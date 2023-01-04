Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E77265DD1E
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 20:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbjADTwZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 14:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbjADTvo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 14:51:44 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5154F1DDC1
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 11:51:42 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cl14so760186pjb.2
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 11:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gGfRufgwiyUdXa3eJ5tbVx7FLU0LfHSZG2806Bmarno=;
        b=a7cAHwHS7ZlNYSGok8EvRN6QNUXBaWx3gPocN9uoNpzzwh+af6FTMM8fNHrSVkYnUc
         pGlHd+RqrawjuL737+gg5m3F0kJ5kast+M6+WOSADCoLkS623xIevutmof4BPfY+B3W6
         YY37vn0E2gWk6Yyp9xa85MPepiPiPAfO9raQ5I2KuFeQ4KJi/lj65243ia4xLH8iUyre
         pDmjVOBew5VbrjO2abkWm8SGdzVZc6uHoL2dWxYBcFp7B71DCUgLg3yGtY6PGWfYLJUh
         6J7lGnmAQypVA06MpK9/HdaEmi4gsApUb6oi+H6Md/XVrHoKGI9bdiswZJqFwlJD9G6p
         0kzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGfRufgwiyUdXa3eJ5tbVx7FLU0LfHSZG2806Bmarno=;
        b=UbyiGr8Y7+SKorWXZYSZUbF3xDhvchC27oPn12iyP8SItlQb9Q8QpYvD9O9cexcQQ2
         xm3EjKPq2HQzZzFbXynMCjeYRmzskJeuLSQTjsFHDtE/UdvsSCA6rIGR/1dkjjd4EVXu
         d712EAwrHvii1UFYqTTHpGS9xKL0rNvvzTus9yMeO6T8ZrMNDWyaRStTgGcsmAs0upfZ
         66VjQyopNB9zOFGCmV7z0f16TL6DBrdmlWRP6Fzkpn7Gli++BGigW+EpH5y+KMJ75YDB
         yzzui96uqwTpKcCbdu8VAffiWZTRh6eVLPFpzT+CA8s0MdqgVLYk4hBFccCNvKe3f9Ic
         h2Gg==
X-Gm-Message-State: AFqh2kp35Cp/KBYiFayjcKRrMcSwWIVKMwQHhxJcQkNBwJY6VwVMOSU0
        sZ7ccmKJq2gJQNAiewmSL0Y=
X-Google-Smtp-Source: AMrXdXuuW8SkFvlTcwqyBhcRGrQTcMIDNsiznM/UCdIWGj6KkmeTDkTUhYD+g8h3JpzTyvLuzOMHOA==
X-Received: by 2002:a17:903:41c7:b0:189:ea22:6d6a with SMTP id u7-20020a17090341c700b00189ea226d6amr69897590ple.60.1672861901781;
        Wed, 04 Jan 2023 11:51:41 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:1385])
        by smtp.gmail.com with ESMTPSA id jd6-20020a170903260600b00192a8d795f3sm11597370plb.192.2023.01.04.11.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 11:51:41 -0800 (PST)
Date:   Wed, 4 Jan 2023 11:51:38 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     David Vernet <void@manifault.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
Message-ID: <20230104195138.q43ioskabs4c32py@macbook-pro-6.dhcp.thefacebook.com>
References: <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
 <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
 <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan>
 <CAEf4BzY0aJNGT321Y7Fx01sjHAMT_ynu2-kN_8gB_UELvd7+vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY0aJNGT321Y7Fx01sjHAMT_ynu2-kN_8gB_UELvd7+vw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 04, 2023 at 10:43:52AM -0800, Andrii Nakryiko wrote:
> 
> struct bpf_dynptr dptr = ...;
> bool is_null = false;
> 
> if (bpf_core_value_exists(enum bpf_func_id, BPF_FUNC_dynptr_is_null)) {
>     is_null = bpf_dynptr_is_null(&dptr);
> } else {
>     struct bpf_dynptr_kern *kdptr = (void*)&dptr;
>     is_null = !!BPF_CORE_READ(kdptr, data);
> }
> 
> How do you detect the existence of kfunc today? Preferably without
> doing extra work in user-space.
> 
> Now, let's say kfunc changes its signature. Show me a short example on
> how you deal with that in BPF C code?

Didn't we add bpf_core_type_matches for func protos specifically
to deal with function signature changes in the kernel after tracepoint
args got swapped?
I'm assuming the same mechanism will work for kfuncs.
If not we can come up with a new one.

> 
> Think about sched_ext. Right now it's so bleeding edge that you have
> to assume the very latest and freshest kernel code. So you know all
> the kfuncs that you need should exist otherwise sched_ext doesn't work
> at all. Ok, happy place.
> 
> Now a year or two passes by. Some kfuncs are added, some are changed.
> We still believe that BPF CO-RE (compile once - run everywhere) is
> good and we don't want to compile and distribute multiple versions of
> BPF application, right? You'll want to do some extra (or more
> performant) stuff if kernel is recent and has some new kfunc, but
> fallback to some default suboptimal behavior otherwise. How do you do
> that in a simple and straightforward way? 

with a help of CORE, of course.
If it doesn't exist today we can add it.

> But even worse is what if
> some critical kfunc is changed between kernel versions and you do
> *need* to support both versions. Think about those aspects, because
> sched_ext will run into them almost inevitably soon after its
> inclusion into kernel.
> 
> 
> One way or another there are some technical solution of various
> degrees of creativity. And I'm actually not sure if I have a solution
> for kfunc signature change at all. Without BTF we could use two
> separate .c files and statically link them together, which would work
> because extern is untyped in pure C. But with BPF static linking we do
> have BTF information for each extern, and those BTF types will be
> incompatible for the same extern func.
> 
> We can probably come up with some hacks and conventions, as usual, but
> better start thinking about them now.
> 
> But hopefully you can empathize a bit more with poor end users that
> have to do hack like this and why having bpf_dynptr API defined as
> stable BPF helpers, with no extra dependencies on BTF in kernel, 

BTF is a reasonable dependency.
You've just used it to detect whether helper exists or not.
So it's fine to use the same to check whether kfunc exists or not.

> 
> Depends on perspective. If I was some humble dev trying to build
> BPF-based tool that should work on x86, arm64, s390x, and riscv (or
> whatever other architecture), and dynptr API is only based on kfuncs,
> I'm screwed. I can't sponsor or do kfunc support for my favorite
> architecture, I'm stuck waiting for this to be done by someone some
> time, if ever.

If kfuncs and bpf trampoline don't work on a particular architecture
that developer is likely screwed anyway. Dynptr is the last thing they
would worry about.
