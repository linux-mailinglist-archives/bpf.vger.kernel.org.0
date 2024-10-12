Return-Path: <bpf+bounces-41802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F53399B0AE
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 06:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BE71C22552
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 04:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D09A13174B;
	Sat, 12 Oct 2024 04:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUGp9CyZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E10126BFA;
	Sat, 12 Oct 2024 04:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728706047; cv=none; b=t/XpiZTgn2vrFgJSBCBqcyIkdKgL7pgSCOx49afc9YOywrQL+9zNaAaMGmZ+z8YgqWXGiSYJhU1IgBGSWwsTZbJ+vpU0GJVKcaoIFsXEB++zVTcx80XZHtJ0nzLYepRLwwHf1pMY/lUricWthyExueSGPaXkuaZhPillqbOK3Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728706047; c=relaxed/simple;
	bh=rDljLUYtyvEolOi313e9tVjcWSdz+WrvZ+W7hx1oegY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GMENE3BUzL65mrIVxkC1s7RPABnq++uFp3q2fsN0bxsgHDsEG5xJlAtQwV1wqmyNojD+TAjWImh71u6tvKUmKRjNoEVQHYtmzoZxoPWeS7fUimSH/eglSujuABp0HgeJOBdnfcYfdhEQLBm55OhO+Zk4CgGtP4e5vuP67D5HBM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUGp9CyZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c7edf2872so21136395ad.1;
        Fri, 11 Oct 2024 21:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728706045; x=1729310845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hVRaBXC252Dx8TcXt1k7byW2s36lWcU4IhMjNxESCs=;
        b=cUGp9CyZcSTjjXQDvDdbQ0+JrAk+lzgkgnAwr6XbqztPeDBSatnywq3a90il3U9baG
         aNrBR+GZA0sSEx1Pp/Yc1/6abCrAvvU/irxz5ND+A/0bkdBmW3eQwOiNGKB+9XLqsYwO
         QSghYLF7ZkLP6mZaAEK+OoSxSBhuuw7oysgaDasXd2NVL7huHhdL87/XW8uKGtF1hips
         C+caAbKMEhl0Aao2M9TByVVVBWVYGOkxkCJdj81c53knu8wI2Pd2DzoKmbr2DdpTvqX2
         pK7tVDDcJmoLS1tXFou8v6ScyzewuIPPSSxj11yc965KpgsLHhiTHFzWyeTAN1GDiKLb
         ScRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728706045; x=1729310845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hVRaBXC252Dx8TcXt1k7byW2s36lWcU4IhMjNxESCs=;
        b=oFuZr2nYpAqaOg+AOAJF9Oi+WeAVv4GeianJDzi+mErYJZ1qyo9Za6j1aN5HXmmJ0+
         M/j41xayb9p2FyFjwgofbh19IgLjg1vcpAX+yX6I49IiT1WiEowLMBU+pXdkyEWX+VuQ
         Hx7C8t8jhL8eYzeZFGwtVI14fbrVJ44+sm7gHEonwF6qniEQf9iCeAHsvnjyJrhgESIq
         w94RuRPbfLJljtUzUnCUgWCKzxazgJCI1eKWDM4gWw431SLvHGwHLR5wBOY2nDt3Xih5
         C9QfiLJ5GqKms724uTLri2peKVVo6O2+DZrT/6i38TuZdOU4LpP6VqHiMX/oZmnBwRfG
         hKdA==
X-Forwarded-Encrypted: i=1; AJvYcCVmKyD8l8eU1WLt+C2TZ3DGr7TKSbaOKeOEygVEQ8XllmY1SEA/zY75CkQx6fotCKYfi3X8IxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTMBpz/KeW0PB0H3homsZVgFVHTEFfU/ElpcUIic1qtUkg5eSg
	PAwh75j6LWmdvl3BHjHfDsnD4K9Z54KDmn0kCL/PdDkArDKvva7f
X-Google-Smtp-Source: AGHT+IHg8XfHQswhhxxTNWgks+HiljZNvmNN7B6/sXwYm2pE/3OS3tpIzR38RQz7ap3DxWp3AQ77og==
X-Received: by 2002:a17:902:d48a:b0:20b:5aeb:9b8 with SMTP id d9443c01a7336-20ca03d67eamr73258105ad.24.1728706044857;
        Fri, 11 Oct 2024 21:07:24 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c21301dsm30939685ad.199.2024.10.11.21.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:07:24 -0700 (PDT)
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
Subject: [PATCH net-next v2 05/12] net-timestamp: add bpf infrastructure to allow exposing timestamp later
Date: Sat, 12 Oct 2024 12:06:44 +0800
Message-Id: <20241012040651.95616-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241012040651.95616-1-kerneljasonxing@gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Implement basic codes so that we later can easily add each tx points.
Introducing BPF_SOCK_OPS_ALL_CB_FLAGS used as a test statement can help
use control whether to output or not.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/uapi/linux/bpf.h       | 5 ++++-
 net/core/skbuff.c              | 8 ++++++++
 tools/include/uapi/linux/bpf.h | 5 ++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c6cd7c7aeeee..157e139ed6fc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6900,8 +6900,11 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf when the kernel is generating tx timestamps.
+	 */
+	BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 /* List of known BPF sock_ops operators.
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d0f912f1ff7b..3a4110d0f983 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5621,11 +5621,19 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
 
 static void bpf_skb_tstamp_tx_output(struct sock *sk, int tstype)
 {
+	struct tcp_sock *tp;
 	u32 tsflags;
 
+	if (!sk_is_tcp(sk))
+		return;
+
 	tsflags = READ_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR]);
 	if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
 		return;
+
+	tp = tcp_sk(sk);
+	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG))
+		return;
 }
 
 void __skb_tstamp_tx(struct sk_buff *orig_skb,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1fb3cb2636e6..93853d9d4922 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6899,8 +6899,11 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf when the kernel is generating tx timestamps.
+	 */
+	BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 /* List of known BPF sock_ops operators.
-- 
2.37.3


