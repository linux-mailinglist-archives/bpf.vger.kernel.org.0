Return-Path: <bpf+bounces-53683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A96A58410
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 13:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB1D16BAF3
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70A21DBB19;
	Sun,  9 Mar 2025 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFoIGoYs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E31C5F28;
	Sun,  9 Mar 2025 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741523446; cv=none; b=U/aPFRX2EGGZThYYQUCZpRe0ydGxtROw/agEwp2drZhxgv6PxDjHLaHHHtVBnfNKBxP/8q5r4+epaeslt2Ohd869io1k6RCRtuuB2sYtSiKaR3HSC8TnwBY7vhlb0VmsvLvXKhMkH2ZC8HKEl5FDclNQoIIPbci9f9J0C8BjSfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741523446; c=relaxed/simple;
	bh=NOW2XrmUVA1NK3Nw/539Y0a503B96ritDqC6eaIURIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t54ZFoNvSJUVhN2E6thF60vzdN/kJ8HVEaWImX7DCuTD9lXwYH5H1JGeUB+L2CulXukXiQymFx+tHUmMo7pG4gpuWpyUWsqnYtdFuXil1R99OTaeO47pUpUd8gafPnC9hGXUG/WT02Wgk6MnxCPEQe44g7eU8mGpuUIDbVVoHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFoIGoYs; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac297cbe017so41186066b.0;
        Sun, 09 Mar 2025 05:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741523443; x=1742128243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiRYmKaC3kfh25G+XT/95pzhdM3mQ1S2KNDwZbDo1Ec=;
        b=QFoIGoYsuKz4uEJTQ1VP23SES9idAbm4nTA1CKGnzJHvUgeDogqiICbpcwe88GHQeX
         YPmHut+fZ5GImlkdDyo8NSd3tkjQjPQcvsyReSzhUkvy9AawfiaBpHna8q7eO1vjrFQp
         rHV8fx0Gii6fkpzWznpb0SacpENHeRKDF/50pdCYqdXuOPqDN/oeGUNzBx/eLiMsdME3
         6xOHXASYTHI45HK5P0aAA7dgZFwtv6RkTMtRu4ADkXvMwdH4klUDziNhN59mOVpojMlj
         hEM/ET83+88wgDLKi3xYZo4pL7Nn4InM0fsIS73jtwJgb58jTjcJxOU6NFKactPPRtg8
         mLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741523443; x=1742128243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiRYmKaC3kfh25G+XT/95pzhdM3mQ1S2KNDwZbDo1Ec=;
        b=eN3rKPclKXQYV3cu/i8e/k/Jp/jyVzLngJYkBws8bO/vB4YEtPCLAgaNjsbhDbho1j
         3fSrWD6ZQAa11xo3ERO8oEOIFdXXEQg6BvGJq3WFPe8DRJriZfCcyRAk59efJzp9Fuq0
         vFWx6QRfGglBLdBSloPU+EfpWXy1d7nrEYiltsNkoZnPxCCUDh38g00NnoIpRD4iEcuI
         dfy+4shL6VzIZLM57n3nuNSfrSM70erUjoO9SdztDBqwUKtSBx8YRh/WUXD5Q567TL2X
         T2GY7jvN8cL+WRAXM+Ioh3lPmSM6epE912g+++7sGctUCc/x/v+IRF5yMRtBITpWY1/B
         Iydw==
X-Forwarded-Encrypted: i=1; AJvYcCUctQHzBdIGKeSPvExfdBMYg4C7x/cK3dshNMMAJLaEVBkF39ZdoIUv6k8ilwlqUh2IcUebEvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzig8L2kNmInAacb5vyXnrT4EoJXxeWrCZ+bEAvWTJ2teYjjPsB
	f/dz9KZ+saI5JOnlne56DWMHoMXO0btbYJ043xh2b2qZNTTYejXx
