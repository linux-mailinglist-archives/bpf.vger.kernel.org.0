Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F8835FE16
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 00:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhDNW55 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 18:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbhDNW55 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 18:57:57 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9681AC061574;
        Wed, 14 Apr 2021 15:57:33 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 65so23984220ybc.4;
        Wed, 14 Apr 2021 15:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFtXRWOeNut3QLILsCIY8HpJ4Srwebx9VnJDfKrPSOw=;
        b=tdV3Cc3axUyAXlfd05PvgGcSz2G5cCBiLzPV31WD/YZQAWPoQCYZcBacSnX19m8O/V
         n3OYJ4CHd60/41iHCz/yoeEM2Y0v+0sJlCGJ5ShG3u98JKnVmFJOxKURgqXRHRUpr1OW
         3n+C+8vWeGtFjcxWuWtQ1U36EaL5SdXWFpbvlT1ndCB0SsOs/SDJVdOikcyH0Naq6q2r
         9ECFUubEeI8OwW0r3ADD8dUYPHu5pWIFCly8gsYKXcDE/l3k6nInsbq35Y9C8ELLqMCL
         WbJ2NO6CqPb+YQTKAmOMTe5WUcOuVIv1p+rqwPS+j2nDTwJeC4nCJ6lYcv5cTvOQxZCb
         7gZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFtXRWOeNut3QLILsCIY8HpJ4Srwebx9VnJDfKrPSOw=;
        b=sTgDqAmmQQa62KK1/piIEK4EGSFikP+2VZ0AvFpQx6EjiZ0yaZDiY25IHAO6+xHnqg
         rwV9r6+zjpMYtsz2l/KTwyi3pkX4+nkAchocbsdFXQVkTLIYM8/0WbjpPY3O9g4koREg
         GQo/InzRyzjFlJn0Z2LCbdOjB+24nFXfEmDd4PvL3CGm55+/isnIK1b6d6JYkELX7im/
         mk3+1JX75BwaPb2boAE2XagN5f7kGZci91AoUes4dIkh8OTS2/NH0CkGZuEBCcVZyP2w
         YOY23PAE4cTEeceoFyk3ke3435XJSirgUSUua0b4s439Ph79af1dzYt9u9vhKwvpd23Z
         PvvQ==
X-Gm-Message-State: AOAM531NUofCDnvb0kGUaNL+ESzFNPZG+fTSj669WKnMgMXB23qB06T1
        b9l1ov/aPiPtbh72dssrwl58h1ZbNdWiPS5LrYg=
X-Google-Smtp-Source: ABdhPJx0ndauyWN/XJNHKfSXZRGLsNq+d5TRVBgn0UoWYaJlrSGRC35isGrUhWrzEgvvX7QAvgxHGt8aKCuucHKP/I4=
X-Received: by 2002:a25:dc46:: with SMTP id y67mr460314ybe.27.1618441052870;
 Wed, 14 Apr 2021 15:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-4-revest@chromium.org>
 <CAEf4BzZCR2JMXwNvJikfWYnZa-CyCQTQsW+Xs_5w9zOT3kbVSA@mail.gmail.com> <CABRcYmJvzcFySYS=U=xtfn4eG7yKpmET_yh-bZYrkYfJMdx_pw@mail.gmail.com>
In-Reply-To: <CABRcYmJvzcFySYS=U=xtfn4eG7yKpmET_yh-bZYrkYfJMdx_pw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 14 Apr 2021 15:57:21 -0700
Message-ID: <CAEf4Bza+rVCp=G5i97MuuBrTX+o1ZUBn3nzstssoS1KtE4F6vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Add a bpf_snprintf helper
To:     Florent Revest <revest@chromium.org>
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

