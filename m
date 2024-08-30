Return-Path: <bpf+bounces-38605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F70966ADE
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 22:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95C7B22E06
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 20:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B851C0DD2;
	Fri, 30 Aug 2024 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJF9E6Yn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F4D1BF7FD;
	Fri, 30 Aug 2024 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051079; cv=none; b=fFt8vnkZdVRP/YkdmsEdLdmYkSNaTcYez+hBiKXQR+637Nwy9ctpsk8zElGHPw2hEFgWGpUVwUKiRV3CiRbedNI8gx20CyW8yUtwgtPyBJwXoBa6d1lEtK8pEL9CttW+SL0gTW8C7x9y7bMkM/ivqZJjm2U1VCWww2Wccm2xEPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051079; c=relaxed/simple;
	bh=EGmaHQIyFUQXRzkAm6S7M6ACd+k5XeZNvtGEUAyJy0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrPyGKTXmFIIkt0HsdrjWnNVZyAO/1FvVtSKcVLWQaTkwmkeHn9O84N/jKgpZYkD7osGNjxGiBn7g0TuQV5fvFM2dCxJtbn6YLedN18sgT2eFyhUqj3CNMY1VL0aTEYxJU5tPc+Aggvia3VOxXuH6ZsfdhigNAhC78ivT5XzXbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJF9E6Yn; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7bcf8077742so1562120a12.0;
        Fri, 30 Aug 2024 13:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725051077; x=1725655877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKCWX5eBlnYoIPNYnC/Yrj2h0Y/qTbwBQ/bhYQL0ahI=;
        b=RJF9E6YnGRQz8YjtxUy4PrOwffcqeN3TRTJ/PAPJibjhWIV+HvckGQx47Zrh10BajW
         xiSjC5rAnXpAhFey2xvQ0O8cj/5Gu+fpISFWjm3LjhXXzh7HSaCpwLPovbdt2LeNPOAm
         yHOWbRqLYka5h7fUNnrwR8xvCTaSt7qbLq7f9NFE0fu/H2WkqnkA17ShzyFJwzlMHpar
         jwKbqeyq+BP0nfVH7JE37EhGm+ORG7JJz968nERfFA42MooKcGpV6OzWrEQNEnQusawZ
         bQhfw1yEBVM5qVleUvM5nw8lB+hnI6/9PsufzuxqL3GZcui6PdBvEP3NnmIfPS3eMV+4
         mEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725051077; x=1725655877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKCWX5eBlnYoIPNYnC/Yrj2h0Y/qTbwBQ/bhYQL0ahI=;
        b=haUegjPKmp9ONhiZhiMs7NlcATbrQ9Yg1F3PhP36hYZU8e3DC0z8JPQ3oEQQYbm+k0
         yB3Z1Rqrt9lIWuKn4A2MN4UmAkzg3GtejNuN+hjbHNIMff3y8Rw2tcwaWZdp6PEuX5Hn
         M8ym9KNSS6KQj9BAC7RH+xWsdxVIKmLFUvHdVda0eGo2kHHRHzVnfNDSZJSzYhdY/ejm
         DbWTi9/vaDCifC+877IIOoxGTLG9FL9lnXZomWFGGQr94yTXFSNXs4cLfHkLq6SyAX6C
         zkbZDw3/kpc4YVysknQimfrTkoO2JrMjgV2hZNymlevEQMUIWPULkLBlzXiBtKV1j6jT
         wjJw==
X-Forwarded-Encrypted: i=1; AJvYcCUUYC+Mg9ik++MAOfHqGU7odRf3xf7jB9t3imLQ+X3tVb4+qv6Vhlu6JNID4hBoLrr9+nbWKXeVsQ+gGAM5@vger.kernel.org, AJvYcCUV9edyw3Eo3Htu4N5OjcZuTzcAZjx84ixdM0fFjRU0gmAwzSx6BNC4R/Y+1ukE6h/NV3WWEVOB1Ucc6yp8pFfBUk60@vger.kernel.org, AJvYcCVsIx5A4CZkYZqxdPnMjdVU8+f6k4wH01Et8s5LMIoKbnnu9sRxHA+55LfCQ3P8isJfnCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+OxP5xUD9+gOtGT4Ew1UtTQNXsmUeuBj+XZbtaeHBStfYJDc
	gR3h64xNBDGkwg21Mu+fhtcFVIIbU+2JLovjs+EZg1u/PTpT9KJAFAi1qSvypqimjWjs4UIZMIq
	EmsGePETGQ/zivFx/CJiTTopsCq8=
X-Google-Smtp-Source: AGHT+IFJkXzMiCz4hLWiGHcIVHu9KNDUbV2A/WAg3aG8mUvFdbjfQlgpeqAXSl8XE4hL1lGIco6WROtxFKXpTg8dotw=
X-Received: by 2002:a17:90a:4b85:b0:2cf:7388:ad9e with SMTP id
 98e67ed59e1d1-2d85616eccamr7546969a91.2.1725051077220; Fri, 30 Aug 2024
 13:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829194505.402807-1-jolsa@kernel.org> <20240829194505.402807-3-jolsa@kernel.org>
In-Reply-To: <20240829194505.402807-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 13:51:04 -0700
Message-ID: <CAEf4Bza4JztS8YBaEFUi81OwH2aSNbv3c29hoVc31vTnfgiCLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add uprobe pid filter test
 for multiple processes
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Tianyi Liu <i.pear@outlook.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 12:45=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> The idea is to create and monitor 3 uprobes, each trigered in separate

typo: triggered

> process and make sure the bpf program gets executed just for the proper
> PID specified via pid filter.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 103 ++++++++++++++++++
>  .../bpf/progs/uprobe_multi_pid_filter.c       |  61 +++++++++++
>  2 files changed, 164 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_pid_fi=
lter.c
>

It's good to have a test, thanks for adding it! But we should couple
it with the fix in multi-uprobe and land together, right? I'm not
exactly sure why we can't just use task->signal-based check, but let's
try to converge on something and fix it.

pw-bot: cr

[...]

> +#define TASKS 3
> +
> +static void run_pid_filter(struct uprobe_multi_pid_filter *skel,
> +                          create_link_t create_link, bool retprobe)
> +{
> +       struct bpf_link *link[TASKS] =3D {};
> +       struct child child[TASKS] =3D {};
> +       int i;
> +
> +       printf("%s retprobe %d\n", create_link =3D=3D create_link_uprobe =
? "uprobe" : "uprobe_multi",
> +               retprobe);

leftovers

> +
> +       memset(skel->bss->test, 0, sizeof(skel->bss->test));
> +
> +       for (i =3D 0; i < TASKS; i++) {
> +               if (!ASSERT_OK(spawn_child(&child[i]), "spawn_child"))
> +                       goto cleanup;
> +               skel->bss->pids[i] =3D child[i].pid;
> +       }

[...]

