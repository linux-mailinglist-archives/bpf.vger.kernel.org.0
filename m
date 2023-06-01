Return-Path: <bpf+bounces-1595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5212871EEEA
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 18:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97CC1C20ACD
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 16:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF524251D;
	Thu,  1 Jun 2023 16:27:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6811722D6B
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 16:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83DEC4339E
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 16:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685636865;
	bh=QE0XSagsa2DQLg9IscaA8maH28AaIQ/fD6jN5dA8Z+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i8zamJm98zIuJj2clV+U+VOx5XWBeR8BQt5cf6mzzNlU/gHnnKl3sYA+fIveLJVQ6
	 UlfSGNTy387R7KbeHlQxXToTcYXlrwCOqPmzpcQGim8g2UCiNAWCkI+wsFq0fjKTB/
	 fKi8NYio+q0U1MnUdNbpqs9PZeT0f1ckiwE9peDksXFLz3G1y/mZ+QZWUc6cXj04Cp
	 JgQ+6oiZc/CZ7jr3h+q3ODr28CaTEHTJjDrfaKY6HiPg11hzJ7ZhyvwwpGoEfGc8ON
	 3OcLcylZhOrD1eCNuFETWKlmrlzMD2b0YGaRTXdzxkN5IflslVTE/FkGvC+987cEz5
	 Xq0573BLelM0A==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5147e441c33so2456617a12.0
        for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 09:27:45 -0700 (PDT)
X-Gm-Message-State: AC+VfDwv0GE0sXRBeBzxLpE/LkmXDnNaZREKJkU2bYc612VLvdzfnkRB
	U5Q71ExGcULRXsuBJMZqfmGzsaU3aRFWp9tmH8hpRg==
X-Google-Smtp-Source: ACHHUZ7HhpdqOisBzUSlFXCyc3z3wx+lp46dTGnKF9EKUmtlrcgWpd4vg2fi/F5k2e/yqpce25LMN4g7SFl+4zyJx24=
X-Received: by 2002:a05:6402:2551:b0:514:a21b:f137 with SMTP id
 l17-20020a056402255100b00514a21bf137mr485952edb.6.1685636863988; Thu, 01 Jun
 2023 09:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230601122622.513140-1-kpsingh@kernel.org> <CAPhsuW45Sb0TeOYouTvaVDhOGfz+2nBht0AmGyF4=yq15HE8AA@mail.gmail.com>
In-Reply-To: <CAPhsuW45Sb0TeOYouTvaVDhOGfz+2nBht0AmGyF4=yq15HE8AA@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 1 Jun 2023 18:27:33 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7S7JwX77NSSurr1wWYnFQs0TZwUKcwW5Zmva3CkkAx5w@mail.gmail.com>
Message-ID: <CACYkzJ7S7JwX77NSSurr1wWYnFQs0TZwUKcwW5Zmva3CkkAx5w@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix UAF in task local storage
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, kafai@fb.com, ast@kernel.org, songliubraving@fb.com, 
	andrii@kernel.org, daniel@iogearbox.net, Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 1, 2023 at 6:18=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Jun 1, 2023 at 5:26=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrot=
e:
> >
> > When the the task local storage was generalized for tracing programs, t=
he
> > bpf_task_local_storage callback was moved from a BPF LSM hook callback
> > for security_task_free LSM hook to it's own callback. But a failure cas=
e
> > in bad_fork_cleanup_security was missed which, when triggered, led to a=
 dangling
> > task owner pointer and a subsequent use-after-free.
> >
> > This issue was noticed when a BPF LSM program was attached to the
> > task_alloc hook on a kernel with KASAN enabled. The program used
> > bpf_task_storage_get to copy the task local storage from the current
> > task to the new task being created.
>
> This is pretty tricky. Let's add a selftest for this.

I don't have an easy repro for this (the UAF does not trigger
immediately), Also I am not sure how one would test a UAF in a
selftest. What actually happens is:

* We have a dangling task pointer in local storage.
* This is used sometime later which then leads to weird memory
corruption errors.

>
> >
> > Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing progra=
ms")
> > Reported-by: Kuba Piecuch <jpiecuch@google.com>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >
> > This fixes the regression from the LSM blob based implementation, we ca=
n
> > still have UAFs, if bpf_task_storage_get is invoked after bpf_task_stor=
age_free
> > in the cleanup path.
>
> Can we fix this by calling bpf_task_storage_free() from free_task()?

I think we can yeah. But, this is yet another deviation from how the
security blob is managed (security_task_free) frees the blob that we
were previously using.

>
> Thanks,
> Song
>
> >
> >  kernel/fork.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index ed4e01daccaa..112d85091ae6 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2781,6 +2781,7 @@ __latent_entropy struct task_struct *copy_process=
(
> >         exit_sem(p);
> >  bad_fork_cleanup_security:
> >         security_task_free(p);
> > +       bpf_task_storage_free(p);
> >  bad_fork_cleanup_audit:
> >         audit_free(p);
> >  bad_fork_cleanup_perf:
> > --
> > 2.41.0.rc0.172.g3f132b7071-goog
> >
> >

