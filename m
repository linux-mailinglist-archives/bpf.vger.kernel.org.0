Return-Path: <bpf+bounces-56530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3842A9977A
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 20:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6851B82391
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 18:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB6928D829;
	Wed, 23 Apr 2025 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY+apih7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E19426A0D6;
	Wed, 23 Apr 2025 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431713; cv=none; b=aoTU8paE42uUo7psGbDNFf/vs4DOiMkSxyS0u6DgsOSXkOXptNsZatQM5uHjtXRe5TuhzmxX9wndjnF7lwTYHCaNZrN2Tqvo3n5QSwAY1nnY3ErO43txKXxL/kal8VFO5a/tKcC9ez6s4atfcL/02s1cbia+IQq7ObHpeBwW2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431713; c=relaxed/simple;
	bh=Qa109e2Yerw+mY7jqK/IU4w9d41jbcc6x0fyLkrDnas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asV5mXGPXS0uWsECkSBGoC5SScAgCUe8uKaLIvzSmxLiLpqYo5LRKICKSvlUDLSGUlqONcZNXHK9SaciI3Mgw9vU06MSaGuQlGtSIadTMXJYi8L2k/5UDku17rK0Zh5yIl8pf14uiSqPtrLAMHNFpo08CZx1jKrfQJ9iGJFZZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AY+apih7; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac29fd22163so25348266b.3;
        Wed, 23 Apr 2025 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745431709; x=1746036509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xi60dEtyUhPZNtpwovqAvM845aWNbX2RRNkZ0SaNpQQ=;
        b=AY+apih7D9iZQGY76nGRRVk2rpH2xMNfz+R7NK0pfMfwh6519MCAUyD1buBQNTRm0j
         xV622T/bSW2YsjYWBFcoazHIvp2xU4Fec1hx43eVW5Rz2pXG68uU02sjV9bvM8zqWDoN
         lX/gZoEWBQYSQx5MZ0JDRzW/bNm/PkGrtzmiFzXetJVKkpacVmxXLjCU4hAVaM7biQoG
         LoIzWdnUWuTJFHI9PVJsLrmYfLZZXZLjceR00vp+JAT3itgHLZ9L4P4D5GL4p96z5oCZ
         eK0Heks+cbDkws/Qh1/2rfUanZjvlWCtHdUPnlu7nyWft6ZMYrnGsQGsylVY9Hx4Ynmx
         EmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745431709; x=1746036509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xi60dEtyUhPZNtpwovqAvM845aWNbX2RRNkZ0SaNpQQ=;
        b=hV57HynVqGkK8VsxoJWTOlgWA1qH8HPV5PPJW8pOhriY1D8KzzRKtKl1C/GXOCGRsR
         yQxaXTP/a1fvx8tkjimtaUG5GCnC+Xp3V9MIIbibEbj/9XmrnHL5TcmIwY42jMtopUcQ
         eWAITgNE+aOdsE1JtQO24KqqyyZq0UumJuHL/KEz5Bd9kkBP/2VXCEfdl9z9Vk4GPn9E
         EYShXAv3KALtoJpAcvHmxTz4LLgNxNyslaqO5MQrfVnpPd+6226jL7eOJhTo5cXQzgCh
         MyEhnK38hNgHdRhTAGmRjpR8MM+mID9rWz9dq5qmPIHxYeN3OvoOXhRH4nMoruTqvbAH
         zn0g==
X-Forwarded-Encrypted: i=1; AJvYcCU/yGcqDtcUGEOEi4lV122gk+RY8s3gjhrn6ExhYQpzcEkC9E8XEtyBkVySy9JSvhkmZ9o=@vger.kernel.org, AJvYcCWT4GdxDzZtGr0hRddQ5vB6DTy9Kur3lkBk+Q2QS/7IZdzWC3BIM0lY/+kqoVes/TNtmbJGDjbOTtOehJl6@vger.kernel.org, AJvYcCWlD6ZrmqxQkjtWm6kITaKvobuzN/XgDBdeA5Vdsq29Zku7fmZn5SxrwbtAUy2WVD0YEUN5CQ65DRv18OKX91D55KvS@vger.kernel.org
X-Gm-Message-State: AOJu0YwnktYOUSSf4ifPKm0MznkI4rJggIvySa6TlhzSFjmai+2I4026
	UTdosRnhQFcW8XRM5KKisRwT96+IDG1NHwwFZC/xzjiqnFat+Us0RMP19/FS4JdXlcsmvG0cZ/V
	ZgXWk1xmYEfIiCqo0tufDopbAZgncEWpF
X-Gm-Gg: ASbGnct9/UcIz/kBs2S7fBWnF/yRoAdQaKFvKKTd8eKxJGyTChO74NX7je4/uzVDLbU
	Mn84Ddu+YuQWPr5jJ3mpyyhTB7uBKHyLsoz8UBv9gIwag0iNfKJkVnL8HgiVc1/v+S0JHtpvQLy
	/1ibf3WMHAJAPTugyGfrMQCTkU2ZzJ45CSYYL6tQ==
X-Google-Smtp-Source: AGHT+IEUz+FjvBAD0SgTo5QNsN500GYb2FaOEiFZf2hUtW3G4MlRraoJZ25kw8TmyqSeLTC0Rt6SB03a01k9n1/8QzE=
X-Received: by 2002:a17:907:1c10:b0:aca:cda9:3170 with SMTP id
 a640c23a62f3a-acb74d65bacmr1910978866b.46.1745431709234; Wed, 23 Apr 2025
 11:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423073151.297103-1-yangfeng59949@163.com>
