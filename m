Return-Path: <bpf+bounces-53369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C7FA505AE
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A3B164C56
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CBE1991DB;
	Wed,  5 Mar 2025 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/CqLe/I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486081917E4
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193557; cv=none; b=UiV43q8E7LWPTjIQqYVnAZXaBNmDhzh0200mM/9DtdmeyBwOeX2C0i7ETsoWpZ7S/PGqOL7TTEJBsoaUhlK+5jkLOFPBpvehPJSSReBR0IwAP+Mh1CwieApX8zgkSQ/QLirLrmOsr1g38CFOSBUI/0TIj9rIef1UVJ/hg9e2A8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193557; c=relaxed/simple;
	bh=BV7qpD5KPgk/JFO/yZ7iRswMGIs9dZfui1Slp6rjcY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzhyTWMi0xdYCdZdcBQwuq/M28Ds42vGAQB960WgQjDYF6+75WuTeT0c9H4tCYGJbYDvHNZFFYU1k3nKkD6UnP9cX2bTq1JK9q4JBhnUeA7CYzW7Fh7jNkLCNz7i3hUyEEpLycBYjEbnBLXVUDDVgRyHAGZ0dZFch5/0UJhNWyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/CqLe/I; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fd4dcf2df7so44757737b3.0
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 08:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741193555; x=1741798355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAp6zKpf2lv69m6kvLUtccLZepzJlutx2efM15o/2rQ=;
        b=K/CqLe/Ip+DxB4xkWVgQDXxZFtvdTCvTj7Ium9F3qPLKGX4YfVEEgOwIIey6v4xydB
         /3C/x7/dKNX6Ly+dGD62NOv7conRNc8IypF3T/GamO0XTAi1IPYKlg6l0PTe2uTawPwr
         fchpxWItLOWXJfGyzlthJWIx2MKE/ISZuPwyGny8ycUq/RL1/QIY8AksPVjPhqKt0yNM
         FwSTpneexC7Ytwqe00R3JKlVpSdUqxVhCSAQg71Wsf+MAbTAmb0u8ajaZHStubWOczez
         TGNgisx+elY+yvlyKsmlxs/eNXhcZGoDeAuyc70ZJuneeSsCTbmNwsjHDKVS/iBOtK4z
         ddvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741193555; x=1741798355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAp6zKpf2lv69m6kvLUtccLZepzJlutx2efM15o/2rQ=;
        b=xC4YHSBEbfJgkrTp94GjsIEGjdCiCcp/FTfnKhwRvVmhaN0CnTj+4Uh9BNl21xvTP2
         NGkInkZ2pIkyjS6ofGib5G6zTY0L2jRP8whyI95dSav4IBQgxPlhD3phNuT87LUIaeEh
         6IHA9zy66hccwrBaCtzjFHoU0tu++j/qg4CiD92GVoxfUFjOL7a2V7Gt4+0/8TQfx15R
         ehLLHI1GiGX/DpIwfKo1naSpw49tw/cJAzUT9UMUJUPmjK5CJRd/M1IffZ9YSedWnqUQ
         2pD6JimRcc3SkKi3agrFxHjAzjHNE1SUvUq7wDTn6w1NDuK8GUTpyCjSIZvnCVi7lw2E
         BVKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/mMOGfHH6i3xjdZLyPiNKt4IEye5EgUbfDakyeHK8S6lCJjPSKfPiZmYz+lYyh+bJ3fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqb+NTHGCvapVF4cWiIvE2D54xccQBdrXqyurGgGhm+m1/juEA
	+67zHFiwvwDD/0c5f+vqmHzFDTdfmObJY/xNV2PG6OlE3iLFFFp2u/mKGFh44FDj//QWUlm2gKY
	3effGLu0Pz8Chz/f7uoUOsg3qvrM=
X-Gm-Gg: ASbGnctbTyMxYf2IGzoOKbAwNsOq06O4z8W6iuhg9sObxlQ9d4TFGkfb8MjbZXcx7ja
	C/NCITtxP57h1SZDkzkXykWJs5/GcXMf+tqVnl6gy47yl8vVh/cPL8e6Qxs+OjMvqImI2mtbcHP
	QDNH8lRF6DxWuojkPKC3qexfkn5w==
