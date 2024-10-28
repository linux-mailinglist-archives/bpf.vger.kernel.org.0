Return-Path: <bpf+bounces-43287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD4B9B2E72
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 12:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE54B22F66
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 11:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D279E1DF733;
	Mon, 28 Oct 2024 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDNTsp66"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7251D1DF720;
	Mon, 28 Oct 2024 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113593; cv=none; b=QMpe7Hk7pLcA7yhJAfh2e3SygOMt2DZANaemn/+QEK2uv2DDz6UE8r9KDF/QMW2YMBK9RYZ/vGW30bmO7qNDboYMoDaBqgL/hh5bGomapW5d8w33Wmbg2qMku8ro6r+DMh0INC0D++0Tc8DIHb8vVoVhU/PX/8j13THK1h2aVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113593; c=relaxed/simple;
	bh=CB6K3j14X/CVRq/52BsIc7pB+5IDgpJbM+3S14LdwXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dUQ+2ukfjwzIllehPm5ZE1B567w6Lj/3/TkjU/dNqbWde3css6Aqt3yRaKqOAUsjvq7yLl37cYBFrSSx6yIZ+P8O4yBGQWYNyajx2omYgiYBr3GvrI1jwp0osc5aA+lGmVt/oKadktIEVuLkQK2mFXYEJpKmNM9Jj95SJzW4Eic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDNTsp66; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c803787abso32082475ad.0;
        Mon, 28 Oct 2024 04:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730113591; x=1730718391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDr+6JoYtBk0XGAFGCg5P5S3RT7qdV0GMOwN8CvM128=;
        b=BDNTsp660AW2mVHgMHmYEzvEJcpt3EzfNl79TZioFt0Z24L8ijpo7IbMLUGY79kydk
         Tz+NmFQ1p3r+UESICqoH5oz5WekzbyQ/KmtkyZ1JXthSOEvK2C+ymlGs1DzFirkBP2sO
         QocEjiS/noKSBQGD5Zs83mOcpYri1o8uJ9mvkOj/i8ZxDAsYmvfviH2nPQyYbsulZI7/
         fYWpoIN0NbbHbfZYt0CRHdspod9FwpdnhinSRlmEEIJZM3bo9XMALx6l2cf2XRxXjeRZ
         u3m8QOC8rOcjLEPm5zpW2EgA8+FDYO84X+B8skQl4YSJH/XOEnOQv4Gp33b0cixIJi1D
         lCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113591; x=1730718391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDr+6JoYtBk0XGAFGCg5P5S3RT7qdV0GMOwN8CvM128=;
        b=XQMi1VP9zZkzAaF4eExE5HJZBNBWtXS1ub/kfe1iCZe35d0uFdXOXVec1LtrrtxgCi
         0eHR4GVzVR659RAdj3/YSWbK2ZuAki5h3i7u3rA3Yb1QCgSZyBFCphlqrzBXDDkzhCTW
         wACnlDe/QZUX0Kb8FE5/Qa7f208LGhFYb9T9FgtozLu2gIp4ZYdWy/BQz95rwDyPAfO0
         ta80zh1tdBZLdaKQdZEq6kz4BQgYqb2GfazLZcGPhY2LFazBKOCjk00JX/ePUypP+++J
         R2oVyihZW/4NLtWbcGbh7gAekfnZPv5ku3xMfs7J+vUXUJCOyNj6tpJf9/quvEN1oT7T
         GZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8c1k5VTQ1YnjEJbEGGc5xx+LcCWg8VKVhpwGdzLYyaA/gVn0lSBuX/RcrANijltVz9QyRuew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGFOyk3ZrR+qtayX4BQNF8JxfDm7/q+YTtcrrML2fqzyiM6tKp
	UbfLKmRhRMDO9sdqNc2BIkZwDEiysfvezLxJLGD0WMDSYv4mDe20
X-Google-Smtp-Source: AGHT+IF+R8X+uwB2+p0Vvvzq/sZs3Il35XvlUuXZGeFT7V3j7FWeE7kn5FAAK4fYAsBr/aokW9fX3w==
X-Received: by 2002:a17:902:da8f:b0:20b:a41f:6e4d with SMTP id d9443c01a7336-210c59c6353mr103488775ad.15.1730113590619;
        Mon, 28 Oct 2024 04:06:30 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04bdb6sm48130905ad.255.2024.10.28.04.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:06:30 -0700 (PDT)
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
Subject: [PATCH net-next v3 04/14] net-timestamp: introduce TS_SCHED_OPT_CB to generate dev xmit timestamp
Date: Mon, 28 Oct 2024 19:05:25 +0800
Message-Id: <20241028110535.82999-5-kerneljasonxing@gmail.com>
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

Introduce BPF_SOCK_OPS_TS_SCHED_OPT_CB flag so that we can decide to
print timestamps when the skb just passes the dev layer.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/uapi/linux/bpf.h       |  5 +++++
 net/core/skbuff.c              | 31 ++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e8241b320c6d..324e9e40969c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7013,6 +7013,11 @@ enum {
 					 * by the kernel or the
 					 * earlier bpf-progs.
 					 */
+	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
+					 * dev layer when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 39309f75e105..e6a5c883bdc6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -64,6 +64,7 @@
 #include <linux/mpls.h>
 #include <linux/kcov.h>
 #include <linux/iov_iter.h>
+#include <linux/bpf-cgroup.h>
 
 #include <net/protocol.h>
 #include <net/dst.h>
@@ -5621,13 +5622,41 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
 	__skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
 }
 
+static void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
+{
+	struct bpf_sock_ops_kern sock_ops;
+
+	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+	if (sk_fullsock(sk)) {
+		sock_ops.is_fullsock = 1;
+		sock_owned_by_me(sk);
+	}
+
+	sock_ops.sk = sk;
+	sock_ops.op = op;
+	if (nargs > 0)
+		memcpy(sock_ops.args, args, nargs * sizeof(*args));
+
+	BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
+}
+
 static void skb_tstamp_tx_output_bpf(struct sock *sk, int tstype)
 {
-	u32 tsflags;
+	u32 tsflags, cb_flag;
 
 	tsflags = READ_ONCE(sk->sk_tsflags_bpf);
 	if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
 		return;
+
+	switch (tstype) {
+	case SCM_TSTAMP_SCHED:
+		cb_flag = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
+		break;
+	default:
+		return;
+	}
+
+	timestamp_call_bpf(sk, cb_flag, 0, NULL);
 }
 
 void __skb_tstamp_tx(struct sk_buff *orig_skb,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e8241b320c6d..324e9e40969c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7013,6 +7013,11 @@ enum {
 					 * by the kernel or the
 					 * earlier bpf-progs.
 					 */
+	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
+					 * dev layer when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.37.3


