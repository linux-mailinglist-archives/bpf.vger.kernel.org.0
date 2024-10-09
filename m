Return-Path: <bpf+bounces-41458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6BF997381
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 19:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019371F23F93
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 17:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BCC1E6DC9;
	Wed,  9 Oct 2024 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tgdV9LkQ"
X-Original-To: bpf@vger.kernel.org
Received: from sonic306-26.consmr.mail.ne1.yahoo.com (sonic306-26.consmr.mail.ne1.yahoo.com [66.163.189.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BF41E47C3
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495763; cv=none; b=ZPlBZOEhACMGC526ro3/Tduf7wiBTTxqY92eeXA54Q5TdXJTmRzUSR2vK9yyCFKiYstySbQNPsnYnD2uFAjgiasDZgBFiJlIYboNbGwfbN6TC3FFytarbdviBt7Wxp5QaR8FndUb4WmNJK42O7tMSFMRTPhkjeOFXjZYREyGyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495763; c=relaxed/simple;
	bh=LokgultzN0WmXDqjvoeWLrKrfvyHfix2qKgCgn/zc7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpTjaA5sJI5fis63RG11BkQcoeBu2NiVIWm+lXeMCVG6RjFa8QPam99SncpZYHvBx2WELc9fF2J/FpS3Tbl+vc9gw/UKPp1d9Hq8io8CNPMa4rNufn7hF+8/T7Ep7OWR8q+mT9k4aJWHrJlAHlNlLVKap8bZnGv/o0oOzTE9v7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tgdV9LkQ; arc=none smtp.client-ip=66.163.189.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495760; bh=JXR+r2zL+pQ9RpZEjgRmXf0fUPaWRk6ese8bB91Ub9E=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tgdV9LkQr5t28gQC92mAnkbXNrjKfBtNNl7hcnqR/nB7BekVLMtFQhKMhhyQxNoK5aR50MH4smDs//LhrBwCJgNnNw+gBpWezouwYaw8kLu3Vocq21ozzWU/XIKCnaZKM9kUYcS6DB7AyirvujNfa4nwthkhX87ML0EgJzj5tX6UQBA4k6AiZg1pyH7S0W2p4AAF7xANqPPO0M+i/6g1qfJ7ibUyws8ATqr8aC2BUyPr4ooruouOjmHxMWM66IccgS+v2KrhlQUrs4NZ/fkp4gS3qZpCoWGwXtl6ae6GLI4+Xt/PQfgnPdX/tFJJxmjZCcfvqvc8QpRFWQ4b5wTSGA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495760; bh=t04rV1D1hwdVcm/Gxled13e/eZBMUKXHZSwtpS1lWg3=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=q6OwhEzZSplsPCzN+XeNNarqZBwZpfSAPzx1gu1LJY5B/urPUsHdGUOTwqBKeQaPWXGx5PusgARDLeq7uvb/TIlowiQd82LvcpSpizVAQ+dX7l4HifqYvmn32OiR73O2IACpYY1xgfeS5aiDN1EiKgQJuURHTrgsWGhMRJ5JiqHzwI9ISYPa5lgKDOivctfALQVBFmvjI2shhHL9AjEjslEotv8FjwG3zoXmb4iXBmeWq4HNaDejka9MFqQ3Z4Sokpvz7/hqcvrUJGjgJzp6io31YRJnGO/rC2pgqeJzDgUglj3vfwwfmDqLQvHuosRGa8zKZRqA+qug3egxyT5CNA==
X-YMail-OSG: eYN4iQYVM1n41XBMq4.EVyKQpeLKlUZwfvxzyt6HP0KYLNvsLFqrAllNtqhLWhP
 Az53i8MIUewh1caEIrf7L3cW5JNuekWer15wHz_XxNYrYRDKv6LauAtIF_u0nkSixHdx5D8cURQA
 5hh0fAvRxNL8TbCDLPRI_Iddt1Z9QqOZX66VIa.oFfWi0JeJ3tAnGlZUjqRgO0TzSnddw5c_32kb
 5okAFGHejWzpCNZczvhCCoHsWVgIL6QgRgKHwwAYIe3S2Ia03gviLfR4z3Ar9rF0rJKj8cR.EoE4
 z091lt3x6i4Ztmx12hPqR3ZbuWTzrulFSYa8JYzpp7a_csBWs1ckkWY8nQEqS4CbAyShEZJFVJcN
 3XqKUdAxbcWNFoHdLfphGzhmJ2NeIsfzAXVtNX_75TMWAUC6ba3gd6pyLdLUfBQeqRcIdFu4EP7D
 atkHhpoSVA6JmNV7ylYloxXRshrQXWzpzO39mF9PaSeaeoo6V_rdwLSJoHjSUaB.ZfILjODq1OT_
 sjb_PBTL7CvY0kNu6PZUjN1pOQCMviesX2c5jg8w22vOcPajT_ro7M0a1ylgikZjYk7uqyqprss3
 3BNBMR4_alJSMLSAgx5E3ikh_AmEZWFSuchm5rjFwtOB4g6.9BVKkMyCXNf0rfZBrR6oPbxywh_K
 EA6YRn7DVEK1CYjKHK9z75i0DeEPx_Oam2X.vOA1XBT22rf5VY0TSEfWkOZN0fheRvzVI.fWRHKS
 jCP6SCoqK6yL.pGomNBhBuTxPj_09pEbyX1YxBFkNEzsjYGjUyH_gGgOETokcoOCAr_3INvG7lgv
 gRdZpd3R9jVUghTNdQ.fNO27k_PHKMFBs0ax69HGEYnfMWyHfkdpM.PsiP19z9fAhTZXx4lpaFNV
 9FSqefI3LOy1QNcX_5sQ273cxoI3x9AfzxNpZQX7uKR.L2a12TJblCQdZaPO9ISwRGJjBhp7jrLo
 sSe4iR7yfHjZuNX1Ln6YhDaMcmmGxPS9GSzv4NTdYUjibNe3lyO9f.A8cx4f1buGEoDWx9EwqdAH
 mTxEH5Kx01BDr7kRy4Ae1m6Rx.pqx.7FqW9hwIECenMynyreE9FcS9J90eI5HAO2xHhx3j0ZF273
 qrjs0YuFlkrJkLWE9P6hwdstyvV2.wmUHCm0WZAeB.lQk0rynhZCOOF8ngHmjWUfzvexnmGVVFBd
 b9xwivIV5qH5RDlY937r3Wm6dU65GZZHk598bdATbvFHuDES5JP44mT3yLw.b2oWgvYMDg2FFNQ.
 GDx_ewp14Vpcwp_Z234mFBhSvgONKwmNyJ_JQaAxSAP6f_kefBExotmBxVQ.cLuY3oLLU8aquRKA
 .4N5U25jpfodel6OIDDReJG2zLNE368qw_Nlail9UqzykIi2kM.SwUwZ0t.tmdtqNe_kWoXIqbHf
 GkX.EZIjwb9SMWLV3.mVu8NNG0M8dpmfdnoDum_YvGgC.kwbFmXYSI4u0ZecfS6aVxqDGq8wLQL3
 GrjmSFxihpTUaskLMGAHY76Q_VoJKBakNXdUYw2HA..kYbAIUWTYYUc4EXvDy6Gg2MwfhNSesysv
 VeE6GgN8BtZwC1eQ86REgIdBEF9_J7hf0Kv_jP7rSh6OWrLbv34RkTpzuCgcQeokqTKF6eDh93Ar
 QDo37uloFRVLQrCEhQI7skpprAkNvOJl.PEe7yRpfCMJYG6wDBfms67vH.PgYtLiNh81.aIA60.P
 WfL3fOYSgtMiczE7T_KrC1C85z_LNIITFoZ7WzP9ax_tKewTkaQ_XzDDxqXEYJbFGVTmeglUibcp
 Y3NY6uFr3w2PvZYzQdnuCnh6fg..t73bbnDIDkH_19pl1dFm5DufaQzrbWYONbyp.1zv8Y0kdNLu
 UfpEYbVjEoVYgsGIQr0IhAyWvaP6ODSE1yBlsoXuqtYsYVvkjdL_3C3ixQKx24gOgAGxngqeOGgF
 NF9uyIn7lGP.sv3.Wjf436njySvKQGqG7tSF2k_Ii3vHs3niRMk8PASnSk5XYRNQ71JlI9kvx51M
 6lt6.SlWJyGO34hYnFKMVhe54ALuu0d8Ma4hQI2o.FcDlOmj6IfG7VikZvx6lthXk9yyeCNnrJ22
 e1ny6yjp0wVf0R1xOBOfNyvIuUOxufO6QN7FN6Reduo9XPNm4R6ErcO2yWJpcO33p7RrUWh8k2f.
 1xLHItAsZAgjvNwVP1yPsvwhGUKVdQ5Tro31487k0ti9YXWkVtL29jpAP44Q0W1FRNp46EZStwz3
 vcq7_wfLFnG1CeWplKAzzh1w_pLOus380Fhz.ifhNBZtn6Dp8ITjYjItxmr8i.GOaeDND_2h5a95
 a0JLGft21Uae74G.1fb.scgoPdSInLNysJ3GP31s-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8ea8d104-f8f6-4f4b-981e-98d68358a75b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Oct 2024 17:42:40 +0000
Received: by hermes--production-gq1-5d95dc458-rvnnh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5fec0e30966313b56a0d7e944fb52df1;
          Wed, 09 Oct 2024 17:32:27 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	mic@digikod.net,
	apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org
Subject: [PATCH v4 01/13] LSM: Add the lsm_prop data structure.
Date: Wed,  9 Oct 2024 10:32:09 -0700
Message-ID: <20241009173222.12219-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241009173222.12219-1-casey@schaufler-ca.com>
References: <20241009173222.12219-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When more than one security module is exporting data to audit and
networking sub-systems a single 32 bit integer is no longer
sufficient to represent the data. Add a structure to be used instead.

The lsm_prop structure definition is intended to keep the LSM
specific information private to the individual security modules.
The module specific information is included in a new set of
header files under include/lsm. Each security module is allowed
to define the information included for its use in the lsm_prop.
SELinux includes a u32 secid. Smack includes a pointer into its
global label list. The conditional compilation based on feature
inclusion is contained in the include/lsm files.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: apparmor@lists.ubuntu.com
Cc: bpf@vger.kernel.org
Cc: selinux@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
---
 include/linux/lsm/apparmor.h | 17 +++++++++++++++++
 include/linux/lsm/bpf.h      | 16 ++++++++++++++++
 include/linux/lsm/selinux.h  | 16 ++++++++++++++++
 include/linux/lsm/smack.h    | 17 +++++++++++++++++
 include/linux/security.h     | 20 ++++++++++++++++++++
 5 files changed, 86 insertions(+)
 create mode 100644 include/linux/lsm/apparmor.h
 create mode 100644 include/linux/lsm/bpf.h
 create mode 100644 include/linux/lsm/selinux.h
 create mode 100644 include/linux/lsm/smack.h

diff --git a/include/linux/lsm/apparmor.h b/include/linux/lsm/apparmor.h
new file mode 100644
index 000000000000..612cbfacb072
--- /dev/null
+++ b/include/linux/lsm/apparmor.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linux Security Module interface to other subsystems.
+ * AppArmor presents single pointer to an aa_label structure.
+ */
+#ifndef __LINUX_LSM_APPARMOR_H
+#define __LINUX_LSM_APPARMOR_H
+
+struct aa_label;
+
+struct lsm_prop_apparmor {
+#ifdef CONFIG_SECURITY_APPARMOR
+	struct aa_label *label;
+#endif
+};
+
+#endif /* ! __LINUX_LSM_APPARMOR_H */
diff --git a/include/linux/lsm/bpf.h b/include/linux/lsm/bpf.h
new file mode 100644
index 000000000000..8106e206fcef
--- /dev/null
+++ b/include/linux/lsm/bpf.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linux Security Module interface to other subsystems.
+ * BPF may present a single u32 value.
+ */
+#ifndef __LINUX_LSM_BPF_H
+#define __LINUX_LSM_BPF_H
+#include <linux/types.h>
+
+struct lsm_prop_bpf {
+#ifdef CONFIG_BPF_LSM
+	u32 secid;
+#endif
+};
+
+#endif /* ! __LINUX_LSM_BPF_H */
diff --git a/include/linux/lsm/selinux.h b/include/linux/lsm/selinux.h
new file mode 100644
index 000000000000..9455a6b5b910
--- /dev/null
+++ b/include/linux/lsm/selinux.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linux Security Module interface to other subsystems.
+ * SELinux presents a single u32 value which is known as a secid.
+ */
+#ifndef __LINUX_LSM_SELINUX_H
+#define __LINUX_LSM_SELINUX_H
+#include <linux/types.h>
+
+struct lsm_prop_selinux {
+#ifdef CONFIG_SECURITY_SELINUX
+	u32 secid;
+#endif
+};
+
+#endif /* ! __LINUX_LSM_SELINUX_H */
diff --git a/include/linux/lsm/smack.h b/include/linux/lsm/smack.h
new file mode 100644
index 000000000000..ff730dd7a734
--- /dev/null
+++ b/include/linux/lsm/smack.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linux Security Module interface to other subsystems.
+ * Smack presents a pointer into the global Smack label list.
+ */
+#ifndef __LINUX_LSM_SMACK_H
+#define __LINUX_LSM_SMACK_H
+
+struct smack_known;
+
+struct lsm_prop_smack {
+#ifdef CONFIG_SECURITY_SMACK
+	struct smack_known *skp;
+#endif
+};
+
+#endif /* ! __LINUX_LSM_SMACK_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index b86ec2afc691..555249a8d121 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -34,6 +34,10 @@
 #include <linux/sockptr.h>
 #include <linux/bpf.h>
 #include <uapi/linux/lsm.h>
+#include <linux/lsm/selinux.h>
+#include <linux/lsm/smack.h>
+#include <linux/lsm/apparmor.h>
+#include <linux/lsm/bpf.h>
 
 struct linux_binprm;
 struct cred;
@@ -152,6 +156,22 @@ enum lockdown_reason {
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
+/* scaffolding */
+struct lsm_prop_scaffold {
+	u32 secid;
+};
+
+/*
+ * Data exported by the security modules
+ */
+struct lsm_prop {
+	struct lsm_prop_selinux selinux;
+	struct lsm_prop_smack smack;
+	struct lsm_prop_apparmor apparmor;
+	struct lsm_prop_bpf bpf;
+	struct lsm_prop_scaffold scaffold;
+};
+
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 extern u32 lsm_active_cnt;
 extern const struct lsm_id *lsm_idlist[];
-- 
2.46.0


