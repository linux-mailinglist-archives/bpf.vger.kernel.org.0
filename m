Return-Path: <bpf+bounces-43295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303889B2E84
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 12:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616351C21996
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 11:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDE71DFE38;
	Mon, 28 Oct 2024 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+cxGWcR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8661DFE2C;
	Mon, 28 Oct 2024 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113636; cv=none; b=Y4Qp7BSMBbHVxcEOonVdGELHDDvZSyMqmT0VP5E3L1/HG75DIfwr67zD7JdmFIRy8IIYBvCMnTMYI6Dup+53qMoA7y2wGIvqFdYlUyTQlMB29NcO2CgLjed0/klMF9TF04STwwjNxPU90XfX8k4KE3/w7EA0+NBjSjK/QXf4Fis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113636; c=relaxed/simple;
	bh=QC4G63ZJPFcAP98wAsnrPRmB23FMfRqCIbeY5agxrv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D1u3u9sy25v42sucotlUFUVI7CYQtZaMmnzd+NA/+bc9Wpmp55v6KYkBpj82yZ4xXUoYPSxuDNxQ0rAXsZ+SVwbxZQ6KXchXX7zVrTF6rePYbbKjmAxE5Cog/HcCYDuaYIn4FiPBRaSNDEAyPpmPJFXmLH2Wq4UtAVwfob9ZAU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+cxGWcR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso34189815ad.2;
        Mon, 28 Oct 2024 04:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730113634; x=1730718434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXbOExaDu/uQUw8FjeUjOu713YfQRhW5kS8sH0/9U3A=;
        b=Y+cxGWcR3K12hp2Zq5BRsYOp8urEdJTJmqYBDMsYLnVQx0SFH2iV7hsYZFgtDsH0mA
         3KoZ0IxFaTkoYw55o2F/mhmMCKsvGcFiZ5rxlHBcSP7ubBJLXuGdej9IXQdZZJOuJo5l
         dq0wXdtc+HW8jv+KZ+q0htttx7MqN7A3Xhh34wv/MK/fh/Kwdpo99M6CHij1MEEboVQg
         lSjUe1mRgAazcfiGjEGyORY7aN0SAQwO1BYnmb4X7a9KIJeWTnV2+EbLY8/qXrCtqbrs
         OUKGQOHzaZLg5cXmdDwhvXvSMFCKpEvfIi59sFY/UK4jxD7SPSarSJRQTWwcqVmK/mzi
         kgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113634; x=1730718434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXbOExaDu/uQUw8FjeUjOu713YfQRhW5kS8sH0/9U3A=;
        b=UoDdUy5CxqEyLnbjrDrdksdAZn/sW3D4swzlJghKHm3Ca5PTctoMAxZzz9A9oi5n+X
         CTUhOJ41uWGFZWEgHfrFHoiCHhzvm4F9VnFpBsKTPcCVrBpUGf5svTu33MFGNrij3zEP
         LQTLA2iVc2TyKUQobwn3zVLe2aDaD8cZ2mdSNjUaF7JczNLVju2rQzlhxdh1Qa8MJtAk
         VrkWil/QkDiuQeYtrnGRHormQbYtyNhy5+kwkd8jy3Oje177DEP3opGnkSDOz2WcEOd+
         vbac8OYeA/wMWMWBF6Dkxc5HhkwsrjbB9pze0wwFkeRG6I2um4M6NcLAeZDIxf8TOpwA
         fyWA==
X-Forwarded-Encrypted: i=1; AJvYcCX2LYBFhGEm/ReqOlIK0uGvssLrivS4e+YCIUNx2wIJH68K4jBW8W4khTHs4Fji595fh/ivlC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzklLOw0xm74kUCOh6xdnBa4CpFfGGNmDVTIRlVKOwjY09Ppzuu
	Kgwd3LBTQeRw9ajf22epZprnqv0J2FI6XMibj1/+efa3F2IrTr05
X-Google-Smtp-Source: AGHT+IEzjIQnm8EWERYCUyT2PumNk8MQlsb8zqcZOIOZiJBGPDqo0VE/PsAuBpYThzrSsiI1ldwtvQ==
X-Received: by 2002:a17:902:c945:b0:20c:cd23:449d with SMTP id d9443c01a7336-210c6c43228mr98899525ad.46.1730113633959;
        Mon, 28 Oct 2024 04:07:13 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04bdb6sm48130905ad.255.2024.10.28.04.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:07:13 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	ykolal@fb.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 12/14] net-timestamp: add OPT_ID for UDP proto
Date: Mon, 28 Oct 2024 19:05:33 +0800
Message-Id: <20241028110535.82999-13-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241028110535.82999-1-kerneljasonxing@gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Let it work for UDP proto.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/ip_output.c  | 16 +++++++++++-----
 net/ipv6/ip6_output.c | 16 +++++++++++-----
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 9d94a209057b..45033105b34c 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1049,11 +1049,17 @@ static int __ip_append_data(struct sock *sk,
 
 	cork->length += length;
 
-	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
-	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
-		if (cork->flags & IPCORK_TS_OPT_ID) {
-			tskey = cork->ts_opt_id;
-		} else {
+	if (cork->tx_flags & SKBTX_ANY_TSTAMP) {
+		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
+			if (cork->flags & IPCORK_TS_OPT_ID) {
+				tskey = cork->ts_opt_id;
+			} else {
+				tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+				hold_tskey = true;
+			}
+		}
+		if (!hold_tskey &&
+		    READ_ONCE(sk->sk_tsflags_bpf) & SOF_TIMESTAMPING_OPT_ID) {
 			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
 			hold_tskey = true;
 		}
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 230e8d5a792c..ec956ada7179 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1547,11 +1547,17 @@ static int __ip6_append_data(struct sock *sk,
 			flags &= ~MSG_SPLICE_PAGES;
 	}
 
-	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
-	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
-		if (cork->flags & IPCORK_TS_OPT_ID) {
-			tskey = cork->ts_opt_id;
-		} else {
+	if (cork->tx_flags & SKBTX_ANY_TSTAMP) {
+		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
+			if (cork->flags & IPCORK_TS_OPT_ID) {
+				tskey = cork->ts_opt_id;
+			} else {
+				tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+				hold_tskey = true;
+			}
+		}
+		if (!hold_tskey &&
+		    READ_ONCE(sk->sk_tsflags_bpf) & SOF_TIMESTAMPING_OPT_ID) {
 			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
 			hold_tskey = true;
 		}
-- 
2.37.3


