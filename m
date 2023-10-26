Return-Path: <bpf+bounces-13324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B066D7D8445
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 16:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF77B21284
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 14:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19A72E64B;
	Thu, 26 Oct 2023 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iMZ2PNok"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE932E417;
	Thu, 26 Oct 2023 14:11:21 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4561A2;
	Thu, 26 Oct 2023 07:11:19 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id D8A043200949;
	Thu, 26 Oct 2023 10:11:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 26 Oct 2023 10:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698329475; x=1698415875; bh=icAvO3Qd0Syql
	JN8OcKoRqpnDG3ni8FEKMVwrdoDRp4=; b=iMZ2PNokvbqQmcXrCAS4KxPS3uTxo
	0384DHXfJVdOxS0LOMDBur2GxBhs6iofAncqW1wJLB6DPJJrRMh9WW55ef+P9E3c
	5h/EqMwfkzLoHVejnkOm2FSut1WGwcA4Nz8WMs786N/o1EGEqTi517gvinsI/mzV
	wo4V1vODy2QdyNPuhumr3wP59w/AID8gHvB/7wJg8xut6QsKP1Ui/pPHkyxsYeBZ
	68jRYo1S1b56dtWoDMnjC31dzq65pExUuOggzan4tC2D0oNjCoJuyK9qXcXNnMts
	teJVb3Q2g4RDqnCtFhNV6Wer4biBZaPPJ+v/e8dRo/WJi29ww2UIbErLg==
X-ME-Sender: <xms:gnM6ZQQGh1nbBnIC9nqilgl95yCNFvdlhlxGBwKeKW3jFtJBeoVipA>
    <xme:gnM6ZdxDi7noAq-QS--JUz3zaijfDY6-1CYP5-r1QzGvg0if5fbhI_YBY3OWxH6uH
    TWhK3_SdgZI6Cg>
X-ME-Received: <xmr:gnM6Zd3kc23fm1qwq3iWuPQYpFb7nXxWnOGkoDL4SZU2JYn8adnMvWGQuabQQjWW9rmF9a_gQiuXCVWb9IzMk3gxKnJXfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiugho
    shgthhdrohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgud
    eifeduieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:gnM6ZUBslqAbf-TesFPkv5R7vyPTbY-4LZD0SttG6zxlLASXZz0lmQ>
    <xmx:gnM6ZZhbkQyfwO7tSj1jGeiA20OaGxc48wkoDF3gmnP-9zsPdCWICA>
    <xmx:gnM6ZQosNbOhAVC38FVHw2hiAosvczp33-1S8IqtxtZ6BNzZpACHAw>
    <xmx:g3M6ZUpV9t2rTYXGyhKL_hGK0Iiip3Gdqv1q8zf-hYyLS2X8SLYooQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 10:11:13 -0400 (EDT)
Date: Thu, 26 Oct 2023 17:11:09 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: bpf@vger.kernel.org, jiri@resnulli.us, netdev@vger.kernel.org,
	martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
	john.fastabend@gmail.com, kuba@kernel.org, andrew@lunn.ch,
	toke@kernel.org, toke@redhat.com, sdf@google.com,
	daniel@iogearbox.net
Subject: Re: [PATCH bpf-next 2/2] netkit: use netlink policy for mode and
 policy attributes validation
Message-ID: <ZTpzfckQ5n4o2F7D@shredder>
References: <20231026094106.1505892-1-razor@blackwall.org>
 <20231026094106.1505892-3-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026094106.1505892-3-razor@blackwall.org>

On Thu, Oct 26, 2023 at 12:41:06PM +0300, Nikolay Aleksandrov wrote:
>  static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
>  	[IFLA_NETKIT_PEER_INFO]		= { .len = sizeof(struct ifinfomsg) },
> -	[IFLA_NETKIT_POLICY]		= { .type = NLA_U32 },
> -	[IFLA_NETKIT_MODE]		= { .type = NLA_U32 },
> -	[IFLA_NETKIT_PEER_POLICY]	= { .type = NLA_U32 },
> +	[IFLA_NETKIT_POLICY]		= NLA_POLICY_VALIDATE_FN(NLA_U32,
> +								 netkit_check_policy),

Nik, it's problematic to use NLA_POLICY_VALIDATE_FN() with anything
other than NLA_BINARY. See commit 9e17f99220d1 ("net/sched: act_mpls:
Fix warning during failed attribute validation").

> +	[IFLA_NETKIT_MODE]		= NLA_POLICY_VALIDATE_FN(NLA_U32,
> +								 netkit_check_mode),
> +	[IFLA_NETKIT_PEER_POLICY]	= NLA_POLICY_VALIDATE_FN(NLA_U32,
> +								 netkit_check_policy),
>  	[IFLA_NETKIT_PRIMARY]		= { .type = NLA_REJECT,
>  					    .reject_message = "Primary attribute is read-only" },
>  };
> -- 
> 2.38.1
> 
> 

