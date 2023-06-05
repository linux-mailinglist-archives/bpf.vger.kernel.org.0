Return-Path: <bpf+bounces-1893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D16572337C
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 01:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C421A1C20AD8
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 23:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE362773C;
	Mon,  5 Jun 2023 23:04:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9327737F
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 23:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F56C4339E
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 23:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686006253;
	bh=xHOcnFlkugy3x7S56YCQoSLu3aoakeGtfcuIWbggugY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eYboBtCUFsgW+a143b3AywRzXrjghBQa4rlCNlja+MX7GAMbzpZ/POZspSF0iYpDm
	 dKIa9kvR857OuWYasSJk/M9LfEueQXGkT7M6wnEZ4gEIaM6VgaaxW8SCVG+fh9Emrz
	 CMJDH2HtlV/Y+nJ7FXkDhsq5bGq//fSMGnoaML4L3l6Vrxdemz51aDeWUx2vQL9xog
	 /Kbfh1MgcthLdFOcMAWJOnFIWJblxEb1NQ8fdU/XfagUfgyPrX6CVc2qrVg52llYbr
	 MXNi3W7zCa+mmxHSlljsSS8MoyCGDKD5F0g8j/1GOBaDK+sB+0d888CisCV6DAYOHr
	 8BpeMPLXWkEsA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5148f299105so11249484a12.1
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 16:04:12 -0700 (PDT)
X-Gm-Message-State: AC+VfDwdBuBjz8bbDk1vaO3wPGAg4baLRTlWlTt4Jy4ov6kxeLFKS9nU
	ZJ7XP7n0K5H6hpRFbYKYBIcvpciAS7wlKfjvrapMMA==
X-Google-Smtp-Source: ACHHUZ5Bw7Ugm+PWh1N6AnrRdHzu+2j2naQfZt7HVPnAlvrAs5iZQZdfI0Htsj9yRp+eEuJw4i6M3QRLQ1QO5vJXZ4k=
X-Received: by 2002:a05:6402:b35:b0:513:fa61:397a with SMTP id
 bo21-20020a0564020b3500b00513fa61397amr394574edb.12.1686006251196; Mon, 05
 Jun 2023 16:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602002612.1117381-1-kpsingh@kernel.org> <5abdfec7-99ac-be3a-634c-3eb666538ef4@linux.dev>
In-Reply-To: <5abdfec7-99ac-be3a-634c-3eb666538ef4@linux.dev>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 6 Jun 2023 01:04:00 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6b2-8dYVT2krcNkNZQQvtVL+ek2VR-kKQbH71vAmgzBQ@mail.gmail.com>
Message-ID: <CACYkzJ6b2-8dYVT2krcNkNZQQvtVL+ek2VR-kKQbH71vAmgzBQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix UAF in task local storage
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, songliubraving@fb.com, andrii@kernel.org, 
	daniel@iogearbox.net, Kuba Piecuch <jpiecuch@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 2, 2023 at 8:02=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 6/1/23 5:26 PM, KP Singh wrote:
> > When task local storage was generalized for tracing programs, the
> > bpf_task_local_storage callback was moved from a BPF LSM hook
> > callback for security_task_free LSM hook to it's own callback. But a
> > failure case in bad_fork_cleanup_security was missed which, when
> > triggered, led to a dangling task owner pointer and a subsequent
> > use-after-free. Move the bpf_task_storage_free to the very end of
> > free_task to handle all failure cases.
> >
> > This issue was noticed when a BPF LSM program was attached to the
> > task_alloc hook on a kernel with KASAN enabled. The program used
> > bpf_task_storage_get to copy the task local storage from the current
> > task to the new task being created.
> >
> > Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing progra=
ms")
> > Reported-by: Kuba Piecuch <jpiecuch@google.com>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >
> > * v1 -> v2
> >
> > Move the bpf_task_storage_free to free_task as suggested by Martin
> >
> >   kernel/fork.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index ed4e01daccaa..cb20f9f596d3 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -627,6 +627,7 @@ void free_task(struct task_struct *tsk)
> >       arch_release_task_struct(tsk);
> >       if (tsk->flags & PF_KTHREAD)
> >               free_kthread_struct(tsk);
> > +     bpf_task_storage_free(tsk);
>
> Applied. Thanks for the fix.
>
> A followup question, does it need a "notrace" to be added to
> bpf_task_storage_free to ensure no task storage can be recreated?

Should we do a notrace or a BTF set based deny list?

