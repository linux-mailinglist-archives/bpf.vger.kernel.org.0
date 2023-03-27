Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459256CA2B9
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 13:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjC0LqT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 07:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC0LqT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 07:46:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4DE2121;
        Mon, 27 Mar 2023 04:46:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6750B80DA3;
        Mon, 27 Mar 2023 11:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EE2C433EF;
        Mon, 27 Mar 2023 11:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679917575;
        bh=hhPTBV1xJsp2Kod07mem9sk9Nv7rU61oTkcnuZxLfk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DyvTzQkzfamtuHO3PP5ydYqYCqejj/3k0uvJyWnkfi+n52np12KgQ7Zjwkgw/TiWk
         cYRF1QWrFDQshpFXjVh5q7ngLzCnHESCAEvuVzy1tR0k+NkdOXblevyOXjM6VRzS2u
         2hNND55f1rmvyhgQdMrc805XlCSMvy/tH0oEGK6KqP88Si9Y/1XRdDX6UoLSbTUBMo
         e/pXIwd/RqVV3aWyTVVFQWhdogozExedQL8HWkc7axBR5Ldh/za925KURSiX4tGK3J
         NpU7DdmU6epm2UKnWDD3fr47WLNZmXWqQL+5vhmn1GqxVP/pRHxCcdlFHZPyvzJTUW
         GX7/7SzcAhgzQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BC0364052D; Mon, 27 Mar 2023 08:46:12 -0300 (-03)
Date:   Mon, 27 Mar 2023 08:46:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com
Subject: Re: [PATCH dwarves v2 1/5] fprintf: Correct names for types with
 btf_type_tag attribute
Message-ID: <ZCGCBF5iYxCtBQKh@kernel.org>
References: <20230314230417.1507266-1-eddyz87@gmail.com>
 <20230314230417.1507266-2-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314230417.1507266-2-eddyz87@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Mar 15, 2023 at 01:04:13AM +0200, Eduard Zingerman escreveu:
> The following example contains a structure field annotated with
> btf_type_tag attribute:
> 
>     #define __tag1 __attribute__((btf_type_tag("tag1")))
> 
>     struct st {
>       int __tag1 *a;
>     } g;
> 
> It is not printed correctly by `pahole -F dwarf` command:
> 
>     $ clang -g -c test.c -o test.o
>     pahole -F dwarf test.o
>     struct st {
>     	tag1 *                     a;                    /*     0     8 */
>     	...
>     };
> 
> Note the type for variable `a`: `tag1` is printed instead of `int`.
> This commit teaches `type__fprintf()` and `__tag_name()` logic to skip
> `DW_TAG_LLVM_annotation` objects that are used to encode type tags.

I'm applying this now to make progress on this front, but longer term we
should printf it too, as we want the output to match the original source
code as much as possible from the type information.

- Arnaldo
 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  dwarves_fprintf.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index e8399e7..1e6147a 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -572,6 +572,7 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
>  	case DW_TAG_restrict_type:
>  	case DW_TAG_atomic_type:
>  	case DW_TAG_unspecified_type:
> +	case DW_TAG_LLVM_annotation:
>  		type = cu__type(cu, tag->type);
>  		if (type == NULL && tag->type != 0)
>  			tag__id_not_found_snprintf(bf, len, tag->type);
> @@ -786,6 +787,10 @@ next_type:
>  			n = tag__has_type_loop(type, ptype, NULL, 0, fp);
>  			if (n)
>  				return printed + n;
> +			if (ptype->tag == DW_TAG_LLVM_annotation) {
> +				type = ptype;
> +				goto next_type;
> +			}
>  			if (ptype->tag == DW_TAG_subroutine_type) {
>  				printed += ftype__fprintf(tag__ftype(ptype),
>  							  cu, name, 0, 1,
> @@ -880,6 +885,14 @@ print_modifier: {
>  		else
>  			printed += enumeration__fprintf(type, &tconf, fp);
>  		break;
> +	case DW_TAG_LLVM_annotation: {
> +		struct tag *ttype = cu__type(cu, type->type);
> +		if (ttype) {
> +			type = ttype;
> +			goto next_type;
> +		}
> +		goto out_type_not_found;
> +	}
>  	}
>  out:
>  	if (type_expanded)
> -- 
> 2.39.1
> 

-- 

- Arnaldo
