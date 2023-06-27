Return-Path: <bpf+bounces-3574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E59773FFCD
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 17:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF06728110D
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F8D19BA8;
	Tue, 27 Jun 2023 15:35:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547F116417;
	Tue, 27 Jun 2023 15:35:30 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679F42978;
	Tue, 27 Jun 2023 08:35:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.west.internal (Postfix) with ESMTP id D527D2B0013F;
	Tue, 27 Jun 2023 11:35:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 27 Jun 2023 11:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1687880122; x=1687887322; bh=Ma
	Wd3XEowwvLUFCc41uoQ1RE2kMoRIlrDDw0f1G5UY8=; b=Fs0XZFqcF1Z6kxWEqj
	VyipIL1Lu2IQBe6WPOIhyccgGX5pW5thA0IpIpbrLMyRZP46FokJJG4n8nge6xrd
	wPZDY+RpHlYiMHbTEKOu2REa5lfjAvtfeRplS3fQrQVkr7vM3+OT9gKOQSTbscub
	B8633BC4A1OB2ZHv2WKhM/Z3jGftxhXO8mrY5sex96hQ9iZOiwUcjNSS6pxkG9rq
	4UwbkU6eUdBRhYz00e3DymWK2h30gFAeXrypMHue27O2Jflbx7+g2lggx4U1fXqU
	KrtZZwzQcFpB7CWvAFM6YSVq2UZtnVqmdBMMOYUFFhlTJP0gmlv/YU5kr4x2JCRe
	lXyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1687880122; x=1687887322; bh=MaWd3XEowwvLU
	FCc41uoQ1RE2kMoRIlrDDw0f1G5UY8=; b=j9ZSCj7W+XQf8JkJmrPDFf7EOxMTB
	tqpymNDN9SIS7JTjR0gqqySkBRVgGPlNr8FQZCFfRcjlQx7IXrirGJH6D7aBaqPs
	Z9AZoTDeJMQg08S6ImwCc4hNp0yKrSZqWISMHPmKhAPXtKeArXRJ+WKUHOTNo1Be
	ByNZVCUa+1HJJ2lU9IDKk6j0io8jicWURhhuWVlZiiTnAqi9XPbyUUlzUgrZHRd5
	a/bAh8a817zKOYuku1V0Ow+I0cSSq+FfF1fFIXn9NvivMXIXNBn1B/Xe0rp6mvlR
	+5GP662che8RMu08ZyxWWK18q0j2d4Mjj1jYXVnGIO3xGbPVYMkwvwLPg==
X-ME-Sender: <xms:uQGbZBx6DGW6t-IECKNUw9WFzYNO294lwPkVNHxyHlz_3F6G3EF6HQ>
    <xme:uQGbZBRCy13UqbAxIjL1uoQ0lx2HM4dxvIdNQaHQnKTQqE7zuc0k2JaIleHXPT9ye
    jweR9REd79c82u06g>
X-ME-Received: <xmr:uQGbZLVyucbrKlXZfODVGfTwDAq0TkrrQoL2WKfzbiDmdUrmWFEfwApHG7FptRznwUrRTimviu8aa6jxWKWmqfngLEBo8zGbeboD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddtgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffffgfeg
    iedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:ugGbZDjhwzOYxW82dEuuydsSiFPt6dk92wWs2bXOdWBfZEnthxCS5w>
    <xmx:ugGbZDD5onJICIyrRsab8yj9lDnwB5wntHPq9i8M9-jUzu5r67Tf_Q>
    <xmx:ugGbZMLVaxTNm5BPF_9vLR3xOAbGZgGjCcWXjiz5zfYxLoOwfrOVWg>
    <xmx:ugGbZFzStJSByafpx22ow7dsPAOzBtJREFBZQ6xrOy9l9mqE81gHgsDSFqg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jun 2023 11:35:20 -0400 (EDT)
Date: Tue, 27 Jun 2023 09:35:19 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Florian Westphal <fw@strlen.de>
Cc: daniel@iogearbox.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pablo@netfilter.org, andrii@kernel.org, davem@davemloft.net, 
	ast@kernel.org, kadlec@netfilter.org, martin.lau@linux.dev, song@kernel.org, 
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH bpf-next 4/7] netfilter: bpf: Support
 BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Message-ID: <5hnelxxsrwyon36k3t7uhxbdaqu4ku246vkec6kxkfkqivkcsm@xusgh57bm2xj>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
 <242c66138bf4ec8aa26b29d736fb48242b4164ce.1687819413.git.dxu@dxuuu.xyz>
 <20230627111248.GH3207@breakpoint.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627111248.GH3207@breakpoint.cc>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 01:12:48PM +0200, Florian Westphal wrote:
> Daniel Xu <dxu@dxuuu.xyz> wrote:
> > +static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
> > +{
> > +	int err;
> > +
> > +	switch (link->hook_ops.pf) {
> > +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
> > +	case NFPROTO_IPV4:
> > +		const struct nf_defrag_v4_hook *v4_hook;
> > +
> > +		err = request_module("nf_defrag_ipv4");
> > +		if (err)
> > +			return err;
> > +
> > +		rcu_read_lock();
> > +		v4_hook = rcu_dereference(nf_defrag_v4_hook);
> > +		err = v4_hook->enable(link->net);
> > +		rcu_read_unlock();
> 
> I'd reverse this, first try rcu_dereference(), then modprobe
> if thats returned NULL.

Ack.

> 
> > +static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
> > +{
> > +	switch (link->hook_ops.pf) {
> > +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
> > +	case NFPROTO_IPV4:
> > +		const struct nf_defrag_v4_hook *v4_hook;
> > +
> > +		rcu_read_lock();
> > +		v4_hook = rcu_dereference(nf_defrag_v4_hook);
> > +		v4_hook->disable(link->net);
> > +		rcu_read_unlock();
> 
> if (v4_hook)
> 	v4_hook->disable()
> 
> Else we get trouble on manual 'rmmod'.

Ah good catch, thanks.

> 
> > +	/* make sure conntrack confirm is always last */
> > +	prio = attr->link_create.netfilter.priority;
> > +	if (prio == NF_IP_PRI_FIRST)
> > +		return -ERANGE;  /* sabotage_in and other warts */
> > +	else if (prio == NF_IP_PRI_LAST)
> > +		return -ERANGE;  /* e.g. conntrack confirm */
> > +	else if ((attr->link_create.netfilter.flags & BPF_F_NETFILTER_IP_DEFRAG) &&
> > +		 (prio > NF_IP_PRI_FIRST && prio <= NF_IP_PRI_CONNTRACK_DEFRAG))
> > +		return -ERANGE;  /* cannot use defrag if prog runs before nf_defrag */
> 
> You could elide the (prio > NF_IP_PRI_FIRST, its already handled by
> first conditional.  Otherwise this looks good to me.
> 

Ah, right. It's INT_MIN.


Thanks,
Daniel

