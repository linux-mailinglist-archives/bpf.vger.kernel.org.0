Return-Path: <bpf+bounces-12585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF47A7CE346
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 19:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15EAE1C20C5A
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 17:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772603D389;
	Wed, 18 Oct 2023 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YF0DbO2J"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175F3C071;
	Wed, 18 Oct 2023 17:02:34 +0000 (UTC)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C294A111;
	Wed, 18 Oct 2023 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697648553; x=1729184553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yufWILeJIcU7vxg5cLT0ChCVEOVQwU7OL/NaxwWlnig=;
  b=YF0DbO2JwB4cPdqz+FO0yNS4WBeWubE/D7g+7xYNWGKbUIAu1ry4aYBB
   /HLyElOtHp6JTunSVnVHBzLPzPL6KwBu93Lc/oj7Rh0BLOzyPnCTd+xEK
   3IbV5jFB528QKNw4Q8G5NmGIZEjbZr/SltMmiLFLu699PM3+mbwmjhOXI
   Y=;
X-IronPort-AV: E=Sophos;i="6.03,235,1694736000"; 
   d="scan'208";a="160750732"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 17:02:29 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id 9CFE440D52;
	Wed, 18 Oct 2023 17:02:27 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:13852]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.81:2525] with esmtp (Farcaster)
 id 184ea7e1-aed1-43c9-8a59-f6ddba66683a; Wed, 18 Oct 2023 17:02:27 +0000 (UTC)
X-Farcaster-Flow-ID: 184ea7e1-aed1-43c9-8a59-f6ddba66683a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 18 Oct 2023 17:02:26 +0000
Received: from 88665a182662.ant.amazon.com (10.111.146.69) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 18 Oct 2023 17:02:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <mykolal@fb.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@google.com>,
	<song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 10/11] bpf: tcp: Make WS, SACK, ECN configurable from BPF SYN Cookie.
