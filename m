Return-Path: <bpf+bounces-69953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A50E0BA97D5
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 16:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5320616A53B
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BFF309DCF;
	Mon, 29 Sep 2025 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UZhiI78i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C17D3064AA
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154964; cv=none; b=VhJPbPMCjPHii9KG0E7wdcIy9Lq66jCmh+yZ7RoRwnZbe5HqZF9+YVL22oys9CJZ60ilDprDzY+2lX0E9PjTQDK/pk1cqhNV1T7tNnFhNJVVj9o/1rBRIaoyI9vYHt1UfUzoL2xvlBzlrYx86LFBSPPI7vnZIWWAk50mfqsTciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154964; c=relaxed/simple;
	bh=b+r8GilGqrGu4YUtulWgCPKpjDIlXpmUjP6hTfknSog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TEyfXVTFQLubE5DiAPdXbolawCDEcCmJvK2JV/v4AVRCZNurocVnN4tbbrQqPfVWmDBdQjE0KKhnucIrhMqgCcEaV6umFjoZ5CN/RsicOChvZ/3NEtxCYsb/kYgiiIPj1R0gaqCQk+Ev1RZdMlhLZ113b9AXBd6A9/oDDFRZRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UZhiI78i; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fca216e4aso1347859a12.0
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154961; x=1759759761; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PdczIob3dePKxvyvAYTgj30vryGl7GoxlZy/f11n2Ww=;
        b=UZhiI78i/oQEKzMl5DrljjeMMqfksD3C2vQtklTH1Jp8guA+LP2JsuJY9pR5tyVpr4
         r/eokPrFLHGua7vmcs2JNMLyr0IJbMfKfcLBqrBA8z5X8PASPrZJlCZAp5ba3Kwvl0oq
         ov1HZbXXJ9v6b/IgOndJETW0m2fd03T5MRPZih/VGRGzn+o85erh5SXZIPouio2CNXk+
         Yc2YD+fz0Pf9nfWfw8T15iWurtoK17asxIpoaZ0eHIOPpx0i/+RNPngzS/vlXp0yawao
         inU2l3tA+nAC0Bg3zq7Ilb9GLGGXJa8Qh76+hnYrVs+DxfXv4R/DIRmjjZxso736HJ6i
         yd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154961; x=1759759761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdczIob3dePKxvyvAYTgj30vryGl7GoxlZy/f11n2Ww=;
        b=eofHvuQbfLcRxdUh9Mj4feuS5FMIPIFJBK5UWuxjikkLMIQ7GomwT9shi/MrBNRRgJ
         7o1mG+vJi/+UwwIc+qguvMpiaAghi9/Tbd4kXHYi6M5T8eoK2kRFeNQzZq5ki9mE/Qk4
         0gecEHrGv4oAL4Xm3imDE65QX5opjvyHdnYPg/CdNzef2uY8GBZj9/4PB6wl9jjVSoLL
         4LtVeHkNIaC92kjODiwbtXVCLw0Uqow/gTif6g0c8spv35Y555VgpFsOVW65R5q3+WH/
         iB+Qew/4nBFB/vhZ6E0qvgEeFgme8ItnBco07sOKp8WooTTJ7XQt43F8fhplVlIhd8Jb
         yw2Q==
X-Gm-Message-State: AOJu0YyW4AiX/FakzWDZ8+q/FtL6uIe2QjDcKienYuqRq7okuhEqBXBN
	Q2XeRJTgOwGOulQ+MAAZVSx6UV/7WnIrpnb6gq1jFVlqexj5QzCguHU2J8PUE1K15DAQUdNdABH
	9zTKR
X-Gm-Gg: ASbGncspxDDZ4MEJiUGdKDuayjkofxnCHIzwe40Qfzf/idApNsTN8v3doDDMQKKngCz
	O11H78N542ON6iSA5HRPFk2T6zD8N/o9HJOsHXjuxz3dIUmYugHbS8JMbhuDyKyYQ/jCHIozhJr
	HIxjdAq+xU8Aq1q+qlnTbLuCYpv88b6u+KMBtNtNeCYmLlTbPw+Mjp5s4lU7heDyx1XaGlMIrfb
	kGTSBMraillVmT0UJpwU45bRf1snbMILJqjh0mZEVKwYXQdGxYURhhJbyKxcF0BnnJX/GWmv008
	hIMoGMqq2nST/4XYvM5jxVs05uznfgasXbhrc1C0IU/smgArNJ2d/PDPtHyB9/PgZy4Peohznlk
	Q7VGHt8vdlqnu3uuUnuHr+BxFJ4j0j3PigzhVuHuH5fhdqbUydN/eH6eXsRLLLckMi95kX43HYr
	FNEIkhtyXdsDaEIXNP
