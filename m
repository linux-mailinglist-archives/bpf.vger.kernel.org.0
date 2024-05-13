Return-Path: <bpf+bounces-29677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285378C4A20
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 01:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE021F21B7F
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 23:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D93785643;
	Mon, 13 May 2024 23:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYnEQU5a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C8185622
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715643273; cv=none; b=h8qejZ5vWuA1q0UNo0EknLgTsr44vrPels5r818e9RQf+TYDtOJj+XnB8FDclNG8GJMRXH7/x5uvFiGrBo7EaZd/0QLbOoG+M/d4JDCexfIFkqQcEI4+ztRnKIgGyDvh/BJRJh1FM1+oQCxZIto4svI49DMC1NUWKAJExN56NhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715643273; c=relaxed/simple;
	bh=rEKS8y317Ob58Gt6lNQbqE/EiHxDXN8JvLtxSGPEu+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P13W6EEh6yMQI1XjCxERZmINaiFxW4CsVPPdjnfRRx/4swdJBQbiy8k8dRkPSVK2dkrx7b4jI+mmUiTh28U5gXn+iWVuIv+3bLB/qgJjPyAtIrvXz7JNySi8msyxBPPpt90+6HI9K1CTDxTmqLTo7pXvjC60cyDIjx+vLz5FQQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYnEQU5a; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34d7b0dac54so2787451f8f.0
        for <bpf@vger.kernel.org>; Mon, 13 May 2024 16:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715643270; x=1716248070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvaTJdgSSLgUumG56EUMTVi7s1eMZQ7XWsHbiKviXqk=;
        b=QYnEQU5avPLBaGV8P//UW3brTJvsls5oyO15RbiflsszEtkfbRpKju11eAFS2jL65Y
         HfS3FhpFp0Z2jgG48+KjZR8zxKOQ/+K9FHeG7S47Grh5b8+YdJa3T4dgP6okTSBNS9YR
         idxKQMA4hoVQlmPs2/3koz88bxEGZqK9HclqwzKX8IlNeZvnzGiq+XZA0ULxXeOLmcjV
         e6L2TRBFEXlJzZnNzuIePF/R/4tEqwrhf8W9erfFlY8MMg7MMLth/cT26nkM62s9V+ia
         kal+K8S9NO3p1h/tgxKp4brZo5wQ9CvAGp35+KvklRIqA/QER72ZdpQQotETIwhc8IQQ
         QK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715643270; x=1716248070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvaTJdgSSLgUumG56EUMTVi7s1eMZQ7XWsHbiKviXqk=;
        b=EXT9zFiOaqFr7L3FWSWuDxaUtgwwhtXcFTanlUEeoWpCxHK1ZY8O7Bu9n4Fx1caJBN
         sAlOIx5+jsN0kmDpFa3R4OGzSUCYZHc8dqucYDRjaWrvk8uYWYACxk3uRo4RejwUP6ol
         i4St291UIQrLb2K+6exJqvpeIZoRFVG4OeUsMQBTVCzAF8ay9gYCFHCrCLIz/E0svm38
         KQDlKYRABb3ab3DPLm0vrSMy+UwWD+Jtj9dED1u7ddCJSA0u6B4PDzMD0EERCzeC2b/R
         3ADi38m5yefkLQ2YiBpQyZmCxaf3liFbsTxR8mBFyalTcrTx9NjQBZK0o/Ev1WMkO3nd
         KIHg==
X-Forwarded-Encrypted: i=1; AJvYcCU51WEzVnBJfQuWfi/cUnMLzNl3yO5hnYwYtmNYrA//uO7Rjau4oqL0rw9WcF/WdlsErq0D39na0LnNH11WK8znv4C8
X-Gm-Message-State: AOJu0YxPKf/fHI/wqg+7nuVpagcAC9lF0FUdoasubzZ+1SsKLjV+mLPC
	UZFX2i+ImxfZvO1lFx4EnYHIXXlTVINZf1SjtZw9P1iUloC5rr+nTi6N/tQ07zJn8AoKsiRTbvr
	QRJCrTcuMfEXHjMCQm2D+325CRG0=
