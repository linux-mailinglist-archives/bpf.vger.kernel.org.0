Return-Path: <bpf+bounces-51717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB53A37A2C
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 04:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F3C3AF2C2
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 03:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0C416C850;
	Mon, 17 Feb 2025 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRLcduPR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14C71531E9;
	Mon, 17 Feb 2025 03:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739763831; cv=none; b=H6r3jHIy9YHgM0JL/O9j7kOROhVt1gv13H2qIlbzO4CdQptbtBwlX9ZTjEe3yoLIOPXoSRZmwT/1XKyOYGEMPm07XHPmfGBD71oHi9hR/nG/f3etDsr9CCdIp6hPDoMI7oWYRAPFdk+VdqzKce+MXG42FNLmJvNCIRvYMdxUw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739763831; c=relaxed/simple;
	bh=9QNM3AscLlH25zdbGoqJzoGC3Cbg2xkQ4m6U6PwOPUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U1yn4tmLJYjT7qUGvo5D5NK0ETXiVsbYafmUnOnJWbTtCCpFAOeZUM+afb+2w1zaVr378Su8FgpQFfKX/HBAohqCpYFQrUQQvnuyicLFQDgpI+FRl+w2Ow1WDd00B/lY3UJ9l7eF8+disw316AvqZkk2IzF06xCVKHg969UCe2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRLcduPR; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fc33aef343so4294649a91.1;
        Sun, 16 Feb 2025 19:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739763829; x=1740368629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B57NruNT8Me/w38M2LO6Hk9MWp+zWLpI7IL2YwomIyQ=;
        b=JRLcduPRxMVndTgH4bNxHtVwoD+iwrfIRCMljfkrmD2thgVNbHCtrl0om0TSW6lWfX
         dYAqzNHMvLprdN00O6z4qGgYx/Wnh3u7ZJ+ewFc/vK/40zgx/SMy1lBR+EIomder+MZP
         tDYbAUhuo0JCpJHOWljQxFphJosGD4uWnxRbrbVUk32YbIq0pfMCeJlxGuGy3AE9WQR9
         KlFuHD8gSNviCx1PtcHdEzwccINEFpWdhIJIca+jrbbChwKc1b1Ij9NvBI3g2xmqC5lT
         uiGIYU6F5aPv074tV7jY4Bcv/YwCkmkRJ7qu85PilqTTB0xkprd8wXUwZTcOwIGXdRgS
         aZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739763829; x=1740368629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B57NruNT8Me/w38M2LO6Hk9MWp+zWLpI7IL2YwomIyQ=;
        b=svceCUa/HBpZT5piwIpHhjOB2KclIGTSUjMxQeukUgU65Qho+sBWHWmWasxL0EmtZu
         VQZuOjRLpBbh9iFWg+j1ZJvvsT8LgUPQIGjluz3OU6FwIgaDaRxR4H2r1jd0Jzi5bYG7
         UOjZQBjHfCIem1GT96YxeLcH81gwAy3USy/sKYY60oovu4P/ys042bEqYe/llehAPKcf
         n4R/GlbQLIVBm5mVaV5Xj6fksF2DE4X/8wWvSeuYKEhoIRDeBMMXwvgko8gkb6dGV9fd
         xNL7vjCo1t9DWq5ChSAzA2U3Gssb7qzWr/rKfJ4CV3+GJdXIuwjc7je0crQsa465XzdL
         1IzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0Ec9DV6RihFbLi0trAKc5VPwtg9sVG4T9S4xAKYsgSq1a6oAlQLdxqweUEhWkfiBecPwSvY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq7rMzWx24t5j1EBVX1ceycf7p4I5/OTypw8B3ML4j4NwfYTIs
	vCCCKBf/OYv/eRfjErDYvUxRZYpv82O/pL+2xbtHHfLAdr6HdSlJ
