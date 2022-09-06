Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3D95AF880
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 01:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIFXtH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 19:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIFXtG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 19:49:06 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D258491D11
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 16:49:05 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id o5-20020a1709026b0500b001755c286c81so8648105plk.14
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 16:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=7JzQvNuV+huKghBCFvtgwncICdsG5n37tZbHNby+uDE=;
        b=WU0UMCmLS4x7J61ksfqfKoWXC3BOaZt4Y5CgTNYVMKXElCctNMLESkwSdPLyaCROmr
         IXYaLJm3LUB/fSWfsV9/PFFlJO+jruPLRWXzhqeOZ5mi6/0grRilfx/zyBzI4QodiZk/
         GjBxzND7xQYP0lq8/4B69HhXCNigb50JyFvmcbahCG5Z6kqBpr/Cw0NCzdSDhKf4Usyu
         J1zkesQcE/UEjvHregH7D+r7SKxfkSfDZmM4A1S1jSXB7AXyrt49bytpncUZhdqmLsf1
         RgnQnCoQ+aJk1QHC3KApB1IZyNgTC3qk0l2G/xdr0zJrnaGb7RMMo290f9j+b/X7jHbr
         Qsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=7JzQvNuV+huKghBCFvtgwncICdsG5n37tZbHNby+uDE=;
        b=E1SzfpWIk54WMt0+JGWvkqVNM/+1YIVH7KRuROHJXGvRjfxHZM+59tjgyyAdp1tRBY
         NZcWvuyATzFQPIDvBOY6eYLMFnKuBrVy5jkkY+Frz08b0wjyb01lYCOEqCggr2WQ0fI/
         y+WCbf+UFIImzhIN/SpHmIo6TfuOEpVRBDo1bsFHpUPvFIss9ladK/mpa9o0wEws99IC
         1z4OQJvosOMedCqo74qnwPorGsa352Gc7DbKJMVF6p5W0xs5+c21qqzrYvvomcQ5RSHN
         utEzNcz8g5rmjKeiJibGEdnf3wUdlxlzVFQONIifVCYEZqVkQvFB8GwJdOCSy3nG/OVJ
         Ss4g==
X-Gm-Message-State: ACgBeo0FQfV+IR22Wvlt5ajnhs43VcJ5bHo1S4E/FoJ7LZ+QzwAxeBDm
        E32d2sEUUGGlp1RjvYX7vMxhR7i4BSofYNWjGe0wo0HVQRx6MR5+ucfCqOAsd6SeO4kErQTijkG
        TsUyfyckEI8Eya2GtzsXVCtiEsLDEYx3n6W4Q+XuJjW6Bj76yuNNCgWLmdTC6cx4=
X-Google-Smtp-Source: AA6agR55HEQjmmYWCPvG3/qUHg1aZBC7igJn7rR4+GV444AfD4YiwMNvPXYL0z2BvgZOv85Yp/tYqivULZranQ==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a05:6a00:2906:b0:52a:bc7f:f801 with SMTP
 id cg6-20020a056a00290600b0052abc7ff801mr1138985pfb.49.1662508145304; Tue, 06
 Sep 2022 16:49:05 -0700 (PDT)
Date:   Tue,  6 Sep 2022 23:48:46 +0000
In-Reply-To: <cover.1662507638.git.zhuyifei@google.com>
Mime-Version: 1.0
References: <cover.1662507638.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <5764914c252fad4cd134fb6664c6ede95f409412.1662507638.git.zhuyifei@google.com>
Subject: [PATCH v2 bpf-next 1/3] bpf: Invoke cgroup/connect{4,6} programs for
 unprivileged ICMP ping
From:   YiFei Zhu <zhuyifei@google.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Usually when a TCP/UDP connection is initiated, we can bind the socket
to a specific IP attached to an interface in a cgroup/connect hook.
But for pings, this is impossible, as the hook is not being called.

This adds the hook invocation to unprivileged ICMP ping (i.e. ping
sockets created with SOCK_DGRAM IPPROTO_ICMP(V6) as opposed to
SOCK_RAW. Logic is mirrored from UDP sockets where the hook is invoked
during pre_connect, after a check for suficiently sized addr_len.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 net/ipv4/ping.c | 15 +++++++++++++++
 net/ipv6/ping.c | 16 ++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index b83c2bd9d7223..517042caf6dc1 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -33,6 +33,7 @@
 #include <linux/skbuff.h>
 #include <linux/proc_fs.h>
 #include <linux/export.h>
+#include <linux/bpf-cgroup.h>
 #include <net/sock.h>
 #include <net/ping.h>
 #include <net/udp.h>
@@ -295,6 +296,19 @@ void ping_close(struct sock *sk, long timeout)
 }
 EXPORT_SYMBOL_GPL(ping_close);
 
+static int ping_pre_connect(struct sock *sk, struct sockaddr *uaddr,
+			    int addr_len)
+{
+	/* This check is replicated from __ip4_datagram_connect() and
+	 * intended to prevent BPF program called below from accessing bytes
+	 * that are out of the bound specified by user in addr_len.
+	 */
+	if (addr_len < sizeof(struct sockaddr_in))
+		return -EINVAL;
+
+	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr);
+}
+
 /* Checks the bind address and possibly modifies sk->sk_bound_dev_if. */
 static int ping_check_bind_addr(struct sock *sk, struct inet_sock *isk,
 				struct sockaddr *uaddr, int addr_len)
@@ -1009,6 +1023,7 @@ struct proto ping_prot = {
 	.owner =	THIS_MODULE,
 	.init =		ping_init_sock,
 	.close =	ping_close,
+	.pre_connect =	ping_pre_connect,
 	.connect =	ip4_datagram_connect,
 	.disconnect =	__udp_disconnect,
 	.setsockopt =	ip_setsockopt,
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 91b8405146569..5f2ef84937142 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -20,6 +20,7 @@
 #include <net/udp.h>
 #include <net/transp_v6.h>
 #include <linux/proc_fs.h>
+#include <linux/bpf-cgroup.h>
 #include <net/ping.h>
 
 static void ping_v6_destroy(struct sock *sk)
@@ -49,6 +50,20 @@ static int dummy_ipv6_chk_addr(struct net *net, const struct in6_addr *addr,
 	return 0;
 }
 
+static int ping_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
+			       int addr_len)
+{
+	/* This check is replicated from __ip6_datagram_connect() and
+	 * intended to prevent BPF program called below from accessing
+	 * bytes that are out of the bound specified by user in addr_len.
+	 */
+
+	if (addr_len < SIN6_LEN_RFC2133)
+		return -EINVAL;
+
+	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr);
+}
+
 static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct inet_sock *inet = inet_sk(sk);
@@ -191,6 +206,7 @@ struct proto pingv6_prot = {
 	.init =		ping_init_sock,
 	.close =	ping_close,
 	.destroy =	ping_v6_destroy,
+	.pre_connect =	ping_v6_pre_connect,
 	.connect =	ip6_datagram_connect_v6_only,
 	.disconnect =	__udp_disconnect,
 	.setsockopt =	ipv6_setsockopt,
-- 
2.37.2.789.g6183377224-goog

