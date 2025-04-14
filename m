Return-Path: <bpf+bounces-55869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5137DA8883C
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE67C163741
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA97C2820AF;
	Mon, 14 Apr 2025 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPW4S2nx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83BD18B47D;
	Mon, 14 Apr 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647208; cv=none; b=Einvp7a/zgOzKmH8Nr9LAY3JtO4nS8HQUEo9LsYWL6khIV5HKrn6TE5rjjajo1L3fD2OunEV5lhyiPh1zR4kgwxkzwbRG8TB7l+liQeCHBQsm4UOY3vyRufBqBWjvr84FOflrxzLu7lAEcu1NvBfyDZvIe8H/59ux00qTdvQWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647208; c=relaxed/simple;
	bh=qvY5jbw9xck49ja7zEGLtCus3TlqmsPPGWXLilFOgtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muwHdrDdJzWqNRrWVtpSyeM9QYVkV9c/yftt/FF1oLhTayVS/75KYLAnBzhxrTOoY+uox7g+YK+AxlvyXau4ckA0pxmOW2nWB3zgTPBdPB6z/V8TEDPltOaCDJTSFXs8SotPaq0ixrWc6GYL4nswX5T+noEQKa1I+uL3Yf0OdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPW4S2nx; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7376e311086so5919488b3a.3;
        Mon, 14 Apr 2025 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647205; x=1745252005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7sePUcE9HIgeV2MXGQ7FHHQQwxS27mT0RN9Iexrlfs=;
        b=CPW4S2nxK7TgSDk/7Qg5G1TLNumbCQV/M2SegJqub+RrSWqHaeftQlNOOgRTpD/s5g
         RZPNfLXn1UoI4iOc+uina+9mq/LSCQnUu5fkKp/OkuBnzf+qf/3ukSlXenoISTNL3nlK
         dCPPwvLbQ8rIiICPI7UwSl+L9LzinK6mdj5eVXAMsbEyprc9w6mdoKgrfxyCAjy+88Zw
         YDKjj/fh9Sw2Oi98786wy6TyOV/YZu/FzzMP/jWnTWQyAJFOKQtEUZWHGLMgT1tgawyk
         rEwqGDepG+l4y6bTkZc//RPZRgEl0DsuSFx71tkot5N+l+JJbdp07KhCkdouOeB4jsPh
         6b8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647205; x=1745252005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7sePUcE9HIgeV2MXGQ7FHHQQwxS27mT0RN9Iexrlfs=;
        b=IFEwO5xx4IOj11SMQTmZ10d8H8pSRfrU1opKm7BroWHox72i08cjYZqd5zsVC3vEO4
         LbTX5iUaLAVSAP0yn1zJzrnKTE+c0Af+6jGgUIPISw6/gPOTILQhVNAMWkglwZHnA6wE
         ieFcKQAye5KW3ymTisR00FzKjzCbhwvHTVD5IBfxKYTeVqEPZuZASsNBYt39BRDYfPiK
         y2z/IHXlOldqwc+6uuVT5Gg//R5a56gU15Bxk7Y+T3yk0P7HoMohugw/4kDH4wRngKqB
         a8a3/YPYjsMbllgE+y0p8ejOjOhEixmzmkANit7hZSgCfp2Z1l93mhJJG5cCvq07E0MI
         kUYg==
X-Forwarded-Encrypted: i=1; AJvYcCWUUpe2oZBsNFVAEKzT7cIPh99RePzMH430IkVloq32y2BP4V1PvCXS0/pzmu9vvIsu+MONUaf8JPlY077nOTsYU/IE@vger.kernel.org, AJvYcCWoP6T3uQ6jWPvoaAy7jLkzlvOtm7FDljpmY1rodfMW1w46H2nbaXXIh5Tbsm+k+KgKMW4=@vger.kernel.org, AJvYcCX9FwbgKIfF8j3PGqHEcNemG8f4HLQ+yX6MZy9EGIAhrAs2qRrZhIAeGQPqtv1dKS0xXHmXf2E5NUMWfmD5@vger.kernel.org
X-Gm-Message-State: AOJu0YzdHy9mIZJqujCoipidWwvkgstKvUGAnu+sYX2dk4m5yd/KTJEo
	yfPBMmPRmXBqOd5HX0DCPF8UpiGiXgZSQhxPtFkETrX/d311no8rWoPWSpS7P55fF5cTwMTz0rP
	i8zjSn+LkHK/ru2hTFMRr/0zZ+JY=
X-Gm-Gg: ASbGncucAlDNqD06D7b7Kx4/77E1uOQrzN9kIkAlpLhPuolQcf+B728OFPx4mpgoTMP
	ZlejdCATF7K+rSBij+I+IzyLaH0TjsHekPvn2kdJSd7ObNjwJwfXGTLVpqtOK7ax71WbViQ5S5B
	nwxMwo1FoduWio5tWI7jiMswtcyqNCnXB9uVI9
X-Google-Smtp-Source: AGHT+IH3M6IekqDA9trVQSTP7w3YtX9MsvupPQT87oNq3E7jVYoQAzUlhHDq8AGl2C/p7mn/wSB6dYuVGumruWvFb1g=
X-Received: by 2002:a05:6a00:3a12:b0:736:692e:129 with SMTP id
 d2e1a72fcca58-73bd12dc55dmr19720328b3a.24.1744647205102; Mon, 14 Apr 2025
 09:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414083647.1234007-1-jolsa@kernel.org>
In-Reply-To: <20250414083647.1234007-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Apr 2025 09:13:12 -0700
X-Gm-Features: ATxdqUFXB8BFcxBhMUxOKY3N-lM3POBF5mr_feBuki3H8W05xVbP9Sy1PeQ974k
Message-ID: <CAEf4BzajT9VHS5erhS0NgVN4hot9m2tW8SijZk1tyyHe9ArFLg@mail.gmail.com>
Subject: Re: [PATCHv3 perf/core 1/2] uprobes/x86: Add support to emulate nop instructions
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 1:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to emulate all nop instructions as the original uprobe
> instruction.
>
> This change speeds up uprobe on top of all nop instructions and is a
> preparation for usdt probe optimization, that will be done on top of
> nop5 instruction.
>
> With this change the usdt probe on top of nop5 won't take the performance
> hit compared to usdt probe on top of standard nop instruction.
>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> v3 changes:
>  - use insn->length as index to x86_nops [Andrii]
>
>  arch/x86/kernel/uprobes.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 9194695662b2..6d383839e839 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -840,6 +840,11 @@ static int branch_setup_xol_ops(struct arch_uprobe *=
auprobe, struct insn *insn)
>         insn_byte_t p;
>         int i;
>
> +       /* x86_nops[insn->length]; same as jmp with .offs =3D 0 */
> +       if (insn->length <=3D ASM_NOP_MAX &&
> +           !memcmp(insn->kaddr, x86_nops[insn->length], insn->length))
> +               goto setup;
> +

LGTM, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>         switch (opc1) {
>         case 0xeb:      /* jmp 8 */
>         case 0xe9:      /* jmp 32 */
> --
> 2.49.0
>

