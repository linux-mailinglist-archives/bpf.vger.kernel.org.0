Return-Path: <bpf+bounces-51544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C8FA359F6
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 10:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3474F1880328
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 09:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4776822D4E7;
	Fri, 14 Feb 2025 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U30m736F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F0A228C86;
	Fri, 14 Feb 2025 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524468; cv=none; b=BtRzamg+DZkiYjYremXyq/4hv2C54tTdze8Q9baLfMbqZ5r1W6q9PpTDF9KK14UoMwp+zwV86vDiPHJ72EKV6hURqjvcvzTpi6sj1I8XJXKL5tg7FHm6cHyIo0NUPqXKobD1Neej/kFZ0PfesZgYkxmIVyOi2sdfcZxvHjml0xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524468; c=relaxed/simple;
	bh=ePowDJlvLeT4lEJdpsBFzzU2Vfkn5XlCSc5paUDPKy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5D/8OUCFybBMDqZkgsKr48SD8z1VkKNPrqIDWf35GrAoHA5wh0YlG8JO4ebmNxwswp1nkO5nWZZ8D7MTNQOyeIDciZmeLY+V8S7mIiVTu+ars0WBBGwd4bFTfk1eH43hN2zS6Gyu+jGtBH8N7f7/VpLXqTkO2kJ7+zPKGwCh7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U30m736F; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ab7e9254bb6so277672966b.1;
        Fri, 14 Feb 2025 01:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739524465; x=1740129265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePowDJlvLeT4lEJdpsBFzzU2Vfkn5XlCSc5paUDPKy0=;
        b=U30m736FmgEiAghDueP3vQjjcVJ3MGn1I0e5NUwC67O1nrYQUziQBHQKyhnoP7YU1C
         03fp5HeWz0fj5X7iy4KZT+tmF/vPogjy3JlAcKgR13uDyGyuNgu5DN856Mp99y2OZndf
         N33tO1Y/SaNRBXvn4W8O+BY68zqMCrKD+QvuXsq9HBqFRBBVl0Ggowj2rqVxW4J4mHZF
         Aw6dfemQ+M/lxKO56kpwCuWLBLwn1esiCJMET/XMora1pv9YMPqdDKH8w+WUcwnKBe19
         bE+RUVaZOz88VB0wQBAf/9WchH1WhAMVEWISiodXX2I7czvFzT5Mm+SMYR0Ostxc6002
         iGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524465; x=1740129265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePowDJlvLeT4lEJdpsBFzzU2Vfkn5XlCSc5paUDPKy0=;
        b=elZ1tJOLKgAQbAEi9xndNN0Z6CBHTC04ErqwLt+4zAqFsmn22jtPJJfKkmwf5LPx9E
         JWnQW9ZNdXSH5ZTaTFK+j9ifxg0veRUTekp27m1gVbUGzGgB8UAZrgKC8DkdeJTTtVY/
         xE330Xk9wqzPpj4zHUWuGfw5XNcgK4wDqlZsSTvRUymPZqPeJbJFqEfH7fqXoMGsKgnh
         FQE3G433omJIFEUP3vCl8UKPnlUSIZ7NIpMzDoU491Kr38ioEH9BQdH9lj04umcgrfyb
         M8YpMf3FBTemEk+DmeL/N0BM7w+XpPfWLaYee/uyKFfpNQtwQDBk/D6BrogmQsyOVwKq
         PjmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEkhKAsEH7csiCNImRvsr6pkTlyhvq7bjUQHWLNntSaK6un2JdtyXSDuheUsEDlXxy8qg=@vger.kernel.org, AJvYcCXPX3DAs0QrMLxGu9YgPrmFEQ0lSf5beEBLjMLyzeIew83TqYduvvUibjtOe1b0PRVjGRcNN//nCPsZupDg59nw+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyODLHzDMv3SM9nj7gYUXeigSLKcwh/XbF8dBBKxa/+fsDDV8LS
	fm7gQ9H6G96uNvMl98Kpv3g/t7zXMadLPPbK/3vo4HXvl8Y+QgxzyVEdOx/AiAxJqzz1crCpAl6
	oADhwfcpbxvjnNzh0cKwyfsz12IY=
X-Gm-Gg: ASbGncupVuw3oNiC+BO9+OShI1Q+WNQBKzLWcfJV34As1TvspJaTrrP4JOvdzednOFs
	qhvdxB+b/P/VpuF2aKnbkpYCH6ONko8/HI5T9SbvMOp8Lc2/Ba5RYOnGrxcXxhTAHqcEgBRV3kQ
	==
X-Google-Smtp-Source: AGHT+IF9bs69MkfVdRsypWTr81KsiRClCr71Zt6Fua2ZmiXd96hiPhPmMxXIaeEMHZoFAGaY0pFLKbH5Jz+U5E+2dqY=
X-Received: by 2002:a17:907:d26:b0:ab7:da56:af95 with SMTP id
 a640c23a62f3a-ab7f336e7b4mr949311166b.2.1739524465219; Fri, 14 Feb 2025
 01:14:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210175913.2893549-1-jolsa@kernel.org> <CAADnVQJD1UeMZrRrrQEZ-_twryA61Au5oxacvamL+HwT+v9=oQ@mail.gmail.com>
 <Z68IMCpSrfDuO7iX@krava>
In-Reply-To: <Z68IMCpSrfDuO7iX@krava>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 14 Feb 2025 10:13:48 +0100
X-Gm-Features: AWEUYZlGHkW_VQOual8Mg_S73BOVRsHZfsv6ddjf_KzikMO-aCkqLBaK-c59TOw
Message-ID: <CAP01T76sd0CE_69oiHdfKbOt2zvwBN9acDu+VjZQfpGxYxyb5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add tracepoints with null-able arguments
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Feb 2025 at 10:09, Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Feb 13, 2025 at 05:04:09PM -0800, Alexei Starovoitov wrote:
> > On Mon, Feb 10, 2025 at 9:59=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Some of the tracepoints slipped when we did the first scan, adding th=
em now.
> > >
> > > Fixes: 838a10bd2ebf ("bpf: Augment raw_tp arguments with PTR_MAYBE_NU=
LL")
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >
> > Applied, but at this point we better switch to Ed's llvm-based tool
> > to generate this automatically.
>
> nice, I'm not aware of this tool, where can I find it?

A prototype is available at this link:
https://github.com/eddyz87/llvm-project/tree/nullness-for-tracepoint-params

>
> thanks,
> jirka

