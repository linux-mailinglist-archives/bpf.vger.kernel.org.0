Return-Path: <bpf+bounces-70113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BAABB1444
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 18:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A639A4E2DC4
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 16:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6472877C4;
	Wed,  1 Oct 2025 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVaUbinE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9026286D7B
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759336785; cv=none; b=HnLm6xyS5aNk1Zet21rRuOwmIKnNyQkvoI7VdQCZ6EO8jmfjiyP+ecwxz56iD3V2onWgC7gp5NPsrPSpvA3U/RUNfOUSe10bjPfEvUylE8C5hDcBuvazImLTh4FJwANlvWZiMf+9Thv8bThR9fUGhSp3JL48TI/2TWGG8mGOdvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759336785; c=relaxed/simple;
	bh=5pOEezS/qP6F4jEWoeOm7Fz3N7TCVGrsBiLzB3qwz1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Em2Kueoow3RP1F60qABZ0WQ+HE4w38LxGTtllhs1PXdV2Qy1+cxcKXpmsgM2IfB9/xvV+0t+X3uSRYcKosAS+u9lERioiMNM8e8onqF0O9GGBS3A7eoX67yJKd32Rv1Gh5A05Pwl7tWU0OYHd5dLmMBfz0xXQVd5gudZYxc/rx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVaUbinE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7811a02316bso88768b3a.3
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759336782; x=1759941582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmGKlN/jBsVenanHceP4S7aQlFVvNQtOwGJQtiqwWbA=;
        b=LVaUbinEuK4XM9JBMP2MiBggPrSFpDlqa1rFmwMq79/y5Mse9lUi5GCYJ5Ag3oqV+q
         iyfZ/sKixrbEpRWGx4d+1xq+7NWAzgKwvWOoG0AP8hmSCXR0GtEm7PkLWxtQsH/wo2T1
         ZY1wuvPwuihxocXt27fu6e+wNI48FTpXtE6QhAIv8TNZFtawES2WKj7LXk2l+nkMDZHW
         YOkcVOFUr7MJji4vN7g5g+8p3Se/MCLg+BRr02S0DprzdSBT641P0YAV+30AYtHsUnfK
         Wri1ogMSLCXK1cpBpvs4GaO4sHfuktCXpR/iwWXUWD7g3t40h1oKlO+DHsOf7FRHfNwp
         zSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759336782; x=1759941582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmGKlN/jBsVenanHceP4S7aQlFVvNQtOwGJQtiqwWbA=;
        b=bqsiL0O0lYvymiH/0oqze5G2Rzrcde56TsH7SpjoEzBJzlLpVdhSFOv9SFj1lGiFL9
         XoygA2MoQOj4sYPHD8PnHLJslGMnQSQLaF5lIstDowuYy3K8eILh4cD175D+a1gH/nhQ
         +LRGS8djb3sdlHp1prl61u0yXCdKN4hTOo9yD6ttdusSuPmOvVa5E0z0+4Zl1DBV0iyo
         bzNrURomMpU8ImElACFUKK+YzsmU/698qMmBRi7sNwOaBp2BsqhGq+HmwINwW+j8h9rC
         veraLc3pBvj8bMrZiP9KqJ3Yk5Z2DSdU53nK0qn4qKy0Zx+uAMA1zSs4pfMVYImuFXAg
         qlMw==
X-Forwarded-Encrypted: i=1; AJvYcCW8XWhnVjasstSIedJz1Hdc0ndcYPfMSq0eH7lJJpnW4ncbDzIpdRIfgBlY8sNSvZ5ft+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBiJTjCav5Na0dhOXXRhD8VhefJVKB38cKMeo5S8uaZdDvn/ix
	Ag3BMtnOh3MNivQtgC9yRuDjnFueYOqU5TA2EIOEq9c8eLbp/7W3ZRq8N8sYQVyGhG+1OOnTDlG
	CjQVpP7mVg3gJWroSTV0Y/TcE/wFH3X4=
X-Gm-Gg: ASbGnctHwTOwnoEJA/+unhXswTRTzFJio5FLFLrYXItEBdaHtafS1T+ADduWs+RKAcj
	Xq6IiAaGOnRiv8yZt5pdY9YQ5Khr3GmOSw514lmwBZY/zfxX20Ms7QWYyTddLvr5yv9pbJohT91
	95PmV7W15khjak6P1VKGzGo/XdBXNyxjXwHLZUnsAT3jPYql9cFPw6bjuFkCuuOfFZA5IHFCVuk
	Fwb4ke1UnTw/v/CJvsh1S7880jLaRnjoDXs1FVxhXIiI10=
X-Google-Smtp-Source: AGHT+IE9y4z9vj8j7yKhBcDb2apGorlG7PINT4jHURs+aWjIj8z/pwVAMIEXfRoJqNuQ3Mw/cwz7seK+Az+n+Pf6vm4=
X-Received: by 2002:a17:90b:1e0e:b0:330:7a11:f111 with SMTP id
 98e67ed59e1d1-339a6f84d53mr4930805a91.35.1759336781992; Wed, 01 Oct 2025
 09:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001132449.178759-1-jolsa@kernel.org>
In-Reply-To: <20251001132449.178759-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Oct 2025 09:39:27 -0700
X-Gm-Features: AS18NWBXWfduYxqUtnH1tABDYMsrbfqkNZtEA8ABmNwPyaBnTu4oL0vq-aat2Hk
Message-ID: <CAEf4BzYMDgo2JQEkV7e6rnX1Jwu4QMFdqEsnRcxL2J0ukLxU=Q@mail.gmail.com>
Subject: Re: [PATCH] uprobe: Move arch_uprobe_optimize right after handlers execution
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>, Alejandro Colomar <alx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 6:25=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> It's less confusing to optimize uprobe right after handlers execution
> and before we do the check for changed ip register to avoid situations
> where changed ip register would skip uprobe optimization.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/events/uprobes.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

makes sense

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 5dcf927310fd..c14ec27b976d 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2765,6 +2765,9 @@ static void handle_swbp(struct pt_regs *regs)
>
>         handler_chain(uprobe, regs);
>
> +       /* Try to optimize after first hit. */
> +       arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
> +
>         /*
>          * If user decided to take execution elsewhere, it makes little s=
ense
>          * to execute the original instruction, so let's skip it.
> @@ -2772,9 +2775,6 @@ static void handle_swbp(struct pt_regs *regs)
>         if (instruction_pointer(regs) !=3D bp_vaddr)
>                 goto out;
>
> -       /* Try to optimize after first hit. */
> -       arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
> -
>         if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
>                 goto out;
>
> --
> 2.51.0
>

