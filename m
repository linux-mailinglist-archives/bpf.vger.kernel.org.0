Return-Path: <bpf+bounces-36914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1320094F5E6
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C0B1C21CE2
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 17:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE591891A3;
	Mon, 12 Aug 2024 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF6zNK5m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC1613A3F2
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484226; cv=none; b=LfhzcSdTjNvnrxF3VCiq0ifjfQSPqUDG+kUQQ97InDNEHDDSBk5iSWAUAy6HiwdTShT6bnD6+LrEn6g+ak0MKr5takm4R2h24yJET1m5Rb4wmYZApxnPa7+JpU6zww2AWQ1/jWvX9sioRKgEfq7z32AVoMi+fj2fE0TwuWJqto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484226; c=relaxed/simple;
	bh=C1rSz0peM8LHyjxgu6HYpMsPD58shgcmiJMruE1bmCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0HgYidUSDg0zFZB+JnUhUcZc16nIh19SMBfCsW44uP8GosBomlEiG8veDnVJ+ozOIvvOEK0gWTJzQwpxQrkC4ce2UtT+Ti5VEgz+qJgCdAbvVbIBy2rvWO8qEsYfbJrGmoRWEzMSuxxl5jVXN45maxviYAy0+AQx8P7gFKAlBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dF6zNK5m; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-36bcc168cdaso3218067f8f.0
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723484223; x=1724089023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ake8dWCKaR1kP+8mmsn9aoSiCgb1v8+462Y29FCeXM=;
        b=dF6zNK5mGUQF6y9a5KDhYCaAZfYZG2fOD/Fpt8nsgLQ0fJQ2QBo97IvUiAZczkW+6P
         UmIFiKpkyb9S9w3p78wkC2VM4HHfz9sXA6WAw+1avcyBLPaWoOZvKeCleQC23Ic5RK5B
         u3GMAv3ubU8Iy+Uu4+HH/tcBYfwYkKzNBLjYr4/Gb7AVi3El6bsVExqtqGfSqjQmmN/j
         kVv9pWJww4gCSeT1vw7fx49xx4Iq/SUtYb1ZCClAWK/mhPFuA8k/rk0fWWwfQOvMEq+y
         wYTgAbZ8Zd9nhMnWFs2igmPJ+IvKPIENn03WtMwAJsugJRnHlSwbfzAtxqQiiokPgDGR
         DxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723484223; x=1724089023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ake8dWCKaR1kP+8mmsn9aoSiCgb1v8+462Y29FCeXM=;
        b=A3/YFm8czev6CNbzjhOc23lied/VgzGMP5yMhDhBYkM2+dNR7879mdx6yhCk06+MWq
         UhfXBVbagMnizhtuVArSTTchQwulCZB0/k0wXP35tAPk6oAayX98eNkeI1htk2Pugz+0
         1cJLXNppR2XsIsxaZmC5L+0dJhT1fBv/UyifxqtXSemhONCcUqoRy5crZ7ERXtRuzmAp
         fkH4s0W7on2SXeCsklh26zRba0tBbSE7gAGh0884n1Hu905iSz/yes0GpTSAEOoTjj9V
         S3eMsgRkzBbV5xEzfIxEsKmojIVIXDXMkPTY05U18ToCuC5y+ROLD856cyGtLorLv6Nk
         iCZA==
X-Forwarded-Encrypted: i=1; AJvYcCUaizul1zCaM7wV2jSG20YsD1BXKSI+fSglxGA72QaAnt/9aweWzJ7EvfnDo/Zqv9mU2I5po9VjZgV992iQTUc33Uc8
X-Gm-Message-State: AOJu0YwXbMdZaQu6cztlX39UK4gE/mxopBQIGIbQDaCXNfrnG27XltKd
	mnfS+bN/do/HrsfGw7lQ56cQfsu4CK3GW3CGXGgG/9R895JZrKQj9j4Ref1dHLuMoivcZOkdb4U
	AYloEmFIAGuor0mY2NebYu91djUI=
X-Google-Smtp-Source: AGHT+IFRgvO/SKDokkUmGCenkURIlzKeDsDTW9PCqOzNbyoH5+M+ac0HiyMNxYGGF09bIUNCfFHEIN4usDHEysXCOHA=
X-Received: by 2002:a5d:5243:0:b0:368:420c:74ab with SMTP id
 ffacd0b85a97d-3716ccfa0d5mr1039407f8f.28.1723484223343; Mon, 12 Aug 2024
 10:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807235755.1435806-1-thinker.li@gmail.com>
 <20240807235755.1435806-4-thinker.li@gmail.com> <CAADnVQLs8nZGmyJSdgb11NSsSe_ZH1Qbcu7dcb=60-+0p+k9fw@mail.gmail.com>
 <62ade560-dd46-4480-8595-250b0264d3a4@gmail.com>
In-Reply-To: <62ade560-dd46-4480-8595-250b0264d3a4@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Aug 2024 10:36:52 -0700
Message-ID: <CAADnVQK_DgzMEMFx67ihKxAyU+W0khmQA9wVsio1__XxnrDUgA@mail.gmail.com>
Subject: Re: [RFC bpf-next 3/5] bpf: pin, translate, and unpin __kptr_user
 from syscalls.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kui-Feng Lee <kuifeng@meta.com>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 10:24=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.com>=
 wrote:
>
>
> >> +static int bpf_map_update_value(struct bpf_map *map, struct file *map=
_file,
> >> +                               void *key, void *value, __u64 flags)
> >> +{
> >> +       int err;
> >> +
> >> +       if (flags & BPF_FROM_USER) {
> >
> > there shouldn't be a need for this extra flag.
> > map->record has the info whether uptr is present or not.
>
> The BPF_FROM_USER flag is used to support updating map values from BPF
> programs as well. Although BPF programs can udpate map values, I
> don't want the values of uptrs to be changed by the BPF programs.
>
> Should we just forbid the BPF programs to udpate the map values having
> uptrs in them?

hmm. map_update_elem() is disallowed from bpf prog.

        case BPF_MAP_TYPE_TASK_STORAGE:
                if (func_id !=3D BPF_FUNC_task_storage_get &&
                    func_id !=3D BPF_FUNC_task_storage_delete &&
                    func_id !=3D BPF_FUNC_kptr_xchg)
                        goto error;

