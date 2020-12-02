Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70B02CB1AE
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 01:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgLBAr4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 19:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgLBAr4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 19:47:56 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1665C0613D4;
        Tue,  1 Dec 2020 16:47:15 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id o71so75940ybc.2;
        Tue, 01 Dec 2020 16:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SJeLVcFat+Qs+TQ7dZto7FFoIhroDE/w9I3+5NbVPgE=;
        b=AzrsG5Xxa3YH60Z0gVBDcnvKMykw37uMbG+PN2+lPN5OvpkuDkH/0sIPboPBVC6UUS
         DZO5s6BwHmDhBpmUVJPFYUUOgCiywHMUCH3Xer5zcAfvwMJvpOP8WK6AeP0KecRbDEVJ
         o9oT3gumqfHC7M7M8xkCo1+0+nTlgmLwpS273UhUpXiMUW12A8rmy5Wvw2tYuqPXEKCy
         YMBP+AXUwvgOJ+2KFaaoekpsPTQQHLHHw9Kep77D4SqxhfxqwzXUOjAtMbGLbTkPPbdB
         bE2c6d7DDuryfrAJ9aWRiPNuacFbrf6vW+3LvqkTD0YyH8ThbOVJk4zkkujUrKXe/aG9
         IUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJeLVcFat+Qs+TQ7dZto7FFoIhroDE/w9I3+5NbVPgE=;
        b=kHReslDviq3WtbU7x3++NSYUVKTIjGkOcMCiPmzfM9Ojhk4JQT8lX37hf5X3y5UJo5
         5RKUIf/qLYIf1+xPCDNBCAA1W/DtO1/r9N3iSdc8RwoizePLPPe3/y6GzVpJA4S6JUNk
         8YNT5BWjK21Q/1E1ezeRUicd3KgJtGB4PMNpq2uBJdoBmUVI0KN/6wPPkOMIRaqWeTF9
         xnKH4Ww8pdvHW9Z7stDfKQGQ+JZPXPkq9E6DGZzdFi6nGzNlR+1NxBDgdCfvu/sA7DA5
         oNCQwa86uZWzeQX2W3o/HeDvzFQ6P7s1ViAG4qMRnWK+BROIK9u0h20UBn7zuxuvYoKR
         DCtQ==
X-Gm-Message-State: AOAM532an3/bHDOsHNbVpUflge8eD2mIAhhdnTdv97ZAFFn/ZvCyWlHi
        G7p21UPmGZmiOEyml9lh1cs4bl9Cy25zoAqqyu8=
X-Google-Smtp-Source: ABdhPJwqC61zyy61z3Ag/st93e2QIDv4EwqwjPKltoaXErmVVFdf4gvZUsNNh03YeJaDkJUIbvC5ECdStjkL38EMkd0=
X-Received: by 2002:a25:df82:: with SMTP id w124mr49725ybg.347.1606870035133;
 Tue, 01 Dec 2020 16:47:15 -0800 (PST)
MIME-Version: 1.0
References: <20201126165748.1748417-1-revest@google.com> <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
 <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
