Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C543460F0
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 15:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhCWOFO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 10:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhCWOEo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 10:04:44 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82711C061763
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 07:04:43 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id x16so17776471iob.1
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L613jJK9Y9MQSdkmRsnN4WosDeNaUdNOetkIDZY3lwI=;
        b=TiXZSfZU+6IfreDxKNDluvs38HvdeLiu1w7Rt9B0Ei66N4AcTqmKNTO3CZPl2MdWiB
         HDFa5JomF9wLQMqxFaCoKpWzcVzrWgKE9nFd8r+7soWhjK9q3Xk5b8QJI9z2cD8jtpul
         8pXir6584gdCxBTDwe8wACMwUGT/lN46pnBY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L613jJK9Y9MQSdkmRsnN4WosDeNaUdNOetkIDZY3lwI=;
        b=jEPxdYFJNnrosMZQ3uSYSXjhOL3tHBtcbWyIB5ysyZPWH5ILQgwWw6lvJRyW1cl4vQ
         2s3kVG7tCm6X5dYtZQubbFTkghP1lf+4fhSyLFcIIdV4I1iI5WGZCAEk/Zo34tAC4dUJ
         sXyw6Y7Kc9W/Bj8buKK7J7R5RFN8u/FSzHwmBW1a64AopRJLpVcMHnc/f8Gzt8wq4EFq
         CvH3SFeQ7EkLbhSHkcomE4QlmPL+12aBqdDGl2k9b37PsV8SGKp/hTJo3240bX2UPnKc
         bKz7jsNHgxc8SVo0NeFAwFzB/zkKufanuuvDOa8p1KKpTxuiBdjnBRZIRvwutVoToovs
         Fq2g==
X-Gm-Message-State: AOAM531dX52ilKP7+YSqlzz2CqFHFOQZJiFjQ3JBzK+mR9DPkZS2Ox51
        pFslB5A3VxhKrtfsVwGLVY9k0natr1lvPcGNE6U0/w==
X-Google-Smtp-Source: ABdhPJyHTz7xVPnY35PY5HzF/5/wSWhn1Yy5a8g5gQc/37Oy5qWnOzDyDGJ05pemYSkLGXafDr2TTl9PIp9txA4jfMw=
X-Received: by 2002:a02:cb48:: with SMTP id k8mr4656643jap.52.1616508282929;
 Tue, 23 Mar 2021 07:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210310220211.1454516-1-revest@chromium.org> <20210310220211.1454516-3-revest@chromium.org>
 <20210323032137.yv23z25zjz45prvy@ast-mbp>
In-Reply-To: <20210323032137.yv23z25zjz45prvy@ast-mbp>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 23 Mar 2021 15:04:31 +0100
Message-ID: <CABRcYmLPCVxuC7fYSygMQfNj5L5Ji=k3b8o88fxLxgOV_uYoNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Add a bpf_snprintf helper
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Tue, Mar 23, 2021 at 4:21 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 10, 2021 at 11:02:08PM +0100, Florent Revest wrote:
> >
> > +struct bpf_snprintf_buf {
> > +     char buf[MAX_SNPRINTF_MEMCPY][MAX_SNPRINTF_STR_LEN];
> > +};
> > +static DEFINE_PER_CPU(struct bpf_snprintf_buf, bpf_snprintf_buf);
> > +static DEFINE_PER_CPU(int, bpf_snprintf_buf_used);
> > +
> > +BPF_CALL_5(bpf_snprintf, char *, out, u32, out_size, char *, fmt, u64 *, args,
> > +        u32, args_len)
> > +{
> > +     int err, i, buf_used, copy_size, fmt_cnt = 0, memcpy_cnt = 0;
> > +     u64 params[MAX_SNPRINTF_VARARGS];
> > +     struct bpf_snprintf_buf *bufs;
> > +
> > +     buf_used = this_cpu_inc_return(bpf_snprintf_buf_used);
> > +     if (WARN_ON_ONCE(buf_used > 1)) {
>
> this can trigger only if the helper itself gets preempted and
> another bpf prog will run on the same cpu and will call into this helper
> again, right?
> If so, how about adding preempt_disable here to avoid this case?

Ah, neat, that sounds like a good idea indeed. This was really just
cargo-culted from bpf_seq_printf but as part of my grand unification
attempt for the various printf-like helpers, I can try to make it use
preempt_disable as well yes.

> It won't prevent the case where kprobe is inside snprintf core,
> so the counter is still needed, but it wouldn't trigger by accident.

Good point, I will keep it around then.

> Also since bufs are not used always, how about grabbing the
> buffers only when %p or %s are seen in fmt?
> After snprintf() is done it would conditionally do:
> if (bufs_were_used) {
>    this_cpu_dec(bpf_snprintf_buf_used);
>    preempt_enable();
> }
> This way simple bpf_snprintf won't ever hit EBUSY.

Absolutely, it would be nice. :)

> > +             err = -EBUSY;
> > +             goto out;
> > +     }
> > +
> > +     bufs = this_cpu_ptr(&bpf_snprintf_buf);
> > +
> > +     /*
> > +      * The verifier has already done most of the heavy-work for us in
> > +      * check_bpf_snprintf_call. We know that fmt is well formatted and that
> > +      * args_len is valid. The only task left is to convert some of the
> > +      * arguments. For the %s and %pi* specifiers, we need to read buffers
> > +      * from a kernel address during the helper call.
> > +      */
> > +     for (i = 0; fmt[i] != '\0'; i++) {
> > +             if (fmt[i] != '%')
> > +                     continue;
> > +
> > +             if (fmt[i + 1] == '%') {
> > +                     i++;
> > +                     continue;
> > +             }
> > +
> > +             /* fmt[i] != 0 && fmt[last] == 0, so we can access fmt[i + 1] */
> > +             i++;
> > +
> > +             /* skip optional "[0 +-][num]" width formating field */
> > +             while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
> > +                    fmt[i] == ' ')
> > +                     i++;
> > +             if (fmt[i] >= '1' && fmt[i] <= '9') {
> > +                     i++;
> > +                     while (fmt[i] >= '0' && fmt[i] <= '9')
> > +                             i++;
> > +             }
> > +
> > +             if (fmt[i] == 's') {
> > +                     void *unsafe_ptr = (void *)(long)args[fmt_cnt];
> > +
> > +                     err = strncpy_from_kernel_nofault(bufs->buf[memcpy_cnt],
> > +                                                       unsafe_ptr,
> > +                                                       MAX_SNPRINTF_STR_LEN);
> > +                     if (err < 0)
> > +                             bufs->buf[memcpy_cnt][0] = '\0';
> > +                     params[fmt_cnt] = (u64)(long)bufs->buf[memcpy_cnt];
>
> how about:
> char buf[512]; instead?
> instead of memcpy_cnt++ remember how many bytes of the buf were used and
> copy next arg after that.
> The scratch space would be used more efficiently.
> The helper would potentially return ENOSPC if the first string printed via %s
> consumed most of the 512 space and the second string doesn't fit.
> But the verifier-time if (memcpy_cnt >= MAX_SNPRINTF_MEMCPY) can be removed.
> Ten small %s will work fine.

Cool! That is also a good idea :)

> We can allocate a page per-cpu when this helper is used by prog and free
> that page when all progs with bpf_snprintf are unloaded.
> But extra complexity is probably not worth it. I would start with 512 per-cpu.
> It's going to be enough for most users.

Yes, let's maybe keep that for later. I think there is already enough
complexity going into the printf-like helpers unification patch.

> Overall looks great. Cannot wait for v2 :)

Ahah wait until you see that patch! :D
