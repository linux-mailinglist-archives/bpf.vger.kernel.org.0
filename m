Return-Path: <bpf+bounces-51331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47133A33438
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 01:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E9A07A33DC
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 00:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5017346F;
	Thu, 13 Feb 2025 00:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNbtrKLZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B810E4;
	Thu, 13 Feb 2025 00:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407457; cv=none; b=nsMN9MHsBDJHAbCP8qTH2UVmp7lAHib5EOgDvm2YMykRlJ5Xiy7n71I1EueDxti4gz7TdWVki0Hap3PFWWnh8KSG5tlWGN0V4tz5eUIXB+o9JySIQh7DvmckXquBHDyhNwbW1y4TjJgOYjgbj8u7d/zvBLNP0LkAHP/RSh7+ovA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407457; c=relaxed/simple;
	bh=gRg0dmDhSNl5umDeJNX/yDt3bI0tY5M4cVFXyTsU7k0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J9NxJS8SeKO8kFfqxeQwrAoGcYBNyQruflGleA/LJZnT8wNF6/bLs2J1QoHh+vzWgSZe2q6y/VJ7Rlc08wb0+b0QFg3aU/bax4v9CnSLK3tIXdT0Oq8bKjCq7UAvUfLZ8ctDOIEpfcS3cJ8Q8iH4S93hhA1drP67ArsB0QPxaxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNbtrKLZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fa3fe04dd2so541130a91.0;
        Wed, 12 Feb 2025 16:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739407455; x=1740012255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGMQbUVA6s71dYgqJsnF/GqiIFh2VzMRu5Ark4dBeIs=;
        b=QNbtrKLZziRGEbjUudB0+VC9nQ1TjKb/IuZ0tMQQt09AwX0rxzZOAL9f4gsQLTFeGo
         2/d+yePY5paVDy69MIvu/h/4ZQ+N2bQiR/NPXGVeGquY86aNy7gROs2tiL/oIYio6tTB
         ceGsIuNrPNi8z+SVL/eMOqzINQdtSTU5FDK38/INutkAoB1/t0RLW9/5YMli3DhlsoAe
         dIWgW7YmthLLUh7rNl4tKAxh//6H/jkQYlGTODQRmpcQ8O25ZowlFc5LJdULY4cS7SZn
         OLvVHXe2uIIHUhN93YB5rP5tiKG29uT1C417s44QMWCDysqRmwVIA4ZbF3PgLJLLjNhl
         Vh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739407455; x=1740012255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGMQbUVA6s71dYgqJsnF/GqiIFh2VzMRu5Ark4dBeIs=;
        b=a7xK5hIB7loWRzPa5NPGOPH/2beDBLDxq/oFKyxtGapKuKq3XiQfrurxsZBdv+btDC
         Ke3RfQyke5kGNi1aeCVzzDXb8qIEmeu6MK120hyTYGqUUVfOnA8/BfhAtK2cRtOagLyS
         mJMZQFIY6s7Y8sOBUTgPwJBZQJHIeEjHFx/5oFjQ5oC79fdpyGJoue9V04iPAs4fIW25
         DPcOi4rtVURawdQ6pgoQFnaitIxV1OZ8LdLKNVZvISyIMq48mXiGjZx8lk+/RjMviBRV
         cwHHmmEV7fuO2yLSZY8uc6aWA8vRDx+rm8o+ZN48lCb3yLqZCvCTUgX1nnu5grMSFzEb
         pCdw==
X-Forwarded-Encrypted: i=1; AJvYcCUSQjaHQ9qdxLuoslPwfsndNiSyun42TDLPJmvOIlGsF1L8I4e1/SrZUQLviZHkA3oj3Say810=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtcrJaQc1pLj3ycoj/HRe6qEBqEeENSFROOhdI3kpaPxprzk/S
	mmoYFZ+EIiUgMSXZjj2q151GO/vZKYvnzlaQVYh/Bpk3mggYwGHj
X-Gm-Gg: ASbGncsavKRfQzhfG5my8O2uOslt3IV2+kQ5+Fgdl4wTW3BCCH1J5vvavyTa3Ciwl24
	h3JQF2cMnxBJ7IJb4hQ2yTMJ3lO/W+2dKHHoBvW+fitaIGxUaqLu0YZExU9wLBPb1P2n9mQbxl/
	VKCpwzhUgKV4zzDSEMFl4KGETHippVZn9/FehwIh8iTVsvh3Xl7GT8uiUs808g/Ww7Q1Yco7+th
	V+RySlMzfCHTxHLZWzwtJkxcxUwm3tUlav6UBK12vomwxjQlb3tuO4t/RWiMGJNLPnQtBWCSiXh
	j7rAwa5I2VZgX5OLeUEOyrQFLidp42RgAM+8aVtKHf9Iscqo+dUKfw==
