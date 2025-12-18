Return-Path: <bpf+bounces-77035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A12E3CCD737
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 20:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8CBB302CAD4
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60D52BD02A;
	Thu, 18 Dec 2025 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQlbhU3W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520B327FD54;
	Thu, 18 Dec 2025 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766087917; cv=none; b=SbLB7myaZtK2LStbXIhUUmBg7jnVOQF2IGiHHMpQw9bVI9QE8RUxS7Ofto1q/jgR5X+hxdqSXj0dMofbm8ZyIOg1Q5RDcw+YOW6WtfYivoCJPTwtzWK+4URIdvwUC4ofIo0mtu2vhlKQD/StvBfYz25366cTaAzo+HBvPeE+4AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766087917; c=relaxed/simple;
	bh=VkLv7uKLoSczGnq8ayo+6HGLx9Godc3iHcvmeCAij2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJ23F8U1+EkCDGiYvcQQY3iQUe3FzQY0SIk6P5kObj1Wi1TpneewFnlfZwngX5EKm01tWun7PqhsekAinmp8WIrUCJGZKTGkf5gkcMebLHcwnIEbxlvh+owBgLoAq8+9diEadVGeSfoVbwY/adJo5Zj4EuOwZU8UVu9kdt0Qnt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQlbhU3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BC2C4CEFB;
	Thu, 18 Dec 2025 19:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766087916;
	bh=VkLv7uKLoSczGnq8ayo+6HGLx9Godc3iHcvmeCAij2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lQlbhU3WQWN+mslB/GZO92t3a0A1l2Mi2OmdPvWT1fVbijooOt7Ya6h8GQg9fIH9v
	 GPOUTpBB+knEM/Uqns/WfmXoVujecMIXBsRtipXzAfcR37/4uniq9+ADISkVs9olgf
	 hviNp0H8S6VRjOtB0BIKllo+oomOWs51HhLoc8vWiyvUrMhgefkn9vSereFPkouhSY
	 P2/g5/x/FcT8AqVSpOIl32dR7GwvsL5CmdXM6odlKlGRrACUj7zHQF9yfyFeO1xc38
	 4YLB2neGzdshTJhANL7CNkSris/9QPjj04YaZvtI67egtNsQBhhezTwcyP66oQfYAi
	 mmJkC0UIfzWpA==
Message-ID: <316f974b-50e8-4d24-b422-7b981fb84ecf@kernel.org>
Date: Thu, 18 Dec 2025 12:58:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2] lib/bpf_legacy: Use userspace SHA-1 code
 instead of AF_ALG
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20250929194648.145585-1-ebiggers@kernel.org>
 <20251112040719.GB2832160@google.com>
 <59755b49-fb81-41bf-8875-17e0215f1d8e@kernel.org>
 <20251217234447.GA89113@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20251217234447.GA89113@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/25 4:44 PM, Eric Biggers wrote:
>> If we are going to entertain removing AF_ALG code, we should apply the
>> patch to iproute2-next at the beginning of a dev cycle to give maximum
>> time for testing before it rolls out.
> 
> Any insight into when that would be?
> 


re-send it now.


