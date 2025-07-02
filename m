Return-Path: <bpf+bounces-62067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2E0AF0AC0
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 07:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C304464DE
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6421F1301;
	Wed,  2 Jul 2025 05:33:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096B41C5F06
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 05:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751434427; cv=none; b=Rp0F4vNNpJrwiq3lHOBVtubCzWjqFW39kAeTrHVHF6KRMZOZboDceW58jmFv307wP7bXxQoSoSlYKCtIfLNnbaL6J5RFFpEFDZbD0mO39eco0lO8v90kxb4eGzhkcsDaeYhKjDEqExVByCulSP0YpP2TEvpOBfheEtnOqgJa1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751434427; c=relaxed/simple;
	bh=O2c8jXwLKorov60YmCMBmDLzYGco0Nc2JxSeUbn9/s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nn1H6IUVI+QPB114siWO/oqWdT7HPuE/PIzWMcAz4P2OxMm/0swYbCjKv96Dze2fRnOd8NbkC+W722OF4LNNfxspN+A38iqMQhwWw80wO2S4N0BTuSFwIWqfj7u7lYLXuXEU5uFztDedI3/q0ABUwnzP5y0NGMm3uwn2FmnQYTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 34488AB3204D; Tue,  1 Jul 2025 22:33:37 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH bpf-next 2/2] bpf: Avoid putting struct bpf_scc_callchain variables on the stack
Date: Tue,  1 Jul 2025 22:33:37 -0700
Message-ID: <20250702053337.1991752-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702053332.1991516-1-yonghong.song@linux.dev>
References: <20250702053332.1991516-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a 'struct bpf_scc_callchain callchain' field in bpf_verifier_env.
This way, the previous bpf_scc_callchain local variables can be
replaced by taking address of env->callchain. This can reduce stack
usage and fix the following error:
    kernel/bpf/verifier.c:19921:12: error: stack frame size (1368) exceed=
s limit (1280) in 'do_check'
        [-Werror,-Wframe-larger-than]

Reported-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 36 ++++++++++++++++++------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7e459e839f8b..e2c175d608bb 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -841,6 +841,7 @@ struct bpf_verifier_env {
 	char tmp_str_buf[TMP_STR_BUF_LEN];
 	struct bpf_insn insn_buf[INSN_BUF_SIZE];
 	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
+	struct bpf_scc_callchain callchain;
 	/* array of pointers to bpf_scc_info indexed by SCC id */
 	struct bpf_scc_info **scc_info;
 	u32 scc_cnt;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 29faef51065d..b334e6434eb4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1913,19 +1913,19 @@ static char *format_callchain(struct bpf_verifier=
_env *env, struct bpf_scc_callc
  */
 static int maybe_enter_scc(struct bpf_verifier_env *env, struct bpf_veri=
fier_state *st)
 {
-	struct bpf_scc_callchain callchain;
+	struct bpf_scc_callchain *callchain =3D &env->callchain;
 	struct bpf_scc_visit *visit;
=20
-	if (!compute_scc_callchain(env, st, &callchain))
+	if (!compute_scc_callchain(env, st, callchain))
 		return 0;
-	visit =3D scc_visit_lookup(env, &callchain);
-	visit =3D visit ?: scc_visit_alloc(env, &callchain);
+	visit =3D scc_visit_lookup(env, callchain);
+	visit =3D visit ?: scc_visit_alloc(env, callchain);
 	if (!visit)
 		return -ENOMEM;
 	if (!visit->entry_state) {
 		visit->entry_state =3D st;
 		if (env->log.level & BPF_LOG_LEVEL2)
-			verbose(env, "SCC enter %s\n", format_callchain(env, &callchain));
+			verbose(env, "SCC enter %s\n", format_callchain(env, callchain));
 	}
 	return 0;
 }
@@ -1938,21 +1938,21 @@ static int propagate_backedges(struct bpf_verifie=
r_env *env, struct bpf_scc_visi
  */
 static int maybe_exit_scc(struct bpf_verifier_env *env, struct bpf_verif=
ier_state *st)
 {
-	struct bpf_scc_callchain callchain;
+	struct bpf_scc_callchain *callchain =3D &env->callchain;
 	struct bpf_scc_visit *visit;
=20
-	if (!compute_scc_callchain(env, st, &callchain))
+	if (!compute_scc_callchain(env, st, callchain))
 		return 0;
-	visit =3D scc_visit_lookup(env, &callchain);
+	visit =3D scc_visit_lookup(env, callchain);
 	if (!visit) {
 		verifier_bug(env, "scc exit: no visit info for call chain %s",
-			     format_callchain(env, &callchain));
+			     format_callchain(env, callchain));
 		return -EFAULT;
 	}
 	if (visit->entry_state !=3D st)
 		return 0;
 	if (env->log.level & BPF_LOG_LEVEL2)
-		verbose(env, "SCC exit %s\n", format_callchain(env, &callchain));
+		verbose(env, "SCC exit %s\n", format_callchain(env, callchain));
 	visit->entry_state =3D NULL;
 	env->num_backedges -=3D visit->num_backedges;
 	visit->num_backedges =3D 0;
@@ -1967,22 +1967,22 @@ static int add_scc_backedge(struct bpf_verifier_e=
nv *env,
 			    struct bpf_verifier_state *st,
 			    struct bpf_scc_backedge *backedge)
 {
-	struct bpf_scc_callchain callchain;
+	struct bpf_scc_callchain *callchain =3D &env->callchain;
 	struct bpf_scc_visit *visit;
=20
-	if (!compute_scc_callchain(env, st, &callchain)) {
+	if (!compute_scc_callchain(env, st, callchain)) {
 		verifier_bug(env, "add backedge: no SCC in verification path, insn_idx=
 %d",
 			     st->insn_idx);
 		return -EFAULT;
 	}
-	visit =3D scc_visit_lookup(env, &callchain);
+	visit =3D scc_visit_lookup(env, callchain);
 	if (!visit) {
 		verifier_bug(env, "add backedge: no visit info for call chain %s",
-			     format_callchain(env, &callchain));
+			     format_callchain(env, callchain));
 		return -EFAULT;
 	}
 	if (env->log.level & BPF_LOG_LEVEL2)
-		verbose(env, "SCC backedge %s\n", format_callchain(env, &callchain));
+		verbose(env, "SCC backedge %s\n", format_callchain(env, callchain));
 	backedge->next =3D visit->backedges;
 	visit->backedges =3D backedge;
 	visit->num_backedges++;
@@ -1998,12 +1998,12 @@ static int add_scc_backedge(struct bpf_verifier_e=
nv *env,
 static bool incomplete_read_marks(struct bpf_verifier_env *env,
 				  struct bpf_verifier_state *st)
 {
-	struct bpf_scc_callchain callchain;
+	struct bpf_scc_callchain *callchain =3D &env->callchain;
 	struct bpf_scc_visit *visit;
=20
-	if (!compute_scc_callchain(env, st, &callchain))
+	if (!compute_scc_callchain(env, st, callchain))
 		return false;
-	visit =3D scc_visit_lookup(env, &callchain);
+	visit =3D scc_visit_lookup(env, callchain);
 	if (!visit)
 		return false;
 	return !!visit->backedges;
--=20
2.47.1


