Return-Path: <bpf+bounces-39523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610069742B4
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 20:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CA01C25D08
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 18:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33741A7043;
	Tue, 10 Sep 2024 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iu0davLr"
X-Original-To: bpf@vger.kernel.org
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EC4167DB7
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994303; cv=none; b=jtRcvcx4YWtYTHC21kHJdiQFrDZQ2ajxB3EqonW5siB181fJ9NTVfz8vHhwYiSYU2Mxt3FLg4EIea+aFZpzBsnF533s3BoNXn+f6eIxs2ZBvVkd1HVje0ccDya7I07AxGPG2BRt+JR959hy0VEbG9gV2qD4Ml5rvLl1iPalCmTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994303; c=relaxed/simple;
	bh=iXfhEisxb2+IWqPf8Qmd7+F48D2xzLyfyaflSJ7SQYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jS9sTwOWlV2YmJ1w+uZ89eKFzcAtw29eX8NpjDQtap3l/XVxSIKamu+TVLGbHat9SjEoB/TpK2U+m1Y0qM5gYzG6Nv6FQNa1SvWs9leYXjl+fKb+ljHPYRU+NG6yswqksG+KyivjJh5f/EO9vFme6I1I8O0DWK4+u41Tyte/UdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=iu0davLr; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725994300; bh=hE2XLxKY+ItLaGKEYikD9qRUNGyt4d0i6XrIOITfYq4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=iu0davLrzfYLrTQ25/IZtpRjfA+XWwp/+PJ1FpHG8mU8k+WjW9n2Pw3JtB5cCs/9xwEGb3XTtLrvFBhlNrOKqXUcQ0P4MybeZUHu3gI5rX2KiYta4YNw2d7pW7I01seIZntwoSjCuR128l6dMskpt/BxGwOdPisJVfwEoWtFct9SUbrVB6lPvQIjUv4XgztMRDlG1cpmOqaD9+PBlQBsu2469OwtjCRRQGnR/XazHcrjUvrQ9YFUEyvUQyQea/K+5de9udJMbQTWjavfzCQSOhodmNah6d9UA/a8oSWHihmymIijp4iDKU6qmGhrX+GcFxj0/5k18Ya1ttdKAzvvkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725994300; bh=/xzPXKLMuuRWFaDt5eBmqiNXj6FTivFz5/J7n2x+4jw=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Tpc7R/Wo9Bg8CdRQ2atWO/2IKsHlhFwMFyhZjt3mtdq62gUtCqEL27+pf/PUjl1HIQyjERy/E4hr/aXaRCaRFRor0ZVncAduI79UQ09TASh2ed+8no+BUa1az6r8Ly/llyPgccR7naU9qERMzXkQNtz7iPne6Or5Zd8zhnechH24Y/Y0bCYBtVrQLlRbxudHx953hqfx6/NkUpBdS/5wmNYG1k+wzXBW/CYjkgOUuSgI/9Yv4ewvD0ZVrgq8sij9TrJ1f33vAvD8+3D7PJlpuRB4frsahGrAyxGxL8VGRvJRqrabxHVvz7zbjk1IU2hOD9wQkczVhkVqD+b5eH4ONg==
