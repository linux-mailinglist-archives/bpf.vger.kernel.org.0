Return-Path: <bpf+bounces-38594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C7F966A27
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 22:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87831C217B1
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 20:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA711BF31B;
	Fri, 30 Aug 2024 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9k78Q+F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FFE1BF301;
	Fri, 30 Aug 2024 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725048086; cv=none; b=bnM9fJRKTQV7hBnKHARfnwKob11bgwp/yTCI29BjvI0o8J+6kWnpIWn/xElFPWN5Qi/7yz1ZRicuHQ6FcpeE/gL3DT/wHZy87q0e0uUATP3QTFhc51sZWwAVD6KdZlhM1CJdt95JEoh2919W5obrWu8KCHJEj4gDW0s73GYDVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725048086; c=relaxed/simple;
	bh=hYQ7jcZbc3uIDAFFKWW6FDgp0KZtFbwMMmTZU3idYCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PC+d96y/hL+6zipXvf7h+qBDMdeHccxKyJl3339q7aCPMjh3HGlE1V/0fXP2euiKo4mO9jztNT5XL4s1iiEgR3tvUlL8zmHXsiHVKd9lmCJWipqygQl3l3465OO6RVwO8HJWh9otC09gUP715tFtpEsgbyyc2vh74/zI3fLFfJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9k78Q+F; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d88c0f8e79so321065a91.3;
        Fri, 30 Aug 2024 13:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725048084; x=1725652884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnSY6syE+YjI9c87i4XkqEJUxNVqpprXoi3T2x/tb5c=;
        b=A9k78Q+F+d142yWrMb0cpSMIKMqAA18Vp3LzRz39N16KKLDXtv6kF8AtvGSm+TEhCY
         DN0Npmfp3Tm7yxUGJpq4rSBKpETu8RUXyUFDRhmK8K8OC6NYb9y6eNrv6dfkgf/mq06s
         Mm8T1wXOV7mupjIqlTpOD4Ms6kqPg9XYW4Zw2WiGMp6Ugk6PeoakhGOD8SvB+FQDF4jw
         wQG3Qc+uZlxoO1/hO+3cln5ThgTd7ABZc5uWESw2++TZSMyC2FStLEeqMTU2TO27OWZk
         IX7aZ+IG+zDX/wGG88wscsdSe+HQCp8Tr8OE33wOL8/WfaF0XwgN5+7+JdlBN3i0wzgr
         sf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725048084; x=1725652884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnSY6syE+YjI9c87i4XkqEJUxNVqpprXoi3T2x/tb5c=;
        b=lkYeC1GpnBudzyfF606YDG2ZKG6X/ghPZZfRsPqPF+MB4nU/rjJ5NSafePNq+XF5ex
         K3QNWhEMAH1IoVh+51GlMU2NXzABP+sPDj/RcL9a4TLpMSpo0Nw1EwyxxDrc4gUTzGiX
         fX+n9hE4GZKmEeDIjUaaYMmaL8QIauD6t6cuxXz3b3Ze/hPgDCEDDJegGHTeJCLn8mr+
         vskJnEAeDJ9UflEX5s8s7Zg64mobRKFoCjLLUuWosqW27P7J4lfpX9DG/wABL9TpiOKk
         Z+3NinkliPvKxdMvTh3iMxQ9ueCDuf887hoR+K598Qnd/HtUWtsEQWJesysb2UZLY1j7
         3pZw==
X-Forwarded-Encrypted: i=1; AJvYcCU0/ozp4V1MWS7ut3WzEDZDBY6jeok9yA0SbaNEdMca4eQzWL2JQk75sKA7rHpovSV2EpY=@vger.kernel.org, AJvYcCUon4c54UOoB7HSJmQsw2QTrjIZOepoKv+HOqXTqcfoJAFJmdqg1hs9sIqNzFqcCo6Q5wtlzKN/JmpSL0DK@vger.kernel.org
X-Gm-Message-State: AOJu0YxQW4OLR4VBjCkB9v9gK83ewemQxZuCexTtHqzKOCvAhBE11uYO
	tk8G0/wlkmZESe+TK5+NGzqHpWnSy7e8ZoUrmeMXYtt4iIh70Ad1Ofi6B3iAB8UMPMk4kzyj26w
	Qa7kmxGYRoTYC6yvn8imBe1zXmhw=
X-Google-Smtp-Source: AGHT+IGkeaBxDz6J3AbRGksbsRYoZ1i/pk3Kzd/RE+MltsJAFVPqanb2o72d5SHSljm52Ssaj6Q7yV/Fg4tCYIPnwrA=
X-Received: by 2002:a17:90a:cf13:b0:2cf:def1:d1eb with SMTP id
 98e67ed59e1d1-2d85617babfmr8198132a91.8.1725048083538; Fri, 30 Aug 2024
 13:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_9F90905CD6FBE5B00AF1EBD9681A62990106@qq.com>
In-Reply-To: <tencent_9F90905CD6FBE5B00AF1EBD9681A62990106@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 13:01:11 -0700
Message-ID: <CAEf4BzaCW03xOp6=rSUqmy8DRFvGJWHy1LyGNdpP+D-D9Eo+Yw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] samples/bpf: tracex2: Replace kfree_skb from
 kprobe to tracepoint
To: Rong Tao <rtoax@foxmail.com>
Cc: andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org, rongtao@cestc.cn, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 6:19=E2=80=AFPM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> In commit ba8de796baf4 ("net: introduce sk_skb_reason_drop function")
> kfree_skb_reason() becomes an inline function and cannot be traced.
> We can use the stable tracepoint kfree_skb to get 'ip'.
>
> Link: https://github.com/torvalds/linux/commit/ba8de796baf4bdc03530774fb2=
84fe3c97875566
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  samples/bpf/tracex2.bpf.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>

Maybe just remove this "sample". samples/bpf is abandonware by now,
and we should slowly but surely convert whatever makes sense into BPF
selftests under tools/testing/selftests/bpf and just get rid of the
rest.

> diff --git a/samples/bpf/tracex2.bpf.c b/samples/bpf/tracex2.bpf.c
> index 0a5c75b367be..dc3d91b65a6f 100644
> --- a/samples/bpf/tracex2.bpf.c
> +++ b/samples/bpf/tracex2.bpf.c
> @@ -17,20 +17,15 @@ struct {
>         __uint(max_entries, 1024);
>  } my_map SEC(".maps");
>
> -/* kprobe is NOT a stable ABI. If kernel internals change this bpf+kprob=
e
> - * example will no longer be meaningful
> - */
> -SEC("kprobe/kfree_skb_reason")
> -int bpf_prog2(struct pt_regs *ctx)
> +SEC("tracepoint/skb/kfree_skb")
> +int bpf_prog1(struct trace_event_raw_kfree_skb *ctx)
>  {
>         long loc =3D 0;
>         long init_val =3D 1;
>         long *value;
>
> -       /* read ip of kfree_skb_reason caller.
> -        * non-portable version of __builtin_return_address(0)
> -        */
> -       BPF_KPROBE_READ_RET_IP(loc, ctx);
> +       /* read ip */
> +       loc =3D (long)ctx->location;
>
>         value =3D bpf_map_lookup_elem(&my_map, &loc);
>         if (value)
> --
> 2.46.0
>
>

