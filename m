Return-Path: <bpf+bounces-55567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9E1A82E8C
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 20:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 385A47A8A61
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BF0278149;
	Wed,  9 Apr 2025 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="WstELgZ0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB9E276030
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744222968; cv=none; b=Qigm/5adg5KHIOzHlFFjZxB9u1C55Z430oXXjGHTyPk52GwMzfwVk+Askl9i28xNKLbj7jinajs2n3jgLBf3O74QJSESyJEp53/Ktw2VbHxIL06uPwljmeyELlTVGOCT71hMWoUV9095yfR2x5z1H9hfOtEPOHrZuhvJTk2qS0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744222968; c=relaxed/simple;
	bh=JAO8+G3HphwkOY+iqqSe3ukkWPpaXH8YJAO42Y9xFhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9PQgyq+OG8zk9qUqTgHQN9tQQslWqbzPwkX978zJ18LYI1bI54OiBa3YgzCDzUzFuleqb7siTYlPJIWwU7Z+f+WoqAhimHEE9YmpZ5ehGml5iWWb8393WRbXshuOWXcI0weEcc9ciCX1m4nylW/FMxYPzCh5bBpAFnERWeAET0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=WstELgZ0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7390294782bso1217479b3a.0
        for <bpf@vger.kernel.org>; Wed, 09 Apr 2025 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744222966; x=1744827766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68vcx7Bw67jxBeayoI9I9qADf7d6VxnZrSqJdxToVFs=;
        b=WstELgZ0CAJh/wQGUDcGyboizQtCyKtIy+JDvXN1H5CPMdBRzLiEwBnNjHaaDFR/7W
         xGiwuXvq9IciKQ2px7BdbReZlEYcJC6p1VGBxFPN9T7oUDbjAIzG+ioxmqzPu5zHlYGG
         Sg1NV/m/aqLhHTj8NdUZoXMr9C9GJcccUV1JCe7BpZwPOCbtR7faY14ZevuwBI0X6Ykw
         vGcBObPlT3d27yGUl1tP3r9NUqc6L4S6UQnzhq320g2VQU0kGLmVhTcndWJfCf5UCI3E
         CdtLRyfYguoIFUjiGb8r8g5tGdJL9Zu42S1vYgBy7huyHGI6sBD3MbFH+8AkWCCGCNyx
         1VHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744222966; x=1744827766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68vcx7Bw67jxBeayoI9I9qADf7d6VxnZrSqJdxToVFs=;
        b=Vw2ONskY6B4A3Sa9DM/lHFCH5JoNJYYf+95KuSqBZ5jZUav/6xWiWcvtr+cy9Blh36
         DhwzgIIRhzWuT8MkhtdZDWGQCECLR+zQ1tAVhOW2fiquM/Zv76r+2wc53RNwJzsIzbaQ
         AjZ/8hPu7l9Dp9mrYA0rtauiPfWgBXOR5KI8Zb/MQIKKYByJfDHMV1wH9fByrh0/qaTz
         Lzxz7e3+38ppJ0e1NZEho3vaZHhRMRssukOzj4qKtOZW+EtyVilfz0KVTJ7NrnuzhOcB
         VJ23t17CLmBhtU9p38ehZ+Bgd3ckoJFgyhP2i/ExHyrCbal9JdJTIjfHAQMwqkLN2CDz
         xuDg==
X-Forwarded-Encrypted: i=1; AJvYcCVuPdWhvPbc1a74h4lspgJMowDMLMK4AGlKLNsfCmEjwuQBsWaTIehnbzPgcw0GpsIumgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJKDef42bIspY43gZDWWPjwxq3lTZSKiVUNgpcIrhcyQHvT13E
	fP0nf3hcbKtwUiSiHVeb7slHDGKCr1jEed9ntHiX0KRW6mD9hP+t35gTruCveak=
X-Gm-Gg: ASbGnctL5hBuj2Zxpy2D23tzQ/cSNmQlbQ2A3pCO+d0RGLx+qEnnKPSSPSpeGqVsskH
	qdXLvy8qyT2sapcooExj2d50nNku5CK966Gzz/OZW5M2sCF2juH7YxxMmULKHx4NWRcwGfWON8m
	eisnmUjVKAF21BeHAOiA4Cp1MmMnab3/cnqoJaRQoF+4UuqHNmgigO2hon03TMzDxW8AiYUJyEn
	k1Gf4LlRzoy96ftUOPzWXyKRAKAT6k2CEANqhtKtxLU2brAqbPOHzmx+zMih6c6eyW20+6+ZK0s
	Tqv4f8SmZ/vIa4X2v4snzIGebyYkyl6lXmaG/6cX
X-Google-Smtp-Source: AGHT+IFybk8OdTnLHPlMB6aOkmAK2JetcmLdU041qlRpNVFo6uvs8RWdiyb6MlHvRgMZg5/VqogSYg==
X-Received: by 2002:a05:6a00:1309:b0:736:355b:5df6 with SMTP id d2e1a72fcca58-73bafd6d4aemr1415683b3a.6.1744222965355;
        Wed, 09 Apr 2025 11:22:45 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:2f6b:1a9a:d8b7:a414])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d2ae5fsm1673021b3a.20.2025.04.09.11.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:22:45 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v1 bpf-next 3/5] bpf: udp: Propagate ENOMEM up from bpf_iter_udp_batch
Date: Wed,  9 Apr 2025 11:22:32 -0700
Message-ID: <20250409182237.441532-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409182237.441532-1-jordan@jrife.io>
References: <20250409182237.441532-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop iteration if the current bucket can't be contained in a single
batch to avoid choosing between skipping or repeating sockets. In cases
where none of the saved cookies can be found in the current bucket and
the batch isn't big enough to contain all the sockets in the bucket,
there are really only two choices, neither of which is desirable:

1. Start from the beginning, assuming we haven't seen any sockets in the
   current bucket, in which case we might repeat a socket we've already
   seen.
2. Go to the next bucket to avoid repeating a socket we may have already
   seen, in which case we may accidentally skip a socket that we didn't
   yet visit.

To avoid this tradeoff, enforce the invariant that the batch always
contains a full snapshot of the bucket from last time by returning
-ENOMEM if bpf_iter_udp_realloc_batch() can't grab enough memory to fit
all sockets in the current bucket.

To test this code path, I forced bpf_iter_udp_realloc_batch() to return
-ENOMEM when called from within bpf_iter_udp_batch() and observed that
read() fails in userspace with errno set to ENOMEM. Otherwise, it's a
bit hard to test this scenario.

Link: https://lore.kernel.org/bpf/CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com/

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/ipv4/udp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f6a579d61717..de58dae6ff3c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3429,6 +3429,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	bool resized = false;
 	int resume_bucket;
 	struct sock *sk;
+	int err = 0;
 
 	resume_bucket = state->bucket;
 
@@ -3503,7 +3504,11 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		iter->st_bucket_done = true;
 		goto done;
 	}
-	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
+	if (!resized) {
+		err = bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2);
+		if (err)
+			return ERR_PTR(err);
+
 		resized = true;
 		/* After allocating a larger batch, retry one more time to grab
 		 * the whole bucket.
-- 
2.43.0


