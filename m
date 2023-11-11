Return-Path: <bpf+bounces-14878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AF77E8AB1
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 12:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D353280FA0
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 11:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2133613FF0;
	Sat, 11 Nov 2023 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41ED13AE0;
	Sat, 11 Nov 2023 11:31:58 +0000 (UTC)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB023A9C;
	Sat, 11 Nov 2023 03:31:56 -0800 (PST)
Received: from mail-ed1-f51.google.com ([209.85.208.51]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MGknn-1rEgVm229B-00DW3X;
 Sat, 11 Nov 2023 12:31:55 +0100
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so4448733a12.3;
        Sat, 11 Nov 2023 03:31:55 -0800 (PST)
X-Gm-Message-State: AOJu0Yw6m8oYrMpNWBeKzYJ8cS6oXN7VBSHd19EyujYSzCDACxPS78Ni
	EEr8QHGNLfuWKjATOSAAIV4ixH7od8xpOnlbRKY=
X-Google-Smtp-Source: AGHT+IHcrSnLpeBT4VrVFBQaA8HRCxTfFPpj0DrNVV9+ctHoWJvKZ3yjXWg/W/mKZvIwszW9ejL5FFLOWeVP3vHFo9k=
X-Received: by 2002:a50:ef01:0:b0:543:5293:9a81 with SMTP id
 m1-20020a50ef01000000b0054352939a81mr1430331eds.8.1699702314065; Sat, 11 Nov
 2023 03:31:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110235021.192796-1-linux@jordanrome.com> <CAEf4BzaWtOeTBb_+b7Td3NHaKjZU+OohuBJje_nvw9kd6xPA3g@mail.gmail.com>
 <CA+QiOd4X_=rZ5s=XgxBrmSkoepJLFmN4p+3q-0ST9j1sj_BhPw@mail.gmail.com> <CAEf4BzZT_H1rac3DsSeOdUe2oLEzXkY0EMEnyo-KXXhT=z2djQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZT_H1rac3DsSeOdUe2oLEzXkY0EMEnyo-KXXhT=z2djQ@mail.gmail.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Sat, 11 Nov 2023 06:31:42 -0500
X-Gmail-Original-Message-ID: <CA+QiOd5FJOYK8i1JC9q9HY14XAm27pK5ZMw7jQnbkbGDag1QpQ@mail.gmail.com>
Message-ID: <CA+QiOd5FJOYK8i1JC9q9HY14XAm27pK5ZMw7jQnbkbGDag1QpQ@mail.gmail.com>
Subject: Re: [PATCH perf] perf: get_perf_callchain return NULL for crosstask
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2OkTcxgfTR8jL1fk/DXfM/jiY8S1x/OYIZvuzGRJFtS7L7CdDAq
 Wizwkgdm8NsyrIU7u5m92f2EeeUcC1WP0gCMmWLnpQnNEtCKFQyM8IEgLtMWQYJ/jYs/v0C
 i/s1ahWuXz1UThgS7oPRlsa5f6H65YxzkcvHfKB2HBcKZivtULWNU2AdLsMqXmibiedOFyR
 +dXau4jC4ixzc4nI66icw==
UI-OutboundReport: notjunk:1;M01:P0:J8hFUjGBwX0=;Hnqu8ypxqmmNhjXUfL74GT6cWlY
 ufEnvQhqkZ9eTrzZF3iWSnAb2ki+0NX3X4yc1h7GmhF4/fRBxt/hgJvNMPBPQopXQ2/Hv93jO
 0rBXn84tUuIMjfOp8gQttvIUCO36BUyH4SziZpYC6FFLjZw/SBBPw2QRTdxkE6nc+SNVM9sz2
 kJYiUsIj4jFyZbPeFovfFjgI/s8QlP3Gs1eEjVT2WcQtyFGOKFnODYlH70u9Xw/Vzy4dXYGAp
 QLF/KAzkCzF+CweTeAwo0qynnieLXDdZPvILUM6PBin6YCvY8UgoLvu25ckCNASjHiZXn2wXA
 IvbEEpJNZJNVcwRvqRplsWOtToFAIrjHde14AcPWDZeBm0+EZ69U5dv+Wt7NdjA9uqFlpeqdz
 DBbhKWg23tr4WwU1f0QhbuwjzpN2rk7QreHzz0jdzmY6cF1Dm1Mkt0haxe1C31JYa6ne7CS8u
 hbyFNsFMIHA6nl8yTuZlbLTwDfkgYH8/gBom0lzZACFB+eyo2C57QFFnL0iOBQ6Vk9U4fjuyM
 L2r7a+FCeMPh/QSVQ9CiKc9mNhe6HGGyk4cIKZpA0VLyeu8Egm+ev0FrdTKZuGFZBUnABJqrc
 S48dufhxkfC5OJgamLH1NI7qo/q/uQBpFRzpGu4z2H7vCcBHUd8WV5fCP7ZDHgsSdXHmOsx9g
 1dclgcIwSgd/raqRbOOyKZyf8wYAWDaYCBmdRxt6zMdKzNszFHTzqfSWgBB8JpQu3x9SOguP5
 POd/kOD8nzVDv7FsLBxt0Tr2ccaNedCfxymfaRVpdJRzwqJWlOkJ8Qmfzp+BBuWwG4ZrP8gzN
 Qei3SrN4n2vfZ++BzwLfj14lEMRV/RIGD6EVS2sR9hgvt9wGdDircTT1KcS6UqoSp1djlVOAM
 tq+5QdhnLs0Gq7Q==

On Fri, Nov 10, 2023 at 11:32=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Nov 10, 2023 at 4:43=E2=80=AFPM Jordan Rome <linux@jordanrome.com=
> wrote:
> >
> > On Fri, Nov 10, 2023 at 7:10=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Nov 10, 2023 at 3:51=E2=80=AFPM Jordan Rome <linux@jordanrome=
.com> wrote:
> > > >
> > > > Return NULL instead of returning 1 incorrect frame, which
> > > > currently happens when trying to walk the user stack for
> > > > any task that isn't current. Returning NULL is a better
> > > > indicator that this behavior is not supported.
> > > >
> > > > This issue was found using bpf_get_task_stack inside a BPF
> > > > iterator ("iter/task"), which iterates over all tasks. The
> > > > single address/frame in the buffer when getting user stacks
> > > > for tasks that aren't current could not be symbolized (testing
> > > > multiple symbolizers).
> > > >
> > > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > > ---
> > > >  kernel/events/callchain.c | 7 +++----
> > > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> > > > index 1273be84392c..430fa544fa80 100644
> > > > --- a/kernel/events/callchain.c
> > > > +++ b/kernel/events/callchain.c
> > > > @@ -201,6 +201,9 @@ get_perf_callchain(struct pt_regs *regs, u32 in=
it_nr, bool kernel, bool user,
> > > >         }
> > > >
> > > >         if (user) {
> > > > +               if (crosstask)
> > > > +                       return NULL;
> > >
> > > I think you need that goto exit_put here.
> > >
> >
> > Why is that? Wouldn't that be the same behavior that already exists?
> > That being said we can probably move this check above get_callchain_ent=
ry
> > and exit earlier.
>
> If I read the code right, get_callchain_entry() does expect
> put_callchain_entry(), which you are breaking with this return NULL.
>
> But indeed, checking it early and bailing out might be the best solution =
here.
>

Sounds good. I'll move this check before `get_callchain_entry`.

> >
> > > > +
> > > >                 if (!user_mode(regs)) {
> > > >                         if  (current->mm)
> > > >                                 regs =3D task_pt_regs(current);
> > > > @@ -209,9 +212,6 @@ get_perf_callchain(struct pt_regs *regs, u32 in=
it_nr, bool kernel, bool user,
> > > >                 }
> > > >
> > > >                 if (regs) {
> > > > -                       if (crosstask)
> > > > -                               goto exit_put;
> > > > -
> > > >                         if (add_mark)
> > > >                                 perf_callchain_store_context(&ctx, =
PERF_CONTEXT_USER);
> > > >
> > > > @@ -219,7 +219,6 @@ get_perf_callchain(struct pt_regs *regs, u32 in=
it_nr, bool kernel, bool user,
> > > >                 }
> > > >         }
> > > >
> > > > -exit_put:
> > > >         put_callchain_entry(rctx);
> > > >
> > > >         return entry;
> > > > --
> > > > 2.39.3
> > > >

