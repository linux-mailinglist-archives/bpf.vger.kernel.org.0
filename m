Return-Path: <bpf+bounces-56865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EE1A9F99B
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 21:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1193F463CBE
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 19:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A582973A0;
	Mon, 28 Apr 2025 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9nEGEJn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A738C1E;
	Mon, 28 Apr 2025 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745868968; cv=none; b=WsPnvTA6Rh0jcpLupJuwrZ4rMGBZxAmKtoEvxLJWcZbvXXoglyg8DQbMufQTSzsgtyaNfKNxQlmqFkaOI2v6C5XuarK7givbiHAOfQgbqyyi4km1envGNEq3QoYvoGmcfIwU4PAgdL0rKOer2tauQwGtWf3YeygmBA9+u6Los0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745868968; c=relaxed/simple;
	bh=Mg1A5B4wWnWudt4kflG6AkDnwfKsuRXxG/Z6TbYH8Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2mxQnuoxBGAR3Xlt8lHy+hjMijpyDW/nG9sl2bvqth14VmueSqbgit9stchJ7FRU4FFdevqCUCTUBMCmXH0BGL9+k8ZJNGSZKXM7GpVJmT1ujV4eKy2aJWgA8Zw5A7zpXLZWhmE2RPRE2jPdP+u/J9tbQsEs35EXvLUiLSZIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9nEGEJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4533DC4CEE4;
	Mon, 28 Apr 2025 19:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745868966;
	bh=Mg1A5B4wWnWudt4kflG6AkDnwfKsuRXxG/Z6TbYH8Mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y9nEGEJnIy2Senc3EKLo1R0sl/6nNmy3i/NA5SPoNktOJVP9R+M5RwjqHu4W0t4EA
	 TxIqOpx0ptosx/70A9UjN84SMygUFZNdCONOy9TwnHNP87viKoY5a1uBXHUMCky59H
	 jhjIkafzls20cKRoOwMy7niLCQarz+7pFqqrfIge8pb5vWnHkMiPWvcMwBa294jN03
	 6V9bBVaR3yGD3SPYI/Pj1JywvD/kXoF2rZyHscAmnQOoBK2VsCgsAkF1fTy2OFbVvh
	 Kyq+Yu3bf9cMmsrKh6QR7zV0RqOY0YukkdIXTwISoMwuAvvEH7l8Sj8wz0zoxNRAyp
	 BayfxAQ0Bnfzg==
Date: Mon, 28 Apr 2025 16:36:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>,
	dwarves@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: pahole and gcc-14 issues
Message-ID: <aA_Yo6v7qicMy9xk@x1>
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
 <076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com>
 <CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
 <4aa02e25-7231-40f4-a0ba-e10db3833d81@oracle.com>
 <CAEf4BzYRnNGGafWS8XoXRHd3zje=8xY1o5_8aVw6vxrUSbEehg@mail.gmail.com>
 <c8c4dc05-7fa3-4c1f-a652-a470dd6985c7@oracle.com>
 <e279abde-f4c1-42d2-bcc0-4df174057431@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e279abde-f4c1-42d2-bcc0-4df174057431@oracle.com>

On Mon, Apr 28, 2025 at 04:21:14PM +0100, Alan Maguire wrote:
> In the bad case, the bpf_prog active member:
 
> <2><3d594>: Abbrev Number: 4 (DW_TAG_member)
>     <3d595>   DW_AT_name        : (indirect string, offset: 0x3b976): active
>     <3d599>   DW_AT_decl_file   : 125
>     <3d59a>   DW_AT_decl_line   : 1654
>     <3d59c>   DW_AT_decl_column : 17
>     <3d59d>   DW_AT_type        : <0x4bd05>
 
> ...is a pointer:
> 
>  <1><4bd05>: Abbrev Number: 58 (DW_TAG_pointer_type)
>     <4bd06>   DW_AT_byte_size   : 8
>     <4bd07>   DW_AT_address_class: 2
>     <4bd08>   DW_AT_type        : <0x301cd>
 
> ...which points at an int
 
>  <1><301cd>: Abbrev Number: 214 (DW_TAG_base_type)
>     <301cf>   DW_AT_byte_size   : 4
>     <301d0>   DW_AT_encoding    : 5     (signed)
>     <301d1>   DW_AT_name        : int
>     <301d5>   DW_AT_name        : int
 
> ...but note the the DW_AT_address_class attribute in the latter case and
> the two DW_AT_name values. We don't use that address attribute in pahole
> as far as I can see, but it might be enough to cause problems.

Looks like broken DWARF, there should be just one DW_AT_name per
DW_TAG_base_type, what is the language for the CU where the bad cases
appear? Is some sort of LTO being used?

- Arnaldo

