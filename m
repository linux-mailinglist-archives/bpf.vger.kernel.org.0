Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1EE2CB1DE
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 01:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgLBA4H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 19:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgLBA4G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 19:56:06 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DBAC0613CF;
        Tue,  1 Dec 2020 16:55:26 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id x2so55322ybt.11;
        Tue, 01 Dec 2020 16:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtOPT5jltF4CVLDPPnaNo7rmidfqmNUIx0/PN3QHp2M=;
        b=WX2myt5gM6vWrdPHfVZHnVP4VShRjz+ZY0kRNBqShcXt/1eQKKmOuPujmMidioy82B
         4hfV0WwyLVVUP0Yseh2c8kNFn2qrlnuk1uhWr9zLBis2L0De+Bmx8hfxwEVObnRni1aS
         r2hNM3ceWCmPk5tH8rhWgbBhRwZMkxnThAha/ZS1gYyA9nKFavZUMhE6WWHZoxIb9+B9
         Crq4+PdCqp+4mbhMaKy24NHz/6bVgED4je7m7KaRmXepzhT17hRxWZa26UBq6hUynj8G
         W+VVXKRYUdz/1le4cN52vuGrB6USdgSgycSDr7O2WE/iYaSdX8ND2B6YhbF/cp7BH725
         9/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtOPT5jltF4CVLDPPnaNo7rmidfqmNUIx0/PN3QHp2M=;
        b=hfTheSJDOPragEXHOb9lP42djH5/sX4ISc96nz69DPDgUtriGVBJIMxybTlqsEQzpV
         0HPvzOSsEne0HwBshO2TrkHA8WpQ2ol74SbZ7nHPfUpUFODTwnjMURh0zxngT7JoE/8+
         GzYz7m4E9h5kWpVdOfbc7VtHsI04yTlmXz9uHVsmhCuHGES2B3vaoRXQA/ZfTZ9yy57V
         8WrOD+TosPY4pVTJ1/yZvy/0Jcc+1IXqZkAZeT2wfOrztYKKi2Xe0YmXmTGGOstA3Prr
         58bxCmUFS90gf8S4jgw6+oSnZxz7DrDND3QPYMya9zBGlaCQstmdT+Jxm1/kE9UgvjRr
         6DqQ==
X-Gm-Message-State: AOAM532l1v1B4YAywDC4xQPHrj6FgcP6oDnsCwAR9tMjBdTSwluK6hNC
        qEk2cxP2HZ89+bn2uh1M+Bh/Ew2db2v1krRjgW8=
X-Google-Smtp-Source: ABdhPJy3gBFqXQtWj/HvRoosWfu+pAZZ88j+2BESAL0eQjvgm9bkfHfcwH4ZasTnZnuy3OBgcSh8UuRhF7VUaxFgU/8=
X-Received: by 2002:a25:df82:: with SMTP id w124mr87572ybg.347.1606870525716;
 Tue, 01 Dec 2020 16:55:25 -0800 (PST)
MIME-Version: 1.0
References: <20201126165748.1748417-1-revest@google.com> <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
 <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com> <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com>
