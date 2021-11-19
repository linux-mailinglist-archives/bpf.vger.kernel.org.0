Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97059456886
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 04:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhKSDUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 22:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbhKSDUU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 22:20:20 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72647C061574
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 19:17:19 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id r130so8136631pfc.1
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 19:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MIMROgfQmSVaGv17RE8PCxwovyKCt6VaO1BxDNbYnSg=;
        b=WgM74/KFHxAnuxJriasM8wA/0zTK71gj2jq/MH6gJkfDuQnmDkovut7Ret5Pk40sZU
         GRi8T87kg2tV3EfGsVwP9mhT4OOlQ0r0Ba98d5pFni4mYIXxZ1aaPN12a5Vue+DhTz5e
         0ymuIWfOnvUQZWLBD7ac3iv5NcyGL7pExo8dE5JTYv1+S6Mz1+XRQ2WB7tElGNW1diYm
         IgePG49VgnlChq0vOJR5Puhjq1sG1Lgs0Llp49iGX4As/RujqVCp1dWn9uxc1G2Np5R6
         k9u4M5PPGXBLyhxxx0FJBE/OObHWY6vkMi+4KZ8gv3we7/M8ztsZoRinc2ARHiV4Jod9
         Pz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MIMROgfQmSVaGv17RE8PCxwovyKCt6VaO1BxDNbYnSg=;
        b=y9McAKbNJdNHo7tpa+cjbhxZ+u2as8DF1kUfVmkxTLd23olggrFId7Ve9b1N9Pb8IB
         gwCR7KkezHiJoau0Qra8j96XceZIZOAbrMO3Aa1E8bG+Wzqmnsd0gEI3mZcSdsD01K2A
         hgb5V5KFE+vQVl2P6+wMoi62ZNRGMy8C2B03ADHNgwFFrJaUyv6u3Z+6tzEhV3CE80gh
         zPxRR4jVrQkfggEj/L5HUFPVIIwfrB8hcLhfvKX+Sq74Yx5ls7r/VbLWdBQP6oMYQqJN
         RTPp/RBh9si4zZmAXvh/TnuH8jpIqeyiBzijpN6kV4eJvCAk/jPxu9sEPNP4rVwt+Red
         PXVQ==
X-Gm-Message-State: AOAM531abS5J31bJYlY8tYWays2W/BXEpv5V3fcn1R1wbFQ4R6RISF70
        6UTWPaXyh5r8C8x9NeE4LVs=
X-Google-Smtp-Source: ABdhPJzXFMwwN9NUEDDpq5QZ5jEQDOLCOZtF9OUkg4etpoE5BzgM6+uc+DbFZvx/WV/munLAxx4uOg==
X-Received: by 2002:a63:2c8c:: with SMTP id s134mr15008168pgs.221.1637291838874;
        Thu, 18 Nov 2021 19:17:18 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4e33])
        by smtp.gmail.com with ESMTPSA id ml24sm821047pjb.16.2021.11.18.19.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 19:17:18 -0800 (PST)
Date:   Thu, 18 Nov 2021 19:17:16 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 02/12] bpf: Rename btf_member accessors.
Message-ID: <20211119031716.47gpmk7wahpfuixw@ast-mbp.dhcp.thefacebook.com>
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
 <20211112050230.85640-3-alexei.starovoitov@gmail.com>
 <CAEf4BzYjvg+iqs8wB9bMYWJ-BAH6s4iM89vvB9ZywjHKQBJg8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYjvg+iqs8wB9bMYWJ-BAH6s4iM89vvB9ZywjHKQBJg8g@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 16, 2021 at 04:38:18PM -0800, Andrii Nakryiko wrote:
> >
> > -static inline u32 btf_member_bit_offset(const struct btf_type *struct_type,
> > -                                       const struct btf_member *member)
> > +static inline u32 __btf_member_bit_offset(const struct btf_type *struct_type,
> > +                                         const struct btf_member *member)
> 
> a bit surprised you didn't choose to just remove them, given you had
> to touch all 24 places in the kernel that call this helper
> > -                       if (btf_member_bitfield_size(t, member)) {
> > +                       if (__btf_member_bitfield_size(t, member)) {
> 
> like in this case it would be btf_member_bitfield_size(t, j)

In this and few other cases it's indeed possible, but not in net/ipv4/bpf_tcp_ca.c
It has two callbacks:
struct bpf_struct_ops {
        const struct bpf_verifier_ops *verifier_ops;
        int (*init)(struct btf *btf);
        int (*check_member)(const struct btf_type *t,
                            const struct btf_member *member);
        int (*init_member)(const struct btf_type *t,
                           const struct btf_member *member,
so they cannot be changed without massive refactoring.
Also member pointer vs index is arguably a better api.
I'm not sure compiler can optimize index into pointer in case like below
and won't introduce redundant loads.

> >         for_each_member(i, t, member) {
> > -               moff = btf_member_bit_offset(t, member) / 8;
> > +               moff = __btf_member_bit_offset(t, member) / 8;
> 
> same here, seema like in all the cases we already have member_idx (i
> in this case)
