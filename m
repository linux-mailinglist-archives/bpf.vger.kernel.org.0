Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7551B6DA058
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 20:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjDFSxQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 14:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjDFSxP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 14:53:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817906EB8
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 11:53:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g18so3703036ejj.5
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680807193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAxgUEv2EuxEfrtHGL5OF/cH2YSEE1ekV7V/+4XNUfE=;
        b=hnP8fHXjnsQZqWoxgIYHo/MjcRsmWbZkpcUNjUzpgUYZwEDEl8uCrNUguOb96/eEPK
         2BmOoUdo5H6OOij2iKndTd91WF/1JvV4ViJcJbrudllbXSFIJUBaxAFcCrCPiltOHQlO
         QqN103vwWDLsmfiRhZhm9PZLN6j3b1x0mFU7lo02QDF3Sy7td+2zu94IlsDwcExdSAbU
         /0L6xLrrKjJD6s94SCj2jqtq2sJJbSePfgunMAMmycU0m+egqdW8mA1jH/OhC2A2fuTe
         KehJSwafjHEeLZS0WOnt802MxdZ9m4t9RrYlpWDVYo1VsGG3PR7bicUBZpQqjzMEs6yb
         FGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAxgUEv2EuxEfrtHGL5OF/cH2YSEE1ekV7V/+4XNUfE=;
        b=vwPEwQBXWUWh4jznoVhBHeF5qCN2deGKj+CEJhWA5D+0DtXAgjrBOr4AuEoto4eyKV
         fx9CRrNuXiziWh5XVRdx2AeaKhdI9vWHvfMPf78gMExhKKmg9VGMev71w/RmbJ6qjQOi
         KvoFycDLrnjBjDMytsB4bJwVkKBdd2tXq06LQKF8KlG1hZh8J9g6c4+D1VwOgv3o3dS2
         Uno+i6gzmku+KrwfQqFoNZQdzl/av9duF95pVysJGAwzNND4Ysz/DSFafsk0UBTdRmeE
         TKgPpqaA+7fg8jlOrFQIwldTLLKrFYv1MoNiOLjVO4wt7BwCJZXZJtEx0t2HQRGU5RNq
         zImg==
X-Gm-Message-State: AAQBX9eOSuaaIWE7/9eRd/m5BTTD5lJuEdB7dKhTy94Ke7qUCvQIfsIV
        9sSsr0TEY/Uyd48UsZrUtJq6aw8Iquz2j8GDI2g=
X-Google-Smtp-Source: AKy350ZWr3MKHA8Gcvw5fLKlG1QG8Yjb8roLdmg66fbuNJuebtsUPWO1UfdpcB2hcklhfFk3chHjGWv5GE/e6JOv0/s=
X-Received: by 2002:a17:906:f850:b0:948:5b2a:7841 with SMTP id
 ks16-20020a170906f85000b009485b2a7841mr4026131ejb.5.1680807192949; Thu, 06
 Apr 2023 11:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <CAN+4W8hptrrVjQ+-=otz_FPb2uL4E4bgzNRzp3pOh4=hWgeA+A@mail.gmail.com>
 <CAEf4BzYRc+ppyvbYy39FLPLGL41kPSV8xVSbJ_4Mha_shRCNHw@mail.gmail.com> <CAN+4W8gDS=8Kew42VM-PdqU1uXNZpaHq7wO8KEHQFhDDRBEWxA@mail.gmail.com>
In-Reply-To: <CAN+4W8gDS=8Kew42VM-PdqU1uXNZpaHq7wO8KEHQFhDDRBEWxA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Apr 2023 11:53:00 -0700
Message-ID: <CAEf4BzYfvzY9fFwAZ2fCGaPM2_RX_qM_SDb1zm8j7Vyd922jyQ@mail.gmail.com>
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

