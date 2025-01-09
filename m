Return-Path: <bpf+bounces-48479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C166A082A5
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 23:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155261634E9
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E775C205513;
	Thu,  9 Jan 2025 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbBHBXUy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AE42054E7;
	Thu,  9 Jan 2025 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736460824; cv=none; b=MNdjmpgbfwDvA9F0dvssULD92YgaDQ98ZU6ABV9M8E3Fez7Yx8PI37Xnqj3irI6FMsxb4WpMTh0UQak7kQz2Qt+9ncWMzbTDtcKtthY7YY6wJr9O3TIkVJASYZrgW0i8XiYwx6fPsmpKR3Q+Xs41btiVLYWD400TkEqnv6VWSJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736460824; c=relaxed/simple;
	bh=n+jQUC9Jm2XnIGTjzYqamZTlEyrbvfx8+RyyaO4UvBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyHVMlU0hh8YpyrFGCPKiCMm1vJjtnB6lv6to3ifh4yIWUN+tuLMzNPvXMTVOgfpu4QS/3zfrFFefyxMcsfo5zOWNzbL/Ph13H0HGkhDN0EEVJX8x24nHMOYlBH6++j5kHAh1kRQTGwaolrbGJoVGhJoDDwq6jkTrKPe+8JdTJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbBHBXUy; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso1873708a91.2;
        Thu, 09 Jan 2025 14:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736460822; x=1737065622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THyr0bFENuRK/x7hMtFBy9YWHezz9iNPAjNEHK4Wt68=;
        b=HbBHBXUy25+pbwGT2kEN+cYcvXETJ7JtTl+18BK/BQWhYC+OcohNVhq2BQrAWfg8RW
         VeqOhy9YykmBIUehWT2zuy57FJjKwYZb7GpujdTwHEiom99sT870oD+QdHDjLMMGFDt7
         iw3Z/0W+2hemdw4LQ9D2HtzYUaiTwlJYYucJtGDIcxPEatfUC8Um3RnmlZsJnH0mRpxH
         Kll+GSOP/bhQsi6Z67Nwy35yCls382VHW2SEZIb/1F5o8ndg51tu+fh3D2id0/M0EFmp
         MVYsdjHBXXXeRodBleP5ZTneHc4ctilsjK2wllcEi2dGlBJ0uiov4hhCwkrY1i0lH3bf
         NaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736460822; x=1737065622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THyr0bFENuRK/x7hMtFBy9YWHezz9iNPAjNEHK4Wt68=;
        b=WWhqXdU8szQF1Qz9QVSUAHDXJUE+IFsIHvGbmeJlx7z35ex70TEYzmW4L+O4GFLv4M
         oQPsd9Noo1kFhyM+KEJzTHZTkQHJ63JbXVL580qH1Sk5dvGEgQ+CTrxEteZZgRDqdibR
         RlVp3wnzoxGHedMPELlWHQEh8AzeEvAcKj78LPDlUBpimdjR8S456ZoFThYOLllxlULH
         vAwO2mVYgAVjH2JhkocVu8UtTSs7TAvfCMAkO99a+2Cn84LLg/0ozwN0bY23e27MrZg1
         EWujD4veTMku9STruhODQc22K4E6pbzdtRiCmq7PifR6yFjhyffzswqltTZPSGYFwfc/
         0r3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZ6mtGX/hbbW8h8kkJJEDpN1yfzG+nF/oMRcrxpM8nTixGOgC0s0dBuoRxusLc4C8i7AwKojmHkvmaVwlg@vger.kernel.org, AJvYcCUryjUB5ZJDSjftruZ4O25u9PdtmsiGv95zH2CbuAl1OntMA4E/MyeJ3LusKyvTjGjkqo8=@vger.kernel.org, AJvYcCVoLkhC8dJCrU2rJpfx+5NbM9txln2xpVVZB9sjrFsT1R9IgY4bsqBzSzkJXHGF/8SmMjmY+TdWLopATI3M1FtlpG0R@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ2367HvM8SuCdhJw2aU/IkcOjq8AqF+cLEDvIB78yzPN86utc
	94lVXuTjCf6WXyiuqcCmeM7T3xwrZrPFniLO1jREIcIr2kT5gd39uaFrCumR570r+D104VLjTk3
	rWpgv/ReQf9yUOUuaMCc3BIINm7amxnRd
