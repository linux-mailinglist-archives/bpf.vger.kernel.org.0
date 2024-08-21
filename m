Return-Path: <bpf+bounces-37747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD2195A356
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 19:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DD01F231E8
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 17:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9471B1D6B;
	Wed, 21 Aug 2024 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPjKreLb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EBE13635B;
	Wed, 21 Aug 2024 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259653; cv=none; b=NhJZoXTrx6GqfqavdF6Go5n4H2Ciiu1Hn11//t57dFbFnC8SAqJjYO9PLH/LEkC8jtJ0YxkZ5cmhSR/loATNHWEndjDhlcODZK+ayNQXqyl4z3HSzvJeM+YEA89Czq1MKJWlUu0CSUFUmKhmBex8xd838r3LJ/Rp7/rKKJ2OQnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259653; c=relaxed/simple;
	bh=XcL10eQguhL9xnQXS2iZsuiQuvqlgs2UmruxJW2VK3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ig9xMLBHbxawepwgIXHAJsI+qpPK/FnBySvYQLN/zFZjFIXR676XbNkVggUQaeEm8AWLTp4qD8cwRloGeS64KoGxlgp+z+zKkpAM/9UrQ0EHhd0s5XNK2AvRNSccOMCvyeymHf+2aiAtdSLUHVwvfn0uRrmGlPCCDy+//kmOhSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPjKreLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4094DC32781;
	Wed, 21 Aug 2024 17:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724259653;
	bh=XcL10eQguhL9xnQXS2iZsuiQuvqlgs2UmruxJW2VK3g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HPjKreLbUV7X9kkF0RnKnBnMitV3oZ1WVrfOPXeSMlLwuCbjytOcXyCA9k5Wq45qM
	 3nrA6NvAJ5TJT8i/3Zn6z8+LamkJc5xmzk/plnOrER8TZdLRHLOOs54AmbK8U/fcrp
	 LwXBrY0jpMSydC6HoRgacKJ2rOAg8nd0HEzuQQkvLNttGXgCl4zOCtPitA7ShbNM+7
	 KffRSPVRe4FAwzJwhSg5IqP8+fofn1Enbpta/PSWZIcGjNxKTn9b+qQTJZnu0HPmRI
	 a5IRqMQ6A+9FURqxXKKYit0Ob298gg5ihxHH/HnMNgaQh+bZNXi1HGX20Kx9KkwJV8
	 jmWnW4q+Dnpwg==
Message-ID: <2a382dbb-0f90-4e6b-b8b9-844d93af5edc@kernel.org>
Date: Wed, 21 Aug 2024 11:00:51 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/12] Unmask upper DSCP bits - part 1
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, gnault@redhat.com, fw@strlen.de, martin.lau@linux.dev,
 daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 pablo@netfilter.org, kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
 bpf@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <20240821125251.1571445-1-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240821125251.1571445-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/24 6:52 AM, Ido Schimmel wrote:
> tl;dr - This patchset starts to unmask the upper DSCP bits in the IPv4
> flow key in preparation for allowing IPv4 FIB rules to match on DSCP. No
> functional changes are expected.
> 
> The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> lookup to match against the TOS selector in FIB rules and routes.
> 
> It is currently impossible for user space to configure FIB rules that
> match on the DSCP value as the upper DSCP bits are either masked in the
> various call sites that initialize the IPv4 flow key or along the path
> to the FIB core.
> 
> In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we
> need to make sure the entire DSCP value is present in the IPv4 flow key.
> This patchset starts to unmask the upper DSCP bits in the various places
> that invoke the core FIB lookup functions directly (patches #1-#7) and
> in the input route path (patches #8-#12). Future patchsets will do the
> same in the output route path.
> 
> No functional changes are expected as commit 1fa3314c14c6 ("ipv4:
> Centralize TOS matching") moved the masking of the upper DSCP bits to
> the core where 'flowi4_tos' is matched against the TOS selector.
> 

for the set:
Reviewed-by: David Ahern <dsahern@kernel.org>