X-Google-Smtp-Source: AGHT+IH/xF/Q9egjOvI2AlKVcbFb3lPEErcPtrDnE7EMAmzH1GNJZx/Vk+rouqQYboBWkfPmbzdN/w==
X-Received: by 2002:a17:90b:254e:b0:2f6:539:3cd8 with SMTP id 98e67ed59e1d1-2fbf5c0f490mr9245177a91.18.1739407455144;
        Wed, 12 Feb 2025 16:44:15 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ad3fb8sm63618a91.26.2025.02.12.16.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:44:14 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
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
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@amazon.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next 2/3] bpf: add TCP_BPF_RTO_MAX for bpf_setsockopt
Date: Thu, 13 Feb 2025 08:43:53 +0800
Message-Id: <20250213004355.38918-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250213004355.38918-1-kerneljasonxing@gmail.com>
References: <20250213004355.38918-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support bpf_setsockopt() to set the maximum value of RTO for
BPF program.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 3 ++-
 include/uapi/linux/bpf.h               | 2 ++
 net/core/filter.c                      | 6 ++++++
 tools/include/uapi/linux/bpf.h         | 2 ++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 054561f8dcae..78eb0959438a 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1241,7 +1241,8 @@ tcp_rto_min_us - INTEGER
 
 tcp_rto_max_ms - INTEGER
 	Maximal TCP retransmission timeout (in ms).
-	Note that TCP_RTO_MAX_MS socket option has higher precedence.
+	Note that TCP_BPF_RTO_MAX and TCP_RTO_MAX_MS socket option have the
+	higher precedence for configuring this setting.
 
 	When changing tcp_rto_max_ms, it is important to understand
 	that tcp_retries2 might need a change.
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2acf9b336371..8ab6ef144217 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2868,6 +2868,7 @@ union bpf_attr {
  * 		  **TCP_NODELAY**, **TCP_MAXSEG**, **TCP_WINDOW_CLAMP**,
  * 		  **TCP_THIN_LINEAR_TIMEOUTS**, **TCP_BPF_DELACK_MAX**,
  *		  **TCP_BPF_RTO_MIN**, **TCP_BPF_SOCK_OPS_CB_FLAGS**.
+ *		  **TCP_BPF_RTO_MAX**
  * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
  * 		* **IPPROTO_IPV6**, which supports the following *optname*\ s:
  * 		  **IPV6_TCLASS**, **IPV6_AUTOFLOWLABEL**.
@@ -7091,6 +7092,7 @@ enum {
 	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
+	TCP_BPF_RTO_MAX		= 1009, /* Max delay ack in msecs */
 };
 
 enum {
diff --git a/net/core/filter.c b/net/core/filter.c
index 2ec162dd83c4..a21a147e0a86 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5303,6 +5303,12 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
 			return -EINVAL;
 		tp->bpf_sock_ops_cb_flags = val;
 		break;
+	case TCP_BPF_RTO_MAX:
+		if (val > TCP_RTO_MAX_SEC * MSEC_PER_SEC ||
+		    val < TCP_RTO_MAX_MIN_SEC * MSEC_PER_SEC)
+			return -EINVAL;
+		inet_csk(sk)->icsk_rto_max = msecs_to_jiffies(val);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2acf9b336371..8ab6ef144217 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2868,6 +2868,7 @@ union bpf_attr {
  * 		  **TCP_NODELAY**, **TCP_MAXSEG**, **TCP_WINDOW_CLAMP**,
  * 		  **TCP_THIN_LINEAR_TIMEOUTS**, **TCP_BPF_DELACK_MAX**,
  *		  **TCP_BPF_RTO_MIN**, **TCP_BPF_SOCK_OPS_CB_FLAGS**.
+ *		  **TCP_BPF_RTO_MAX**
  * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
  * 		* **IPPROTO_IPV6**, which supports the following *optname*\ s:
  * 		  **IPV6_TCLASS**, **IPV6_AUTOFLOWLABEL**.
@@ -7091,6 +7092,7 @@ enum {
 	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
+	TCP_BPF_RTO_MAX		= 1009, /* Max delay ack in msecs */
 };
 
 enum {
-- 
2.43.5


