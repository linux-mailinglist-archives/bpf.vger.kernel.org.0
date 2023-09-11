Return-Path: <bpf+bounces-9682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FE179AAE8
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 20:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165CB2813CA
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 18:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853BB15AC2;
	Mon, 11 Sep 2023 18:52:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C70AD23
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 18:52:34 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE741AE
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 11:52:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-594e1154756so52079567b3.2
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694458353; x=1695063153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uVC9DbQLX8BuO4ptf6udoEJocd6aQ23mVf/eGtJr1sI=;
        b=2s0Mi9BhlzsOJWziWBYna/lnR9IQewQxB4pUehWWEBRzqV6hAChOGaHQTubMuXabv2
         +jyCHZwH5B9+07PCWiasEixJXY63ZmVFOlGjSBqtokMpvJdBrft9tb7yw+P/+Ks2lYPh
         2yEjIr1iGMu7Z2yIDTes9aTzO/gzy4juHxeG96MPpTMmKV7LXtbL+NCBHlqNIWSanBFd
         AKLfBxuxKW6SZ/fD3Q4KXOCKhqi4dKoBu0aFY9YKcQkw5AQsOOaTcZItZKz+yk02mfpD
         nAo2CgEP/YFUMoaoZS+Mc+bhzr5QhxIepTyLjebwMazUx9jJesIVIoAsa9FhuP5om6ZH
         XGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694458353; x=1695063153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVC9DbQLX8BuO4ptf6udoEJocd6aQ23mVf/eGtJr1sI=;
        b=QKt+z58PiddnSmnbrsR7tJfZwJxAHQHcrPckgJXKEIqEh0A7NSKbu3tHhxE8yDOo+M
         RTwyD70EwE5vxbapnknuzQIiviPITdlIYgUSVBd4CPu15xMJc0oPxf9ZyIBuFxhGstI1
         IixymvWeG4ZWKr3VCejPA2rBXx7PnRL6tlpK2MFBEkvmOgRincK5mNzESg5SD+FwfMhT
         XQTKV0sZAk9HLmHDTqtY0BJycMjFc2Uzrl5fePEA10eosFk/U2z5HCJteslayvrFT1NW
         LtT9o14n5o4xhYPa3/b6RXtSCvCmKynQR5Z/61+7YSYHe9Zdgs9WS0RQ56qnbbZ+FEUA
         +W+w==
X-Gm-Message-State: AOJu0Yw1NKiZrlV5XF22qzQoCbmRc5mDVUJWz+SPzc3G64UrkuSKVi/x
	Vbmqk7r0nTukF1h7OX4X6GRNR9I=
X-Google-Smtp-Source: AGHT+IEt+Z2d2lLwbwXzKonZd1+e2kHXUXRkb1UZDcV/c+8oP/vgtR0L3uLRRJ+kBZ9JeY6Io3s99y0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:a8b:b0:d12:d6e4:a08f with SMTP id
 cd11-20020a0569020a8b00b00d12d6e4a08fmr208492ybb.6.1694458352869; Mon, 11 Sep
 2023 11:52:32 -0700 (PDT)
Date: Mon, 11 Sep 2023 11:52:31 -0700
In-Reply-To: <927cc104-a266-7300-f601-e39d5d0fef59@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230908210007.1469091-1-sdf@google.com> <acdb12bc-518a-c3f6-ef09-2dfd714770b5@linux.dev>
 <ZP9KJpQIpoYqzaB3@google.com> <a7570c31-b19d-e1d8-8e7e-f47ead34b79b@iogearbox.net>
 <ZP9RSu3QDRN0wsr/@google.com> <927cc104-a266-7300-f601-e39d5d0fef59@iogearbox.net>
