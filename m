Return-Path: <bpf+bounces-17892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4202E813DFE
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B78283B9A
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 23:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E607D6DD06;
	Thu, 14 Dec 2023 23:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsDUiVX7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5FC6DD12
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a22fb5f71d9so9501166b.0
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 15:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702595223; x=1703200023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHV4VlyPZxPUGjIupqzGuMiIqAkqes/m8oWnmE9Z6fM=;
        b=GsDUiVX7+GGbWEH0wewZSVJDaje6ISEUxrG5klYD5JTP29TLI/nIZdK/U3/K22klPm
         jWNDts6iJOXvk7MEgUr8cfvWhWH+/KI3KXuLiuOJjMjviuVmTQTjjR16tHcJmqtQPy28
         P3wOohhy8wr03ee9snfsf3L9A6BxX6G1/Hp2Fg+WWp97qqvdDmqcoiHN24A5bwNj4TB7
         G7O7vxxkvBRXZ3MqZfYbjdBIH/YMeLwEITuQix20mT9vZRyo9ct9uyVpGSx8nlT31FLG
         f/9ww0nZpcgra3z5NIvheyeNqMgp+zJhTrTmCXZaTH6iwd3uEUw3onmYAwxhodIb1Pf/
         hs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702595223; x=1703200023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHV4VlyPZxPUGjIupqzGuMiIqAkqes/m8oWnmE9Z6fM=;
        b=aFf6Nooi5/7/2rtkCguUuKsnhMIKsGRf3wuqoba9OL5HeD1D4q8ufH1K2D3mIn27bH
         ejlwD2pZWMdKgcHDL0zRW9YjNrIIydzg+KetfDzCEmzoic2jlXrmW/f5Hzy7BTXIRwbS
         T4iAndgHwLJ6GASrwTQuGjAc34AGDRHdqbPjzwDSVODF5sgjK29a3nsZzaclBnhYyOpM
         nRWuKfcgjRaJbOu6EXNV3vW0Xoj1WKp0b1dmZ4Kf6PD5MIQTLT9fcM0Tw1HmlZg61nku
         66YJuadSUXYiGH/iriWd8J9ox6W/8VJF89zkJ8DMJv7sSQ2cnkwNpk89SG3Rz66ieqVi
         fkUQ==
X-Gm-Message-State: AOJu0YxQJvSHCBIzWOLXMcK9yp8ziJAuAgPuKzw8tuKyok7yHLnN3ktp
	+h88InASz/BAXjqfbVLWICmqmbNKou10SK4K0eql3q/V
X-Google-Smtp-Source: AGHT+IE53vKvxwmOoMkW6QFnVitxcGDKT4BSmnZv5Kp2v5DEdCOGfUaae4cnhhqVDfhRJRmbHtEBk2Uj+N4JAQ81Xws=
X-Received: by 2002:a50:8e06:0:b0:54c:48aa:cd18 with SMTP id
 6-20020a508e06000000b0054c48aacd18mr9106530edw.40.1702594749879; Thu, 14 Dec
 2023 14:59:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214225016.1209867-1-andrii@kernel.org> <CAEf4BzZVS-U28tswb8P5scO8aXKCd4cteS=-r4xHvyXb2XVz7A@mail.gmail.com>
In-Reply-To: <CAEf4BzZVS-U28tswb8P5scO8aXKCd4cteS=-r4xHvyXb2XVz7A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Dec 2023 14:58:57 -0800
Message-ID: <CAEf4BzbXBH5nTrDPNaPecG5WmeRHANCxFhBD7zLU_bbV-=96Lg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/2] BPF FS mount options parsing follow ups
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 2:56=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 14, 2023 at 2:50=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > Original BPF token patch set ([0]) added delegate_xxx mount options whi=
ch
> > supported only special "any" value and hexadecimal bitmask. This patch =
set
> > attempts to make specifying and inspecting these mount options more
> > human-friendly by supporting string constants matching corresponding bp=
f_cmd,
> > bpf_map_type, bpf_prog_type, and bpf_attach_type enumerators.
> >
> > This implementation relies on BTF information to find all supported sym=
bolic
> > names. If kernel wasn't built with BTF, BPF FS will still support "any"=
 and
> > hex-based mask.
> >
> >   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D805=
707&state=3D*
> >
> > v1->v2:
> >   - strip BPF_, BPF_MAP_TYPE_, and BPF_PROG_TYPE_ prefixes,
> >     do case-insensitive comparison, normalize to lower case (Alexei).
> >
>
> Argh, patches are actually from v1, sorry, rebase troubles. Will send
> v3 with the proper version of the code.

Nope, sorry, never mind, it's all good and the correct version of the
code. Gmail confused me. Sorry for the noise.


>
>
> > Andrii Nakryiko (2):
> >   bpf: support symbolic BPF FS delegation mount options
> >   selftests/bpf: utilize string values for delegate_xxx mount options
> >
> >  kernel/bpf/inode.c                            | 249 +++++++++++++++---
> >  .../testing/selftests/bpf/prog_tests/token.c  |  52 ++--
> >  2 files changed, 243 insertions(+), 58 deletions(-)
> >
> > --
> > 2.34.1
> >

