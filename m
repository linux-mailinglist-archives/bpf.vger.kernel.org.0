Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953556DA64B
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 01:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239569AbjDFXnW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 19:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbjDFXmd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 19:42:33 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AA793E4
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 16:42:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id cw23so5017367ejb.12
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 16:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680824549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1YtO/T+eCLwayKGzZHGfHtpn7fHSmAJSK3qRI39+U8=;
        b=l0WGXJ13/CZk17VXc/Ad/aIzAoyeIlLP52IHszb9u6GJOMBtTgAd29iKdE0wrYxoFK
         sJMjOVJk3n7Iis49uZTA2c1tdPxep159F2ZV1AoDH8OBEwCZ2U4Nr0B06gfkvu8ZqpNr
         zsomX8Tz3NjAkxKBz8hGGG2fkU9MdgcJSav6/+I5P2PpPI0mIYemGR2ZCmMRV2J2e+AF
         qfYucYkPtsOGR66oYBKnXRbfJPFtXsiP69syqvPEAjjLQ5Q1hYGr0YSrqTw7c9DnPXY9
         kHO2h6+S6t3APocjMAyqXOS9RK+KuDHhybfKHap8lo4PWcGa/E+d/nP8qU8dka2e6Hyw
         pP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680824549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1YtO/T+eCLwayKGzZHGfHtpn7fHSmAJSK3qRI39+U8=;
        b=GVqIQZcx9zCF6y59gtvfBZtl3mltUnfhjwfY5kAYQecBcpkjQY1x2kAZCxwKwPxri5
         ytsx60+7UMY6XtWDatyql0UMjdtZI3GTtrIF17c0vpKOfBeM9jKoM3YfW39ZG4Dsr5/J
         xCVGpWDAECg0H74v3nxgD+T/ApCPvv9a4+C+rdMPSMQNR/VWKs7oha2iXh3xeAxFOG7F
         pak5aLDmSJtb4/QQmzdP9WB/TqzPNcoQNe9hK3FR2veZISHyVOIBhh4fXd8u7RQLjOiZ
         93V3WcyVFHyU/Wwm9EWJ8r6ab5GaSws/7F+Rais06uXGWf2SwkMZ2XJidLF+isSAs0kR
         S0mw==
X-Gm-Message-State: AAQBX9cM+uOmyC8fOJnNmcn0l+w3ztW9ITgS3jSKQqaOvnCv55gvSyXg
        KPRtfDNfDTMVuny4Y4LomnCeNkidMS+Bz0P411yYCcjk
X-Google-Smtp-Source: AKy350aYbC05A4axkI0K7z++rvOFz+YNJ0clBxa5EAwhZAyHKGCNunbwSsMVQNfU38oRNtTApIP+Xq5KPmpQukJB7Qc=
X-Received: by 2002:a17:907:1c83:b0:947:9d85:30c9 with SMTP id
 nb3-20020a1709071c8300b009479d8530c9mr5650419ejc.5.1680824549294; Thu, 06 Apr
 2023 16:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <CAN+4W8hptrrVjQ+-=otz_FPb2uL4E4bgzNRzp3pOh4=hWgeA+A@mail.gmail.com>
 <CAEf4BzYRc+ppyvbYy39FLPLGL41kPSV8xVSbJ_4Mha_shRCNHw@mail.gmail.com>
 <CAN+4W8gDS=8Kew42VM-PdqU1uXNZpaHq7wO8KEHQFhDDRBEWxA@mail.gmail.com> <CAEf4BzYfvzY9fFwAZ2fCGaPM2_RX_qM_SDb1zm8j7Vyd922jyQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYfvzY9fFwAZ2fCGaPM2_RX_qM_SDb1zm8j7Vyd922jyQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Apr 2023 16:42:17 -0700
Message-ID: <CAEf4BzYRO3e-ktbjyDujk0yjFG2fkR6OkC=WsdtoT_fm6FX_dw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/19] BPF verifier rotating log
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        timo@incline.eu, robin.goegge@isovalent.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 6, 2023 at 11:53=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 6, 2023 at 10:30=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> =
wrote:
> >
> > On Wed, Apr 5, 2023 at 7:35=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >
> > > So all in all, looking at stats, I don't really see a big
> > > simplification. On the other hand, I spent a considerable time
> > > thinking, debugging, and testing my existing implementation
> > > thoroughly. Then there is also interaction with log_buf=3D=3DNULL &&
> > > log_size=3D=3D0 case, I'd need to re-analyze everything again.
> > >
> > > How strong do you feel the need for me to redo this tricky part to
> > > save a few lines of C code (and lose easy debuggability at least of
> > > kbuf contents)? I'm a bit on the fence. I noted a few things I would
> > > add (or remove) even to existing code and I'll apply that. But unless
> > > someone comes out and says "let's do it this way", I'd rather not
> > > waste half a day on debugging some random off-by-one error again.
> >
> > Well, what are you optimising for? Is it getting the code in or is it
> > ease of understanding for future readers (including you in a year or
> > so?)
>
> I'm just saying that ease of understanding is subjective. So given I'm
> not convinced that your approach is simpler, I'd avoid unnecessary
> extra changes to the code that I've spent a lot of time testing and
> debugging and am pretty confident about.
>
> The point of code review is not to satisfy every nit, but to see if
> there are problems with the proposed solution and if something can be
> done better. Not *different*, but *better*.
>

