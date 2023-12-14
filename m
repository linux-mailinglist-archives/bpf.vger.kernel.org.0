Return-Path: <bpf+bounces-17872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA0A813AE0
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 20:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F2F1F21C90
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 19:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9CB6979D;
	Thu, 14 Dec 2023 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzIG42OR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0A469794
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so331533066b.1
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 11:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702582717; x=1703187517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9aoIM4rZmFhJIcOEfHaSYzgndrFayBeA4fC8/DGo5g=;
        b=jzIG42ORXKZP5y1NKFPhwPmXpIQBDC53168zr6T6kTTjm5pYFLLJBYJtPbjRHsEHhb
         2bJXav9XK05Pliy6p26dxNrC95wCb7D8OmpHxs3oMk8JutDItMXIorkgbMd+Y+lX3rGf
         W/GWkTuTHC99NSvxooEbRDiFNbs5bc9PeluN6HW4OXEFXfmEunKkGlCHPdMxZOLWoQRb
         +GRQEqsShrIAhGPq7MCy+Ly9qVyxSyTc7fksGDUdEqPI1CWHLZe7N51hIXEwdIVFHC+g
         q6YiuIkh3tk+afxvaaNyLhDZireH2KzgCGz4Copxf5xcb9npk0DErnwZO2mMkTgLcVIW
         3yKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702582717; x=1703187517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9aoIM4rZmFhJIcOEfHaSYzgndrFayBeA4fC8/DGo5g=;
        b=lmzYqZEfAc4xlBs+AmOxfOte8aZgMWJ8hHe8RxmjvXBHdtpvJsuwKbmghjklPdqiBP
         nLxwXFer+cNUcD/16heWsb/YDLy3VPEsDizryI+a3XZU5bKNPTk/Xr/K7xqJRoaWbeWp
         ZlmWffFUYFHaJH7xL9WJ8xtmbkD3L63YrdSKHQ2OAdn0c3Hf0Hev01Mp6147YTBDbtLB
         ZP2d0suOrQdZVXMWuLDHywGnmFUfLgsj6dMJhajOEQDmJaFgMX/rhoaJscmlEYdKiImZ
         fw7MhLwR0UzCFuMfWyWpheLDdFOSOiHDbpun7oybNASBaxVGCj/uIDO3OzemswBvahB1
         f5YQ==
X-Gm-Message-State: AOJu0Yx9p+HjZgSUKJDryfEKz4lNPVEnsYKJ0d9YxIBfbxIUrCItdzhJ
	fxUyVGc9iM1Gc/SVD25R7HqUZCCC6QaRqH0Goz1t+VfM
X-Google-Smtp-Source: AGHT+IHh9FXfQNETe2S0sTHEYkI3C4GAdV0LdbthKs1qiV3nhQvrZ8BB6xggy9OCtY6TTQMRavmjASlNVPtjJn7RjBQ=
X-Received: by 2002:a17:907:76d6:b0:a19:d40a:d20c with SMTP id
 kf22-20020a17090776d600b00a19d40ad20cmr2723671ejc.216.1702582716951; Thu, 14
 Dec 2023 11:38:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213222327.934981-1-andrii@kernel.org> <20231213222327.934981-2-andrii@kernel.org>
 <moeyk2noput6zen2dan3s7xsudvxtjc6kf7anieyugwbj6z3uf@kcxw4a3ffvnj>
In-Reply-To: <moeyk2noput6zen2dan3s7xsudvxtjc6kf7anieyugwbj6z3uf@kcxw4a3ffvnj>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Dec 2023 11:38:24 -0800
Message-ID: <CAEf4BzYbLTWBDf-2=AzmHUUdu6Z_QTJd6Xe6HHN=DGgj1bZbrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: support symbolic BPF FS delegation
 mount options
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 7:58=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 13, 2023 at 02:23:26PM -0800, Andrii Nakryiko wrote:
> > Besides already supported special "any" value and hex bit mask, support
> > string-based parsing of delegation masks based on exact enumerator
> > names. Utilize BTF information of `enum bpf_cmd`, `enum bpf_map_type`,
> > `enum bpf_prog_type`, and `enum bpf_attach_type` types to find supporte=
d
> > symbolic names (ignoring __MAX_xxx guard values). So "BPF_PROG_LOAD" an=
d
> > "BPF_MAP_CREATE" are valid values to specify for delegate_cmds options,
> > "BPF_MAP_TYPE_ARRAY" is among supported for map types, etc.
> >
> > Besides supporting string values, we also support multiple values
> > specified at the same time, using colon (':') separator.
> >
> > There are corresponding changes on bpf_show_options side to use known
> > values to print them in human-readable format, falling back to hex mask
> > printing, if there are any unrecognized bits. This shouldn't be
> > necessary when enum BTF information is present, but in general we shoul=
d
> > always be able to fall back to this even if kernel was built without BT=
F.
> >
> > Example below shows various ways to specify delegate_cmds options
> > through mount command and how mount options are printed back:
> >
> >   $ sudo mkdir -p /sys/fs/bpf/token
> >   $ sudo mount -t bpf bpffs /sys/fs/bpf/token \
> >                -o delegate_cmds=3DBPF_PROG_LOAD \
> >                -o delegate_cmds=3DBPF_MAP_CREATE \
> >                -o delegate_cmds=3DBPF_TOKEN_CREATE:BPF_BTF_LOAD:BPF_LIN=
K_CREATE
> >   $ mount | grep token
> >   bpffs on /sys/fs/bpf/token type bpf (rw,relatime,delegate_cmds=3DBPF_=
MAP_CREATE:BPF_PROG_LOAD:BPF_BTF_LOAD:BPF_LINK_CREATE:BPF_TOKEN_CREATE)
>
> imo this is too verbose.
> For cmds it doesn't look as bad. "BPF_" prefix is repetitive, but not ove=
rly so.
> But for maps and progs it will be bad.
> It will look like:
> delegate_progs=3DBPF_PROG_TYPE_SOCKET_FILTER:BPF_PROG_TYPE_SOCKET_XDP:BPF=
_PROG_TYPE_SCHED_CLS
> which is not readable.
> delegate_progs=3DSOCKET_FILTER:XDP:SCHED_CLS
> is much better.
>
> And I would go further (like libbpf does) and lower case them for output
> while allow both upper and lower for input:
> delegate_progs=3Dsocket_filter:xdp:sched_cls.

Ok, I was wondering if someone would complain about this :) Makes
sense, I'll do it more flexibly and succinctly.

>
> Because of stripping the prefix for maps and progs I would strip the pref=
ix for cmds too
> for consistency.
>
> pw-bot: cr
>

