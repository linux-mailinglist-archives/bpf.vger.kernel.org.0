Return-Path: <bpf+bounces-58502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF01ABC883
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 22:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567C11B64926
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 20:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E3F2192F3;
	Mon, 19 May 2025 20:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeaYyk82"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D52A1991CD;
	Mon, 19 May 2025 20:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747687012; cv=none; b=mYUu91lWhZIHqKrfzv1eitBkS7wbuyGfV+Z/cM840MrcW7/h+trwOyljAnP8FQD2WekwLChc3P6zQNSMriqvPi6nXHJ5/EMJJjo/JIcAr5AGiirREC8U5GcAqv5RbYpBVUS1pyUz67JE98odhQ3oZLVnGvbISTM7aI5Z5MDbv0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747687012; c=relaxed/simple;
	bh=oVWSANjaD+3cXUkEaHpJR1vdRfE+V9N0nGA4zTtD9Jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fYOoUxZ78jbIIMAJmbZRZbxIQjSClBoAjkU4LhUB9vkAaiUHcV1+31xBZazjvjwiSlhfoPWenac6VavlsS3mu6t2S3FTzfZsfHElCkC/6GAyC1GiyDnCGs4hLwbj/lP5rHn7UC8ntpoFnTgS9eY20YoKIOkk2QBavJO51HUVKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeaYyk82; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c27df0daso1825444b3a.1;
        Mon, 19 May 2025 13:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747687010; x=1748291810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MEpgsPi5ovbiR+UJNKdDOffGvm/L4xnAp6SSXe5JvQ=;
        b=BeaYyk82FYgZiYKAuscZBC0VMz4zPC0G3vkNJ5cI9PHfhs+z43boRd4+DdAK8eaxwK
         BTFPkbgqqkS6KouifuqvJwFBkTeVLDbBgsB7oPlcPSafIrQHjfGjazhkCp7S7lh3Ln44
         P7mTYUCPKiYucyZ/8OGGbc6kiuj1KhW7HGG0KlJo/Bm8JLj64IrwxCXi9B94xHdwVqSp
         NxNDAvR/Z/EFbjWpTpbtOspcuUokNqyLp4gjKoM+rpU9Pn0OB2VpjfAeloOqTZpBQxxx
         D2qTyA8pWoVqA018OpmOLPOWtkXgy3QWUYjDMzc87NkDzBil4FySEC0hKbqlJ8DrTru4
         JeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747687010; x=1748291810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MEpgsPi5ovbiR+UJNKdDOffGvm/L4xnAp6SSXe5JvQ=;
        b=XlZgaNLD9rZK/QbYN7yYzOTa4mUXSAJhLX70h1nYX8m8W7/oBok6OBL6ad2uhTspeB
         7P/tyQzcrKgM9l73I2AVOfbFSm2m3PrQHEPVkdSDGcQAVeVpp+yks2cWj15HE3d3Dp86
         RiIOho/l+ADCVEq5+qjtwxfFJLSCfCc3OzDRmJgQ6xhzhdbZE1w4TFoGVqCIqfdPW09e
         XLYGQnR4bfH/0oyN8/Zkt1sPNDpb+fx9kodi0fnvq1SMJ9crxYRbI7Fxx5ssRf2fkIAt
         7vLp8PYUVG63tRfvtwXAmZOmYypLrwWTOjmx0GXzoMXCMKXFJFJhlLiqcU0UMyWqB55+
         H7jg==
X-Gm-Message-State: AOJu0YxgQUDAy29bBu0MEhkIza8X8akFSgJ4cY+V5V2a5gIXs4xvVdd4
	+3ge3MWEmrYGgSNZ5CdWKTz1QIltMkBVMngl4MQBczopyt/wvxkWiavr3+5QBQ==
X-Gm-Gg: ASbGncuUb4eZ0q7o941xnhNzEpQmojpqIOfVSdpiL9A1v2idKRQLOutq8VlDQKD8k3S
	hwdBknQU6rdHswz9s/g8Mi6O3i7kKGG/kbIqzUbJ0AxgVuzz/v4OF7KEdYF/cgQfLQ3atqAD2HW
	YKGEukTvf3A4A6vYIbsW/F8zueqiJHfoCIzrlh3pdZ0VCDfiDtN/97hQZr2dlAqdEtjiatmQqzK
	RJ/H9hmZbtRsCRqCXaUTlmK09Zm+c0/pcY5V+pB23EGhxzB9i6Q/+bVw6c+f6Rl03hcetnmASx7
	rJEzFSyjwd1o5NK9AmTZ1sPSVmOuRSJpjUCtYQcCzD6ZCOFQzDeSVntIN6InggTa0i488VPh
