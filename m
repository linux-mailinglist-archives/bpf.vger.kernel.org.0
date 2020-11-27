Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150482C63C6
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 12:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgK0LUN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 06:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgK0LUN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Nov 2020 06:20:13 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4B8C0613D1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 03:20:12 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id y16so5571253ljk.1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 03:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gx/sfWK7RQOwUhoWCcsjhmPBNWJ/nVv9as+ArKz2/0k=;
        b=LpxDn9xb1o6vIwYbn0D7fOmklaeebC5h3J5u9lUnRCxHaOSgkhTx8JhUhFPPhKXna6
         qAnKUmUv9r/Ocbld330pjSYhan9ZrBn90fMswzFFGkxl6YfvZ/V2AWVvIcmLQE8MUVOv
         LKT/FpcvGCujzdg6GhWrQyzZLNI+5W3r10AGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gx/sfWK7RQOwUhoWCcsjhmPBNWJ/nVv9as+ArKz2/0k=;
        b=h9QF93hW2W8L7ydC0UrZrNE85ARMPMK2QVlq/CNy/HjEctycQsRYsG926RrQBo9POm
         zQg/J8VVGbRblnxqugZb3iLebPR2qf34bIGN/Yiff6vX0X/y8kcocuFD+PERbCOE93Yy
         F4qLPxwwYC62HDeSsMt2wF8nKQLO0x5pItcqjYKfltYBhaYRBnzK7A2Nyks+vBxMBGSd
         VTLd6EX59EHuU5sRL3FX13U8ZuKEwGt36eMagFKA+jsiqSzTNEeYLSQDUrpjjlCO3U8O
         7q2SR3341i5yMHSYLNqgMv2Q8tlKSg2/WqXuU0SeX4A81nuOXie5j8T4XXNTjKxwngNf
         +u1A==
X-Gm-Message-State: AOAM531bGf72YKDgvky1/cav3d4nzcS9Zzi2FoeERyFtjftmnF4BC8dw
        C+czWIoVROXIZRb/wK60Jh3ARgwQVNzlvrclb4vXqg==
X-Google-Smtp-Source: ABdhPJyeArwArZ27qJf9UhZoBjPIOa9Awn/z/67I7KPm54UV3qp3Mt5NO+FBE+j9rYIkuGdT9jDKd2FZJyOmZcsrsWA=
X-Received: by 2002:a2e:8e3b:: with SMTP id r27mr3217873ljk.466.1606476011042;
 Fri, 27 Nov 2020 03:20:11 -0800 (PST)
