Return-Path: <bpf+bounces-29674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A3D8C49E6
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 01:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164681F21FDE
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 23:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9430385272;
	Mon, 13 May 2024 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsyNQcfR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1F584DE3
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641714; cv=none; b=MA+uKrhnVT+skQFUTMAae6camRoKXeuIIACO4/eP3CP2QXykenZzP/G0tjB/iiNH5Hk8ZfJuSpJG8ExXmPY1IDVCG4e9Rnc6kZ8Qtu1gh6ZOl+vxrsKJ1y5GJ82isWoq/GnCRT7Ax6eUdLUXsaEjRQQL9k2AR5Y6AwS5DoAjtAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641714; c=relaxed/simple;
	bh=tQVoEkh3Et22BKzJQ9SIkGLeLTeKHW0KCyca28WfJbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVz8JLjhiuuB1UTY8+Q86ch+dneEwtwaC/o0f6LWF2ify0nLxEVJ2e0XPgcwn4U+788lLtV55ZVgZO5BrTHMQ7HgWgitbNbwvm5f8SfZeftfayjeyyP6/clFMxtQWXmS83SThU6Tzasms3jntyvgZ8kas7LO1stscZum0Z+LYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsyNQcfR; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-613a6bb2947so3905282a12.3
        for <bpf@vger.kernel.org>; Mon, 13 May 2024 16:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715641712; x=1716246512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36KrlESq+ggs0EcihIGW/LRPRQtXzbGmNiahLatMMjE=;
        b=RsyNQcfR+yvtVw6TXZv09UOGUIh5ILT0mM6n8h/mAa9hc5CIuST6gFgvtpnF6Ak5ls
         gB9Mzs759iNQ3IYPXwqGsfbjL4FrahBg/SIU5ONSFZccJa61L9Uw5osNNmOPyTMW3zBQ
         MYJ3i+xLlkCfUNdjPHlFOJdxDf5GcYaeQS5szzPW5CyB8gTWftZDV/wLiVSM6Kjkegn3
         78K8Qx9WeAM1m0xdlDmHiHTicZudJAizoGma05dT9veX4FfgkvpIRipio+AyIlZD28mZ
         WXCNLPx/7uLkhft/oCkQR6Cu1CikBr/ohBfTM7HsLHLPykXux0Kl4RQhW9dFyZ0KzU1J
         zuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715641712; x=1716246512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36KrlESq+ggs0EcihIGW/LRPRQtXzbGmNiahLatMMjE=;
        b=Il8yxcLZ/dp9tbAS8IIKMzJn522JdXzeXb9Sy67yveFD8LJFkrf88kGIaSl+TPmDFp
         8UWUzeJzuqJx0/VBQ15MGG26KxIp+68Af1CpUkOKjn8S+GyEm9a7P/YQ5qDek7/7kP70
         4/j1qpN+waogeqgX9Sz5GShBvhSFlT7pj3uzrqRfP0ntrp9H5Q5tgFSAFBzvWBPu2At+
         mHpUceye+EoB6a3+wC3620/A6GFfmHzp0FWnuJkiEeZflyUWyrx93TqeRjLe9JFJ7bcC
         lYCZxHodp9RRyCShFAnWlhdESCjlLOdvPw2zZ/uC2HWaww07HsbzJhs2PI+ezqqCBpdb
         /o1Q==
X-Gm-Message-State: AOJu0YzV2e428+Yv2XmJ6DxP7XJaupTXXKLO0GkM79n9phh6Af7dgmxM
	CMUbKD8xooSye32MfK9AvyC965RTXYy6HCGKiosYfVud1gujl/AufPdZ3Tq2WvJ1+uC89x8ZvRp
	zepqtkO4iG3JTOieP/D9Ia+2+8QY=
X-Google-Smtp-Source: AGHT+IFyR9Xvust1NDNDZ6a2BcNEixovPIaY7GvSQ0z9/eQqmRCUN37THMoagskdtN95cZ1FArxKJfuUb2IROOQdHRk=
X-Received: by 2002:a05:6a21:c91:b0:1af:9728:de86 with SMTP id
 adf61e73a8af0-1afde10456emr10504527637.32.1715641711989; Mon, 13 May 2024
 16:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513192927.99189-1-yatsenko@meta.com>
In-Reply-To: <20240513192927.99189-1-yatsenko@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 13 May 2024 17:08:20 -0600
Message-ID: <CAEf4BzY6ugkAMt23xVFM36XjD8c8Jh9vXBDPiWrR7NB42yvXKw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] bpftool: introduce btf c dump sorting
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, qmo@kernel.org, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 1:29=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Sort bpftool c dump output; aiming to simplify vmlinux.h diffing and
> forcing more natural type definitions ordering.
>
> Definitions are sorted first by their BTF kind ranks, then by their base
> type name and by their own name.
>
> Type ranks
>
> Assign ranks to btf kinds (defined in function btf_type_rank) to set
> next order:
> 1. Anonymous enums/enums64
> 2. Named enums/enums64
> 3. Trivial types typedefs (ints, then floats)
> 4. Structs/Unions
> 5. Function prototypes
> 6. Forward declarations
>
> Type rank is set to maximum for unnamed reference types, structs and
> unions to avoid emitting those types early. They will be emitted as
> part of the type chain starting with named type.
>
> Lexicographical ordering
>
> Each type is assigned a sort_name and own_name.
> sort_name is the resolved name of the final base type for reference
> types (typedef, pointer, array etc). Sorting by sort_name allows to
> group typedefs of the same base type. sort_name for non-reference type
> is the same as own_name. own_name is a direct name of particular type,
> is used as final sorting step.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  .../bpf/bpftool/Documentation/bpftool-btf.rst |   5 +-
>  tools/bpf/bpftool/bash-completion/bpftool     |   3 +
>  tools/bpf/bpftool/btf.c                       | 138 +++++++++++++++++-
>  3 files changed, 139 insertions(+), 7 deletions(-)
>

LGTM, tried it locally and it works well. In fact, see 6.8 kernel vs
latest bpf-next/master (with basically the same config) comparison.
It's quite minimal and easy to use to see what changes about some of
the BPF internal types.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org>

  [0] https://gist.github.com/anakryiko/8fd8ebf2aba73961ebd3cf6587de6822

[...]

