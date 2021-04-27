Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F1036CC70
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 22:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbhD0Ujt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 16:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbhD0Ujq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 16:39:46 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC30C061574;
        Tue, 27 Apr 2021 13:39:02 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id s9so12676468ybe.5;
        Tue, 27 Apr 2021 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBP/gDLd/8oKErMwsojvZSMfN6fwi4M1jDSPKsc8hSk=;
        b=Hux1KjxFk22F4cXuOa0lXCqS5NXglqipUEb7j+hj+/4z1R9ijOFIuwjYhSrnBm6CKk
         fcyfxZzDGKqteJ967ClWEGOZMJB25FspGLpMuxWFaBwtUQvZGu0mAPehTN8A/R1EPKGi
         b9T5WP3nvx2AH6JyPtW0Qes4TT4kYTrHqR55NrNnG7d6nMoqje6LlpZLRGiwSrGTBD+x
         ljNVicaPdCcT0gPgFa/vHyHIcHajFNfKydMXwHobSBGF70TXcAgl43UjTpUd+o8X9+dW
         7kgQONxqfbptfM7KOgdNWOsy7osoD8ilZQnwp2+skCwK2RgfD0XsVV6IjAMIfxVMgDrW
         FARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBP/gDLd/8oKErMwsojvZSMfN6fwi4M1jDSPKsc8hSk=;
        b=Jsyw2ktQXZQZep4NkWMSKoxSLkjV27m4bzRR3fwBFJg1XcDllY7tT9W6wzo/Z8Z/FW
         InL1rXUthvwmDCAoRQ7w3ynsdCm2M67MLgtAjWEG9f52+HiB8AENp/CVgLwD/ttX5R2E
         m70MST7u3NMIB5XA3Slz0rTMSsfl+3yoK1zj93RpRVmvEHxeLYy+bUacsZuWJ4azpeBK
         3uwc9DyGDpy+X2wNvZWjiW9QzduT0J8gHJKIcEYNSz5m3opGYDt2f+pfJ0CVl4PGu9jK
         0fLSmgJ6ag1nsrp74FxqfxAprKadTqh8eoq1OMflQE+SuzMYB6eF3haqnwB/Dx8k2wyu
         Vp/A==
X-Gm-Message-State: AOAM532+Wu3blCuDM4bo3g5WxJOdLJoaRcyaMEnQHwca6abmHy2muots
        5CRnIOnx1b7MKOjDOxjhVk36jVQ+n7xC5JMjS0Y=
X-Google-Smtp-Source: ABdhPJydq143OT7ZWEiBuWS/Teewh41a6hnsmY9gI/hDjrMCMXmgkDY8qjJht8/kdeL4tDcMhFUzNWQLlJNgDS1/710=
X-Received: by 2002:a25:c4c5:: with SMTP id u188mr35363728ybf.425.1619555941955;
 Tue, 27 Apr 2021 13:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210423213728.3538141-1-kafai@fb.com> <CAEf4BzY16ziMkOMdNGNjQOmiACF3E5nFn2LhtUUQbo-y-AP7Tg@mail.gmail.com>
 <YIf3rHTLqW7yZxFJ@krava> <YIgE1hAaa3Hzwni8@kernel.org>
In-Reply-To: <YIgE1hAaa3Hzwni8@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Apr 2021 13:38:51 -0700
Message-ID: <CAEf4Bzbh7+WJ502J_MQKiHDZ_Ab-Vb_ysHO6NNuZwNfThKCAKw@mail.gmail.com>
Subject: Re: [PATCH dwarves] btf: Generate btf for functions in the .BTF_ids section
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Martin KaFai Lau <kafai@fb.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 27, 2021 at 5:34 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Apr 27, 2021 at 01:38:20PM +0200, Jiri Olsa escreveu:
> > On Mon, Apr 26, 2021 at 04:26:11PM -0700, Andrii Nakryiko wrote:
> > > On Fri, Apr 23, 2021 at 2:37 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > BTF is currently generated for functions that are in ftrace list
> > > > or extern.
> > > >
> > > > A recent use case also needs BTF generated for functions included in
> > > > allowlist.  In particular, the kernel
> > > > commit e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist for bpf-tcp-cc")
> > > > allows bpf program to directly call a few tcp cc kernel functions.  Those
> > > > functions are specified under an ELF section .BTF_ids.  The symbols
> > > > in this ELF section is like __BTF_ID__func__<kernel_func>__[digit]+.
> > > > For example, __BTF_ID__func__cubictcp_init__1.  Those kernel
> > > > functions are currently allowed only if CONFIG_DYNAMIC_FTRACE is
> > > > set to ensure they are in the ftrace list but this kconfig dependency
> > > > is unnecessary.
> > > >
> > > > pahole can generate BTF for those kernel functions if it knows they
> > > > are in the allowlist.  This patch is to capture those symbols
> > > > in the .BTF_ids section and generate BTF for them.
>
> > > I wonder if we just record all functions how bad that would be. Jiri,
> > > do you remember from the time you were experimenting with static
> > > functions how much more functions we'd be recording if we didn't do
> > > ftrace filtering?
>
> > hum, I can't find that.. but should be just matter of removing
> > that is_ftrace_func check
>
> > if we decided to do that, maybe we could add some bit indicating
> > that the function is traceable? it would save us check with
> > available_filter_functions file
>
> You mean encoding it in BTF, in 'struct btf_type'? Seems important to
> have it, there are free bits there:
>
> /* Max # of type identifier */
> #define BTF_MAX_TYPE    0x000fffff
> /* Max offset into the string section */
> #define BTF_MAX_NAME_OFFSET     0x00ffffff
> /* Max # of struct/union/enum members or func args */
> #define BTF_MAX_VLEN    0xffff
>
> struct btf_type {
>         __u32 name_off;
>         /* "info" bits arrangement
>          * bits  0-15: vlen (e.g. # of struct's members)
>          * bits 16-23: unused
>          * bits 24-27: kind (e.g. int, ptr, array...etc)
>          * bits 28-30: unused
>          * bit     31: kind_flag, currently used by
>          *             struct, union and fwd
>          */
>         __u32 info;
>         /* "size" is used by INT, ENUM, STRUCT, UNION and DATASEC.
>          * "size" tells the size of the type it is describing.
>          *
>          * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
>          * FUNC, FUNC_PROTO and VAR.
>          * "type" is a type_id referring to another type.
>          */
>         union {
>                 __u32 size;
>                 __u32 type;
>         };
> };
>
> And tools that expect to trace a function can get that information from
> the BTF info instead of getting some failure when trying to trace those
> functions, right?

I don't think it belongs in BTF, though. Plus there are additional
limitations enforced by BPF verifier that will prevent some functions
to be attached. So just because the function is in BTF doesn't mean
it's 100% attachable.

>
> - Arnaldo
