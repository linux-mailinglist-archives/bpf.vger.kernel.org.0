Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9578433D4B8
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 14:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhCPNS4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 09:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCPNSa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 09:18:30 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6D8C061756
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 06:18:29 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id n14so37104675iog.3
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nq/YXeDMQzjYRDwyU4aw5HetphWHUiqNcVSl9vs9s7I=;
        b=JS8/G1DoX8Ji0DmVqUtmgzwdWPUVYyXrGxetZvwqIQaTQ3+j82u9/66F559BT3P/+6
         04VXvk6GnY3JC6H2W2pwa4ps0PV4RdOBquiPxCrKmgNnRuzZaK9pU18/RVu4zCt9WdbY
         jOdRWGz2NwICFUxZh09emszO7X9nfIkmKeUBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nq/YXeDMQzjYRDwyU4aw5HetphWHUiqNcVSl9vs9s7I=;
        b=PG3fC/5fqBgA8iyNRLbDk0yQERhI7QNn+g6pfSr9XFogP67AKOAxEDn68kF7CKe0D2
         FTcNR9yYeaU7oAAPQitUxmozd+t7JQZg06BEhnCSzaMRUmXjbiLpxTvcYLiQo5eQjxrC
         IcaZiqRgp+ItxMpHKbQ9otBs0ToaXO3Wo0gcJYLgwoBGfCrc64P7uPpKXO+38I8YlKJf
         cOEkmd6X6WlQYx717HdDCiTePxF8t72J+DawD33brr6OO0aPUvDHlnG2Szb92sk1aSde
         ckhz60g5pkvzpH50xmvKEa5uiXQ5mrat84V/RPi1qKcCyuKjfShmy6gqd8Gu6rVbYvOJ
         9B5A==
X-Gm-Message-State: AOAM532BqFTJGx21QEqcEiyxTPxQMwxDzLbgTCIsAS2mcymb0mQ0Dw6g
        7BLVnBw7LJwZlHoEQrT9RvCvr3H4w0BNmICx9uqVZQ==
X-Google-Smtp-Source: ABdhPJzNFYHM3R0JKFKOWQ3OVQc0CGrsmnHshue3a72FycqeRFuCUDIEyilvEMoEVnaKCvH/DjrauvkRBtv8bO5/Tc8=
X-Received: by 2002:a02:662b:: with SMTP id k43mr10311013jac.139.1615900708605;
 Tue, 16 Mar 2021 06:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210310220211.1454516-1-revest@chromium.org> <20210310220211.1454516-3-revest@chromium.org>
 <CAEf4BzZ+vxVA4ed8xEfHdt=XVn7h8tuHy2czABskG0pgiAjooQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZ+vxVA4ed8xEfHdt=XVn7h8tuHy2czABskG0pgiAjooQ@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 16 Mar 2021 14:18:17 +0100
