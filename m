Return-Path: <bpf+bounces-51497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D031CA3535F
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0626516E16F
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6090E3BBC9;
	Fri, 14 Feb 2025 01:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6bi+v9y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E24C275419;
	Fri, 14 Feb 2025 01:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494877; cv=none; b=EltX+VtLrZ0zZZDJ8t5VcNixwm3JDF2z9xpF9AoKXSVRHuEtQBt6bo3/Zng7A/4hybv7/auVEUUirGOSevsLMINytDJCVV6HmnpeEPQb96kmvzaQHrWIZ0dofIb/mRg/CtmumFbuPPDF7UfZitQV8Sa/uktCrFW+WxA7sg5UHCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494877; c=relaxed/simple;
	bh=eTHtJrLTgKPapbvhe7qwd0kLWB4F9Df0+/dv2qnCE3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RI1D+Zwb6iCIr3AOIjSt7zmVZp+PFplFFgaRZFhAkP/HVflQMDbAnQqoApdITOiDAbuxtDyn22x+7Me372SdhxQLxFReJhNqZ5e3WsY93UztFrCoEncmZVNtcCjBuDtMriLG+8IRbaC/9SfOa9HLE2wXGQCv5X/vyoleKrJ9WXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6bi+v9y; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc0026eb79so2765824a91.0;
        Thu, 13 Feb 2025 17:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739494875; x=1740099675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJ9F212PtsSHKIVUZOrPA2mk84naWjg27j0jUX3VDVs=;
        b=L6bi+v9ydRw9GKY9iu583FWBYWK4WDwqK60Z+/srU1QUk9KWBgLn2QXf/r2ZlZlI4i
         oMotp0Y4Aqo6Xohs4MMAqNXuUDqIaEsPXwq/Zx+DAChHcXKFz7XC7IgoS8FU6PLIlz/M
         3zN3hqE/N2UR+GnSslotf3AEGpAsD/kIlAZf3DGVC/M7rD4oiGLferewPB96InN5/cTO
         eHN6va5Il5KmH6JYhIsZqUh56a1dbSBkSgnKpYb0xnmEVZ3+2UDFimaSzHPlN33QdCIk
         TUyn0zvfkSMN2Zkz+KDCqeDDiA3XsFqerPVTH4MDmR6mhfUjDlFMg5LG3OWd2wE5xMhk
         5Q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739494875; x=1740099675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJ9F212PtsSHKIVUZOrPA2mk84naWjg27j0jUX3VDVs=;
        b=bgBRxwqMuQWfhfkRxI1gTBjWQsvM5+8RFtAcq5ygr8isNAuUvnnMv3Uw9WUQyELqDi
         gbzL8YqH0AwJQydTWGp9NjamxyFuEiYArXyngUBsbx4GOnjSb5n94bogJjodD9+XddxN
         8Vj4kANKz7f2vlv9t30gLEmvL5kkeCYiDS0G/J+PRPv8XIgw4HOP+zd5wjo6FMBPgIPd
         wfcgfld2mKCNMxTqVNAWwl9R4wRJWMeKrOs0raroInS6n5uFGHN/Wz44oqaZAQacaCEC
         1NEWf/N4fXXbxpR6raWwBwedcJrYmDePPAicJ24Z6GtDJ9kasxYJTWjZo9tovxIjKvTn
         E/lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRkVWQpcPbaU+ess6S54Ow3+fAyBZURry5m6nk5L5d23yIRkV+iJ/1wa1VRrjRI5BGLlzoByk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyC40QYlZ62Z6tw1C2K4oCiTX1pbGD1nO/aBPkO1ujLwa+NWQU
	fAqbJDZmAQYTWc6bdR5+N8vQ2B1RGcry1nEEN5wIIBvc3TVf/nCy
X-Gm-Gg: ASbGncthGNN1YBzVIne9jXEqFH+m0wmuohTSFInHTaGPcgUy4KLQXcUyuxCIUFMNll8
	m4wH73e+wcGRaf5IsBZ1XRxNu8YUon2csmumgADjZt31tNGL1iCD77Q9rzu4aflTThzk4f49m5b
	QrgWh9ZwjmNdCem+I4JwSCfGASkofF5bz4m1i7bHpR/B1QhrrYGvN/h04t04DUG61WPmg5Q4bRw
	GLcge7u/go054B5cxPbYcOnSCIzOQhfi8LH9Fl/ZzcOsJBuRLo8MGvH05e5RV1pFwRZaL2wE8Bc
	iHd2t2JlcQTaud9QVePeIRDVifVESOsr38MVgnIpO7Gy7FmE/OJ4lg==
X-Google-Smtp-Source: AGHT+IFJkXtGtlbYlTo7BOxFd3do8Sy1/TssN6e9klcEaS9pO0vQIqdBMR7K1ewXllgQBIw92QSlqQ==
X-Received: by 2002:a17:90b:2f06:b0:2ee:53b3:3f1c with SMTP id 98e67ed59e1d1-2fbf5bc1a9dmr13807382a91.5.1739494874794;
        Thu, 13 Feb 2025 17:01:14 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534db68sm18629565ad.39.2025.02.13.17.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 17:01:14 -0800 (PST)
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
Subject: [PATCH bpf-next v11 05/12] net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
Date: Fri, 14 Feb 2025 09:00:31 +0800
Message-Id: <20250214010038.54131-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250214010038.54131-1-kerneljasonxing@gmail.com>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes here. Only add test to see if the orig_skb
matches the usage of application SO_TIMESTAMPING.

In this series, bpf timestamping and previous socket timestamping
are implemented in the same function __skb_tstamp_tx(). To test
the socket enables socket timestamping feature, this function
skb_tstamp_tx_report_so_timestamping() is added.

In the next patch, another check for bpf timestamping feature
will be introduced just like the above report function, namely,
skb_tstamp_tx_report_bpf_timestamping(). Then users will be able
to know the socket enables either or both of features.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/skbuff.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a441613a1e6c..341a3290e898 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5539,6 +5539,23 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
 
+static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
+						 struct skb_shared_hwtstamps *hwtstamps,
+						 int tstype)
+{
+	switch (tstype) {
+	case SCM_TSTAMP_SCHED:
+		return skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP;
+	case SCM_TSTAMP_SND:
+		return skb_shinfo(skb)->tx_flags & (hwtstamps ? SKBTX_HW_TSTAMP :
+						    SKBTX_SW_TSTAMP);
+	case SCM_TSTAMP_ACK:
+		return TCP_SKB_CB(skb)->txstamp_ack;
+	}
+
+	return false;
+}
+
 void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		     const struct sk_buff *ack_skb,
 		     struct skb_shared_hwtstamps *hwtstamps,
@@ -5551,6 +5568,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
+	if (!skb_tstamp_tx_report_so_timestamping(orig_skb, hwtstamps, tstype))
+		return;
+
 	tsflags = READ_ONCE(sk->sk_tsflags);
 	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
 	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
-- 
2.43.5


