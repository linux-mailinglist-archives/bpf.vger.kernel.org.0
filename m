Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E107D567B1C
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 02:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiGFA0b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 5 Jul 2022 20:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiGFA0b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jul 2022 20:26:31 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC4A1208F
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 17:26:30 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265JLi74027187
        for <bpf@vger.kernel.org>; Tue, 5 Jul 2022 17:26:29 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h4uck1u8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 05 Jul 2022 17:26:29 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 5 Jul 2022 17:26:28 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id A9F779BD2636; Tue,  5 Jul 2022 17:26:17 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <daniel@iogearbox.net>, <kernel-team@fb.com>, <ast@kernel.org>,
        <andrii@kernel.org>, Song Liu <song@kernel.org>,
        <syzbot+2f649ec6d2eea1495a8f@syzkaller.appspotmail.com>,
        <syzbot+87f65c75f4a72db05445@syzkaller.appspotmail.com>
Subject: [PATCH bpf] bpf, x86: fix freeing of not-finalized bpf_prog_pack
Date:   Tue, 5 Jul 2022 17:26:12 -0700
Message-ID: <20220706002612.4013790-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0Z0lOV2nMjxVBxwcu6iZMJ89pYPPTA6T
X-Proofpoint-ORIG-GUID: 0Z0lOV2nMjxVBxwcu6iZMJ89pYPPTA6T
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_20,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot reported a few issues with bpf_prog_pack [1], [2]. These are
triggered when the program passed initial JIT in jit_subprogs(), but
failed final pass of JIT. At this point, bpf_jit_binary_pack_free() is
called before bpf_jit_binary_pack_finalize(), and the whole 2MB page is
freed.

Fix this with a custom bpf_jit_free() for x86_64, which calls
bpf_jit_binary_pack_finalize() if necessary. Also, with custom
bpf_jit_free(), bpf_prog_aux->use_bpf_prog_pack is not needed any more,
remove it.

Fixes: 1022a5498f6f ("bpf, x86_64: Use bpf_jit_binary_pack_alloc")
[1] https://syzkaller.appspot.com/bug?extid=2f649ec6d2eea1495a8f
[2] https://syzkaller.appspot.com/bug?extid=87f65c75f4a72db05445
Reported-by: syzbot+2f649ec6d2eea1495a8f@syzkaller.appspotmail.com
Reported-by: syzbot+87f65c75f4a72db05445@syzkaller.appspotmail.com
Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 25 +++++++++++++++++++++++++
 include/linux/bpf.h         |  1 -
 include/linux/filter.h      |  8 ++++++++
 kernel/bpf/core.c           | 29 ++++++++++++-----------------
 4 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index c98b8c0ed3b8..c3dca4c97e48 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2492,3 +2492,28 @@ void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 		return ERR_PTR(-EINVAL);
 	return dst;
 }
+
+void bpf_jit_free(struct bpf_prog *prog)
+{
+	if (prog->jited) {
+		struct x64_jit_data *jit_data = prog->aux->jit_data;
+		struct bpf_binary_header *hdr;
+
+		/*
+		 * If we fail the final pass of JIT (from jit_subprogs),
+		 * the program may not be finalized yet. Call finalize here
+		 * before freeing it.
+		 */
+		if (jit_data) {
+			bpf_jit_binary_pack_finalize(prog, jit_data->header,
+						     jit_data->rw_header);
+			kvfree(jit_data->addrs);
+			kfree(jit_data);
+		}
+		hdr = bpf_jit_binary_pack_hdr(prog);
+		bpf_jit_binary_pack_free(hdr, NULL);
+		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
+	}
+
+	bpf_prog_unlock_free(prog);
+}
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2b914a56a2c5..7424cf234ae0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1025,7 +1025,6 @@ struct bpf_prog_aux {
 	bool sleepable;
 	bool tail_call_reachable;
 	bool xdp_has_frags;
-	bool use_bpf_prog_pack;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
 	/* function name for valid attach_btf_id */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index ed0c0ff42ad5..5005bf2d30bd 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1060,6 +1060,14 @@ u64 bpf_jit_alloc_exec_limit(void);
 void *bpf_jit_alloc_exec(unsigned long size);
 void bpf_jit_free_exec(void *addr);
 void bpf_jit_free(struct bpf_prog *fp);
+struct bpf_binary_header *
+bpf_jit_binary_pack_hdr(const struct bpf_prog *fp);
+
+static inline bool bpf_prog_kallsyms_verify_off(const struct bpf_prog *fp)
+{
+	return list_empty(&fp->aux->ksym.lnode) ||
+	       fp->aux->ksym.lnode.prev == LIST_POISON2;
+}
 
 struct bpf_binary_header *
 bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **ro_image,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5f6f3f829b36..360ceb817639 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -647,12 +647,6 @@ static bool bpf_prog_kallsyms_candidate(const struct bpf_prog *fp)
 	return fp->jited && !bpf_prog_was_classic(fp);
 }
 
-static bool bpf_prog_kallsyms_verify_off(const struct bpf_prog *fp)
-{
-	return list_empty(&fp->aux->ksym.lnode) ||
-	       fp->aux->ksym.lnode.prev == LIST_POISON2;
-}
-
 void bpf_prog_kallsyms_add(struct bpf_prog *fp)
 {
 	if (!bpf_prog_kallsyms_candidate(fp) ||
@@ -1150,7 +1144,6 @@ int bpf_jit_binary_pack_finalize(struct bpf_prog *prog,
 		bpf_prog_pack_free(ro_header);
 		return PTR_ERR(ptr);
 	}
-	prog->aux->use_bpf_prog_pack = true;
 	return 0;
 }
 
@@ -1174,17 +1167,23 @@ void bpf_jit_binary_pack_free(struct bpf_binary_header *ro_header,
 	bpf_jit_uncharge_modmem(size);
 }
 
+struct bpf_binary_header *
+bpf_jit_binary_pack_hdr(const struct bpf_prog *fp)
+{
+	unsigned long real_start = (unsigned long)fp->bpf_func;
+	unsigned long addr;
+
+	addr = real_start & BPF_PROG_CHUNK_MASK;
+	return (void *)addr;
+}
+
 static inline struct bpf_binary_header *
 bpf_jit_binary_hdr(const struct bpf_prog *fp)
 {
 	unsigned long real_start = (unsigned long)fp->bpf_func;
 	unsigned long addr;
 
-	if (fp->aux->use_bpf_prog_pack)
-		addr = real_start & BPF_PROG_CHUNK_MASK;
-	else
-		addr = real_start & PAGE_MASK;
-
+	addr = real_start & PAGE_MASK;
 	return (void *)addr;
 }
 
@@ -1197,11 +1196,7 @@ void __weak bpf_jit_free(struct bpf_prog *fp)
 	if (fp->jited) {
 		struct bpf_binary_header *hdr = bpf_jit_binary_hdr(fp);
 
-		if (fp->aux->use_bpf_prog_pack)
-			bpf_jit_binary_pack_free(hdr, NULL /* rw_buffer */);
-		else
-			bpf_jit_binary_free(hdr);
-
+		bpf_jit_binary_free(hdr);
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
 	}
 
-- 
2.30.2