X-Gm-Gg: ASbGncsLGPeKxPr8QTwhoNU2D3J3GtcrkVZ5KRnDqNzG/4tESb2skiQdkBR9qnJTkjO
	j23/vMEFw44oyCK6U1ivYMNkycJMNzxIj6TxHR4ANilPxtV5JgK4F4w==
X-Google-Smtp-Source: AGHT+IGB4idtyCwBlsDTPAqYT6JY5/HUe6ULdeSVhwHPLZym9wE9lNRCRBpIz/KIDpDvEyH+bhApWHQkk4SvDW+O8mI=
X-Received: by 2002:a17:90b:270d:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-2f548ebf526mr13236642a91.14.1736460822034; Thu, 09 Jan 2025
 14:13:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109141440.2692173-1-jolsa@kernel.org>
In-Reply-To: <20250109141440.2692173-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Jan 2025 14:13:28 -0800
X-Gm-Features: AbW1kvYFr51BqGuo-AxCk5g8kARhcXpQia9ZKMl5TtQ4vgYss-dMmKL2OzraUfY
Message-ID: <CAEf4BzZ2vYmZ9DNy7iaxoaC6imszBnwA-1OCJpuoKcBUGgb_oQ@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Fix race in uprobe_free_utask
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Max Makarov <maxpain@linux.com>, bpf@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 6:14=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Max Makarov reported kernel panic [1] in perf user callchain code.
>
> The reason for that is the race between uprobe_free_utask and bpf
> profiler code doing the perf user stack unwind and is triggered
> within uprobe_free_utask function:
>   - after current->utask is freed and
>   - before current->utask is set to NULL
>
>  general protection fault, probably for non-canonical address 0x9e759c37e=
e555c76: 0000 [#1] SMP PTI
>  RIP: 0010:is_uprobe_at_func_entry+0x28/0x80
>  ...
>   ? die_addr+0x36/0x90
>   ? exc_general_protection+0x217/0x420
>   ? asm_exc_general_protection+0x26/0x30
>   ? is_uprobe_at_func_entry+0x28/0x80
>   perf_callchain_user+0x20a/0x360
>   get_perf_callchain+0x147/0x1d0
>   bpf_get_stackid+0x60/0x90
>   bpf_prog_9aac297fb833e2f5_do_perf_event+0x434/0x53b
>   ? __smp_call_single_queue+0xad/0x120
>   bpf_overflow_handler+0x75/0x110
>   ...
>   asm_sysvec_apic_timer_interrupt+0x1a/0x20
>  RIP: 0010:__kmem_cache_free+0x1cb/0x350
>  ...
>   ? uprobe_free_utask+0x62/0x80
>   ? acct_collect+0x4c/0x220
>   uprobe_free_utask+0x62/0x80
>   mm_release+0x12/0xb0
>   do_exit+0x26b/0xaa0
>   __x64_sys_exit+0x1b/0x20
>   do_syscall_64+0x5a/0x80
>
> It can be easily reproduced by running following commands in
> separate terminals:
>
>   # while :; do bpftrace -e 'uprobe:/bin/ls:_start  { printf("hit\n"); }'=
 -c ls; done
>   # bpftrace -e 'profile:hz:100000 { @[ustack()] =3D count(); }'
>
> Fixing this by making sure current->utask pointer is set to NULL
> before we start to release the utask object.
>
> [1] https://github.com/grafana/pyroscope/issues/3673
> Reported-by: Max Makarov <maxpain@linux.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/events/uprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

ah, it's interrupt/NMI checking current->utask, makes total sense,
thanks for the fix!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index fa04b14a7d72..5d71ef85420c 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1915,6 +1915,7 @@ void uprobe_free_utask(struct task_struct *t)
>         if (!utask)
>                 return;
>
> +       t->utask =3D NULL;
>         WARN_ON_ONCE(utask->active_uprobe || utask->xol_vaddr);
>
>         timer_delete_sync(&utask->ri_timer);
> @@ -1924,7 +1925,6 @@ void uprobe_free_utask(struct task_struct *t)
>                 ri =3D free_ret_instance(ri, true /* cleanup_hprobe */);
>
>         kfree(utask);
> -       t->utask =3D NULL;
>  }
>
>  #define RI_TIMER_PERIOD (HZ / 10) /* 100 ms */
> --
> 2.47.0
>

