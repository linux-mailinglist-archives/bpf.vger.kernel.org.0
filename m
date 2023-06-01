Return-Path: <bpf+bounces-1622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674A671F1F0
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 20:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE386281983
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 18:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9747919532;
	Thu,  1 Jun 2023 18:32:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F5D5180C
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 18:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78017C433A0
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 18:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685644371;
	bh=LcaEV3e/EvScaz8I+a/VKN5I1mbw3vr1LHUpqwrq0ac=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ksBCaBjlIp9eY5Thge3ONzc0DrOduPPmAjBUMCnQ6VsTHU55L6KkUrAWK4xBsQHFX
	 HBO6B9HYzRoclsD7Jo4YF7HjN+yCx25bc+KBpY86QcsrDWOIPUnTXg369wzzV1lSAe
	 3XPuqunOadgYhQKK5yNg86Z1p0cxk2lnihD741ilH+1vKq/21NDE6uGmQopUgV0uiq
	 Bobqf3aZeCKN2aqDFkCfKpqWPJE0wt5YadWM1/7m0dj95g7mFrrVw8MBof3Y6yC93D
	 HnATKBJVHfanBAAKNxcYGn9FMqoAxTiTfiPOQTCpIxL8Y76kujSwVETNZ04M+5R2QV
	 1fmWmmbEMWC7w==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so1742530a12.1
        for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 11:32:51 -0700 (PDT)
X-Gm-Message-State: AC+VfDw7dTylXSA90526luVV+UyFf0FmXszg9BmyHy66Ahaa+E9C9tD+
	0eSnqZ2l1XWGl37g3XlG2cRINUgC6hyiEFTN/Eqtmw==
X-Google-Smtp-Source: ACHHUZ4cbDYw81Zr1qdb+Gl9rydSGlDqQUsqv3wtlj8odug2B1UYZNs8bC+e95EN/NBGK7elXNTQtOtM3qicHGs6lRo=
X-Received: by 2002:a50:ee87:0:b0:514:9df0:e3ec with SMTP id
 f7-20020a50ee87000000b005149df0e3ecmr593605edr.0.1685644369635; Thu, 01 Jun
 2023 11:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230601122622.513140-1-kpsingh@kernel.org> <CAPhsuW45Sb0TeOYouTvaVDhOGfz+2nBht0AmGyF4=yq15HE8AA@mail.gmail.com>
 <CACYkzJ7S7JwX77NSSurr1wWYnFQs0TZwUKcwW5Zmva3CkkAx5w@mail.gmail.com>
 <5486EA34-136F-45EA-BD9B-EA54EC436CA1@fb.com> <7e09f647-da79-4088-4579-1520e3fd8427@linux.dev>
 <CACYkzJ5=D7P38aQ=H388JzNUzHGWk348FUi-6N7o9oNw_esqCg@mail.gmail.com>
In-Reply-To: <CACYkzJ5=D7P38aQ=H388JzNUzHGWk348FUi-6N7o9oNw_esqCg@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 1 Jun 2023 20:32:38 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5u-vm8RAPvWmmdrVQSMZb=m5wDevJzjpqSKDzMtDvxag@mail.gmail.com>
Message-ID: <CACYkzJ5u-vm8RAPvWmmdrVQSMZb=m5wDevJzjpqSKDzMtDvxag@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix UAF in task local storage
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin Lau <kafai@meta.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 1, 2023 at 8:24=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> On Thu, Jun 1, 2023 at 7:47=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
> >
> > On 6/1/23 9:54 AM, Song Liu wrote:
> > >
> > >
> > >> On Jun 1, 2023, at 9:27 AM, KP Singh <kpsingh@kernel.org> wrote:
> > >>
> > >> On Thu, Jun 1, 2023 at 6:18=E2=80=AFPM Song Liu <song@kernel.org> wr=
ote:
> > >>>
> > >>> On Thu, Jun 1, 2023 at 5:26=E2=80=AFAM KP Singh <kpsingh@kernel.org=
> wrote:
> > >>>>
> > >>>> When the the task local storage was generalized for tracing progra=
ms, the
> > >>>> bpf_task_local_storage callback was moved from a BPF LSM hook call=
back
> > >>>> for security_task_free LSM hook to it's own callback. But a failur=
e case
> > >>>> in bad_fork_cleanup_security was missed which, when triggered, led=
 to a dangling
> > >>>> task owner pointer and a subsequent use-after-free.
> > >>>>
> > >>>> This issue was noticed when a BPF LSM program was attached to the
> > >>>> task_alloc hook on a kernel with KASAN enabled. The program used
> > >>>> bpf_task_storage_get to copy the task local storage from the curre=
nt
> > >>>> task to the new task being created.
> > >>>
> > >>> This is pretty tricky. Let's add a selftest for this.
> > >>
> > >> I don't have an easy repro for this (the UAF does not trigger
> > >> immediately), Also I am not sure how one would test a UAF in a
> > >> selftest. What actually happens is:
> > >>
> > >> * We have a dangling task pointer in local storage.
> > >> * This is used sometime later which then leads to weird memory
> > >> corruption errors.
> > >
> > > I think we will see it easily with KASAN, no?
>
> No, the issue only happens when copy_process fails for some reason
> (which one can possibly trigger with error injection / fexit) and then
> somehow triggers the UAF.
>
> Even if one does manage to trigger the KASAN warning, we won't fail
> the selftest, so I don't see this in the selftest territory TBH. What
> do you have in mind?
>
> > >
> > >>
> > >>>
> > >>>>
> > >>>> Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing p=
rograms")
> > >>>> Reported-by: Kuba Piecuch <jpiecuch@google.com>
> > >>>> Signed-off-by: KP Singh <kpsingh@kernel.org>
> > >>>> ---
> > >>>>
> > >>>> This fixes the regression from the LSM blob based implementation, =
we can
> > >>>> still have UAFs, if bpf_task_storage_get is invoked after bpf_task=
_storage_free
> > >>>> in the cleanup path.
> > >>>
> > >>> Can we fix this by calling bpf_task_storage_free() from free_task()=
?
> > >>
> > >> I think we can yeah. But, this is yet another deviation from how the
> > >> security blob is managed (security_task_free) frees the blob that we
> > >> were previously using.
> >
> > Does it mean doing bpf_task_storage_free() in free_task() will break so=
me use
> > cases? Could you explain?
> > Doing bpf_task_storage_free() in free_task() seems to be more straight =
forward.
>
> Superficially, I don't see any issues . All I am saying is that,
> before we generalized task local storage, it was allocated and freed
> as a security blob and now it's deviating further. Should we just
> consider moving security_task_free into task_free then?

For now, I am going to move bpf_task_storage_free into free_task as
it's the immediate fix and respin.

>
> >
> > >
> > > Yeah, this will make the code even more tricky.
> > >
> > > Another idea I had is to filter on task->__state in the helper. IOW,
>
> bailing out on __state =3D=3D TASK_DEAD should be reasonable.
>
> > > task local storage does not work on starting or died tasks. But I am
> > > not sure whether this will make BPF_LSM less effective (not covering
> > > certain tasks).
>
> As long as the task local storage is usable in LSM hooks like
> security_task_alloc it's okay
>
> > >
> > > Thanks,
> > > Song
> > >
> > >
> >

