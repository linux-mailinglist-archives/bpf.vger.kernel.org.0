Return-Path: <bpf+bounces-45158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 747879D2323
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B611281307
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 10:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763811C1F30;
	Tue, 19 Nov 2024 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="e7lMxl6E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED8013DBB1
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011195; cv=none; b=GO4II3HnJe1eb2/QkDSMf1tRuIFwp+NBagWS7qDZk2ylrhQRAC6hWdduY+tyxSqpODga//pda2kYiwM99t6xDTHwimONU8Z3v0bZUtXsXruMO4kmAYKSfy9jEUu/ay11NWykf+u3L280DWqfATLDgKrswMnahHRBVTMSrtzTIac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011195; c=relaxed/simple;
	bh=G3wa07rZYgN6CVGveQn2J5nSIZh5i+vLZIp5qLRAfWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K1GxYChSZe3L2jmok0brDLqLpp+B4SYXbDWgH5K+r5LOYX4x3y3lH6yoxM36jKeWbHVcdYjfrQJ4r7Nn+FAXiu6348ZFUCAhpLzU9NpqejibaPBrvNNHcNbzr2xsTzJKY/ttfppjMvzZy7GoXYFrp3qVWAu907LG8wuxpmV0nFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=e7lMxl6E; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa3a79d4d59so123430166b.3
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 02:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732011191; x=1732615991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoG5JO9syP1TPphV80q7oHvJ3++/Z/0Nk/f2xqd8VJ8=;
        b=e7lMxl6E0ANSfpl+MFpbI24+gFJkV0cNYvRTEHhtO4OVgsWWzTbNB1Iex+D43vSa6C
         7P8HniPU+q4yDLLc/XM+VOcmwhLu/5TVXGMnySznCOV6HExso2+j9AieUjnBnrzB7Kw7
         CUtIIpwTuFIdLnntplXkLZ8FLvxjaZBZ0FgM9J2wWV04VoMlRCm2NVcq/Cte+LlAYO4+
         2XzJZ2FhhUr5kAF1M8mlP1YS2jJja4vNt2F7maMqT8HdYnEwzEXlQ8r5PZr6nBdE55M+
         tA1KQC/6qM2alS7VIfdEPAmzjnsj+adjdsvc3JVMEre5ZG2IfHkqTn//XXzsy7+6Ts8P
         OLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011191; x=1732615991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoG5JO9syP1TPphV80q7oHvJ3++/Z/0Nk/f2xqd8VJ8=;
        b=Sq5WHW0ZPjt8IFaZBWhq4BXaEc+sBSo/dvP9BI76c1aH5zy2RjNkuf4W6BqKWhGGSi
         P9L1qkcXdGWlAqhGLF8GbBRg7qFUrgG4hfARnIIbJmmvz3lCqIDOIhpyJm5yhaMY3T0z
         t7dYCAyNOJEg0+tI5RFDr1nVTYZjy6hQly4Hg+CvpmcbO7Z9rqxBeHWAR7TQjP6cjB2H
         HIGWV0x9QosK1C/9y8b+Ig+sAlWEAu26mD3FrDtcCcnpsyEIfzyzkmJclsCiON3bcshT
         1qyMzj+VD3vrz0nH7h5OtkW0j4c8/QjgLJ4RfsWyKhLkkSANqdF2pWxTP7SvmdfBgMx2
         OPdQ==
X-Gm-Message-State: AOJu0YzXiRqioK5M83pnEn4GprBhdlWqmh5GXUuS/HmT230PVa/SfsMd
	V48Av4/mBOcZpYANxD2BTfgf6Y9Ka8Ciw8D2ijXqXCuXxBOmQIONBx0l0YVx+UoiTjISWLtDkzv
	X
X-Google-Smtp-Source: AGHT+IG5Znv8naabKvI0Z28q60PkEgTohof//IfJpxdK6tz1td6QkuoD4FbrdCS+W4Mrajzj4YE8BA==
X-Received: by 2002:a17:907:2d90:b0:a9a:230b:fb5e with SMTP id a640c23a62f3a-aa4833f66f2mr1568467266b.4.1732011191307;
        Tue, 19 Nov 2024 02:13:11 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df7eee4sm629003066b.87.2024.11.19.02.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:13:10 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v2 bpf-next 1/6] bpf: add a __btf_get_by_fd helper
Date: Tue, 19 Nov 2024 10:15:47 +0000
Message-Id: <20241119101552.505650-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119101552.505650-1-aspsk@isovalent.com>
References: <20241119101552.505650-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new helper to get a pointer to a struct btf from a file
descriptor which doesn't increase a refcount.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/linux/btf.h | 13 +++++++++++++
 kernel/bpf/btf.c    | 13 ++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 4214e76c9168..050051a578a8 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -4,6 +4,7 @@
 #ifndef _LINUX_BTF_H
 #define _LINUX_BTF_H 1
 
+#include <linux/file.h>
 #include <linux/types.h>
 #include <linux/bpfptr.h>
 #include <linux/bsearch.h>
@@ -143,6 +144,18 @@ void btf_get(struct btf *btf);
 void btf_put(struct btf *btf);
 const struct btf_header *btf_header(const struct btf *btf);
 int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz);
+
+static inline struct btf *__btf_get_by_fd(struct fd f)
+{
+	if (fd_empty(f))
+		return ERR_PTR(-EBADF);
+
+	if (unlikely(fd_file(f)->f_op != &btf_fops))
+		return ERR_PTR(-EINVAL);
+
+	return fd_file(f)->private_data;
+}
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