X-YMail-OSG: lYsK.8gVM1mhUSBIE.5ARCA_jMSVJfJ3x60AfolUYHGmnP_bku7kMTV3CtECNxn
 FgS0e020Uhksp0G1m7AlynBsiKEeM1dctUk2zHoSP5Yu1ioDo0GsiShqxGLQNQZwQODlZKKaji5w
 PfgkZq6pOij3.8qJaN19zyphN4VXjmXvq.NjWTPpmY3py_L8i2VI9Nxfj2KT796Tz9AFwwL1lhG4
 .Wao0mQ4lxf7BdnE5ys_8XYx6vmDqaGnPmRIW0B9gEEZbthPz_Cn.NhEPNdAU1.TOveDo212qWrT
 oZT_is_Md8GjvZFaiNSqva7J5ru5d3pXgnc5z4poWYcZmlyypymlhjZmkh0ACz__eLqdq2Uven7P
 wlHF1gzNto8Nav2As9BC7CKo0YeTgsZ3jyGl8xKtzmul4txbDoh0vz_PCvtRueh0yXKPKmYUvw1b
 2m16lrHzGYRztn_r6zS2QbSGJAEF.BVtDFFXO6ZPJNHrsBC_gg2pjn9qrB19GrfcBn1kfNcwwUMO
 8Gdlm7GDwLsyKrMo2ZWnDjikCxyxKi4C_JzqvSgnx_vi4jyTUALlNBIwI0kJaV4kHAURhJhGFm1F
 Xnb9VCbdkiDV7PdLJwDdVyYTaj8Fihq2jVXjlkM_b5oZ7zBHCuGx3ke0hvUqX0H2cn_8MMcs3mlE
 .0xwtouVCtsF06UJbIRJjzfFqHwzQ1dbex1QUU4dTQaUi.lOLmrrWW5fpURQhDTU92lPXQ6XRfQA
 9oxpdt3Awdfzm58N5GhcNTHOE.wljkRvD5wo12NoJ41uCgWIEpOG9kO1tHU9TR2ghwhp1rnKYnhc
 5fGCvoSowJvW137jnfzFD0pzZqtgaCss0.hd.CDckJWWJi7e2ijuAqR5GycHd_aGESHG6AhFDUTR
 QTX4I0lqFVfjFhCnfYvLn2n2WUSJEd_gXsAjYOOAkzFZ3t2kRRoU9UADZCcCFsmLCdlyGUnucTIx
 dJRvSo6PZlEb6N9f.JTLQ7ZPSeIVbpVTvAmKaK20SOKSdmbdLzZwbn0_f2pXXN4usKExhW9SUIqM
 cOByB5mdTsZLyKOHX4vk49nkXWkyCrpccO7Rx9cuoohGIdOqeHrUpK9HpreDy9aZiVsLVwGNI7P.
 .qM.M96X45Hg7.JGyJr6uFKL_mtiaZnl5kIyGOaxfTUQaDZUKcJUZ3AX6Pxe0tf.VWwVK1wk23Dg
 uxIzfD0NjCfUjoIvrWna.g6SBVjbZRqa76pwA6WJbm2r0AmKD45AmQz0DXCiclTNIKf5A3shuDG2
 Aj1dS5kPAXB.nArf3QdDYvR8cx45dhp8fgRwhZmdntHgw0GfS5MxRU.ZxdvxBySZ1Y760pUU9cKa
 NYU5q1Dp1oizsp_HSYPq4da4ypNgXd4RK9Npvs8kmPuTYgkUlbOzF8SgdLaKJq4lBafyD7ozdDdW
 TFmke5roYc.QmDj5O8JS4U5O0LK6.ErMOWo.JVnxsAJBbK0.A0WcEcu_FC2zb1Gv5oNY0weBRLQv
 6IFhBDutOmX0QMv_lhlf2hamN6eu3sWdtF53Q1k2sj_gHRGIiw_RvWptGZ_XBQdA3H2Tt034opSv
 WwaZfdxjgFCYz5JKdpdpiZ4_4lNpw4NJH_ptx6pXDGDmcYpL7xYB0PxoK7Jq09sr_8JukJN_X2U.
 9.40W4oyt6DOXrdfzzEJqkQffFhTDQdiGQmVSQAt4zB6RImZSar3oBtyIN_iTX0nAwxXF.oMX8qS
 grzxOoL9GpgqscNFkHhA_BhemBnkW6eM7byCCxdxrOKNLumeft4pBr9tcZrcSZsFhJYv0Q5mXjaa
 mSgG9MV48IGhM_tpWwT5eS9ocExE9wb_hvrY4GwfV.Ef0OJW0BaT5j9BkosuPSac221m9s48BoND
 w2pNSWcjlRfm5iPX4k7EIo3dzOE_RdfhIQaecLzYDzJO27jxwfZWVGgDPlUU5bnxAlZIauQwHoYB
 ylEEBetC3MyGz1YlwKJ2L1Rj08MlMttelw76R.bC1n4UqVH1LBRgy2EBTihRGhdsxTd4T6kspSt6
 fJ7if2I4kbdisTGxnrHW04Y9rTEqkDyQ1ZHdMJdiEB1pM6tXK.jxrfz1mdLWnmkvvHhbtiMZVfPh
 8ZeCANfZN4eNvKPPQug9a_WusZDpZzEsHz.zOxGAX.AhVGzdgVHCwSrLiCPYB9QUz4CVL2yVJVxC
 WM3FAPOBarCz6M4nhWUsUieZ47QwnCSTECZpk7Pg4kHD.QUqZnCQsXYZDSklAaWrw.FIa1ZHpWPj
 PjO30jrnahGYSOB60wXG0kOnb78zaG4GPvCSZWXCVR7cT5Suk_DKuSgD_P8Ll9_Si0p7pMRrBHeF
 a9G5cW0M..4wch5wVjB_x2k7FZvTvMuJEPhS7
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 2352b9a3-2409-4959-89b3-d3c615c9372b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Sep 2024 18:51:40 +0000
Received: by hermes--production-gq1-5d95dc458-rvnnh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0f4d83cf88f6912abe79246c392d6ed4;
          Tue, 10 Sep 2024 18:41:31 +0000 (UTC)
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
Subject: [PATCH v3 01/13] LSM: Add the lsm_prop data structure.
Date: Tue, 10 Sep 2024 11:41:13 -0700
Message-ID: <20240910184125.224651-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910184125.224651-1-casey@schaufler-ca.com>
References: <20240910184125.224651-1-casey@schaufler-ca.com>
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
index 1390f1efb4f0..1027c802cc8c 100644
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
@@ -140,6 +144,22 @@ enum lockdown_reason {
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


