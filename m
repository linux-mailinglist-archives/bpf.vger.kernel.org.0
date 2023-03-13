Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED65F6B775A
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 13:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCMMUp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 08:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCMMUi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 08:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353CB42BC6
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 05:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C52A46123A
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 12:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F36FC433D2;
        Mon, 13 Mar 2023 12:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678710036;
        bh=yXSFxTL1PpdCyfa50O1SbMj6H7vfC2TYQE9pYPUcmZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ns+FBn2BMi9VINPVbBZq9XfWUduTWBo8IyMtc9+GMYtdj4IaeMQ6CaEaiD8wGbkIN
         V8GH3u8hbDkTq/42VTSPOUW3r9ISSsi3J0hezTBriZzo8IlcdkxeNgbZ9CMyFhLnu+
         IIm45Z859clCgb1/DJ2LKbmKu+9pZZYSNHv0mNnsAA6IsaPUXV6qJBaWfrrY5vyN/R
         mOWxWQQIGl6fiCR2y0/lCxy3qxhcF+LYfEmCJPvs68L0MLZN1dyLbgtPyVaIypLtoT
         xQkfZ2JU0xobvNl+C2EKA03Tj97r68NRyClmf2yqj4HBZyBteNDJFHq7dWi/rtGP/L
         JVWzGxe4tv7dw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6B3E04049F; Mon, 13 Mar 2023 09:20:33 -0300 (-03)
Date:   Mon, 13 Mar 2023 09:20:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 2/3] dwarves_fprintf: support skipping modifier
Message-ID: <ZA8VEfKWuQYH/Jnx@kernel.org>
References: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
 <1678459850-16140-3-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1678459850-16140-3-git-send-email-alan.maguire@oracle.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Mar 10, 2023 at 02:50:49PM +0000, Alan Maguire escreveu:
> When doing BTF comparisons between functions defined in multiple
> CUs, it was noticed a few critical functions failed prototype
> comparisons due to multiple "const" modifiers; for example:
> 
> function mismatch for 'memchr_inv'('memchr_inv'): 'void * ()(const const void  * , int, size_t)' != 'void * ()(const void  *, int, size_t)'
> 
> function mismatch for 'strnlen'('strnlen'): '__kernel_size_t ()(const const char  * , __kernel_size_t)' != '__kernel_size_t ()(const char  *, size_t)'
> 
> (note the "const const" in the first parameter.)
> 
> As such it would be useful to omit modifiers for comparison
> purposes.  Also noted was the fact that for the "no_parm_names"
> case, an extra space was being emitted in some cases, also
> throwing off string comparisons of prototypes.

Running 'btfdiff vmlinux' after this change ends up in a segfault:

⬢[acme@toolbox pahole]$ btfdiff vmlinux
/var/home/acme/bin/btfdiff: line 34:  8183 Segmentation fault      (core dumped) ${pahole_bin} -F dwarf --flat_arrays --sort --jobs --suppress_aligned_attribute --suppress_force_paddings --suppress_packed --lang_exclude rust --show_private_classes $dwarf_input > $dwarf_output
/var/home/acme/bin/btfdiff: line 39:  8237 Segmentation fault      (core dumped) ${pahole_bin} -F btf --sort --suppress_aligned_attribute --suppress_packed $btf_input > $btf_output
⬢[acme@toolbox pahole]$

Investigating.

- Arnaldo
 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  dwarves.h         |  1 +
>  dwarves_fprintf.c | 26 ++++++++++++++++----------
>  2 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/dwarves.h b/dwarves.h
> index d04a36d..7a319d1 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -134,6 +134,7 @@ struct conf_fprintf {
>  	uint8_t	   strip_inline:1;
>  	uint8_t	   skip_emitting_atomic_typedefs:1;
>  	uint8_t	   skip_emitting_errors:1;
> +	uint8_t    skip_emitting_modifier:1;
>  };
>  
>  struct cus;
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index 5c6bf9c..b20a473 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -506,7 +506,8 @@ static const char *tag__ptr_name(const struct tag *tag, const struct cu *cu,
>  				struct tag *next_type = cu__type(cu, type->type);
>  
>  				if (next_type && tag__is_pointer(next_type)) {
> -					const_pointer = "const ";
> +					if (!conf->skip_emitting_modifier)
> +						const_pointer = "const ";
>  					type = next_type;
>  				}
>  			}
> @@ -580,13 +581,16 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
>  				   *type_str = __tag__name(type, cu, tmpbf,
>  							   sizeof(tmpbf),
>  							   pconf);
> -			switch (tag->tag) {
> -			case DW_TAG_volatile_type: prefix = "volatile "; break;
> -			case DW_TAG_const_type:    prefix = "const ";	 break;
> -			case DW_TAG_restrict_type: suffix = " restrict"; break;
> -			case DW_TAG_atomic_type:   prefix = "_Atomic ";  break;
> +			if (!conf->skip_emitting_modifier) {
> +				switch (tag->tag) {
> +				case DW_TAG_volatile_type: prefix = "volatile "; break;
> +				case DW_TAG_const_type: prefix = "const"; break;
> +				case DW_TAG_restrict_type: suffix = " restrict"; break;
> +				case DW_TAG_atomic_type:   prefix = "_Atomic ";  break;
> +				}
>  			}
> -			snprintf(bf, len, "%s%s%s ", prefix, type_str, suffix);
> +			snprintf(bf, len, "%s%s%s%s", prefix, type_str, suffix,
> +				 conf->no_parm_names ? "" : " ");
>  		}
>  		break;
>  	case DW_TAG_array_type:
> @@ -818,9 +822,11 @@ print_default:
>  	case DW_TAG_const_type:
>  		modifier = "const";
>  print_modifier: {
> -		size_t modifier_printed = fprintf(fp, "%s ", modifier);
> -		tconf.type_spacing -= modifier_printed;
> -		printed		   += modifier_printed;
> +		if (!conf->skip_emitting_modifier) {
> +			size_t modifier_printed = fprintf(fp, "%s ", modifier);
> +			tconf.type_spacing -= modifier_printed;
> +			printed		   += modifier_printed;
> +		}
>  
>  		struct tag *ttype = cu__type(cu, type->type);
>  		if (ttype) {
> -- 
> 1.8.3.1
> 

-- 

- Arnaldo
