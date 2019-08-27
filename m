Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 218E99EB93
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2019 16:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfH0OxL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Aug 2019 10:53:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24725 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfH0OxL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Aug 2019 10:53:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D65FB369CC;
        Tue, 27 Aug 2019 14:53:10 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-102.ams2.redhat.com [10.36.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CC4D5C1D6;
        Tue, 27 Aug 2019 14:53:09 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, iii@linux.ibm.com, jolsa@redhat.com
Subject: [PATCH v2] bpf: s390: add JIT support for multi-function programs
Date:   Tue, 27 Aug 2019 17:53:07 +0300
Message-Id: <20190827145307.7984-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20190826182036.17456-1-yauheni.kaliuta@redhat.com>
References: <20190826182036.17456-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 27 Aug 2019 14:53:10 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds support for bpf-to-bpf function calls in the s390 JIT
compiler. The JIT compiler converts the bpf call instructions to
native branch instructions. After a round of the usual passes, the
start addresses of the JITed images for the callee functions are
known. Finally, to fixup the branch target addresses, we need to
perform an extra pass.

Because of the address range in which JITed images are allocated on
s390, the offsets of the start addresses of these images from
__bpf_call_base are as large as 64 bits. So, for a function call,
the imm field of the instruction cannot be used to determine the
callee's address. Use bpf_jit_get_func_addr() helper instead.

The patch borrows a lot from:

8c11ea5ce13d bpf, arm64: fix getting subprog addr from aux for calls
e2c95a61656d bpf, ppc64: generalize fetching subprog into bpf_jit_get_func_addr
8484ce8306f9 bpf: powerpc64: add JIT support for multi-function programs

(including the commit message).

test_verifier (5.3-rc6 with CONFIG_BPF_JIT_ALWAYS_ON=y):

without patch:
Summary: 1501 PASSED, 0 SKIPPED, 47 FAILED

with patch:
Summary: 1540 PASSED, 0 SKIPPED, 8 FAILED

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---

V1->V2:

- mention CONFIG_BPF_JIT_ALWAYS_ON=y in the commit message;
- in case of bpf_jit_get_func_addr() error return -1 to be consistent
  with the bpf_jit_insn() default branch return value.

---
 arch/s390/net/bpf_jit_comp.c | 63 +++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 11 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index e636728ab452..55fce1d7dca1 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -502,7 +502,8 @@ static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
  * NOTE: Use noinline because for gcov (-fprofile-arcs) gcc allocates a lot of
  * stack space for the large switch statement.
  */
-static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i)
+static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
+				 int i, bool extra_pass)
 {
 	struct bpf_insn *insn = &fp->insnsi[i];
 	int jmp_off, last, insn_count = 1;
@@ -1011,10 +1012,14 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 	 */
 	case BPF_JMP | BPF_CALL:
 	{
-		/*
-		 * b0 = (__bpf_call_base + imm)(b1, b2, b3, b4, b5)
-		 */
-		const u64 func = (u64)__bpf_call_base + imm;
+		u64 func;
+		bool func_addr_fixed;
+		int ret;
+
+		ret = bpf_jit_get_func_addr(fp, insn, extra_pass,
+					    &func, &func_addr_fixed);
+		if (ret < 0)
+			return -1;
 
 		REG_SET_SEEN(BPF_REG_5);
 		jit->seen |= SEEN_FUNC;
@@ -1281,7 +1286,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 /*
  * Compile eBPF program into s390x code
  */
-static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp)
+static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp, bool extra_pass)
 {
 	int i, insn_count;
 
@@ -1290,7 +1295,7 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp)
 
 	bpf_jit_prologue(jit, fp->aux->stack_depth);
 	for (i = 0; i < fp->len; i += insn_count) {
-		insn_count = bpf_jit_insn(jit, fp, i);
+		insn_count = bpf_jit_insn(jit, fp, i, extra_pass);
 		if (insn_count < 0)
 			return -1;
 		/* Next instruction address */
@@ -1309,6 +1314,12 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
+
+struct s390_jit_data {
+	struct bpf_binary_header *header;
+	struct bpf_jit ctx;
+};
+
 /*
  * Compile eBPF program "fp"
  */
@@ -1316,7 +1327,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 {
 	struct bpf_prog *tmp, *orig_fp = fp;
 	struct bpf_binary_header *header;
+	struct s390_jit_data *jit_data;
 	bool tmp_blinded = false;
+	bool extra_pass = false;
 	struct bpf_jit jit;
 	int pass;
 
@@ -1335,6 +1348,22 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		fp = tmp;
 	}
 
+	jit_data = fp->aux->jit_data;
+	if (!jit_data) {
+		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
+		if (!jit_data) {
+			fp = orig_fp;
+			goto out;
+		}
+		fp->aux->jit_data = jit_data;
+	}
+	if (jit_data->ctx.addrs) {
+		jit = jit_data->ctx;
+		header = jit_data->header;
+		extra_pass = true;
+		goto skip_init_ctx;
+	}
+
 	memset(&jit, 0, sizeof(jit));
 	jit.addrs = kcalloc(fp->len + 1, sizeof(*jit.addrs), GFP_KERNEL);
 	if (jit.addrs == NULL) {
@@ -1347,7 +1376,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	 *   - 3:   Calculate program size and addrs arrray
 	 */
 	for (pass = 1; pass <= 3; pass++) {
-		if (bpf_jit_prog(&jit, fp)) {
+		if (bpf_jit_prog(&jit, fp, extra_pass)) {
 			fp = orig_fp;
 			goto free_addrs;
 		}
@@ -1359,12 +1388,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		fp = orig_fp;
 		goto free_addrs;
 	}
+
 	header = bpf_jit_binary_alloc(jit.size, &jit.prg_buf, 2, jit_fill_hole);
 	if (!header) {
 		fp = orig_fp;
 		goto free_addrs;
 	}
-	if (bpf_jit_prog(&jit, fp)) {
+skip_init_ctx:
+	if (bpf_jit_prog(&jit, fp, extra_pass)) {
 		bpf_jit_binary_free(header);
 		fp = orig_fp;
 		goto free_addrs;
@@ -1373,12 +1404,22 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		bpf_jit_dump(fp->len, jit.size, pass, jit.prg_buf);
 		print_fn_code(jit.prg_buf, jit.size_prg);
 	}
-	bpf_jit_binary_lock_ro(header);
+	if (!fp->is_func || extra_pass) {
+		bpf_jit_binary_lock_ro(header);
+	} else {
+		jit_data->header = header;
+		jit_data->ctx = jit;
+	}
 	fp->bpf_func = (void *) jit.prg_buf;
 	fp->jited = 1;
 	fp->jited_len = jit.size;
+
+	if (!fp->is_func || extra_pass) {
 free_addrs:
-	kfree(jit.addrs);
+		kfree(jit.addrs);
+		kfree(jit_data);
+		fp->aux->jit_data = NULL;
+	}
 out:
 	if (tmp_blinded)
 		bpf_jit_prog_release_other(fp, fp == orig_fp ?
-- 
2.22.0

