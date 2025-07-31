Return-Path: <bpf+bounces-64839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D27B177D6
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 23:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3145C5885BB
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 21:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B19258CCB;
	Thu, 31 Jul 2025 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cmi/PP2d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044E0A921;
	Thu, 31 Jul 2025 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996194; cv=none; b=FxSECdXKnC/u0hMjQqUIXdzSVyHeQkTeKJtShj4AWPu1q8sfPgrbqm8TT14umESdpDIpGDWV4eSxBYFhPQohrbg1HOKR8OfwtlXZOuLUWWQt/DP9q8KknDz5ulIWEFLqu/tKT0Hrkd/O7ceuJcNVSr4ZN99FsNvKZhNmVQ3Sw3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996194; c=relaxed/simple;
	bh=goGHIwXQjm39lClSVOguqWuCOjqXk95voq5ncmSIXY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFNDSQPOAri/A1sPERv+/aNCu/QpOizjrFUKnHVA+r2pkf8n65L/FR1xUwydyVUoEPF2LvVfOOFmANDpM/C048emV7ae+1YYftVojvjfjggLRm6gbyN4U86af89WWdF3ol1uA9ZkUSoGSATUfyuKvvrmUl1Z7XQBYDzFSEWewYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cmi/PP2d; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73c17c770a7so302440b3a.2;
        Thu, 31 Jul 2025 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753996192; x=1754600992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBN+keDzAc8UM8NN7QgsoVq8Hc93jRiQDLCV28ad4h4=;
        b=Cmi/PP2dwzzOnLaPtfKEV7WEQ092UycWyU8oABN0ysuuje7FnYH7Z+1KGYMtioz3Cw
         c7q+4qJZY7TSNUFd5KKHKjG4JhnFhehPYA09lbjlerhvxkTos72amyUseguz7cTq+3Gv
         BGziSPxo6HzcR14GNagXDTaCrdESSpBVke+yHcOMp0hhQulhmkIU9pMAnU24+gcGlf1k
         FYqU/QaNFQYP2fep3q00nIHtYFUNDvfeSORAhYbof+yZYSRhpZLCiETtmGFGzQCSV4od
         DnUtlrH+py3ZtlnSwhB1sVmTDZIKyPxtGnLTXB7fi05CDKLAlDLikjkVaE/0MMpsXr6Z
         5Zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753996192; x=1754600992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBN+keDzAc8UM8NN7QgsoVq8Hc93jRiQDLCV28ad4h4=;
        b=whCLlkalJvbG6gNAJ//rM9Fth+mVX3xvKvRNJzlrV9yNbjv+54g7P16kCC0ETHlkvt
         hCnWowxJlG4gftRz5QgXK9acTUlxxj0Siw+eoXilRwca1stt7UhJRSxQ6qVYvIJ4cfit
         AK1q4rUCGGA3AEjX/Lh/uXpK6c7n27v8iAjyRK8ddrObPmyXq7OYsPhLThgIzyE8AxrN
         D2H/ff7hycWHmGaM9KmNakWlI2vrTIN9QoJFz3VZRlr2KLFiy0Q+XStTvcd0dGBE3oah
         FKUIjE6QMx9aLVJhg2LmaoanJD+QNW2stgY5i3EbBxMVh3x1XSfOf2qhtE1Gds5Rkvy6
         RZBg==
X-Gm-Message-State: AOJu0Yw0Gfzaax6tP1ajTVBWRfAZphkGPez5OFVxcuEFGLyt7CIZiDyC
	TPZCl8aLyzxVrF7cGBdAjwRrgXhL0qoC3SVWJqkUr0FRS9HPKNkjSLB97xnC8Q==
