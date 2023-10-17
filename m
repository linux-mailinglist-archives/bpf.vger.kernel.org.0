Return-Path: <bpf+bounces-12359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA897CB76B
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 02:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BBC1C20C25
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 00:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5095C15B1;
	Tue, 17 Oct 2023 00:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OZ3MRuQz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECF88BF9;
	Tue, 17 Oct 2023 00:31:20 +0000 (UTC)
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D25A7;
	Mon, 16 Oct 2023 17:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697502680; x=1729038680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cWliG2NV1kGukfy+w+gPobJRp1ccl6GzwmgZ0IueiF8=;
  b=OZ3MRuQza6Ie5NytW3ILMn0WySck7VruuUNtkzilbElCIAJdZqQpXeiB
   +7054xlYOT7QNLZ35dh2ke5+ulX1BALNscwqCsaIkC+2eosCEb5IPuuiM
   BpQYzjWdIzpQrz5eFOo8H3KtP+5YtNIM+kJzjkVC7JAK7RBkt8DHdZjqV
   w=;
X-IronPort-AV: E=Sophos;i="6.03,230,1694736000"; 
   d="scan'208";a="678093490"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 00:31:14 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id 6498660C28;
	Tue, 17 Oct 2023 00:31:11 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:32772]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.209:2525] with esmtp (Farcaster)
 id e4025785-f217-459b-9c22-c564a1c35538; Tue, 17 Oct 2023 00:31:11 +0000 (UTC)
X-Farcaster-Flow-ID: e4025785-f217-459b-9c22-c564a1c35538
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 00:31:11 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 00:31:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <sinquersw@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <martin.lau@linux.dev>,
	<mykolal@fb.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sdf@google.com>, <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 03/11] tcp: Clean up goto labels in cookie_v[46]_check().
Date: Mon, 16 Oct 2023 17:30:58 -0700
Message-ID: <20231017003058.6254-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <effba957-26ce-4b04-841a-40c863e6931f@gmail.com>
References: <effba957-26ce-4b04-841a-40c863e6931f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.29]
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <sinquersw@gmail.com>
Date: Mon, 16 Oct 2023 17:00:39 -0700
> On 10/13/23 15:04, Kuniyuki Iwashima wrote:
> > We will add a SOCK_OPS hook to validate SYN Cookie.
> > 
> > We invoke the hook after allocating reqsk.  In case it fails,
> > we will respond with RST instead of just dropping the ACK.
> > 
> > Then, there would be more duplicated error handling patterns.
> > To avoid that, let's clean up goto labels.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >   net/ipv4/syncookies.c | 22 +++++++++++-----------
> >   net/ipv6/syncookies.c |  4 ++--
> >   2 files changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index 64280cf42667..b0cf6f4d66d8 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -369,11 +369,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
> >   	if (!cookie_timestamp_decode(net, &tcp_opt))
> >   		goto out;
> >   
> > -	ret = NULL;
> >   	req = cookie_tcp_reqsk_alloc(&tcp_request_sock_ops,
> >   				     &tcp_request_sock_ipv4_ops, sk, skb);
> >   	if (!req)
> > -		goto out;
> > +		goto out_drop;
> >   
> >   	ireq = inet_rsk(req);
> >   	treq = tcp_rsk(req);
> > @@ -405,10 +404,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
> >   	 */
> >   	RCU_INIT_POINTER(ireq->ireq_opt, tcp_v4_save_options(net, skb));
> >   
> > -	if (security_inet_conn_request(sk, skb, req)) {
> > -		reqsk_free(req);
> > -		goto out;
> > -	}
> > +	if (security_inet_conn_request(sk, skb, req))
> > +		goto out_free;
> >   
> >   	req->num_retrans = 0;
> >   
> > @@ -425,10 +422,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
> >   			   ireq->ir_loc_addr, th->source, th->dest, sk->sk_uid);
> >   	security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
> >   	rt = ip_route_output_key(net, &fl4);
> > -	if (IS_ERR(rt)) {
> > -		reqsk_free(req);
> > -		goto out;
> > -	}
> > +	if (IS_ERR(rt))
> > +		goto out_free;
> >   
> >   	/* Try to redo what tcp_v4_send_synack did. */
> >   	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(&rt->dst, RTAX_WINDOW);
> > @@ -452,5 +447,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
> >   	 */
> >   	if (ret)
> >   		inet_sk(ret)->cork.fl.u.ip4 = fl4;
> > -out:	return ret;
> > +out:
> > +	return ret;
> > +out_free:
> > +	reqsk_free(req);
> > +out_drop:
> > +	return NULL;
> >   }
> 
> Looks like you don't use out_free and out_drop at all
> in the patch 5 & 6. Are these changes still necessary?
> Especially, the line 'goto out_drop' can be 'return NULL' concisely.

I think it's hard to follow a function where goto and return
are mixed, so I cleaned up the labels while at it.