Message-ID: <ZP9h71zBaUUVsYYs@google.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: return correct -ENOBUFS from bpf_clone_redirect
From: Stanislav Fomichev <sdf@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, ast@kernel.org, andrii@kernel.org, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 09/11, Daniel Borkmann wrote:
> On 9/11/23 7:41 PM, Stanislav Fomichev wrote:
> > On 09/11, Daniel Borkmann wrote:
> > > On 9/11/23 7:11 PM, Stanislav Fomichev wrote:
> > > > On 09/09, Martin KaFai Lau wrote:
> > > > > On 9/8/23 2:00 PM, Stanislav Fomichev wrote:
> > > > > > Commit 151e887d8ff9 ("veth: Fixing transmit return status for dropped
> > > > > > packets") exposed the fact that bpf_clone_redirect is capable of
> > > > > > returning raw NET_XMIT_XXX return codes.
> > > > > > 
> > > > > > This is in the conflict with its UAPI doc which says the following:
> > > > > > "0 on success, or a negative error in case of failure."
> > > > > > 
> > > > > > Let's wrap dev_queue_xmit's return value (in __bpf_tx_skb) into
> > > > > > net_xmit_errno to make sure we correctly propagate NET_XMIT_DROP
> > > > > > as -ENOBUFS instead of 1.
> > > > > > 
> > > > > > Note, this is technically breaking existing UAPI where we used to
> > > > > > return 1 and now will do -ENOBUFS. The alternative is to
> > > > > > document that bpf_clone_redirect can return 1 for DROP and 2 for CN.
> > > > > > 
> > > > > > Reported-by: Daniel Borkmann <daniel@iogearbox.net>
> > > > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > > > ---
> > > > > >     net/core/filter.c | 3 +++
> > > > > >     1 file changed, 3 insertions(+)
> > > > > > 
> > > > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > > > index a094694899c9..9e297931b02f 100644
> > > > > > --- a/net/core/filter.c
> > > > > > +++ b/net/core/filter.c
> > > > > > @@ -2129,6 +2129,9 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
> > > > > >     	ret = dev_queue_xmit(skb);
> > > > > >     	dev_xmit_recursion_dec();
> > > > > > +	if (ret > 0)
> > > > > > +		ret = net_xmit_errno(ret);
> > > > > 
> > > > > I think it is better to have bpf_clone_redirect returning -ENOBUFS instead
> > > > > of leaking NET_XMIT_XXX to the uapi. The bpf_clone_redirect in the
> > > > > uapi/bpf.h also mentions
> > > > > 
> > > > >    *      Return
> > > > >    *              0 on success, or a negative error in case of failure.
> > > > > 
> > > > > If -ENOBUFS is returned in __bpf_tx_skb, should the same be done for
> > > > > __bpf_rx_skb? and should net_xmit_errno() only be done for
> > > > > bpf_clone_redirect()?  __bpf_{tx,rx}_skb is also used by skb_do_redirect()
> > > > > which also calls __bpf_redirect_neigh() that returns NET_XMIT_xxx but no
> > > > > caller seems to care the NET_XMIT_xxx value now.
> > > > 
> > > > __bpf_rx_skb seems to only add to backlog and doesn't seem to return any
> > > > of the NET_XMIT_xxx. But I might be wrong and haven't looked too deep
> > > > into that.
> > > > 
> > > > > Daniel should know more here. I would wait for Daniel to comment.
> > > > 
> > > > Ack, sure!
> > > 
> > > I think my preference would be to just document it in the helper UAPI, what
> > > Stan was suggesting below:
> > > 
> > > | Note, this is technically breaking existing UAPI where we used to
> > > | return 1 and now will do -ENOBUFS. The alternative is to
> > > | document that bpf_clone_redirect can return 1 for DROP and 2 for CN.
> > > 
> > > And then only adjusting the test case.
> > 
> > In this case, would we also need something similar to our
> > TCP_BPF_<state> changes? Like BUILD_BUG_ON(BPF_NET_XMIT_XXX !=
> > NET_XMIT_XXX)? Otherwise, we risk more leakage into the UAPI.
> > Merely documenting doesn't seem enough?
> 
> We could probably just mention that a positive, non-zero code indicates
> that the skb clone got forwarded to the target netdevice but got dropped
> from driver side. This is somewhat also driver dependent e.g. if you look
> at dummy which does drop-all, it returns NETDEV_TX_OK. Anything more
> specific in the helper doc such as defining BPF_NET_XMIT_* would be more
> confusing.

Something like the following?

Return
	0 on success, or a negative error in case of failure. Positive
	error indicates a potential drop or congestion in the target
	device. The particular positive error codes are not defined.