In-Reply-To: <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Dec 2020 16:55:14 -0800
Message-ID: <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
To:     Yonghong Song <yhs@fb.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 27, 2020 at 8:09 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/27/20 3:20 AM, KP Singh wrote:
> > On Fri, Nov 27, 2020 at 8:35 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 11/26/20 8:57 AM, Florent Revest wrote:
> >>> This helper exposes the kallsyms_lookup function to eBPF tracing
> >>> programs. This can be used to retrieve the name of the symbol at an
> >>> address. For example, when hooking into nf_register_net_hook, one can
> >>> audit the name of the registered netfilter hook and potentially also
> >>> the name of the module in which the symbol is located.
> >>>
> >>> Signed-off-by: Florent Revest <revest@google.com>
> >>> ---
> >>>    include/uapi/linux/bpf.h       | 16 +++++++++++++
> >>>    kernel/trace/bpf_trace.c       | 41 ++++++++++++++++++++++++++++++++++
> >>>    tools/include/uapi/linux/bpf.h | 16 +++++++++++++
> >>>    3 files changed, 73 insertions(+)
> >>>
> >>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >>> index c3458ec1f30a..670998635eac 100644
> >>> --- a/include/uapi/linux/bpf.h
> >>> +++ b/include/uapi/linux/bpf.h
> >>> @@ -3817,6 +3817,21 @@ union bpf_attr {
> >>>     *          The **hash_algo** is returned on success,
> >>>     *          **-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
> >>>     *          invalid arguments are passed.
> >>> + *
> >>> + * long bpf_kallsyms_lookup(u64 address, char *symbol, u32 symbol_size, char *module, u32 module_size)
> >>> + *   Description
> >>> + *           Uses kallsyms to write the name of the symbol at *address*
> >>> + *           into *symbol* of size *symbol_sz*. This is guaranteed to be
> >>> + *           zero terminated.
> >>> + *           If the symbol is in a module, up to *module_size* bytes of
> >>> + *           the module name is written in *module*. This is also
> >>> + *           guaranteed to be zero-terminated. Note: a module name
> >>> + *           is always shorter than 64 bytes.
> >>> + *   Return
> >>> + *           On success, the strictly positive length of the full symbol
> >>> + *           name, If this is greater than *symbol_size*, the written
> >>> + *           symbol is truncated.
> >>> + *           On error, a negative value.
> >>>     */
> >>>    #define __BPF_FUNC_MAPPER(FN)               \
> >>>        FN(unspec),                     \
> >>> @@ -3981,6 +3996,7 @@ union bpf_attr {
> >>>        FN(bprm_opts_set),              \
> >>>        FN(ktime_get_coarse_ns),        \
> >>>        FN(ima_inode_hash),             \
> >>> +     FN(kallsyms_lookup),    \
> >>>        /* */
> >>>
> >>>    /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> >>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >>> index d255bc9b2bfa..9d86e20c2b13 100644
> >>> --- a/kernel/trace/bpf_trace.c
> >>> +++ b/kernel/trace/bpf_trace.c
> >>> @@ -17,6 +17,7 @@
> >>>    #include <linux/error-injection.h>
> >>>    #include <linux/btf_ids.h>
> >>>    #include <linux/bpf_lsm.h>
> >>> +#include <linux/kallsyms.h>
> >>>
> >>>    #include <net/bpf_sk_storage.h>
> >>>
> >>> @@ -1260,6 +1261,44 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
> >>>        .arg5_type      = ARG_ANYTHING,
> >>>    };
> >>>
> >>> +BPF_CALL_5(bpf_kallsyms_lookup, u64, address, char *, symbol, u32, symbol_size,
> >>> +        char *, module, u32, module_size)
> >>> +{
> >>> +     char buffer[KSYM_SYMBOL_LEN];
> >>> +     unsigned long offset, size;
> >>> +     const char *name;
> >>> +     char *modname;
> >>> +     long ret;
> >>> +
> >>> +     name = kallsyms_lookup(address, &size, &offset, &modname, buffer);
> >>> +     if (!name)
> >>> +             return -EINVAL;
> >>> +
> >>> +     ret = strlen(name) + 1;
> >>> +     if (symbol_size) {
> >>> +             strncpy(symbol, name, symbol_size);
> >>> +             symbol[symbol_size - 1] = '\0';
> >>> +     }
> >>> +
> >>> +     if (modname && module_size) {
> >>> +             strncpy(module, modname, module_size);
> >>> +             module[module_size - 1] = '\0';
> >>
> >> In this case, module name may be truncated and user did not get any
> >> indication from return value. In the helper description, it is mentioned
> >> that module name currently is most 64 bytes. But from UAPI perspective,
> >> it may be still good to return something to let user know the name
> >> is truncated.
> >>
> >> I do not know what is the best way to do this. One suggestion is
> >> to break it into two helpers, one for symbol name and another
> >
> > I think it would be slightly preferable to have one helper though.
> > maybe something like bpf_get_symbol_info (better names anyone? :))
> > with flags to get the module name or the symbol name depending
> > on the flag?
>
> This works even better. Previously I am thinking if we have two helpers,
> we can add flags for each of them for future extension. But we
> can certainly have just one helper with flags to indicate
> whether this is for module name or for symbol name or something else.
>
> The buffer can be something like
>     union bpf_ksymbol_info {
>        char   module_name[];
>        char   symbol_name[];
>        ...
>     }
> and flags will indicate what information user wants.

one more thing that might be useful to resolve to the symbol's "base
address". E.g., if we have IP inside the function, this would resolve
to the start of the function, sort of "canonical" symbol address. Type
of ksym is another "characteristic" which could be returned (as a
single char?)

I wouldn't define bpf_ksymbol_info, though. Just depending on the
flag, specify what kind of memory layou (e.g., for strings -
zero-terminated string, for address - 8 byte numbers, etc). That way
we can also allow fetching multiple things together, they would just
be laid out one after another in memory.

E.g.:

char buf[256];
int err = bpf_ksym_resolve(<addr>, BPF_KSYM_NAME | BPF_KSYM_MODNAME |
BPF_KSYM_BASE_ADDR, buf, sizeof(buf));

if (err == -E2BIG)
  /* need bigger buffer, but all the data up to truncation point is filled in */
else
  /* err has exact number of bytes used, including zero terminator(s) */
  /* data is laid out as
"cpufreq_gov_powersave_init\0cpufreq_powersave\0\x12\x23\x45\x56\x12\x23\x45\x56"
*/


>
> >
> >> for module name. What is the use cases people want to get both
> >> symbol name and module name and is it common?
> >
> > The use case would be to disambiguate symbols in the
> > kernel from the ones from a kernel module. Similar to what
> > /proc/kallsyms does:
> >
> > T cpufreq_gov_powersave_init [cpufreq_powersave]
> >
> >>
> >>> +     }
> >>> +
> >>> +     return ret;
> >>> +}
> >>> +
> >>> +const struct bpf_func_proto bpf_kallsyms_lookup_proto = {
> >>> +     .func           = bpf_kallsyms_lookup,
> >>> +     .gpl_only       = false,
> >>> +     .ret_type       = RET_INTEGER,
> >>> +     .arg1_type      = ARG_ANYTHING,
> >>> +     .arg2_type      = ARG_PTR_TO_MEM,
> >> ARG_PTR_TO_UNINIT_MEM?
> >>
> >>> +     .arg3_type      = ARG_CONST_SIZE,
> >> ARG_CONST_SIZE_OR_ZERO? This is especially true for current format
> >> which tries to return both symbol name and module name and
> >> user may just want to do one of them.
> >>
> >>> +     .arg4_type      = ARG_PTR_TO_MEM,
> >> ARG_PTR_TO_UNINIT_MEM?
> >>
> >>> +     .arg5_type      = ARG_CONST_SIZE,
> >> ARG_CONST_SIZE_OR_ZERO?
> >>
> >>> +};
> >>> +
> >>>    const struct bpf_func_proto *
> >>>    bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >>>    {
> >>> @@ -1356,6 +1395,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >>>                return &bpf_per_cpu_ptr_proto;
> >>>        case BPF_FUNC_bpf_this_cpu_ptr:
> >>>                return &bpf_this_cpu_ptr_proto;
> >>> +     case BPF_FUNC_kallsyms_lookup:
> >>> +             return &bpf_kallsyms_lookup_proto;
> >>>        default:
> >>>                return NULL;
> >>>        }
> >> [...]
