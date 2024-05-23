Return-Path: <bpf+bounces-30441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C328CDD22
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 01:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8326B285732
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 23:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9484512880A;
	Thu, 23 May 2024 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2dRbAB4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A08128814
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716505741; cv=none; b=HB0/0RA0DMFfUid8fj0SWtrwuW9iZlL+PO7So1ZXNWqaXv3aNILBlscNeQFedV9oo+Xdjf7KuHQ6YeOU2lSTLaJcJ/zVK+niOAHJqxf3P6CcRe23HivZf9KaPUWQKzjQI/EFHjOy0fTzgRzXUWdCL/49sTZ2r6RaRirQVOWB6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716505741; c=relaxed/simple;
	bh=pqzVqwQ++8qd6amXfFidlSgABpQlHOg/9TLDkfHrsJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FIJ4QlD/nStaTnA4jTF6d/uOCzipIhOJ1P4rvBEohaTQrTnIPKKDgYPF31Mh4mJ1SbCVNvwXmXICLVVSxLYHG5CNmG9T9cRxQ0+ISDWG5GF612kbelH1ckisWp1KQIf59VvCmRcH13lEcciR3owI4fnfCl/29lbe9a/lNvW2p8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2dRbAB4; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-62a08438b9aso3018627b3.3
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 16:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716505738; x=1717110538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=404ZgiGbr0O6+NfupkiGmQYModIgXFWM0DgrDzRNv/s=;
        b=E2dRbAB4wSAfcV5XvhELmHr28K9R2ASyDUppGMf5U55a+LKGbOeNIox83tMZR5C3mW
         6+Jo14iTCk9xZsaEuB9skxp6Fa7Cy+X46RHHwqbNwhvbjDMPHI8MRpjiAEoKqr/wSKoO
         ecZf42qR5FW1YVIyczvjPrI50CMZKf4Mq5/rzEuLt9ZnQ1vykLnhONAMSdGwHQgLoFuY
         z6UldOyzFJoRZ7rzJWJBePTj8S5JwV+WZ9QshFzbnj8tFZzZEzY76AB+5LZJDXh7Po3W
         AucdM5ocLIMe7YLs6KZiji8Revna69tLFEwjr41pFUsr3iQWT7pfY3vdsx1Bid6tMvlr
         vBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716505738; x=1717110538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=404ZgiGbr0O6+NfupkiGmQYModIgXFWM0DgrDzRNv/s=;
        b=wjNx0zsglJA9yT01w2G1M1ql0hPYDHOo6lO6JKa/wKHznBy1XBgJGPFfDSfrvl8Blh
         8UILRemhH0wcq5XYMx6YxlwEEvJ5naeEQSjPUfGd1mWBlFWt2gwwxISS2QdlOKef+Rcp
         MaJru8rLuGWQE7NDp7SuR+Ezi7khUwPDrjCQ9b0EGba7wVT4EowLbCBSZGU9NFvSjKAQ
         ZbJIGozXozEEVQutbMmBXj5emLFH3iquSL+EMA0stUhhT7jVydkn7+eqWD3OygBvQj+5
         PMCgqwKk1vX8h1jWkURI09mi2QTu92icwu+nraIQpKVahCoLyseSTyAmqe+Y6jjBF+V+
         s5zg==
X-Gm-Message-State: AOJu0Ywe1j96sSoRH7KbVMhqKLMNqjucl3zr7pVy79NZUxNGv8em14NL
	z45x1n9gCDb8PcmKJH+Zz0DGt9CRljE9uVURZv9cgx/a0ur3SN2e4FhvAA==
X-Google-Smtp-Source: AGHT+IF9opjUd69Ht69YX4u+TSBz8WsRmnubiOtF5ZEPjbrhEvEJ9jMRRzRRPWBl+pQDB9asFZh6RA==
X-Received: by 2002:a0d:e883:0:b0:615:4653:1c11 with SMTP id 00721157ae682-62a08d9544emr6136667b3.12.1716505737075;
        Thu, 23 May 2024 16:08:57 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b7f1:1457:70d4:ab6c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a37d5d0sm474087b3.16.2024.05.23.16.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:08:56 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 4/8] bpf: export bpf_link_inc_not_zero.
Date: Thu, 23 May 2024 16:08:44 -0700
Message-Id: <20240523230848.2022072-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523230848.2022072-1-thinker.li@gmail.com>
References: <20240523230848.2022072-1-thinker.li@gmail.com>
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


