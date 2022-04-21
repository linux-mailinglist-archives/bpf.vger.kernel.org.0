Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9748450A95B
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 21:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392035AbiDUTlF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 15:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiDUTlF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 15:41:05 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125712AC3
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 12:38:15 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n18so5998010plg.5
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 12:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=abCmdeVnu/aMtbg26EMBQpj5+ppqwoiao4odFFei1H4=;
        b=C69VetDe0Smv6djsZtdcm0NbXlrxd1oxFYhahIo651DDJ5/YBjNwxkx/+mxOe2HQ71
         5TMB0FXZZrZm0PApGkEUJ8Q6HKI9kx1cD0ucD4lPvnIrz3XLmTVxWYjSQpH8nZHjOLmj
         lc1G61zdb/58wW0i7KgYW7HAWHNCGs9Cd+YAlLsGG+TtsH7MfgKLTs3s1X4hBgt7qAHE
         u2Bk4uzm4oFZ7iA99lAwMv5tcusWrEES/Ls29hryhJ+OhiMiwYiWEOTxvLbkzjf67Gsb
         upw9zEknWGPDMjHC/bd5V++6VQB461fXZ8+risbou1pDPappxjbtylFZQN19gajeP5uE
         F5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=abCmdeVnu/aMtbg26EMBQpj5+ppqwoiao4odFFei1H4=;
        b=hmx/rSpikecO9brwCy+TjItZ5+sHubsVWCer4G6tpsTSeYb2cGD6NEYQvyrhaAnk3r
         +CgyB4lZZBjGDYvQ98UpJr2gRF1AZfb/N6p0WTZWAY02Rui4qNTFjsTSbRiql+IiiBtM
         f2j+OAfc/q8wn/RuRz+SGyqX+51nOqoxvsPI/fWLVdB0BYCBf/fXvy7Kleem1jKpn6cq
         IhC/bbP4VwHfjphOCgCxb0MOFsu2WAoa1fqh/pD1SvcsJADgUi4C3OHcUM1A/0VYvd7c
         EQT07uO56GvC3AvLmamW9e443qtfQ3X55galu3B0iWXhMbx3oetawolWKILRjjcOwFxs
         YVWQ==
X-Gm-Message-State: AOAM531ZdB/EWl0e3H4CKdboD5v1aJY/w5ob7slUWWZBUQxJD2CSqsUh
        qIOINu4K9cDUQ9rr5f11u+c=
X-Google-Smtp-Source: ABdhPJxNfrpfFxwWLx5S508d0LspNHbp1gROWpxBn0oPZG0JCYPmKziFPDF2t3M0kSeefeGqTrsfcA==
X-Received: by 2002:a17:90b:3b4f:b0:1d2:7117:d758 with SMTP id ot15-20020a17090b3b4f00b001d27117d758mr12061648pjb.105.1650569894537;
        Thu, 21 Apr 2022 12:38:14 -0700 (PDT)
Received: from localhost ([157.49.241.21])
        by smtp.gmail.com with ESMTPSA id iy2-20020a17090b16c200b001d75aabe050sm1279617pjb.34.2022.04.21.12.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:38:14 -0700 (PDT)
Date:   Fri, 22 Apr 2022 01:08:27 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v5 05/13] bpf: Allow storing referenced kptr in
 map
Message-ID: <20220421193827.6fyxzpihy62dtloz@apollo.legion>
References: <20220415160354.1050687-1-memxor@gmail.com>
 <20220415160354.1050687-6-memxor@gmail.com>
 <20220421042147.n2xocxpmilywa7qs@MBP-98dd607d3435.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421042147.n2xocxpmilywa7qs@MBP-98dd607d3435.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 09:51:47AM IST, Alexei Starovoitov wrote:
> On Fri, Apr 15, 2022 at 09:33:46PM +0530, Kumar Kartikeya Dwivedi wrote:
> > Extending the code in previous commits, introduce referenced kptr
> > support, which needs to be tagged using 'kptr_ref' tag instead. Unlike
> > unreferenced kptr, referenced kptr have a lot more restrictions. In
> > addition to the type matching, only a newly introduced bpf_kptr_xchg
> > helper is allowed to modify the map value at that offset. This transfers
> > the referenced pointer being stored into the map, releasing the
> > references state for the program, and returning the old value and
> > creating new reference state for the returned pointer.
> >
> > Similar to unreferenced pointer case, return value for this case will
> > also be PTR_TO_BTF_ID_OR_NULL. The reference for the returned pointer
> > must either be eventually released by calling the corresponding release
> > function, otherwise it must be transferred into another map.
> >
> > It is also allowed to call bpf_kptr_xchg with a NULL pointer, to clear
> > the value, and obtain the old value if any.
> >
> > BPF_LDX, BPF_STX, and BPF_ST cannot access referenced kptr. A future
> > commit will permit using BPF_LDX for such pointers, but attempt at
> > making it safe, since the lifetime of object won't be guaranteed.
> >
> > There are valid reasons to enforce the restriction of permitting only
> > bpf_kptr_xchg to operate on referenced kptr. The pointer value must be
> > consistent in face of concurrent modification, and any prior values
> > contained in the map must also be released before a new one is moved
> > into the map. To ensure proper transfer of this ownership, bpf_kptr_xchg
> > returns the old value, which the verifier would require the user to
> > either free or move into another map, and releases the reference held
> > for the pointer being moved in.
> >
> > In the future, direct BPF_XCHG instruction may also be permitted to work
> > like bpf_kptr_xchg helper.
> >
> > Note that process_kptr_func doesn't have to call
> > check_helper_mem_access, since we already disallow rdonly/wronly flags
> > for map, which is what check_map_access_type checks, and we already
> > ensure the PTR_TO_MAP_VALUE refers to kptr by obtaining its off_desc,
> > so check_map_access is also not required.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h            |  8 +++
> >  include/uapi/linux/bpf.h       | 12 +++++
> >  kernel/bpf/btf.c               | 10 +++-
> >  kernel/bpf/helpers.c           | 21 ++++++++
> >  kernel/bpf/verifier.c          | 98 +++++++++++++++++++++++++++++-----
> >  tools/include/uapi/linux/bpf.h | 12 +++++
> >  6 files changed, 148 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index f73a3f10e654..61f83a23980f 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -160,8 +160,14 @@ enum {
> >  	BPF_MAP_VALUE_OFF_MAX = 8,
> >  };
> >
> > +enum bpf_map_off_desc_type {
> > +	BPF_MAP_OFF_DESC_TYPE_UNREF_KPTR,
> > +	BPF_MAP_OFF_DESC_TYPE_REF_KPTR,
>
> Those are verbose names and MAP_OFF_DESC part doesn't add value.
> Maybe:
> enum bpf_kptr_type {
>  BPF_KPTR_UNREF,
>  BPF_KPTR_REF
> };

Ok, will rename.

--
Kartikeya
