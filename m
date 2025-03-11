Return-Path: <bpf+bounces-53793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C724AA5BB4C
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 09:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056FF17172E
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 08:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C0222FF44;
	Tue, 11 Mar 2025 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eT9DB0K8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109F22F39F;
	Tue, 11 Mar 2025 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683402; cv=none; b=N85Ubc+ARtPha/O7LybJYETWvTSAOPh2SUV8nZFSsRdwcntBy6UmKxiUkfHFZpafOOjUdRyprNJPDOE0EkE5Rw8CYHG7YIuvnteHKhXtDY72F57uopbyG94lLUaz5k/LXedbOnSBaTtbNSO7hgZok66GhCQu+3bVIAZQzKJR0nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683402; c=relaxed/simple;
	bh=UVq854qgEpvP1dadjyuCmR0djax6WDkNt1BAcWtfAMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GL/h//jUG4aJrcjb1uBn/I3lzNNFiKE8pJsmTYOsfDDLjD8bis1fNc6R1ELJJ2WtxeH1VFPQxA2Ad8vDQwx48rNevq9AExqAFgrwz7xa+BaMJ6szW+BCnxrxR2zIZWqIKH+oz7mzkDdlmsTu+Z3hJsHV2+plT9tLJXNL1DUfKM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eT9DB0K8; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5b56fc863so7504606a12.3;
        Tue, 11 Mar 2025 01:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741683399; x=1742288199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONap8g/E/8Kd+50+E5mpWbiiyyQkbjrVWKMdb9y5KnA=;
        b=eT9DB0K8z12E2a0DnXaI0wj4x7Gq0Ct6WVpV/g6eNS12NRnDaYpT0HgfMqUrySoEpP
         rK16bOsJbOYfEatkP3zMIwpH1seF60Funn1OU/hktbef8dOjwuOq+T71NveyzuOQyXfU
         jqiANvouhaMKjtrKcFw4ibjqeNA1y1U+NblIZAsu7fiBnY1j+3q9r6W0sHYp7Ruycspj
         tOoObi/82WKZh/m+TPG5tuTlfMNpbOsFy6RUnY7/SDV7wP4PHNu5ADZMexMrPCT4APbJ
         PxAmAcbIb7/X8SKjlUoDTTRzZJW4nHEFE1gPzToeAokmhr+c0tC2luU55l6Rm7EV+LMm
         fwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741683399; x=1742288199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONap8g/E/8Kd+50+E5mpWbiiyyQkbjrVWKMdb9y5KnA=;
        b=pxZvSDEto/xQVACMdBonI5uE2Tu1sfLM44ePce8bP30ACIsQG6uuS9ocUjsPrBpO9z
         On3HH6nu0woOYlMPeOHHIkWuaHOhD1uVbXoTLfn07n4ksWHI2Un2s6VRGpTBdrtV9VJJ
         07k0+Rxd76HqbDHtlpvpTOXWuQLO1qxNdKWgo9J7DMK4b2vxmcb9nllDJANNLrnjn93S
         EnTxx6HH4GrNIf3WMYZtprJLHwK4+iciDSRlBPjSjcQubJ8SrPD5f1czCx0hJ/O5iPu1
         V77NAW/Kry90xUlhkH58Cd+1BL4DENN8E4I+hLlsEaS9T1IXXyO3mjjWhhjokC9Uk/vH
         Nu/g==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+YyJuf4yvM0+MpI5HbbiWRfz+qFtNe/0P/lS4rZZ/cCIp/OlY2RLkKITHQvuo0v0L2WI/vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaxnFThSs9UV0z5onKBG06nGSDnDaUYMQldAqc2gLj4kX15vjv
	VKeSipYGFhcqMtx3M82k5Xa3BXtPbG5bOUwp+DOSegHqsq6F3qw0
X-Gm-Gg: ASbGncvtTjTTByaKxx54XV/FnThd1R9me4TmMcnN9TBBQLf4RB5t2mlR88ciw/fvrat
	KMu7np2ZGj8bc+5uwjgNnXkhiBgx2/4YEWvjyhkjVCGJ/c1ue1+7BfgoyWhvTq6NojQ+3rNUx3j
	YONpBHlm0VT+OZ391zp9iHSeCi9RXL3ABQyLjmGMGWeMFYHOCl23iUa10iUWWi1iAZvD0EOSa0i
	QtuYSIdoyjShwlg8r6I+4M4gPmkiifORgJs8Hph8D6CcjDkiSM0m0EFgCK0Am1+ofyfyspjNrQP
	Ek1hSEqNyk6pq8WGY7Jq2Ivdoe5DJWh2QY6gv9/4K/yjTaHihiSLe6QHS2MJo7x4FsZ+VGhlz3l
	CIKaekA==
X-Google-Smtp-Source: AGHT+IEZxbV2l8HM6Gn8Mgj6TjvQ5jVTp5hvU2YH/wQ5YOdU+CW6oY5QuMpFwvKMTvo6WhuSwIIdlQ==
X-Received: by 2002:a05:6402:d08:b0:5e5:4807:5441 with SMTP id 4fb4d7f45d1cf-5e75f985a89mr3500590a12.30.1741683398382;
        Tue, 11 Mar 2025 01:56:38 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766a16esm7965571a12.60.2025.03.11.01.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:56:38 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 5/6] tcp: support TCP_DELACK_MAX_US for set/getsockopt use
Date: Tue, 11 Mar 2025 09:54:36 +0100
Message-Id: <20250311085437.14703-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250311085437.14703-1-kerneljasonxing@gmail.com>
References: <20250311085437.14703-1-kerneljasonxing@gmail.com>
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
index 2a0fd56358c3..ed652c5e9e96 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3340,7 +3340,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	icsk->icsk_probes_tstamp = 0;
 	icsk->icsk_rto = TCP_TIMEOUT_INIT;
 	WRITE_ONCE(icsk->icsk_rto_min, TCP_RTO_MIN);
-	icsk->icsk_delack_max = TCP_DELACK_MAX;
+	WRITE_ONCE(icsk->icsk_delack_max, TCP_DELACK_MAX);
 	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	tcp_snd_cwnd_set(tp, TCP_INIT_CWND);
 	tp->snd_cwnd_cnt = 0;
@@ -3828,6 +3828,14 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
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
@@ -4673,6 +4681,12 @@ int do_tcp_getsockopt(struct sock *sk, int level,
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
index 9a3cf51eab78..00267b17f5e4 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4173,7 +4173,7 @@ u32 tcp_delack_max(const struct sock *sk)
 {
 	u32 delack_from_rto_min = max(tcp_rto_min(sk), 2) - 1;
 
-	return min(inet_csk(sk)->icsk_delack_max, delack_from_rto_min);
+	return min(READ_ONCE(inet_csk(sk)->icsk_delack_max), delack_from_rto_min);
 }
 
 /* Send out a delayed ack, the caller does the policy checking
-- 
2.43.5


