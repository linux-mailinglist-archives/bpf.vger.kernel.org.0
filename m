Return-Path: <bpf+bounces-61198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2BAAE222C
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 20:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AA31BC43AD
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 18:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26E72EA746;
	Fri, 20 Jun 2025 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daM7NI45"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85D2EA16A;
	Fri, 20 Jun 2025 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750444074; cv=none; b=sRgeqWy5O0in7eop4yHo220YyvsbCpi6QmEHu4G+pZsbANRqXvxHZH1AbDfjEJ5pAKsLtgjKjdEFCJts7gEAQeyAp4mHC9WdmucJYKu5cMDlccyvv0N2iV8LuU2Gl5Eb7lp3iTpuYQxZBfQK1EiHfbtpN205UKlzVXvLVAVMTcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750444074; c=relaxed/simple;
	bh=d3O9J1g1JWzmphWm7UDBt8lB/M6/JgREUMSah6KHI8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVC0LHVLbZBfT6GStOlQZpQqlxaGsgun+pPKWpGVwJ5elm4xM61syHFcp0YKA0495FViXNvUFUGdDemAQMDTtIIgBrQdyn4S05jk2DgMjS58uy2W/lO1WmNPfqfvBgRdrzf489QG3sQv+nULSdG2q1pcO1Yl9p/DDS/2EbG24jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daM7NI45; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so16152675e9.0;
        Fri, 20 Jun 2025 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750444071; x=1751048871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zt/6wMvuIqgz85pJnrDVkDDDGGryUSiChs8NDQQDWVo=;
        b=daM7NI45Rryey9zKuvKYzhJkEFuJnso65HakcJF14fLbXaF9kls0sH70WCkSQ2t3sZ
         Ziq4wsSUCfFMX9GQyrOt/9aixJNv4pe8PveR+AxjkuJNX5OtO3Kn071rmRdYIWjupnyu
         jaj+BBExxWmgwvC/WbP1XbDzVMymNKzotAVCM6I1O2OH7VXAewXUgkgPJvzBR/OI1E7X
         cU9tlJk8Uzc2Hjq6DslTTcGxaqsliveR7DphW9ovuprSsiId71cJpsVYp+RlNwoo71Vw
         y1gZkjVkotlFWpTY6Ln/HJ3ETZMcrQ0g9uCeooW6WbfmAK3Vj5y4lU/cpeU6GulUTykf
         W4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750444071; x=1751048871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zt/6wMvuIqgz85pJnrDVkDDDGGryUSiChs8NDQQDWVo=;
        b=JSC7MgBpUftxgnx/xggjy1FfrCHcd/Qtwm2JgSKlLEbzV6DmnS4A1v9NYAWVjFGDOg
         +r8d6fTuZrieJqqdqxz0lVUic6Qu17iOReawL+2TXuow9ORVFVNr1+3cYYW5v++Ntr6v
         gBJG5LVYbJIWigtC+1Yd4Z+W7zYfbjbz9mvkydu4XJ9sITyPgd5FjU3hHPMeTtoXLaCs
         abYVqKMgV5m5IroCbMziXHQrgcZbjYoPkFsH7x5Cv6+Ye5Q7U1MbD+msUb2YRffztSl2
         XeEKViTuCo9DRQLy1nh15ndeZiOozgioFpeEAJmtDkBq0/h289lAA1weS6mEwbjGJaJ/
         +Prw==
X-Forwarded-Encrypted: i=1; AJvYcCUPtfTRgER3iY3wWRGE5IByta7dihyagCVJAkZ2kUU0IELhDnZX8Vuvb5sPET3EAAnWaaflQdIAUPDfmNrW@vger.kernel.org, AJvYcCXYpu9a/7yFyWVhIovRI+GdWvgobNJbM/EWyWoQiU1KnkXuEFs8hhSiljSPNewpLWlUYzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyITh6XXnyCt5soJ461HRfyobJs4TaMBfx7ZXp16bqSgi6G1CqQ
	jK8hrCW8ue/3f7IubwcIZVjLU8y2Vo6F+bFkrXlZO1POqExg+XmyyRHduX9hFOVG/YmlTuDNHhT
	/kA2QYi/rQPFNBl2dVRvSb1Aa6k7BGDg=
X-Gm-Gg: ASbGncsUUbBXc6cmq+nI4DNmEGnPaAktA/mLXdAeJBW/A3B25NI0NBC+gPuRrMTTSSM
	szOGimdIInjmFPokiqGD/krZqOD/a6uK8PzOvEhypfTcW/Ompr0V24Oo0ZnLHywCHZ+JYfDyn60
	PX6+eWOpt1vZ9Xfa1szU84Y6xXuVlEQGRdh63hWE9fAstPaOxc5/gzTU40ephNe5dNVp8atESK
X-Google-Smtp-Source: AGHT+IHl1RC5vEGeuNOIEw+Q0BWs87oSYVrmLGxL3Je5kTduEV/BPpmvNnOVPUgu+e+9h4GOG8mjOs7xr5n5bef6YWE=
X-Received: by 2002:a05:600c:1da0:b0:451:833f:483c with SMTP id
 5b1f17b1804b1-453653d4544mr36551175e9.7.1750444070411; Fri, 20 Jun 2025
 11:27:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620051017.111559-1-chen.dylane@linux.dev>
In-Reply-To: <20250620051017.111559-1-chen.dylane@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Jun 2025 11:27:38 -0700
X-Gm-Features: Ac12FXzZDe62xxGp3JJlnJT6bukK6dDwlfsdTDNpYvcrO-W5ia9pQBHKXqSnPpk
Message-ID: <CAADnVQLd9Z1nfp+WBdMLaZ7EP-+A9QEDdOhZaL0YTaygtKD2Hg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add load_time in bpf_prog fdinfo
To: Tao Chen <chen.dylane@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 10:10=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> w=
rote:
>
> The field run_time_ns can tell us the run time of the bpf_prog,
> and load_time_s can tell us how long the bpf_prog loaded on the
> machine.
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/syscall.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 51ba1a7aa43..407841ea296 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2438,6 +2438,7 @@ static void bpf_prog_show_fdinfo(struct seq_file *m=
, struct file *filp)
>         const struct bpf_prog *prog =3D filp->private_data;
>         char prog_tag[sizeof(prog->tag) * 2 + 1] =3D { };
>         struct bpf_prog_kstats stats;
> +       u64 now =3D ktime_get_boottime_ns();
>
>         bpf_prog_get_stats(prog, &stats);
>         bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
> @@ -2450,7 +2451,8 @@ static void bpf_prog_show_fdinfo(struct seq_file *m=
, struct file *filp)
>                    "run_time_ns:\t%llu\n"
>                    "run_cnt:\t%llu\n"
>                    "recursion_misses:\t%llu\n"
> -                  "verified_insns:\t%u\n",
> +                  "verified_insns:\t%u\n"
> +                  "load_time_s:\t%llu\n",
>                    prog->type,
>                    prog->jited,
>                    prog_tag,
> @@ -2459,7 +2461,8 @@ static void bpf_prog_show_fdinfo(struct seq_file *m=
, struct file *filp)
>                    stats.nsecs,
>                    stats.cnt,
>                    stats.misses,
> -                  prog->aux->verified_insns);
> +                  prog->aux->verified_insns,
> +                  (now - prog->aux->load_time) / NSEC_PER_SEC);

I don't like where it's going.
Soon fdinfo will be printing the xlated insns of the prog too,
since why not?
Let's stop here. We have syscall query api-s for that and
bpftool to print such things.
No more fdinfo "improvements".

