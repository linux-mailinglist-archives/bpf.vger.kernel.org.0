Return-Path: <bpf+bounces-14861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1677E7E893B
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 05:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7ED1F20F9E
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 04:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7878453B4;
	Sat, 11 Nov 2023 04:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG7SR1DP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C01915B3;
	Sat, 11 Nov 2023 04:32:55 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8551FD7;
	Fri, 10 Nov 2023 20:32:53 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so4355357a12.0;
        Fri, 10 Nov 2023 20:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699677172; x=1700281972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1LAJp2By4zZWFpPX7rxfXeSMFnxE7/94UDqW/5rzVc=;
        b=MG7SR1DPlxw2jEAEYwfKTJsTwRUGpiXWvWl77P1h3igalsjatSyCiiXDWfBn6QWac5
         cbzV0ZX1ll0KcLP30CDr245ei9xp48/C52XIvI9b7dR8IdIc5HNJJP1FTJ3gTO4yRN9t
         9sy7arJAB9EGMUtYBCjnxKLU5O9TVT6rmLx+xYIKPLx7NojIIbT+YWzCd8/jq7VR4M0T
         Hm7txQbx0PGmQncCxFX+4QN+dtfghY4PhpnoeOB1Br3oa61yQOWzwqxvzBhbpapuyl2U
         oJa93/Mvyt5aga3LrvRjdYEug0oq9ZYXH5Uv7Tm3RlD3hqopZNsCyBext41xN2H5ssRX
         GLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699677172; x=1700281972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1LAJp2By4zZWFpPX7rxfXeSMFnxE7/94UDqW/5rzVc=;
        b=jGi7srhexLbmdT6xYsKlFLyxLOjXVl4aT8j5RAW5Syl7hq3Qfb7vlnLRZ6VO+hmE/+
         s5VdrV8Kg/w3LVpGUSMnmYiIw7JVZJZJN9vppwt+LzThX2N8eW9Jew4ihRNzjXU1CrIa
         CJPp7nhTKbsq3u9gSWL4tR6mtwNLKIBiEczLe942UP++KefPnQ5vzkreCroN187yVW9w
         okMKlQuZXmAfwoSXdaPaKx9Lmillm9duHmbd7e1kgE60hj8dpOG01wKfnqYml7cCJ/TX
         HmwU8FVO+P3bHYi0RqA49SzTPKv2/2LdqLxpMxHValO2evOtUKMqJi2CTX0HuUHBlu1Z
         pomQ==
X-Gm-Message-State: AOJu0YwNmzmqQDrBr65XoGlgKpgEgORYpOdF/HL1wTorxeP7cXMufVp3
	g6yQlwjs/OIbJhBjqzjGv63MAMaZYjbHA2dmOk0=
X-Google-Smtp-Source: AGHT+IHBSFjMd61UgVKV/ASu7RdIpB1lscOrNSkuDSCW1og64A5iVZmaoVtWhLv5D1qQykp+me0NlXAWtLJPKcjXXB0=
X-Received: by 2002:a05:6402:5162:b0:532:bed7:d0dd with SMTP id
 d2-20020a056402516200b00532bed7d0ddmr733083ede.5.1699677171944; Fri, 10 Nov
 2023 20:32:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110235021.192796-1-linux@jordanrome.com> <CAEf4BzaWtOeTBb_+b7Td3NHaKjZU+OohuBJje_nvw9kd6xPA3g@mail.gmail.com>
 <CA+QiOd4X_=rZ5s=XgxBrmSkoepJLFmN4p+3q-0ST9j1sj_BhPw@mail.gmail.com>
In-Reply-To: <CA+QiOd4X_=rZ5s=XgxBrmSkoepJLFmN4p+3q-0ST9j1sj_BhPw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Nov 2023 20:32:40 -0800
Message-ID: <CAEf4BzZT_H1rac3DsSeOdUe2oLEzXkY0EMEnyo-KXXhT=z2djQ@mail.gmail.com>
Subject: Re: [PATCH perf] perf: get_perf_callchain return NULL for crosstask
To: Jordan Rome <linux@jordanrome.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 4:43=E2=80=AFPM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> On Fri, Nov 10, 2023 at 7:10=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Nov 10, 2023 at 3:51=E2=80=AFPM Jordan Rome <linux@jordanrome.c=
om> wrote:
> > >
> > > Return NULL instead of returning 1 incorrect frame, which
> > > currently happens when trying to walk the user stack for
> > > any task that isn't current. Returning NULL is a better
> > > indicator that this behavior is not supported.
> > >
> > > This issue was found using bpf_get_task_stack inside a BPF
> > > iterator ("iter/task"), which iterates over all tasks. The
> > > single address/frame in the buffer when getting user stacks
> > > for tasks that aren't current could not be symbolized (testing
> > > multiple symbolizers).
> > >
> > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > ---
> > >  kernel/events/callchain.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> > > index 1273be84392c..430fa544fa80 100644
> > > --- a/kernel/events/callchain.c
> > > +++ b/kernel/events/callchain.c
> > > @@ -201,6 +201,9 @@ get_perf_callchain(struct pt_regs *regs, u32 init=
_nr, bool kernel, bool user,
> > >         }
> > >
> > >         if (user) {
> > > +               if (crosstask)
> > > +                       return NULL;
> >
> > I think you need that goto exit_put here.
> >
>
> Why is that? Wouldn't that be the same behavior that already exists?
> That being said we can probably move this check above get_callchain_entry
> and exit earlier.

If I read the code right, get_callchain_entry() does expect
put_callchain_entry(), which you are breaking with this return NULL.

But indeed, checking it early and bailing out might be the best solution he=
re.

>
> > > +
> > >                 if (!user_mode(regs)) {
> > >                         if  (current->mm)
> > >                                 regs =3D task_pt_regs(current);
> > > @@ -209,9 +212,6 @@ get_perf_callchain(struct pt_regs *regs, u32 init=
_nr, bool kernel, bool user,
> > >                 }
> > >
> > >                 if (regs) {
> > > -                       if (crosstask)
> > > -                               goto exit_put;
> > > -
> > >                         if (add_mark)
> > >                                 perf_callchain_store_context(&ctx, PE=
RF_CONTEXT_USER);
> > >
> > > @@ -219,7 +219,6 @@ get_perf_callchain(struct pt_regs *regs, u32 init=
_nr, bool kernel, bool user,
> > >                 }
> > >         }
> > >
> > > -exit_put:
> > >         put_callchain_entry(rctx);
> > >
> > >         return entry;
> > > --
> > > 2.39.3
> > >

