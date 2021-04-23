Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA343693F4
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 15:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhDWNqS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Apr 2021 09:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhDWNqH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Apr 2021 09:46:07 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00E1C06174A
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 06:45:29 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e186so489273iof.7
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 06:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hadQA6kRs+D4pVpp3rDemh4znqWCxT2uwsFMnVuSorc=;
        b=RQhD6LxA0EbE2aUkDyAwhX+M5JkqY9x9p4Ho29YHrrZ8YXyYl3QfXISkyDJe2RwTH0
         Ie9LgFomrUlYkmNy9NCH4oiTdGIsiEo8T9azTwMIpIMBdXmSZp39AWROhGvugMRnFVy7
         jF1q3pwqbLkJl3aivQQC/FUAKR7+y/J35NbH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hadQA6kRs+D4pVpp3rDemh4znqWCxT2uwsFMnVuSorc=;
        b=XREwJ+JsQWROIJAdpNb5k4v6YJLGT0WNxyMqNEVDqd/7DCxHX5I/ejmHLfKCPEyPh+
         HRCZF5Q17lNIH3ctJ9stxaowrR6GgKaptoiQkO0c07wMr1yXqImaCt4jfawzQHwEriP3
         FHTSzPm/A2Pd3nlU8tTuxT8o48F4uQp6y11LY3clJREfNUYBPoMiLqOw6hX4pkiU8lsB
         +uQj9JZJbzkqwItE/sma6Ml80fPFMsr5BAXAWSSgcpZXisTruGqmxtzikVo3nM6oiGSs
         Za2lVrgY3OA4XJ65apnK9LKrBBZrMuawrKO0ydh+7DcpDgNcTHRfDUbcH5u8djwumBZF
         zSdA==
X-Gm-Message-State: AOAM532ekkCxLhn2PCN8Mad+M1rk5CrW9iz5n2iujVle+zjoKSPLNGWw
        sZrv2jcJW6CkB2kuX/WiXAd+1KzAH19Br1WnfTB1e8xU4f+PXA==
X-Google-Smtp-Source: ABdhPJwTV4gp9LJYsVJJWcgJFrxSByzV5LSYY0rO2SJ1PjoOjh4K6HODB5G8+uITBoMdVJ4FKhPUoLzQHeIArrG+vC8=
X-Received: by 2002:a02:9508:: with SMTP id y8mr3702499jah.125.1619185529119;
 Fri, 23 Apr 2021 06:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210423011517.4069221-1-revest@chromium.org> <20210423011517.4069221-3-revest@chromium.org>
 <ebe46a2a-92f8-8235-ecd8-566a46e41ed5@rasmusvillemoes.dk>
In-Reply-To: <ebe46a2a-92f8-8235-ecd8-566a46e41ed5@rasmusvillemoes.dk>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 23 Apr 2021 15:45:18 +0200
Message-ID: <CABRcYmJj5MTHKkOq9DT4Ju0LJmFV_8hZ+uLxwVf4bhoaL3C_aQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Implement formatted output helpers with bstr_printf
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 23, 2021 at 11:27 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 23/04/2021 03.15, Florent Revest wrote:
> > BPF has three formatted output helpers: bpf_trace_printk, bpf_seq_printf
> > and bpf_snprintf. Their signatures specifies that arguments are always
> > provided from the BPF world as u64s (in an array or as registers). All
> > of these helpers are currently implemented by calling functions such as
> > snprintf() whose signatures take arguments as a va_list.
>
> It's nitpicking, but I'd prefer to keep the details accurate as this has
> already caused enough confusion. snprintf() does not take a va_list, it
> takes a variable number of arguments.

Agreed, will fix in v2

> > To convert args from u64s to a va_list
>
> No, the args are not converted from u64 to a va_list, they are passed to
> said variadic function (possibly after zeroing the top half via an
> interim cast to u32) as 64-bit arguments.

Agreed

> "d9c9e4db bpf: Factorize
> > bpf_trace_printk and bpf_seq_printf" introduced a bpf_printf_prepare
> > function that fills an array of arguments and an array of modifiers.
> > The BPF_CAST_FMT_ARG macro was supposed to consume these arrays and cast
> > each argument to the right size. However, the C promotion rules implies
> > that every argument is stored as a u64 in the va_list.
>
> "that every argument is passed as a u64".

Yes

> >
> > To comply with the format expected by bstr_printf, certain format
> > specifiers also need to be pre-formatted: %pB and %pi6/%pi4/%pI4/%pI6.
> > Because vsnprintf subroutines for these specifiers are hard to expose,
>
> Indeed, as lib/vsnprintf.c reviewer I would very likely NAK that.

I imagined yes :)

> > we pre-format these arguments with calls to snprintf().
>
> Nothing to do with this patch, but wouldn't it be better if one just
> stored the 4 or 16 bytes of ip address in the buffer, and let
> bstr_printf do the formatting?
>
> The derefencing of the pointer must be done at "prepare" time, but I
> don't see the point of actually doing the textual formatting at that
> time, when the point of BINARY_PRINT is to get out of the way as fast as
> possible and punt the decimal conversion slowness to a later time.
>
> I also don't see why '%pB' needs to be handled specially, other than the
> fact that bin_printf doesn't handle it currently; AFAICT it should be
> just as safe as 'S' and 's' to just save the pointer and act on the
> pointer value later.

These changes would make sense to me, yes, and I tried having %pB work
like %pS and %ps yesterday, it worked like a charm for my usecase but
while reading the commit log of vsprintf.c to understand the
philosophy of this function better, I came across "841a915d20c
vsprintf: Do not have bprintf dereference pointers" that says "Since
perf and trace-cmd already can handle %p[sSfF] via saving kallsyms,
their pointers are saved and not processed during vbin_printf(). If
they were converted, it would break perf and trace-cmd, as they would
not know how to deal with the conversion.". I interpreted that as
"this args binary representation is some sort of UABI '' so I tried
not to mess around with it. But maybe I misunderstood something ?
+cc Steven who probably has context, I should have done that earlier. :)
