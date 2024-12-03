Return-Path: <bpf+bounces-46001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599329E204D
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 15:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38D01B427A3
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 13:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169441F12F2;
	Tue,  3 Dec 2024 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="WW0VRdnX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37911DF736
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233723; cv=none; b=btT4tNlaaEcsuW0eb12H/6PO+7O44v3u41JJgoZSEmVtBiXV/TR/82nC5mgX62ZL6N0uGxl0OI1LecU6zNirkfeMlrRMQOJDiAhVbqZR3shbumlEIX6zNRnrRuB0c9Xo5Wo5pifSqNQzyR4O93smWBztJ8Jx+cAMOTr2gy50YqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233723; c=relaxed/simple;
	bh=ABC2JinWNRiYAUq/CXOh/OLgohJEP7+NA7nwm8xGSZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QOWAkHtYvIZjdghMIGk2+eUZoxF3SqqoQtyzCUaQmzbEadi7fddQDVjSXMrOkdJF6fDGrhVxzwu8FLi6jDqzxWruxZJUAGMQ4Qn6aUY/AsIoPXjpLYO5+Pv+cX19N4RUxMjzs1mJY/57zmYMSN20Fohj4o0L5UTTOkX5nQHjdMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=WW0VRdnX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cfddb70965so7006531a12.0
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 05:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733233720; x=1733838520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8POyoFbCcEjSQD4RN/xYZaFrBV0KG5Ys0zmlrQNRb2c=;
        b=WW0VRdnXCmaDlBhGcRi86/K2B3zVQJGRYNCGJuHbTAe7DtxKUgxHq/IOFdarG40KnR
         kuH9ruRuvMqmzZiePW9tIuN8JKLPl5fxAhJfjoEPTKghERvYyKPLHZDE87S04mQy+XAG
         7f5EffMwRLKDMC3UWu05Vu8sM5SLggwzpHMenq8Qd6wmi25GSDBNpZ8jd3jeVywoJ851
         S0MI7Pkm0j1QV9WpyiVob6EDALCqrboDvGxzXzC2sJQYqXNpkOzIOu3YmZRUtkhlNO7E
         4JKm6ulIjDHsD9xNtlLou9Q1HKY8AGCreTDk1/zq5tWAHnM/8VyGl7/k2I99r333QrFb
         ciEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233720; x=1733838520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8POyoFbCcEjSQD4RN/xYZaFrBV0KG5Ys0zmlrQNRb2c=;
        b=T3kOefAUpmYuuYHOf2gkh1d1oir0laazNNgmFo4fUarR/5xuFQslSliR5xnYEN76sj
         pGQOy+cFc/5URBjHavb73FoAZrfxyXPPC3/S82me4ZEyPVgUbcmmQiaEdRuVoktplONP
         s/miHTKeQemr5t6qSmvDBHWVKW71HuvSqquLdKMPg4yrvMwtX5cS7Z9GQRKajhSWBtzY
         N5NPiwSUhkj619bsAojXwbe4k4H+J8knkmajE8sCjt1LjWSt+ojalm5hjECLPfpalQwj
         WAw0rf/pu6CjdnXedAtIEhNu5sCr5LMobuzg+L1S96KLn8TpwhEz8oGf2+9cL3oIH90w
         conA==
X-Gm-Message-State: AOJu0YxtvcQvS0miJ6nrnJtWdB+168LyIuGwJDiZswArA4+DJZOKu7np
	nJ/cAKKFwwlmZBardPjZe+mnm+3rLWFq4BrXNNGV1t7Zm4cOMOeYRnEpVUeB3sDOnC+XdRct+p8
	3
X-Gm-Gg: ASbGncvW4nl2eb2hTKmng4+TGGexkKKTOgUfFDiQ7eV95RmoSDnP5gb6vIuwWt9XId5
	MOaxZT7RTB6BX6PibgCC6ySDa7/0Bf0esBeLaUULaC263WxMf163i4FThZGrokxJuAc4ffPFjNq
	bDcPIC96f0zw92DbtI+Uc3UBrzK3c11/HAWjqcoCraWC+LtIjQIdlLNYBOcOUqRySr6HlpTJtDJ
	NM9UqitgrZUI+egG0PJLHTclquzGvTGyh06VXHkD4RkOITUMs2XxkXjMFTHW1Q=