On Thu, Apr 6, 2023 at 10:30=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> On Wed, Apr 5, 2023 at 7:35=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>
> > So all in all, looking at stats, I don't really see a big
> > simplification. On the other hand, I spent a considerable time
> > thinking, debugging, and testing my existing implementation
> > thoroughly. Then there is also interaction with log_buf=3D=3DNULL &&
> > log_size=3D=3D0 case, I'd need to re-analyze everything again.
> >
> > How strong do you feel the need for me to redo this tricky part to
> > save a few lines of C code (and lose easy debuggability at least of
> > kbuf contents)? I'm a bit on the fence. I noted a few things I would
> > add (or remove) even to existing code and I'll apply that. But unless
> > someone comes out and says "let's do it this way", I'd rather not
> > waste half a day on debugging some random off-by-one error again.
>
> Well, what are you optimising for? Is it getting the code in or is it
> ease of understanding for future readers (including you in a year or
> so?)

I'm just saying that ease of understanding is subjective. So given I'm
not convinced that your approach is simpler, I'd avoid unnecessary
extra changes to the code that I've spent a lot of time testing and
debugging and am pretty confident about.

The point of code review is not to satisfy every nit, but to see if
there are problems with the proposed solution and if something can be
done better. Not *different*, but *better*.

One of the things I wanted to hear feedback on was if the overall UAPI
behavior makes sense. You had concerns about enabling rotating log
mode by default, which I believe are addressed by returning -ENOSPC.
Can you please confirm that this approach is acceptable now? Thanks!

>
> Feel free to submit it as it is, maybe I can trim down my solution
> some more to get rid of some more special cases ;)
>
> > > -            new_n =3D min_t(u32, log->len_total - log->end_pos, n);
> > > -            log->kbuf[new_n - 1] =3D '\0';
> >
> > without this part I can't debug what kernel is actually emitting into
> > user-space with a simple printk()...
>
> As I just learned, vscnprintf always null terminates so log->kbuf can
> always be printed?

aren't we adjusting n in this branch and would need to zero-terminate
anew? Yes we can safely print it, it just won't be the contents we are
putting into the user buffer.

>
> > > +void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt=
,
> > > +               va_list args)
> > > +{
> > > +    /* NB: contrary to vsnprintf n can't be larger than sizeof(log->=
kbuf) */
> >
> > it can't be even equal to sizeof(log->kbuf)
>
> Yes... C string functions are the worst.
>
> >
> > > +    u32 n =3D vscnprintf(log->kbuf, sizeof(log->kbuf), fmt, args);
> > > +
> > > +    if (log->level =3D=3D BPF_LOG_KERNEL) {
> > > +        bool newline =3D n > 0 && log->kbuf[n - 1] =3D=3D '\n';
> > > +
> > > +        pr_err("BPF: %s%s", log->kbuf, newline ? "" : "\n");
> > > +        return;
> > > +    }
> > >
> > > +    if (log->level & BPF_LOG_FIXED) {
> > > +        bpf_vlog_update_len_max(log, n);
> >
> > this made me pause for a second to prove we are not double-accounting
> > something. We don't, but I find the argument of a simplification a bit
> > weaker due to this :)
>
> Yeah. I found a way to get rid of this, I might submit that as a follow u=
p.
>
> > > -    if (log->level & BPF_LOG_FIXED)
> > > -        pos =3D log->end_pos + 1;
> > > -    else
> > > -        div_u64_rem(new_pos, log->len_total, &pos);
> > > -
> > > -    if (pos < log->len_total && put_user(zero, log->ubuf + pos))
> > > -        log->ubuf =3D NULL;
> >
> > equivalent to what you do in vlog_finalize, right?
>
> Yep
>
> > > @@ -237,8 +220,20 @@ int bpf_vlog_finalize(struct bpf_verifier_log
> > > *log, u32 *log_size_actual)
> > >
> > >      if (!log->ubuf)
> > >          goto skip_log_rotate;
> > > +
> > > +    if (log->level & BPF_LOG_FIXED) {
> > > +        bpf_vlog_update_len_max(log, 1);
> > > +
> > > +        /* terminate by (potentially) overwriting the last byte */
> > > +        if (put_user(zero, log->ubuf + min_t(u32, log->end_pos,
> > > log->len_total-1))
> > > +            return -EFAULT;
> > > +    } else {
> > > +        /* terminate by (potentially) rotating out the first byte */
> > > +        bpf_vlog_emit(log, &zero, 1);
> > > +    }
> >
> > not a big fan of this part where we still do two separate handlings
> > for two modes
>
> Agreed, but I'm not sure it can be avoided at all since we need to
> clamp different parts of the buffer depending on which mode we are in.
