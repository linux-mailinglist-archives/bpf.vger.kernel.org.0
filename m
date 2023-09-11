Return-Path: <bpf+bounces-9676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B297679AA98
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 19:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C67E1C20852
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 17:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E48156DB;
	Mon, 11 Sep 2023 17:41:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661EAD2E
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 17:41:34 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B8DC5
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 10:41:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c8f360a07a2so4562204276.2
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 10:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694454092; x=1695058892; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xu7iMhDcNFGmX/EjUlUOV/uW3b7muKE6w5Sjrvs71hU=;
        b=hMmrWoccR5H7OZjeJkb4MCg46cy3iyLCQoleZmr79A8xdtoywh2jA53Nub9bkAU/n4
         XF3c3MbKjf6DtM0IMoaJqwVkKatE+XulD8tqJrqO5jibCUdpxE1l2noQnyNuZyXUNEno
         f0bPNd9EOL/PjLQ/NpvFIXzrMPHL8hgkEJv568B1nyowOYL17zq9cXMtHUyf5E65T3OC
         FmjTbI52sJ5RL0g9Uj0r3C7btYMsm691nQrv2v+C0O++uimWpodGkIsz1wndzFWxbCIM
         oSbXF0NsmOmlYZMreAGq2ujPZAPuh4LTiltY7m6iIdTZBcsgRI74wcsgHjrHaPqurwKo
         wJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694454092; x=1695058892;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xu7iMhDcNFGmX/EjUlUOV/uW3b7muKE6w5Sjrvs71hU=;
        b=R/i35dXvenzfVMmzuVAcnp+D/jtdMz72OschXEYGblA9eFMRR4X64ZO13Mj9M1C/sy
         h5i31DuOlQHgSeG6Y39azJK7YyMvUU+hNHFcWzDSmFGf7lQvxDg+2eMEBp6nCbJ/k+6f
         f544C2o6u/9oq24KaiUtBzuO/w5u1onhm9Xj+WgLxYvCVtTYPtuw2kqfBJtASUdqY7YD
         UHddTNRh/HaIHqXHHO4mrO5IE2N8tpLjZwyla+U6CTaeO7Rt2o+PqxchAM7vLGA8+kcO
         cUl77qOUBF2XnulobRZIUP50KjGhLy/HEi/s5TANqYHGLmo8BkybUjilp81DqnOTfdD1
         25tg==
X-Gm-Message-State: AOJu0Yx2/z6bHNvp4AZ/9H2rZOo+od9iBt9lI18tF+gRmVolegh6Awkx
	vp1fdkS38e1MjTcCDigoUcMF4Uc=
X-Google-Smtp-Source: AGHT+IFD1OBnNOA3ZKLNQqB+s+Z5vDfLAh4EUipPkzJD6d1yh/dyS3XBJqCZPuj/+AZQZ5fdaScDMs0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:adc3:0:b0:d01:60ec:d0e with SMTP id
 d3-20020a25adc3000000b00d0160ec0d0emr240559ybe.9.1694454092113; Mon, 11 Sep
 2023 10:41:32 -0700 (PDT)
Date: Mon, 11 Sep 2023 10:41:30 -0700
In-Reply-To: <a7570c31-b19d-e1d8-8e7e-f47ead34b79b@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230908210007.1469091-1-sdf@google.com> <acdb12bc-518a-c3f6-ef09-2dfd714770b5@linux.dev>
 <ZP9KJpQIpoYqzaB3@google.com> <a7570c31-b19d-e1d8-8e7e-f47ead34b79b@iogearbox.net>
