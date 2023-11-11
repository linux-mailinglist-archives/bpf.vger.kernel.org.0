Return-Path: <bpf+bounces-14883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481327E8C7F
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 21:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E67280DF3
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 20:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714341D55D;
	Sat, 11 Nov 2023 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lru2VNGC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D51D532;
	Sat, 11 Nov 2023 20:16:28 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A8A30CF;
	Sat, 11 Nov 2023 12:16:25 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507962561adso4773544e87.0;
        Sat, 11 Nov 2023 12:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699733783; x=1700338583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anX/O1ZyHX/bAkTSiEeTTeh9inf0Mby4QqMwrhDOwKM=;
        b=lru2VNGCM3WgcI2eim5RHvKMdk+N3ut+sfK71vz8JKvytCSVbzwNgSGkgnvo5EbtfU
         3ttcTOkv4YSz5QeB/kumJVJT1bRnhXuV0/R+1GYqyJthA1ssoXa/rcA52wkJVBHY8jvv
         1qUPliyvN6Gd7GnG4feFXq3+coFkizdSBIQjYk75K7xIwtUN4eJd13fmiO6r7qizuzi/
         vLBPkRjJVDWOvYB+ZCN7yy3XrzdVZIVig2twsF2Wcv8sS3C3mBxKlYig494Dym2aTSp8
         8DwoDiwnAj9Q+xczW9pXEhmafIqiUMs8lEoed6N9YnFccDl1JjOPqDRs9rRVPYmKsQLb
         ZWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699733783; x=1700338583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anX/O1ZyHX/bAkTSiEeTTeh9inf0Mby4QqMwrhDOwKM=;
        b=C+XAwb2j33dv+AO0FcHPgearRzE8Ob6LwLXT9rHMTo1EBqLaICbqXg9fHZiTkZYRsU
         4wDzLGaenoqy5tNDRBJaY8igOijO/oYIGRwWmy0yNkKB6s4w966xsGC/vyMm0n3JN+rm
         ln0+XCzPy+8b63qGn98f/LzHT0Ir8YvanjrNFpa5z2arudbf02yjaZ9nebaYQBWL+Nhf
         punB4h+LSm4oVdQantG90bIwjLxxDD79NZtg4+mpqLzssQgO4CB1t1A/uv//cupIxgKX
         1GhT5fHBkarNxdLOYGWG2g4saDSpcq9D7qWUDQ5J5zJX5/ar1D7yuB9EvZdV9srNmnFi
         MCGQ==
X-Gm-Message-State: AOJu0Yz95ehFD/EXM1fMQuHD5hPksTD1E+7lpup9e7zsbAt7xC7drPvV
	DN/jXUqR6X2l625aZM0utzSBAmfb6W4dTO1NWig=
X-Google-Smtp-Source: AGHT+IHZtt6XxuQfcj7eNpCMe2MN3/Agc8m2uDdxVwJDhsRFIaxLiWj1nZwpJG7Qxxek/Nge6GRDJOUEXp22U8zxEIo=
X-Received: by 2002:a19:381b:0:b0:509:8a5e:654d with SMTP id
 f27-20020a19381b000000b005098a5e654dmr1592575lfa.21.1699733782837; Sat, 11
 Nov 2023 12:16:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111172001.1259065-1-linux@jordanrome.com>
In-Reply-To: <20231111172001.1259065-1-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 11 Nov 2023 12:16:11 -0800
Message-ID: <CAEf4BzYbjqsfG9yFsU3epT=Zp98LTEBuVNkkSSK3ab9pQtt8uA@mail.gmail.com>
Subject: Re: [PATCH v2] perf: get_perf_callchain return NULL for crosstask
To: Jordan Rome <linux@jordanrome.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Peter Zijlstra <peterz@infradead.org>, Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 9:20=E2=80=AFAM Jordan Rome <linux@jordanrome.com> =
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
>
> Changes in v2:
> * move user and crosstask check before get_callchain_entry
>

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> v1:
> https://lore.kernel.org/linux-perf-users/CAEf4BzaWtOeTBb_+b7Td3NHaKjZU+Oo=
huBJje_nvw9kd6xPA3g@mail.gmail.com/T/#t
>
>  kernel/events/callchain.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 1273be84392c..104ea2975a57 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -184,6 +184,9 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr,=
 bool kernel, bool user,
>         struct perf_callchain_entry_ctx ctx;
>         int rctx;
>
> +       if (user && crosstask)
> +               return NULL;
> +
>         entry =3D get_callchain_entry(&rctx);
>         if (!entry)
>                 return NULL;
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