Message-ID: <CABRcYmKznSNZCqVhVZ8qGJsLySNKOFC7-d7s_=eD+=w_Q03dgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Add a bpf_snprintf helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 16, 2021 at 2:25 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 10, 2021 at 2:02 PM Florent Revest <revest@chromium.org> wrote:
> >
> > The implementation takes inspiration from the existing bpf_trace_printk
> > helper but there are a few differences:
> >
> > To allow for a large number of format-specifiers, parameters are
> > provided in an array, like in bpf_seq_printf.
> >
> > Because the output string takes two arguments and the array of
> > parameters also takes two arguments, the format string needs to fit in
> > one argument. But because ARG_PTR_TO_CONST_STR guarantees to point to a
> > NULL-terminated read-only map, we don't need a format string length arg.
> >
> > Because the format-string is known at verification time, we also move
> > most of the format string validation, currently done in formatting
> > helper calls, into the verifier logic. This makes debugging easier and
> > also slightly improves the runtime performance.
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
> >  include/linux/bpf.h            |   4 +
> >  include/uapi/linux/bpf.h       |  28 +++++++
> >  kernel/bpf/verifier.c          | 137 +++++++++++++++++++++++++++++++++
> >  kernel/trace/bpf_trace.c       | 110 ++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  28 +++++++
> >  5 files changed, 307 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 7b5319d75b3e..d78175c9a887 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1902,6 +1902,10 @@ extern const struct bpf_func_proto bpf_task_storage_get_proto;
> >  extern const struct bpf_func_proto bpf_task_storage_delete_proto;
> >  extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
> >
> > +#define MAX_SNPRINTF_VARARGS           12
> > +#define MAX_SNPRINTF_MEMCPY            6
> > +#define MAX_SNPRINTF_STR_LEN           128
> > +
> >  const struct bpf_func_proto *bpf_tracing_func_proto(
> >         enum bpf_func_id func_id, const struct bpf_prog *prog);
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 2d3036e292a9..3cbdc8ae00e7 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -4660,6 +4660,33 @@ union bpf_attr {
> >   *     Return
> >   *             The number of traversed map elements for success, **-EINVAL** for
> >   *             invalid **flags**.
> > + *
> > + * long bpf_snprintf(char *out, u32 out_size, const char *fmt, u64 *data, u32 data_len)
>
> bpf_snprintf_btf calls out and out_size str and str_size, let's be consistent?
>
> > + *     Description
> > + *             Outputs a string into the **out** buffer of size **out_size**
> > + *             based on a format string stored in a read-only map pointed by
> > + *             **fmt**.
> > + *
> > + *             Each format specifier in **fmt** corresponds to one u64 element
> > + *             in the **data** array. For strings and pointers where pointees
> > + *             are accessed, only the pointer values are stored in the *data*
> > + *             array. The *data_len* is the size of *data* in bytes.
> > + *
> > + *             Formats **%s** and **%p{i,I}{4,6}** require to read kernel
> > + *             memory. Reading kernel memory may fail due to either invalid
> > + *             address or valid address but requiring a major memory fault. If
> > + *             reading kernel memory fails, the string for **%s** will be an
> > + *             empty string, and the ip address for **%p{i,I}{4,6}** will be 0.
> > + *             Not returning error to bpf program is consistent with what
> > + *             **bpf_trace_printk**\ () does for now.
> > + *
> > + *     Return
> > + *             The strictly positive length of the printed string, including
> > + *             the trailing NUL character. If the return value is greater than
> > + *             **out_size**, **out** contains a truncated string, without a
> > + *             trailing NULL character.
>
> this deviates from the behavior in other BPF helpers dealing with
> strings. and it's extremely inconvenient for users to get
> non-zero-terminated string. I think we should always zero-terminate.
>
> > + *
> > + *             Or **-EBUSY** if the per-CPU memory copy buffer is busy.
> >   */
> >  #define __BPF_FUNC_MAPPER(FN)          \
> >         FN(unspec),                     \
> > @@ -4827,6 +4854,7 @@ union bpf_attr {
> >         FN(sock_from_file),             \
> >         FN(check_mtu),                  \
> >         FN(for_each_map_elem),          \
> > +       FN(snprintf),                   \
> >         /* */
> >
> >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c99b2b67dc8d..3ab549df817b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5732,6 +5732,137 @@ static int check_reference_leak(struct bpf_verifier_env *env)
> >         return state->acquired_refs ? -EINVAL : 0;
> >  }
> >
> > +int check_bpf_snprintf_call(struct bpf_verifier_env *env,
> > +                           struct bpf_reg_state *regs)
> > +{
>
> can we please extra the printf format string parsing/checking logic
> and re-use them across all functions? We now have at least 4 variants
> of it, it's not great to say the least. I hope it's possible to
> generalize it in such a way that the same function will parse the
> string, and will record each expected argument and it's type, with
> whatever extra flags we need to. That should make the printing part
> simpler as well, as it will just follow "directions" from the parsing
> part? Devil is in the details, of course :) But it's worthwhile to try
> at least.

Eheh this is gonna be fun, I'll try it out and see if I can come up
with something ~decent. :)

