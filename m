Return-Path: <bpf+bounces-12584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7B37CE340
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 19:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D7E28138A
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 17:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD1D3D382;
	Wed, 18 Oct 2023 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nbr3V1sT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DEC3C091;
	Wed, 18 Oct 2023 17:01:10 +0000 (UTC)
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE894115;
	Wed, 18 Oct 2023 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697648467; x=1729184467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sYGk306VRE26i5+88NzS6r8vp6yylh4qzVVMPA3fWLg=;
  b=nbr3V1sTsLau3e9FkeLOvHURseMvL4I4IJbBHtwgjF3OGxdtgdxYChpk
   BMtAoks7yMYKIBZlm84bEB8oyVvqueqPnhS7UY6UK0YCQLgCDwHblw67u
   FN8y7U0E+0RhP3G0FoDnOYNBuxhs10JZHMHkg2TyC4xJNQ/hDemjgF3At
   Q=;
X-IronPort-AV: E=Sophos;i="6.03,235,1694736000"; 
   d="scan'208";a="678535311"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 17:01:01 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id 015ECA1275;
	Wed, 18 Oct 2023 17:00:59 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:9526]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.209:2525] with esmtp (Farcaster)
 id df83366e-0293-45c7-b6db-99c3b6429330; Wed, 18 Oct 2023 17:00:59 +0000 (UTC)
X-Farcaster-Flow-ID: df83366e-0293-45c7-b6db-99c3b6429330
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 18 Oct 2023 17:00:57 +0000
Received: from 88665a182662.ant.amazon.com (10.111.146.69) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 18 Oct 2023 17:00:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <mykolal@fb.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@google.com>,
	<song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 05/11] bpf: tcp: Add SYN Cookie generation SOCK_OPS hook.
Date: Wed, 18 Oct 2023 10:00:45 -0700
Message-ID: <20231018170045.8620-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <607fda5b-c976-60c0-7a51-4b7fc81cd567@linux.dev>
References: <607fda5b-c976-60c0-7a51-4b7fc81cd567@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.111.146.69]
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
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
Date: Tue, 17 Oct 2023 17:54:53 -0700
> On 10/13/23 3:04 PM, Kuniyuki Iwashima wrote:
> > This patch adds a new SOCK_OPS hook to generate arbitrary SYN Cookie.
> > 
> > When the kernel sends SYN Cookie to a client, the hook is invoked with
> > bpf_sock_ops.op == BPF_SOCK_OPS_GEN_SYNCOOKIE_CB if the listener has
> > BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG set by bpf_sock_ops_cb_flags_set().
> > 
> > The BPF program can access the following information to encode into
> > ISN:
> > 
> >    bpf_sock_ops.sk      : 4-tuple
> >    bpf_sock_ops.skb     : TCP header
> >    bpf_sock_ops.args[0] : MSS
> > 
> > The program must encode MSS and set it to bpf_sock_ops.replylong[0],
> > which will be looped back to the paired hook added in the following
> > patch.
> > 
> > Note that we do not call tcp_synq_overflow() so that the BPF program
> > can set its own expiration period.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >   include/uapi/linux/bpf.h       | 18 +++++++++++++++-
> >   net/ipv4/tcp_input.c           | 38 +++++++++++++++++++++++++++++++++-
> >   tools/include/uapi/linux/bpf.h | 18 +++++++++++++++-
> >   3 files changed, 71 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 7ba61b75bc0e..d3cc530613c0 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6738,8 +6738,17 @@ enum {
> >   	 * options first before the BPF program does.
> >   	 */
> >   	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
> > +	/* Call bpf when the kernel generates SYN Cookie (ISN) for SYN+ACK.
> > +	 *
> > +	 * The bpf prog will be called to encode MSS into SYN Cookie with
> > +	 * sock_ops->op == BPF_SOCK_OPS_GEN_SYNCOOKIE_CB.
> > +	 *
> > +	 * Please refer to the comment in BPF_SOCK_OPS_GEN_SYNCOOKIE_CB for
> > +	 * input and output.
> > +	 */
> > +	BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG = (1<<7),
> >   /* Mask of all currently supported cb flags */
> > -	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
> > +	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
> >   };
> >   
> >   /* List of known BPF sock_ops operators.
> > @@ -6852,6 +6861,13 @@ enum {
> >   					 * by the kernel or the
> >   					 * earlier bpf-progs.
> >   					 */
> > +	BPF_SOCK_OPS_GEN_SYNCOOKIE_CB,	/* Generate SYN Cookie (ISN of
> > +					 * SYN+ACK).
> > +					 *
> > +					 * args[0]: MSS
> > +					 *
> > +					 * replylong[0]: ISN
> > +					 */
> >   };
> >   
> >   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 584825ddd0a0..c86a737e4fe6 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -6966,6 +6966,37 @@ u16 tcp_get_syncookie_mss(struct request_sock_ops *rsk_ops,
> >   }
> >   EXPORT_SYMBOL_GPL(tcp_get_syncookie_mss);
> >   
> > +#if IS_ENABLED(CONFIG_CGROUP_BPF) && IS_ENABLED(CONFIG_SYN_COOKIES)
> > +static int bpf_skops_cookie_init_sequence(struct sock *sk, struct request_sock *req,
> > +					  struct sk_buff *skb, __u32 *isn)
> > +{
> > +	struct bpf_sock_ops_kern sock_ops;
> > +	int ret;
> > +
> > +	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> > +
> > +	sock_ops.op = BPF_SOCK_OPS_GEN_SYNCOOKIE_CB;
> > +	sock_ops.sk = req_to_sk(req);
> > +	sock_ops.args[0] = req->mss;
> > +
> > +	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
> > +
> > +	ret = BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*isn = sock_ops.replylong[0];
> 
> sock_ops.{replylong,reply} cannot be used. afaik, no existing sockops hook 
> relies on {replylong,reply}. It is a union of args[4]. There could be a few 
> skops bpf in the same cgrp and each of them will be run one after another. (eg. 
> two skops progs want to generate cookie).

Ah, I missed that case.  Looking at bpf_prog_run_array_cg(), multiple
SOCK_OPS prog can be attached and args[] are reused.  Then, we cannot
use replylong[] for interface from bpf prog.


> 
> I don't prefer to extend the uapi 'struct bpf_sock_ops' and then the 
> sock_ops_convert_ctx_access(). Adding member to the kernel 'struct 
> bpf_sock_addr_kern' could still be considered if it is really needed.
> 
> One option is to add kfunc to allow the bpf prog to directly update the value of 
> the kernel obj (e.g. tcp_rsk(req)->snt_isn here).

Yes, we need to set snt_isn, mss, sack_ok etc based on _CB (if we
continue with SOCK_OPS).


> 
> Also, we need to allow a bpf prog to selectively generate custom cookie for one 
> SYN but fall-through to the kernel cookie for another SYN.

Initially I implemented the fallback but the validation hook looked bit
ugly (because of reqsk allocation) and removed the fallback flow.

Also, I thought it can be done with other hooks so that such SYN will be
distributed to another listener.

