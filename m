Return-Path: <bpf+bounces-79123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF28AD27E32
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0304E30EB0AE
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063DD3BFE20;
	Thu, 15 Jan 2026 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftCk80BA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038F52E0923
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502724; cv=none; b=F/HBZUbZU9hPy2C+4d7UibXZjNN6QkdzZdiA+WrY714Gyl5BMUDUZ4tJFO1AzcXL6LRRA1mrqSBmAsV7NNOM/ec+0k25EI2TSkTrNISKndBki2+DHfwCFJC6g6tai84NLcVkkaVlMncgc+2ECtmVqZZNXL4xdERC3Zcds17aRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502724; c=relaxed/simple;
	bh=EFL63FFlz30RoPcSU9RimtrCKcZJ/bSO099/xwfNfuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3xanqg1M2ooCOw9D5GaBvqRBvpEwx9aRxTO/CQwWUxFzzibX5M8fhZ+pACy0LdXWImbDrHUxb9Wrio7QgNfLY/7DKmREzHYQqS3omAOglHDeMMxw8psOFWl9SEio058U4SpT2NWXWh7nYgEZNgdUZA7Ll4QqbDHz5RyAxShEOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftCk80BA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801d24d91bso5078725e9.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768502721; x=1769107521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T4sevIX2vz5i3IwZTXpnIl7JXh75LeXlHl1YTPoDENs=;
        b=ftCk80BAnmcWmmwugmf7pz1aDVZMNtkoXnbEfjOA23bpiA9YuFiphw5MSblZxHZZ7v
         eXXlfmAU0g3ApP1ZiAE8obPFO+gtXUNjdmLCOrghnRzPoBVxYF26CwFwmoZYUw6Lq0uV
         RoK8ZyqSS0iMyHaHasNyfKXH+KbaCbFMoF/jWH+YWkzC3FQTOTrM6wwK0MM06EPuvo9p
         +ECR2yTzEkGLnm4ogCG2VsjOPXx9xOfnoOCEOF6RFOCEIkMuZ3BZmSKRoOfxlg5pjYx1
         kijaa2NlJUSZdJRD+iHV3sW4kf3mxdWMq+Nzf6te2qLAyF4veFyizi4PWtYVEhK/7Vj8
         hO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768502721; x=1769107521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4sevIX2vz5i3IwZTXpnIl7JXh75LeXlHl1YTPoDENs=;
        b=hsq9anLQy4wqgJtzw6dg9KUxtUmLAXmbshdZcXY9gX9bycaN2EzQviuFjvPbTrQglq
         10mCkNlQD2zltUdX9pllQtqtGyDZmaPrs8DLb/kuLSLchvAPSUfVaHxC8ez8UebSoNv8
         pJvhPlFZVk+81HBd7jkjFc4M7Zgvc5UUy6yDIxtuxxZrLW5Y4bbJYy3nVml6srRyHenw
         2FpqOpjDUSR4S0jNKhmuwALs3RHgis+IyDCCHLiwJDY3hGp2acDCTC+HPBwb7aKjh1rC
         QRvwiRIBxwraS8HQlO+PMihzGH9onvTLPTulhkO1Rt+5gtMl8FkdxYBTMibft5AYiFOS
         bZkA==
X-Gm-Message-State: AOJu0YyWVGCKNWA1OJM39fM3Y73cWjFKd7aYqMuJ9ErVgouo77WNGsyB
	TVYoDV2o3OD9mPw/xmlrArhtdBsLh0MDnIr+jrzSHBCRLSWLFxFACqJIJDqAsw==
X-Gm-Gg: AY/fxX4BzhFQyvlWP+FUHRtuJRjOsEqKuQqWN+siaawG6xurYkIPeaz2jEYKH+FCAks
	10ebiLLGy0M7TXBeD8qzmk2KjJ2LLvmUe2DQtpsUBSCPka2G2N6IAA5ifDdTWFf0aBPhBK7f8Xs
	otw7O4hIyJzFKG0VtIdfHfEUWdiV8BzVfdzQ7FaPVqRBv/g1aQ0baSsoFkublfHRDVd2daGu/Xs
	A/AxFvxgn3ILTW7ztyJCaoc/pkCBzKJvrSJygGsJxEhOQ24Os9YM7hoivbLq/Yf83SJ0ZtxPpKa
	fgOsESu9Qgy3tSL/QPf4LmRNPl82ARVajjDv2UMNaWi4oGk8mNo7VUFLUp6GhHTIfwMqkWmiy+5
	NqSBURrSJqmcS6U4bAlLwRYpRdCXo6UUN7QY2p3k0p/LElZMFoGk/uNenHZwiIdOlMQ==
