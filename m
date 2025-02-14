Return-Path: <bpf+bounces-51499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAED5A35365
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A985E1890798
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4015512EBEA;
	Fri, 14 Feb 2025 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGD2WMYf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486631BC3C;
	Fri, 14 Feb 2025 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494887; cv=none; b=STvMNpEv6qFv470zYkzDzXpELxoDMIgoVTwGZjNU6dP7mQiNYtpbbci/C8BO3MYKMpRkfFCd8vbdlQU9wSNj2XGwuREXALKd3xxMBLYNu/Pmk0HQLXAbEHAvl2bZOjxRFDAaaTixDYI0THBaSTCxu2suLeK7C8Mp/sb5kMtAxx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494887; c=relaxed/simple;
	bh=IXLUCYhCNHZgztCruzDU0ZGKFctaGuPZNEaKlMrXO4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SNqXxB4wqfNyL8FCCkiiik0wwNPMqNppaLBdXwPaz1JEKeszs+Tkgex1t6vnWXrQDTYTsNl/SL55e47kQZ6dRB+XSFDn5tjvwyS/mLLy5zh/96etzetGGBPCNGm3vI4/cS1GZ66OyQX0yhKeUQK7FHYObHRBv11M47sfoAnEfqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGD2WMYf; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fbfc9ff0b9so2458650a91.2;
        Thu, 13 Feb 2025 17:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739494885; x=1740099685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVlgz+q5Bkt8Btds59rDLuHiYriySzR73dW98PkMWw0=;
        b=bGD2WMYf0P6vfsxDb2wlhNSRUpyDgNwvItMV6ZrsoonIfjJHfpsF6cwrGQdHWkxgAq
         Lp1JTjw5X+DSIStYECYObR+Nq6ezVNkN6WPbSbmVsWANmya4iObFQLChTVv0eoBpqe5L
         A8oFAuTd+AfY10NV/00lL3QrG60yPLItgv9wBJO6+dpg8mwVAEguw1CxzYiF50Z5+swp
         lhXtdphRIIxNQUVheRAy9nlViKmOw2KRNXcNnXfNRAIweozlMwSYSrn7DjX0mvyMmuNa
         i0JqMH5Ce6z2UYABQnS59tZx98QScuZHV/D+xUBPIAXAkGYtvNqu78Fv3Il9/J03LRTS
         QYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739494885; x=1740099685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVlgz+q5Bkt8Btds59rDLuHiYriySzR73dW98PkMWw0=;
        b=bIM/RM8uu89lAtrn5clg+OLfk7WGnAw/Ll/FKSAWv5pblKIg52Nv5vpFlA89i8FBJB
         mZZa9zsGNauB3gXfB3rxz51HEnJW59SR4RyuWWDD9QBay5CCBRIa0cF13xJNH0rLM1Fw
         0XcdIGHZXmGoM7tpanCIyl0Ktysn3BG8iSwcE+4ZcWHuIHVItKvjXSxzAGafV5Jiv/2q
         6n9SlcH9IqkXydgn5u8hx2IYKJxfn8NKf/adzsXO8oM3xUv1LT58pTQG1XWZ5H9+T8Wx
         7KCMDUWX+p5Pn+oQw8i5fEzYw7yYi523SiHRNf2/Fpm/8o4tP45jAvxazQIiMKXcd2iV
         eeqw==
X-Forwarded-Encrypted: i=1; AJvYcCUVnhe4dAMo8il9axezdtL2CH0WZSjPIuw+ymQE2XFUj2Otn1viZJEFXE27iTRRHGfZbEwENo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC3Pdh0WiMXxW6HPftrz+WJukaq14MUPvlDx0gEPEzcM4E+u3E
	MM9zjfWeKjATnXjmtPt0xPfxUbLUFikX0sXmP4XOlJm7D0YdmDOb
