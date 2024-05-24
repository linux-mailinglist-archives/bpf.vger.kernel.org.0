Return-Path: <bpf+bounces-30541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9F78CEC6C
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 00:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF24B21B93
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 22:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B34811FF;
	Fri, 24 May 2024 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwDKdfuD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A419D128808
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716589847; cv=none; b=jp/FDsaq7VcNOtBBf6LLZiLjhtVZI+2quPv/Uc8iBrmnq8A8P6BKTc41SinmrCbN46nShGtILkyRgiOlYan/EKuEgHiDJEfktIqttxBSrYR1rDL8DjQJ3tkkAr/t7QSO5IhDClQ2E9t8V3IYR65qLogJLyfa2m+FMoEpLmVEQms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716589847; c=relaxed/simple;
	bh=pqzVqwQ++8qd6amXfFidlSgABpQlHOg/9TLDkfHrsJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfZfkvXPVDwMTqKFqulVA+evrNhXkTodtQXFaC9XJuqdn5MmsmLjqc5SmwEVDq/2bDj+ApNqUDvmRLsnNQSkb5Mg9BMxDFLjz4qigpP4e5T+XSktSoUEczNDfdsOv/nuk/E1V7ft5hh8pNT6Zhhg2CtiJnrs8Yp8kAqczisVbnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwDKdfuD; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-62a0849f8e5so13785827b3.2
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 15:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716589844; x=1717194644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=404ZgiGbr0O6+NfupkiGmQYModIgXFWM0DgrDzRNv/s=;
        b=iwDKdfuDJ3xAOEtYLmwMdFYHkrK+cCiOdHdMSPh418JbT0/wEFWyB9bgWyaQbb03HG
         uaaiecYzsr5dw6lwq+LbErnAAkiw+fqLK2CI0TbhfSHDDObw402S4m+huXXLPFE69jBX
         imGGqIFvZMA3MoZUbjZTXps6q94Ew9DLQ0ALdre4DoYYhhWYn2Lba7Rwld4gS1g/MITr
         ctkBJLSpq10JDA4rAQh7gpTMqb+MMCbOazwg7hU6UgXW4KZs2xxBIVm1YhPBEGRZj9OT
         kShtkyc1fbiW3rC5YO/0pSf1GdekVcSPoGN+O69PqQ4ZcHOOnm0FL0gcOC9vorC+RmjO
         hhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716589844; x=1717194644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=404ZgiGbr0O6+NfupkiGmQYModIgXFWM0DgrDzRNv/s=;
        b=Gp3w1yUsYjLHhJ9h0c5iNPFq6X6EIA/SVycQjRIGD60ABui4KVujxw0saNXq7Wb23B
         QZluFajsv3KRyW4IycPVoIVLqdBhzTFK702tjrgoZmR8W7eLggiSin3Z2iarqChPseHH
         O+KzJmzdOAmKNyJT+oWB8DJbgmVrkzfuVAasU0x7yQ8RQyPHBsJEKqYVbzKqpRZYCXio
         nflmMHFJO7dSwZm0HXqG//OxTnSuRuIe2JhUVEFSKKB2eMwXYDpgcRfr8t8BkUlcmlXq
         gBhfxkvcyogJVWmW9DM64OlCudlzZjGRkhP9Zf9FeD3vDXJhyILe12t+2bLoYShzL3bn
         ZWJA==
X-Gm-Message-State: AOJu0YxExqJJNMZPTbWqe8yakmG44EJpem6+mqISHjsjqpvbIPZifpcW
	J8WRIgVrO5QDvLi3T+deTzbYwWiy7tTTQuHlMJplCl7yQv7uZ4Jzjx35LA==
X-Google-Smtp-Source: AGHT+IGzUxGG+1n1fAaspOGsrVwE9by+wFZgf2otRFq0eaBHB48WcLUM5HEti342e8/x7wtzAzT1Hw==
X-Received: by 2002:a0d:dfc8:0:b0:615:225e:ac13 with SMTP id 00721157ae682-62a08d8735amr38121407b3.18.1716589844381;
        Fri, 24 May 2024 15:30:44 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6aeb:e91b:f49d:e77d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a3bfa19sm4169987b3.44.2024.05.24.15.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 15:30:44 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 4/8] bpf: export bpf_link_inc_not_zero.
Date: Fri, 24 May 2024 15:30:32 -0700
Message-Id: <20240524223036.318800-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524223036.318800-1-thinker.li@gmail.com>
References: <20240524223036.318800-1-thinker.li@gmail.com>
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
index 741f91153fe6..0d59de63540d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5432,10 +5432,11 @@ static int link_detach(union bpf_attr *attr)
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