In-Reply-To: <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Dec 2020 16:47:04 -0800
Message-ID: <CAEf4BzZsG+6VNwBxLfnycjeQinZwMka+gqawBdQMEuvTSfWhsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
To:     KP Singh <kpsingh@chromium.org>
Cc:     Yonghong Song <yhs@fb.com>, Florent Revest <revest@chromium.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 27, 2020 at 3:20 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On Fri, Nov 27, 2020 at 8:35 AM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 11/26/20 8:57 AM, Florent Revest wrote:
> > > This helper exposes the kallsyms_lookup function to eBPF tracing
> > > programs. This can be used to retrieve the name of the symbol at an
> > > address. For example, when hooking into nf_register_net_hook, one can
> > > audit the name of the registered netfilter hook and potentially also
> > > the name of the module in which the symbol is located.
> > >
> > > Signed-off-by: Florent Revest <revest@google.com>
> > > ---
> > >   include/uapi/linux/bpf.h       | 16 +++++++++++++
> > >   kernel/trace/bpf_trace.c       | 41 ++++++++++++++++++++++++++++++++++
> > >   tools/include/uapi/linux/bpf.h | 16 +++++++++++++
> > >   3 files changed, 73 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index c3458ec1f30a..670998635eac 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -3817,6 +3817,21 @@ union bpf_attr {
> > >    *          The **hash_algo** is returned on success,
> > >    *          **-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
> > >    *          invalid arguments are passed.
> > > + *
> > > + * long bpf_kallsyms_lookup(u64 address, char *symbol, u32 symbol_size, char *module, u32 module_size)
> > > + *   Description
> > > + *           Uses kallsyms to write the name of the symbol at *address*
> > > + *           into *symbol* of size *symbol_sz*. This is guaranteed to be
> > > + *           zero terminated.
> > > + *           If the symbol is in a module, up to *module_size* bytes of
> > > + *           the module name is written in *module*. This is also
> > > + *           guaranteed to be zero-terminated. Note: a module name
> > > + *           is always shorter than 64 bytes.
> > > + *   Return
> > > + *           On success, the strictly positive length of the full symbol
> > > + *           name, If this is greater than *symbol_size*, the written
> > > + *           symbol is truncated.
> > > + *           On error, a negative value.
> > >    */
> > >   #define __BPF_FUNC_MAPPER(FN)               \
> > >       FN(unspec),                     \
> > > @@ -3981,6 +3996,7 @@ union bpf_attr {
> > >       FN(bprm_opts_set),              \
> > >       FN(ktime_get_coarse_ns),        \
> > >       FN(ima_inode_hash),             \
> > > +     FN(kallsyms_lookup),    \
> > >       /* */
> > >
> > >   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index d255bc9b2bfa..9d86e20c2b13 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -17,6 +17,7 @@
> > >   #include <linux/error-injection.h>
> > >   #include <linux/btf_ids.h>
> > >   #include <linux/bpf_lsm.h>
> > > +#include <linux/kallsyms.h>
> > >
> > >   #include <net/bpf_sk_storage.h>
> > >
> > > @@ -1260,6 +1261,44 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
> > >       .arg5_type      = ARG_ANYTHING,
> > >   };
> > >
> > > +BPF_CALL_5(bpf_kallsyms_lookup, u64, address, char *, symbol, u32, symbol_size,
> > > +        char *, module, u32, module_size)
> > > +{
> > > +     char buffer[KSYM_SYMBOL_LEN];
> > > +     unsigned long offset, size;
> > > +     const char *name;
> > > +     char *modname;
> > > +     long ret;
> > > +
> > > +     name = kallsyms_lookup(address, &size, &offset, &modname, buffer);
> > > +     if (!name)
> > > +             return -EINVAL;
> > > +
> > > +     ret = strlen(name) + 1;
> > > +     if (symbol_size) {
> > > +             strncpy(symbol, name, symbol_size);
> > > +             symbol[symbol_size - 1] = '\0';
> > > +     }
> > > +
> > > +     if (modname && module_size) {
> > > +             strncpy(module, modname, module_size);
> > > +             module[module_size - 1] = '\0';
> >
> > In this case, module name may be truncated and user did not get any
> > indication from return value. In the helper description, it is mentioned
> > that module name currently is most 64 bytes. But from UAPI perspective,
> > it may be still good to return something to let user know the name
> > is truncated.
> >
> > I do not know what is the best way to do this. One suggestion is
> > to break it into two helpers, one for symbol name and another
>
> I think it would be slightly preferable to have one helper though.
> maybe something like bpf_get_symbol_info (better names anyone? :))

bpf_ksym_resolve()?

> with flags to get the module name or the symbol name depending
> on the flag?
>
> > for module name. What is the use cases people want to get both
> > symbol name and module name and is it common?
>
> The use case would be to disambiguate symbols in the
> kernel from the ones from a kernel module. Similar to what
> /proc/kallsyms does:
>
> T cpufreq_gov_powersave_init [cpufreq_powersave]
>
> >
> > > +     }
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +const struct bpf_func_proto bpf_kallsyms_lookup_proto = {
> > > +     .func           = bpf_kallsyms_lookup,
> > > +     .gpl_only       = false,
> > > +     .ret_type       = RET_INTEGER,
> > > +     .arg1_type      = ARG_ANYTHING,
> > > +     .arg2_type      = ARG_PTR_TO_MEM,
> > ARG_PTR_TO_UNINIT_MEM?
> >
> > > +     .arg3_type      = ARG_CONST_SIZE,
> > ARG_CONST_SIZE_OR_ZERO? This is especially true for current format
> > which tries to return both symbol name and module name and
> > user may just want to do one of them.
> >
> > > +     .arg4_type      = ARG_PTR_TO_MEM,
> > ARG_PTR_TO_UNINIT_MEM?
> >
> > > +     .arg5_type      = ARG_CONST_SIZE,
> > ARG_CONST_SIZE_OR_ZERO?
> >
> > > +};
> > > +
> > >   const struct bpf_func_proto *
> > >   bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> > >   {
> > > @@ -1356,6 +1395,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> > >               return &bpf_per_cpu_ptr_proto;
> > >       case BPF_FUNC_bpf_this_cpu_ptr:
> > >               return &bpf_this_cpu_ptr_proto;
> > > +     case BPF_FUNC_kallsyms_lookup:
> > > +             return &bpf_kallsyms_lookup_proto;
> > >       default:
> > >               return NULL;
> > >       }
> > [...]
