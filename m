Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C810431F6CE
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 10:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBSJxD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 04:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhBSJxA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Feb 2021 04:53:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D003C061788
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 01:52:15 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h98so2486229wrh.11
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 01:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7GJI5hJf7kClUGYltrQmcJtEGXTgG/I5Sto2S8X228I=;
        b=wEphN6x4pP0T0M0aunICcoa1NJ2lyNjVwrrLEsac1MPXRd3Rw6B6AsdDvRBqYuGH97
         /591AJdoA0OQYdedSNxjLtoh5HTg5C+GZGu8b37sqQWZoWnq6CoypBpvs+P+fCfEVEj2
         kqRCTUq3ftgbbHr3QkjzlXSGbp0WKShDNHgz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7GJI5hJf7kClUGYltrQmcJtEGXTgG/I5Sto2S8X228I=;
        b=mJitMOyFNOY11J5xw1Kb0aUV0dK/VBQHOQmeWhFQ7Ak6SoPLA5h64lkOFMhkr25fgI
         Oav5fZl+aoN7CnfaFO7bpuhRF0YxHAe802RbcSJ4ZQjK5ES4sXJlmX0r85II84q/8IW6
         BAInhKWO1031g+mbMClQJjaR1AZwwqPqX0w0+uPeg9YyJDt3RxiPYq3k8z/YcoQq3Ysj
         XzS5PebnYEEb3siO4DVPcvIkYnl7FAyAvYv/nwKTAvoT8iRZYkO8ndu+h9RGkiP4+kR2
         4dAuRLRZh57m2rYvUOzH1j6VvdCTBmagjz9gxhA7aCrR53uQiQP4wSuxYGs3mi7n5WAk
         /n6A==
X-Gm-Message-State: AOAM531FQjUNvvn/k1awF6PQMd0sWQXgOxRYKZOTd6NYgUzoFT9COsR5
        XlhFK3uomEXDqB6lwg6T7DsO4A==
X-Google-Smtp-Source: ABdhPJyCttIQw2Whak4S1eQFBwJwesciW5s24GgbIAH99N2WPmw62T4SYecu5R2KDth5F9034ZAYag==
X-Received: by 2002:adf:fc48:: with SMTP id e8mr8479338wrs.154.1613728333570;
        Fri, 19 Feb 2021 01:52:13 -0800 (PST)
Received: from antares.lan (b.3.5.8.9.a.e.c.e.a.6.2.c.1.9.b.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:b91c:26ae:cea9:853b])
        by smtp.gmail.com with ESMTPSA id a21sm13174910wmb.5.2021.02.19.01.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 01:52:13 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 1/4] net: add SO_NETNS_COOKIE socket option
Date:   Fri, 19 Feb 2021 09:51:46 +0000
Message-Id: <20210219095149.50346-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210219095149.50346-1-lmb@cloudflare.com>
References: <20210219095149.50346-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We need to distinguish which network namespace a socket belongs to.
BPF has the useful bpf_get_netns_cookie helper for this, but accessing
it from user space isn't possible. Add a read-only socket option that
returns the netns cookie, similar to SO_COOKIE. If network namespaces
are disabled, SO_NETNS_COOKIE returns the cookie of init_net.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 arch/alpha/include/uapi/asm/socket.h  |  2 ++
 arch/mips/include/uapi/asm/socket.h   |  2 ++
 arch/parisc/include/uapi/asm/socket.h |  2 ++
 arch/sparc/include/uapi/asm/socket.h  |  2 ++
 include/uapi/asm-generic/socket.h     |  2 ++
 net/core/sock.c                       | 11 +++++++++++
 6 files changed, 21 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 57420356ce4c..6b3daba60987 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -127,6 +127,8 @@
 #define SO_PREFER_BUSY_POLL	69
 #define SO_BUSY_POLL_BUDGET	70
 
+#define SO_NETNS_COOKIE		71
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 2d949969313b..cdf404a831b2 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -138,6 +138,8 @@
 #define SO_PREFER_BUSY_POLL	69
 #define SO_BUSY_POLL_BUDGET	70
 
+#define SO_NETNS_COOKIE		71
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index f60904329bbc..5b5351cdcb33 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -119,6 +119,8 @@
 #define SO_PREFER_BUSY_POLL	0x4043
 #define SO_BUSY_POLL_BUDGET	0x4044
 
+#define SO_NETNS_COOKIE		0x4045
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 848a22fbac20..ff79db753dce 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -120,6 +120,8 @@
 #define SO_PREFER_BUSY_POLL	 0x0048
 #define SO_BUSY_POLL_BUDGET	 0x0049
 
+#define SO_NETNS_COOKIE		 0x004a
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 4dcd13d097a9..d588c244ec2f 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -122,6 +122,8 @@
 #define SO_PREFER_BUSY_POLL	69
 #define SO_BUSY_POLL_BUDGET	70
 
+#define SO_NETNS_COOKIE		71
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/core/sock.c b/net/core/sock.c
index 0ed98f20448a..de4644aeb58d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1614,6 +1614,17 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		v.val = sk->sk_bound_dev_if;
 		break;
 
+	case SO_NETNS_COOKIE:
+		lv = sizeof(u64);
+		if (len < lv)
+			return -EINVAL;
+#ifdef CONFIG_NET_NS
+		v.val64 = sock_net(sk)->net_cookie;
+#else
+		v.val64 = init_net.net_cookie;
+#endif
+		break;
+
 	default:
 		/* We implement the SO_SNDLOWAT etc to not be settable
 		 * (1003.1g 7).
-- 
2.27.0

