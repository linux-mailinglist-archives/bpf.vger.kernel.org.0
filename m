Return-Path: <bpf+bounces-23127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 565EE86DC8F
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 08:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AADA1C22B99
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 07:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971C669D1A;
	Fri,  1 Mar 2024 07:57:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C0A6996A;
	Fri,  1 Mar 2024 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279875; cv=none; b=WMdGNlrXeIe4OXdh5FyoO5UAPKoGUwOPLV9QngY6cYOQwabbhd0ACfreFrV7yHd+ZarbwSMzGqmBM5a1+eQNWRTSWtYAvnWa8/yuw6okXajUpfEcaiJYwqE2xNySs1N1esJ9Y+EivHQFvCkWqFusNIDO3bmCh5nHjErvfGmD1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279875; c=relaxed/simple;
	bh=1HnXrNCczlojfDwK0Lj32V+7Nhy5BOZgDCKbCA6NdwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0LR3IlOC/Dw7j4jFOzMvoz1DbcM66VM2V3hwppwY1GR1s3WHgQqOxLnrDeOffHB5DEGTeYOdgkdB2khSZN5v28zd/3gmiqIhnl07P0dNktj5l/L5v5XpQCFmMgHDe6v2r+DsDAyOovmYCAZXn+PSaoY3Dim7M7SM2+CmXCpbfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4TmL6k6bZ5z9v8R;
	Fri,  1 Mar 2024 08:57:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d5WQLkBCU8dg; Fri,  1 Mar 2024 08:57:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4TmL6c6G14z9v7S;
	Fri,  1 Mar 2024 08:57:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C8BCB8B774;
	Fri,  1 Mar 2024 08:57:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 9JRALyKYH8lu; Fri,  1 Mar 2024 08:57:44 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.117])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AD2718B766;
	Fri,  1 Mar 2024 08:57:42 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Wang YanQing <udknight@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
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
Subject: [PATCH bpf-next RESEND v2 1/2] bpf: Take return from set_memory_ro() into account with bpf_prog_lock_ro()
Date: Fri,  1 Mar 2024 08:57:23 +0100
Message-ID: <8f3b3823cce2177e5912ff5f2f11381a16db07db.1709279661.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709279844; l=2767; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=1HnXrNCczlojfDwK0Lj32V+7Nhy5BOZgDCKbCA6NdwM=; b=dSZBTT9qth3ODdOJv+HPXE6vZVAWv23et0yw75PIiB3gdOiY3UXnigDyUvxewEonfvli9lvIo +Qux59pCUBvDQzFTq83UHZHd0c0SdTUdPTiHh7L0OSrlNqTbBKzEz8V
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

set_memory_ro() can fail, leaving memory unprotected.

Check its return and take it into account as an error.

Link: https://github.com/KSPP/linux/issues/7
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-hardening@vger.kernel.org <linux-hardening@vger.kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
Sorry for the resend, I forgot to flag patch 2 as bpf-next

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


