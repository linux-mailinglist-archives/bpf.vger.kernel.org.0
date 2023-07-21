Return-Path: <bpf+bounces-5649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68AA75D556
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 22:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68531C21783
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 20:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169FF23BD4;
	Fri, 21 Jul 2023 20:03:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D361B21D5F;
	Fri, 21 Jul 2023 20:03:41 +0000 (UTC)
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529A1272C;
	Fri, 21 Jul 2023 13:03:39 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.west.internal (Postfix) with ESMTP id 1D99E2B00169;
	Fri, 21 Jul 2023 16:03:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 21 Jul 2023 16:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1689969813; x=1689977013; bh=UI
	xSERX8/T0QhMA41PxgSILvKp1Mo/d3t7SIbHJ30FM=; b=t48KOEps/vCcAI7DxH
	mMtvIueAxN1ZU4cTbiqPu1lCCyFdy83iX7cSuiW88Rc/iGJjZo5VKLVtSJkgKBYT
	2gKdzkEb3EBc8wuTXV/RPO5XwcJDdYBURiqAp2yGU8j4c5Lz0ZVOHNUiZ6qCo1Xe
	bL4QIktHu/2GuzJiUsP1sW9oV+CebNH3btNt8Fb4GGUBvuhEUSwKbjs+YceDLwqE
	wDeWeXA0k85WM4qxv11pIJCRQvCK3Mf1XOJTWSffF1UU/cwoNotj8AAu/0iGrejI
	CO0XX2ElBmcwyuAyuRP2xQp2YOpB4GnASkeQMgjoegqq3VaTi1ECshbJBuHLf5I+
	VwUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1689969813; x=1689977013; bh=UIxSERX8/T0Qh
	MA41PxgSILvKp1Mo/d3t7SIbHJ30FM=; b=DNcO38MFDJ/BX9RI1DERnK7T82652
	LbDTk23wYUgeUIg8cVJRj5kaUejXv3Jh5Q55I3tJdc1z2yqXswdlGgKQoWt3KXMy
	ppdC7aA2v9w938C9T6DWUD3Nsjhvgs+oot/aFZ1DER+1kDTElPprs17OAxhJdBU5
	9Ws2kh1VXJ21Kq3511b7+DEPf3+IAi/dslfY5laRlsNDZeDkgQUYPMrl1K8CWAiY
	MtQ8zxzRbcuK9/nfdktUVlWEDWNzh8J4erjzK95sNoJHeS/fEV2W5N2l3e6ZSTP7
	iLVAAp7K1EXrHnNjT4yTqNyCbBVnUrfIJ0OhrAEUxiI8D+atNWOE++Thw==
X-ME-Sender: <xms:lOS6ZLi_yl2HEx8VNhPzXISbLHNDccRa4qdqkaEkYYHIFUaa0-Phvg>
    <xme:lOS6ZIANKa0Fe-CWSCLV7KmOeogapQ3OxYmJp_BwMGaVpetH7KZG_ylvTtzP4eDD6
    r0PfuKZu9bJb9mlIQ>
X-ME-Received: <xmr:lOS6ZLEX_AV5j1TyvlUPDixKyvVcmK00XVk3ff_R1JBC1O1Ve_crbubbe2jzKae7x39MtdO2cN4AIyrEX_-c5TAR4XZYJRUAB9PY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgddufeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:lOS6ZISIrqP9DmogYZlfIhS1AHOz9ht7hAOJh8Ks8flYsHdgsw5Zrw>
    <xmx:lOS6ZIx86g21Z66hxEaTtAlnF63MWXKQmyAOdUJ0C7bMkmbnigv8pA>
    <xmx:lOS6ZO5rs1Ky-lE-zxOyYIYbqSeGOOlORer4lqBlLvtJ1yG8dJhUDg>
    <xmx:leS6ZHi9AvtvYGlY_SOCwmEKnLe0DXKCdmvumiTkBNinwEt__yKEnX8ETLs>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 16:03:30 -0400 (EDT)
Date: Fri, 21 Jul 2023 14:03:29 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Florian Westphal <fw@strlen.de>
Cc: daniel@iogearbox.net, kadlec@netfilter.org, ast@kernel.org, 
	pablo@netfilter.org, kuba@kernel.org, davem@davemloft.net, andrii@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, alexei.starovoitov@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH bpf-next v5 2/5] netfilter: bpf: Support
 BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Message-ID: <waoejzg2unjytkjflwvcff4z6wu2vlsji5neybrt4p5a3bn3ev@nznwevyfywvh>
References: <cover.1689884827.git.dxu@dxuuu.xyz>
 <690a1b09db84547b0f0c73654df3f4950f1262b7.1689884827.git.dxu@dxuuu.xyz>
 <20230720231904.GA31372@breakpoint.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720231904.GA31372@breakpoint.cc>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 01:19:04AM +0200, Florian Westphal wrote:
> Daniel Xu <dxu@dxuuu.xyz> wrote:
> > +	const struct nf_defrag_hook __maybe_unused *hook;
> > +
> > +	switch (link->hook_ops.pf) {
> > +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
> > +	case NFPROTO_IPV4:
> > +		hook = get_proto_defrag_hook(link, nf_defrag_v4_hook, "nf_defrag_ipv4");
> > +		if (IS_ERR(hook))
> > +			return PTR_ERR(hook);
> > +
> > +		link->defrag_hook = hook;
> > +		return 0;
> > +#endif
> > +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
> > +	case NFPROTO_IPV6:
> > +		hook = get_proto_defrag_hook(link, nf_defrag_v6_hook, "nf_defrag_ipv6");
> > +		if (IS_ERR(hook))
> > +			return PTR_ERR(hook);
> > +
> > +		link->defrag_hook = hook;
> > +		return 0;
> > +#endif
> > +	default:
> > +		return -EAFNOSUPPORT;
> > +	}
> > +}
> > +
> > +static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
> > +{
> > +	const struct nf_defrag_hook *hook = link->defrag_hook;
> > +
> > +	if (!hook)
> > +		return;
> > +	hook->disable(link->net);
> > +	module_put(hook->owner);
> > +}
> > +
> >  static void bpf_nf_link_release(struct bpf_link *link)
> >  {
> >  	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
> > @@ -37,6 +119,8 @@ static void bpf_nf_link_release(struct bpf_link *link)
> >  	 */
> >  	if (!cmpxchg(&nf_link->dead, 0, 1))
> >  		nf_unregister_net_hook(nf_link->net, &nf_link->hook_ops);
> > +
> > +	bpf_nf_disable_defrag(nf_link);
> >  }
> 
> I suspect this needs to be within the cmpxchg() branch to avoid
> multiple ->disable() calls.

Ah, good catch.

> 
> > +	if (attr->link_create.netfilter.flags & BPF_F_NETFILTER_IP_DEFRAG) {
> > +		err = bpf_nf_enable_defrag(link);
> > +		if (err) {
> > +			bpf_link_cleanup(&link_primer);
> > +			return err;
> > +		}
> > +	}
> > +
> >  	err = nf_register_net_hook(net, &link->hook_ops);
> >  	if (err) {
> 		bpf_nf_disable_defrag(link);

Ack. Did not see that bpf_link_cleanup() sets link->prog to NULL which
disables bpf_link_ops:release() on the release codepath.

> 
> Other than those nits this lgtm, thanks!
> 

Thanks for reviewing!

Daniel