Message-ID: <ZP9RSu3QDRN0wsr/@google.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: return correct -ENOBUFS from bpf_clone_redirect
From: Stanislav Fomichev <sdf@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, ast@kernel.org, andrii@kernel.org, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 09/11, Daniel Borkmann wrote:
> On 9/11/23 7:11 PM, Stanislav Fomichev wrote:
> > On 09/09, Martin KaFai Lau wrote:
> > > On 9/8/23 2:00 PM, Stanislav Fomichev wrote:
> > > > Commit 151e887d8ff9 ("veth: Fixing transmit return status for dropped
> > > > packets") exposed the fact that bpf_clone_redirect is capable of
> > > > returning raw NET_XMIT_XXX return codes.
> > > > 
> > > > This is in the conflict with its UAPI doc which says the following:
> > > > "0 on success, or a negative error in case of failure."
> > > > 
> > > > Let's wrap dev_queue_xmit's return value (in __bpf_tx_skb) into
> > > > net_xmit_errno to make sure we correctly propagate NET_XMIT_DROP
> > > > as -ENOBUFS instead of 1.
> > > > 
> > > > Note, this is technically breaking existing UAPI where we used to
> > > > return 1 and now will do -ENOBUFS. The alternative is to
> > > > document that bpf_clone_redirect can return 1 for DROP and 2 for CN.
> > > > 
> > > > Reported-by: Daniel Borkmann <daniel@iogearbox.net>
> > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > ---
> > > >    net/core/filter.c | 3 +++
> > > >    1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > index a094694899c9..9e297931b02f 100644
> > > > --- a/net/core/filter.c
> > > > +++ b/net/core/filter.c
> > > > @@ -2129,6 +2129,9 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
> > > >    	ret = dev_queue_xmit(skb);
> > > >    	dev_xmit_recursion_dec();
> > > > +	if (ret > 0)
> > > > +		ret = net_xmit_errno(ret);
> > > 
> > > I think it is better to have bpf_clone_redirect returning -ENOBUFS instead
> > > of leaking NET_XMIT_XXX to the uapi. The bpf_clone_redirect in the
> > > uapi/bpf.h also mentions
> > > 
> > >   *      Return
> > >   *              0 on success, or a negative error in case of failure.
> > > 
> > > If -ENOBUFS is returned in __bpf_tx_skb, should the same be done for
> > > __bpf_rx_skb? and should net_xmit_errno() only be done for
> > > bpf_clone_redirect()?  __bpf_{tx,rx}_skb is also used by skb_do_redirect()
> > > which also calls __bpf_redirect_neigh() that returns NET_XMIT_xxx but no
> > > caller seems to care the NET_XMIT_xxx value now.
> > 
> > __bpf_rx_skb seems to only add to backlog and doesn't seem to return any
> > of the NET_XMIT_xxx. But I might be wrong and haven't looked too deep
> > into that.
> > 
> > > Daniel should know more here. I would wait for Daniel to comment.
> > 
> > Ack, sure!
> 
> I think my preference would be to just document it in the helper UAPI, what
> Stan was suggesting below:
> 
> | Note, this is technically breaking existing UAPI where we used to
> | return 1 and now will do -ENOBUFS. The alternative is to
> | document that bpf_clone_redirect can return 1 for DROP and 2 for CN.
> 
> And then only adjusting the test case.

In this case, would we also need something similar to our
TCP_BPF_<state> changes? Like BUILD_BUG_ON(BPF_NET_XMIT_XXX !=
NET_XMIT_XXX)? Otherwise, we risk more leakage into the UAPI.
Merely documenting doesn't seem enough?

> Programs checking for ret < 0 will continue to behave as before. Technically
> the bpf_clone_redirect() did its job just that on the veth side things were
> dropped. Other drivers such as tun, vrf, ipvlan, bond could already have
> returned NET_XMIT_DROP, so technically it's not a new situation where it is
> possible. And having a ret > 0 could then also be clearly used to differentiate
> that something came from driver side rather than helper side.
> 
> > > For the selftest, may be another option is to use a 28 bytes data_in for the
> > > lwt program redirecting to veth? 14 bytes used by bpf_prog_test_run_skb and
> > > leave 14 bytes for veth_xmit. It seems the original intention of the "veth
> > > ETH_HLEN+1 packet ingress" test is expecting it to succeed also.
> > 
> > IIUC, you're suggesting to pass full ipv4 or ipv6 packet for veth tests
> > to make them actually succeed with the forwarding, right?
> > 
> > Sure, I can do that. But let's keep this entry with the -NOBUFS as well?
> > Just for the sake of ensuring that we don't export NET_XMIT_xxx from
> > uapi.
> > 
> 

