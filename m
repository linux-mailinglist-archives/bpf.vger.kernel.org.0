Return-Path: <bpf+bounces-12722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887DC7D011B
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 20:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC0A1C20E9D
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 18:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A0137CA8;
	Thu, 19 Oct 2023 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WNuhgC96"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10FC14F90;
	Thu, 19 Oct 2023 18:02:24 +0000 (UTC)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09B3121;
	Thu, 19 Oct 2023 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697738543; x=1729274543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AqTc+kSMJCv4b7o2301HQA9kKRyS99hPwO3SqBo8Cfk=;
  b=WNuhgC96IuEFL+bPIpSBA1wCLP4kQBFY0Trx/i9fbTLrMspi4bxcgjaJ
   4SkxnIKHMqDQtKqSSV/n0aNLu4/GGw3AxFoG0R6Nccb8W1i6JP9/+9WOh
   DF+eMmLDcasb4/mNnzshwIQz6jP0rNypOKwNBlo6umMUiVg1993wkDiFi
   g=;
X-IronPort-AV: E=Sophos;i="6.03,238,1694736000"; 
   d="scan'208";a="679481337"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 18:02:15 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id F042448353;
	Thu, 19 Oct 2023 18:02:08 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:34185]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.211:2525] with esmtp (Farcaster)
 id 7afacc76-ecef-4ef9-b76a-fb2782a29c7b; Thu, 19 Oct 2023 18:02:08 +0000 (UTC)
