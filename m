Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDE94CB32C
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 01:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiCCAFi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 19:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiCCAFg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 19:05:36 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C149F13
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 16:04:47 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id d3so2727597ilr.10
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 16:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/OWy/OEn0MdMHicH3sNTD1vye0V/hIZS/qSTdPkK5pg=;
        b=er8lrXYZpK9g/SbY8RKY4fzCW5U5WOQLnyTiJY0JkDP72NPjumDArJDTdxXGM119fn
         40FG3cWmMp6GEdY9rn3tz7K9atRO7Gz/ZH1M6aMDMgb26Zfil0T2b0p/gNdJtErToHgc
         R0DyQppSkObJn+YS1bnFbfUrqyF8dnSds+TKxrdL6iim3iAaxRWtS2Us77OzFTuQ8StB
         wbGFhK8f2VYGdLxSUM78/QGkAUfcyqEDbijULIG+dOBhfnFHjcQGABk3OC78aq9Z6t3K
         4tTRu4l2FOx/M2A3LG/WMdaWvrvXFRpHsHD0MolIf1mCackFgZ63pCww2+yTqjNUpdiH
         g2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/OWy/OEn0MdMHicH3sNTD1vye0V/hIZS/qSTdPkK5pg=;
        b=N+szMbDtqnowPPYVtaI8B1sLFyO722QVT4wTT8BlWGKfsrPyAKbgbnkhvfKg6ukBdD
         d7a5+xtsXJVEl0v2xZzOiBsCQfKyyKOC6K5oDf37oI307lUg/JcdRNTRr9py0sbY9tXy
         xZrxzJUljY9o52txw3M4fX6DhnCt9UOpIdMYJpmtodFuCWGre2a3rIdM+y+cVEB/joco
         prlbO4HCI7rUpT5p6oCubvuELfSMLrMFDKByLrYz3uz+aopDqV2Xsdb3mi814rIMW5S8
         zoGFSdHhkq8SNe9X+wk/S+lwodl1OKuKwin40RHLQeljaVn1QoAt+qOohl7FmQZFITKI
         70Eg==
X-Gm-Message-State: AOAM530OeeJAZk21SyC1DXKUPSFFLuVoD9/0VjQwZF+blgnsbj330Bnp
        xLE3CW6iDn0rA30bPmxSU4kNJaGaQY4=
X-Google-Smtp-Source: ABdhPJxqgI/4GpKCJ5023oxQyUakVTrpHH/tqiCbGxk13tMFMQsce2ueE8cjhy/dD2+w/goH9w9afw==
X-Received: by 2002:a63:3487:0:b0:373:4c14:59b1 with SMTP id b129-20020a633487000000b003734c1459b1mr28054667pga.68.1646263794865;
        Wed, 02 Mar 2022 15:29:54 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b004c55d0dcbd1sm248020pfu.120.2022.03.02.15.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 15:29:54 -0800 (PST)
Date:   Thu, 3 Mar 2022 04:59:52 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v1 4/6] bpf: Harden register offset checks for
 release kfunc
Message-ID: <20220302232952.2p7nn5bzqaflftev@apollo.legion>
References: <20220301065745.1634848-1-memxor@gmail.com>
 <20220301065745.1634848-5-memxor@gmail.com>
 <20220302032024.knhf2wyfiscjy73p@kafai-mbp>
 <20220302094218.5gov4mdmyiqfrt6p@apollo.legion>
 <20220302215640.2thsbd4blxbfd7tk@kafai-mbp>
 <20220302223020.3vmwknct24pplzzr@apollo.legion>
 <20220302224418.5ph7nkzx2qmcy36n@ast-mbp.dhcp.thefacebook.com>
 <20220302230047.7xjekpuivrbno5cp@apollo.legion>
 <CAADnVQLPpCLLTQZdeXWfx_Ey-4mrs_=yuL48dVpi839hq9No+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLPpCLLTQZdeXWfx_Ey-4mrs_=yuL48dVpi839hq9No+A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 03, 2022 at 04:47:59AM IST, Alexei Starovoitov wrote:
> On Wed, Mar 2, 2022 at 3:00 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > fwiw I like patches 1-3.
> > > I think extra check here for release func is justified on its own.
> > > Converting it into:
> > >   fixed_off_ok = false;
> > >   if (type == PTR_TO_BTF_ID && (!is_release_func || !reg->ref_obj_id))
> > >           fixed_off_ok = true;
> > > obfuscates the check to me.
> >
> > I was talking of putting this inside check_func_arg_reg_off. I think we should
> > do the same check for BPF helpers as well (rn only one supports releasing
> > PTR_TO_BTF_ID, soon we may have others). Just passing a bool to
> > check_func_arg_reg_off to indicate we are checking for release func (helper or
> > kfunc have same rules here) would allow putting this check inside it.
>
> Hmm. check_func_arg() is called before we call
> is_release_function(func_id).
> Are you proposing to call it before and pass
> another boolean into check_func_arg() or store the flag in meta?

We save meta.func_id before calling check_func_arg. Inside it we can do:
err = check_func_arg_reg_off(env, reg, regno, arg_type, is_release_function(meta->func_id));

I actually tried open coding it for BPF helpers, and it was more complicated. If
we delay this check until is_release_function call after check_func_arg, we need
to remember if reg for whom meta->ref_obj_id had off > 0 and type PTR_TO_BTF_ID.
If we put it inside check_reg_type or check_func_arg, you need to call
is_release_function anyway there.

Compared to these two options, doing it in check_func_arg_reg_off looks better
to me, but ymmv.

> Sounds ugly.
> imo reg->off is a simple enough check to keep it open coded
> where necessary.

--
Kartikeya
