Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155EA465729
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 21:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352924AbhLAUdi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 15:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352930AbhLAUdM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 15:33:12 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5C6C061574
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 12:29:51 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u11so18615021plf.3
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 12:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t/DEv4XllS6zdIybgIH8L1CZOWO65z15DgGyakCIrp8=;
        b=Iw6zyYvtLn7KsP590xvXbCUO3WK0rr88ZTDgoN+lAADEa2p7nh+Nt+6ZXJThjiKLwh
         hLlXzHU/cgcIgblh+wwNYBKPzgQwNyIPXR5iPQ50ASYDseaTHJ9df3gZ2EXWek0E8MZ9
         kW1c/TjZOrGivczTZqEn8h/FZl37KnWoxEHjOxbbvNaGh0/AI4kbz82BreKNcA39I4vM
         o7wo6mqetK5TlMKAN+sgH0w4AY4o4oULGGYXjwKCj9PDL5xQE+xhm7a1Yt4D681VrKqS
         1Bc+1fW88wYNePnYuXcXlRxrhRoBmg5jFkgkxshAh5hRXkl7C95QizS6VI7csQmJqTmQ
         JR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t/DEv4XllS6zdIybgIH8L1CZOWO65z15DgGyakCIrp8=;
        b=Y9zLcUrlw3n4xlSmOy2qQLdtZnR0e1pqFK+/ThyaD8jeow++vNKLwmFJ4ykkaRaDvv
         4T6TwOimidTFwgl1zEfilPn+6tTHj2RzVMGriAsXjDShTBSSsydNKgdU3st+R+3geww2
         Xdi1kHM8eKz6edFwJCMhBtp1LNMInVF4KgTCnr7Nn/5KUJVK+YIC3Rv/RCNn1lqZLHI8
         99Ioi9hc/i/ae+b3HsWeSY5I5rYqQyE7OhJONUPhNo/v6NTDMYY8Ka//vvxBb3+SOEzO
         b9Pe2/oPmAxlaQKTV0V9OqZc/Tt4wQR2speZQO795dzUKJoUBfSn9Us10CL9K2+uPNJr
         4IZA==
X-Gm-Message-State: AOAM5318udM0ECBHVqpnHVaE7Y+JIc6qKxqIFrwOLSI9yVyHGqfLqMaB
        mcJDr2//0JASspzxRa91YEU=
X-Google-Smtp-Source: ABdhPJz8r8Ol4z3oS4guR9H4ubKHvayiDyUl0ARAMrXD14GS+W+b5+ge6OsROxvNDAcv3cQ1oKsjVQ==
X-Received: by 2002:a17:902:d4d0:b0:141:c13d:6c20 with SMTP id o16-20020a170902d4d000b00141c13d6c20mr10584764plg.44.1638390590638;
        Wed, 01 Dec 2021 12:29:50 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:620c])
        by smtp.gmail.com with ESMTPSA id e10sm702094pfv.140.2021.12.01.12.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:29:49 -0800 (PST)
Date:   Wed, 1 Dec 2021 12:29:47 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 1/9] bpf: Introduce composable reg, ret
 and arg types.
Message-ID: <20211201202947.vag7mftglwnxtiy6@ast-mbp.dhcp.thefacebook.com>
References: <20211130012948.380602-1-haoluo@google.com>
 <20211130012948.380602-2-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130012948.380602-2-haoluo@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 29, 2021 at 05:29:40PM -0800, Hao Luo wrote:
> There are some common properties shared between bpf reg, ret and arg
> values. For instance, a value may be a NULL pointer, or a pointer to
> a read-only memory. Previously, to express these properties, enumeration
> was used. For example, in order to test whether a reg value can be NULL,
> reg_type_may_be_null() simply enumerates all types that are possibly
> NULL. The problem of this approach is that it's not scalable and causes
> a lot of duplication. These properties can be combined, for example, a
> type could be either MAYBE_NULL or RDONLY, or both.
> 
> This patch series rewrites the layout of reg_type, arg_type and
> ret_type, so that common properties can be extracted and represented as
> composable flag. For example, one can write
> 
>  ARG_PTR_TO_MEM | PTR_MAYBE_NULL
> 
> which is equivalent to the previous
> 
>  ARG_PTR_TO_MEM_OR_NULL
> 
> The type ARG_PTR_TO_MEM are called "base types" in this patch. Base
> types can be extended with flags. A flag occupies the higher bits while
> base types sits in the lower bits.
> 
> This patch in particular sets up a set of macro for this purpose. The
> followed patches rewrites arg_types, ret_types and reg_types
> respectively.
> 
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>  include/linux/bpf.h | 50 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cc7a0c36e7df..b592b3f7d223 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -297,6 +297,37 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
>  
>  extern const struct bpf_map_ops bpf_map_offload_ops;
>  
> +/* bpf_type_flag contains a set of flags that are applicable to the values of
> + * arg_type, ret_type and reg_type. For example, a pointer value may be null,
> + * or a memory is read-only. We classify types into two categories: base types
> + * and extended types. Extended types are base types combined with a type flag.
> + *
> + * Currently there are no more than 32 base types in arg_type, ret_type and
> + * reg_types.
> + */
> +#define BPF_BASE_TYPE_BITS	8
> +
> +enum bpf_type_flag {
> +	/* PTR may be NULL. */
> +	PTR_MAYBE_NULL		= BIT(0 + BPF_BASE_TYPE_BITS),
> +
> +	__BPF_TYPE_LAST_FLAG	= PTR_MAYBE_NULL,
> +};
> +
> +#define BPF_BASE_TYPE_MASK	GENMASK(BPF_BASE_TYPE_BITS, 0)
> +
> +/* Max number of base types. */
> +#define BPF_BASE_TYPE_LIMIT	(1UL << BPF_BASE_TYPE_BITS)
> +
> +/* Max number of all types. */
> +#define BPF_TYPE_LIMIT		(__BPF_TYPE_LAST_FLAG | (__BPF_TYPE_LAST_FLAG - 1))
> +
> +/* extract base type. */
> +#define BPF_BASE_TYPE(x)	((x) & BPF_BASE_TYPE_MASK)
> +
> +/* extract flags from an extended type. */
> +#define BPF_TYPE_FLAG(x)	((enum bpf_type_flag)((x) & ~BPF_BASE_TYPE_MASK))

Overall I think it's really great.
The only suggestion is to use:
static inline u32 base_type(u32 x)
{
  return x & BPF_BASE_TYPE_MASK;
}
and
static inline u32 type_flag(u32 x) ..

The capital letter macros are too loud.

wdyt?

