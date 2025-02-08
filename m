Return-Path: <bpf+bounces-50863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C13A2D590
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 11:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C577A4406
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 10:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BC81B6D0B;
	Sat,  8 Feb 2025 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCaj6jRX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8B41B0F11;
	Sat,  8 Feb 2025 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739010803; cv=none; b=FSgrK3ML3+j+I+spO1dlS9FtIlEWQVow1VPRwQxPb0+9H8GmPPxzfElGRNuLiz2dM2K3pnRmyF6lm7spzNieJXgPpCVodYtSPWPK8XdWgoloGOkRfRujurT8y2RVj6mPMfgG8xT6ysZiZ/voC4drjSlFHx4mYrB8gYwneGp5r/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739010803; c=relaxed/simple;
	bh=WY8yUDz7yc8gviHSfkBQwlWcLRw//ShDhYG8DXRFLV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IQ/A+HLR1KTsJuV40XoArHDxDh+M8JO1F+JJgZ7k4Rrm3mcG2Nh+WwFEJuqEHdxfG7bpHSnbLCV06JRONXbnRHgDMxVO+qgMImePs/M/MfNFOsGaparc/R1SnS6ofo8yquQo2LZn1Tryz0M5TyuvGSEvBWxWYAEf5YhnUQ/L/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCaj6jRX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f6d264221so3470005ad.1;
        Sat, 08 Feb 2025 02:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739010801; x=1739615601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AknKlNj2i8ni4+T0IaTF/FB2qHRc7HV6m3tejtC5b0w=;
        b=dCaj6jRXisQTP5R3pK8gdVoasqyNz7oO3r0e+E3+zTnRXOjdIr2leBwdVTl/i554V+
         Nx2VIJ5KPcUXLAMYE5ba7sd/PvjaoQG8Edn3XzUr7b5AMUr7mWxZtVGRu8W3ZNmLQNUX
         5rlSfY0fT1lUro114Rg5LvqcHDPeKX/cwM+shK9f+8IFtjNL7QPDICx2G1DBWWfskJmg
         6sQEAWMARkD5GCEYlxjL6bg+CUf7hL7Gfs3luFxOlCsmSAf+Xcsl/2McsVnj6yeRsbY+
         EcTDuiK7KkWRAYwYiZUL+KxHWiMfBWLdXTDKFMG2hhmUlvUhGSi2Fj1hYEv16hzReuD8
         qFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739010801; x=1739615601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AknKlNj2i8ni4+T0IaTF/FB2qHRc7HV6m3tejtC5b0w=;
        b=GYM13aikQ/VhLPXoLyoKE4Vm4PTjJGkWADPTR82k2g8jez9NDky2dBW9BYnE0omS/F
         zxEcSz5lhJAPHyYsF/H+QIhBuRQCFdZEmaH8D3Ia5N+cvvmYwsSNGdVgrKqqFvzFOGWH
         uyM0OEz/OnxMtV/tEI+9nMNNPhbE3PVl8F/Pyvomh9FYg7BpbpPPueRJW6qZqoZP+cuz
         pPVcGWrSn2recvXO+BRa6obV0CrVVJgfJGlKxsILTjZEvD3LESsvUbWbbfUG8WIDi2v4
         Nfs62pffLGiKAVIB2P5a9mt+8EeL2DAnjCEUjLavUM+ZSV72EJpwH9VYzlkAorL9c5r5
         bTfw==
X-Forwarded-Encrypted: i=1; AJvYcCX5e99daPhnqPOx8X21mUsRVzbuyzdG4+X03mOHy6Ju51y/r3cuY/wDeHzy+vbenmdd4EWXoX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW9ov0Cuhg7/pONIYQ7EwP37VxkH1Y3UpcrcU2EGGWZOUAtSz8
	KElPHd+cZNJFu44TGYTEm6/BOuqTSyuubSCB1yBPkSJGkBHUqF2d
X-Gm-Gg: ASbGncuxlaZSTz6dNCjulVbptFlEtmeb7aYGad3FwnLkeAtru4mhO8Yukp1VdW4INri
	FOXo6RLIFHCPNZoiLG50kE3zm5giFIhdBLBzGOsDAA53RooMi9ZAhHbF6wfAZG/bVrc/ymMS7Bs
	K/X/ADmUkSZzJiFT8Af6rZIPmrh6voMUhMawbdY1V5B9ynI9E+bun18m6BKJXNHxK/gW8P8lz63
	j30Y9YUAxXBpUJEVu3Y+CXaNMd3DY2eZntvKfUB/bMVtyOqT0okRpT66LYsAz6MBJvrpg8w9Pvp
	PbVlpfsY/lyqeJsKFyLOLYIHti5mUOV5RgNgoZsQ+2grt3BuSiyRAA==
X-Google-Smtp-Source: AGHT+IFc7ayT+TxLuuHRzy+mhlKx59C4tK3K9Q+Km5PSRdVV3s8dlXlnf6nxBFOXACG+ohYfbRVO7w==
X-Received: by 2002:a17:902:cccb:b0:215:7446:2151 with SMTP id d9443c01a7336-21f4e1ce6cemr125558075ad.4.1739010801117;
        Sat, 08 Feb 2025 02:33:21 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af58sm44527835ad.70.2025.02.08.02.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 02:33:20 -0800 (PST)
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
	horms@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v9 10/12] bpf: add a new callback in tcp_tx_timestamp()
Date: Sat,  8 Feb 2025 18:32:18 +0800
Message-Id: <20250208103220.72294-11-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250208103220.72294-1-kerneljasonxing@gmail.com>
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the callback to correlate tcp_sendmsg timestamp with other
points, like SND/SW/ACK. For instance, let bpf prog trace the beginning
of tcp_sendmsg_locked() and then store the sendmsg timestamp at
the bpf_sk_storage, so that in tcp_tx_timestamp() we can correlate
the timestamp with tskey which can be found in other sending points.
More details can be found in the selftest.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/uapi/linux/bpf.h       | 5 +++++
 net/ipv4/tcp.c                 | 4 ++++
 tools/include/uapi/linux/bpf.h | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c04e788125a7..7b1a7dd68c0d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7049,6 +7049,11 @@ enum {
 					 * when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_SND_CB,		/* Called when every sendmsg syscall
+					 * is triggered. It's used to correlate
+					 * sendmsg timestamp with corresponding
+					 * tskey.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..4895d7a6327b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -492,6 +492,10 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
 			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
 	}
+
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb)
+		bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TS_SND_CB);
 }
 
 static bool tcp_stream_is_readable(struct sock *sk, int target)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d3e2988b3b4c..2739ee0154a0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7042,6 +7042,11 @@ enum {
 					 * when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_SND_CB,		/* Called when every sendmsg syscall
+					 * is triggered. It's used to correlate
+					 * sendmsg timestamp with corresponding
+					 * tskey.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


