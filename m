Return-Path: <bpf+bounces-1593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EF471EE98
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 18:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F5F281668
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 16:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D0A42513;
	Thu,  1 Jun 2023 16:18:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B7E22D77
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 16:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C07C4339C
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 16:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685636314;
	bh=5JFRDAGHyLTDyHyT/r5fwG60Rmyvqw3Xizu4Rql+pGI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XUKw5jgXkvHHLBJ+O2+rTyazm/uPOYIn2u0zjdZv6wh6/epi4gIFeaFV506Ch9ZYy
	 V4oni6lQTyaxhMXbF/UgX4vcBblzDF/rdrNGy4XUwaZ+sOyA9gh41ENbG+SjfcRRYR
	 bya1T0Gg/WoV4QLP+ecTpz/tIUfYCiDRmc9b0XBH+D92h8r2V4EBbpEzD9m8gOoetd
	 0x73A5Ldbb6OgB17hPisOCC/55zYWoBaeIssKJZlkmyZurXVL77GbjV/E7E2Q4/RYC
	 SdEmz74DzIdwqnWgrvHni8eBLLwefGJjUqATzDeJcStPOQ8cKV7RDZd7eZQfr3tbPk
	 NixnSKWecXVvw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2af177f12d1so15388461fa.0
        for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 09:18:34 -0700 (PDT)
X-Gm-Message-State: AC+VfDw7jiEsYOOFZq88oeMmophP9U4xqcTu5B9sif3UtyAT/7tfPshF
	UTzIcujiZPzNztPRVWnDCd9DNoDpXoN5j1l2Kp8=
X-Google-Smtp-Source: ACHHUZ7Jf0NEOanNDNsRthX3LYhe8GIn5iRs5Rxcq/IllC1DMDhvtqS6h7S00BEq5liYKh3bqct6WkdZ8ET7nifKTIk=
X-Received: by 2002:a2e:9e47:0:b0:2ab:145e:c04a with SMTP id
 g7-20020a2e9e47000000b002ab145ec04amr5430692ljk.17.1685636312291; Thu, 01 Jun
 2023 09:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230601122622.513140-1-kpsingh@kernel.org>
In-Reply-To: <20230601122622.513140-1-kpsingh@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 1 Jun 2023 09:18:19 -0700
X-Gmail-Original-Message-ID: <CAPhsuW45Sb0TeOYouTvaVDhOGfz+2nBht0AmGyF4=yq15HE8AA@mail.gmail.com>
Message-ID: <CAPhsuW45Sb0TeOYouTvaVDhOGfz+2nBht0AmGyF4=yq15HE8AA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix UAF in task local storage
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, kafai@fb.com, ast@kernel.org, songliubraving@fb.com, 
	andrii@kernel.org, daniel@iogearbox.net, Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 1, 2023 at 5:26=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote:
>
> When the the task local storage was generalized for tracing programs, the
> bpf_task_local_storage callback was moved from a BPF LSM hook callback
> for security_task_free LSM hook to it's own callback. But a failure case
> in bad_fork_cleanup_security was missed which, when triggered, led to a d=
angling
> task owner pointer and a subsequent use-after-free.
>
> This issue was noticed when a BPF LSM program was attached to the
> task_alloc hook on a kernel with KASAN enabled. The program used
> bpf_task_storage_get to copy the task local storage from the current
> task to the new task being created.

This is pretty tricky. Let's add a selftest for this.

>
> Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing programs=
")
> Reported-by: Kuba Piecuch <jpiecuch@google.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>
> This fixes the regression from the LSM blob based implementation, we can
> still have UAFs, if bpf_task_storage_get is invoked after bpf_task_storag=
e_free
> in the cleanup path.

Can we fix this by calling bpf_task_storage_free() from free_task()?

Thanks,
Song

>
>  kernel/fork.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index ed4e01daccaa..112d85091ae6 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2781,6 +2781,7 @@ __latent_entropy struct task_struct *copy_process(
>         exit_sem(p);
>  bad_fork_cleanup_security:
>         security_task_free(p);
> +       bpf_task_storage_free(p);
>  bad_fork_cleanup_audit:
>         audit_free(p);
>  bad_fork_cleanup_perf:
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>
>