X-Google-Smtp-Source: AGHT+IFn0p2Y3H/fjT7ex9aHKbC25wWninqvM/E69Bk41VpuM+yxIw4v7oHwZ84XmpMSvBP15l6bgA==
X-Received: by 2002:aa7:db47:0:b0:634:b5a7:3cf with SMTP id 4fb4d7f45d1cf-6365af2b6e7mr510906a12.15.1759154961224;
        Mon, 29 Sep 2025 07:09:21 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae321csm8076524a12.24.2025.09.29.07.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:19 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 29 Sep 2025 16:09:07 +0200
Subject: [PATCH RFC bpf-next 2/9] net: Helper to move packet data and
 metadata after skb_push/pull
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-skb-meta-rx-path-v1-2-de700a7ab1cb@cloudflare.com>
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
In-Reply-To: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Lay groundwork for fixing BPF helpers available to TC(X) programs.

When skb_push() or skb_pull() is called in a TC(X) ingress BPF program, the
skb metadata must be kept in front of the MAC header. Otherwise, BPF
programs using the __sk_buff->data_meta pseudo-pointer lose access to it.

Introduce a helper that moves both metadata and a specified number of
packet data bytes together, suitable as a drop-in replacement for
memmove().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skbuff.h | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index fa633657e4c0..d32b62ab9f31 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4514,6 +4514,80 @@ static inline void skb_metadata_clear(struct sk_buff *skb)
 	skb_metadata_set(skb, 0);
 }
 
+/**
+ * skb_data_move - Move packet data and metadata after skb_push() or skb_pull().
+ * @skb: packet to operate on
+ * @len: number of bytes pushed or pulled from &sk_buff->data
+ * @n: number of bytes to memmove() from pre-push/pull &sk_buff->data
+ *
+ * Moves both packet data (@n bytes) and metadata. Assumes metadata is located
+ * immediately before &sk_buff->data prior to the push/pull, and that sufficient
+ * headroom exists to hold it after an skb_push(). Otherwise, metadata is
+ * cleared and a one-time warning is issued.
+ *
+ * Use skb_postpull_data_move() or skb_postpush_data_move() instead of calling
+ * this helper directly.
+ */
+static inline void skb_data_move(struct sk_buff *skb, const int len,
+				 const unsigned int n)
+{
+	const u8 meta_len = skb_metadata_len(skb);
+	u8 *meta, *meta_end;
+
+	if (!len || (!n && !meta_len))
+		return;
+
+	if (!meta_len)
+		goto no_metadata;
+
+	meta_end = skb_metadata_end(skb);
+	meta = meta_end - meta_len;
+
+	if (WARN_ON_ONCE(meta_end + len != skb->data ||
+			 meta + len < skb->head)) {
+		skb_metadata_clear(skb);
+		goto no_metadata;
+	}
+
+	memmove(meta + len, meta, meta_len + n);
+	return;
+
+no_metadata:
+	memmove(skb->data, skb->data - len, n);
+}
+
+/**
+ * skb_postpull_data_move - Move packet data and metadata after skb_pull().
+ * @skb: packet to operate on
+ * @len: number of bytes pulled from &sk_buff->data
+ * @n: number of bytes to memmove() from pre-pull &sk_buff->data
+ *
+ * See skb_data_move() for details.
+ */
+static inline void skb_postpull_data_move(struct sk_buff *skb,
+					  const unsigned int len,
+					  const unsigned int n)
+{
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+	skb_data_move(skb, len, n);
+}
+
+/**
+ * skb_postpush_data_move - Move packet data and metadata after skb_push().
+ * @skb: packet to operate on
+ * @len: number of bytes pushed onto &sk_buff->data
+ * @n: number of bytes to memmove() from pre-push &sk_buff->data
+ *
+ * See skb_data_move() for details.
+ */
+static inline void skb_postpush_data_move(struct sk_buff *skb,
+					  const unsigned int len,
+					  const unsigned int n)
+{
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+	skb_data_move(skb, -len, n);
+}
+
 struct sk_buff *skb_clone_sk(struct sk_buff *skb);
 
 #ifdef CONFIG_NETWORK_PHY_TIMESTAMPING

-- 
2.43.0