X-Gm-Gg: ASbGncs51Btb2x9gCP6OyNvlYXIjnALcmdgNCHci5Q8/xZ+YOPrc5PwuO9LYyw5x+Vt
	3FGAc9tg3Wr8iFeMwACdzCtYBX3W4NviNAkg4BA1BWDVz9IgiLl8up3puGc41hUlEy5NrBL5w9C
	rjzTfXwnhVCnjvIo6DYy8ZdiYy3J94ckWHPMV0szerZE9aut3QwBfwjuXJn/3cMs9irQg8h6Ya5
	sWYpkPcZwDdkopqWmq/9cG5N6zrnH8qWpIevOgMeyX4UQ1cX8Bo3vp1XjgRbg2zEifK/NOR0oH6
	NfFjF2giSZeoqz1LouKMDzTE5IqUGU51u3FiFU6eYWSfpyAw7Pn7C2B3L/nxfKc=
X-Google-Smtp-Source: AGHT+IEs+22WmmhwfGOFkeqzMbKXOL89TanbzvuylQy7Tc3in0VurD10NCuELWaHJjVAvZxQ5QwYog==
X-Received: by 2002:a17:90b:4a0c:b0:2ee:aed6:9ec2 with SMTP id 98e67ed59e1d1-2fc40f10287mr14653472a91.14.1739763828996;
        Sun, 16 Feb 2025 19:43:48 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536b047sm61966585ad.101.2025.02.16.19.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 19:43:48 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com,
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
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: add rto max for bpf_setsockopt test
Date: Mon, 17 Feb 2025 11:42:45 +0800
Message-Id: <20250217034245.11063-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250217034245.11063-1-kerneljasonxing@gmail.com>
References: <20250217034245.11063-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add TCP_RTO_MAX_MS selftests for active and passive flows
in various bpf callbacks. Even though the TCP_RTO_MAX_MS
can be used in established phase, we highly discourage
to do so because it may trigger unexpected behaviour.
On the contrary, it's highly recommended that the maximum
value of RTO is set before first time of transmission, such
as BPF_SOCK_OPS_{PASSIVE|ACTIVE}_ESTABLISHED_CB,

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 tools/include/uapi/linux/tcp.h                      | 1 +
 tools/testing/selftests/bpf/progs/bpf_tracing_net.h | 1 +
 tools/testing/selftests/bpf/progs/setget_sockopt.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/tcp.h b/tools/include/uapi/linux/tcp.h
index 13ceeb395eb8..7989e3f34a58 100644
--- a/tools/include/uapi/linux/tcp.h
+++ b/tools/include/uapi/linux/tcp.h
@@ -128,6 +128,7 @@ enum {
 #define TCP_CM_INQ		TCP_INQ
 
 #define TCP_TX_DELAY		37	/* delay outgoing packets by XX usec */
+#define TCP_RTO_MAX_MS		44	/* max rto time in ms */
 
 
 #define TCP_REPAIR_ON		1
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index 59843b430f76..eb6ed1b7b2ef 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -49,6 +49,7 @@
 #define TCP_SAVED_SYN		28
 #define TCP_CA_NAME_MAX		16
 #define TCP_NAGLE_OFF		1
+#define TCP_RTO_MAX_MS		44
 
 #define TCP_ECN_OK              1
 #define TCP_ECN_QUEUE_CWR       2
diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index 6dd4318debbf..106fe430f41b 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -61,6 +61,7 @@ static const struct sockopt_test sol_tcp_tests[] = {
 	{ .opt = TCP_NOTSENT_LOWAT, .new = 1314, .expected = 1314, },
 	{ .opt = TCP_BPF_SOCK_OPS_CB_FLAGS, .new = BPF_SOCK_OPS_ALL_CB_FLAGS,
 	  .expected = BPF_SOCK_OPS_ALL_CB_FLAGS, },
+	{ .opt = TCP_RTO_MAX_MS, .new = 2000, .expected = 2000, },
 	{ .opt = 0, },
 };
 
-- 
2.43.5