X-Received: by 2002:a05:600c:1c19:b0:480:1dc6:269c with SMTP id 5b1f17b1804b1-4801e350488mr8980005e9.37.1768502721195;
        Thu, 15 Jan 2026 10:45:21 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::5:2520])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e9ec958sm1178875e9.6.2026.01.15.10.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:45:20 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next v1] bpf: Add __force annotations to silence sparse warnings
Date: Thu, 15 Jan 2026 18:45:09 +0000
Message-ID: <20260115184509.3585759-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Add __force annotations to casts that convert between __user and kernel
address spaces. These casts are intentional:

- In bpf_send_signal_common(), the value is stored in si_value.sival_ptr
  which is typed as void __user *, but the value comes from a BPF
  program parameter.

- In the bpf_*_dynptr() kfuncs, user pointers are cast to const void *
  before being passed to copy helper functions that correctly handle
  the user address space through copy_from_user variants.

Without __force, sparse reports:
  warning: cast removes address space '__user' of expression

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601131740.6C3BdBaB-lkp@intel.com/
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/trace/bpf_trace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6e076485bf70..c9ada367a202 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -830,7 +830,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struc
 		info.si_code = SI_KERNEL;
 		info.si_pid = 0;
 		info.si_uid = 0;
-		info.si_value.sival_ptr = (void *)(unsigned long)value;
+		info.si_value.sival_ptr = (void __user __force *)(unsigned long)value;
 		siginfo = &info;
 	}
 
@@ -3517,7 +3517,7 @@ __bpf_kfunc int bpf_send_signal_task(struct task_struct *task, int sig, enum pid
 __bpf_kfunc int bpf_probe_read_user_dynptr(struct bpf_dynptr *dptr, u64 off,
 					   u64 size, const void __user *unsafe_ptr__ign)
 {
-	return __bpf_dynptr_copy(dptr, off, size, (const void *)unsafe_ptr__ign,
+	return __bpf_dynptr_copy(dptr, off, size, (const void __force *)unsafe_ptr__ign,
 				 copy_user_data_nofault, NULL);
 }
 
@@ -3531,7 +3531,7 @@ __bpf_kfunc int bpf_probe_read_kernel_dynptr(struct bpf_dynptr *dptr, u64 off,
 __bpf_kfunc int bpf_probe_read_user_str_dynptr(struct bpf_dynptr *dptr, u64 off,
 					       u64 size, const void __user *unsafe_ptr__ign)
 {
-	return __bpf_dynptr_copy_str(dptr, off, size, (const void *)unsafe_ptr__ign,
+	return __bpf_dynptr_copy_str(dptr, off, size, (const void __force *)unsafe_ptr__ign,
 				     copy_user_str_nofault, NULL);
 }
 
@@ -3545,14 +3545,14 @@ __bpf_kfunc int bpf_probe_read_kernel_str_dynptr(struct bpf_dynptr *dptr, u64 of
 __bpf_kfunc int bpf_copy_from_user_dynptr(struct bpf_dynptr *dptr, u64 off,
 					  u64 size, const void __user *unsafe_ptr__ign)
 {
-	return __bpf_dynptr_copy(dptr, off, size, (const void *)unsafe_ptr__ign,
+	return __bpf_dynptr_copy(dptr, off, size, (const void __force *)unsafe_ptr__ign,
 				 copy_user_data_sleepable, NULL);
 }
 
 __bpf_kfunc int bpf_copy_from_user_str_dynptr(struct bpf_dynptr *dptr, u64 off,
 					      u64 size, const void __user *unsafe_ptr__ign)
 {
-	return __bpf_dynptr_copy_str(dptr, off, size, (const void *)unsafe_ptr__ign,
+	return __bpf_dynptr_copy_str(dptr, off, size, (const void __force *)unsafe_ptr__ign,
 				     copy_user_str_sleepable, NULL);
 }
 
@@ -3560,7 +3560,7 @@ __bpf_kfunc int bpf_copy_from_user_task_dynptr(struct bpf_dynptr *dptr, u64 off,
 					       u64 size, const void __user *unsafe_ptr__ign,
 					       struct task_struct *tsk)
 {
-	return __bpf_dynptr_copy(dptr, off, size, (const void *)unsafe_ptr__ign,
+	return __bpf_dynptr_copy(dptr, off, size, (const void __force *)unsafe_ptr__ign,
 				 copy_user_data_sleepable, tsk);
 }
 
@@ -3568,7 +3568,7 @@ __bpf_kfunc int bpf_copy_from_user_task_str_dynptr(struct bpf_dynptr *dptr, u64
 						   u64 size, const void __user *unsafe_ptr__ign,
 						   struct task_struct *tsk)
 {
-	return __bpf_dynptr_copy_str(dptr, off, size, (const void *)unsafe_ptr__ign,
+	return __bpf_dynptr_copy_str(dptr, off, size, (const void __force *)unsafe_ptr__ign,
 				     copy_user_str_sleepable, tsk);
 }
 
-- 
2.52.0


