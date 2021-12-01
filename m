Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C60465961
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 23:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343812AbhLAWkL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 17:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343802AbhLAWkL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 17:40:11 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8AAC061574
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 14:36:49 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r11so108050518edd.9
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 14:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vV81ObG46eXsbwH3dmG9sSANE1uIHZsRCQ1ntNzmzKw=;
        b=ah+wSoZ85EkXYc/X6957Qime58H/+krsVNrM3896TluUXsWZ4azXI/mHuQeLgBYv2n
         6RhEbbucqP2qPcPSfhkmbdjp2T0a0pO7L7ZpnB1W7wR6wD02BQ4HAaLg+WR1eftTdFhf
         8bOpLRsMPRPPInZLd9ONOf3p1I+zlcJsY8FdNENc3NnZ6D9o6b7InkaLqu+xhCN6puYT
         UWv0euhYYma+KWRU5d1E3MgO8AObewIq7bMkopq6QO+dQ7cwbfCpu1T7KJ9tV+aZvvkq
         x6rNQ3E2UDdMsh3jhczDzg5aN9bGqPOFRLRbJ9JVM3IAHT+n6EkyrJv0NzkHSvi8pF0d
         ta8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vV81ObG46eXsbwH3dmG9sSANE1uIHZsRCQ1ntNzmzKw=;
        b=CGqrx5m5h+78j6XSSplWCUxVjSBKxe3J90wEgpplY/qdcPKECkfVP1uRbb/HAUon6m
         iyvtOHDAfUXh7C4Lwq+XD7aAS5KK4wy8yWvMWhU6P7+Da2SKT4XSdS41aBYbMSVH0q/r
         Ik/XPpTvY2jp3xZoXmn4uCXpqnLV9vHV8F+lNE75CpLtqDftDRJu2yThU9iCdmI67Dg6
         xZ57ODKBL0z3sYzfe41ok4ZRjHd7NZ6hoilXYzDc+TYhcZM8Mr/IYOD0tTfkjHCMUmpc
         NfpQszBhrz1hcATZ/A0PZaypX8+HRmYrVRPcJgvKGCyEPG+6NU1+rsJQQHPSAvMXfYsJ
         g4LQ==
X-Gm-Message-State: AOAM532NOyV63gh2VUk6sHLIiJyyEu+y3GMQzYV/2IWKoUVlotPsKo18
        PdtTN0rXfxJ+b69fQAceagz0G51vdjtWnWMt3B1qZQ==
X-Google-Smtp-Source: ABdhPJwwcCFKY3Vmzt88Ociw8AUbN9vbH0l941fzIL1ZusLs8VAurZWgIAilXCvq6c8yrs71cz19a+nG7YHP2birnAc=
X-Received: by 2002:a50:e0c9:: with SMTP id j9mr12459143edl.336.1638398207878;
 Wed, 01 Dec 2021 14:36:47 -0800 (PST)
MIME-Version: 1.0
References: <20211130012948.380602-1-haoluo@google.com> <20211130012948.380602-2-haoluo@google.com>
 <20211201202947.vag7mftglwnxtiy6@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211201202947.vag7mftglwnxtiy6@ast-mbp.dhcp.thefacebook.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 1 Dec 2021 14:36:36 -0800
Message-ID: <CA+khW7hfpUV4B=tmPbwx5EY0pvGq-29Y2HWi9TnrPjBYvg8egQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 1/9] bpf: Introduce composable reg, ret
 and arg types.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 1, 2021 at 12:29 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 29, 2021 at 05:29:40PM -0800, Hao Luo wrote:
> > There are some common properties shared between bpf reg, ret and arg
> > values. For instance, a value may be a NULL pointer, or a pointer to
> > a read-only memory. Previously, to express these properties, enumeration
> > was used. For example, in order to test whether a reg value can be NULL,
> > reg_type_may_be_null() simply enumerates all types that are possibly
> > NULL. The problem of this approach is that it's not scalable and causes
> > a lot of duplication. These properties can be combined, for example, a
> > type could be either MAYBE_NULL or RDONLY, or both.
> >
> > This patch series rewrites the layout of reg_type, arg_type and
> > ret_type, so that common properties can be extracted and represented as
> > composable flag. For example, one can write
> >
> >  ARG_PTR_TO_MEM | PTR_MAYBE_NULL
> >
> > which is equivalent to the previous
> >
> >  ARG_PTR_TO_MEM_OR_NULL
> >
> > The type ARG_PTR_TO_MEM are called "base types" in this patch. Base
> > types can be extended with flags. A flag occupies the higher bits while
> > base types sits in the lower bits.
> >
> > This patch in particular sets up a set of macro for this purpose. The
> > followed patches rewrites arg_types, ret_types and reg_types
> > respectively.
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
> >  include/linux/bpf.h | 50 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index cc7a0c36e7df..b592b3f7d223 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -297,6 +297,37 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
> >
> >  extern const struct bpf_map_ops bpf_map_offload_ops;
> >
> > +/* bpf_type_flag contains a set of flags that are applicable to the values of
> > + * arg_type, ret_type and reg_type. For example, a pointer value may be null,
> > + * or a memory is read-only. We classify types into two categories: base types
> > + * and extended types. Extended types are base types combined with a type flag.
> > + *
> > + * Currently there are no more than 32 base types in arg_type, ret_type and
> > + * reg_types.
> > + */
> > +#define BPF_BASE_TYPE_BITS   8
> > +
> > +enum bpf_type_flag {
> > +     /* PTR may be NULL. */
> > +     PTR_MAYBE_NULL          = BIT(0 + BPF_BASE_TYPE_BITS),
> > +
> > +     __BPF_TYPE_LAST_FLAG    = PTR_MAYBE_NULL,
> > +};
> > +
> > +#define BPF_BASE_TYPE_MASK   GENMASK(BPF_BASE_TYPE_BITS, 0)
> > +
> > +/* Max number of base types. */
> > +#define BPF_BASE_TYPE_LIMIT  (1UL << BPF_BASE_TYPE_BITS)
> > +
> > +/* Max number of all types. */
> > +#define BPF_TYPE_LIMIT               (__BPF_TYPE_LAST_FLAG | (__BPF_TYPE_LAST_FLAG - 1))
> > +
> > +/* extract base type. */
> > +#define BPF_BASE_TYPE(x)     ((x) & BPF_BASE_TYPE_MASK)
> > +
> > +/* extract flags from an extended type. */
> > +#define BPF_TYPE_FLAG(x)     ((enum bpf_type_flag)((x) & ~BPF_BASE_TYPE_MASK))
>
> Overall I think it's really great.
> The only suggestion is to use:
> static inline u32 base_type(u32 x)
> {
>   return x & BPF_BASE_TYPE_MASK;
> }
> and
> static inline u32 type_flag(u32 x) ..
>
> The capital letter macros are too loud.
>
> wdyt?
>

Sounds good to me. Will do in the next iteration.
