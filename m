Return-Path: <bpf+bounces-75283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E499C7C147
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 02:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 335DB4E2899
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 01:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E01A2BEC2B;
	Sat, 22 Nov 2025 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFbN1LFy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2E62BD5A1
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763774236; cv=none; b=oFX5migPHv1e46e8cSasG2qiBnu81xydhWhd/uHgYU5qP0wr9WDi7fz/q4YQljob5Lmr/fii7P9NcumVxlu0A0jugEee4QAQTArUsOGEp+9rd/33Ew8J0rwEVoXuzBLA7dsjwkuKY40n/Ed61F6rvG8sqpaBe7MrEQYUi/oDrgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763774236; c=relaxed/simple;
	bh=r/wNp+uT7kNGVIG33eEk96nQ/Gyfec08QQFMLjr8oMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgV5PTs2An+b1/v4GW+UIgni7lq38NVOw6UGqaC9t+a1NnGAdsi6noMRDsPfwv2E+7QxutMH9UhIB6exZBCISPhHPGUShHfgx/Eu1slEXQaEpQzIuyyCA8qlaO8tbnWOXlo7EMDOZHSoIp/Lno6ETvlFoirXPhdaGTvhyzkLdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFbN1LFy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4775ae77516so27946355e9.1
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 17:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763774232; x=1764379032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlPYGH9VlLRPLaD0U7L1Ut36F8Yv81tkSPf4NJ6dfKg=;
        b=lFbN1LFyEatbEC6laqVTQuUIGyt/K1GNRbcg1XvUqky8rTaDJkyKUmus+cke6Mlj+1
         ILYwk57HjTL+TfP4vGwJ9wib/0EaV77HD5/FB9rMNKy76YjvuBX5sG3OWWl/ffdw84gR
         B9kDMkbGjsQl+kqz7bYPZGhzcW6ESmKGdurPxqmv/wkDu17mZyOScQZo6/UAo5mUbUZe
         QXMCz38e4LfAaaMlc+kkn+l1ukduUYH20RZEek0x9ckCVkc2b2t3OCVy88JqqWw6aD66
         1WDGvQEAel4EtugQuW19PQOUmKdSPDD2Z+wH9ZoC/7USkuMBTlmr2DuWc6gz8AkPoihl
         p0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763774232; x=1764379032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NlPYGH9VlLRPLaD0U7L1Ut36F8Yv81tkSPf4NJ6dfKg=;
        b=lGcu3JHbXgOS20bSeCablO5cI05cIdmTkO0q3EhJ20DG6R5I+WOiZuJLfneTGJL8Qt
         giybKII18ymJrWsi/16THPPhdJwsBFphcTk78VGul7VlSgK5QwAQwm3btq5odR3E312G
         3W8th813xX+Y0tQ+XIufEEBgb/w2Y8Fom3fz1lcSfblyIfEQf+ltxKDwC0Bk+dOaVNLz
         CmSdMRM7xEh2uVTTmoU4kSZRHB+N76tgE+PkucXQcXzUEq8HEAYAKUdhInFh8b9WDx2s
         IM/Gbyq8vViK7/dQwjUSO3v4xkyRTO/8aiyt79FxVzkphV08QsRK7b1uG4rHxDwHJjM1
         jgwg==
X-Forwarded-Encrypted: i=1; AJvYcCXx21ttG0JeP2LfF2LSNfJg6wGFsqm4is8LLEB/imcSZ6r1TXsqiCR6MkZo4+NuUEHGXf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxFclFwVouinnihxI+a7j3UjSoVPT2D/G4hoXmmC1AfV9ckaw5
	1ELGUGI1EIbFoeCwJ8fGqV0k65kLh3dANPFjD947KDxVVF7KPnj8/s9hxfHy+qP7Kv3yrJw506J
	jfVeuWK4p65d+r/JocS/28+MeqjqY7ts=
X-Gm-Gg: ASbGncsZ3D9pt7ofJXsk1PIj6+fsXLy/vcQcTclqRYBPdlGlQcxOh3vGZFAkXNHCV5k
	OTluk6/grUMPvwrvUCTE97gFFuueW6ae76YHu0w4mKTJG39B99elgtVpODU1oayPptqZJ/zltan
	fm6DEPdzADgo64NrPMH+zySi7gPnoFax/TJibh9/0aJlWlCnsryUQ4lba1bhQa37fhvaFe+1Q0o
	Caq7w1CJezuxhPX678R9Gi9RquZJtvORQnpOMPrGnN156/Xu5j5f8+Toc/3QbCFaEJgVaMFCLxV
	8JnVV+jGT/cZS1zbBUTNL+qKBDjqkninrZMfyw8=
X-Google-Smtp-Source: AGHT+IG90GJ3cVozbP6RR2l0NmYm2sRFDpMK2E6Pg80dHKaiXaMHehMlfcpN4BL6HiYRmmNnEEtJT3pf+sExuorT1So=
X-Received: by 2002:a05:6000:26cb:b0:429:d186:8c49 with SMTP id
 ffacd0b85a97d-42cc1d526b1mr4554047f8f.56.1763774232497; Fri, 21 Nov 2025
 17:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118125802.385503-1-chen.dylane@linux.dev>
In-Reply-To: <20251118125802.385503-1-chen.dylane@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 21 Nov 2025 17:17:00 -0800
X-Gm-Features: AWmQ_bnY5ro3ViVWECsPZH9bYyOjjQElX6FF_rqR_CxxutNpcJsR7fKUhsqAEjo
Message-ID: <CAADnVQJ0MDMwrmsUoM1xt_1bMQ2d-Eer7ynD3GVSCuwcpZouLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_get_task_cmdline kfunc
To: Tao Chen <chen.dylane@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 4:58=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> Add the bpf_get_task_cmdline kfunc. One use case is as follows: In
> production environments, there are often short-lived script tasks execute=
d,
> and sometimes these tasks may cause stability issues. It is desirable to
> detect these script tasks via eBPF. The common approach is to check
> the process name, but it can be difficult to distinguish specific
> tasks in some cases. Take the shell as an example: some tasks are
> started via bash xxx.sh =E2=80=93 their process name is bash, but the scr=
ipt
> name of the task can be obtained through the cmdline. Additionally,
> myabe this is helpful for security auditing purposes.

maybe

>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/helpers.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 865b0dae38d..7cac17d58d5 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2685,6 +2685,27 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(=
s32 pid)
>         return p;
>  }
>
> +/*
> + * bpf_get_task_cmdline - Get the cmdline to a buffer
> + *
> + * @task: The task whose cmdline to get.
> + * @buffer: The buffer to save cmdline info.
> + * @len: The length of the buffer.
> + *
> + * Return: the size of the cmdline field copied. Note that the copy does
> + * not guarantee an ending NULL byte. A negative error code on failure.
> + */
> +__bpf_kfunc int bpf_get_task_cmdline(struct task_struct *task, char *buf=
fer, size_t len)

'size_t len' doesn't make the verifier track the size of the buffer.
while 'char *buffer' tells the verifier to check that _one_ byte is availab=
le.
So this is buggy.

In general the kfunc seems useful, but selftest in patch 2 is just bad

+ ret =3D bpf_get_task_cmdline(task, buf, sizeof(buf));
+ if (ret < 0)
+    err =3D 1;
+
+ return 0;
+}

it's not testing much.

Also you must explain the true motivation for the kfunc.
"maybe helpful for security" is too vague.
Do you have a proprietary bpf-lsm that needs it?
What is the exact use case?

pw-bot: cr

