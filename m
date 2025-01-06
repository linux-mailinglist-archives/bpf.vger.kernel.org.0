Return-Path: <bpf+bounces-47912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6DBA01D97
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 03:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EC0163414
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 02:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C500A1D86FF;
	Mon,  6 Jan 2025 02:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0XQkuqc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E5616191B;
	Mon,  6 Jan 2025 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736130774; cv=none; b=dqCqQ2BFsSdbRVRoKbctHDingiQTy2OAxtFZzovRvuj432NXsjV0IqDeC+mpD6ZxvCQwpErXB2GRuz/11bvLerTavpz7od8yNdk2tOamaEVSOoRwU9TdY0peQEsXwkSdznfqXGJwkPxZrDokEgcnhOKq6nXCoHktqH93SYVTYu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736130774; c=relaxed/simple;
	bh=C5PSASVt8s8gKDxScZiQpBrHlwaGgwz1NRYiAvdvZDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foXy3bJJsdvm5KRmb5QDFSjhuzcA4J+E7s2+EqODp9B9bpbosMei5gpiNECkeQuPJ5YncEa2Xq0JJHw7UNGq7i+1EcBv1ZeupTJffCINYYcVVhb0d0rnVNcPNdie34eUQKkoWNZQn2ZZlFfVSv0a41/XLTCiaa8kI+/SC0PcRdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0XQkuqc; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d896be3992so82198936d6.1;
        Sun, 05 Jan 2025 18:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736130771; x=1736735571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyD4ycAlKLm+dJzi8zquZubTEnRDreWOPRb1Lh7I8Uc=;
        b=U0XQkuqcpl6PmD4rMKYY30WFSpctvMTD+qsIshwrU9y5KS4p7nanWXWEwoQvJ0Mbae
         q46jrMhU2TZQzj8drvbaXPdKBDwQquZvbxM2x15rDgN8uTvczScqMvY02m5wN4kusF5K
         XurqVP5OuxoadJv1pDuT9J9j1NFRXAT1BicPZuYIoObkMZhvN3LdrJz6otur+U9IBVdx
         E69XmBiCc08gd7YR6UDNAdKPL4OkOdXC0KFqG7JZsb/XvEb/K/DZmmFFTcxCXqN6TBRw
         PFJ6TwvK30GIns4xY4VfwCbg9MoR4C0Y/Znt6kJZmgpaB25iCU8lfwbZXcYofEaeCtsm
         eibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736130771; x=1736735571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyD4ycAlKLm+dJzi8zquZubTEnRDreWOPRb1Lh7I8Uc=;
        b=lIkox3nqI3Yd6ZRXJ9KoZzZiH45kgB+u4sM+Px+RTcxvAOBiiwFpfddXjjal3bzE8W
         EnegMFzKQUPAN/sxy2B7Y8lITmNDvta8PEn92J20aneviFRo7FgTh0Ze1F6gmphAyvbd
         Cl0J8An0qVGTOS/WQQQv3L1NBZQJt6GUAcepdE6wXkUbb1l93PvX2uZoOeHsOn+vXoi+
         5ao65e6A/AhBVosQyGHJZ9BTb66nVioa2F2Phl2gyxftnHy2OeuQIlsZg5oE3viHYWxc
         SNyrEOnUDrgmHzoI2UvaGANqh7Fo8lSfE34t+8q+TqkUw7lfCtyfPwE+ZobD5rNkKPYe
         QXwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXPWkVbYjVOB/yKEjYKEU/EE5w0w4kfjb37f/rrJdwhFu/sPkqPw7vxU7WSuf74XZ+F8e1xaSv@vger.kernel.org, AJvYcCX3F+xO5rKulKkoqnGFnCJffAHs6Vx/7RtUIBEKnQy0CLTbU41Zfim6SLrDtwYYynrDa0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPUcIm3318aMFZiDhJhijj40VELS/NWRTfjZrPEFS+FgOfd+Q
	JQp7+IvxpgCTmfLPE40kf7CN1WF7oxBvdh+DZHRrUB+iLVnE2Ok9O0PS0RysvQPt4+MCspvXps3
	qg0+xz7f0OzoXL7Y7nZVEuWlv7mM=
X-Gm-Gg: ASbGncvSt97O+haBsENLib8zf9jFWSsiGwRuh4LTBpsq2cTTXaXdPOHmO6ITUtznbNf
	VQjAvEBc8CuxDTjNorAsKI5I8tSpcOwa6b/zVdVhj
X-Google-Smtp-Source: AGHT+IFggkFAI/yFgXl14W1IFITq436W6P9ZIdOeBmVDBIxmLLdJfglnirKM2gl+QymCL2DsxAa595oNKBMZuFY1u1Y=
X-Received: by 2002:a05:6214:4199:b0:6d8:8aa6:ef27 with SMTP id
 6a1803df08f44-6dd233978bfmr1105095646d6.38.1736130770954; Sun, 05 Jan 2025
 18:32:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105124403.991-1-laoar.shao@gmail.com> <20250105124403.991-2-laoar.shao@gmail.com>
 <CAADnVQ+ga1ir9XCDxPiU_-eYzKHTQsiod9Sz4_o3XeqGW2rq4A@mail.gmail.com>
In-Reply-To: <CAADnVQ+ga1ir9XCDxPiU_-eYzKHTQsiod9Sz4_o3XeqGW2rq4A@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 6 Jan 2025 10:32:15 +0800
Message-ID: <CALOAHbD+w3niwBojP=-81Wrqj1V9ppLgTfuZjb=AxXjx51MGRA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] libbpf: Add support for dynamic tracepoint
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Dumazet <edumazet@google.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 8:16=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Jan 5, 2025 at 4:44=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > Dynamic tracepoints can be created using debugfs. For example:
> >
> >    echo 'p:myprobe kernel_clone args' >> /sys/kernel/debug/tracing/kpro=
be_events
> >
> > This command creates a new tracepoint under debugfs:
> >
> >   $ ls /sys/kernel/debug/tracing/events/kprobes/myprobe/
> >   enable  filter  format  hist  id  trigger
> >
> > Although this dynamic tracepoint appears as a tracepoint, it is interna=
lly
> > implemented as a kprobe. However, it must be attached as a tracepoint t=
o
> > function correctly in certain contexts.
>
> Nack.
> There are multiple mechanisms to create kprobe/tp via text interfaces.
> We're not going to mix them with the programmatic libbpf api.

It appears that bpftrace still lacks support for adding a kprobe/tp
and then attaching to it directly. Is that correct?
What do you think about introducing this mechanism into bpftrace? With
such a feature, we could easily attach to inlined kernel functions
using bpftrace.

--
Regards
Yafang

