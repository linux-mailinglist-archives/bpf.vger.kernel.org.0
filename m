Return-Path: <bpf+bounces-41126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7A1992DF8
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 15:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33075281E5F
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDE51D54D7;
	Mon,  7 Oct 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRQYqMMl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F21D45FF;
	Mon,  7 Oct 2024 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309364; cv=none; b=lslsxKjvH0sgfWLnOZysbQ5hsqAm2/CQQaMWZdlOmNJ8o9Z+qprbWldru+yx+s3GsKQRhY27T6QEzAVJ6JWKam6gDZaLkUdWFKiPRe6YiIMJ/hZ4b5yU79obowxvWoi+cczBoaSKOnKlKQ9rUf2KWuKrx7hP4VX8tK0rs/DqFZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309364; c=relaxed/simple;
	bh=wvCri/APOwLwKzEXU27ZALMfuTtuI11RCzPtlLbbyiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TF+Ueb112L/0sL+tEZQpkg//UZHoZIlzJG9U7qx1Ktvqczl41yu3koXCnUCerYVhGNVG5/iNNKHl345/G1u7629dStQj1DYkBoTFUc1TxbUGyAeBhfEf+mKiQhuAfPGuzZDsEqK9RQHoJQS9tf9HD/qZAA1OFsdY73DUH1o0bMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRQYqMMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408BEC4CEC6;
	Mon,  7 Oct 2024 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728309363;
	bh=wvCri/APOwLwKzEXU27ZALMfuTtuI11RCzPtlLbbyiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hRQYqMMlWb5R+TYN+9Gtblw36NWS4sjRrmiX2IcEgOjSnsuMa2acTeTUpw136ZRVn
	 ehpgIagQIUhxVoACUxfRZT2LSsxGI2n3MdKnQ/AN44UH115WRfbZPOXMJQPElsd4MQ
	 TpiZyYjaBEunWM+u55QvDW1NIpbpzHLl6i748lQj0tu4MpatagA3TolpoNayyFKAKx
	 kSYcgq14cvbbubEonZRZND/yni3VGHU6z+Nd/cUGf3FXS9xhh+HpU38eI5e+1w7JgG
	 xW5LusspTY1r81TnxXZh/hPnsZzgIbUKwOn05fYHaKHsim6h7YQbnrrPJ/SyrKiIG/
	 N0sOS9Soj4BYQ==
Date: Mon, 7 Oct 2024 10:55:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves] btf_encoder: fix reversed condition for matching
 ELF section
Message-ID: <ZwPob57HKYbfNpOH@x1>
References: <20241005000147.723515-1-stephen.s.brennan@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005000147.723515-1-stephen.s.brennan@oracle.com>

On Fri, Oct 04, 2024 at 05:01:46PM -0700, Stephen Brennan wrote:
> We only want to consider PROGBITS and NOBITS. However, when refactoring
> this function for clarity, I managed to miss flip this condition. The
> result is fewer variables output, and bad section names used for the
> ones that are emitted.
> 
> Fixes: bf2eedb ("btf_encoder: Stop indexing symbols for VARs")
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
> 
> Hi Arnaldo,
> 
> This clearly slipped by me in my last small edit based on Alan's feedback, and I
> didn't run a full enough validation test after the last tweak since it was "just
> some small nits".
> 
> (His code review suggestion was not buggy... I introduced it as I shoddily
> redid his suggestion).
> 
> Sorry for the bug introduced at the last second - feel free to fold this into
> the commit or keep the commit as a monument to the bug :)

Nope, as it was just in the next branch, I folded it into the fixed
commit and kept just a lore link to this fixup, all is back in next now
and I'm redoing tests here.

Thanks for realizing the mistake and providing a fix, and thanks to Jiri
and Alan for reviewing the fix.

- Arnaldo
 
> Thanks,
> Stephen
> 
>  btf_encoder.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 201a48c..5954238 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2137,8 +2137,8 @@ static size_t get_elf_section(struct btf_encoder *encoder, uint64_t addr)
>  	/* Start at index 1 to ignore initial SHT_NULL section */
>  	for (size_t i = 1; i < encoder->seccnt; i++) {
>  		/* Variables are only present in PROGBITS or NOBITS (.bss) */
> -		if (encoder->secinfo[i].type == SHT_PROGBITS ||
> -		    encoder->secinfo[i].type == SHT_NOBITS)
> +		if (!(encoder->secinfo[i].type == SHT_PROGBITS ||
> +		     encoder->secinfo[i].type == SHT_NOBITS))
>  			continue;
>  
>  		if (encoder->secinfo[i].addr <= addr &&
> -- 
> 2.43.5

