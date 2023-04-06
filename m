Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9686D9EBF
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 19:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240054AbjDFRap (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 13:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240026AbjDFRan (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 13:30:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9E38A7A
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 10:30:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l17so3180082ejp.8
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 10:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680802234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1H0MWW0Gn+Mzs9K2o10ObMucKn9HfggstITlmdMpcrA=;
        b=EPvIdcRaIZUKTq+XJW0QWGapwr+NybcnJt3J5HKULJzbug28QUJOzKyRgKNs7B/IWe
         1hiLvKoEuwyKSbmKz2RONCQxeHB3LQaUY6AESkhrlv+UsRQEilMo0WerECdYylnd1J2U
         ELTy/ztApi7eFmyUjCHNKVJYnQx2p3f/jS95RXVtB2dsoXTEwYtkyLPZYcAthSXr1BoV
         o9qCJn9cyQKCQwQZMljEjK5G1tdocab5Nt1ceDT3wDQU/EU+bBAG0JeOxC59VnLx9nPQ
         /AvDh41ySyoIgWPVa2KIRyLzOHmVLVcHS9eWS6X4wi974H0AtnvzD3X0nLnNpH0x+q1i
         3ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680802234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1H0MWW0Gn+Mzs9K2o10ObMucKn9HfggstITlmdMpcrA=;
        b=L1Q2/FcFuHOXdSnRdUI7Kqmdu5sumtvJSol+PcYjvavBjBRkvj2s6fvaUzf86mJF8s
         8tqq0uuZLQemAGgeTewUUeov+DC3gj3julcjLW3CDPGw4h0qPCGxi4oS/ua8qnh6OhI0
         TIgdKTwRHte0INbIr6o1V+CM17Ci0+eWFXp1VkSnEc2mxjUEkiGkY3h8ra3wyXpzi0FQ
         3AiHHrHseY7v/hYeYzqBT3+8sB+f8IH9jVAxmxDKpnfpjuaV74XxBdCT7SrCHcp7SLP6
         BgVg3pioQrFWBYeduInHon5WHg/ny+YFyoReNFfJSbkuPXcGHZOoG4kdEZqr0mKmBIbi
         SStw==
X-Gm-Message-State: AAQBX9ddptYRrX/RpZ3WseOLdidJTucRYDa+wBVFD4bTrrQDhIl3qT9P
        IuWJVTKCgMpoUFY6Cik8pr0h1bn4DpS878s+ktGvaPWb4O34+T3TiBSelQ==
X-Google-Smtp-Source: AKy350Y2Jj8s7o8AQP1OkQMM/nHBSRcXZgP4IDzX+ATEoatCN7YN13gtmesSBbj2wwDlFs95qFbvOf+aiFX1f05dh5k=
X-Received: by 2002:a17:906:950a:b0:8e6:266c:c75e with SMTP id
 u10-20020a170906950a00b008e6266cc75emr3925359ejx.14.1680802234692; Thu, 06
 Apr 2023 10:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <CAN+4W8hptrrVjQ+-=otz_FPb2uL4E4bgzNRzp3pOh4=hWgeA+A@mail.gmail.com>
 <CAEf4BzYRc+ppyvbYy39FLPLGL41kPSV8xVSbJ_4Mha_shRCNHw@mail.gmail.com>
In-Reply-To: <CAEf4BzYRc+ppyvbYy39FLPLGL41kPSV8xVSbJ_4Mha_shRCNHw@mail.gmail.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Thu, 6 Apr 2023 18:30:03 +0100
Message-ID: <CAN+4W8gDS=8Kew42VM-PdqU1uXNZpaHq7wO8KEHQFhDDRBEWxA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/19] BPF verifier rotating log
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        timo@incline.eu, robin.goegge@isovalent.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 5, 2023 at 7:35=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:

> So all in all, looking at stats, I don't really see a big
> simplification. On the other hand, I spent a considerable time
> thinking, debugging, and testing my existing implementation
> thoroughly. Then there is also interaction with log_buf=3D=3DNULL &&
> log_size=3D=3D0 case, I'd need to re-analyze everything again.
>
> How strong do you feel the need for me to redo this tricky part to
> save a few lines of C code (and lose easy debuggability at least of
> kbuf contents)? I'm a bit on the fence. I noted a few things I would
> add (or remove) even to existing code and I'll apply that. But unless
> someone comes out and says "let's do it this way", I'd rather not
> waste half a day on debugging some random off-by-one error again.

Well, what are you optimising for? Is it getting the code in or is it
ease of understanding for future readers (including you in a year or
so?)

Feel free to submit it as it is, maybe I can trim down my solution
some more to get rid of some more special cases ;)

> > -            new_n =3D min_t(u32, log->len_total - log->end_pos, n);
> > -            log->kbuf[new_n - 1] =3D '\0';
>
> without this part I can't debug what kernel is actually emitting into
> user-space with a simple printk()...

As I just learned, vscnprintf always null terminates so log->kbuf can
always be printed?

> > +void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
> > +               va_list args)
> > +{
> > +    /* NB: contrary to vsnprintf n can't be larger than sizeof(log->kb=
uf) */
>
> it can't be even equal to sizeof(log->kbuf)

Yes... C string functions are the worst.

>
> > +    u32 n =3D vscnprintf(log->kbuf, sizeof(log->kbuf), fmt, args);
> > +
> > +    if (log->level =3D=3D BPF_LOG_KERNEL) {
> > +        bool newline =3D n > 0 && log->kbuf[n - 1] =3D=3D '\n';
> > +
> > +        pr_err("BPF: %s%s", log->kbuf, newline ? "" : "\n");
> > +        return;
> > +    }
> >
> > +    if (log->level & BPF_LOG_FIXED) {
> > +        bpf_vlog_update_len_max(log, n);
>
> this made me pause for a second to prove we are not double-accounting
> something. We don't, but I find the argument of a simplification a bit
> weaker due to this :)

Yeah. I found a way to get rid of this, I might submit that as a follow up.

> > -    if (log->level & BPF_LOG_FIXED)
> > -        pos =3D log->end_pos + 1;
> > -    else
> > -        div_u64_rem(new_pos, log->len_total, &pos);
> > -
> > -    if (pos < log->len_total && put_user(zero, log->ubuf + pos))
> > -        log->ubuf =3D NULL;
>
> equivalent to what you do in vlog_finalize, right?

Yep

> > @@ -237,8 +220,20 @@ int bpf_vlog_finalize(struct bpf_verifier_log
> > *log, u32 *log_size_actual)
> >
> >      if (!log->ubuf)
> >          goto skip_log_rotate;
> > +
> > +    if (log->level & BPF_LOG_FIXED) {
> > +        bpf_vlog_update_len_max(log, 1);
> > +
> > +        /* terminate by (potentially) overwriting the last byte */
> > +        if (put_user(zero, log->ubuf + min_t(u32, log->end_pos,
> > log->len_total-1))
> > +            return -EFAULT;
> > +    } else {
> > +        /* terminate by (potentially) rotating out the first byte */
> > +        bpf_vlog_emit(log, &zero, 1);
> > +    }
>
> not a big fan of this part where we still do two separate handlings
> for two modes

Agreed, but I'm not sure it can be avoided at all since we need to
clamp different parts of the buffer depending on which mode we are in.
