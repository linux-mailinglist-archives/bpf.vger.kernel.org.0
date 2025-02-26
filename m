Return-Path: <bpf+bounces-52655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ACBA465CC
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 16:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F55D7A3798
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9113B21CC6C;
	Wed, 26 Feb 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn7YwetH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1627A1A238B;
	Wed, 26 Feb 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585421; cv=none; b=l48WMVEJBRnPAiH7ix8DGjqkgFM0calDInPb7htOFbHCEiFBFte//K4vE+LaCwzuBzVeDTTx8rYzv3qjgwh2bwi9s/fVtCDRnm/XkQdVS/4fEYEuQvYGNOxXd7Gs8DesunIvy7h7EToILAtvWY4KY6iJirmvJvY8/N2QAUobcTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585421; c=relaxed/simple;
	bh=0SzxgF835egvXUi404gxbE0Wj59PnOeDX9vBQVmodco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwm66vciGhTJJwtdGnQFGZe52Bd+ckThvzvSe5t6A6wft8HtwsInNDkzNWpvoP8nTwNkZbl9n13tOiFhr86rKROe34Z89aiCXrCU9Uyx+ObTXIPZr2cF64QiXqTDMaMebcNRVLsAo+kCyZoa0v5WVmAl0IIJWoY18THVAMHX0Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn7YwetH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDBFC4CED6;
	Wed, 26 Feb 2025 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740585420;
	bh=0SzxgF835egvXUi404gxbE0Wj59PnOeDX9vBQVmodco=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dn7YwetHXjnSGxD05OJ0gyHe56QaZ10drk6AMiseaI7RGpHlnQlcKFggOG0eymP5K
	 YAtT5hXNOaX+vQPCVphwc9xHvs0i9TVJiYrWBnZtQ/0a67+RMXieVY9u02/GNDDDXO
	 fS6q0WgTftyR4J84eBwm+m0qdMvS1UTAZu3cwefiBa5cl2A1lYUFqiqZ+WpsfQmL9n
	 f9gLy7CJJni1O/XanXPEzbCxRPUGaBjvZtJwTHcn++L4V8kyf3DA46Z3N3Y/PQ5vHu
	 vdg130dKwPu2uptrLjO16Prc1NNk/VRgkc1tH5YJOo1+aRalu5e7MoyjAMx30Uh6LD
	 W/ssykPn8NnNg==
Message-ID: <f1854274-653a-414a-9300-c2e805d2ce14@kernel.org>
Date: Wed, 26 Feb 2025 08:56:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2] ip: link: netkit: Support scrub options
Content-Language: en-US
To: Jordan Rife <jordan@jrife.io>, Daniel Borkmann <daniel@iogearbox.net>,
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, stephen@networkplumber.org
References: <20250224164903.138865-1-jordan@jrife.io>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250224164903.138865-1-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 9:49 AM, Jordan Rife wrote:
> diff --git a/ip/iplink_netkit.c b/ip/iplink_netkit.c
> index 49550a2e..818da119 100644
> --- a/ip/iplink_netkit.c
> +++ b/ip/iplink_netkit.c
> @@ -24,13 +24,19 @@ static const char * const netkit_policy_strings[] = {
>  	[NETKIT_DROP]		= "blackhole",
>  };
>  
> +static const char * const netkit_scrub_strings[] = {
> +	[NETKIT_SCRUB_NONE]	= "none",
> +	[NETKIT_SCRUB_DEFAULT]	= "default",
> +};
> +
>  static void explain(struct link_util *lu, FILE *f)
>  {
>  	fprintf(f,
> -		"Usage: ... %s [ mode MODE ] [ POLICY ] [ peer [ POLICY <options> ] ]\n"
> +		"Usage: ... %s [ mode MODE ] [ POLICY ] [ scrub SCRUB ] [ peer [ POLICY <options> ] ]\n"
>  		"\n"
>  		"MODE: l3 | l2\n"
>  		"POLICY: forward | blackhole\n"
> +		"SCRUB: default | none\n"

needs an update to the man page.



