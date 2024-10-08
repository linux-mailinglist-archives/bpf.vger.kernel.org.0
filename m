Return-Path: <bpf+bounces-41228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4A19944F0
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73EACB23753
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05C51C1AB8;
	Tue,  8 Oct 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="injmPPme"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E771218C92D;
	Tue,  8 Oct 2024 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381090; cv=none; b=sqoHizxAQ05WwHKJh6kAXcMlm2wowu0jK3Uk/WrAw7q5y/g5V1L0U3hc/6QJaAoBbm30NOFGfNQROaEbtMq954K6Fb/RKCTjIeXvtGpNjPPoElWaVfq/DtRvcgI/pekjOILLjHdYyhUJL1melh4JfkY7258ONoKwSQQwDiYx82I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381090; c=relaxed/simple;
	bh=gfIGOMois/XfufsYDX1Tjk7Q5MqWeIoi2YOgvJxM9RM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oxRYITj+Iv83Ba2idz+DXqNZ7X1A5QanvAyrBi45wxf2CSKdwMY79RAeUiKLjCtthLBgsiOYZhAKULl58QqgcRo2haDB59Wy2TdP4oYN3P1+BWPlEiRsNbQk0OcPO7nSNpWfUWiFUjQ4HY7EdR+MgDyf0CYlVAm011kgcr1N/XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=injmPPme; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c56b816faso4410805ad.2;
        Tue, 08 Oct 2024 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728381087; x=1728985887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98ykS8Ga57uf+D8UKSlgOLD18H1UXyqadxSpnrjw8jg=;
        b=injmPPmeWJysV2PaISLsWyvyzD06Z0GQ5yfbd5t1LNAcv8thMXaqHYaVu7bRX4CGem
         Qxprit4r2DfC61lUttCBgrCfG5i904jSONNOocraUYxxYgbdmnmkUoB/USlLIUFy6I+g
         snr5gjV5plEndAMcZXcXDo16qsJDgFjbSyj7TtyIemZJB5XWnShYlNvOZA960pZXFUaQ
         bPBG6Yhh8P2WuB8I/akQHzn06r4KnAHzBnPi5Kochhoe/NCJ6yROBqEDtt6G3TIpUjKe
         l7Gg/NC5/Dy7DnIlre6PttOepxVPFEwBssFpcvcAxD/O2h9PVoKC7arrcVot4SLHReU7
         XL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728381087; x=1728985887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98ykS8Ga57uf+D8UKSlgOLD18H1UXyqadxSpnrjw8jg=;
        b=aCNhROrbi0grZM51HJRQp6bBcNqXjDuU8wfTLDouC09e05a99zyRzqpAh/VolkPoo0
         SNBrp0PEeHL33F+iQ6S4ve9hHCLAk/C/XfiLt5pn59bB3EliigLNKxkrdEN50jiAlo+Y
         a9sYXYitwyjQPT8DPUBys7XD1pI1swnXbvAhG+PeoCJGW/nO5upd3HW61HvL1NJRtC8k
         6ru+d8fQSGqCG7N3AKLw3xtPPZnb9PAuBgC50tzGhdooupzhb4b1C5v9yEYM4NHWyFiR
         INysX67IB4IGfpaITilfLyO63iOjFuXruZg25rTy0oIkrgo6wbMF3hAZ+jx6+O24RX3y
         lLBA==
X-Forwarded-Encrypted: i=1; AJvYcCVvqsVroRUTjjJckBQKThszWRoFya9NieXhPJ1DQLY+F4GTEZu59063HnFhSJ6tukgVFxSB1sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW6/q0DejunAIpT6/8A5RgxSG3xHJQIZf2CrlUnylPzB+xMaGt
	e6t3WxIM5z8COWcim9CI4ZxfAStYHI9/vQx5sthaQmnj2C77XjwF
X-Google-Smtp-Source: AGHT+IHE+S/SdAwkomRxpQvFPULcgvDI3kpZMfoP/Dz3A8+rjr3YJCiDUVMQSHWUhSKjej6ZkpPB3Q==
X-Received: by 2002:a17:902:d4c7:b0:20b:bac2:88f6 with SMTP id d9443c01a7336-20bff17d57dmr215597065ad.52.1728381087019;
        Tue, 08 Oct 2024 02:51:27 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cfd25sm52527345ad.73.2024.10.08.02.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:51:26 -0700 (PDT)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/9] net-timestamp: introduce TS_SCHED_OPT_CB to generate dev xmit timestamp
Date: Tue,  8 Oct 2024 17:51:02 +0800
Message-Id: <20241008095109.99918-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241008095109.99918-1-kerneljasonxing@gmail.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Introduce BPF_SOCK_OPS_TS_SCHED_OPT_CB flag so that we can decide to
print timestamps when the skb just passes the dev layer.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/uapi/linux/bpf.h       |  5 +++++
 net/core/skbuff.c              | 16 +++++++++++++++-
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 157e139ed6fc..3cf3c9c896c7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7019,6 +7019,11 @@ enum {
 					 * by the kernel or the
 					 * earlier bpf-progs.
 					 */
+	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
+					 * dev layer when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5ff1a91c1204..e697f50d1182 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5548,8 +5548,22 @@ static bool bpf_skb_tstamp_tx(struct sock *sk, u32 scm_flag,
 		return false;
 
 	tp = tcp_sk(sk);
-	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG))
+	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG)) {
+		struct timespec64 tstamp;
+		u32 cb_flag;
+
+		switch (scm_flag) {
+		case SCM_TSTAMP_SCHED:
+			cb_flag = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
+			break;
+		default:
+			return true;
+		}
+
+		tstamp = ktime_to_timespec64(ktime_get_real());
+		tcp_call_bpf_2arg(sk, cb_flag, tstamp.tv_sec, tstamp.tv_nsec);
 		return true;
+	}
 
 	return false;
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 93853d9d4922..d60675e1a5a0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7018,6 +7018,11 @@ enum {
 					 * by the kernel or the
 					 * earlier bpf-progs.
 					 */
+	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
+					 * dev layer when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.37.3