X-Google-Smtp-Source: AGHT+IG4+/4Qs46e5f72H0nhWwII+lVZS2142yC0dlBgkLo0VL/ySLBm316F0vDFeo+pkj3aqt1xsRdz6qQ3ZhK9QYI=
X-Received: by 2002:a05:690c:3589:b0:6f7:5a46:fe5f with SMTP id
 00721157ae682-6fda30379a6mr54949957b3.1.1741193555060; Wed, 05 Mar 2025
 08:52:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304163626.1362031-1-ameryhung@gmail.com> <20250304163626.1362031-3-ameryhung@gmail.com>
 <716c1a2d-f4fb-407f-b77d-03019e0dd2a5@linux.dev>
In-Reply-To: <716c1a2d-f4fb-407f-b77d-03019e0dd2a5@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 5 Mar 2025 08:52:24 -0800
X-Gm-Features: AQ5f1JqFkZQbKFf7ObkSAmf2J7ytxQrh_G0CbKXWJJQMy5_6I_tav2Av1vi4sY0
Message-ID: <CAMB2axMPmTqz16nbVh5fk6gs0rmaMPL4uG73gAqyr+L5A=2Ggw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Fix dangling stdout seen
 by traffic monitor thread
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:36=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 3/4/25 8:36 AM, Amery Hung wrote:
> > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/s=
elftests/bpf/test_progs.c
> > index ab0f2fed3c58..5b89f6ca5a0a 100644
> > --- a/tools/testing/selftests/bpf/test_progs.c
> > +++ b/tools/testing/selftests/bpf/test_progs.c
> > @@ -88,7 +88,11 @@ static void stdio_hijack(char **log_buf, size_t *log=
_cnt)
> >   #endif
> >   }
> >
> > -static void stdio_restore_cleanup(void)
> > +static pthread_mutex_t stdout_lock =3D PTHREAD_MUTEX_INITIALIZER;
> > +
> > +static bool in_crash_handler(void);
> > +
> > +static void stdio_restore(void)
> >   {
> >   #ifdef __GLIBC__
> >       if (verbose() && env.worker_id =3D=3D -1) {
> > @@ -98,34 +102,34 @@ static void stdio_restore_cleanup(void)
> >
> >       fflush(stdout);
> >
> > -     if (env.subtest_state) {
> > +     pthread_mutex_lock(&stdout_lock);
> > +
> > +     if (!env.subtest_state || in_crash_handler()) {
>
> Can the stdio restore be done in the crash_handler() itself instead of ha=
ving a
> special case here and adding another in_crash_handler()?
>
> Theoretically, the crash_handler() only needs to
> fflush(stdout /* whatever the current stdout is */) and...
>
> > +             if (stdout =3D=3D env.stdout_saved)
> > +                     goto out;
> > +
> > +             fclose(env.test_state->stdout_saved);
> > +             env.test_state->stdout_saved =3D NULL;
> > +             stdout =3D env.stdout_saved;
> > +             stderr =3D env.stderr_saved;
>
> ... restore std{out,err} =3D env.std{out,err}_saved.
>
> At the crash point, it does not make a big difference to
> fclose(evn.test_state->stdout_saved) or not?
>
> If the crash_handler() does not close the stdout that the traffic monitor=
 might
> potentially be using, then crash_handler() does not need to take mutex, r=
ight?
>

You are right. I think it is simpler to not let stdio_restore() handle
the crash case, and just do the following in the crash handler.

fflush(stdout);
stdout =3D env.stdout_saved;
stderr =3D env.stderr_saved;


> > +     } else {
> >               fclose(env.subtest_state->stdout_saved);
> >               env.subtest_state->stdout_saved =3D NULL;
> >               stdout =3D env.test_state->stdout_saved;
> >               stderr =3D env.test_state->stdout_saved;
> > -     } else {
> > -             fclose(env.test_state->stdout_saved);
> > -             env.test_state->stdout_saved =3D NULL;
> >       }
> > +out:
> > +     pthread_mutex_unlock(&stdout_lock);
> >   #endif
> >   }
> >
>
> [ ... ]
>
> > +static bool in_crash_handler(void)
> > +{
> > +     struct sigaction sigact;
> > +
> > +     /* sa_handler will be cleared if invoked since crash_handler is
> > +      * registered with SA_RESETHAND
> > +      */
> > +     sigaction(SIGSEGV, NULL, &sigact);
> > +
> > +     return sigact.sa_handler !=3D crash_handler;
> > +}
> > +