X-Gm-Gg: ASbGncu25m5NNiL4xfLvP7hlmMwnWvZOuCvsqfidY1iLjfyaj7rAJH02iAwHLxoinJQ
	VzxhbsBNMfL7q+HrIgMbn2aPTA5O/ZqBZJS0DPT1jywMf7MmDvPhoyYD1aYglA0Q0mYKQdOp9Hs
	WxN0BnDGNk7RPUNBJZogFcBTPwVFbXIV4Jt1LOKqNq3rVDdwxt5CVtrGe6BgtucXe4ob3w5/tzm
	7NDS/+MFruOSanifq0kiZ0NhfwRe/4Fo5WZSeyP3FaLY68kesonniOVGWRS7aseESJXZInbEg3b
	uvxNFSpgVeY5YOryAgjRVFXuGqH+x+iLUVfZVihGz/Vgg6Eju7HcGck4cmd0bP+SB+WWB+bj5M6
	mIZv9w2tunXPKlg==
X-Google-Smtp-Source: AGHT+IH9F2syxC4mBH45kGTSzw7yMBlMLuoMHoQzMAxqqjwHhNTZkSHcy+Fz41VvSYbDr7TJ8Z692g==
X-Received: by 2002:a05:6a00:3a1e:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-76ab092f862mr14827577b3a.3.1753996192112;
        Thu, 31 Jul 2025 14:09:52 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbf07fsm2439371b3a.86.2025.07.31.14.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:09:51 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/3] bpf: Allow getting bpf_map from struct_ops kdata
Date: Thu, 31 Jul 2025 14:09:48 -0700
Message-ID: <20250731210950.3927649-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250731210950.3927649-1-ameryhung@gmail.com>
References: <20250731210950.3927649-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow struct_ops implementors to access the bpf_map during reg() and
unreg(), return bpf_map from bpf_struct_ops_get() instead and let
callers check the error. Additionally, expose bpf_struct_ops_get() and
bpf_struct_ops_put() so that kernel modules can use them.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h         | 4 ++--
 kernel/bpf/bpf_struct_ops.c | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f9cd2164ed23..5bc08a77df7c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1948,7 +1948,7 @@ struct bpf_struct_ops_common_value {
 		__register_bpf_struct_ops(st_ops);			\
 	})
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
-bool bpf_struct_ops_get(const void *kdata);
+struct bpf_map *bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
 int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 moff);
 int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
@@ -1963,7 +1963,7 @@ void bpf_struct_ops_image_free(void *image);
 static inline bool bpf_try_module_get(const void *data, struct module *owner)
 {
 	if (owner == BPF_MODULE_OWNER)
-		return bpf_struct_ops_get(data);
+		return !IS_ERR(bpf_struct_ops_get(data));
 	else
 		return try_module_get(owner);
 }
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 687a3e9c76f5..7b9bb6a211f0 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1150,7 +1150,7 @@ const struct bpf_map_ops bpf_struct_ops_map_ops = {
 /* "const void *" because some subsystem is
  * passing a const (e.g. const struct tcp_congestion_ops *)
  */
-bool bpf_struct_ops_get(const void *kdata)
+struct bpf_map *bpf_struct_ops_get(const void *kdata)
 {
 	struct bpf_struct_ops_value *kvalue;
 	struct bpf_struct_ops_map *st_map;
@@ -1159,9 +1159,9 @@ bool bpf_struct_ops_get(const void *kdata)
 	kvalue = container_of(kdata, struct bpf_struct_ops_value, data);
 	st_map = container_of(kvalue, struct bpf_struct_ops_map, kvalue);
 
-	map = __bpf_map_inc_not_zero(&st_map->map, false);
-	return !IS_ERR(map);
+	return __bpf_map_inc_not_zero(&st_map->map, false);
 }
+EXPORT_SYMBOL_GPL(bpf_struct_ops_get);
 
 void bpf_struct_ops_put(const void *kdata)
 {
@@ -1173,6 +1173,7 @@ void bpf_struct_ops_put(const void *kdata)
 
 	bpf_map_put(&st_map->map);
 }
+EXPORT_SYMBOL_GPL(bpf_struct_ops_put);
 
 static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 {
-- 
2.47.3


