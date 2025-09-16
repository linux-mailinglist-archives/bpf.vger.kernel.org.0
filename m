Return-Path: <bpf+bounces-68564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EB5B7DE24
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769D3462CDA
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 22:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B28232E2E1;
	Tue, 16 Sep 2025 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSHnxAnm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCC332E2DB
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061748; cv=none; b=hieTqTeT5K9pDdcWV1129Cjeb6UvxU5F3kVgT0syEB2bqJEZO5c5e6Dqgn1ZArqWeaerDDz2hqDcQcrHQT1J8OmWpiquJ0MD9wI7GdTkrmcwNr2XQMWFb5pTwpBDrzqu3zVqru5HquOViT4mWXX3UsNe9EcaXauga2zUQMc1+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061748; c=relaxed/simple;
	bh=GQRiMPLso4udFX4CB+sEYglBh5mmBczyDU9O0TBC65U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8Aw3xlPO39b3djebjZDvosTa64aso5LqIBUzXCunBbc2ly6ZAqJ5P1fA+GDhJlAcEPocMwRydNkIPqAoHm7lY26QpMGo4vzgacMQ/NbhsSJAIh7SXHinPjMJOdfnJ4ZfO977b9OWZN2R0Hw4MCYBsZghXyjltdKg9oY1iV4Tnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSHnxAnm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-244582738b5so50388165ad.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 15:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758061747; x=1758666547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WprOe5/M+42SgMOPYQkTmIUA2Q1389Nu0dnK2gJe/0=;
        b=WSHnxAnmisQm9BwcqNhUrEh1Mb18UqZhLC3Umb/0KOoNk8zxCMQifaExiwN0eon23A
         6lPiKFE+EL6UHzah3cpzGfV51V0swQiDYDNmnY+LAxMwkxFK4tpl20gQpSvBWmxG9JdN
         mDFORNM6fZgmxVwdu42iY3Zc66DUXGMdTG8WxJXfVOEPUfLDbkqpbs81bKymEOo5a5N2
         xkNsEys5ihXe2SDfxFiD2XK534u0I0ctuCcy/DzYpD0kAOEh13lIpLbvxE9rXBrRTLwy
         BD9HVs4UeRVjX+0LNyEoN5aKvpEZq2hjo5nKlUJE4XLfohE5vroCKiCbCfoRPwFsuyav
         ex6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758061747; x=1758666547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WprOe5/M+42SgMOPYQkTmIUA2Q1389Nu0dnK2gJe/0=;
        b=Y/mKMh5seeBvyEcghE7r2+ciRIQhzxvZPSx2grBScc4tpVwWO4GizE/E8+VUymQUMi
         lwY0Ps/K72q3V+DKnzbCc6nE2d95OIj0yTlYxNnjUfmc9RnaTtWO6Q5rqRMzSvHS0VI+
         aZ3+w/v0DjJnTuzd/8N3XGqWrswSW5SxXj8jE6ZIJJW3GrFAU41As3UrMqxarEloVbwS
         c1x2NtH70bZtJX3d0X5xeXpiA2NINzcmSRH0yYHAdjY2Gg3gXUguv9XEeU7bdwPCr/LD
         oIh8q6RwOuCuHnsHzc2OB38fLKC4erLFqTM6eyPVXlLJoEhMkeMVi247FJ0nhrqRHz87
         2RLA==
X-Forwarded-Encrypted: i=1; AJvYcCXk2ph2cAcsNZVYAxY+kTiFYrW9FMEfvBy9dzQcSUJ8wjuSOjLmOOo+Dx8ScUy53Z4oEPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7Zp8P6du7H6WkVBO9paBtJo3HbAv1JaNYS9LlWv4xWA48Sb8
	rzxjC6YktYO2GFwUzqT0ZCQU5URwb5uU/2vfuxHpC8gfbLl3IwBOs70bt2l6QOlzgvM2YCrBoco
	mTaR+krrDf+YFAi+BOIww2/7z5IIuwS0=
X-Gm-Gg: ASbGncvfIzidCAkXLAMZuR93DBtvWLgCOCG6E238caY0bh4xdxjpUMnX80Xe7DoxkoZ
	laaDhF6tHu81f3XU5vPkSruIn+tyYINbHTGtPq9a632s+7SQ6hfNVc8WPH8oRFgBy4HOH+MPvB5
	m1e428qfg6uI6o5PgmRPxczgXe0O8i6JeWxqP/AKQixVDShsWUWjdpTedOrIxUdfI485seiJH6+
	4XhWsSf2wgloKhiEikBPy0=
X-Google-Smtp-Source: AGHT+IHBOnFSbfOjCWswssFIXUYknwoi8bxg+YaSZ0NlMLbN3Szk7M4gcBk+o1k+eZZc+Hhru+MlV+o4dEFHedKtN1s=
X-Received: by 2002:a17:903:2410:b0:24c:9a51:9a33 with SMTP id
 d9443c01a7336-25d24e9df3dmr201990295ad.22.1758061746563; Tue, 16 Sep 2025
 15:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916215301.664963-1-jolsa@kernel.org> <20250916215301.664963-3-jolsa@kernel.org>
In-Reply-To: <20250916215301.664963-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Sep 2025 15:28:52 -0700
X-Gm-Features: AS18NWDXq8G0jhAXIKx9oMvchpwy_wkQP4mw4ZzusEgUYtrbuckohtBJ2yrw2Bw
Message-ID: <CAEf4BzYTJcq=Kk6W9Gz90gM=mw2fS2T-QBurUhdjBNinReDSjQ@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 2/6] uprobe: Do not emulate/sstep original
 instruction when ip is changed
To: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:53=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> If uprobe handler changes instruction pointer we still execute single
> step) or emulate the original instruction and increment the (new) ip
> with its length.
>
> This makes the new instruction pointer bogus and application will
> likely crash on illegal instruction execution.
>
> If user decided to take execution elsewhere, it makes little sense
> to execute the original instruction, so let's skip it.
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/events/uprobes.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 7ca1940607bd..2b32c32bcb77 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2741,6 +2741,13 @@ static void handle_swbp(struct pt_regs *regs)
>
>         handler_chain(uprobe, regs);
>
> +       /*
> +        * If user decided to take execution elsewhere, it makes little s=
ense
> +        * to execute the original instruction, so let's skip it.
> +        */
> +       if (instruction_pointer(regs) !=3D bp_vaddr)
> +               goto out;
> +

Peter, Ingo,

Are you guys ok with us routing this through the bpf-next tree? We'll
have a tiny conflict because in perf/core branch there is
arch_uprobe_optimize() call added after handler_chain(), so git merge
will be a bit confused, probably. But it should be trivially
resolvable.

>         if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
>                 goto out;
>
> --
> 2.51.0
>

