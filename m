Return-Path: <bpf+bounces-12877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B137D197C
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 01:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD04282704
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 23:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2F4354FD;
	Fri, 20 Oct 2023 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="olB2ipdp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0661A71B;
	Fri, 20 Oct 2023 23:10:25 +0000 (UTC)
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CBFD46;
	Fri, 20 Oct 2023 16:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697843425; x=1729379425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c2MTKVsVzkxUvuTXCIBYynqyIqF6GoiRRdW1Io8kXV0=;
  b=olB2ipdpmrErNEPPqkAcvHeE5XPGI+ZRg5cNoud+FquCGIR0YvzcoaJ5
   CwwQKJMVvYh+tVIh4dQohISTEwKRgJOxLD9yF6qevp6caJFG1g+9itvj6
   xCuBhh0vTiwBenGFIwR62FH8c4CSTkhfAuzP3OucwYn01MYbPSLP5AOVf
   4=;
X-IronPort-AV: E=Sophos;i="6.03,239,1694736000"; 
   d="scan'208";a="611265191"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 23:10:23 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 2429E486DE;
	Fri, 20 Oct 2023 23:10:16 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:9435]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.246:2525] with esmtp (Farcaster)
 id 9fe161c2-9fba-4e93-9c67-a745e55eb32a; Fri, 20 Oct 2023 23:10:16 +0000 (UTC)
X-Farcaster-Flow-ID: 9fe161c2-9fba-4e93-9c67-a745e55eb32a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 20 Oct 2023 23:10:15 +0000
Received: from 88665a182662.ant.amazon.com (10.142.223.91) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 20 Oct 2023 23:10:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <mykolal@fb.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@google.com>,
	<sinquersw@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie generation/validation SOCK_OPS hooks.
