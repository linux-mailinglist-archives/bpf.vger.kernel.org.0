Return-Path: <bpf+bounces-33686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51A39249F4
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A26A1F2317F
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC48201279;
	Tue,  2 Jul 2024 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+kXf2I9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC19A7EEE7;
	Tue,  2 Jul 2024 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955904; cv=none; b=X8sxapZZo4SmyxCDfu6ls35hjyjhzaA1VpcYw63uIOGxLs/jjlYhxqYjDIW88U9RpH/KvXpW6yVeugaQKaMVxX1NXVt7xDr/uM1gW89aKHmOOFE30jVopb0kzSKg6bZalNylOUyQ7AaPFT9skLevW1BgSH3i221ihnlBjHnyhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955904; c=relaxed/simple;
	bh=ujqRZ8/8U5lVIZTzEYAksm9vWt7Np+scdFDE7psuE7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4by1hXIlJDT+/halWjy0L0VaMIduI7Ap55ZxCDSP0qq32mH3K1/UKLbYCA2nFTpxyqKfl+O+n4+VMJk45pMFt4bpNgsDwn0zQqAYRWikdbMOh/H7cDjexNeJyRcKWB4rcoCyxjEIe+m7ssJA3T2z2rc3+6fkJlHowlvYj+GgRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+kXf2I9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a754746f3easo122742366b.0;
        Tue, 02 Jul 2024 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719955901; x=1720560701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvW5BjaF/Ev+Kd0l7m/Khs7Jq3VHhd8PTZ4El8oKmvM=;
        b=h+kXf2I9XbthlfhIifelxKS8toHvIwLlRMpZaFcJHpI9W/NgMD0FMh4l3w/l124zhE
         sUJE/rkPF/flNb1cfzMPEpBx+OQje0IRBDsxLEVLZIGOOzMFnc1R14vKG1PECOSEIUZ6
         qQTAZCmvtYUtrTEZ81m4MdtGNuBTeMQHcQvBY8pscXXINbROmRs0qEWFYrmTbG55LfUE
         xQ5lYHdJLL2vsMcNa/ctP43zi3Wa6eiMoFl6lj5j1ZGrbyF8Kvh3qw7QqbDBeomOvbQ9
         aCBDbCh2Spff9gYh4lhsVIxg3wL451pNi9qNV+K4AgR9Vu3fpeYqFy5K/399TaJDALrI
         Ijzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719955901; x=1720560701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvW5BjaF/Ev+Kd0l7m/Khs7Jq3VHhd8PTZ4El8oKmvM=;
        b=RpFAQXp3evcpRZfYLjLjIOznkEt1dx7NOuzgvQ7V/3nu86ALjFeX2xH7/jyU09zTA4
         LKxyHKDEnltKISI4Df65W6TGCV4muR8HQS109SaVrCwKXgBD/r2lvpbOEPuZSgjBwQjx
         VN/p4YNXwVw8bEvzWhYHx0BbJZKsOvtNhXa7sDrc4dhAYWjJSNEMBIc3NRZtNzT0xJfm
         jipO0khjtashSJC2CbD1Tzflqr1ttTHLJPLw4RuSbdwow+4yVHGsYickVFcyTHUFvq6E
         RgaAwN0/+6iRA67YFgLLNDATQn4qSAU5qxHVzrWZhj1gPz0piD8QsponwIQ7BmVanKiX
         0Ngg==
X-Forwarded-Encrypted: i=1; AJvYcCV6fUA2Tpl7n2Pz+SOqyfsaVBNgkpNj7jpYlNSjmybXVuo+rcKjEnY4wfIUr4tZd2EKG/y6pl+x+igO97Enma42Q6q9wU6Sxiu2wH3dEIi65g874X5ZLZhHvxiK4p7H7NXJchz/lujXvUR/ywSCcqPSMcC/y6c90Qq6+if4RbazGP/Jbxc0
X-Gm-Message-State: AOJu0YxthpUwWJdqfbIGOeI9pZ4XGfRHTyR3OTWVXnAwn84JF4WQ5mbx
	qJNr62DDPxM4O4UkIqoDsYGHq3Z8xW6ked0QUIjR/e+vMKiSYTMDWdQ3pGaNcNYTBv+t0r9QdM7
	A3lGPcNpRp61EtM1EcNiuPtD7pG0=
X-Google-Smtp-Source: AGHT+IGTXhpr/MSlG1c4rhRsYrCWeqnJSb0iP/uGLs8+yX09MxRG/wL+V8FUzeYbK+z7OhQobWRMHzR9xct7qrRq0+4=
X-Received: by 2002:a17:906:730d:b0:a6e:d339:c09c with SMTP id
 a640c23a62f3a-a7514513575mr823485266b.48.1719955900916; Tue, 02 Jul 2024
 14:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701164115.723677-1-jolsa@kernel.org> <20240701164115.723677-4-jolsa@kernel.org>
