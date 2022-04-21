Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AA15095C5
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 06:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384082AbiDUEYj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 00:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376782AbiDUEYi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 00:24:38 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0CD11A2C
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 21:21:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id a15so3844339pfv.11
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 21:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZvHu1MPWeBEDe/969Ge2drExLnOUWDXQWuI7ylYZR9k=;
        b=MHJIOVG0vLeDkruhL3abBlnzHC0PIK32GEvgXqGpK7ir109RTeycCQVGnphJQfFnfI
         URuP31mk1BRlfwF3JIUOk6fMcHfPDoNNUv9XETYlN6UbrRxnkgHFL/8kjNiAF3ZZLkLV
         OYt+hJdU0Z0rA4GdqZnPNTwf7/nQvfO3ouf/sFKfCklUfF3dr6R+YtjjJQsWTry2/0MM
         Bovt2KU/NuWyQox7Ub67I9ztaYB4RGJbJhgGx0QzdFUqO/50UQ9Eo/tO3LJNmlcpCYJp
         tM/AQgoHb1p2vwx+nl7ZSMg8h+qxfaSbbNAS1qZg6BpGPoDlWMnEbLvgEXe26k/GS6Zb
         BVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZvHu1MPWeBEDe/969Ge2drExLnOUWDXQWuI7ylYZR9k=;
        b=4xrKYg2hZjkC/OXWAWfaDRSfRolqgaQWUVcKqczLrz2lk6K9Dhaw4VbZv3jE4aW2No
         lbKh2CGXFcdwkv6498Hgz5GYXwh8PFBWw5dusyL9hlmGpNWKE+d6+Ecmt1cP30Q/CLpO
         Jn0ThS8wRch+WKWCeluRcFZoD3S0oOTOdMDYLHxsGvRr6LVVdojQaMnKpM+m9LQr/4WH
         yGpFonS0xl8OM3gWpd5C3FkKvp/CAcsE6YvSFYb6Z9zS5IcHPglAU9MGOXw4kqjPQBBz
         WDRGcbzCey+R3BlV4teQxvdRlhTLHtUDzYxl847HsPqFkt4PPWNLP0M2kxqhAQg6jnEY
         z8Gw==
X-Gm-Message-State: AOAM532kxOg0t7Las2laPQnxJpM5otEiCH5ZW+hFx+//F8lqcy1RiAWm
        4G93+cvzDa+X4Hn+4+y/ZMg=
X-Google-Smtp-Source: ABdhPJxoDhE7QTnclqsHlMnB/Wn1DODKpQd8DbHD3hUlIcxI/nWRQPr6bwF+JM3za5osR/SpiuTTlw==
X-Received: by 2002:a65:6a45:0:b0:3aa:69df:3b62 with SMTP id o5-20020a656a45000000b003aa69df3b62mr5196232pgu.394.1650514909866;
        Wed, 20 Apr 2022 21:21:49 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::5:4399])
        by smtp.gmail.com with ESMTPSA id 35-20020a631763000000b0039d93f8c2f0sm21293482pgx.24.2022.04.20.21.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 21:21:49 -0700 (PDT)
Date:   Wed, 20 Apr 2022 21:21:47 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v5 05/13] bpf: Allow storing referenced kptr in
 map
Message-ID: <20220421042147.n2xocxpmilywa7qs@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220415160354.1050687-1-memxor@gmail.com>
 <20220415160354.1050687-6-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415160354.1050687-6-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 15, 2022 at 09:33:46PM +0530, Kumar Kartikeya Dwivedi wrote:
> Extending the code in previous commits, introduce referenced kptr
> support, which needs to be tagged using 'kptr_ref' tag instead. Unlike
> unreferenced kptr, referenced kptr have a lot more restrictions. In
> addition to the type matching, only a newly introduced bpf_kptr_xchg
> helper is allowed to modify the map value at that offset. This transfers
> the referenced pointer being stored into the map, releasing the
> references state for the program, and returning the old value and
> creating new reference state for the returned pointer.
> 
> Similar to unreferenced pointer case, return value for this case will
> also be PTR_TO_BTF_ID_OR_NULL. The reference for the returned pointer
> must either be eventually released by calling the corresponding release
> function, otherwise it must be transferred into another map.
> 
> It is also allowed to call bpf_kptr_xchg with a NULL pointer, to clear
> the value, and obtain the old value if any.
> 
> BPF_LDX, BPF_STX, and BPF_ST cannot access referenced kptr. A future
> commit will permit using BPF_LDX for such pointers, but attempt at
> making it safe, since the lifetime of object won't be guaranteed.
> 
> There are valid reasons to enforce the restriction of permitting only
> bpf_kptr_xchg to operate on referenced kptr. The pointer value must be
> consistent in face of concurrent modification, and any prior values
> contained in the map must also be released before a new one is moved
> into the map. To ensure proper transfer of this ownership, bpf_kptr_xchg
> returns the old value, which the verifier would require the user to
> either free or move into another map, and releases the reference held
> for the pointer being moved in.
> 
> In the future, direct BPF_XCHG instruction may also be permitted to work
> like bpf_kptr_xchg helper.
> 
> Note that process_kptr_func doesn't have to call
> check_helper_mem_access, since we already disallow rdonly/wronly flags
> for map, which is what check_map_access_type checks, and we already
> ensure the PTR_TO_MAP_VALUE refers to kptr by obtaining its off_desc,
> so check_map_access is also not required.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h            |  8 +++
>  include/uapi/linux/bpf.h       | 12 +++++
>  kernel/bpf/btf.c               | 10 +++-
>  kernel/bpf/helpers.c           | 21 ++++++++
>  kernel/bpf/verifier.c          | 98 +++++++++++++++++++++++++++++-----
>  tools/include/uapi/linux/bpf.h | 12 +++++
>  6 files changed, 148 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f73a3f10e654..61f83a23980f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -160,8 +160,14 @@ enum {
>  	BPF_MAP_VALUE_OFF_MAX = 8,
>  };
>  
> +enum bpf_map_off_desc_type {
> +	BPF_MAP_OFF_DESC_TYPE_UNREF_KPTR,
> +	BPF_MAP_OFF_DESC_TYPE_REF_KPTR,

Those are verbose names and MAP_OFF_DESC part doesn't add value.
Maybe:
enum bpf_kptr_type {
 BPF_KPTR_UNREF,
 BPF_KPTR_REF
};
