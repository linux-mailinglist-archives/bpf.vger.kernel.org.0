Return-Path: <bpf+bounces-51215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF7BA31E99
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 07:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63CF3A951D
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92551FC7FD;
	Wed, 12 Feb 2025 06:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBK18lxY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA8C1FBEB6;
	Wed, 12 Feb 2025 06:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341192; cv=none; b=ayoZeUj+KanWWaoEKiPrUEfObAkaZbKM52VM6m4CnuwEENh2vJR9UfnXxID5NILAyTSLR/sNuvkcYc3oLj/kWRJmrxh8K2vUoBLEgCfNGvR1VfRlgm0hIUyTDmIhRxKaFfipmRCYzsfJf4hqo8xnORaexjvjBP9ZRGgGdQ4KulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341192; c=relaxed/simple;
	bh=guyV3BxCKgA8UfYI4RuwgDoHBcgK6uQDKptuR8EkjEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H0qXbGuDjwKVqt4XsgknA9kl/BZQM+DiCgm8zz1QDZ8SRKJAyehImJ4oiuptTRBGBcS3VouB3ryGXYdbtf3yWPM8wy4RiAyq271EoiOFICTEsZwGm+lrpYpfwOrJVIid3S7V4vak99AZSQ39RJ2ZQT92XD5TiKMBl0je94c9Xe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBK18lxY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f6f18b474so55147045ad.1;
        Tue, 11 Feb 2025 22:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739341190; x=1739945990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSc1kwsuWpasoHVH6g5zL3Vq5gC9QDcjB0G0BsQk2U4=;
        b=FBK18lxYbyrMUjqUgGDhG1EfWoWumfbItv1YGTLefHsHlhtaX1GbhMdZkIizhvxihG
         W6aCrOOwcSeeeft8S/GnIySq5qH9pZjB08W6WNGanPQxqqRM3oGv/tbeQVndib9ovIxc
         GqhRuyagpCD5Kj1sn9dPAK7PJgmX6prCBGnqME5NcyWe54UX3sOldvHokMKqad6EvCdz
         mlBhhuI8oYrV1dV9XV9SbI1O/gZuIC/oxER8BaCCxW1TbTFxcwe1ifN7m0Y9daXRHLbT
         UAqH+CUgHQ40/RN/GiXX95E4Zae/SlllfNFk9sAQeMFPops8lt4suMvMuL8KRHy1W1aF
         XY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341190; x=1739945990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSc1kwsuWpasoHVH6g5zL3Vq5gC9QDcjB0G0BsQk2U4=;
        b=dRXmK1dW6mygRzQyPUpcZEJ8VAOF+rXc9KIxfGW2FHaYFg9lv+Ucx6W26tb2QSpIDd
         5sVaf4yI0QvEuhD514tsgqZaPi3M5sxyRhEkIKQbQ4HZFcuMQKt5rSziYssuf5FK3oBS
         GY0ikSGjoZAxxKKx0XFCWYeRfwi2jmKLj/Je2n0nIEKz29sdFDvF4HDqZHIlIXDfoPMi
         2M8VlmURVBQLGl+ugc+m/QLfodCp8dL2mfs8JHMUxb+WHo6K8y1Ne12fHlpSHOSs1LnM
         LrcZrR0tYEdtL/Chc4ihkAGE/TppBPwrwv5Uyw5RArr7F5hlPSQwf5PgVYse5to5yZ3x
         cFLw==
X-Forwarded-Encrypted: i=1; AJvYcCUkih2xQuBYD67Rht/YOH5+K1FYGOzIFN7KmQjJZPitTv/C0slR296wTfKN3gZQmXN+77QmAwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEsBzFPRcmxaxRPl5EKv5F4IU1fXZqbg4JHZT7uRAcuM8XiKF/
	+BmfQph1qz7EkFjcnR9pWLs8XLFkFDgdTtVglevwc9lIRbW8hNmv
X-Gm-Gg: ASbGncvIymMMH/fNR1Xkm0tbn1yhp7ImiptW4WnucLjGwzoXo84Vds1oHXa1PckNgih
	wCtlEGTSRAdiyu1JL6QD03S1efCX/Bg+te33LuW3Vsj7vYza99fICbbqa/XAHAkoCaLck/khknp
	ErAKbCMdq2yTIiMG31DOVDgM/L9drw91QFuAKidC/8SRopdIVWlkarlqEgkWVeeGhCfPurUw+7t
	XpOIXwEiwQiCVCawLnEClESrRNkZRVcnfBLk/xYkhcoXm4hV/jcHsxbHf7BKVLz4gdJtORQYbQE
	emNsqhZroPg6eVrZzbnIIxZiI5HRZarhYlrg8t/nIEsj1ImN7xDWKV2CDAcXlTY=