Date: Fri, 20 Oct 2023 16:10:03 -0700
Message-ID: <20231020231003.51313-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <16bad14a-a99c-a2a2-ccdc-6c44c9c4ad1d@linux.dev>
References: <16bad14a-a99c-a2a2-ccdc-6c44c9c4ad1d@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.142.223.91]
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Fri, 20 Oct 2023 12:59:00 -0700
> On 10/19/23 11:01 AM, Kuniyuki Iwashima wrote:
> > From: Martin KaFai Lau <martin.lau@linux.dev>
> > Date: Thu, 19 Oct 2023 00:25:00 -0700
> >> On 10/18/23 3:31 PM, Kuniyuki Iwashima wrote:
> >>> From: Kui-Feng Lee <sinquersw@gmail.com>
> >>> Date: Wed, 18 Oct 2023 14:47:43 -0700
> >>>> On 10/18/23 10:20, Kuniyuki Iwashima wrote:
> >>>>> From: Eric Dumazet <edumazet@google.com>
> >>>>> Date: Wed, 18 Oct 2023 10:02:51 +0200
> >>>>>> On Wed, Oct 18, 2023 at 8:19 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >>>>>>>
> >>>>>>> On 10/17/23 9:48 AM, Kuniyuki Iwashima wrote:
> >>>>>>>> From: Martin KaFai Lau <martin.lau@linux.dev>
> >>>>>>>> Date: Mon, 16 Oct 2023 22:53:15 -0700
> >>>>>>>>> On 10/13/23 3:04 PM, Kuniyuki Iwashima wrote:
> >>>>>>>>>> Under SYN Flood, the TCP stack generates SYN Cookie to remain stateless
> >>>>>>>>>> After 3WHS, the proxy restores SYN and forwards it and ACK to the backend
> >>>>>>>>>> server.  Our kernel module works at Netfilter input/output hooks and first
> >>>>>>>>>> feeds SYN to the TCP stack to initiate 3WHS.  When the module is triggered
> >>>>>>>>>> for SYN+ACK, it looks up the corresponding request socket and overwrites
> >>>>>>>>>> tcp_rsk(req)->snt_isn with the proxy's cookie.  Then, the module can
> >>>>>>>>>> complete 3WHS with the original ACK as is.
> >>>>>>>>>
> >>>>>>>>> Does the current kernel module also use the timestamp bits differently?
> >>>>>>>>> (something like patch 8 and patch 10 trying to do)
> >>>>>>>>
> >>>>>>>> Our SYN Proxy uses TS as is.  The proxy nodes generate a random number
> >>>>>>>> if TS is in SYN.
> >>>>>>>>
> >>>>>>>> But I thought someone would suggest making TS available so that we can
> >>>>>>>> mock the default behaviour at least, and it would be more acceptable.
> >>>>>>>>
> >>>>>>>> The selftest uses TS just to strengthen security by validating 32-bits
> >>>>>>>> hash.  Dropping a part of hash makes collision easier to happen, but
> >>>>>>>> 24-bits were sufficient for us to reduce SYN flood to the managable
> >>>>>>>> level at the backend.
> >>>>>>>
> >>>>>>> While enabling bpf to customize the syncookie (and timestamp), I want to explore
> >>>>>>> where can this also be done other than at the tcp layer.
> >>>>>>>
> >>>>>>> Have you thought about directly sending the SYNACK back at a lower layer like
> >>>>>>> tc/xdp after receiving the SYN?
> >>>>>
> >>>>> Yes.  Actually, at netconf I mentioned the cookie generation hook will not
> >>>>> be necessary and should be replaced with XDP.
> >>
> >> Right, it is also what I have been thinking when seeing the
> >> BPF_SOCK_OPS_GEN_SYNCOOKIE_CB carrying the bpf generated timestamp to the
> >> tcp_make_synack. It feels like trying hard to work with the tcp want_cookie
> >> logic while there is an existing better alternative in tc/xdp to deal with synflood.
> >>
> >>>>>
> >>>>>
> >>>>>>> There are already bpf_tcp_{gen,check}_syncookie
> >>>>>>> helper that allows to do this for the performance reason to absorb synflood. It
> >>>>>>> will be natural to extend it to handle the customized syncookie also.
> >>>>>
> >>>>> Maybe we even need not extend it and can use XDP as said below.
> >>>>>
> >>>>>
> >>>>>>>
> >>>>>>> I think it should already be doable to send a SYNACK back with customized
> >>>>>>> syncookie (and timestamp) at tc/xdp today.
> >>>>>>>
> >>>>>>> When ack is received, the prog@tc/xdp can verify the cookie. It will probably
> >>>>>>> need some new kfuncs to create the ireq and queue the child socket. The bpf prog
> >>>>>>> can change the ireq->{snd_wscale, sack_ok...} if needed. The details of the
> >>>>>>> kfuncs need some more thoughts. I think most of the bpf-side infra is ready,
> >>>>>>> e.g. acquire/release/ref-tracking...etc.
> >>>>>>>
> >>>>>>
> >>>>>> I think I mostly agree with this.
> >>>>>
> >>>>> I didn't come up with kfunc to create ireq and queue it to listener, so
> >>>>> cookie_v[46]_check() were best place for me to extend easily, but now it
> >>>>> sounds like kfunc would be the way to go.
> >>>>>
> >>>>> Maybe we can move the core part of cookie_v[46]_check() except for kernel
> >>>>> cookie's validation to __cookie_v[46]_check() and expose a wrapper of it
> >>>>> as kfunc ?
> >>>>>
> >>>>> Then, we can look up sk and pass the listener, skb, and flags (for sack_ok,
> >>>>> etc) to the kfunc.  (It could still introduce some conflicts with Eric's
> >>>>> patch though...)
> >>>>
> >>>> Does that mean the packets handled in this way (in XDP) will skip all
> >>>> netfilter at all?
> >>>
> >>> Good point.
> >>>
> >>> If we want not to skip other layers, maybe we can use tc ?
> >>>
> >>> 1) allocate ireq and set sack_ok etc with kfunc
> >>> 2) bpf_sk_assign() to set ireq to skb (this could be done in kfunc above)
> >>> 3) let inet_steal_sock() return req->sk_listener if not sk_fullsock(sk)
> >>> 4) if skb->sk is reqsk in cookie_v[46]_check(), skip validation and
> >>>      req allocation and create full sk
> >>
> >> Haven't looked at the details. The above feels reasonable and would be nice if
> >> it works out. don't know if the skb at tc can be used in cookie_v[46]_check() as
> >> is. It probably needs more thoughts.  [ note, xdp does not have skb. ]
> >>
> >> Regarding the "allocate ireq and set sack_ok etc with kfunc", do you think it
> >> will be useful (and potentially cleaner) even for the
> >> BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB if it needed to go back to consider skops? Then
> >> only do the BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB and the xdp/tc can generate SYNACK.
> >> The xdp/tc can still do the check and drop the bad ACK earlier in the stack.
> > 
> > kfunc would be useful if we want to fall back to the default
> > validation, but I think we should not allocate ireq in kfunc.
> > 
> > The SOCK_OPS prog only returns a binary value.  If we decide whether
> > we skip validation or not based on kfunc call (ireq allocation), the
> > flow would be like :
> > 
> >    1. CG_OK & ireq is allocated -> skip validation and req allocation
> >    2. CG_OK & no ireq           -> default validation
> >    3. CG_ERR                    -> RST
> > 
> > The problem here is that if kfunc fails with -ENOMEM and cookie
> > is valid, we need a way to tell the kernel to drop the ACK instead
> > of sending RST.  (I hope the prog could return CG_DROP...)
> 
> bpf_set_retval() helper allows the cgrp bpf prog to return -ENOMEM. Take a look 
> at how __cgroup_bpf_run_filter_getsockopt is using the return value of 
> bpf_prog_run_array_cg() and an example in progs/cgroup_getset_retval_getsockopt.c.