In-Reply-To: <20240701164115.723677-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 14:31:25 -0700
Message-ID: <CAEf4BzbvA98fVtc9yf5zP2Bf3WbJ1wc7ZeXSR3FSvG-VV3zAKA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 3/9] bpf: Add support for uprobe multi session context
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:42=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Placing bpf_session_run_ctx layer in between bpf_run_ctx and
> bpf_uprobe_multi_run_ctx, so the session data can be retrieved
> from uprobe_multi link.
>
> Plus granting session kfuncs access to uprobe session programs.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 1b19c1cdb5e1..d431b880ca11 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3184,7 +3184,7 @@ struct bpf_uprobe_multi_link {
>  };
>
>  struct bpf_uprobe_multi_run_ctx {
> -       struct bpf_run_ctx run_ctx;
> +       struct bpf_session_run_ctx session_ctx;
>         unsigned long entry_ip;
>         struct bpf_uprobe *uprobe;
>  };
> @@ -3297,10 +3297,15 @@ static const struct bpf_link_ops bpf_uprobe_multi=
_link_lops =3D {
>
>  static int uprobe_prog_run(struct bpf_uprobe *uprobe,
>                            unsigned long entry_ip,
> -                          struct pt_regs *regs)
> +                          struct pt_regs *regs,
> +                          bool is_return, void *data)
>  {
>         struct bpf_uprobe_multi_link *link =3D uprobe->link;
>         struct bpf_uprobe_multi_run_ctx run_ctx =3D {
> +               .session_ctx =3D {
> +                       .is_return =3D is_return,
> +                       .data =3D data,
> +               },
>                 .entry_ip =3D entry_ip,
>                 .uprobe =3D uprobe,
>         };
> @@ -3319,7 +3324,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprob=
e,
>
>         migrate_disable();
>
> -       old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> +       old_run_ctx =3D bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
>         err =3D bpf_prog_run(link->link.prog, regs);
>         bpf_reset_run_ctx(old_run_ctx);
>
> @@ -3349,7 +3354,7 @@ uprobe_multi_link_handler(struct uprobe_consumer *c=
on, struct pt_regs *regs,
>         struct bpf_uprobe *uprobe;
>
>         uprobe =3D container_of(con, struct bpf_uprobe, consumer);
> -       return uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
> +       return uprobe_prog_run(uprobe, instruction_pointer(regs), regs, f=
alse, data);
>  }
>
>  static int
> @@ -3359,14 +3364,15 @@ uprobe_multi_link_ret_handler(struct uprobe_consu=
mer *con, unsigned long func, s
>         struct bpf_uprobe *uprobe;
>
>         uprobe =3D container_of(con, struct bpf_uprobe, consumer);
> -       return uprobe_prog_run(uprobe, func, regs);
> +       return uprobe_prog_run(uprobe, func, regs, true, data);
>  }
>
>  static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
>  {
>         struct bpf_uprobe_multi_run_ctx *run_ctx;
>
> -       run_ctx =3D container_of(current->bpf_ctx, struct bpf_uprobe_mult=
i_run_ctx, run_ctx);
> +       run_ctx =3D container_of(current->bpf_ctx, struct bpf_uprobe_mult=
i_run_ctx,
> +                              session_ctx.run_ctx);
>         return run_ctx->entry_ip;
>  }
>
> @@ -3374,7 +3380,8 @@ static u64 bpf_uprobe_multi_cookie(struct bpf_run_c=
tx *ctx)
>  {
>         struct bpf_uprobe_multi_run_ctx *run_ctx;
>
> -       run_ctx =3D container_of(current->bpf_ctx, struct bpf_uprobe_mult=
i_run_ctx, run_ctx);
> +       run_ctx =3D container_of(current->bpf_ctx, struct bpf_uprobe_mult=
i_run_ctx,
> +                              session_ctx.run_ctx);
>         return run_ctx->uprobe->cookie;
>  }
>
> @@ -3565,7 +3572,7 @@ static int bpf_kprobe_multi_filter(const struct bpf=
_prog *prog, u32 kfunc_id)
>         if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id))
>                 return 0;
>
> -       if (!is_kprobe_session(prog))
> +       if (!is_kprobe_session(prog) && !is_uprobe_session(prog))
>                 return -EACCES;
>
>         return 0;
> --
> 2.45.2
>
>

