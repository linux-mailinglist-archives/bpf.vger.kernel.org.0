Return-Path: <bpf+bounces-43292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 215659B2E7E
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 12:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A384D1F217BB
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA691DFD9D;
	Mon, 28 Oct 2024 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aitjkq6u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F18F1DFD84;
	Mon, 28 Oct 2024 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113620; cv=none; b=ZFeprlvQtAnqiPcdwY1Ux9Kb4x+q01mxuyo97dT6tphytc/RGXo5gZ9QRxqpyUSO7Hk49yrVXlZDGWQ4Kyxs1hb+R80d7clQvy9xLV30E3iVeoZpuDi8mG8b3j4udIt4zedutLT4d+jVurp/yFoArDxkVfWqZio7AGbZA+hUU9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113620; c=relaxed/simple;
	bh=aD8o6D6tpOQIg0naivN5cjlg8DZcm+4tt6wdIAfz4G0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJaJ+EKhrm2tql+YgELpcLIff3IxwzvC8KmIgXHZXC6FfTY2RPIJm00BHSGmGzpFrTbkQQbPh8aftRznHzdYS6Ii3UwtN3qIa+O/cJwQzcEzesEvI2Dlm1ZGnV0ENvIDGYgNPTtGuQcTUOBgztSCJGcnoinnSS2TmlTJmlFZ1Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aitjkq6u; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c805a0753so39199945ad.0;
        Mon, 28 Oct 2024 04:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730113618; x=1730718418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ukuau26fm7NhiMm7nIX1EbwJfdgYGVl0CZ73swdUhhE=;
        b=aitjkq6uHxXgVck+fte4z9fnmTRth8+/64DrXwQuOdWvbhjYXYK/hD3howY55nk8gT
         4ntqaFbDfVNnVMA3A3TU/aMbECEMSq3uYEZMUzm5WmwNcMkH4Aq4b69FcAHoT/YTVFEm
         wDO0IP0sxTwUnJpXvWrUx4ZPnKi9uJM/1Yx7TwaLDb5Qlkc6AJdw6oTOwkReMqByrf3D
         WxgLMTy0pGfiqSWjskfMjwqs5SZ35gfbTcTnfKlor9zlHpLryrGsVq0tQ1QFW4vtekTb
         QL27+5XJ/mH5IKkfi/C80pX4Vt0DSAox1N9zvDrRQ7Es5AvIwH9w2T/87QPBAgKmg++n
         uyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113618; x=1730718418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ukuau26fm7NhiMm7nIX1EbwJfdgYGVl0CZ73swdUhhE=;
        b=jcVZoBLvczP2MBDKlKLNWfyMy7GjRfpu784iNc/X9/dlo4wyFIdlsZPXnxNira8CZo
         CGlhY2DDgD4Vb8vstDv4GurCjMtouOSuFBCH9VTC9/cw4HKF6lXt6psUlCoMu4JyKeLT
         IE57XWQeSmGcngrKdHr25+b1XhOYk3UB5ndvFcv35ESfC+bNC29OKxZtXLN87hJ/hp/6
         IevQObO4EZo0QlihjWXpGQ5T2/l5cNv+WjJuZ6YwUz4uAE6sFYKo3Lm42cp4K2sfbVon
         uKIPnGsdCWyD5gzsfk/7MQqvakuipGBBtbTI4Zl94o03kOzeHV39cpnATLr7eX0O4Hb/
         Pa6w==
X-Forwarded-Encrypted: i=1; AJvYcCXcO+xSd2Mb0FOjMQKc98vhM4Jv7I+rvgDqX1oNozESiEJltoBy5RTu4zB66z+rvKRwGy3IbDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0iRfJA1ciVf7mO01QfF3QXQE3Kf5FQ6kgwq0E+cftuEs8UKq
	Vc880B0UFtEem2SMcFy2hD//PtWYAp86tpkY0wz+Y12eCZvR5b6P
X-Google-Smtp-Source: AGHT+IHuT40DF3jXyYd7kyC2EEpbUG70WNYus2IT3/sZAMWa5gXHVdLZPt/ZTkEvlPDqBHUhdb8VZg==
X-Received: by 2002:a17:902:d50c:b0:20c:9eb3:c1ff with SMTP id d9443c01a7336-210c6cc5afbmr111461965ad.59.1730113617680;
        Mon, 28 Oct 2024 04:06:57 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04bdb6sm48130905ad.255.2024.10.28.04.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:06:57 -0700 (PDT)
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
Subject: [PATCH net-next v3 09/14] net-timestamp: add a common helper to set tskey
Date: Mon, 28 Oct 2024 19:05:30 +0800
Message-Id: <20241028110535.82999-10-kerneljasonxing@gmail.com>
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

No functional changes here. Only add a common helper so that we
can use it later for bpf extension easily.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h |  1 +
 net/core/sock.c    | 27 +++++++++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index cf687efbea9f..91398b20a4a3 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2917,6 +2917,7 @@ void sock_def_readable(struct sock *sk);
 
 int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
 void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
+int sock_set_tskey(struct sock *sk, int val, int bpf_type);
 int sock_set_timestamping(struct sock *sk, int optname,
 			  struct so_timestamping timestamping);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 7e05748b1a06..42c1aba0b3fe 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -891,21 +891,16 @@ static int sock_timestamping_bind_phc(struct sock *sk, int phc_index)
 	return 0;
 }
 
-int sock_set_timestamping(struct sock *sk, int optname,
-			  struct so_timestamping timestamping)
+int sock_set_tskey(struct sock *sk, int val, int bpf_type)
 {
-	int val = timestamping.flags;
-	int ret;
-
-	if (val & ~SOF_TIMESTAMPING_MASK)
-		return -EINVAL;
+	u32 tsflags = bpf_type ? sk->sk_tsflags_bpf : sk->sk_tsflags;
 
 	if (val & SOF_TIMESTAMPING_OPT_ID_TCP &&
 	    !(val & SOF_TIMESTAMPING_OPT_ID))
 		return -EINVAL;
 
 	if (val & SOF_TIMESTAMPING_OPT_ID &&
-	    !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
+	    !(tsflags & SOF_TIMESTAMPING_OPT_ID)) {
 		if (sk_is_tcp(sk)) {
 			if ((1 << sk->sk_state) &
 			    (TCPF_CLOSE | TCPF_LISTEN))
@@ -919,6 +914,22 @@ int sock_set_timestamping(struct sock *sk, int optname,
 		}
 	}
 
+	return 0;
+}
+
+int sock_set_timestamping(struct sock *sk, int optname,
+			  struct so_timestamping timestamping)
+{
+	int val = timestamping.flags;
+	int ret;
+
+	if (val & ~SOF_TIMESTAMPING_MASK)
+		return -EINVAL;
+
+	ret = sock_set_tskey(sk, val, 0);
+	if (ret)
+		return ret;
+
 	if (val & SOF_TIMESTAMPING_OPT_STATS &&
 	    !(val & SOF_TIMESTAMPING_OPT_TSONLY))
 		return -EINVAL;
-- 
2.37.3


