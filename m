Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5222535F103
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 11:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbhDNJrL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 05:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbhDNJrK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 05:47:10 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5BBC061574
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 02:46:49 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id v123so13187261ioe.10
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 02:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QSY+YF0ygYiG1EiJZskRZOjnmmttz2RNZ0RIR9uNbSI=;
        b=k7ieuvix8d6RycI66YKCN8yW4dVTY36rKSS/XWuHxyv0q5bdN0h1ICUXSNyrvs4F3o
         +Xyv5f/8HrExwKjEwsVFfcgbKVSYiqSM6jf3ftSqntLpKcSmyrKOmbNcgHlfkC7VC2B5
         qTKlt2g5WLJo98c3Bm+C1av3VrY3wE0hfPcNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSY+YF0ygYiG1EiJZskRZOjnmmttz2RNZ0RIR9uNbSI=;
        b=kXrGhQfruwchhE+UlItRn9giYEsGguWG3oZt4Nz+RA3bS+UINB+La04/03yQcI/FI6
         nWZ7bGjjar/8zMzHxo6sfXoppA8gm9uXdgc0hEDoVrrN8sHjbA3mQNtruKk6/wN/PxdT
         qG+JDgmV5xMnYYnDf6XFufm5GicAjhW6mvLPykOCmqrP5VvRdNJuNYNkfHER9rU6o10z
         9Lwz82svBrBdJatWilxClHvPVcbbBXth/W3RR/43+5CZKsu1SQxT6BGM28gEMHxmczpa
         djAYeEFpCFIBue/E/aLqSCLN+CMPvgHE7+LEbB4tOXHeTz0V7Gm5oYA4sU/uoRrjSmor
         0uRQ==
X-Gm-Message-State: AOAM532S0Jp6V4BVqEQjjrQSBADT7cgUWjQdSAbYckxundodZLE1CFd7
        tJlk58fMCAs+wfzzp27mu7VXVZmAH0okWnUuEk4wLg==
X-Google-Smtp-Source: ABdhPJzPixnojwlN8XP8k88cP6u03RzsNaQL6/YxmSt+0RNWzwVpls932y0asMJtoxu14QXvEPsckB3We2i+WUq90JU=
X-Received: by 2002:a02:cf16:: with SMTP id q22mr25911665jar.32.1618393609117;
 Wed, 14 Apr 2021 02:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-4-revest@chromium.org>
 <CAEf4BzZCR2JMXwNvJikfWYnZa-CyCQTQsW+Xs_5w9zOT3kbVSA@mail.gmail.com>
In-Reply-To: <CAEf4BzZCR2JMXwNvJikfWYnZa-CyCQTQsW+Xs_5w9zOT3kbVSA@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 14 Apr 2021 11:46:38 +0200
Message-ID: <CABRcYmJvzcFySYS=U=xtfn4eG7yKpmET_yh-bZYrkYfJMdx_pw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Add a bpf_snprintf helper
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

On Wed, Apr 14, 2021 at 1:16 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
> > +static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
> > +                                  struct bpf_reg_state *regs)
> > +{
> > +       struct bpf_reg_state *fmt_reg = &regs[BPF_REG_3];
> > +       struct bpf_reg_state *data_len_reg = &regs[BPF_REG_5];
> > +       struct bpf_map *fmt_map = fmt_reg->map_ptr;
> > +       int err, fmt_map_off, num_args;
> > +       u64 fmt_addr;
> > +       char *fmt;
> > +
> > +       /* data must be an array of u64 */
> > +       if (data_len_reg->var_off.value % 8)
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
> > +       fmt = (char *)fmt_addr + fmt_map_off;
> > +
>
> bot complained about lack of (long) cast before fmt_addr, please address

Will do.

> > +       /* Maximumly we can have MAX_SNPRINTF_VARARGS parameters, just give
> > +        * all of them to snprintf().
> > +        */
> > +       err = snprintf(str, str_size, fmt, BPF_CAST_FMT_ARG(0, args, mod),
> > +               BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod),
> > +               BPF_CAST_FMT_ARG(3, args, mod), BPF_CAST_FMT_ARG(4, args, mod),
> > +               BPF_CAST_FMT_ARG(5, args, mod), BPF_CAST_FMT_ARG(6, args, mod),
> > +               BPF_CAST_FMT_ARG(7, args, mod), BPF_CAST_FMT_ARG(8, args, mod),
> > +               BPF_CAST_FMT_ARG(9, args, mod), BPF_CAST_FMT_ARG(10, args, mod),
> > +               BPF_CAST_FMT_ARG(11, args, mod));
> > +
> > +       put_fmt_tmp_buf();
>
> reading this for at least 3rd time, this put_fmt_tmp_buf() looks a bit
> out of place and kind of random. I think bpf_printf_cleanup() name
> pairs with bpf_printf_prepare() better.

Yes, I thought it would be clever to name that function
put_fmt_tmp_buf() as a clear parallel to try_get_fmt_tmp_buf() but
because it only puts the buffer if it is used and because they get
called in two different contexts, it's after all maybe not such a
clever name... I'll revert to bpf_printf_cleanup(). Thank you for your
patience with my naming adventures! :)

> > +
> > +       return err + 1;
>
> snprintf() already returns string length *including* terminating zero,
> so this is wrong

lib/vsprintf.c says:
 * The return value is the number of characters which would be
 * generated for the given input, excluding the trailing null,
 * as per ISO C99.

Also if I look at the "no arg" test case in the selftest patch.
"simple case" is asserted to return 12 which seems correct to me
(includes the terminating zero only once). Am I missing something ?

However that makes me wonder whether it would be more appropriate to
return the value excluding the trailing null. On one hand it makes
sense to be coherent with other BPF helpers that include the trailing
zero (as discussed in patch v1), on the other hand the helper is
clearly named after the standard "snprintf" function and it's likely
that users will assume it works the same as the std snprintf.
