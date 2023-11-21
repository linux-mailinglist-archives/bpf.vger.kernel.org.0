Return-Path: <bpf+bounces-15505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3FB7F255D
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 06:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8384282969
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 05:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A842199DB;
	Tue, 21 Nov 2023 05:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="likLLOTk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66BA113;
	Mon, 20 Nov 2023 21:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700545049; x=1732081049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/zrryXpKWKQAyrCPZGj07xxabi8IACpWZDfQTkTD2cw=;
  b=likLLOTk+eHaEyvJeOnOTUF7jmxnvAanWC8ApaH1s5HahXiTQhxg8ZQ5
   2+yqLsYfDCxXFApE5aLzK+fNJe5q2Cc1e/nW00pRPo9N96YF+iJKyUoSw
   ksa1sqZT892qz4RccZ7QHjus3rrU45LBLXJJ+hbwtxHSkH7iofLYfY2DU
   I=;
X-IronPort-AV: E=Sophos;i="6.04,215,1695686400"; 
   d="scan'208";a="364017441"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 05:37:24 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id C90CBA049D;
	Tue, 21 Nov 2023 05:37:22 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:39084]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.2:2525] with esmtp (Farcaster)
 id 940a4e78-2f4b-4cb0-b273-910cbf05cc9c; Tue, 21 Nov 2023 05:37:22 +0000 (UTC)
X-Farcaster-Flow-ID: 940a4e78-2f4b-4cb0-b273-910cbf05cc9c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 21 Nov 2023 05:37:22 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Tue, 21 Nov 2023 05:37:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lkp@intel.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <llvm@lists.linux.dev>, <martin.lau@linux.dev>,
	<mykolal@fb.com>, <netdev@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
	<pabeni@redhat.com>, <sdf@google.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH v2 bpf-next 10/11] bpf: tcp: Support arbitrary SYN Cookie.
Date: Mon, 20 Nov 2023 21:37:09 -0800
Message-ID: <20231121053709.91149-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <202311211310.E8pJEsnT-lkp@intel.com>
References: <202311211310.E8pJEsnT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.26]
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: kernel test robot <lkp@intel.com>
Date: Tue, 21 Nov 2023 13:17:40 +0800
> Hi Kuniyuki,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on bpf-next/master]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tcp-Clean-up-reverse-xmas-tree-in-cookie_v-46-_check/20231121-063036
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20231120222341.54776-11-kuniyu%40amazon.com
> patch subject: [PATCH v2 bpf-next 10/11] bpf: tcp: Support arbitrary SYN Cookie.
> config: arm-spear3xx_defconfig (https://download.01.org/0day-ci/archive/20231121/202311211310.E8pJEsnT-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211310.E8pJEsnT-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311211310.E8pJEsnT-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from net/core/sock.c:142:
>    In file included from include/net/tcp.h:32:
> >> include/net/inet_hashtables.h:472:22: error: use of undeclared identifier 'sock_pfree'
>                            skb->destructor = sock_pfree;
>                                              ^

Ok, sock_pfree is available with CONFIG_INET.

I'll guard the req->syncookie part in inet6?_steal_sock() by
CONFIG_SYN_COOKIE too.

---8<---
diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index b6c0ed5a1e3c..9a67f47a5e64 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -120,12 +120,14 @@ struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 		return sk;
 
 	if (sk->sk_state == TCP_NEW_SYN_RECV) {
+#if IS_ENABLED(CONFIG_SYN_COOKIE)
 		if (inet_reqsk(sk)->syncookie) {
 			*refcounted = false;
 			skb->sk = sk;
 			skb->destructor = sock_pfree;
 			return inet_reqsk(sk)->rsk_listener;
 		}
+#endif
 		return sk;
 	} else if (sk->sk_state == TCP_TIME_WAIT) {
 		return sk;
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 0f4091112967..36609656a047 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -466,12 +466,14 @@ struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 		return sk;
 
 	if (sk->sk_state == TCP_NEW_SYN_RECV) {
+#if IS_ENABLED(CONFIG_SYN_COOKIE)
 		if (inet_reqsk(sk)->syncookie) {
 			*refcounted = false;
 			skb->sk = sk;
 			skb->destructor = sock_pfree;
 			return inet_reqsk(sk)->rsk_listener;
 		}
+#endif
 		return sk;
 	} else if (sk->sk_state == TCP_TIME_WAIT) {
 		return sk;
---8<---

