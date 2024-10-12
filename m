Return-Path: <bpf+bounces-41805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C904B99B0B4
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 06:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850F8285337
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 04:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F195E13A256;
	Sat, 12 Oct 2024 04:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByRWTZMv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBB4128369;
	Sat, 12 Oct 2024 04:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728706061; cv=none; b=nO2mNNHCGUhFvpmf43IqqIikJRxRQAZh6YDWGw6sztic106Wb2tdyReIvd3Eq4Dm3PqxGkj1U25kqtj+dp5S4e/jUg/CLbxgv+WYckG/ojl9qNBmGdekJAVC9NsNrRQsmy59+3202vhBjwjn/zydOAXCGFk9koGKu4X5Ok2GKVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728706061; c=relaxed/simple;
	bh=S3HNPOpYMrfdrPsaUvWNqYtAGnxE1FPX3Yb8xP7Rtmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mV5YTFVwltLlLkOxLf/AA2YscaIioCrNNNKv55DlnS5+6Eubxsr6+cmVmyA3I8ZHUCDTz8cJXgdrRNJmzhA0oqzNnlR8WPyoQNwKlvmoP0rTWujGVTyEZK08YhmyPdicTMHh4ChZFT6mBMX1K6INo82Tt+Si6yO2syoI/7sd6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByRWTZMv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cb47387ceso6837255ad.1;
        Fri, 11 Oct 2024 21:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728706059; x=1729310859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pagld+GkzvWpPPsbvZdzqsapkyB63T4pAkivFgLO5c=;
        b=ByRWTZMv6FjV3OyzGO/bmEpyg5EwqsHPNod1+qhqlz4HYTNtDrjR70bA02YAQWKOtJ
         9N8Io59e4jcSnYKIF/Z1TblAoP5UVaUYqxGoF2mRsiB5qWOmeEV8a7cIetVHtwM1/5Og
         FhilfB1QtemcWlwio9UjJ4f1p6yTdhnfEC34KSbSzV4p8Op/lzRY6LIrqFsScB1XUPNM
         pfryP8IjL95U3fR0FM0fdNpeliIkdbp8dwWuo2N9FqzlbVzhfYLOLocUVOd9WlNz84dg
         hF8u499HKYXw13qQWhZlpR95j0t2zDfWLAnTR0bpeQ1H7bUTaD2xUWhgFnpMbIs3IRE4
         J+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728706059; x=1729310859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pagld+GkzvWpPPsbvZdzqsapkyB63T4pAkivFgLO5c=;
        b=HDIPEDPjQLxmyZWsMAjqLqvRjLdrr5KLz9qjfsB18xwYw3PBwXystr2KuHKXQZ88o8
         YnLNt4XRbWwosjinrAV1xqwACLlhduQjzBGbSoLj64ynhxHaYvsVmPJMiggY+oMpRFvI
         dqOgTNaeNZMw7elxQfYD0d6cVmV0BCTcWtjN/3Qq/elX6b5B/DAKMCz2NITgEYvxv/rf
         3r9qYBFRiAQK9WLgy/Le58jQsiV9foFxA9cBb3P2knBkUA5sl7QxS7SVoT5dNNCVHgWp
         yw19TcqdLeBZ1YWYiWjpRGiuZAlhu3wxzim3+yP4ARTCkev5fjWwVk9QYb1C1mJVKJfS
         3BUA==
X-Forwarded-Encrypted: i=1; AJvYcCXbntmgNbaBN1bxNgCqHq5szhyWFs1KoPOhnE8jVXY0S2+igkVnWQG5f2T5om6jlSN0Tb3m2sA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfFqq+24nOHUyXdgPDdLWw3nLofsR6gOglKgnvT0dItQKg3ViL
	olCjpV676NjIEbBgaVmWkbzF8uLaUsg5u2EIasGZ/rXldF/FFGyy
X-Google-Smtp-Source: AGHT+IE6G9YkwcWwiCDbFNSMEpF/g/AagIclmdqNFngCNkNu/juT+7dyMr3Zu4lCS276pacGBIxzXw==
X-Received: by 2002:a17:902:ecc1:b0:20c:bffe:e1e5 with SMTP id d9443c01a7336-20cbffee323mr18675565ad.19.1728706059527;
        Fri, 11 Oct 2024 21:07:39 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c21301dsm30939685ad.199.2024.10.11.21.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:07:39 -0700 (PDT)
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
Subject: [PATCH net-next v2 08/12] net-timestamp: introduce TS_ACK_OPT_CB to generate tcp acked timestamp
Date: Sat, 12 Oct 2024 12:06:47 +0800
Message-Id: <20241012040651.95616-9-kerneljasonxing@gmail.com>
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

When the last sent skb in each sendmsg() is acknowledged in TCP layer,
we can print timestamp by setting BPF_SOCK_OPS_TS_ACK_OPT_CB in
bpf program.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/uapi/linux/bpf.h       | 5 +++++
 net/core/skbuff.c              | 3 +++
 tools/include/uapi/linux/bpf.h | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0d00539f247a..1b478ec18ac2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7029,6 +7029,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_ACK_OPT_CB,	/* Called when all the skbs are
+					 * acknowledged when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 832d53de9874..e18305b03a01 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5644,6 +5644,9 @@ static void bpf_skb_tstamp_tx_output(struct sock *sk, int tstype,
 		case SCM_TSTAMP_SND:
 			cb_flag = BPF_SOCK_OPS_TS_SW_OPT_CB;
 			break;
+		case SCM_TSTAMP_ACK:
+			cb_flag = BPF_SOCK_OPS_TS_ACK_OPT_CB;
+			break;
 		default:
 			return;
 		}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 020ec14ffae6..fc9b94de19f2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7028,6 +7028,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_ACK_OPT_CB,	/* Called when all the skbs are
+					 * acknowledged when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.37.3


