Return-Path: <bpf+bounces-23125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1A286DC6F
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 08:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE461C228C0
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 07:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C0D69D05;
	Fri,  1 Mar 2024 07:52:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71FB224C9;
	Fri,  1 Mar 2024 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279566; cv=none; b=bJwHCuev+pQvlQrDcEwxBfa+kffHUk30mS5x509q077C2EtAC7f54ylmQgctTRrnX+tIVyLjDA1hHTsvrzEv6lbN09dli2FzoSOmpiT5ADjyWwdTvT1RV5WYBUnnxDPmcZ8LiveL5DQypMk/9cp657TaT+Bahq8f6hGW6TQUV7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279566; c=relaxed/simple;
	bh=m9JyN+OfZnBfNduvWL6HlRt2Ws8qdQM+zYhc2tHrO60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TjLu8oj5/wja4dRS73eiuFFpI+WQoMqhXJ6PheR2+C0e24fljpIfsfbhoZp9yQyqQKQGIrBKsrj+/R7SjJQaG6qHYn2YQTfeHOE8+Zyzl3276TLY2GIxxjVWDOCzm9gpnH4htaVsvGpE+J3rN5ck6+oWA41EbkUfgyheC5SOD/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4TmL0g4qB7z9tHZ;
	Fri,  1 Mar 2024 08:52:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BqoZa5JD5ZwP; Fri,  1 Mar 2024 08:52:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4TmL0f46Qcz9tFS;
	Fri,  1 Mar 2024 08:52:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 857FB8B774;
	Fri,  1 Mar 2024 08:52:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id X5jlVshACLyB; Fri,  1 Mar 2024 08:52:34 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.117])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6FC788B766;
	Fri,  1 Mar 2024 08:52:33 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	netdev@vger.kernel.org,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH bpf-next v2 1/2] bpf: Take return from set_memory_ro() into account with bpf_prog_lock_ro()
Date: Fri,  1 Mar 2024 08:52:24 +0100
Message-ID: <8f3b3823cce2177e5912ff5f2f11381a16db07db.1709279160.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709279548; l=2705; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=m9JyN+OfZnBfNduvWL6HlRt2Ws8qdQM+zYhc2tHrO60=; b=BM8D7LKNIqd4yL3OmV1oY3lqs5bdcfaokGX528YFWG10bGRYTPO7xmnY3X/YTK0+TrgdD1oe0 Jcv1743O7HSBXVnLAvfrfkWf80mkc3ESZY06KRQSThm9AifGg/N13eN
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

set_memory_ro() can fail, leaving memory unprotected.

Check its return and take it into account as an error.

Link: https://github.com/KSPP/linux/issues/7
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-hardening@vger.kernel.org <linux-hardening@vger.kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
Note: next patch is autonomous, it is sent as a follow-up of this one to minimize risk of conflict on filter.h because the two changes are too close to each other.

v2: No modification (Just added link in patch message), patchwork discarded this series due to failed test of s390 but it seems unrelated, see https://lore.kernel.org/bpf/wvd5gzde5ejc2rzsbrtwqyof56uw5ea3rxntfrxtkdabzcuwt6@w7iczzhmay2i/T/#m2e61446f42d5dc3d78f2e0e8b7a783f15cfb109d
---
 include/linux/filter.h | 5 +++--
 kernel/bpf/core.c      | 4 +++-
 kernel/bpf/verifier.c  | 4 +++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 36cc29a2934c..7dd59bccaeec 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -884,14 +884,15 @@ bpf_ctx_narrow_access_offset(u32 off, u32 size, u32 size_default)
 
 #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]))
 
-static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
+static inline int __must_check bpf_prog_lock_ro(struct bpf_prog *fp)
 {
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	if (!fp->jited) {
 		set_vm_flush_reset_perms(fp);
-		set_memory_ro((unsigned long)fp, fp->pages);
+		return set_memory_ro((unsigned long)fp, fp->pages);
 	}
 #endif
+	return 0;
 }
 
 static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 71c459a51d9e..c49619ef55d0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2392,7 +2392,9 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 	}
 
 finalize:
-	bpf_prog_lock_ro(fp);
+	*err = bpf_prog_lock_ro(fp);
+	if (*err)
+		return fp;
 
 	/* The tail call compatibility check can only be done at
 	 * this late stage as we need to determine, if we deal
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c34b91b9583..6ec134f76a11 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19096,7 +19096,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	 * bpf_prog_load will add the kallsyms for the main program.
 	 */
 	for (i = 1; i < env->subprog_cnt; i++) {
-		bpf_prog_lock_ro(func[i]);
+		err = bpf_prog_lock_ro(func[i]);
+		if (err)
+			goto out_free;
 		bpf_prog_kallsyms_add(func[i]);
 	}
 
-- 
2.43.0


