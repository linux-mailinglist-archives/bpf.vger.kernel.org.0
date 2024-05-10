Return-Path: <bpf+bounces-29416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BAF8C1BC2
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E8E1C21B52
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E3253811;
	Fri, 10 May 2024 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOd2H/ZB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1C1535BA
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300992; cv=none; b=jTLzJfReyVKfw0p0qCsJzMeZQ8UCjGQ0vNAcK5E0WI5eDlm/hUBTYz7CDQlXP8JOAr8J2zIuJD00nJ2f0Vy6ygbTXEnC8wIQWK8ny5uraYtWXv2l3wdlnXjbTtl9c1FwLcA7W5kbVAD2iLKNkeu5kZqz8LsVsAuHVvht1IlZuyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300992; c=relaxed/simple;
	bh=34VL9O4NDfy7Ojt5kCpX/zgfJ2l99XUzUsH5/dLKqgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NvyBX4rpT6TTEmf69KBdaddVwK1azsCA1iuhKkf8We2iTEY3/rI/E8GRjO0lDss9uOM6cDS6EmDOIJYIgGlKvi+SREaIz2fbUpg2yE6ZZ2pzbZ11MWFGBCAjxe9tFglaSKWW56CDVyl6un+nyv8ljY+9ssx5hjMikP/36j9ZiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOd2H/ZB; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c9881d07fdso890579b6e.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715300989; x=1715905789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXM2QFy+xceW32g6/wIpbUNL9uI/2VITc2w+pZ/sTY8=;
        b=WOd2H/ZBF2oFyReHyEfbla8AWgAbLdbdOVfcb7HLCm1Yf6f0wRX6NNNs7+W12yOA0V
         fvAtfju7C2hSXBfYkf4fejwHZ4aFHPpUqcZTtTLXnpaQ7gh9dJKAE90Uxk/v5xY6GEXp
         XJpfkCwxfRckVufJ/2eVA/VkKx4maSANrcutbdOXVUQa7cMDWnHgTfqyjcduuMwbBLKO
         INYi+jlLMOyQxL3L38AXWmymyfQ3LdZ4ANLF90SskmO5FbplqajuYXP7bUQE9efCg9Ws
         /YYEIQIG3qtrKuXOrMsehJ3kNihNsAWJHKZClRL0C0zU6zOw/FWkrTHJPm20yMddm817
         p6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715300989; x=1715905789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXM2QFy+xceW32g6/wIpbUNL9uI/2VITc2w+pZ/sTY8=;
        b=J64t8Y3OyY6j+5CXCmdiDs828CxXFCG1LtiWcptVn/1xRvrKc1HgdJKXc/G3Kn6nMX
         A5j9Vr2ddYncwY8bSFZbgCEym1xucLkQgev1PUHUn4/zymLDt/+VVDFXYked/uIvDMll
         pnqK0wn/2DEiQqXXgD6EFGVQl8AfJ3RsRc+BMbruNx7/9gAviEtStt1imNGXcy0pQJra
         GQBIfE46wNbsCmVAiPtapVtE5V/Fru4QjqZsYgSACFh9nY2urwkTHaMaafmVsEANiM87
         BxtBk6/Mv5D3EaG+r4Xul0rMK1s3wLBH+7FaIn5k6Uh8huzztbjBlY5ZrMLOnrX3Y3Js
         h67A==
X-Gm-Message-State: AOJu0YwvB2HGv5O3iGsiSMnh50MuyvszbJtWS16l6lAlkYhA+J25fAzT
	9bcqaGmLhUhpnMJzdwS2PPpfSSIc57p+cnSSDT61WeqUkTGeQNA7j2wixQ==
X-Google-Smtp-Source: AGHT+IEVEameRzuB1MzpXOdi2QGSKTBXT0dcM3QHHfNRee2xereXzE7WoVuuN7Q+yuegUZ27yI5qMg==
X-Received: by 2002:a05:6808:4185:b0:3c9:6e10:ab35 with SMTP id 5614622812f47-3c9971f9993mr1122949b6e.58.1715300989540;
        Thu, 09 May 2024 17:29:49 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c98fc7e00bsm433251b6e.4.2024.05.09.17.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 17:29:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 4/7] bpf: export bpf_link_inc_not_zero.
Date: Thu,  9 May 2024 17:29:39 -0700
Message-Id: <20240510002942.1253354-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510002942.1253354-1-thinker.li@gmail.com>
References: <20240510002942.1253354-1-thinker.li@gmail.com>
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


