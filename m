Return-Path: <bpf+bounces-13334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B437D861F
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 17:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFB41C20EB8
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 15:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F46374F7;
	Thu, 26 Oct 2023 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUKWS+oX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839BEF9E3;
	Thu, 26 Oct 2023 15:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B7AC433C8;
	Thu, 26 Oct 2023 15:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698335033;
	bh=jXfdXn+wwSI6ZNtlslSrkwqiIx+8s5iAKHJYnEX1bJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IUKWS+oXXzEsBIqHljh/6Dt3pjRuTLzvQKP+U9yXEf/0oA2ICfFemFbXNmERmCfcR
	 1ntHoZWJbZumxhVnv1SZDfjgjI6IHfPm8+Q5I2KMOZNSFRCVQe9IFXg7xNvKQxvDN2
	 sM9vNAJedJ21lTCSHEMxpewxx0EydnHsRe297UtV657apVy+8sQdcniiEwFMBFIbtX
	 EV7cnlLKqD9CcCxvKOVNc8M7nCm+SqoJc96gRFLaPSyFgiIBLxqbMz1jhZrc6J76Q6
	 EA4max+c8TbjbZrIDPXtFcAMb+DsEuEqW0fc04Ep1au8W7a4BPmNDloxI/KcF9CLbh
	 4GIvpNrRqUs7Q==
Date: Thu, 26 Oct 2023 08:43:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: bpf@vger.kernel.org, jiri@resnulli.us, netdev@vger.kernel.org,
 martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 john.fastabend@gmail.com, andrew@lunn.ch, toke@kernel.org, toke@redhat.com,
 sdf@google.com, daniel@iogearbox.net, idosch@idosch.org
Subject: Re: [PATCH bpf-next v2] netkit: use netlink policy for mode and
 policy attributes validation
Message-ID: <20231026084351.6bb4ba8a@kernel.org>
In-Reply-To: <20231026151659.1676037-1-razor@blackwall.org>
References: <20231026151659.1676037-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 18:16:59 +0300 Nikolay Aleksandrov wrote:
>  static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
>  	[IFLA_NETKIT_PEER_INFO]		= { .len = sizeof(struct ifinfomsg) },
> -	[IFLA_NETKIT_POLICY]		= { .type = NLA_U32 },
> -	[IFLA_NETKIT_MODE]		= { .type = NLA_U32 },
> -	[IFLA_NETKIT_PEER_POLICY]	= { .type = NLA_U32 },
> +	[IFLA_NETKIT_POLICY]		= NLA_POLICY_VALIDATE_FN(NLA_BINARY,
> +								 netkit_check_policy,
> +								 sizeof(u32)),
> +	[IFLA_NETKIT_MODE]		= NLA_POLICY_VALIDATE_FN(NLA_BINARY,
> +								 netkit_check_mode,
> +								 sizeof(u32)),
> +	[IFLA_NETKIT_PEER_POLICY]	= NLA_POLICY_VALIDATE_FN(NLA_BINARY,
> +								 netkit_check_policy,
> +								 sizeof(u32)),

I vote to leave this code be. It's not perfect. But typing it as binary
is not getting us closer to perfection.