X-Google-Smtp-Source: AGHT+IFrjh7MHle/eL72xN9s5rky90fLVur4AOblU8wYrLCMguRg+0nMba4Vxloe+XDXPO1xPZvryQ==
X-Received: by 2002:a05:6402:13d0:b0:5d0:c098:5b with SMTP id 4fb4d7f45d1cf-5d10cb5bf42mr1984947a12.19.1733233719547;
        Tue, 03 Dec 2024 05:48:39 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d098330dd2sm6243394a12.14.2024.12.03.05.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:48:38 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v4 bpf-next 1/7] bpf: add a __btf_get_by_fd helper
Date: Tue,  3 Dec 2024 13:50:46 +0000
Message-Id: <20241203135052.3380721-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203135052.3380721-1-aspsk@isovalent.com>
References: <20241203135052.3380721-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new helper to get a pointer to a struct btf from a file
descriptor. This helper doesn't increase a refcnt. Add a comment
explaining this and pointing to a corresponding function which
does take a reference.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/linux/bpf.h | 17 +++++++++++++++++
 include/linux/btf.h |  2 ++
 kernel/bpf/btf.c    | 13 ++++---------
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eaee2a819f4c..ac44b857b2f9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2301,6 +2301,14 @@ void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
 struct bpf_map *bpf_map_get(u32 ufd);
 struct bpf_map *bpf_map_get_with_uref(u32 ufd);
 
+/*
+ * The __bpf_map_get() and __btf_get_by_fd() functions parse a file
+ * descriptor and return a corresponding map or btf object.
+ * Their names are double underscored to emphasize the fact that they
+ * do not increase refcnt. To also increase refcnt use corresponding
+ * bpf_map_get() and btf_get_by_fd() functions.
+ */
+
 static inline struct bpf_map *__bpf_map_get(struct fd f)
 {
 	if (fd_empty(f))
@@ -2310,6 +2318,15 @@ static inline struct bpf_map *__bpf_map_get(struct fd f)
 	return fd_file(f)->private_data;
 }
 
+static inline struct btf *__btf_get_by_fd(struct fd f)
+{
+	if (fd_empty(f))
+		return ERR_PTR(-EBADF);
+	if (unlikely(fd_file(f)->f_op != &btf_fops))
+		return ERR_PTR(-EINVAL);
+	return fd_file(f)->private_data;
+}
+
 void bpf_map_inc(struct bpf_map *map);
 void bpf_map_inc_with_uref(struct bpf_map *map);
 struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 4214e76c9168..69159e649675 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -4,6 +4,7 @@
 #ifndef _LINUX_BTF_H
 #define _LINUX_BTF_H 1
 
+#include <linux/file.h>
 #include <linux/types.h>
 #include <linux/bpfptr.h>
 #include <linux/bsearch.h>
@@ -143,6 +144,7 @@ void btf_get(struct btf *btf);
 void btf_put(struct btf *btf);
 const struct btf_header *btf_header(const struct btf *btf);
 int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz);
+
 struct btf *btf_get_by_fd(int fd);
 int btf_get_info_by_fd(const struct btf *btf,
 		       const union bpf_attr *attr,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e7a59e6462a9..ad5310fa1d3b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7743,17 +7743,12 @@ int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 
 struct btf *btf_get_by_fd(int fd)
 {
-	struct btf *btf;
 	CLASS(fd, f)(fd);
+	struct btf *btf;
 
-	if (fd_empty(f))
-		return ERR_PTR(-EBADF);
-
-	if (fd_file(f)->f_op != &btf_fops)
-		return ERR_PTR(-EINVAL);
-
-	btf = fd_file(f)->private_data;
-	refcount_inc(&btf->refcnt);
+	btf = __btf_get_by_fd(f);
+	if (!IS_ERR(btf))
+		refcount_inc(&btf->refcnt);
 
 	return btf;
 }
-- 
2.34.1