X-Google-Smtp-Source: AGHT+IGgMdaaZzFoXOPhwbL3kDFmSuS6nyY9i7P5snBTk9PeU+Q4Qgj5DxDCEEc0vVHEZqaDLzkXKDNj/RRGQRc0w8A=
X-Received: by 2002:adf:cf0d:0:b0:346:47a6:e77e with SMTP id
 ffacd0b85a97d-350185d763fmr13415371f8f.27.1715643270277; Mon, 13 May 2024
 16:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513192927.99189-1-yatsenko@meta.com> <CAEf4BzY6ugkAMt23xVFM36XjD8c8Jh9vXBDPiWrR7NB42yvXKw@mail.gmail.com>
In-Reply-To: <CAEf4BzY6ugkAMt23xVFM36XjD8c8Jh9vXBDPiWrR7NB42yvXKw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 May 2024 16:34:19 -0700
Message-ID: <CAADnVQKRkap+uusEqM937bHWtojkth+aSdS8fFn7VRJrzPVOqw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] bpftool: introduce btf c dump sorting
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Quentin Monnet <qmo@kernel.org>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 4:08=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 13, 2024 at 1:29=E2=80=AFPM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > Sort bpftool c dump output; aiming to simplify vmlinux.h diffing and
> > forcing more natural type definitions ordering.
> >
> > Definitions are sorted first by their BTF kind ranks, then by their bas=
e
> > type name and by their own name.
> >
> > Type ranks
> >
> > Assign ranks to btf kinds (defined in function btf_type_rank) to set
> > next order:
> > 1. Anonymous enums/enums64
> > 2. Named enums/enums64
> > 3. Trivial types typedefs (ints, then floats)
> > 4. Structs/Unions
> > 5. Function prototypes
> > 6. Forward declarations
> >
> > Type rank is set to maximum for unnamed reference types, structs and
> > unions to avoid emitting those types early. They will be emitted as
> > part of the type chain starting with named type.
> >
> > Lexicographical ordering
> >
> > Each type is assigned a sort_name and own_name.
> > sort_name is the resolved name of the final base type for reference
> > types (typedef, pointer, array etc). Sorting by sort_name allows to
> > group typedefs of the same base type. sort_name for non-reference type
> > is the same as own_name. own_name is a direct name of particular type,
> > is used as final sorting step.
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
> >  .../bpf/bpftool/Documentation/bpftool-btf.rst |   5 +-
> >  tools/bpf/bpftool/bash-completion/bpftool     |   3 +
> >  tools/bpf/bpftool/btf.c                       | 138 +++++++++++++++++-
> >  3 files changed, 139 insertions(+), 7 deletions(-)
> >
>
> LGTM, tried it locally and it works well. In fact, see 6.8 kernel vs
> latest bpf-next/master (with basically the same config) comparison.
> It's quite minimal and easy to use to see what changes about some of
> the BPF internal types.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Tested-by: Andrii Nakryiko <andrii@kernel.org>
>
>   [0] https://gist.github.com/anakryiko/8fd8ebf2aba73961ebd3cf6587de6822

Just noticed:

+ ETHTOOL_A_TS_STAT_UNSPEC =3D 0,
+ ETHTOOL_A_TS_STAT_TX_PKTS =3D 1,
+ ETHTOOL_A_TS_STAT_TX_LOST =3D 2,
+ ETHTOOL_A_TS_STAT_TX_ERR =3D 3,
+ __ETHTOOL_A_TS_STAT_CNT =3D 4,
+ ETHTOOL_A_TS_STAT_MAX =3D 3,
};

I'm a bit surprised that enum values are not sorted.
I'm guessing the enum names come in dwarf order and copied
the same way in BTF ?
I guess it's not an issue.