Date: Wed, 18 Oct 2023 10:02:15 -0700
Message-ID: <20231018170215.8830-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <66f72518-f9d6-f19b-60a6-eff0f30c2590@linux.dev>
References: <66f72518-f9d6-f19b-60a6-eff0f30c2590@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.111.146.69]
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Tue, 17 Oct 2023 18:08:34 -0700
> On 10/13/23 3:04 PM, Kuniyuki Iwashima wrote:
> > This patch allows BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB hook to enable WScale,
> > SACK, and ECN by passing corresponding flags to bpf_sock_ops.replylong[1].
> > 
> > The same flags are passed to BPF_SOCK_OPS_GEN_SYNCOOKIE_CB hook as
> > bpf_sock_ops.args[1] so that the BPF prog need not parse the TCP header to
> > check if WScale, SACK, ECN, and TS are available in SYN.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >   include/uapi/linux/bpf.h       | 18 ++++++++++++++++++
> >   net/ipv4/syncookies.c          | 20 ++++++++++++++++++++
> >   net/ipv4/tcp_input.c           | 11 +++++++++++
> >   tools/include/uapi/linux/bpf.h | 18 ++++++++++++++++++
> >   4 files changed, 67 insertions(+)
> > 
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 24f673d88c0d..cdae4dd5d797 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6869,6 +6869,7 @@ enum {
> >   					 * option.
> >   					 *
> >   					 * args[0]: MSS
> > +					 * args[1]: BPF_SYNCOOKIE_XXX
> >   					 *
> >   					 * replylong[0]: ISN
> >   					 * replylong[1]: TS
> > @@ -6883,6 +6884,7 @@ enum {
> >   					 * args[1]: TS
> >   					 *
> >   					 * replylong[0]: MSS
> > +					 * replylong[1]: BPF_SYNCOOKIE_XXX
> >   					 */
> >   };
> >   
> > @@ -6970,6 +6972,22 @@ enum {
> >   						 */
> >   };
> >   
> > +/* arg[1] value for BPF_SOCK_OPS_GEN_SYNCOOKIE_CB and
> > + * replylong[1] for BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB.
> > + *
> > + * MSB                                LSB
> > + * | 31 ... | 6  | 5   | 4    | 3 2 1 0 |
> > + * |    ... | TS | ECN | SACK | WScale  |
> > + */
> > +enum {
> > +	/* 0xf is invalid thus means that SYN did not have WScale. */
> > +	BPF_SYNCOOKIE_WSCALE_MASK	= (1 << 4) - 1,
> > +	BPF_SYNCOOKIE_SACK		= (1 << 4),
> > +	BPF_SYNCOOKIE_ECN		= (1 << 5),
> > +	/* Only available for BPF_SOCK_OPS_GEN_SYNCOOKIE_CB to check if SYN has TS */
> > +	BPF_SYNCOOKIE_TS		= (1 << 6),
> > +};
> 
> This details should not be exposed to uapi (more below).
> 
> > +
> >   struct bpf_perf_event_value {
> >   	__u64 counter;
> >   	__u64 enabled;
> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index ff979cc314da..22353a9af52d 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -286,6 +286,7 @@ int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req, struct sk_
> >   {
> >   	struct bpf_sock_ops_kern sock_ops;
> >   	struct net *net = sock_net(sk);
> > +	u32 options;
> >   
> >   	if (tcp_opt->saw_tstamp) {
> >   		if (!READ_ONCE(net->ipv4.sysctl_tcp_timestamps))
> > @@ -309,6 +310,25 @@ int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req, struct sk_
> >   	if (!sock_ops.replylong[0])
> >   		goto err;
> >   
> > +	options = sock_ops.replylong[1];
> > +
> > +	if ((options & BPF_SYNCOOKIE_WSCALE_MASK) != BPF_SYNCOOKIE_WSCALE_MASK) {
> > +		if (!READ_ONCE(net->ipv4.sysctl_tcp_window_scaling))
> > +			goto err;
> > +
> > +		tcp_opt->wscale_ok = 1;
> > +		tcp_opt->snd_wscale = options & BPF_SYNCOOKIE_WSCALE_MASK;
> > +	}
> > +
> > +	if (options & BPF_SYNCOOKIE_SACK) {
> > +		if (!READ_ONCE(net->ipv4.sysctl_tcp_sack))
> > +			goto err;
> > +
> > +		tcp_opt->sack_ok = 1;
> > +	}
> > +
> > +	inet_rsk(req)->ecn_ok = options & BPF_SYNCOOKIE_ECN;
> > +
> >   	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESRECV);
> >   
> >   	return sock_ops.replylong[0];
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index feb44bff29ef..483e2f36afe5 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -6970,14 +6970,25 @@ EXPORT_SYMBOL_GPL(tcp_get_syncookie_mss);
> >   static int bpf_skops_cookie_init_sequence(struct sock *sk, struct request_sock *req,
> >   					  struct sk_buff *skb, __u32 *isn)
> >   {
> > +	struct inet_request_sock *ireq = inet_rsk(req);
> >   	struct bpf_sock_ops_kern sock_ops;
> > +	u32 options;
> >   	int ret;
> >   
> > +	options = ireq->wscale_ok ? ireq->snd_wscale : BPF_SYNCOOKIE_WSCALE_MASK;
> > +	if (ireq->sack_ok)
> > +		options |= BPF_SYNCOOKIE_SACK;
> > +	if (ireq->ecn_ok)
> > +		options |= BPF_SYNCOOKIE_ECN;
> > +	if (ireq->tstamp_ok)
> > +		options |= BPF_SYNCOOKIE_TS;
> 
> No need to set "options" (which becomes args[1]). sock_ops.sk is available to 
> the bpf prog. The bpf prog can directly read it. The recent AF_UNIX bpf support 
> could be a reference on how the bpf_cast_to_kern_ctx() and bpf_rdonly_cast() are 
> used.
> 
> https://lore.kernel.org/bpf/20231011185113.140426-10-daan.j.demeyer@gmail.com/

I just tried bpf_cast_to_kern_ctx() and bpf_rdonly_cast() and found
it's quite useful, thanks!

If we want to set {sack_ok,ecn_ok,snd_wscale} in one shot, it would
be good to expose such flags and a helper.

