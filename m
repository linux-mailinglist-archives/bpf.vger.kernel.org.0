Return-Path: <bpf+bounces-78967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEA4D2178A
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 22:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2878E301F321
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 21:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E283A9D8E;
	Wed, 14 Jan 2026 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQZUoJxO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0268238F954
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427816; cv=none; b=uuzMhOSoDXq+zBKi8pH9YjrXwSAKMV2poDuiYXfWyLwnHydDdBfHvzQbYgtJ8hlrVRYRjpFLmP/fTnzVSwC13SPZJ/MtZ5hmJiIxt34238XIDAcnS8erH21RlELZOgzZzKX0PQt7iT+1R4r4l97b7OAdFZ9omZDWoRG2SHY+wMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427816; c=relaxed/simple;
	bh=GhnFSKeN2Zl7Uze175m/2I1Md7YRb2qMzTVcY7DlFvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/J3p9wnlrZvrW+b1+TY7TfYl7CzOnla/NytlaesjvC9HTgIUuzGmvy9vohV6S+wu8AzJMP56xNclPD4jGGBeCPRSOtAUiHAj2A9ExNHiuE4cJjnM/xwtvPOapVWjzJaEPsND1oBP/rXoPgt7COr0ODFqu1P22jnHe6NRcp9Ue8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQZUoJxO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso2517745e9.2
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 13:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768427783; x=1769032583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2IFPWB+T8VdoZY6NJv4zwx5iiV744THuNeTgWC4nyo=;
        b=fQZUoJxOaUJFGdyaLYelKy7sOZpSVZER3GLT5CDfmciBUY9rzu3JeKM2Rra9TKpRI7
         FAN8zz4cOkp2vNZeFWc3oSeZsOSqH16Gdp9tc3lFCdbB3B1yMjyQHQKcHtwvt3TpvBXX
         QW+n9K9Zhc7jBMsQLqZzkBDfmrAtp81USjKoQX0QrNEyon1M9Q8wjFNtvB73qDp8nGZi
         4TRbZtzF+vsEmD5EzdJ/3/Yi8kN5SZOm/QByIXDxCkDu6aey9EaANXP9mYLxjXLt+ng8
         6i57YprppSZwKIy+mZExmt3dWG9eRGYu8K5ZhLZjJtDlUtjStd/l5Tv2DPfQMKzRUZO0
         vw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768427783; x=1769032583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V2IFPWB+T8VdoZY6NJv4zwx5iiV744THuNeTgWC4nyo=;
        b=uETAMiPOgQb+kTDmaMk6Xl9uP5uhLoXvjr/UsljAgaSM3lVjxtUtjAMI2FDicuHHEI
         9bdH1NXTQ4MN8tErNN/ptLiXaiWwgik6fHdqc5EzgK6CbS8oIRNao9nWzI0fJUFHqRMJ
         SvGfZMcEgc3O5EARn1fgBdwTGjl15R4PwCI2r+uOL80gckqFMwBp2Y4Xa5+LljFCG5N5
         m9yu9aKNuUsJdlQxPYpbUzgQLEp4WVL4LFzdM3pktmDFPckN1g25ptvep6GvJLMcW8oH
         SSWKen+Qc2hreIbYKjOgWcwrbEm/oqghwokxFrbtBjTqfgOwp4BqdIY0m/rvbXUTWvti
         RhwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYfaSh8LzfOVotIX6kNfYrwGdp9+wK5jPgZJHRYHIcqCm+IuqMegrPh3M2reTUMvGg6Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxroe+h2lID6KXkiUxtpWt35jv7f4HbWK9kzANqHV9hKdWTZw/
	rvgg2mHRHHKz90lDfKkzXIE/tZGYa/uzSb2zEIzQwsWODqpC2c9KArVaUJ0kKBpENnq59i7a3Lh
	3PQBsHSN+topDTx/5kjJBoA2h2TTFNqs=
X-Gm-Gg: AY/fxX4tRG7X5X0TGqpcT/m5MeLkVig7t0RPn0Ri15O6tDDd0zz4RU5j7uz/PLb4jtZ
	1hFmddEqvvBLDAn0C2pY+akQ1ToUktmxdeFbZ0P3d1TY+v+P0HSeQj8KVzKAvluz521ojwPzzFD
	NJuBcNwXFfuWlwSn9bm2x6O6LgISrEqG1H+XkY3nkyfmaa3bTawE9nm2vfYsNzxBUGoxElFhTc1
	mO3+Br3hKGfn/LAh+A4uZ58kX0ylxweaH/yVtBaWmsAJwqvNT1vmCSkER8XdR604bShNpTDcnpP
	YRcCysdXM9h8AxJd/4jOfP3sepuy
X-Received: by 2002:a05:600c:4f0b:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-47ee4819f30mr39840995e9.19.1768427783081; Wed, 14 Jan 2026
 13:56:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102150032.53106-1-leon.hwang@linux.dev> <CAADnVQJugf_t37MJbmvhrgPXmC700kJ25Q2NVGkDBc7dZdMTEQ@mail.gmail.com>
 <aWd9z8GVYO12YsaH@krava> <CAADnVQLxo1uPbutGNKrv=f=bSVkzxOfSof0ea8n7VvqsaU+S3w@mail.gmail.com>
 <aWgD3zH7vsiBdIcr@krava>
In-Reply-To: <aWgD3zH7vsiBdIcr@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 Jan 2026 13:56:11 -0800
X-Gm-Features: AZwV_QjPeGyIa5g7MAD4JaS1tAElwUa_x4uErmV3ep-P21EZz9S74OzD-I8OSSs
Message-ID: <CAADnVQLHVogD1mjMCsHcJOayuZW4OwadEN0g9wu=6d97uRSWqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] bpf: tailcall: Eliminate max_entries and
 bpf_func access at runtime
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 1:00=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> >
> > > fyi I briefly discussed that with Andrii indicating that it might not
> > > be worth the effort at this stage.
> >
> > depending on complexity of course.
>
> for my tests I just had to allow BPF_MAP_TYPE_PROG_ARRAY map
> for sleepable programs
>
> jirka
>
>
> ---
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index faa1ecc1fe9d..1f6fc74c7ea1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20969,6 +20969,7 @@ static int check_map_prog_compatibility(struct bp=
f_verifier_env *env,
>                 case BPF_MAP_TYPE_STACK:
>                 case BPF_MAP_TYPE_ARENA:
>                 case BPF_MAP_TYPE_INSN_ARRAY:
> +               case BPF_MAP_TYPE_PROG_ARRAY:
>                         break;
>                 default:
>                         verbose(env,

Think it through, add selftests, ship it.
On the surface the easy part is to make
__bpf_prog_map_compatible() reject sleepable/non-sleepable combo.
Maybe there are other things.

