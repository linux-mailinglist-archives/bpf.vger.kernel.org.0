Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA397211FD1
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 11:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgGBJYe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jul 2020 05:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgGBJYb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jul 2020 05:24:31 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E836C08C5DC
        for <bpf@vger.kernel.org>; Thu,  2 Jul 2020 02:24:30 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n2so13847387edr.5
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2020 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0BY6ok1QYTMHoHC2FyFBlpP9FnBum5gXQ+nmbXEQDKU=;
        b=GGYzkthxBLIF0Y59p+WWENuYhgg1Uj/dr8HNGZoOjnmseZ1A3gs3i0w5HKI47EKeTu
         6kz3bI3uyWCkVFmgWXhmf1p3G64m5//80UURBmT6Gw2OpG/fc9UXAzDP2DnLCGpfI2ZW
         CpNNQgIKXIgfH7mXtRU8aLJY8LC867MIx0ZDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0BY6ok1QYTMHoHC2FyFBlpP9FnBum5gXQ+nmbXEQDKU=;
        b=CBqPPvjvSNcnb1G96QI/qVmiAiJAkKs1tXlZvuUK+NFYwePk/cETUknjegxmvM3IyQ
         +nWuwLDOwZFxCd7Ny7OmksLupkB7s1cZYGQ0ZsO5rYmR3LCluoUiC9sq3IB7AiQPgKa0
         QbvKaYOc6CSebkMfSP/pdd5aiQPzwuumTQGlWFrEmHfiCG634G/mKf0sWEi1BLSulc4B
         mXW2cB8NluGzijVG7o4i2v25kktFpSfDO4bidrN6M6yQQwQ5Ui30Ly7D3gT81PlNlyiT
         3ovpaL8MhYJ1Nu8eWCIrBXuHKJXQ3J+u8esRwu/maOJ73CHd+5fdzrmMFRnCa/2qvrL6
         uGzQ==
X-Gm-Message-State: AOAM533SaQrICwaH/Jh+lZQkPVwdoaxpBKOLS3nwWg4vWy9WMN4+peFP
        rUkD6H415h38Nutcck0Q502IRxe0GcQhdQ==
X-Google-Smtp-Source: ABdhPJxFpwzyX42hZ6RtTwFi9hA0EMYHwFRgTQb8F/h53KlCOWfRR8AYYEfjmZrEXZu0lFAqMYW47Q==
X-Received: by 2002:a05:6402:1ad9:: with SMTP id ba25mr1844654edb.74.1593681869078;
        Thu, 02 Jul 2020 02:24:29 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id d12sm8899912edx.80.2020.07.02.02.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 02:24:28 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marek Majkowski <marek@cloudflare.com>
Subject: [PATCH bpf-next v3 06/16] inet6: Run SK_LOOKUP BPF program on socket lookup
Date:   Thu,  2 Jul 2020 11:24:06 +0200
Message-Id: <20200702092416.11961-7-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200702092416.11961-1-jakub@cloudflare.com>
References: <20200702092416.11961-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Following ipv4 stack changes, run a BPF program attached to netns before
looking up a listening socket. Program can return a listening socket to use
as result of socket lookup, fail the lookup, or take no action.

Suggested-by: Marek Majkowski <marek@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---

Notes:
    v3:
    - Use a static_key to minimize the hook overhead when not used. (Alexei)
    - Don't copy struct in6_addr when populating BPF prog context. (Martin)
    - Adapt for running an array of attached programs. (Alexei)
    - Adapt for optionally skipping reuseport selection. (Martin)

 include/linux/filter.h      | 41 +++++++++++++++++++++++++++++++++++++
 net/ipv6/inet6_hashtables.c | 35 +++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index ff7721d862c2..e7462f178213 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1336,4 +1336,45 @@ static inline bool bpf_sk_lookup_run_v4(struct net *net, int protocol,
 	return do_reuseport;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
+static inline bool bpf_sk_lookup_run_v6(struct net *net, int protocol,
+					const struct in6_addr *saddr,
+					const __be16 sport,
+					const struct in6_addr *daddr,
+					const u16 dport,
+					struct sock **psk)
+{
+	struct bpf_prog_array *run_array;
+	bool do_reuseport = false;
+	struct sock *sk = NULL;
+
+	rcu_read_lock();
+	run_array = rcu_dereference(net->bpf.run_array[NETNS_BPF_SK_LOOKUP]);
+	if (run_array) {
+		const struct bpf_sk_lookup_kern ctx = {
+			.family		= AF_INET6,
+			.protocol	= protocol,
+			.v6.saddr	= saddr,
+			.v6.daddr	= daddr,
+			.sport		= sport,
+			.dport		= dport,
+		};
+		u32 ret;
+
+		ret = BPF_PROG_SK_LOOKUP_RUN_ARRAY(run_array, &ctx,
+						   BPF_PROG_RUN);
+		if (ret & (1U << BPF_REDIRECT)) {
+			sk = ctx.selected_sk;
+			do_reuseport = sk && !ctx.no_reuseport;
+		} else if (ret & (1U << BPF_DROP)) {
+			sk = ERR_PTR(-ECONNREFUSED);
+		}
+	}
+	rcu_read_unlock();
+
+	*psk = sk;
+	return do_reuseport;
+}
+#endif /* IS_ENABLED(CONFIG_IPV6) */
+
 #endif /* __LINUX_FILTER_H__ */
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 03942eef8ab6..b63583d2aa76 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -21,6 +21,8 @@
 #include <net/ip.h>
 #include <net/sock_reuseport.h>
 
+extern struct inet_hashinfo tcp_hashinfo;
+
 u32 inet6_ehashfn(const struct net *net,
 		  const struct in6_addr *laddr, const u16 lport,
 		  const struct in6_addr *faddr, const __be16 fport)
@@ -159,6 +161,31 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
 	return result;
 }
 
+static inline struct sock *inet6_lookup_run_bpf(struct net *net,
+						struct inet_hashinfo *hashinfo,
+						struct sk_buff *skb, int doff,
+						const struct in6_addr *saddr,
+						const __be16 sport,
+						const struct in6_addr *daddr,
+						const u16 hnum)
+{
+	struct sock *sk, *reuse_sk;
+	bool do_reuseport;
+
+	if (hashinfo != &tcp_hashinfo)
+		return NULL; /* only TCP is supported */
+
+	do_reuseport = bpf_sk_lookup_run_v6(net, IPPROTO_TCP,
+					    saddr, sport, daddr, hnum, &sk);
+	if (do_reuseport) {
+		reuse_sk = lookup_reuseport(net, sk, skb, doff,
+					    saddr, sport, daddr, hnum);
+		if (reuse_sk)
+			sk = reuse_sk;
+	}
+	return sk;
+}
+
 struct sock *inet6_lookup_listener(struct net *net,
 		struct inet_hashinfo *hashinfo,
 		struct sk_buff *skb, int doff,
@@ -170,6 +197,14 @@ struct sock *inet6_lookup_listener(struct net *net,
 	struct sock *result = NULL;
 	unsigned int hash2;
 
+	/* Lookup redirect from BPF */
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
+		result = inet6_lookup_run_bpf(net, hashinfo, skb, doff,
+					      saddr, sport, daddr, hnum);
+		if (result)
+			goto done;
+	}
+
 	hash2 = ipv6_portaddr_hash(net, daddr, hnum);
 	ilb2 = inet_lhash2_bucket(hashinfo, hash2);
 
-- 
2.25.4

