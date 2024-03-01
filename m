Return-Path: <bpf+bounces-23105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E4D86D8B8
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 02:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D65528441C
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 01:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB442BAF0;
	Fri,  1 Mar 2024 01:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB349Txf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87438485
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 01:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256520; cv=none; b=kxjVtjYXllYVtXu8UvqZsoVgACHEEzqozEVZ+PUy5x4wIfR+baai+NVvOb44VqVIZrK105vKlD3Ndts1rpZkYwvyIxFm3nEY3okXUliA5et+xT//a7Q4iSdsSSOgUJqDwP9Vy9t9kcKlz/ysHfKO7Qf/cndITw0jPQj1KCHLsc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256520; c=relaxed/simple;
	bh=pzWs8gpbCHAY6mAwYXEVQmXaaS1/1tTfBjJV1btomj8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hjyZz5H1ujGsYZvZBS9UelNvepFPihP1yWJiX2u/LiZXNLSerz3zDeZlMkBQrEQoZiYqlgkl57X8IAaiPrIh2Gq70+rWGonon6Au9ILfHCe0zJgNl3XuNdbabFXwWQ9pAlybYABAGZpzCD7NAnGujRLcARA8yb4Wyk7J/qJ4Qus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dB349Txf; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d28464c554so18250001fa.3
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 17:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709256517; x=1709861317; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=anOZa8dpE76Pwh5YV4DqVNgze9YMQ73JMVYsA3Y5lug=;
        b=dB349TxfE6XSq0eEt0Ee2YewgdAaBODDeLH3lWCHptlPdVvEYYOpseIeX77TDOE/47
         ni5pPK2VhptU1HoaxZBn2wosJ/HVf4R7RS+hyoEd+z2/aaxWBVk0ObISDjzR8cV9tYNt
         i1vxiaMqKrCLXzckh4i8HJglJBEr9poXkoPkeg/VPNhX7r75AWA6MWnCccbyaM54bLxJ
         m6Yz9xy1dhW9SqhQaC9yqeOd521yBUDLztZqnXqaCRA6LepGJiupFC0GSYuAblh3AzcN
         9FHZPDMbqLn/BUtthnPyYMv8DD71ERB6kf/8oJCCXL90XJD6SUgG4KPQD6gR8Qdj31oy
         9qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709256517; x=1709861317;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anOZa8dpE76Pwh5YV4DqVNgze9YMQ73JMVYsA3Y5lug=;
        b=DPRxet2d83fd6HaGwpRivX4P83Sw+tRWjV67kDAl15Ru1vB95ZiDb/dpghFtNJES4Q
         KweKAs5ew82Y+0aGhZny6oU3CWMCAus7tq9ogOfVFBUrJ4N5orvodhZo7N6EZA80SCyq
         KUGSJQdBSlzG7FUAnRuut3DnFjxOAlGDWVu4vjsZLPtWOlEJY3birYLqoTZFGBSqxu3p
         wuq6pRDuBSt/RJrtV2J6Kq3Zw8vh9O0t9U1m6uXMFuXsjNYbPYGO21bwoNQst/asgBoC
         NUngXbAE3CfXwhu65uyzIkIf01BPGz/RtiAz7CRUruB8ZzHBB9tXxJqYVZ2q890+6iXn
         +stg==
X-Gm-Message-State: AOJu0Yx9ls4AhCvzIfsSKR3bPF9PEq5ae5Y/jtWVYQ6LtLmPl/+fzOoE
	xNlYYv4z9cgYQQRgCWsilSXnRrdVDyS4kuWiGrDTgPUkvFshyX26
X-Google-Smtp-Source: AGHT+IGAsUTyj5IJ0G3lgMTTpGhQIXDI3B9thG3i4xOdbKbjp9a47PH0hLZSv36IyWNqZNdlPlAtrQ==
X-Received: by 2002:a2e:918a:0:b0:2d2:e28e:bde3 with SMTP id f10-20020a2e918a000000b002d2e28ebde3mr68361ljg.48.1709256516625;
        Thu, 29 Feb 2024 17:28:36 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s20-20020a2e9c14000000b002d29a078125sm394037lji.124.2024.02.29.17.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 17:28:35 -0800 (PST)
Message-ID: <316cd654a3c3294a2bb2b9ca2e5bc9767bef294b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 6/8] selftests/bpf: test autocreate behavior
 for struct_ops maps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  void@manifault.com
Date: Fri, 01 Mar 2024 03:28:34 +0200
In-Reply-To: <CAEf4BzYRS-wd_FTi-_=1t9mjgMp3P6yrTqbkQ+359aKmcjZDNQ@mail.gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-7-eddyz87@gmail.com>
	 <CAEf4BzbXzsDUx-dvUQQEMcCVUeUjnBnbF6V4fmc36C0YzVF73A@mail.gmail.com>
	 <d5fda01ecfac47e096e741a68ac8a1d2d726fc16.camel@gmail.com>
	 <CAEf4BzYRS-wd_FTi-_=1t9mjgMp3P6yrTqbkQ+359aKmcjZDNQ@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 16:02 -0800, Andrii Nakryiko wrote:
> On Wed, Feb 28, 2024 at 3:55=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
[...]
> > On Wed, 2024-02-28 at 15:43 -0800, Andrii Nakryiko wrote:
> > > > +SEC(".struct_ops.link")
> > >=20
> > > can you please also have a test where we use SEC("?.struct_ops.link")
> > > which set autoload to false by default?
> >=20
> > As far as I understand, that would be a new behavior, currently '?'
> > works only for programs. I'll add a separate patch to support this.
> >=20
>=20
> Yep, thanks!

So, I have a draft for v2 with support for this feature in [0].
But there is a gotcha:

    libbpf: BTF loading error: -22
    libbpf: -- BEGIN BTF LOAD LOG ---
    ...
    [23] DATASEC ?.struct_ops size=3D8 vlen=3D1 Invalid name
   =20
    -- END BTF LOAD LOG --
    libbpf: Error loading .BTF into kernel: -22. BTF is mandatory, can't pr=
oceed.

Kernel rejects DATASEC name with '?'.
The options are:
1. Tweak kernel to allow '?' as a first char in DATASEC names;
2. Use some different name, e.g. ".struct_ops.opt";
3. Do some kind of BTF rewrite in libbpf to merge
   "?.struct_ops" and ".struct_ops" DATASECs as a single DATASEC.
 =20
(1) is simple, but downside is requirement for kernel upgrade;
(2) is simple, but goes against current convention for program section name=
s;
(3) idk, will check if that is feasible tomorrow.

[0] https://github.com/eddyz87/bpf/tree/structops-multi-version