X-Google-Smtp-Source: AGHT+IGIPpFjl7INmtRLKvhkisTeFFPMk/e1QIrB5ZYhYJzsYebQ4YOhBfIJnIGfLr2HeOr5vV8HSA==
X-Received: by 2002:a17:902:f604:b0:21f:85af:4bbf with SMTP id d9443c01a7336-220bbaf8ffdmr36118255ad.20.1739341190033;
        Tue, 11 Feb 2025 22:19:50 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dac7sm105277835ad.142.2025.02.11.22.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:19:49 -0800 (PST)
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
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v10 08/12] bpf: add BPF_SOCK_OPS_TS_HW_OPT_CB callback
Date: Wed, 12 Feb 2025 14:18:51 +0800
Message-Id: <20250212061855.71154-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250212061855.71154-1-kerneljasonxing@gmail.com>
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support hw SCM_TSTAMP_SND case for bpf timestamping.

Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. This
callback will occur at the same timestamping point as the user
space's hardware SCM_TSTAMP_SND. The BPF program can use it to
get the same SCM_TSTAMP_SND timestamp without modifying the
user-space application.

To avoid increase the code complexity, replace SKBTX_HW_TSTAMP
with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous callers
from driver side using SKBTX_HW_TSTAMP. The new definition of
SKBTX_HW_TSTAMP means the combination tests of socket timestamping
and bpf timestamping. After this patch, drivers can work under the
bpf timestamping.

Considering some drivers doesn't assign the skb with hardware
timestamp, this patch do the assignment and then BPF program
can acquire the hwstamp from skb directly.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         | 4 +++-
 include/uapi/linux/bpf.h       | 4 ++++
 net/core/skbuff.c              | 6 +++---
 tools/include/uapi/linux/bpf.h | 4 ++++
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 76582500c5ea..0b4f1889500d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -470,7 +470,7 @@ struct skb_shared_hwtstamps {
 /* Definitions for tx_flags in struct skb_shared_info */
 enum {
 	/* generate hardware time stamp */
-	SKBTX_HW_TSTAMP = 1 << 0,
+	SKBTX_HW_TSTAMP_NOBPF = 1 << 0,
 
 	/* generate software time stamp when queueing packet to NIC */
 	SKBTX_SW_TSTAMP = 1 << 1,
@@ -494,6 +494,8 @@ enum {
 	SKBTX_BPF = 1 << 7,
 };
 
+#define SKBTX_HW_TSTAMP		(SKBTX_HW_TSTAMP_NOBPF | SKBTX_BPF)
+
 #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
 				 SKBTX_SCHED_TSTAMP | \
 				 SKBTX_BPF)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b3bd92281084..f70edd067edf 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7043,6 +7043,10 @@ enum {
 					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_HW_OPT_CB,	/* Called in hardware phase when
+					 * SK_BPF_CB_TX_TIMESTAMPING feature
+					 * is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d80d2137692f..4930c43ee77b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5547,7 +5547,7 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
 	case SCM_TSTAMP_SCHED:
 		return skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP;
 	case SCM_TSTAMP_SND:
-		return skb_shinfo(skb)->tx_flags & (hwts ? SKBTX_HW_TSTAMP :
+		return skb_shinfo(skb)->tx_flags & (hwts ? SKBTX_HW_TSTAMP_NOBPF :
 						    SKBTX_SW_TSTAMP);
 	case SCM_TSTAMP_ACK:
 		return TCP_SKB_CB(skb)->txstamp_ack;
@@ -5568,9 +5568,9 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
 		break;
 	case SCM_TSTAMP_SND:
+		op = hwts ? BPF_SOCK_OPS_TS_HW_OPT_CB : BPF_SOCK_OPS_TS_SW_OPT_CB;
 		if (hwts)
-			return;
-		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
+			*skb_hwtstamps(skb) = *hwts;
 		break;
 	default:
 		return;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 9bd1c7c77b17..7b9652ce7e3c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7033,6 +7033,10 @@ enum {
 					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_HW_OPT_CB,	/* Called in hardware phase when
+					 * SK_BPF_CB_TX_TIMESTAMPING feature
+					 * is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


