Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0160849BD34
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 21:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiAYUce (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 15:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiAYUce (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 15:32:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB6AC06173B
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 12:32:34 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id j2so33061448ejk.6
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 12:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=bokI7pGwRLMRTDVTPnRqBIC/QXPqkJQzLSJnqzFkC54=;
        b=YenqlmfrBrMjBoFHEJJrFq0rU4Y+D4bPQUUqHGbhXBdkx1Dk1uixgInmVzVvbeXBXq
         sULWK+gcYA3eukCILt1DxAw/711RyxXPdIiV6ZApzuPzvIqeT5oEHoDKa39OBDzftqS6
         4VtlWvxrozVn0b5vpGPDq2Q5wn7XSgLTYT7es9B7wy5GTB4/vzMTp7GbhmgrhGlV6cCw
         sOIxSywEzfUhcRDot4Z5iRAurWp6FwVNtuI1EuHhqU75ei2dL03l9mrkLZnxSEIO7Ozs
         eZHpw8T+00oq/66IEU0PlD2bASdb5j1l4KdFBohypV6WmpptI97+3j/oA+DxHO9n+9tj
         Ddiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=bokI7pGwRLMRTDVTPnRqBIC/QXPqkJQzLSJnqzFkC54=;
        b=D5D2GmcXZygnqG5F06mwAbzhbn9W0tGSwUJ19ObbTWkezG3nT8FSyqNrSqjpKqf34z
         WAeemz7ea+EeL+k/40P27rypWlQDx+O3pLJnvYzhx+zumZrUe0UUMjM3g1WhrEtY761A
         iQbljMV86ECyjhj30inX5MeWUyhUJmZKyx2UcPQUqATgJmh2+nhMJHG+aNdtvq+LhYSh
         /CGKoTdzS+O1JvXpeiEBHBGwybpEvwVZwZDNTsSmEBMJ9qJiFc0ZFVdQrNcOwk7yInsB
         4QLlIm9fU68vyZoYnCLMf2YzRPrqC9IRNOhkGO3/zeAGO+CyefG2t9yYx3k1O53Owz9D
         shcQ==
X-Gm-Message-State: AOAM530jcI7mpcfpBljoc58vE2A4Vrstn4bbYDYmBUvwWp0p7Bk/BoK2
        GhwkXtpHawM1U7Ov5i3Dkq2KiV8KE50yAqwnEw/kBmwpzJzlNQ==
X-Google-Smtp-Source: ABdhPJz3pSoN4UIXETqJ1SEsNGG1+FpvnI35sUfVAIh3o3+J2yz+fyxWZpesEmMT4Of+liTXXeWOnrEfnGluXznH0o8=
X-Received: by 2002:a17:906:c116:: with SMTP id do22mr17776484ejc.592.1643142752374;
 Tue, 25 Jan 2022 12:32:32 -0800 (PST)
MIME-Version: 1.0
References: <CAK3+h2wcDceeGyFVDU3n7kPm=zgp7r1q4WK0=abxBsj9pyFN-g@mail.gmail.com>
 <CAK3+h2ybqBVKoaL-2p8eu==4LxPY2kfLyMsyOuWEVbRf+S-GbA@mail.gmail.com>
In-Reply-To: <CAK3+h2ybqBVKoaL-2p8eu==4LxPY2kfLyMsyOuWEVbRf+S-GbA@mail.gmail.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Tue, 25 Jan 2022 12:32:20 -0800
Message-ID: <CAK3+h2zLv6BcfOO7HZmRdXZcHf_zvY91iUH08OgpcetOJkM=EQ@mail.gmail.com>
Subject: Re: can't get BTF: type .rodata.cst32: not found
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 25, 2022 at 9:52 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>
> this is macro I suspected in my implementation that could cause issue with BTF
>
> #define ENABLE_VTEP 1
> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
> 0x2048a90a, }
> #define VTEP_MAC (__u64[]){0x562e984c3682, 0x582e984c3682,
> 0x5eaaed93fdf2, 0x5faaed93fdf2, }
> #define VTEP_NUMS 4
>
> On Tue, Jan 25, 2022 at 9:38 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
> >
> > Hi
> >
> > While developing Cilium VTEP integration feature
> > https://github.com/cilium/cilium/pull/17370, I found a strange issue
> > that seems related to BTF and probably caused by my specific
> > implementation, the issue is described in
> > https://github.com/cilium/cilium/issues/18616, I don't know much about
> > BTF and not sure if my implementation is seriously flawed or just some
> > implementation bug or maybe not compatible with BTF. Strangely, the
> > issue appears related to number of VTEPs I use, no problem with 1 or 2
> > VTEP, 3, 4 VTEPs will have problem with BTF, any guidance from BTF
> > experts  are appreciated :-).
> >
> > Thanks
> >
> > Vincent

Sorry for previous top post

it looks the compiler compiles the cilium bpf_lxc.c to bpf_lxc.o
differently and added " [21] .rodata.cst32     PROGBITS
0000000000000000  00011e68" when  following macro exceeded 2 members

#define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
0x2048a90a, }

no ".rodata.cst32" compiled in bpf_lxc.o  when above VTEP_ENDPOINT
member <=2. any reason why compiler would do that?
