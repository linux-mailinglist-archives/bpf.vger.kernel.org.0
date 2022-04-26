Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC4B50EF9F
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 06:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbiDZEO6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 00:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbiDZEO5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 00:14:57 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4AB17E0D;
        Mon, 25 Apr 2022 21:11:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so1410415pjf.0;
        Mon, 25 Apr 2022 21:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OWU8+twW9giLtmk/iNr6dFXjwBEnrNERsI1cDtyJELo=;
        b=Pb0oKk+f0UKZsOhdIYj46gfTuzMy/j62lRgTH5APFo6G4hNDveMIzNLZEDNBrjgw8F
         B9PcEgueZ+19RK3ihQ7pUkUpTwvv5l6WQ0nBgzyATC4Cvpgi1tmD2qr4Un4LTm9nd5Tb
         s8JuPGhBRe4CGJ2W25I3ygjozjWXHCAI3knPwMf8Rd/WQVSuZtYLPr1fZMscloCTSwz9
         9wS26K5CTtROqmiMOyqi1g4VM98l1Dcm7BCv7su6FWd4daoPNcSrlh/PhNUZgWdba2sb
         ayQp28wb6H68ZE/CqZ2oNslfOIl2YiW9Ggx9v8VUoUdSNDeg6w3E39nNMv/Jw4+M32vq
         awYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OWU8+twW9giLtmk/iNr6dFXjwBEnrNERsI1cDtyJELo=;
        b=gPYb3qygOSnffzM9Mo/QLD5Zc1fIyhZi9/01AO4YRlhG40lzjAXjIg69cheDZXKOu8
         Qg8dUkxhWvH+LMtO45lK29prZTVQuQAqVlS07AHCLt4s1KU0kVgOHVETEakH0eln2Q3K
         bu8q1tnXtoBQRl1hqbsGXmJ2GtXMmoutbwZKIYYUWNcsOT4O1SQexyBCcsGB9pr38BTP
         kBbAiavFBxvMfwSe77QA4RMGWtieHqw+6e0in70A4Yh+W9UJE92STdyq8rLcR5DB85Ew
         0Yp7ggn48uKEeMj2/80jyruxfAwd+FF1FAl0fBZmJmxS7+FavPW4WoqMozGPM9PvVqLB
         F0bQ==
X-Gm-Message-State: AOAM533hBYq1APPGfodApDgcIRJbYiX5kq28+WZ9DDRgOdQd/572tCgz
        MGVrn48W6HXQY9D/w+otzsc=
X-Google-Smtp-Source: ABdhPJwO4XEQSwlpF2K+qcWKLQEIuOQgGeS0iZE1F9fQMv7DaI3Nih8dmbnu7D+9NuKLa8lGdjJDQg==
X-Received: by 2002:a17:90b:4c85:b0:1d4:bc0b:90eb with SMTP id my5-20020a17090b4c8500b001d4bc0b90ebmr24607284pjb.171.1650946311004;
        Mon, 25 Apr 2022 21:11:51 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::5:438a])
        by smtp.gmail.com with ESMTPSA id p27-20020a056a000a1b00b004f3f63e3cf2sm14932823pfh.58.2022.04.25.21.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 21:11:50 -0700 (PDT)
Date:   Mon, 25 Apr 2022 21:11:47 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [RFC bpf-next v4 3/7] error-inject: add new type that carries if
 the function is non sleepable
Message-ID: <20220426041147.gwnxhcjftl2kaz6g@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
 <20220421140740.459558-4-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421140740.459558-4-benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 04:07:36PM +0200, Benjamin Tissoires wrote:
> When using error-injection function through bpf to change the return
> code, we need to know if the function is sleepable or not.
> 
> Currently the code assumes that all error-inject functions are sleepable,
> except for a few selected of them, hardcoded in kernel/bpf/verifier.c
> 
> Add a new flag to error-inject so we can code that information where the
> function is declared.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> ---
> 
> new in v4:
> - another approach would be to define a new kfunc_set, and register
>   it with btf. But in that case, what program type would we use?
>   BPF_PROG_TYPE_UNSPEC?
> - also note that maybe we should consider all of the functions
>   non-sleepable and only mark some as sleepable. IMO it makes more
>   sense to be more restrictive by default.

I think the approach in this patch is fine.
We didn't have issues with check_non_sleepable_error_inject() so far,
so I wouldn't start refactoring it.

> ---
>  include/asm-generic/error-injection.h |  1 +
>  kernel/bpf/verifier.c                 | 10 ++++++++--
>  lib/error-inject.c                    |  2 ++
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
> index fbca56bd9cbc..5974942353a6 100644
> --- a/include/asm-generic/error-injection.h
> +++ b/include/asm-generic/error-injection.h
> @@ -9,6 +9,7 @@ enum {
>  	EI_ETYPE_ERRNO,		/* Return -ERRNO if failure */
>  	EI_ETYPE_ERRNO_NULL,	/* Return -ERRNO or NULL if failure */
>  	EI_ETYPE_TRUE,		/* Return true if failure */
> +	EI_ETYPE_NS_ERRNO,	/* Return -ERRNO if failure and tag the function as non-sleepable */

>  };
>  
>  struct error_injection_entry {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0f339f9058f3..45c8feea6478 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14085,6 +14085,11 @@ static int check_non_sleepable_error_inject(u32 btf_id)
>  	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
>  }
>  
> +static int is_non_sleepable_error_inject(unsigned long addr)
> +{
> +	return get_injectable_error_type(addr) == EI_ETYPE_NS_ERRNO;

It's a linear search. Probably ok. But would be good to double check
that we're not calling it a lot.

> +}
> +
>  int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			    const struct bpf_prog *prog,
>  			    const struct bpf_prog *tgt_prog,
> @@ -14281,8 +14286,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  				/* fentry/fexit/fmod_ret progs can be sleepable only if they are
>  				 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
>  				 */
> -				if (!check_non_sleepable_error_inject(btf_id) &&
> -				    within_error_injection_list(addr))
> +				if (within_error_injection_list(addr) &&
> +				    !check_non_sleepable_error_inject(btf_id) &&
> +				    !is_non_sleepable_error_inject(addr))
>  					ret = 0;
>  				break;
>  			case BPF_PROG_TYPE_LSM:
> diff --git a/lib/error-inject.c b/lib/error-inject.c
> index 2ff5ef689d72..560c3b18f439 100644
> --- a/lib/error-inject.c
> +++ b/lib/error-inject.c
> @@ -183,6 +183,8 @@ static const char *error_type_string(int etype)
>  		return "ERRNO_NULL";
>  	case EI_ETYPE_TRUE:
>  		return "TRUE";
> +	case EI_ETYPE_NS_ERRNO:
> +		return "NS_ERRNO";
>  	default:
>  		return "(unknown)";
>  	}
> -- 
> 2.35.1
> 
