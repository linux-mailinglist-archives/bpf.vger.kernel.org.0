Return-Path: <bpf+bounces-22226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2150B85967C
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 11:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA291C20A24
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 10:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5984F1E4;
	Sun, 18 Feb 2024 10:55:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A314D11D;
	Sun, 18 Feb 2024 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253723; cv=none; b=jyif8oQLUwKe2mM+rUY16tlE3y5PXcoxT5vz6SDPzRbhGDzRiLtpbfeHCYyGmmNh86mI+DtsWz/Z7E7PqCsWyAUWRw3ecDyKi3Cfofbx7g2kalPdrlQyG65/JeACAAdodLyrF2GjGrPQRiOGl6DkjaVKtlL34D60g0sn2wze6K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253723; c=relaxed/simple;
	bh=EbBTO80WkRv7m3C0/eIYgeu1ZNHlQh49ZLc+XBBYCWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZGas89Dslzg7Np51it3DqvypFnoGtEcoKGB7CiEYBzYKlJN1q9pcN8Zvmxuq/eiLJhwjx6t/S5AwVNV13w4T6PJ7ChdXTRoD10TXCN5FxdsQZRSL+txvWG5tntrze2kMCom+vRfAOmX+E9coLQrmd7RefIDX7/ZBuDFqWHnja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Td2cx1hvmz9v4J;
	Sun, 18 Feb 2024 11:55:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oNLdMsMYWM-I; Sun, 18 Feb 2024 11:55:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Td2cx0nzTz9v4H;
	Sun, 18 Feb 2024 11:55:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 133EC8B76C;
	Sun, 18 Feb 2024 11:55:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id rSFuxJHSf4wJ; Sun, 18 Feb 2024 11:55:12 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.5])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F9778B763;
	Sun, 18 Feb 2024 11:55:12 +0100 (CET)
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
	Jiri Olsa <jolsa@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Take return from set_memory_ro() into account with bpf_prog_lock_ro()
Date: Sun, 18 Feb 2024 11:55:01 +0100
Message-ID: <135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708253703; l=2087; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=EbBTO80WkRv7m3C0/eIYgeu1ZNHlQh49ZLc+XBBYCWQ=; b=F8NxWRnHg/MwjNEFQ6M9LOolCSgQxtP3c3JmOchmjBXK4w3gNTQyvbbU8Dfk5LMKUUuWJdiXO gQxH9ILOKV4BiYc52c44ZK+GDQsbGG8QeTRKNZ0eeQFcfNep8r/rx1n
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

set_memory_ro() can fail, leaving memory unprotected.

Check its return and take it into account as an error.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/filter.h | 5 +++--
 kernel/bpf/core.c      | 4 +++-
 kernel/bpf/verifier.c  | 4 +++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index fee070b9826e..fc0994dc5c72 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -881,14 +881,15 @@ bpf_ctx_narrow_access_offset(u32 off, u32 size, u32 size_default)
 
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
index c5d68a9d8acc..1f831a6b4bbc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19020,7 +19020,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
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


