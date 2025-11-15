Return-Path: <bpf+bounces-74630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F38B8C5FEC4
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C92534FC59
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ADA21507F;
	Sat, 15 Nov 2025 02:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InKzF0/L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DB914B950
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174582; cv=none; b=DivBDS6dB6QifA6Y6RFOsZy+1+8sKMTWUE6eNyUWS3Xh2OhK7FG6B4/OznvhWcwOSQj7QOvHD2B4UVWLFouJdwV4mcUIiYZwaSZdZP8hWdLzRfgs2K2Y30i5M4p0YR9Li9ZN55uCFTBdN3OLGqlvwLfsMg9wjAqtm7+bve/Td8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174582; c=relaxed/simple;
	bh=w5wgG1MKR91CsxuNvAx7QjHjZXdAXzWJYTL4WmJ8MPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isODxo6OeFRB8iPRUQmxGuFbrwygpUSIRG1avKEoJMdlIMpeySYt9//Yzr5mn8JSY0ul9xDor+70AoFcUV69p4YuF6IkE++CoPRhyRZmrIrEkZhHCjFeDdeTIwN9r+3pORiJaRnkb1PEjs++f7xpAlybcjrZNElMfgVmt3p+7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InKzF0/L; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso1489290f8f.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763174579; x=1763779379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5wgG1MKR91CsxuNvAx7QjHjZXdAXzWJYTL4WmJ8MPA=;
        b=InKzF0/L+mUs9nIhjx41agXCOdcSEgjmWDXJOLZZUGTePezDe+yNhNaahbD8PZTLnK
         vogOTEV+tPcnozcuGTdIfCI97MTmr0oQoeKQMzRCNceJlnlRJ+icTlOg2TYGXARjKo/m
         /96eeDVl/Q1uN3dpIYZbWejR22QABMKPq8MvaVu6oGnVxre5UjjbA7r+GBKI93HJKTdu
         QPrsDo3gEWsFaU/T98DjY6GeBK/TJf8Y6bYQLwEbUdrofbELwdeP25sSAkeVXBNeXcuP
         ruDRBROV+fvINebdCsCN5EccAuhXDiuIjmtrd8XEA2FncTCbW8/pceXH4n0ivg5pmgg3
         9ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763174579; x=1763779379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w5wgG1MKR91CsxuNvAx7QjHjZXdAXzWJYTL4WmJ8MPA=;
        b=ODJq2qXesu2Tcwnl94FqMK5c6YuXT5p3sbQa2UeNopjRHo+u3iBCA0yZLCjY7w9DIL
         F9vMpd6Me8IVXmS09QTzZT4qxuxrdeY4kAlAtrMYWMkY0uxC9/jNuC/ibWrAncjs74kf
         02hTHHqSH286zcQzZV9sa66vwbxUheZzRYovVFcmImAEt9f1twsIAB1Ws/qhC3qG0ZGt
         mV/FiQLaEXINV7Bu8okFO6RMRaFzv5TbvBAMyAjnIFqsdCyXkV24+bJ755SyknJTbGZR
         lOGF7W8kFsONf4bhuM3Kfr1w3d4H0aqPbiRvqKMRwC/Wshi8YN+gRlrU3sFrrJW9pkgE
         dBXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAQov8brSGIw3RonWKZcQGmryFnGjLiGgqMXkzP3qnwhCjMfAri2kwA2AuSQAEKQznBzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtTQhAM5tVxP9Vezmma2YeiH7qyuK3e9Fc5sYCv5ccSHOSPLYl
	2y0VqDKAQEZjFhxhiTYATmbJKZLKD8yAQ2BH7A+H2nJy2wX3R+ufdAaVlcts2ufwC2qJ8VJ51Aj
	4x/GYXGUBl6kJPUhHobtM2wlZ/beKdGM=
X-Gm-Gg: ASbGncsr+B5dFhWgWnBQlyP7U/3Wx8N1Z+pQ3qc0LqZEU/vavqL9Q+RWsXMkOM4iBTq
	i1+LibudvFgmUQbIsYo6D9RCeljq/xz4oHWQhuDuIih/2Ar9yLltMEpNYLKE4lgWLnmIGluuf+e
	JkSDdZefduwzQBePcXD7bbQLJOWGCLYj0X03qKSr3ELKtWypdRYRmUNJ85RhnK1gMBn1CsXRslU
	gbNkN5N6GhK9V3El+6vmK9svq3F4e76tMKrnuDkKC0fO4SNJgTSU6LMxUN+AW5D9UwmhSbDXG1t
	2GA951kwQq2S6OP/I8pOeDdDRtZ1smoYDQnhWM0=
X-Google-Smtp-Source: AGHT+IHVzQscXXmrUSEQCZZL1CtQ82WdcojH4qYjNbQi464TgTrJ4qRsKMtK0vCa8hnqpYgaM17ur3cDY1FZhF1FUhc=
X-Received: by 2002:a05:6000:290d:b0:427:6a3:e72f with SMTP id
 ffacd0b85a97d-42b595a4daamr4462844f8f.34.1763174579433; Fri, 14 Nov 2025
 18:42:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
 <20251114092450.172024-8-dongml2@chinatelecom.cn> <CAADnVQKw9PtRYooO+qKQ70xgNusEn8qusBFfzU+bZ7WXRg3-3A@mail.gmail.com>
 <CADxym3bKsw=mrG+wNErLouhPSeobuqY7sTZRS=HrNeQ=0=p4Jg@mail.gmail.com>
In-Reply-To: <CADxym3bKsw=mrG+wNErLouhPSeobuqY7sTZRS=HrNeQ=0=p4Jg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 18:42:48 -0800
X-Gm-Features: AWmQ_bmXHzn1ZQkddhrB5SugZxEfOGbPyMWJGgz5O7479flWgWW2q2yLLox05JA
Message-ID: <CAADnVQJiHExkioeh3t=4y1CWPiUkeV08ZHjeJfpZChkY6dNvhg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 7/7] bpf: implement "jmp" mode for trampoline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 6:39=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
> >
> > How about bpf_trampoline_must_jmp() ?
> > and drop if (!ret) fallback and BPF_TRAMP_F_JMPED bit.
> > It doesn't look to be necessary.
>
> I think you are right. We can check if current trampoline is in "jmp"
> mode with the "orig_flags" instead, and remove the
> BPF_TRAMP_F_JMPED. That means that I need to pass the
> "orig_flags" to
> modify_fentry -> bpf_trampoline_update_fentry(bpf_text_poke).

Yep. Makes sense to me.

