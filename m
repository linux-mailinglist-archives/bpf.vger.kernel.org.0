Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A30494670
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 05:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiATE1e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 23:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbiATE1d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 23:27:33 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4590C061574
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 20:27:33 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id mi14-20020a17090b4b4e00b001b51b28c055so739549pjb.1
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 20:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JkpYam3hZ+jJoShN26K1t5MnrIP7COnCpSkY81PT030=;
        b=Zk9ldyeVlwhz7r27D60GFWdRllJfZeCoYAaw2CCAjrktNS6HCShyaagBr9wxMAoTRE
         pQfwcCaZZ2fUCm2y+tPylSF9B547aZ4Dsohykm51vuH5NhGq1HHx/HDJBjhl8je9715L
         FBd4xsQ4moFNuvIgn/cahf06An1ldh+x8ERRqavrLeStGYMWJbc6UAOA6vaEqCGASQqb
         JBHLbz0u5rdMk1xr1c60LEZuUI63HYKWyuZ7YG334DEn1liuv83N6N8C+0Uq6ME81k31
         AFIfp4xdpb87u5EPzlnVqWTE3GjALbu7Y5v2XuuQDFvRPX8252ihVJpmJ9O1dZjsFBHD
         IgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JkpYam3hZ+jJoShN26K1t5MnrIP7COnCpSkY81PT030=;
        b=OkiOw3hiXg+4Px+5U6XZw8q0isKgCqOseBVLQzTeELhSGzgqDRyOkuoPRj8gof8lVJ
         +RrUUXqhh5YQHoVG2TNudLtgDd5poMb6ENP2O5QZJ9WynTr/TfJyWuluBVeRU6AjgpOE
         UKUt3To45Xh5Nxo2K680omjh5ZYz6laieBCI4nqv6FEEB3TlEQNJ1M9tWPb+OITjUdR4
         L6aS1jXhoGFMf5xSA1LrKbkNxHwKSawRTC+R92UeTDXd0F8okXgZh6gQlZmAOj/D1HuK
         65s5k6IeRiYxSMSjefHQj3GY5PNlrdRWxkRKqXP5gt6sJ5SUOBXXHI2aLG+6UsEbqgZp
         GNzA==
X-Gm-Message-State: AOAM533Ce28YdKpm7xpFgW32shY6Ik2x+CGDZ8zZOhIGBOLoyzO7AntZ
        bN++pqvIXPxvRL1iskKMBDg=
X-Google-Smtp-Source: ABdhPJyFbIKCjVxLDYeGFMSjuG4+6QkMO84Ss6Feq+ruqNJ/Xxn7DKmmuSF3msPsCLhL/NTMyrcWqg==
X-Received: by 2002:a17:902:bd4b:b0:14a:7839:d839 with SMTP id b11-20020a170902bd4b00b0014a7839d839mr36051318plx.134.1642652853165;
        Wed, 19 Jan 2022 20:27:33 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:9dc9])
        by smtp.gmail.com with ESMTPSA id n15sm6951550pjn.32.2022.01.19.20.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 20:27:32 -0800 (PST)
Date:   Wed, 19 Jan 2022 20:27:30 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/5] bpf: reject program if a __user tagged
 memory accessed in kernel way
Message-ID: <20220120042730.eow5d3dv3mtkwbci@ast-mbp.dhcp.thefacebook.com>
References: <20220112201449.1620763-1-yhs@fb.com>
 <20220112201500.1623985-1-yhs@fb.com>
 <CAADnVQKY-uvYic=4iXmHMdyiYOSzT1Nx=Zv_70pL+8ypNWQjYQ@mail.gmail.com>
 <4fe03fc1-fc1a-9853-bc10-dacb8cc60fe1@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fe03fc1-fc1a-9853-bc10-dacb8cc60fe1@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 19, 2022 at 08:10:27PM -0800, Yonghong Song wrote:
> 
> 
> On 1/19/22 9:47 AM, Alexei Starovoitov wrote:
> > On Wed, Jan 12, 2022 at 12:16 PM Yonghong Song <yhs@fb.com> wrote:
> > > +
> > > +                       /* check __user tag */
> > > +                       t = btf_type_by_id(btf, mtype->type);
> > > +                       if (btf_type_is_type_tag(t)) {
> > > +                               tag_value = __btf_name_by_offset(btf, t->name_off);
> > > +                               if (strcmp(tag_value, "user") == 0)
> > > +                                       tmp_flag = MEM_USER;
> > > +                       }
> > > +
> > >                          stype = btf_type_skip_modifiers(btf, mtype->type, &id);
> > 
> > Does LLVM guarantee that btf_tag will be the first in the modifiers?
> > Looking at the selftest:
> > +struct bpf_testmod_btf_type_tag_2 {
> > +       struct bpf_testmod_btf_type_tag_1 __user *p;
> > +};
> > 
> > What if there are 'const' or 'volatile' modifiers on that pointer too?
> > And in different order with btf_tag?
> > BTF gets normalized or not?
> > I wonder whether we should introduce something like
> > btf_type_collect_modifiers() instead of btf_type_skip_modifiers() ?
> 
> Yes, LLVM guarantees that btf_tag will be the first in the modifiers.
> The type chain format looks like below:
>   ptr -> [btf_type_tag ->]* (zero or more btf_type_tag's)
>       -> [other modifiers: const and/or volatile and/or restrict]
>       -> base_type
> 
> I only handled zero/one btf_type_tag case as we don't have use case
> in kernel with two btf_type_tags for one pointer yet.

Makes sense. Would be good to document this LLVM behavior somewhere.
When GCC adds support for btf_tag it would need to do the same.
Or is it more of a pahole guarantee when it converts LLVM dwarf tags to BTF?

Separately... looking at:
FLAG_DONTCARE           = 0
It's not quite right.
bpf_types already have an enum value at zero:
enum bpf_reg_type {
        NOT_INIT = 0,            /* nothing was written into register */
and other bpf_*_types too.
So empty flag should really mean zeros in bits after BPF_BASE_TYPE_BITS.
But there is no good way to express it as enum.
So maybe use 0 directly when you init:
enum bpf_type_flag tmp_flag = 0;
?

Another bit.. this patch will conflict with
commit a672b2e36a64 ("bpf: Fix ringbuf memory type confusion when passing to helpers")
so please resubmit when that patch appears in bpf-next.
Thanks!
