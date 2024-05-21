Return-Path: <bpf+bounces-30175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D10588CB62F
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 00:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF2F281B61
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5F114A09F;
	Tue, 21 May 2024 22:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8pQ2VNQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5970614A08E
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716331988; cv=none; b=NSTOLQhIXeilPTs6LR73UhoOP5XnLcECJCiI00ywJu7GjOpw2+BWCTAr1SrcRY9oVuIW1jiLHzkzOodz6GqGkuHMuviJ7APPw0PeMjkeLSe7/Qk9Wc32dN72w4nHcM8TsYp3C0wGvI2Vp23jWAEyuA+It5KcseUM0iKgz25xb8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716331988; c=relaxed/simple;
	bh=34VL9O4NDfy7Ojt5kCpX/zgfJ2l99XUzUsH5/dLKqgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hKycT0ZV95dzaHCBmFZhHHLrG4t57GZSiAp4UnKCF5OYtjY2rYyqkH0qNFeH+Hc3d3uSlYB+4khWgKCbn37AXxq1vICaAkw+AEYWucokcqXD9ghlO3VVtlVSVr0yNNYWMle53FHMl7ec8i/9K8ag0hqXRJfI8YHvCHTuhmtR83Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8pQ2VNQ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-df3dfcf7242so4370449276.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 15:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716331986; x=1716936786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXM2QFy+xceW32g6/wIpbUNL9uI/2VITc2w+pZ/sTY8=;
        b=Z8pQ2VNQKWHLwWRM5LjFIH0K/AFDzsmbCqBqy71sVLybeLX/EfFA4CYAX/YpNMCkRh
         XCD+MVA6VqLfsHIi6jB+051weJ1f4RyZof56qcusKfy3tyUkkBmQKktq6CvCcIwqOQFI
         AWFSgAfkb34atHFsmkvQMF/6FcLz5JvLzOBGLU30cM3QGYB6vzTtpEExzju0hKhyWO5T
         xRgF+w8w34gEZYKLbqIrVMA+5YMCert6e5s7Mm+ybTsEp1K+WvTdyeH87wocaxVpqqkZ
         q+VOXqe8L+etPVz+Q/jQaVdTJOhO3jmeMQ0s+ZCUmj/TjpBaxW3bPvvd2l5VgUUbDpWN
         UkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716331986; x=1716936786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXM2QFy+xceW32g6/wIpbUNL9uI/2VITc2w+pZ/sTY8=;
        b=UAD4JvnNz2RvR/guI3fjtMVZBmfC/1M7G36bKLwkq+sbf+SfQD4meIgEdZAOwqBjOt
         3ZYNz+NIo00LgpbTOejB6KSGVlpafFL78aoxPoWnMFuVL0fC84dCxtTxIGjwYIdH2kRR
         mXMIa+4kQgana4VxPLMkgKyBr+z/KT6sp8AsPZ048VkdveyfIBtFfOf7yvn4Kji5m8N9
         eqCXBB4dVJwIY6+0I4roUK7EGTYD3sL5BJJfS1pkYGQQFPgYjNzDsSCaJ1bK4zlEilwu
         FqCU1w8iMztDFNyO1XguYaWm9ZKHnyyQRxKLMq9swJr4HOsg/pQtwnzWtOvOKNOd4Ffo
         Dr4w==
X-Gm-Message-State: AOJu0YwWEYdIFcDBFxwC7HyNVTGRfswn7NDHbfGdHQtorfIdadGR+IIM
	bBYqReREhVP/un93gKSS48TkS4GRWzVTC1KsVWNxJwqR/JazXVIJ/dW9Ug==
X-Google-Smtp-Source: AGHT+IFhLsnl4yrwk6Ob1Z+sEeRfKZpNO+JcMKPyOHpPOxBTl6viQhSMzrJe81zdaIdssvEubDYptA==
X-Received: by 2002:a25:e047:0:b0:df4:ab4d:2c6c with SMTP id 3f1490d57ef6-df4e0a892e5mr463929276.6.1716331985884;
        Tue, 21 May 2024 15:53:05 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1437:59a6:29be:9221])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd385be51sm5584956276.54.2024.05.21.15.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 15:53:05 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v4 4/7] bpf: export bpf_link_inc_not_zero.
Date: Tue, 21 May 2024 15:51:18 -0700
Message-Id: <20240521225121.770930-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521225121.770930-1-thinker.li@gmail.com>
References: <20240521225121.770930-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_link_inc_not_zero() will be used by kernel modules.  We will use it in
bpf_testmod.c later.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h  | 6 ++++++
 kernel/bpf/syscall.c | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5f7496ef8b7c..6b592094f9b4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2351,6 +2351,7 @@ int bpf_link_prime(struct bpf_link *link, struct bpf_link_primer *primer);
 int bpf_link_settle(struct bpf_link_primer *primer);
 void bpf_link_cleanup(struct bpf_link_primer *primer);
 void bpf_link_inc(struct bpf_link *link);
+struct bpf_link *bpf_link_inc_not_zero(struct bpf_link *link);
 void bpf_link_put(struct bpf_link *link);
 int bpf_link_new_fd(struct bpf_link *link);
 struct bpf_link *bpf_link_get_from_fd(u32 ufd);
@@ -2722,6 +2723,11 @@ static inline void bpf_link_inc(struct bpf_link *link)
 {
 }
 
+static inline struct bpf_link *bpf_link_inc_not_zero(struct bpf_link *link)
+{
+	return NULL;
+}
+
 static inline void bpf_link_put(struct bpf_link *link)
 {
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ad4f81ed27f0..31fabe26371d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5422,10 +5422,11 @@ static int link_detach(union bpf_attr *attr)
 	return ret;
 }
 
-static struct bpf_link *bpf_link_inc_not_zero(struct bpf_link *link)
+struct bpf_link *bpf_link_inc_not_zero(struct bpf_link *link)
 {
 	return atomic64_fetch_add_unless(&link->refcnt, 1, 0) ? link : ERR_PTR(-ENOENT);
 }
+EXPORT_SYMBOL(bpf_link_inc_not_zero);
 
 struct bpf_link *bpf_link_by_id(u32 id)
 {
-- 
2.34.1


