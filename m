Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744794A0014
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 19:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350539AbiA1S2F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jan 2022 13:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245735AbiA1S2E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jan 2022 13:28:04 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A02C061714
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 10:28:04 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ah7so18772078ejc.4
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 10:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5csExDfAq2CF8PZL0mkHHlS63LpDZtNGmh8ny+7VJoI=;
        b=BJ2qacWQk1W0mSFC054Ild1AjYez4k8r/d3g3Z2MGtvlH6evdm0rtup7+yofvm8ctX
         1B4I42V7dZ2bBbDPqicaP6UaDWdA2ELARICaVckhTbH3A70rAsKN0T/noEnPnPxYXQL3
         oo/IQ9dUrqTB6s6WT4bNxqhzgs6Aq6gkJIH/fhRvhdyCrcHgORJWtfLd3/TJWFVGSdH+
         0hGXSB2Uf7lA2zX3Z+0d07bSbOb9uF5SXPZ7zsqhA4Qrhw1Mh/yejmZyTNJAzu5zFAeA
         P1Pi4zag+VzdRWi6OvIumI3Unvw/QBnU6Q1DRjcuq270TUcH5KTv5Z6jaNVwBkQe4GOE
         qP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5csExDfAq2CF8PZL0mkHHlS63LpDZtNGmh8ny+7VJoI=;
        b=yhrc96jJbSZbfnv1YmeEOT6kzZyzqDjco9JQzanUKUbVQTC+2/x/zVhosCkkrPHz9P
         35YCT4zO0EI4goOM0GdFaZ+108Ik00Ok1WNKjzOEYCiWP95lGV5ykzJi03MwnIP52lyt
         fYVTRMbJeYOI2DovCaMlTAbOvOMoVt0cDhcccrShxB+gELWbPqfSHwvUBiJoHda6VXNR
         Q12/090m8eNT53lFV0ZJvrkTgvdzNPEDBcRjkuZCyBIi1GzGSnWubaVdH8MP9szpljr1
         a+OhyON9cbywEgjP00V68B9tCeBXZEWKvMHzWUFFNy99AHRFs9u5EQCp/CRmvbckxcRX
         mkqQ==
X-Gm-Message-State: AOAM532vYcHuqwliMQ05b1pdzzMbE9gGMeh9rI9dOF9LW2px0LzixYvU
        RdVWGiYF4V3x8wbrLex9u1EhkKxoVUCSrKfgyDP2Ae2fLc4=
X-Google-Smtp-Source: ABdhPJwu6ZorpNknD9rhKD2+FWtf2QUX2FWktWVq0aOXzFCLnIaQ76Hm16r1G1O1DXjimo2YGc/4wu57imRBvCJrWZ8=
X-Received: by 2002:a17:907:7241:: with SMTP id ds1mr8189065ejc.199.1643394482971;
 Fri, 28 Jan 2022 10:28:02 -0800 (PST)
MIME-Version: 1.0
References: <CAK3+h2wcDceeGyFVDU3n7kPm=zgp7r1q4WK0=abxBsj9pyFN-g@mail.gmail.com>
 <CAK3+h2ybqBVKoaL-2p8eu==4LxPY2kfLyMsyOuWEVbRf+S-GbA@mail.gmail.com>
 <CAK3+h2zLv6BcfOO7HZmRdXZcHf_zvY91iUH08OgpcetOJkM=EQ@mail.gmail.com> <41e809b6-62ac-355a-082f-559fa4b1ffea@fb.com>
In-Reply-To: <41e809b6-62ac-355a-082f-559fa4b1ffea@fb.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Fri, 28 Jan 2022 10:27:51 -0800
Message-ID: <CAK3+h2xD5h9oKqvkCTsexKprCjL0UEaqzBJ3xR65q-k0y_Rg1A@mail.gmail.com>
Subject: Re: can't get BTF: type .rodata.cst32: not found
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 27, 2022 at 5:50 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/25/22 12:32 PM, Vincent Li wrote:
> > On Tue, Jan 25, 2022 at 9:52 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
> >>
> >> this is macro I suspected in my implementation that could cause issue with BTF
> >>
> >> #define ENABLE_VTEP 1
> >> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
> >> 0x2048a90a, }
> >> #define VTEP_MAC (__u64[]){0x562e984c3682, 0x582e984c3682,
> >> 0x5eaaed93fdf2, 0x5faaed93fdf2, }
> >> #define VTEP_NUMS 4
> >>
> >> On Tue, Jan 25, 2022 at 9:38 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
> >>>
> >>> Hi
> >>>
> >>> While developing Cilium VTEP integration feature
> >>> https://github.com/cilium/cilium/pull/17370, I found a strange issue
> >>> that seems related to BTF and probably caused by my specific
> >>> implementation, the issue is described in
> >>> https://github.com/cilium/cilium/issues/18616, I don't know much about
> >>> BTF and not sure if my implementation is seriously flawed or just some
> >>> implementation bug or maybe not compatible with BTF. Strangely, the
> >>> issue appears related to number of VTEPs I use, no problem with 1 or 2
> >>> VTEP, 3, 4 VTEPs will have problem with BTF, any guidance from BTF
> >>> experts  are appreciated :-).
> >>>
> >>> Thanks
> >>>
> >>> Vincent
> >
> > Sorry for previous top post
> >
> > it looks the compiler compiles the cilium bpf_lxc.c to bpf_lxc.o
> > differently and added " [21] .rodata.cst32     PROGBITS
> > 0000000000000000  00011e68" when  following macro exceeded 2 members
> >
> > #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
> > 0x2048a90a, }
> >
> > no ".rodata.cst32" compiled in bpf_lxc.o  when above VTEP_ENDPOINT
> > member <=2. any reason why compiler would do that?
>
> Regarding to why compiler generates .rodata.cst32, the reason is
> you have some 32-byte constants which needs to be saved somewhere.
> For example,
>
> $ cat t.c
> struct t {
>    long c[2];
>    int d[4];
> };
> struct t g;
> int test()
> {
>     struct t tmp  = {.c = {1, 2}, .d = {3, 4}};
>     g = tmp;
>     return 0;
> }
>
> $ clang -target bpf -O2 -c t.c
> $ llvm-readelf -S t.o
> ...
>    [ 4] .rodata.cst32     PROGBITS        0000000000000000 0000a8 000020
> 20  AM  0   0  8
> ...
>
> In the above code, if you change the struct size, say from 32 bytes to
> 40 bytes, the rodata.cst32 will go away.

Thanks Yonghong! I guess it is cilium/ebpf needs to recognize rodata.cst32 then

Vincent
