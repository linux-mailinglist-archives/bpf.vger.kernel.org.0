Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB342B2256
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 18:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgKMR2g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 12:28:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgKMR2g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Nov 2020 12:28:36 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0960820A8B;
        Fri, 13 Nov 2020 17:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605288515;
        bh=gupygpViVpZX2FHgH3V5GslVXVOVVFaRCre/+S6Ve4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbk36kHfRknT+DWbeBRy09qzeWWSg4mxocIvHN8EYBRS8JiOQvhqd2ubodT3l7g6m
         pVvTe4PELd9wL/1u6QgQIDzdr7Ifyp+42qqtQjD3atd+4uGO348CTHsuYhhnHshdyy
         Orf6V7oPIQdSiryFSoqd9jHNWziIs5QEmoPq94P0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 78AEA411D1; Fri, 13 Nov 2020 14:28:32 -0300 (-03)
Date:   Fri, 13 Nov 2020 14:28:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 2/2] btf_encoder: Fix function generation
Message-ID: <20201113172832.GA446420@kernel.org>
References: <20201113151222.852011-1-jolsa@kernel.org>
 <20201113151222.852011-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113151222.852011-3-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Nov 13, 2020 at 04:12:22PM +0100, Jiri Olsa escreveu:
> Current conditions for picking up function records break
> BTF data on some gcc versions.
> 
> Some function records can appear with no arguments but with
> declaration tag set, so moving the 'fn->declaration' in front
> of other checks.
> 
> Then checking if argument names are present and finally checking
> ftrace filter if it's present. If ftrace filter is not available,
> using the external tag to filter out non external functions.

Humm has_arg_names() will return true for a:

void foo(void)

function, which I think is right, but can't this function appear
multiple times in different CUs and we end up with the same function
multiple times in the BTF info?

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  btf_encoder.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index d531651b1e9e..de471bc754b1 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -612,25 +612,21 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  		const char *name;
>  
>  		/*
> -		 * The functions_cnt != 0 means we parsed all necessary
> -		 * kernel symbols and we are using ftrace location filter
> -		 * for functions. If it's not available keep the current
> -		 * dwarf declaration check.
> +		 * Skip functions that:
> +		 *   - are marked as declarations
> +		 *   - do not have full argument names
> +		 *   - are not in ftrace list (if it's available)
> +		 *   - are not external (in case ftrace filter is not available)
>  		 */
> +		if (fn->declaration)
> +			continue;
> +		if (!has_arg_names(cu, &fn->proto))
> +			continue;
>  		if (functions_cnt) {
> -			/*
> -			 * We check following conditions:
> -			 *   - argument names are defined
> -			 *   - there's symbol and address defined for the function
> -			 *   - function address belongs to ftrace locations
> -			 *   - function is generated only once
> -			 */
> -			if (!has_arg_names(cu, &fn->proto))
> -				continue;
>  			if (!should_generate_function(btfe, function__name(fn, cu)))
>  				continue;
>  		} else {
> -			if (fn->declaration || !fn->external)
> +			if (!fn->external)
>  				continue;
>  		}
>  
> -- 
> 2.26.2
> 

-- 

- Arnaldo
