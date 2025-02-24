Return-Path: <bpf+bounces-52443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5211FA42FCC
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D7D17ADC5
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E76A1FAC5C;
	Mon, 24 Feb 2025 22:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyCbLraJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53381F4177
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434918; cv=none; b=BQoTFXtxZVNUIGNZI+1xaqIcfb+s8tVLCAway5Nfjw5ChupFvH9VRYnBRafYgpT9L/ileACVq6V8+uJtC+/sQcz6dphblUjGAmTv3Jj7fPvT1pPJii+3hGMBxuNtN0yoYG6FggILEgdpFEbcaqVPCVvmf7MNwZkqWxBvp3h+Byc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434918; c=relaxed/simple;
	bh=t9bfJQxPigfNRyjwzhRujMW8dIJKseQLM25r8C6JW14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNtHrUWZF0uUD7wyfGBcLy8Z6CFRAomE/ZNU1oIiIJKzrwG3p8Fd584ZClc8FWjrJ/XfwgYyYzqYy4UEYgawaOkDzdIHr/UktZ/rZGruha2ut1qOorQ2kOBFGhZh7M48wmPdXeD0zuEcb5yQ6V5wfXj9qsg3Gh8TqH9oOYhAEuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyCbLraJ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc0d44a876so7939714a91.3
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 14:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740434916; x=1741039716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R0ZSBog1cdegFhuLJ0ePwp7uZkd7aNvj2+R2VlV6n0=;
        b=PyCbLraJi4DnGgfafzJMujIplqp5odJ1QSX2c4LWD7rpH5BDEGTsDclk2tgYOm/jtG
         ecYFVU0uFicFTanqrwdeRw8ONXEbmpkO04maNUn4/xFjSyQpngRVSgcaJurpuBYWxSIS
         VNVKX9T4Fnscs/VQ65lGiQbQ6Vfs1dbxxZTbSZze0etNH/d7ZONNz+cT2PPZBsddTAQx
         2YIwIWk+4ZW1uwoJc0xMrK0vRwNAcL2CS7votY5AyCwmIW1MBlMwKlDdWKc3xxdcITkN
         w6lfoYtpB/lzmsAcS7zdYqyY8rluq7g4dpaEIGX3XXDPW1YCPqBHoWHOFG1h7D9znZyl
         KFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740434916; x=1741039716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6R0ZSBog1cdegFhuLJ0ePwp7uZkd7aNvj2+R2VlV6n0=;
        b=BW4GMfG80hLUa+Wv0YCk8urBsmdta9mVj6watikmxYBdgohsw8nOun7HZ1HJ5K64gK
         o7BKSuaEE9VA0FcFSIFQm6PHejvEApvXI6MpojfeR1QwCY6351vICMUxOIn5q1TJsyRb
         Tb+VHrMg4rW0QlQaC2Rd9DMhh7IsgB13AS2pBN03/aJOScAvWEpJaqcF8r3TJCfW0lXq
         Z1+KAD3chtbnOvAobKRS3Znas9eWmpD63m6soN0WWPSLAQZVH+BpFQzGUVdB8Hh/ur4E
         AC0ssX4vDlhjkC8PX//j24n+YPN7qPTYLBLFTgLQqhEzfauBw/IrWq31jb8q1PP0i9+3
         u3FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgpwLEQDlCTIaFf+WA3ABLL7SEZfa3wrdklooiSSQaVL+P+uaOQ2UFvOlP8jarmq5SYDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7TlruWvmTV1g4RNJaWieF0w7z7YaicTopIANxg3zuMmLZu9mc
	iUVeloZf4OqhVF4/ZWYNSmdZT5fYIp9IpImnKLl5y92rid1fP0NBP0NpGMEuQtWv8lHCY7TGvfZ
	+SutDdWYK8hZBInODo5p6lM+vaX0=
X-Gm-Gg: ASbGncss/4j34fbyDc1RI04Ap6C8+JiHdFtYgHqKf6/J6zFQ6i2lnD7dx5aMEeuiolD
	VxVvWUS+BmirUYCy4zBsrls/vIqv9wK5Z5fesgcfl4DAn2V4CjHDwJnms5JW4JH9+S01YXIcqPG
	IhHaYnAsfEDs84txywAVyRX2w=
X-Google-Smtp-Source: AGHT+IFydDmysPYmF5Fg2aWsrvsEraykhmS3ry96vF1qp82FGm7Mn++SX4uj40AjnslSW1mcoFqg+Y2qZZ9DyIb9L0w=
X-Received: by 2002:a17:90b:5385:b0:2f5:63a:449c with SMTP id
 98e67ed59e1d1-2fe68cf4000mr1223217a91.28.1740434915914; Mon, 24 Feb 2025
 14:08:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224153352.64689-1-leon.hwang@linux.dev> <20250224153352.64689-3-leon.hwang@linux.dev>
 <CAADnVQKOeKfxL_3tCw1xWNS1CpXz-6pVUG-1UWhZwpPjRy+32A@mail.gmail.com>
In-Reply-To: <CAADnVQKOeKfxL_3tCw1xWNS1CpXz-6pVUG-1UWhZwpPjRy+32A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Feb 2025 14:08:23 -0800
X-Gm-Features: AQ5f1JosrMaw-VChF2GyAWAY9BtS3SH3Q19ppfCa6Dx8eMpfI9glC8K9Tg-zGMc
Message-ID: <CAEf4BzaE+sRmnPMN_ePQ1sa7wHuRNn9zktu85Z5=BRyyVEXM=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Improve error reporting for freplace
 attachment failure
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Eddy Z <eddyz87@gmail.com>, Manjusaka <me@manjusaka.me>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:41=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 24, 2025 at 7:34=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
> >
> > @@ -3539,7 +3540,7 @@ static int bpf_tracing_prog_attach(struct bpf_pro=
g *prog,
> >                  */
> >                 struct bpf_attach_target_info tgt_info =3D {};
> >
> > -               err =3D bpf_check_attach_target(NULL, prog, tgt_prog, b=
tf_id,
> > +               err =3D bpf_check_attach_target(log, prog, tgt_prog, bt=
f_id,
> >                                               &tgt_info);
>
> I still don't like this uapi addition.
>
> It only helps a rare corner case of freplace usage:
>                 /* If there is no saved target, or the specified target i=
s
>                  * different from the destination specified at load time,=
 we
>                  * need a new trampoline and a check for compatibility
>                  */
>
> If it was useful in more than one case we could consider it,
> but uapi addition for a single rare use, is imo wrong trade off.

Agreed. I think the idea of verbose log is useful for bpf() syscall,
given how complicated some of its conditions are. But it should be
done more generically, ideally at syscall (or at least the entire BPF
command) level, not for one particular kind of link.

>
> pw-bot: cr