Oh, this is nice, I assumed -EPERM was always returned.


> > If we allocate ireq first, it would be cleaner as bpf need not care
> > about the drop path.
> > 
> >    1. CG_OK & mss is set -> skip validation
> >    2. CG_OK & no mss set -> default validation
> >    3. CG_ERR             -> RST
> 
> Even if it uses the mss set/not-set like above to decide drop/rst. Does it 
> really need to pre-allocate ireq? Looking at the test, the bpf prog is not using 
> the skops->sk either.

It uses skops->remote_ip4 etc, maybe this was another reason why
I chose pre-alloc, but yes, it's not needed.  The same value can
be extraced from skb with bpf_skb_load_bytes_relative(BPF_HDR_START_NET).


> It would be nice to allow bpf prog to check the cookie first before creating 
> ireq. The kernel also checks the cookie first before tcp_parse_option and ireq 
> creation. Beside, I suspect the multiple "if ([!]bpf_cookie)" checks in 
> cookie_v[46]_check() is due to the pre-alloc ireq requirement.
> 
> What does it take to create an ireq? sk, skb, tcp_opt, and mss? Potentially, it 
> could have a "bpf_skops_parse_tcp_options(struct bpf_sock_ops_kern *skops, 
> struct tcp_options_received *opt_rx, u32 opt_rx__sz)" to initialize the tcp_opt. 
> I think the bpf prog should be able to parse the tcp options by itself also and 
> directly initialize the tcp_opt.

Yes, also the prog will not need to parse all the options unless
the validation algorithm needs to becaues SACK_PERMITTED, WSCALE,
MSS (and ECN bits) are only available in SYN.

So, the prog will just need to parse timestamps option with
bpf_load_hdr_opt() and can initialise tcp_opt based on ISN
(and/or TS).


> The "bpf_skops_alloc_tcp_req(struct bpf_sock_ops_kern *skops, struct 
> tcp_options_received *opt_rx, u32 opt_rx__size, int mss,...)" could directly 
> save the "ireq" in skops->ireq (new member). If skops->ireq is available, the 
> kernel could then skip most of the ireq initialization and directly continue the 
> remaining processing (e.g. directly to security_inet_conn_request() ?). would 
> that work?

Yes, that will work.

