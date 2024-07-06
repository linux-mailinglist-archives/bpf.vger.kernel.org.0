Return-Path: <bpf+bounces-33981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F9A92903D
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 05:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B821C21319
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 03:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADEAFC18;
	Sat,  6 Jul 2024 03:13:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8FD2EE;
	Sat,  6 Jul 2024 03:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720235592; cv=none; b=uGpPW0fFU+ImDS0oe8g3eerubGO/96GskxyC92+GX7GJFRoUxo0vveH9Yjz4bLJzTrh+PFstI5Vh8/wG93a9W+yc7g6qqO1mGXZgwX/kVpd0FFiIIJScUb2F3DbgyPLsmbkp0ren4KJPsN5RJMksIazXhzM8BkuYJZSXdCR3w/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720235592; c=relaxed/simple;
	bh=MyjTGk6VuWMYFBl8e5jB9YOcHh8boZQO8NlWjQrIp6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=puY+nOED9A92+tO3Ux/wQ1mmjILvb1hCPRqSqkGoIgIk8D96oPiG5pH+3LxlJMM4NtF0t199tksgbYUaV+DRnSUlYHpFqLL3xcJwrl9QPd/cpzF/yfBaDJ1uqVJkZ9fneQMA2A9Jc4Pz9RQaDVRSCUdpPFRtwgifgIj4Cl2XEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpip1t1720235489tei2m50
X-QQ-Originating-IP: T9voozigEMbvKQqLmyXHyvJvu/Sgt2Ax2xFLqZOUFw0=
Received: from avenger-OMEN-by-HP-Gaming-Lapto ( [255.251.210.2])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 06 Jul 2024 11:11:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1222939419050242368
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: ast@kernel.org,
	keescook@chromium.org,
	linux-hardening@vger.kernel.org,
	christophe.leroy@csgroup.eu,
	catalin.marinas@arm.com,
	song@kernel.org,
	puranjay12@gmail.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	illusionist.neo@gmail.com,
	linux@armlinux.org.uk,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev,
	johan.almbladh@anyfinetworks.com,
	paulburton@kernel.org,
	tsbogend@alpha.franken.de,
	linux-mips@vger.kernel.org,
	deller@gmx.de,
	linux-parisc@vger.kernel.org,
	iii@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	davem@davemloft.net,
	sparclinux@vger.kernel.org,
	kuba@kernel.org,
	hawk@kernel.org,
	netdev@vger.kernel.org,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	guanwentao@uniontech.com,
	baimingcong@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] Revert "bpf: Take return from set_memory_rox() into account with bpf_jit_binary_lock_ro()" for linux-6.6.37
Date: Sat,  6 Jul 2024 11:11:01 +0800
Message-ID: <5A29E00D83AB84E3+20240706031101.637601-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

This reverts commit 08f6c05feb1db21653e98ca84ea04ca032d014c7.

Upstream commit e60adf513275 ("bpf: Take return from set_memory_rox() into account with bpf_jit_binary_lock_ro()")
depends on
upstream commit 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management").

It will cause a compilation warning on the arm64 if it's not merged:
  arch/arm64/net/bpf_jit_comp.c: In function ‘bpf_int_jit_compile’:
  arch/arm64/net/bpf_jit_comp.c:1651:17: warning: ignoring return value of ‘bpf_jit_binary_lock_ro’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
   1651 |                 bpf_jit_binary_lock_ro(header);
        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This will prevent the kernel with the '-Werror' compile option from
being compiled successfully.

We might as well revert this commit in linux-6.6.37 to solve the
problem in a simple way.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/arm/net/bpf_jit_32.c        | 25 +++++++++++++------------
 arch/loongarch/net/bpf_jit.c     | 22 ++++++----------------
 arch/mips/net/bpf_jit_comp.c     |  3 +--
 arch/parisc/net/bpf_jit_core.c   |  8 +-------
 arch/s390/net/bpf_jit_comp.c     |  6 +-----
 arch/sparc/net/bpf_jit_comp_64.c |  6 +-----
 arch/x86/net/bpf_jit_comp32.c    |  3 ++-
 include/linux/filter.h           |  5 ++---
 8 files changed, 27 insertions(+), 51 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index ac8e4d9bf954..6a1c9fca5260 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1982,21 +1982,28 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	/* If building the body of the JITed code fails somehow,
 	 * we fall back to the interpretation.
 	 */
-	if (build_body(&ctx) < 0)
-		goto out_free;
+	if (build_body(&ctx) < 0) {
+		image_ptr = NULL;
+		bpf_jit_binary_free(header);
+		prog = orig_prog;
+		goto out_imms;
+	}
 	build_epilogue(&ctx);
 
 	/* 3.) Extra pass to validate JITed Code */
-	if (validate_code(&ctx))
-		goto out_free;
+	if (validate_code(&ctx)) {
+		image_ptr = NULL;
+		bpf_jit_binary_free(header);
+		prog = orig_prog;
+		goto out_imms;
+	}
 	flush_icache_range((u32)header, (u32)(ctx.target + ctx.idx));
 
 	if (bpf_jit_enable > 1)
 		/* there are 2 passes here */
 		bpf_jit_dump(prog->len, image_size, 2, ctx.target);
 