X-Google-Smtp-Source: AGHT+IFeqDLSLMdbKxW0cTcgOny7vqSPIwg1gi/RKWIPoafalRyvOocBVAdcJvlKOmGdyehbaimfKQ==
X-Received: by 2002:a05:6a21:9188:b0:1f5:8754:324d with SMTP id adf61e73a8af0-21621875a26mr19727801637.9.1747687009825;
        Mon, 19 May 2025 13:36:49 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970d5aasm6865112b3a.63.2025.05.19.13.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 13:36:49 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	zhoufeng.zf@bytedance.com,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	zijianzhang@bytedance.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v3 1/4] skmsg: rename sk_msg_alloc() to sk_msg_expand()
Date: Mon, 19 May 2025 13:36:25 -0700
Message-Id: <20250519203628.203596-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519203628.203596-1-xiyou.wangcong@gmail.com>
References: <20250519203628.203596-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

The name sk_msg_alloc is misleading, that function does not allocate
sk_msg at all, it simply refills sock page frags. Rename it to
sk_msg_expand() to better reflect what it actually does.

Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 include/linux/skmsg.h | 4 ++--
 net/core/skmsg.c      | 6 +++---
 net/ipv4/tcp_bpf.c    | 2 +-
 net/tls/tls_sw.c      | 6 +++---
 net/xfrm/espintcp.c   | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 0b9095a281b8..d6f0a8cd73c4 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -121,8 +121,8 @@ struct sk_psock {
 	struct rcu_work			rwork;
 };
 
-int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
-		 int elem_first_coalesce);
+int sk_msg_expand(struct sock *sk, struct sk_msg *msg, int len,
+		  int elem_first_coalesce);
 int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
 		 u32 off, u32 len);
 void sk_msg_trim(struct sock *sk, struct sk_msg *msg, int len);
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 276934673066..8e85f4a3406e 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -24,8 +24,8 @@ static bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
 	return false;
 }
 
-int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
-		 int elem_first_coalesce)
+int sk_msg_expand(struct sock *sk, struct sk_msg *msg, int len,
+		  int elem_first_coalesce)
 {
 	struct page_frag *pfrag = sk_page_frag(sk);
 	u32 osize = msg->sg.size;
@@ -82,7 +82,7 @@ int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
 	sk_msg_trim(sk, msg, osize);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(sk_msg_alloc);
+EXPORT_SYMBOL_GPL(sk_msg_expand);
 
 int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
 		 u32 off, u32 len)
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index ba581785adb4..85b64ffc20c6 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -530,7 +530,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		}
 
 		osize = msg_tx->sg.size;
-		err = sk_msg_alloc(sk, msg_tx, msg_tx->sg.size + copy, msg_tx->sg.end - 1);
+		err = sk_msg_expand(sk, msg_tx, msg_tx->sg.size + copy, msg_tx->sg.end - 1);
 		if (err) {
 			if (err != -ENOSPC)
 				goto wait_for_memory;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index fc88e34b7f33..1e8d7fc179a8 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -324,7 +324,7 @@ static int tls_alloc_encrypted_msg(struct sock *sk, int len)
 	struct tls_rec *rec = ctx->open_rec;
 	struct sk_msg *msg_en = &rec->msg_encrypted;
 
-	return sk_msg_alloc(sk, msg_en, len, 0);
+	return sk_msg_expand(sk, msg_en, len, 0);
 }
 
 static int tls_clone_plaintext_msg(struct sock *sk, int required)
@@ -619,8 +619,8 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 	new = tls_get_rec(sk);
 	if (!new)
 		return -ENOMEM;
-	ret = sk_msg_alloc(sk, &new->msg_encrypted, msg_opl->sg.size +
-			   tx_overhead_size, 0);
+	ret = sk_msg_expand(sk, &new->msg_encrypted, msg_opl->sg.size +
+			    tx_overhead_size, 0);
 	if (ret < 0) {
 		tls_free_rec(sk, new);
 		return ret;
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index fe82e2d07300..4fd03edb4497 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -351,7 +351,7 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	sk_msg_init(&emsg->skmsg);
 	while (1) {
 		/* only -ENOMEM is possible since we don't coalesce */
-		err = sk_msg_alloc(sk, &emsg->skmsg, msglen, 0);
+		err = sk_msg_expand(sk, &emsg->skmsg, msglen, 0);
 		if (!err)
 			break;
 
-- 
2.34.1


