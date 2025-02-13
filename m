Return-Path: <bpf+bounces-51330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39819A33437
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 01:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006CB3A803A
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 00:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BC284D13;
	Thu, 13 Feb 2025 00:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdBf3Oug"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1422478F39;
	Thu, 13 Feb 2025 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407451; cv=none; b=YrmQedMcA6AJ0av+qbzuGE1x+9Pj0bQH273v02+oQZRYBGvcaxJdRd7VnMLau+gkLy7FwGNxCw7vfxMmaZxiwM6uG7+TOl6xazbd/ez7vej0eWKeUqCgFyFmo1ZYpFG+HtOiWgcHkZpFpBnj/OxRvr7KlcTkccFOmQcosewyxnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407451; c=relaxed/simple;
	bh=4ZB7lKfheazXc1YfiXI2G/ICBAu5E5fQcKEl4UMlf8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mYXkHUU0qMuu3N1TIof5z3R2sCiWW0PXcXb10GD0/pQygmrGX7KbgWNrA1Nr7l7IFQN/uej0alMfDBRMUl5KNdDMc52/GbkMJ3kR7+RQFGOsTC9Gv0qJFJNsX9yU9A8by/iDbJoGAGKoIGN37PuWPywCEGxlPECKOYMNw4g+Z4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdBf3Oug; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f5660c2fdso4944975ad.2;
        Wed, 12 Feb 2025 16:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739407449; x=1740012249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xijuzipHBNdGLwUwwHqZ3Q998EyPsGhqmxBLA9ACfbk=;
        b=bdBf3OugB6adA7AQXSVvyAInbW8lhhTChhO7L4o0pM7EHUT1B8x4Us8sn2roVmHcW4
         FLs97NcLAHn2YOeNibZp1S0ae9nae08CxRHsRUbVr0a4Juu19kfcSLONOmP/9+rGUlHU
         PlFDvk4TQHfsxvxWaXsisj1pVH6fhNvRDDvFhn4OsyqMANuH8N+CyiAXCR/aeB5ropOs
         CWSH9/fMNQubXrE6PJrgVdN9xja4+5YPorEyNy436hH80JS5Kl/mwERtF3jFp7+Ujab5
         gezVd5UIxJum26vjML9zByBWmteCKYa6RMr6WidfK3v/JXkA3XXSizJvH2L2LK7DEvsG
         8Zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739407449; x=1740012249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xijuzipHBNdGLwUwwHqZ3Q998EyPsGhqmxBLA9ACfbk=;
        b=neT4S3XfUeKJlqKtaQ8Q4jIQBDx17F6epP7epxtCymqx+eUycYNiFTr2iRGEjaNXF6
         YXt3uE867Aw8KxZgKav7550eGnpbWUvQvKxUuk+HIG5UN4rLo+CqLV0AROKJ2p6Pr1yF
         CdKGRHcawXXR6zxKT8Kgv1HRWZJFHoYq0MNSXTby7oCds403vznDY7AIvEQTcyJEK9+P
         pEcDiMUL3mIr77MRp6QT0bToXIcvK+RlyucjYh+RUmDqrD3q8/yzJMESMXOyT+aFeNof
         fBzp1d8fzy8LEjlGAEHQqQFKjFXO5I5Jze6UK0pZStGmgvkCEYuClWo51dHEsZJtW/A0
         10LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY+8UoC6hNIUyR0vX7Ae+HcGN6HDc9/ZCBaM9/Hi4+JPjatu+/S0vgqLmS1Y6Sv9McJPIst5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+yCqq50aueTexzzuhCXLJR4vG6MzWLCU/amMzZ857S7qbWkWv
	9K0ClNaafXH6gqxoWxku5BwDX6MChGBsNfCrPpUhmf8L4Zdqk57M
X-Gm-Gg: ASbGncvj6Um1Ry33DY4f11adiX3MPXxKk0BtDinjr666eoSV3d9qEFNTeEM2Fw4BYlA
	Kvi6mdG9kst8Xo5Zm6Qzax/O/QUlp8DkF9UmqzTQYZRickqBBWi3EBHWNPgeTHgpZUMydMKZag8
	wO05Eb6ss8VrydD6d3WPEXBQ2HOWcgld4QoOh9j6GTVEIUfhRMwfTSvpDg4kTEzRnoCQdUtienH
	cIbEM77oXshjb21lGh/LsqbeOL/ta5E22AjZNio1Zl8Bf9HwKBZX6cJyUmXlqRqrsX7ShfCPS+q
	1CJONbsLZhP4qUE08hBUsgkSbaXlrYQgNYGLbWJDR463XT6wNCulwQ==
X-Google-Smtp-Source: AGHT+IE8AvQXooKTtwvZmuaozmvTuHWm0dHdQcMxqGUjIHsnV4dAivlBQWHYuQ/f35rmx0keS/8OEA==
X-Received: by 2002:a17:902:f683:b0:216:53fa:634f with SMTP id d9443c01a7336-220d2126541mr19879295ad.48.1739407449195;
        Wed, 12 Feb 2025 16:44:09 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ad3fb8sm63618a91.26.2025.02.12.16.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:44:08 -0800 (PST)
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
Subject: [PATCH net-next 1/3] tcp: add TCP_RTO_MAX_MIN_SEC definition
Date: Thu, 13 Feb 2025 08:43:52 +0800
Message-Id: <20250213004355.38918-2-kerneljasonxing@gmail.com>
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

Add minimum value definition as the lower bound of RTO MAX
set by users. In the next patch, bpf_sol_tcp_setsockopt()
will use this in the test statement.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/tcp.h          | 1 +
 net/ipv4/sysctl_net_ipv4.c | 3 ++-
 net/ipv4/tcp.c             | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7fd2d7fa4532..b6bedbe68636 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -143,6 +143,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_DELACK_MIN	4U
 #define TCP_ATO_MIN	4U
 #endif
+#define TCP_RTO_MAX_MIN_SEC 1
 #define TCP_RTO_MAX_SEC 120
 #define TCP_RTO_MAX	((unsigned)(TCP_RTO_MAX_SEC * HZ))
 #define TCP_RTO_MIN	((unsigned)(HZ / 5))
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 3a43010d726f..53942c225e0b 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -28,6 +28,7 @@ static int tcp_adv_win_scale_max = 31;
 static int tcp_app_win_max = 31;
 static int tcp_min_snd_mss_min = TCP_MIN_SND_MSS;
 static int tcp_min_snd_mss_max = 65535;
+static int tcp_rto_max_min = TCP_RTO_MAX_MIN_SEC * MSEC_PER_SEC;
 static int tcp_rto_max_max = TCP_RTO_MAX_SEC * MSEC_PER_SEC;
 static int ip_privileged_port_min;
 static int ip_privileged_port_max = 65535;
@@ -1590,7 +1591,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE_THOUSAND,
+		.extra1		= &tcp_rto_max_min,
 		.extra2		= &tcp_rto_max_max,
 	},
 };
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 992d5c9b2487..2373ab1a1d47 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3812,7 +3812,8 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 					   TCP_RTO_MAX / HZ));
 		return 0;
 	case TCP_RTO_MAX_MS:
-		if (val < MSEC_PER_SEC || val > TCP_RTO_MAX_SEC * MSEC_PER_SEC)
+		if (val < TCP_RTO_MAX_MIN_SEC * MSEC_PER_SEC ||
+		    val > TCP_RTO_MAX_SEC * MSEC_PER_SEC)
 			return -EINVAL;
 		WRITE_ONCE(inet_csk(sk)->icsk_rto_max, msecs_to_jiffies(val));
 		return 0;
-- 
2.43.5


