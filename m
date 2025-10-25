Return-Path: <bpf+bounces-72173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3142FC0860B
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 02:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE4E3AFB35
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 00:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1D62F4A;
	Sat, 25 Oct 2025 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hovA5M9f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E01A26B;
	Sat, 25 Oct 2025 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761351042; cv=none; b=ODnNTHTkb5yNnmF/bkEXJj10eRPqjOOF9Goh4QqWgy1p2Jk2J82MeQyAotAH/dhzF2dCYUtCapiSPbb1YOtQkGovz/I/P7nfFpUAGxTIu/9NXgTA5Lvmw6LkD06lea1WmzPMkLmk0g/1wWoxYl3/iglIzyeyMyZ/bbqfwQNckio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761351042; c=relaxed/simple;
	bh=LKflfcEkcxaTywqX1KQ6eNf3jakjQw3bGfr9z5Ar9zU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CgJZd0n3UTYc4fVnxP4Afoj4CgMeDcO3k0koAKXb9ctHp/ZWH2qbQV1LlWpOvTGO1jsEgf4rFJ4q71BeO1dVCBcyXhmyzXru3xrsl1mThi+0mtZk+vsh1WGwE8++0JxnW8v95zrhMUS/8DhD2l5FZqUZkpmnQdXVFeTj2x2TvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hovA5M9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44829C4CEF1;
	Sat, 25 Oct 2025 00:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761351041;
	bh=LKflfcEkcxaTywqX1KQ6eNf3jakjQw3bGfr9z5Ar9zU=;
	h=From:To:Cc:Subject:Date:From;
	b=hovA5M9fa4IxyDfqCXNOIW6YXZnpYJ+2Eky3gbzRolB0B+zIMvy0O3vTRcdfDBTJR
	 I24qQULCHDZAZ/SP8Qy57u0yjawp6Q+eF/+F9p8RcHc0WkPpVAOGpiSQlrQlt+ALRw
	 PB/8n50c1m0OmWf0RRrD/DAfhG/wYjDJeLy1DdLO4w6rIdA1PDujDd0/HEd5yKrRyU
	 s6JAMJVx0Xqg8H5auFyo8D/a1+458o50FfGxVuqv41XbAkUmGdRw5UZakFyNO/8rFu
	 OHeBQOxpAHAmKLNqjz+7c/JBdFbE6dX7WCiEkirHeFkex+Ydfj9sT0tPiLtx2cqXXU
	 LsC5Qw7dn+7OQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	casey@schaufler-ca.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	john.johansen@canonical.com,
	Song Liu <song@kernel.org>
Subject: [RFC bpf-next] lsm: bpf: Remove lsm_prop_bpf
Date: Fri, 24 Oct 2025 17:10:22 -0700
Message-ID: <20251025001022.1707437-1-song@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lsm_prop_bpf is not used in any code. Remove it.

Signed-off-by: Song Liu <song@kernel.org>

---

Or did I miss any user of it?
---
 include/linux/lsm/bpf.h  | 16 ----------------
 include/linux/security.h |  2 --
 2 files changed, 18 deletions(-)
 delete mode 100644 include/linux/lsm/bpf.h

diff --git a/include/linux/lsm/bpf.h b/include/linux/lsm/bpf.h
deleted file mode 100644
index 8106e206fcef..000000000000
--- a/include/linux/lsm/bpf.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Linux Security Module interface to other subsystems.
- * BPF may present a single u32 value.
- */
-#ifndef __LINUX_LSM_BPF_H
-#define __LINUX_LSM_BPF_H
-#include <linux/types.h>
-
-struct lsm_prop_bpf {
-#ifdef CONFIG_BPF_LSM
-	u32 secid;
-#endif
-};
-
-#endif /* ! __LINUX_LSM_BPF_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 92ac3f27b973..b6ace332576f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -37,7 +37,6 @@
 #include <linux/lsm/selinux.h>
 #include <linux/lsm/smack.h>
 #include <linux/lsm/apparmor.h>
-#include <linux/lsm/bpf.h>
 
 struct linux_binprm;
 struct cred;
@@ -163,7 +162,6 @@ struct lsm_prop {
 	struct lsm_prop_selinux selinux;
 	struct lsm_prop_smack smack;
 	struct lsm_prop_apparmor apparmor;
-	struct lsm_prop_bpf bpf;
 };
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
-- 
2.47.3


