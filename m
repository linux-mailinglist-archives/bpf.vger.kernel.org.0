Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CB34356CF
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 02:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhJUARH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 20:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJUARH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 20:17:07 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14935C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 17:14:52 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id s64so19018937yba.11
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 17:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yTTZ706DRDbQHTtfSaCImH89gPPtcScXW1ihGhIthS8=;
        b=T/j4jyj6gtpO7fftu2CJDTY0puag/CZSze1iXp8cOK9CSzaWb1VelDhlpg4Fgdhryv
         pDdm9ZZ4HIxsvhzZNOfu1YMf0uhzok+p+NTk5SUk4wgJtFD3gMTmsdlqiWOISRn4ffEZ
         6uB7AG7DGFyN0Kv7EyDtxFS76/yYwnx3ohJCpiISzSB00Ra9yIc8bdYkPW1rheMB5L69
         +z7eBZ5qDRF6NbI900T7dCLsnPEQ2M0F/UHaIO0qqHgJaQ8+5xEdNockixq9uwglWBmS
         IMGhttZMjNIBUVxExMljnuEqnwIyEnKQZPTPMYCwCGRowkkctGM9xSZU+XwNOJzFJhci
         Q36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yTTZ706DRDbQHTtfSaCImH89gPPtcScXW1ihGhIthS8=;
        b=xdPzH66JqzhEF+EU6hmofgDhp9k7lWBowLn6HW4k5249X0hUUWlFf1wsPpWJEEwGJB
         5bbqvbOvd0tH7bZAEgd5SDjWbK4lEcJkiNiMa1ipRSZRtNU0grQqp/oVmTgAj/9pjaiY
         3SZokkFdbtXBN7vxJVhfJg+iv+bGZ/uUdPHZGl9ntRI3pe8lHncTQpr+pW2ml78hZW+j
         ygNe9f3JV51RCGeV3Nc1ItoM6selK0Aa6GZ9JUq6Mux/67lXv8+cmABI1GrEotdSmKqO
         a92qRuCNGogHOepHkDQ2ArTLMnx11Pm68txzmr2iN3JqkLw9dqA69riSShnBGMBpywVW
         UzRQ==
X-Gm-Message-State: AOAM531nIEZuHaLdWyLwisk+r0xi486BBSguzlhd4MxYU/BIrkQWaunx
        N3kLYJvJ/aWck1rQCCJHhzZrD9cV9JFA1RlfF3ajOQVor5Joog==
X-Google-Smtp-Source: ABdhPJzy5eedjRt1vz+a3s0sw0p8IRUGaAB1AFwAQYFQP6qMZudhfSxODvSs6O2jIr61hujEtQMsvypD7dIytupfzNk=
X-Received: by 2002:a25:5606:: with SMTP id k6mr2353564ybb.51.1634775291288;
 Wed, 20 Oct 2021 17:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211012041524.udytbr2xs5wid6x2@apollo.localdomain>
In-Reply-To: <20211012041524.udytbr2xs5wid6x2@apollo.localdomain>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 17:14:40 -0700
Message-ID: <CAEf4BzY43kSeayjxu_CsnGsy-hF_yfXac9e+caUiUAeJ8c-6sQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/10] libbpf: support custom .rodata.*/.data.* sections
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 11, 2021 at 9:15 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, Oct 08, 2021 at 05:32:59AM IST, andrii.nakryiko@gmail.com wrote:
> > From: Andrii Nakryiko <andrii@kernel.org>
> >
> > [...]
> > One interesting possibility that is now open by these changes is that it's
> > possible to do:
> >
> >     bpf_trace_printk("My fmt %s", sizeof("My fmt %s"), "blah");
> >
> > and it will work as expected. I haven't updated libbpf-provided helpers in
> > bpf_helpers.h for snprintf, seq_printf, and printk, because using
> > `static const char ___fmt[] = fmt;` trick is still efficient and doesn't fill
> > out the buffer at runtime (no copying), but it also enforces that format
> > string is compile-time string literal:
> >
> >     const char *s = NULL;
> >
> >     bpf_printk("hi"); /* works */
> >     bpf_printk(s); /* compilation error */
> >
> > By passing fmt directly to bpf_trace_printk() would actually compile
> > bpf_printk(s) above with no warnings and will not work at runtime, which is
> > worse user experience, IMO.
> >
>
> You could try the following (_Static_assert would probably be preferable, but
> IDK if libbpf can use it).

Yeah, we definitely can use _Static_assert from BPF side (see
progs/test_cls_redirect.c in selftests/bpf).

>
> #define IS_ARRAY(x) ({ sizeof(int[-__builtin_types_compatible_p(typeof(x), typeof(&*(x)))]); 1; })
>

Thanks! This seems to be working well to detect arrays and string
literals. I'll keep it in my toolbox :) Ultimately I decided to not
touch bpf_printk() for now, because of the BPF_NO_GLOBAL_DATA trick.
If I go with direct "fmt" usage, I'll need to implementations of
__bpf_printk(), which doesn't seem worth it right now. I might revisit
it later, though.

> In action: https://godbolt.org/z/4d4W61YPf
>
> --
> Kartikeya