Thanks for the thorough review! I agree with all your points and will
address them in v2.

> > +       struct bpf_reg_state *fmt_reg = &regs[BPF_REG_3];
> > +       struct bpf_reg_state *data_len_reg = &regs[BPF_REG_5];
> > +       struct bpf_map *fmt_map = fmt_reg->map_ptr;
> > +       int err, fmt_map_off, i, fmt_cnt = 0, memcpy_cnt = 0, num_args;
> > +       u64 fmt_addr;
> > +       char *fmt;
> > +
> > +       /* data must be an array of u64 so data_len must be a multiple of 8 */
> > +       if (data_len_reg->var_off.value & 7)
> > +               return -EINVAL;
> > +       num_args = data_len_reg->var_off.value / 8;
> > +
> > +       /* fmt being ARG_PTR_TO_CONST_STR guarantees that var_off is const
> > +        * and map_direct_value_addr is set.
> > +        */
> > +       fmt_map_off = fmt_reg->off + fmt_reg->var_off.value;
> > +       err = fmt_map->ops->map_direct_value_addr(fmt_map, &fmt_addr,
> > +                                                 fmt_map_off);
> > +       if (err)
> > +               return err;
> > +       fmt = (char *)fmt_addr;
> > +
>
> [...] not fun to read this part over and over :)
>
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >                              int *insn_idx_p)
> >  {
> > @@ -5846,6 +5977,12 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >                         return -EINVAL;
> >         }
> >
> > +       if (func_id == BPF_FUNC_snprintf) {
> > +               err = check_bpf_snprintf_call(env, regs);
> > +               if (err < 0)
> > +                       return err;
> > +       }
> > +
> >         /* reset caller saved regs */
> >         for (i = 0; i < CALLER_SAVED_REGS; i++) {
> >                 mark_reg_not_init(env, regs, caller_saved[i]);
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 0d23755c2747..7b80759c10a9 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1271,6 +1271,114 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
> >         .arg5_type      = ARG_ANYTHING,
> >  };
> >
> > +struct bpf_snprintf_buf {
> > +       char buf[MAX_SNPRINTF_MEMCPY][MAX_SNPRINTF_STR_LEN];
> > +};
> > +static DEFINE_PER_CPU(struct bpf_snprintf_buf, bpf_snprintf_buf);
> > +static DEFINE_PER_CPU(int, bpf_snprintf_buf_used);
> > +
> > +BPF_CALL_5(bpf_snprintf, char *, out, u32, out_size, char *, fmt, u64 *, args,
> > +          u32, args_len)
> > +{
> > +       int err, i, buf_used, copy_size, fmt_cnt = 0, memcpy_cnt = 0;
> > +       u64 params[MAX_SNPRINTF_VARARGS];
> > +       struct bpf_snprintf_buf *bufs;
> > +
> > +       buf_used = this_cpu_inc_return(bpf_snprintf_buf_used);
> > +       if (WARN_ON_ONCE(buf_used > 1)) {
> > +               err = -EBUSY;
> > +               goto out;
> > +       }
> > +
> > +       bufs = this_cpu_ptr(&bpf_snprintf_buf);
> > +
> > +       /*
> > +        * The verifier has already done most of the heavy-work for us in
> > +        * check_bpf_snprintf_call. We know that fmt is well formatted and that
> > +        * args_len is valid. The only task left is to convert some of the
> > +        * arguments. For the %s and %pi* specifiers, we need to read buffers
> > +        * from a kernel address during the helper call.
> > +        */
> > +       for (i = 0; fmt[i] != '\0'; i++) {
>
> same function should hopefully be reused here
>
> > +       }
> > +
> > +       /* Maximumly we can have MAX_SNPRINTF_VARARGS parameters, just give
> > +        * all of them to snprintf().
> > +        */
> > +       err = snprintf(out, out_size, fmt, params[0], params[1], params[2],
> > +                      params[3], params[4], params[5], params[6], params[7],
> > +                      params[8], params[9], params[10], params[11]) + 1;
> > +
> > +out:
> > +       this_cpu_dec(bpf_snprintf_buf_used);
> > +       return err;
> > +}
> > +
> > +static const struct bpf_func_proto bpf_snprintf_proto = {
> > +       .func           = bpf_snprintf,
> > +       .gpl_only       = true,
> > +       .ret_type       = RET_INTEGER,
> > +       .arg1_type      = ARG_PTR_TO_MEM,
> > +       .arg2_type      = ARG_CONST_SIZE,
>
> can we mark is CONST_SIZE_OR_ZERO and just do nothing on zero at
> runtime? I still have scars from having to deal (prove, actually) with
> ARG_CONST_SIZE (> 0) limitations in perf_event_output. No need to make
> anyone's life harder, if it's easy to just do something sensible on
> zero (i.e., do nothing, but emit desired amount of bytes).
>
> > +       .arg3_type      = ARG_PTR_TO_CONST_STR,
> > +       .arg4_type      = ARG_PTR_TO_MEM,
> > +       .arg5_type      = ARG_CONST_SIZE_OR_ZERO,
> > +};
> > +
> >  const struct bpf_func_proto *
> >  bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >  {
> > @@ -1373,6 +1481,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >                 return &bpf_task_storage_delete_proto;
> >         case BPF_FUNC_for_each_map_elem:
> >                 return &bpf_for_each_map_elem_proto;
> > +       case BPF_FUNC_snprintf:
> > +               return &bpf_snprintf_proto;
>
> why just tracing? can't all BPF programs use this functionality?
>
> >         default:
> >                 return NULL;
> >         }
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index 2d3036e292a9..3cbdc8ae00e7 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -4660,6 +4660,33 @@ union bpf_attr {
> >   *     Return
> >   *             The number of traversed map elements for success, **-EINVAL** for
> >   *             invalid **flags**.
> > + *
> > + * long bpf_snprintf(char *out, u32 out_size, const char *fmt, u64 *data, u32 data_len)
> > + *     Description
> > + *             Outputs a string into the **out** buffer of size **out_size**
> > + *             based on a format string stored in a read-only map pointed by
> > + *             **fmt**.
> > + *
> > + *             Each format specifier in **fmt** corresponds to one u64 element
> > + *             in the **data** array. For strings and pointers where pointees
> > + *             are accessed, only the pointer values are stored in the *data*
> > + *             array. The *data_len* is the size of *data* in bytes.
> > + *
> > + *             Formats **%s** and **%p{i,I}{4,6}** require to read kernel
> > + *             memory. Reading kernel memory may fail due to either invalid
> > + *             address or valid address but requiring a major memory fault. If
> > + *             reading kernel memory fails, the string for **%s** will be an
> > + *             empty string, and the ip address for **%p{i,I}{4,6}** will be 0.
> > + *             Not returning error to bpf program is consistent with what
> > + *             **bpf_trace_printk**\ () does for now.
> > + *
> > + *     Return
> > + *             The strictly positive length of the printed string, including
> > + *             the trailing NUL character. If the return value is greater than
> > + *             **out_size**, **out** contains a truncated string, without a
> > + *             trailing NULL character.
> > + *
> > + *             Or **-EBUSY** if the per-CPU memory copy buffer is busy.
> >   */
> >  #define __BPF_FUNC_MAPPER(FN)          \
> >         FN(unspec),                     \
> > @@ -4827,6 +4854,7 @@ union bpf_attr {
> >         FN(sock_from_file),             \
> >         FN(check_mtu),                  \
> >         FN(for_each_map_elem),          \
> > +       FN(snprintf),                   \
> >         /* */
> >
> >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > --
> > 2.30.1.766.gb4fecdf3b7-goog
> >
