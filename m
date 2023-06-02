Return-Path: <bpf+bounces-1635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8E571F72E
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 02:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2B128197B
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 00:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8EA10E9;
	Fri,  2 Jun 2023 00:37:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BE2EA8
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 00:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07B3C4339B
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 00:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685666243;
	bh=Gu8k8o+Lad2BHMmYenoV+ZC4HykmSh3gB1PHww+cZQo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LMslZDUq/w9er2RUfB7oZJizQjHW3rDkIp7n5Q7P0+KW1xfNhjeHyBJFqE742QsVW
	 aqrOnsaBgXdaziXRDyZ1hhW7Zv4tR7+GdhSj1NoZpp+zBGIblih+9auvCVV1h9PZXp
	 zn8We+56mdnUCKb6InSYoiWoCe9fMYrSiO94E9+imYMJJDIwCOTCdzrUfqFX9rF9FF
	 I/hQlFp+Kn9GCtupy+1CpLHf+rbVroxm1nLm79iY8pO7o3Kw6S+mjjO+DfHLLB9g74
	 ds3A4/0TPRB9u7WM7SOQG3HQ7Gbr7bejBl6li6CbGm1xrlLjhBdGTDlFdir96LSFh+
	 Q75VsVSCYJaYg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4f3bb61f860so2032791e87.3
        for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 17:37:23 -0700 (PDT)
X-Gm-Message-State: AC+VfDw1ldAJA/c8WwJNY6/MR7Z5LO41qsLs7xYSdek2w5DtOt2pfi63
	I89tba/IQfhmRF48GNSfUnq58Z0GPszm4JvaiuM=
X-Google-Smtp-Source: ACHHUZ7QGUAsTduN+5wjnWQRpfYN3cbee8OjEpEatDC3b9ZNJ0nBF492cvnaXnsxcMieRWjY8J11Gb4UpAEUhMwPlTg=
X-Received: by 2002:ac2:44ac:0:b0:4e9:bafc:88d0 with SMTP id
 c12-20020ac244ac000000b004e9bafc88d0mr811256lfm.23.1685666241752; Thu, 01 Jun
 2023 17:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602002612.1117381-1-kpsingh@kernel.org>
In-Reply-To: <20230602002612.1117381-1-kpsingh@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 1 Jun 2023 17:37:09 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5VnEOyo=_KMc7VFWwp2iai1Uz9qXvk+Vf9sBy95a-+NQ@mail.gmail.com>
Message-ID: <CAPhsuW5VnEOyo=_KMc7VFWwp2iai1Uz9qXvk+Vf9sBy95a-+NQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix UAF in task local storage
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, kafai@fb.com, ast@kernel.org, songliubraving@fb.com, 
	andrii@kernel.org, daniel@iogearbox.net, Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 1, 2023 at 5:26=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> When task local storage was generalized for tracing programs, the
> bpf_task_local_storage callback was moved from a BPF LSM hook
> callback for security_task_free LSM hook to it's own callback. But a
> failure case in bad_fork_cleanup_security was missed which, when
> triggered, led to a dangling task owner pointer and a subsequent
> use-after-free. Move the bpf_task_storage_free to the very end of
> free_task to handle all failure cases.
>
> This issue was noticed when a BPF LSM program was attached to the
> task_alloc hook on a kernel with KASAN enabled. The program used
> bpf_task_storage_get to copy the task local storage from the current
> task to the new task being created.
>
> Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing programs=
")
> Reported-by: Kuba Piecuch <jpiecuch@google.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Acked-by: Song Liu <song@kernel.org>

Thanks,
Song

> ---
>
> * v1 -> v2
>
> Move the bpf_task_storage_free to free_task as suggested by Martin
>
>  kernel/fork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index ed4e01daccaa..cb20f9f596d3 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -627,6 +627,7 @@ void free_task(struct task_struct *tsk)
>         arch_release_task_struct(tsk);
>         if (tsk->flags & PF_KTHREAD)
>                 free_kthread_struct(tsk);
> +       bpf_task_storage_free(tsk);
>         free_task_struct(tsk);
>  }
>  EXPORT_SYMBOL(free_task);
> @@ -979,7 +980,6 @@ void __put_task_struct(struct task_struct *tsk)
>         cgroup_free(tsk);
>         task_numa_free(tsk, true);
>         security_task_free(tsk);
> -       bpf_task_storage_free(tsk);
>         exit_creds(tsk);
>         delayacct_tsk_free(tsk);
>         put_signal_struct(tsk->signal);
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>
>

