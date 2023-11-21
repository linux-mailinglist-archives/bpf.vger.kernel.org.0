Return-Path: <bpf+bounces-15500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB2E7F252D
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 06:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30CF9B21C10
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 05:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCA718643;
	Tue, 21 Nov 2023 05:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="j327D7gO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9B4C8;
	Mon, 20 Nov 2023 21:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700543957; x=1732079957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pcsXmk8Q6mE4d84jdRULTsqZMUZAGSif0EL2ns/7/gA=;
  b=j327D7gOylNOojX+/dRINxIPjD4eKbEk2sS016hmxJjSPncZHZuvxQhJ
   dyRrinKJVhlmxK0mCqO4UQFvE28Wara40OPvVgUSjI22GiEXmXXf/JJL8
   /f2mK6tO09CWfLc4hdAebx/uU9k7Ebo+1gLfxGG1Us88FoFBtMZw5XeQ/
   Q=;
X-IronPort-AV: E=Sophos;i="6.04,215,1695686400"; 
   d="scan'208";a="167409420"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 05:19:13 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id 1BFD440D91;
	Tue, 21 Nov 2023 05:19:11 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:30199]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.224:2525] with esmtp (Farcaster)
 id 78b88525-b3b4-4dd6-82ed-c2b6d0c9ab58; Tue, 21 Nov 2023 05:19:10 +0000 (UTC)
X-Farcaster-Flow-ID: 78b88525-b3b4-4dd6-82ed-c2b6d0c9ab58
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 21 Nov 2023 05:19:10 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 21 Nov 2023 05:19:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lkp@intel.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <martin.lau@linux.dev>, <mykolal@fb.com>,
	<netdev@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
	<pabeni@redhat.com>, <sdf@google.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH v2 bpf-next 10/11] bpf: tcp: Support arbitrary SYN Cookie.
Date: Mon, 20 Nov 2023 21:18:57 -0800
Message-ID: <20231121051857.89600-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <202311211229.8GAmfTPp-lkp@intel.com>
References: <202311211229.8GAmfTPp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.26]
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: kernel test robot <lkp@intel.com>
Date: Tue, 21 Nov 2023 13:06:23 +0800
> Hi Kuniyuki,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on bpf-next/master]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tcp-Clean-up-reverse-xmas-tree-in-cookie_v-46-_check/20231121-063036
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20231120222341.54776-11-kuniyu%40amazon.com
> patch subject: [PATCH v2 bpf-next 10/11] bpf: tcp: Support arbitrary SYN Cookie.
> config: arm-randconfig-001-20231121 (https://download.01.org/0day-ci/archive/20231121/202311211229.8GAmfTPp-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211229.8GAmfTPp-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311211229.8GAmfTPp-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> net/core/filter.c:11812:48: warning: 'struct tcp_cookie_attributes' declared inside parameter list will not be visible outside of this definition or declaration
>    11812 |                                         struct tcp_cookie_attributes *attr,
>          |                                                ^~~~~~~~~~~~~~~~~~~~~
>    net/core/filter.c: In function 'bpf_sk_assign_tcp_reqsk':
>    net/core/filter.c:11821:31: error: invalid application of 'sizeof' to incomplete type 'struct tcp_cookie_attributes'
>    11821 |         if (attr__sz != sizeof(*attr))
>          |                               ^
>    net/core/filter.c:11851:17: error: invalid use of undefined type 'struct tcp_cookie_attributes'
>    11851 |         if (attr->tcp_opt.mss_clamp < min_mss) {
>          |                 ^~
>    net/core/filter.c:11856:17: error: invalid use of undefined type 'struct tcp_cookie_attributes'
>    11856 |         if (attr->tcp_opt.wscale_ok &&
>          |                 ^~
>    net/core/filter.c:11857:17: error: invalid use of undefined type 'struct tcp_cookie_attributes'
>    11857 |             attr->tcp_opt.snd_wscale > TCP_MAX_WSCALE) {
>          |                 ^~
>    net/core/filter.c:11875:24: error: invalid use of undefined type 'struct tcp_cookie_attributes'
>    11875 |         req->mss = attr->tcp_opt.mss_clamp;
>          |                        ^~
>    net/core/filter.c:11877:32: error: invalid use of undefined type 'struct tcp_cookie_attributes'
>    11877 |         ireq->snd_wscale = attr->tcp_opt.snd_wscale;
>          |                                ^~
>    net/core/filter.c:11878:31: error: invalid use of undefined type 'struct tcp_cookie_attributes'
>    11878 |         ireq->wscale_ok = attr->tcp_opt.wscale_ok;
>          |                               ^~
>    net/core/filter.c:11879:31: error: invalid use of undefined type 'struct tcp_cookie_attributes'
>    11879 |         ireq->tstamp_ok = attr->tcp_opt.tstamp_ok;
>          |                               ^~
>    net/core/filter.c:11880:29: error: invalid use of undefined type 'struct tcp_cookie_attributes'
>    11880 |         ireq->sack_ok = attr->tcp_opt.sack_ok;
>          |                             ^~
>    net/core/filter.c:11881:28: error: invalid use of undefined type 'struct tcp_cookie_attributes'
>    11881 |         ireq->ecn_ok = attr->ecn_ok;
>          |                            ^~
>    net/core/filter.c:11883:33: error: invalid use of undefined type 'struct tcp_cookie_attributes'
>    11883 |         treq->req_usec_ts = attr->usec_ts_ok;
>          |                                 ^~
> 
> 
> vim +11812 net/core/filter.c
> 
>  11810	
>  11811	__bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct sk_buff *skb, struct sock *sk,
>  11812						struct tcp_cookie_attributes *attr,
>  11813						int attr__sz)
>  11814	{

bpf_sk_assign_tcp_reqsk() needs to be guarded by CONFIG_SYN_COOKIE.

Will fix in v3.

Thanks!

---8<---
diff --git a/net/core/filter.c b/net/core/filter.c
index 58b567aaf577..7beba469e8a7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11808,6 +11808,7 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_SYN_COOKIE)
 __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct sk_buff *skb, struct sock *sk,
 					struct tcp_cookie_attributes *attr,
 					int attr__sz)
@@ -11888,6 +11889,7 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct sk_buff *skb, struct sock *sk,
 
 	return 0;
 }
+#endif
 
 __bpf_kfunc_end_defs();
 
---8<---

