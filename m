Return-Path: <bpf+bounces-14811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DD27E86D4
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 01:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D4D1F20F3B
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 00:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25FAEDB;
	Sat, 11 Nov 2023 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXXQFP/s"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81F372;
	Sat, 11 Nov 2023 00:10:27 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EF73C39;
	Fri, 10 Nov 2023 16:10:26 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50797cf5b69so3508921e87.2;
        Fri, 10 Nov 2023 16:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699661424; x=1700266224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iUpKnAP+GZy4RHyPvoIjHluSL+zR9tj4/HlA//4Cq4=;
        b=GXXQFP/s3WGR54dXdTnEVD0pt/kBZ4y0TD5w8U4TNsH71/x2vBAP/nEE1t0FxAUoVl
         bgT6U4A8wRnPEWUHiO24+j4hg+JBmU5H1W7jb40plv3jkPcl+TddZj7W9c/xphY+w767
         3AfA5kPmBXl9m/nVMMoW4nBPXzlOrPagyczueFM0/U7PsFsSEPO8IeZwOZUUG9VOJTVa
         mDc8OpQ1nqpdfklQfjQqxDt6fMIyfVuUfLjQ5b83HNRi55RLhQyM3UY9E9uZx+d0MC5a
         EwkeuwPBVYLGvEDhkjgQ1bknDcF2uHZ35b3ZUHBaEstJkxjCBPCRVscfOrT3ACtINcTy
         wYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699661424; x=1700266224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iUpKnAP+GZy4RHyPvoIjHluSL+zR9tj4/HlA//4Cq4=;
        b=pQBqbZupnSPzQzB41Jmt84o+6vCjp6agXliKdi/Ucx1SkomtMgxKOeq3nKr3wMNBWm
         fuzj9OUpZOXGLOoCkadklnVOR6aDnooau74s3j+YtCKEda58y3igF2Yezve9oLtl4RW9
         vMX96s7zm37Zi5GTKEXC36DLtmfZYApxXuWWK1A5wI2dx66rmAJnXK9r6HLqq0NfaMzv
         qNNRJ2aSdD8ijmy6oCRNS4cCW7xfBGniamVxTk/ejurgkoQoeIVfDf/oBjbK3qyPz6Ec
         okjEeHk3XzIbtLN3Pcl8Gql5XcadkwozWOtc+50X3INcK2hCm656QQkJqThQdgixQryi
         7neQ==
X-Gm-Message-State: AOJu0YxOTriXpYRtbVwc1zHKMv8EUCSESq+Bl2ohIlyaQkcUWiqsRW4F
	2j7dWyf4GUMtMideYIluOMftoLy2fxb4ocsLDkj8RjZf
X-Google-Smtp-Source: AGHT+IF9Xyu5EaFiMDd1Oslutv8xlJxIaeJXH+mNAkqjONZZZr5o/hUbRrq1b0RJmj4tXiznTsfqpiHOWq5kNhcWltY=
X-Received: by 2002:ac2:5551:0:b0:509:2b80:f90c with SMTP id
 l17-20020ac25551000000b005092b80f90cmr301025lfk.68.1699661424162; Fri, 10 Nov
 2023 16:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110235021.192796-1-linux@jordanrome.com>
In-Reply-To: <20231110235021.192796-1-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Nov 2023 16:10:13 -0800
Message-ID: <CAEf4BzaWtOeTBb_+b7Td3NHaKjZU+OohuBJje_nvw9kd6xPA3g@mail.gmail.com>
Subject: Re: [PATCH perf] perf: get_perf_callchain return NULL for crosstask
To: Jordan Rome <linux@jordanrome.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 3:51=E2=80=AFPM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> Return NULL instead of returning 1 incorrect frame, which
> currently happens when trying to walk the user stack for
> any task that isn't current. Returning NULL is a better
> indicator that this behavior is not supported.
>
> This issue was found using bpf_get_task_stack inside a BPF
> iterator ("iter/task"), which iterates over all tasks. The
> single address/frame in the buffer when getting user stacks
> for tasks that aren't current could not be symbolized (testing
> multiple symbolizers).
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  kernel/events/callchain.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 1273be84392c..430fa544fa80 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -201,6 +201,9 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr,=
 bool kernel, bool user,
>         }
>
>         if (user) {
> +               if (crosstask)
> +                       return NULL;

I think you need that goto exit_put here.

> +
>                 if (!user_mode(regs)) {
>                         if  (current->mm)
>                                 regs =3D task_pt_regs(current);
> @@ -209,9 +212,6 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr,=
 bool kernel, bool user,
>                 }
>
>                 if (regs) {
> -                       if (crosstask)
> -                               goto exit_put;
> -
>                         if (add_mark)
>                                 perf_callchain_store_context(&ctx, PERF_C=
ONTEXT_USER);
>
> @@ -219,7 +219,6 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr,=
 bool kernel, bool user,
>                 }
>         }
>
> -exit_put:
>         put_callchain_entry(rctx);
>
>         return entry;
> --
> 2.39.3
>