X-Gm-Gg: ASbGncuDEoGsD1gxYGsjtlXl4mq3WEHryQXKKbKIockno/6CvswnHM/KmeOe+DLvC+P
	An2WdISd0JfwwDQK2PQICwFFArEZvH3OTJfwh4XFKtUVTYjH0sstM7nugn1etZhG7+c7sJtT7gS
	4/ni7X40byEdCB/1f/nrd+ZBmMPwDpe6DDdYH3RIjEdNuQY4fUqreKnO8KYunJzrSB686d7q8vC
	R+PHhVg7hoNdWpMrMszxavj4/YqhptkAGRJgWuuubZNo4jz3rUh8J+IOFg9jgqOu0cPe1d7A4Md
	dG3YZtSUauRzxjVCV4EumzUaqfo3EiqkjBOfrz2UhY6kQ8GJBAN2zYr9xZ2VE43XjBABff5jluf
	GCnFKhQ==
X-Google-Smtp-Source: AGHT+IEXIbXLU9EVr+jXVBEp+LLMXw1wTqtGX3sudrIqAEbOqlWICN4G5+2cFFH8tamEF5QBgCp8wQ==
X-Received: by 2002:a17:907:d40c:b0:abf:6951:4bc2 with SMTP id a640c23a62f3a-ac26ca5934cmr635709766b.7.1741523442643;
        Sun, 09 Mar 2025 05:30:42 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac29c19603dsm39144066b.38.2025.03.09.05.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 05:30:42 -0700 (PDT)
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
	kuniyu@amazon.com,
	ncardwell@google.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next 4/5] tcp: support TCP_DELACK_MAX_US for set/getsockopt use
Date: Sun,  9 Mar 2025 13:30:03 +0100
Message-Id: <20250309123004.85612-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250309123004.85612-1-kerneljasonxing@gmail.com>
References: <20250309123004.85612-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support adjusting delayed ack max for socket level in non BPF case.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/uapi/linux/tcp.h |  1 +
 net/ipv4/tcp.c           | 16 +++++++++++++++-
 net/ipv4/tcp_output.c    |  2 +-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index b2476cf7058e..2377e22f2c4b 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -138,6 +138,7 @@ enum {
 #define TCP_IS_MPTCP		43	/* Is MPTCP being used? */
 #define TCP_RTO_MAX_MS		44	/* max rto time in ms */
 #define TCP_RTO_MIN_US		45	/* min rto time in us */
+#define TCP_DELACK_MAX_US	46	/* max delayed ack time in us */
 
 #define TCP_REPAIR_ON		1
 #define TCP_REPAIR_OFF		0
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index cec944a83c2d..100135117cf2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3353,7 +3353,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	icsk->icsk_probes_tstamp = 0;
 	icsk->icsk_rto = TCP_TIMEOUT_INIT;
 	WRITE_ONCE(icsk->icsk_rto_min, TCP_RTO_MIN);
-	icsk->icsk_delack_max = TCP_DELACK_MAX;
+	WRITE_ONCE(icsk->icsk_delack_max, TCP_DELACK_MAX);
 	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	tcp_snd_cwnd_set(tp, TCP_INIT_CWND);
 	tp->snd_cwnd_cnt = 0;
@@ -3841,6 +3841,14 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		WRITE_ONCE(inet_csk(sk)->icsk_rto_min, rto_min);
 		return 0;
 	}
+	case TCP_DELACK_MAX_US: {
+		int delack_max = usecs_to_jiffies(val);
+
+		if (delack_max > TCP_DELACK_MAX || delack_max < TCP_TIMEOUT_MIN)
+			return -EINVAL;
+		WRITE_ONCE(inet_csk(sk)->icsk_delack_max, delack_max);
+		return 0;
+	}
 	}
 
 	sockopt_lock_sock(sk);
@@ -4686,6 +4694,12 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		val = jiffies_to_usecs(rto_min);
 		break;
 	}
+	case TCP_DELACK_MAX_US: {
+		int delack_max = READ_ONCE(inet_csk(sk)->icsk_delack_max);
+
+		val = jiffies_to_usecs(delack_max);
+		break;
+	}
 	default:
 		return -ENOPROTOOPT;
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 24e56bf96747..65aa26d65987 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4179,7 +4179,7 @@ u32 tcp_delack_max(const struct sock *sk)
 {
 	u32 delack_from_rto_min = max(tcp_rto_min(sk), 2) - 1;
 
-	return min(inet_csk(sk)->icsk_delack_max, delack_from_rto_min);
+	return min(READ_ONCE(inet_csk(sk)->icsk_delack_max), delack_from_rto_min);
 }
 
 /* Send out a delayed ack, the caller does the policy checking
-- 
2.43.5