MIME-Version: 1.0
References: <20201126165748.1748417-1-revest@google.com> <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
In-Reply-To: <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 27 Nov 2020 12:20:00 +0100
Message-ID: <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
To:     Yonghong Song <yhs@fb.com>
Cc:     Florent Revest <revest@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 27, 2020 at 8:35 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/26/20 8:57 AM, Florent Revest wrote:
> > This helper exposes the kallsyms_lookup function to eBPF tracing
> > programs. This can be used to retrieve the name of the symbol at an
> > address. For example, when hooking into nf_register_net_hook, one can
> > audit the name of the registered netfilter hook and potentially also
> > the name of the module in which the symbol is located.
> >
> > Signed-off-by: Florent Revest <revest@google.com>
> > ---
> >   include/uapi/linux/bpf.h       | 16 +++++++++++++
> >   kernel/trace/bpf_trace.c       | 41 ++++++++++++++++++++++++++++++++++
> >   tools/include/uapi/linux/bpf.h | 16 +++++++++++++
> >   3 files changed, 73 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index c3458ec1f30a..670998635eac 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -3817,6 +3817,21 @@ union bpf_attr {
> >    *          The **hash_algo** is returned on success,
> >    *          **-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
> >    *          invalid arguments are passed.
> > + *
> > + * long bpf_kallsyms_lookup(u64 address, char *symbol, u32 symbol_size, char *module, u32 module_size)
> > + *   Description
> > + *           Uses kallsyms to write the name of the symbol at *address*
> > + *           into *symbol* of size *symbol_sz*. This is guaranteed to be
> > + *           zero terminated.
> > + *           If the symbol is in a module, up to *module_size* bytes of
> > + *           the module name is written in *module*. This is also
> > + *           guaranteed to be zero-terminated. Note: a module name
> > + *           is always shorter than 64 bytes.
> > + *   Return
> > + *           On success, the strictly positive length of the full symbol
> > + *           name, If this is greater than *symbol_size*, the written
> > + *           symbol is truncated.
> > + *           On error, a negative value.
> >    */
> >   #define __BPF_FUNC_MAPPER(FN)               \
> >       FN(unspec),                     \
> > @@ -3981,6 +3996,7 @@ union bpf_attr {
> >       FN(bprm_opts_set),              \
> >       FN(ktime_get_coarse_ns),        \
> >       FN(ima_inode_hash),             \
> > +     FN(kallsyms_lookup),    \
> >       /* */
> >
> >   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index d255bc9b2bfa..9d86e20c2b13 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -17,6 +17,7 @@
> >   #include <linux/error-injection.h>
> >   #include <linux/btf_ids.h>
> >   #include <linux/bpf_lsm.h>
> > +#include <linux/kallsyms.h>
> >
> >   #include <net/bpf_sk_storage.h>
> >
> > @@ -1260,6 +1261,44 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
> >       .arg5_type      = ARG_ANYTHING,
> >   };
> >
> > +BPF_CALL_5(bpf_kallsyms_lookup, u64, address, char *, symbol, u32, symbol_size,
> > +        char *, module, u32, module_size)
> > +{
> > +     char buffer[KSYM_SYMBOL_LEN];
> > +     unsigned long offset, size;
> > +     const char *name;
> > +     char *modname;
> > +     long ret;
> > +
> > +     name = kallsyms_lookup(address, &size, &offset, &modname, buffer);
> > +     if (!name)
> > +             return -EINVAL;
> > +
> > +     ret = strlen(name) + 1;
> > +     if (symbol_size) {
> > +             strncpy(symbol, name, symbol_size);
> > +             symbol[symbol_size - 1] = '\0';
> > +     }
> > +
> > +     if (modname && module_size) {
> > +             strncpy(module, modname, module_size);
> > +             module[module_size - 1] = '\0';
>
> In this case, module name may be truncated and user did not get any
> indication from return value. In the helper description, it is mentioned
> that module name currently is most 64 bytes. But from UAPI perspective,
> it may be still good to return something to let user know the name
> is truncated.
>
> I do not know what is the best way to do this. One suggestion is
> to break it into two helpers, one for symbol name and another

I think it would be slightly preferable to have one helper though.
maybe something like bpf_get_symbol_info (better names anyone? :))
with flags to get the module name or the symbol name depending
on the flag?

> for module name. What is the use cases people want to get both
> symbol name and module name and is it common?

The use case would be to disambiguate symbols in the
kernel from the ones from a kernel module. Similar to what
/proc/kallsyms does:

T cpufreq_gov_powersave_init [cpufreq_powersave]

>
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +const struct bpf_func_proto bpf_kallsyms_lookup_proto = {
> > +     .func           = bpf_kallsyms_lookup,
> > +     .gpl_only       = false,
> > +     .ret_type       = RET_INTEGER,
> > +     .arg1_type      = ARG_ANYTHING,
> > +     .arg2_type      = ARG_PTR_TO_MEM,
> ARG_PTR_TO_UNINIT_MEM?
>
> > +     .arg3_type      = ARG_CONST_SIZE,
> ARG_CONST_SIZE_OR_ZERO? This is especially true for current format
> which tries to return both symbol name and module name and
> user may just want to do one of them.
>
> > +     .arg4_type      = ARG_PTR_TO_MEM,
> ARG_PTR_TO_UNINIT_MEM?
>
> > +     .arg5_type      = ARG_CONST_SIZE,
> ARG_CONST_SIZE_OR_ZERO?
>
> > +};
> > +
> >   const struct bpf_func_proto *
> >   bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >   {
> > @@ -1356,6 +1395,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >               return &bpf_per_cpu_ptr_proto;
> >       case BPF_FUNC_bpf_this_cpu_ptr:
> >               return &bpf_this_cpu_ptr_proto;
> > +     case BPF_FUNC_kallsyms_lookup:
> > +             return &bpf_kallsyms_lookup_proto;
> >       default:
> >               return NULL;
> >       }
> [...]