So, I did an honest attempt to implement the idea of BPF_LOG_FIXED
being just a partial case of rotating mode by just adjusting N. And
this breaks down once we start calculating len_max and using
log->end_pos as logical position that can go beyond log->len_total. I
had to abandon this idea, sorry. As I mentioned before, interactions
with log_size=3D=3D0 are not obvious and straightforward.

I did more testing, though, verifying fixed mode truncation. That
actually caught a corner case when len_total =3D 1, in which case buffer
wasn't zero-terminated. So at least that's the payoff. :)


> One of the things I wanted to hear feedback on was if the overall UAPI
> behavior makes sense. You had concerns about enabling rotating log
> mode by default, which I believe are addressed by returning -ENOSPC.
> Can you please confirm that this approach is acceptable now? Thanks!
>
> >
> > Feel free to submit it as it is, maybe I can trim down my solution
> > some more to get rid of some more special cases ;)
> >
> > > > -            new_n =3D min_t(u32, log->len_total - log->end_pos, n)=
;
> > > > -            log->kbuf[new_n - 1] =3D '\0';
> > >
> > > without this part I can't debug what kernel is actually emitting into
> > > user-space with a simple printk()...
> >
> > As I just learned, vscnprintf always null terminates so log->kbuf can
> > always be printed?
>
> aren't we adjusting n in this branch and would need to zero-terminate
> anew? Yes we can safely print it, it just won't be the contents we are
> putting into the user buffer.
>
> >
> > > > +void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *f=
mt,
> > > > +               va_list args)
> > > > +{
> > > > +    /* NB: contrary to vsnprintf n can't be larger than sizeof(log=
->kbuf) */
> > >
> > > it can't be even equal to sizeof(log->kbuf)
> >
> > Yes... C string functions are the worst.
> >
> > >
> > > > +    u32 n =3D vscnprintf(log->kbuf, sizeof(log->kbuf), fmt, args);
> > > > +
> > > > +    if (log->level =3D=3D BPF_LOG_KERNEL) {
> > > > +        bool newline =3D n > 0 && log->kbuf[n - 1] =3D=3D '\n';
> > > > +
> > > > +        pr_err("BPF: %s%s", log->kbuf, newline ? "" : "\n");
> > > > +        return;
> > > > +    }
> > > >
> > > > +    if (log->level & BPF_LOG_FIXED) {
> > > > +        bpf_vlog_update_len_max(log, n);
> > >
> > > this made me pause for a second to prove we are not double-accounting
> > > something. We don't, but I find the argument of a simplification a bi=
t
> > > weaker due to this :)
> >
> > Yeah. I found a way to get rid of this, I might submit that as a follow=
 up.
> >
> > > > -    if (log->level & BPF_LOG_FIXED)
> > > > -        pos =3D log->end_pos + 1;
> > > > -    else
> > > > -        div_u64_rem(new_pos, log->len_total, &pos);
> > > > -
> > > > -    if (pos < log->len_total && put_user(zero, log->ubuf + pos))
> > > > -        log->ubuf =3D NULL;
> > >
> > > equivalent to what you do in vlog_finalize, right?
> >
> > Yep
> >
> > > > @@ -237,8 +220,20 @@ int bpf_vlog_finalize(struct bpf_verifier_log
> > > > *log, u32 *log_size_actual)
> > > >
> > > >      if (!log->ubuf)
> > > >          goto skip_log_rotate;
> > > > +
> > > > +    if (log->level & BPF_LOG_FIXED) {
> > > > +        bpf_vlog_update_len_max(log, 1);
> > > > +
> > > > +        /* terminate by (potentially) overwriting the last byte */
> > > > +        if (put_user(zero, log->ubuf + min_t(u32, log->end_pos,
> > > > log->len_total-1))
> > > > +            return -EFAULT;
> > > > +    } else {
> > > > +        /* terminate by (potentially) rotating out the first byte =
*/
> > > > +        bpf_vlog_emit(log, &zero, 1);
> > > > +    }
> > >
> > > not a big fan of this part where we still do two separate handlings
> > > for two modes
> >
> > Agreed, but I'm not sure it can be avoided at all since we need to
> > clamp different parts of the buffer depending on which mode we are in.
