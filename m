Return-Path: <bpf+bounces-41685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27048999A52
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 04:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559B21C25E70
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 02:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE631F12FA;
	Fri, 11 Oct 2024 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNy342yN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796351E9099;
	Fri, 11 Oct 2024 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613239; cv=none; b=sEKxJO7B2Q0jHic5dBJYsEzfRiP0+viSfflmex73yRAwrrManF0OLphP7QVFqK7VpWUuLr1Cyw2z9rx1/6dl1QvM3haOff35x0e7MUZeC8dBUnHANBhWFrPQG1nPv/hKM3666z0chfAMhpApu7By+QDgY7drgdMDiShRcumuyi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613239; c=relaxed/simple;
	bh=1ijJnCob+9tIpvtdxnuDyjvCd6Z2v5UhMdnZVzsBX/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoAM9HPrEmR4Z2/m+wuFj6GF1bFOyPO9bKRJplhx1joUCnSBDeJyiH3QQIl1wBVVbNJrCCOaP/o43jM8GguqKSrKOpFU3g+DsvN8xq4HoUU8Bm+rt+yY0LCQzUtYd37ghuN7ZhoMYTH3qfPUZrvubrzDf5qlK8xlj3JAsGhfbGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNy342yN; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so572899a91.3;
        Thu, 10 Oct 2024 19:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728613238; x=1729218038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtnJ2Bznke0oQPsOijLPOi2tLuq8IIbaw3z7aQYC59s=;
        b=XNy342yNiACuEfW4iNpMjIbODOn8C3tqrZxkhC9iZU8j9PZmmFHKNgMYNQOg+tbWT5
         T+9WgAjbr4iSiQSvnY9hrRwhQ3IGhO3bqcZH7id2tx0u/Apox2H+IJvnmnKqzNj2WHye
         rhhHpqGv9AuGels5/rDIDiBJmQyXfFME1B9fw6Nf8BqGiv2L5efVefA5KofY66ufant9
         H+YYrCC5ZRI2h1Mighap4+8hKqdzsLCin0Egy4seuCCbEnqupX7My91ZeblW3UZ+plEI
         cRvwmSwZ4TN/9IE6QJleGsU/HQ/oeSywdSmmUkls9+8QXnpQdGT2ujizEwDCoxjvePgK
         dZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728613238; x=1729218038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtnJ2Bznke0oQPsOijLPOi2tLuq8IIbaw3z7aQYC59s=;
        b=F8h2bmXJu7Io3DR6kzYpUOUmYev+hVd6MMqgaZpwuuHCNl0vuxHUiCf+Nk7mmPEVw+
         97W+4UqiiNpOAflL0ArHnqHswqrnc8PlbxOKwgU082ciVpONqpJNzBkMyxNkFX7gevbc
         bwqifGTb4t/WpPwuLjczAP7CoRqjtS6gA1eye6xVT2/aOB6vFzu7+bh4oaPmUk8WonsP
         qmUsI4rbuUPpMWjn49COoQzc+FGDaybrUmX4KAvd8oGf+psIc2+99JLWka6HIlHh7Pbf
         MhbcZbsf6q5Vn66bvNaKJkMOScXewgE8GwIwB1dZLkXIl5IvMd6SOsD72aip84cPPil8
         EUHg==
X-Forwarded-Encrypted: i=1; AJvYcCUCkd/CsNaQmivIFyGnjS0jScH1SW3PQ57+GocaAguaDQSpWzfl6CnF2Uc/v4ON8R3YAkT+Zy85hR254iUhOXFYmjkh@vger.kernel.org, AJvYcCX2Y73DohRIQ0BufXCWPoh0shnREypm2D5PodSD2XrYroqjyQ2tMIvC/5D+o6UQhZiNwvuD/FeLrNfWTWNV@vger.kernel.org, AJvYcCXF83pMPAqMVUzSIAlcBGaJ7JRDllOtk/mOENpyTiGuFFOBfVMHnGaR6AHNmARxddiKwXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGNfuhOSbdJ1S3pYrxNvkN7XWzofz7zVefggXDzuqMQEPes3+e
	vnFYCzacAakRZDtotAF38HVCchXNwxlMOgt9lRADQGgHkgLKRqiala7CRDoPPNYNumZP/TsiUVe
	oQn9fKWhs7xVehgx6/v7iKPLl7Sg=
X-Google-Smtp-Source: AGHT+IEnlThx2CJOLLxYpZlnUVHLuVs3tRAlsUc0Ft/w8gpEqNyhz8GZjttfQbPclEDf2mHXJpdp9IjzS0TyI02SU04=
X-Received: by 2002:a17:90a:c388:b0:2e2:d3ab:2d77 with SMTP id
 98e67ed59e1d1-2e2f0d8adbbmr1517415a91.39.1728613237729; Thu, 10 Oct 2024
 19:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010200957.2750179-1-jolsa@kernel.org> <20241010200957.2750179-5-jolsa@kernel.org>
In-Reply-To: <20241010200957.2750179-5-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 19:20:25 -0700
Message-ID: <CAEf4BzaWyreKRmLSL0Z+698dqE6Xj8rze3zP=Ygb7WuhJZ-ibg@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 04/16] bpf: Force uprobe bpf program to always
 return 0
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:10=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> As suggested by Andrii make uprobe multi bpf programs to always return 0,
> so they can't force uprobe removal.
>
> Keeping the int return type for uprobe_prog_run, because it will be used
> in following session changes.
>
> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index fdab7ecd8dfa..3c1e5a561df4 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3209,7 +3209,6 @@ static int uprobe_prog_run(struct bpf_uprobe *uprob=
e,
>         struct bpf_prog *prog =3D link->link.prog;
>         bool sleepable =3D prog->sleepable;
>         struct bpf_run_ctx *old_run_ctx;
> -       int err =3D 0;
>
>         if (link->task && !same_thread_group(current, link->task))
>                 return 0;
> @@ -3222,7 +3221,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprob=
e,
>         migrate_disable();
>
>         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> -       err =3D bpf_prog_run(link->link.prog, regs);
> +       bpf_prog_run(link->link.prog, regs);
>         bpf_reset_run_ctx(old_run_ctx);
>
>         migrate_enable();
> @@ -3231,7 +3230,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprob=
e,
>                 rcu_read_unlock_trace();
>         else
>                 rcu_read_unlock();
> -       return err;
> +       return 0;
>  }
>
>  static bool
> --
> 2.46.2
>