X-Gm-Gg: ASbGncvbEI2QlvbXKqKjKVOvly/StbA2W1UgP61Wdl6eGbiAXD09RqNcdnO/R3yzkw+
	yGbB1nFr9Kt0FQNAZNkn0LBezJg/Q2chga148VT9jxIsBLcWKWfb21nNfaWm/nl9zGvpf8fKJzW
	+/j2/zhgqA5EKLcKTkM5ewieg1Id7raYM77Oo1nNrW+zZS3pThbwGhRkt7e18KM4OMZigGvEJmf
	a6hsey2E03ge6E5gVusgsePFs3O45S5rI0K2QvS4jfaY/W7ViYz1uatn2q/LKjwJ/Dk68VOMzq7
	YbidhoHbNVY08p9u2jjKIYOIrJp/zJnGhV2nT7/bGVy7XM9/JxAEpA==
X-Google-Smtp-Source: AGHT+IHgaZLK4BCkk9FVWm5O3Kbvrv9kTyPfnGwVN/FFkHEYQwBzfrg0xyEcS64+QUVFDHY8Tx73iA==
X-Received: by 2002:a17:90b:17c1:b0:2ee:8e75:4aeb with SMTP id 98e67ed59e1d1-2fc0e7a219fmr8458655a91.17.1739494885591;
        Thu, 13 Feb 2025 17:01:25 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534db68sm18629565ad.39.2025.02.13.17.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 17:01:25 -0800 (PST)
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
Subject: [PATCH bpf-next v11 07/12] bpf: add BPF_SOCK_OPS_TS_SW_OPT_CB callback
Date: Fri, 14 Feb 2025 09:00:33 +0800
Message-Id: <20250214010038.54131-8-kerneljasonxing@gmail.com>
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

Support sw SCM_TSTAMP_SND case for bpf timestamping.

Add a new sock_ops callback, BPF_SOCK_OPS_TS_SW_OPT_CB. This
callback will occur at the same timestamping point as the user
space's software SCM_TSTAMP_SND. The BPF program can use it to
get the same SCM_TSTAMP_SND timestamp without modifying the
user-space application.

Based on this patch, BPF program will get the software
timestamp when the driver is ready to send the skb. In the
sebsequent patch, the hardware timestamp will be supported.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         | 2 +-
 include/uapi/linux/bpf.h       | 4 ++++
 net/core/skbuff.c              | 9 ++++++++-
 tools/include/uapi/linux/bpf.h | 4 ++++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 52f6e033e704..76582500c5ea 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4568,7 +4568,7 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
 static inline void skb_tx_timestamp(struct sk_buff *skb)
 {
 	skb_clone_tx_timestamp(skb);
-	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
+	if (skb_shinfo(skb)->tx_flags & (SKBTX_SW_TSTAMP | SKBTX_BPF))
 		skb_tstamp_tx(skb, NULL);
 }
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 68664ececdc0..b3bd92281084 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7039,6 +7039,10 @@ enum {
 					 * dev layer when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
+					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0aa54d102624..03b90f04d0b0 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5557,6 +5557,7 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
 }
 
 static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
+						  struct skb_shared_hwtstamps *hwtstamps,
 						  struct sock *sk,
 						  int tstype)
 {
@@ -5566,6 +5567,11 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 	case SCM_TSTAMP_SCHED:
 		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
 		break;
+	case SCM_TSTAMP_SND:
+		if (hwtstamps)
+			return;
+		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
+		break;
 	default:
 		return;
 	}
@@ -5586,7 +5592,8 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		return;
 
 	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
-		skb_tstamp_tx_report_bpf_timestamping(orig_skb, sk, tstype);
+		skb_tstamp_tx_report_bpf_timestamping(orig_skb, hwtstamps,
+						      sk, tstype);
 
 	if (!skb_tstamp_tx_report_so_timestamping(orig_skb, hwtstamps, tstype))
 		return;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index eed91b7296b7..9bd1c7c77b17 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7029,6 +7029,10 @@ enum {
 					 * dev layer when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
+					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