-	if (bpf_jit_binary_lock_ro(header))
-		goto out_free;
+	bpf_jit_binary_lock_ro(header);
 	prog->bpf_func = (void *)ctx.target;
 	prog->jited = 1;
 	prog->jited_len = image_size;
@@ -2013,11 +2020,5 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		bpf_jit_prog_release_other(prog, prog == orig_prog ?
 					   tmp : orig_prog);
 	return prog;
-
-out_free:
-	image_ptr = NULL;
-	bpf_jit_binary_free(header);
-	prog = orig_prog;
-	goto out_imms;
 }
 
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 13cd480385ca..9eb7753d117d 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1206,19 +1206,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	flush_icache_range((unsigned long)header, (unsigned long)(ctx.image + ctx.idx));
 
 	if (!prog->is_func || extra_pass) {
-		int err;
-
 		if (extra_pass && ctx.idx != jit_data->ctx.idx) {
 			pr_err_once("multi-func JIT bug %d != %d\n",
 				    ctx.idx, jit_data->ctx.idx);
-			goto out_free;
-		}
-		err = bpf_jit_binary_lock_ro(header);
-		if (err) {
-			pr_err_once("bpf_jit_binary_lock_ro() returned %d\n",
-				    err);
-			goto out_free;
+			bpf_jit_binary_free(header);
+			prog->bpf_func = NULL;
+			prog->jited = 0;
+			prog->jited_len = 0;
+			goto out_offset;
 		}
+		bpf_jit_binary_lock_ro(header);
 	} else {
 		jit_data->ctx = ctx;
 		jit_data->image = image_ptr;
@@ -1249,13 +1246,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	out_offset = -1;
 
 	return prog;
-
-out_free:
-	bpf_jit_binary_free(header);
-	prog->bpf_func = NULL;
-	prog->jited = 0;
-	prog->jited_len = 0;
-	goto out_offset;
 }
 
 /* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index e355dfca4400..a40d926b6513 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -1012,8 +1012,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bpf_prog_fill_jited_linfo(prog, &ctx.descriptors[1]);
 
 	/* Set as read-only exec and flush instruction cache */
-	if (bpf_jit_binary_lock_ro(header))
-		goto out_err;
+	bpf_jit_binary_lock_ro(header);
 	flush_icache_range((unsigned long)header,
 			   (unsigned long)&ctx.target[ctx.jit_index]);
 
diff --git a/arch/parisc/net/bpf_jit_core.c b/arch/parisc/net/bpf_jit_core.c
index 979f45d4d1fb..d6ee2fd45550 100644
--- a/arch/parisc/net/bpf_jit_core.c
+++ b/arch/parisc/net/bpf_jit_core.c
@@ -167,13 +167,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bpf_flush_icache(jit_data->header, ctx->insns + ctx->ninsns);
 
 	if (!prog->is_func || extra_pass) {
-		if (bpf_jit_binary_lock_ro(jit_data->header)) {
-			bpf_jit_binary_free(jit_data->header);
-			prog->bpf_func = NULL;
-			prog->jited = 0;
-			prog->jited_len = 0;
-			goto out_offset;
-		}
+		bpf_jit_binary_lock_ro(jit_data->header);
 		prologue_len = ctx->epilogue_offset - ctx->body_len;
 		for (i = 0; i < prog->len; i++)
 			ctx->offset[i] += prologue_len;
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 05746e22fe79..62ee557d4b49 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1973,11 +1973,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		print_fn_code(jit.prg_buf, jit.size_prg);
 	}
 	if (!fp->is_func || extra_pass) {
-		if (bpf_jit_binary_lock_ro(header)) {
-			bpf_jit_binary_free(header);
-			fp = orig_fp;
-			goto free_addrs;
-		}
+		bpf_jit_binary_lock_ro(header);
 	} else {
 		jit_data->header = header;
 		jit_data->ctx = jit;
diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 73bf0aea8baf..fa0759bfe498 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1602,11 +1602,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bpf_flush_icache(header, (u8 *)header + header->size);
 
 	if (!prog->is_func || extra_pass) {
-		if (bpf_jit_binary_lock_ro(header)) {
-			bpf_jit_binary_free(header);
-			prog = orig_prog;
-			goto out_off;
-		}
+		bpf_jit_binary_lock_ro(header);
 	} else {
 		jit_data->ctx = ctx;
 		jit_data->image = image_ptr;
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index f2fc8c38629b..429a89c5468b 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2600,7 +2600,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	if (bpf_jit_enable > 1)
 		bpf_jit_dump(prog->len, proglen, pass + 1, image);
 
-	if (image && !bpf_jit_binary_lock_ro(header)) {
+	if (image) {
+		bpf_jit_binary_lock_ro(header);
 		prog->bpf_func = (void *)image;
 		prog->jited = 1;
 		prog->jited_len = proglen;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index a74d97114a54..5a2800ec94ea 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -853,11 +853,10 @@ static inline int __must_check bpf_prog_lock_ro(struct bpf_prog *fp)
 	return 0;
 }
 
-static inline int __must_check
-bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
+static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
 {
 	set_vm_flush_reset_perms(hdr);
-	return set_memory_rox((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
+	set_memory_rox((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
 }
 
 int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap);
-- 
2.43.0