In-Reply-To: <20250423073151.297103-1-yangfeng59949@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 11:08:14 -0700
X-Gm-Features: ATxdqUGYawM4t6dv3vcfJQGfxK9pbDXk54HpkHaSvGFwCeEH0FwcNdd-mxfiJA0
Message-ID: <CAEf4Bza6gK3dsrTosk6k3oZgtHesNDSrDd8sdeQ-GiS6oJixQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: streamline allowed helpers between
 tracing and base sets
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 12:33=E2=80=AFAM Feng Yang <yangfeng59949@163.com> =
wrote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> Many conditional checks in switch-case are redundant
> with bpf_base_func_proto and should be removed.
>
> Regarding the permission checks bpf_base_func_proto:
> The permission checks in bpf_prog_load (as outlined below)
> ensure that the trace has both CAP_BPF and CAP_PERFMON capabilities,
> thus enabling the use of corresponding prototypes
> in bpf_base_func_proto without adverse effects.
> bpf_prog_load
>         ......
>         bpf_cap =3D bpf_token_capable(token, CAP_BPF);
>         ......
>         if (type !=3D BPF_PROG_TYPE_SOCKET_FILTER &&
>             type !=3D BPF_PROG_TYPE_CGROUP_SKB &&
>             !bpf_cap)
>                 goto put_token;
>         ......
>         if (is_perfmon_prog_type(type) && !bpf_token_capable(token, CAP_P=
ERFMON))
>                 goto put_token;
>         ......
>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> Acked-by: Song Liu <song@kernel.org>
> ---

LGTM, applied to bpf-next, thanks. See comments on remaining helpers below.

> Changes in v4:
> - Only modify patch description information.
> - At present, bpf_tracing_func_proto still has the following ID:
> - BPF_FUNC_get_current_uid_gid
> - BPF_FUNC_get_current_comm

I don't see why these two cannot be used in any program, after all, we
have bpf_get_current_task(), these are in the same family.

> - BPF_FUNC_get_smp_processor_id

Based on another thread, I think it's some filter programs that have
to use raw variant of it, right? All other should use non-raw
implementation. So I think the right next step would be to make sure
that bpf_base_func_proto returns non-raw implementation, and only
those few program types that are exceptions should use raw ones?

> - BPF_FUNC_perf_event_read

should be fine to use anywhere (and actually can be useful for
networking programs to measure its own packet processing overhead or
something like that). Checking implementation I don't see any
limitations, it's just PERF_EVENT_ARRAY map access

> - BPF_FUNC_probe_read
> - BPF_FUNC_probe_read_str

generic tracing helpers, should be OK to be used anywhere with
CAP_PERFMON capabilities

> - BPF_FUNC_current_task_under_cgroup

same as above current_comm, if there is CGROUP_ARRAY, this should be
fine (though I don't know, there might be cgroup-specific
restrictions, not sure)

> - BPF_FUNC_send_signal
> - BPF_FUNC_send_signal_thread

fine to do from NMI, so should be fine to do anywhere (with
CAP_PERFMON, presumably)

> - BPF_FUNC_get_task_stack

seems fine (again, if it works under NMI and doesn't use any
context-dependent things, should be fine for any program type)

> - BPF_FUNC_copy_from_user
> - BPF_FUNC_copy_from_user_task

same as probe_read/probe_read_str (but only for sleepable)

> - BPF_FUNC_task_storage_get
> - BPF_FUNC_task_storage_delete

this is designed to work anywhere, so yeah, why not?

> - BPF_FUNC_get_func_ip

nope, very context dependent, definitely not generic (and just doesn't
make sense for most program types)

> - BPF_FUNC_get_branch_snapshot

NMI-enabled and not context-dependent, good to be used anywhere

> - BPF_FUNC_find_vma

non-sleepable, but other than that doesn't really make any assumptions
about program type, should be fine everywhere (NMI-safe, I believe?)

> - BPF_FUNC_probe_write_user

it's just like probe_read_user, CAP_PERFMON, so we can enable it
anywhere for completeness, but I'm not sure if that is a good idea...

> - I'm not sure which ones can be used by all programs, as Zvi Effron said=
(https://lore.kernel.org/all/CAC1LvL2SOKojrXPx92J46fFEi3T9TAWb3mC1XKtYzwU=
=3DpzTEbQ@mail.gmail.com/)
> - get_smp_processor_id also be retained(https://lore.kernel.org/all/CAADn=
VQ+WYLfoR1W6AsCJF6fNKEUgfxANXP01EQCJh1=3D99ZpoNw@mail.gmail.com/)

yep, I saw the discussion, that's fine

>
> - Link to v3: https://lore.kernel.org/all/20250410070258.276759-1-yangfen=
g59949@163.com/
>
> Changes in v3:
> - Only modify patch description information.
> - Link to v2: https://lore.kernel.org/all/20250408071151.229329-1-yangfen=
g59949@163.com/
>
> Changes in v2:
> - Only modify patch description information.
> - Link to v1: https://lore.kernel.org/all/20250320032258.116156-1-yangfen=
g59949@163.com/
> ---
>  kernel/trace/bpf_trace.c | 72 ----------------------------------------
>  1 file changed, 72 deletions(-)
>

[...]