On Wed, Apr 14, 2021 at 2:46 AM Florent Revest <revest@chromium.org> wrote:
>
> On Wed, Apr 14, 2021 at 1:16 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
> > > +static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
> > > +                                  struct bpf_reg_state *regs)
> > > +{
> > > +       struct bpf_reg_state *fmt_reg = &regs[BPF_REG_3];
> > > +       struct bpf_reg_state *data_len_reg = &regs[BPF_REG_5];
> > > +       struct bpf_map *fmt_map = fmt_reg->map_ptr;
> > > +       int err, fmt_map_off, num_args;
> > > +       u64 fmt_addr;
> > > +       char *fmt;
> > > +
> > > +       /* data must be an array of u64 */
> > > +       if (data_len_reg->var_off.value % 8)
> > > +               return -EINVAL;
> > > +       num_args = data_len_reg->var_off.value / 8;
> > > +
> > > +       /* fmt being ARG_PTR_TO_CONST_STR guarantees that var_off is const
> > > +        * and map_direct_value_addr is set.
> > > +        */
> > > +       fmt_map_off = fmt_reg->off + fmt_reg->var_off.value;
> > > +       err = fmt_map->ops->map_direct_value_addr(fmt_map, &fmt_addr,
> > > +                                                 fmt_map_off);
> > > +       if (err)
> > > +               return err;
> > > +       fmt = (char *)fmt_addr + fmt_map_off;
> > > +
> >
> > bot complained about lack of (long) cast before fmt_addr, please address
>
> Will do.
>
> > > +       /* Maximumly we can have MAX_SNPRINTF_VARARGS parameters, just give
> > > +        * all of them to snprintf().
> > > +        */
> > > +       err = snprintf(str, str_size, fmt, BPF_CAST_FMT_ARG(0, args, mod),
> > > +               BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod),
> > > +               BPF_CAST_FMT_ARG(3, args, mod), BPF_CAST_FMT_ARG(4, args, mod),
> > > +               BPF_CAST_FMT_ARG(5, args, mod), BPF_CAST_FMT_ARG(6, args, mod),
> > > +               BPF_CAST_FMT_ARG(7, args, mod), BPF_CAST_FMT_ARG(8, args, mod),
> > > +               BPF_CAST_FMT_ARG(9, args, mod), BPF_CAST_FMT_ARG(10, args, mod),
> > > +               BPF_CAST_FMT_ARG(11, args, mod));
> > > +
> > > +       put_fmt_tmp_buf();
> >
> > reading this for at least 3rd time, this put_fmt_tmp_buf() looks a bit
> > out of place and kind of random. I think bpf_printf_cleanup() name
> > pairs with bpf_printf_prepare() better.
>
> Yes, I thought it would be clever to name that function
> put_fmt_tmp_buf() as a clear parallel to try_get_fmt_tmp_buf() but
> because it only puts the buffer if it is used and because they get
> called in two different contexts, it's after all maybe not such a
> clever name... I'll revert to bpf_printf_cleanup(). Thank you for your
> patience with my naming adventures! :)
>
> > > +
> > > +       return err + 1;
> >
> > snprintf() already returns string length *including* terminating zero,
> > so this is wrong
>
> lib/vsprintf.c says:
>  * The return value is the number of characters which would be
>  * generated for the given input, excluding the trailing null,
>  * as per ISO C99.
>
> Also if I look at the "no arg" test case in the selftest patch.
> "simple case" is asserted to return 12 which seems correct to me
> (includes the terminating zero only once). Am I missing something ?
>

no, you are right, but that means that bpf_trace_printk is broken, it
doesn't do + 1 (which threw me off here), shall we fix that?

> However that makes me wonder whether it would be more appropriate to
> return the value excluding the trailing null. On one hand it makes
> sense to be coherent with other BPF helpers that include the trailing
> zero (as discussed in patch v1), on the other hand the helper is
> clearly named after the standard "snprintf" function and it's likely
> that users will assume it works the same as the std snprintf.


Having zero included simplifies BPF code tremendously for cases like
bpf_probe_read_str(). So no, let's stick with including zero
terminator in return size.