X-Farcaster-Flow-ID: 7afacc76-ecef-4ef9-b76a-fb2782a29c7b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 19 Oct 2023 18:02:07 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 18:02:03 +0000
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
Date: Thu, 19 Oct 2023 11:01:54 -0700
Message-ID: <20231019180154.69237-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <33ff226e-a5b2-b222-c178-199e9c504e73@linux.dev>
References: <33ff226e-a5b2-b222-c178-199e9c504e73@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.106.101.12]
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Thu, 19 Oct 2023 00:25:00 -0700
> On 10/18/23 3:31 PM, Kuniyuki Iwashima wrote:
> > From: Kui-Feng Lee <sinquersw@gmail.com>
> > Date: Wed, 18 Oct 2023 14:47:43 -0700
> >> On 10/18/23 10:20, Kuniyuki Iwashima wrote:
> >>> From: Eric Dumazet <edumazet@google.com>
> >>> Date: Wed, 18 Oct 2023 10:02:51 +0200
> >>>> On Wed, Oct 18, 2023 at 8:19 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >>>>>
> >>>>> On 10/17/23 9:48 AM, Kuniyuki Iwashima wrote:
> >>>>>> From: Martin KaFai Lau <martin.lau@linux.dev>
> >>>>>> Date: Mon, 16 Oct 2023 22:53:15 -0700
> >>>>>>> On 10/13/23 3:04 PM, Kuniyuki Iwashima wrote:
> >>>>>>>> Under SYN Flood, the TCP stack generates SYN Cookie to remain stateless
> >>>>>>>> After 3WHS, the proxy restores SYN and forwards it and ACK to the backend
> >>>>>>>> server.  Our kernel module works at Netfilter input/output hooks and first
> >>>>>>>> feeds SYN to the TCP stack to initiate 3WHS.  When the module is triggered
> >>>>>>>> for SYN+ACK, it looks up the corresponding request socket and overwrites
> >>>>>>>> tcp_rsk(req)->snt_isn with the proxy's cookie.  Then, the module can
> >>>>>>>> complete 3WHS with the original ACK as is.
> >>>>>>>
> >>>>>>> Does the current kernel module also use the timestamp bits differently?
> >>>>>>> (something like patch 8 and patch 10 trying to do)
> >>>>>>
> >>>>>> Our SYN Proxy uses TS as is.  The proxy nodes generate a random number
> >>>>>> if TS is in SYN.
> >>>>>>
> >>>>>> But I thought someone would suggest making TS available so that we can
> >>>>>> mock the default behaviour at least, and it would be more acceptable.
> >>>>>>
> >>>>>> The selftest uses TS just to strengthen security by validating 32-bits
> >>>>>> hash.  Dropping a part of hash makes collision easier to happen, but
> >>>>>> 24-bits were sufficient for us to reduce SYN flood to the managable
> >>>>>> level at the backend.
> >>>>>
> >>>>> While enabling bpf to customize the syncookie (and timestamp), I want to explore
> >>>>> where can this also be done other than at the tcp layer.
> >>>>>
> >>>>> Have you thought about directly sending the SYNACK back at a lower layer like
> >>>>> tc/xdp after receiving the SYN?
> >>>
> >>> Yes.  Actually, at netconf I mentioned the cookie generation hook will not
> >>> be necessary and should be replaced with XDP.
> 
> Right, it is also what I have been thinking when seeing the 
> BPF_SOCK_OPS_GEN_SYNCOOKIE_CB carrying the bpf generated timestamp to the 
> tcp_make_synack. It feels like trying hard to work with the tcp want_cookie 
> logic while there is an existing better alternative in tc/xdp to deal with synflood.
> 
> >>>
> >>>
> >>>>> There are already bpf_tcp_{gen,check}_syncookie
> >>>>> helper that allows to do this for the performance reason to absorb synflood. It
> >>>>> will be natural to extend it to handle the customized syncookie also.
> >>>
> >>> Maybe we even need not extend it and can use XDP as said below.
> >>>
> >>>
> >>>>>
> >>>>> I think it should already be doable to send a SYNACK back with customized
> >>>>> syncookie (and timestamp) at tc/xdp today.
> >>>>>
> >>>>> When ack is received, the prog@tc/xdp can verify the cookie. It will probably
> >>>>> need some new kfuncs to create the ireq and queue the child socket. The bpf prog
> >>>>> can change the ireq->{snd_wscale, sack_ok...} if needed. The details of the
> >>>>> kfuncs need some more thoughts. I think most of the bpf-side infra is ready,
> >>>>> e.g. acquire/release/ref-tracking...etc.
> >>>>>
> >>>>
> >>>> I think I mostly agree with this.
> >>>
> >>> I didn't come up with kfunc to create ireq and queue it to listener, so
> >>> cookie_v[46]_check() were best place for me to extend easily, but now it
> >>> sounds like kfunc would be the way to go.
> >>>
> >>> Maybe we can move the core part of cookie_v[46]_check() except for kernel
> >>> cookie's validation to __cookie_v[46]_check() and expose a wrapper of it
> >>> as kfunc ?
> >>>
> >>> Then, we can look up sk and pass the listener, skb, and flags (for sack_ok,
> >>> etc) to the kfunc.  (It could still introduce some conflicts with Eric's
> >>> patch though...)
> >>
> >> Does that mean the packets handled in this way (in XDP) will skip all
> >> netfilter at all?
> > 
> > Good point.
> > 
> > If we want not to skip other layers, maybe we can use tc ?
> > 
> > 1) allocate ireq and set sack_ok etc with kfunc
> > 2) bpf_sk_assign() to set ireq to skb (this could be done in kfunc above)
> > 3) let inet_steal_sock() return req->sk_listener if not sk_fullsock(sk)
> > 4) if skb->sk is reqsk in cookie_v[46]_check(), skip validation and
> >     req allocation and create full sk
> 
> Haven't looked at the details. The above feels reasonable and would be nice if 
> it works out. don't know if the skb at tc can be used in cookie_v[46]_check() as 
> is. It probably needs more thoughts.  [ note, xdp does not have skb. ]
> 
> Regarding the "allocate ireq and set sack_ok etc with kfunc", do you think it 
> will be useful (and potentially cleaner) even for the 
> BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB if it needed to go back to consider skops? Then 
> only do the BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB and the xdp/tc can generate SYNACK. 
> The xdp/tc can still do the check and drop the bad ACK earlier in the stack.

kfunc would be useful if we want to fall back to the default
validation, but I think we should not allocate ireq in kfunc.

The SOCK_OPS prog only returns a binary value.  If we decide whether
we skip validation or not based on kfunc call (ireq allocation), the
flow would be like :

  1. CG_OK & ireq is allocated -> skip validation and req allocation
  2. CG_OK & no ireq           -> default validation
  3. CG_ERR                    -> RST

The problem here is that if kfunc fails with -ENOMEM and cookie
is valid, we need a way to tell the kernel to drop the ACK instead
of sending RST.  (I hope the prog could return CG_DROP...)

If we allocate ireq first, it would be cleaner as bpf need not care
about the drop path.

  1. CG_OK & mss is set -> skip validation
  2. CG_OK & no mss set -> default validation
  3. CG_ERR             -> RST

