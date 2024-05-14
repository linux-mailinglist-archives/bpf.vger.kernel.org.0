Return-Path: <bpf+bounces-29685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6578C4B91
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 05:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADF01C2102F
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 03:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2254C2E3;
	Tue, 14 May 2024 03:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZETA6Ar"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27142B653
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 03:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715658675; cv=none; b=sjef7atCrTkIysDfQmHmZugf2xdimX7rm2lVU8186/RAgJGNRDaTmVdHKpXbwB0nHIbCLnkAzZWeqNOUwweZK4ody+jbNcePwXvMNBJTQvRQGIL37FT6ACKtW0czJq7AfIvCi67OwGxMABGhliKAUeycfG7fBr3jPFQspInvvsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715658675; c=relaxed/simple;
	bh=tD6W9lfvr9vW0qaLabFCwi7jkutJqhsyqfmxxsP0a6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdWQuyLwhDjrPVR7jMVRbNoSJEhrmtFNrTARTgfPph4QDZAZOYqdSyZhJz+NSxt1SIY8XvGgU1PQis8uZc6PGES7fcyLPk195l9Enpp0K76V1F2xOzsmfCh0KBpww40IMLS3pMli3LFSCQjrbLL9BpoSz7MbtG1pDYdidc/AQpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZETA6Ar; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-64e93d9b14bso32882a12.1
        for <bpf@vger.kernel.org>; Mon, 13 May 2024 20:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715658673; x=1716263473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqcFXhoDvdBPYrb27LXNJvIfvwGX1Tt1anOFjJwQRwU=;
        b=aZETA6ArJQFLD5ycMIUvZhEUco4QiFAR/1cmZ30l0pDWtAq1l0h57NZwBYtCNkRFJa
         4Ftx+b7U4LB+mQA4zQh0LGaO/EwMREhbTmksC6oeA4THfImuBvuOErkM91sf5jdObg7A
         lQrUmnf5bW4+V+lMFi+iYFi9rm1AlYzvamC4F1tniyQAexyd0/qt3z2+U/NM65gvftap
         Px0m4ld305fegCgcISkaUg+AhuQ8QH9sgqVQ5GSuOC1DqrubgliNABa9lk6T9PPH2CZW
         CSpzj+QEe5FVZTiD0d5UNq/Rq7fkRhhyLZmzVhDqS7PsKoXV4uFpYjSVfXJG0n0+S/1f
         5wiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715658673; x=1716263473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqcFXhoDvdBPYrb27LXNJvIfvwGX1Tt1anOFjJwQRwU=;
        b=UiKiZf/OWPIakFT2I72/CXEblne1LBw+lkhLzKNPLZqs54ODIJ7pwemgVtwzlMUvnd
         HFjuwbopqTU7hOX2GCo2juxldnzOHBcrbzE17tcWU4y7gMMaPt2K1dnOEibSealSHqxx
         g4JLCD/LVisDxggjmq4fxcqXUOWNFsaMwkSkPWop/J0nEs7/X9KAsDZqbxqtZc6NuMAD
         WC+tMKkE0biuOub+HxeitSpGg2xNtDEaeb8PKpHNIb8U3ob7FHaPw04XJrYzoUb+fsW7
         L/4QsAFizWS3ZzkX3W4jc8+RyoSJmKp5Fg8pAmGr0R38NSE7kUBoA+8pZ+7ezL5B34uD
         C7mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm2gGB0AnZZ7Pq/NDrmFjhwQ4ozW7pwrB0TqieKafnlMVz9UIlqnI7wIzvFG/5vw6dTdWyNCGXLrb9Hv1yQ/psRRn0
X-Gm-Message-State: AOJu0YzvvIYwkyvWMD3Q+1Cq71w5Svru8y1LaFyARTd3Dl5Pzr3Xiqlb
	GPXzhlSaRGq2OntyDD6NWn19LftlrHowmC9/dDZwx9Lo5TdPzdIahRxnQCQpcxQxILOcFr3U4Kd
	7iOK8w61FeMEBkPj3LhmZvEcnf2s=
X-Google-Smtp-Source: AGHT+IEK4i/3PjV9ZY51+IN8g0iosrSj59dkXpqI7DKyFUe6JY6XjHN7ja0xnMXLQ+ll3JWoccu7cJZ7vqczZnxySGc=
X-Received: by 2002:a05:6a21:6d9e:b0:1af:952f:f6fb with SMTP id
 adf61e73a8af0-1afde0a8e00mr12926380637.3.1715658673330; Mon, 13 May 2024
 20:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513192927.99189-1-yatsenko@meta.com> <CAEf4BzY6ugkAMt23xVFM36XjD8c8Jh9vXBDPiWrR7NB42yvXKw@mail.gmail.com>
 <CAADnVQKRkap+uusEqM937bHWtojkth+aSdS8fFn7VRJrzPVOqw@mail.gmail.com>
In-Reply-To: <CAADnVQKRkap+uusEqM937bHWtojkth+aSdS8fFn7VRJrzPVOqw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 13 May 2024 21:51:01 -0600
Message-ID: <CAEf4BzYmRt0Bn9FVBZLOVzU5E5d30Dkba=MRSKWgDaRXp=vdKg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] bpftool: introduce btf c dump sorting
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Quentin Monnet <qmo@kernel.org>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 5:34=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 13, 2024 at 4:08=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, May 13, 2024 at 1:29=E2=80=AFPM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> > >
> > > From: Mykyta Yatsenko <yatsenko@meta.com>
> > >
> > > Sort bpftool c dump output; aiming to simplify vmlinux.h diffing and
> > > forcing more natural type definitions ordering.
> > >
> > > Definitions are sorted first by their BTF kind ranks, then by their b=
ase
> > > type name and by their own name.
> > >
> > > Type ranks
> > >
> > > Assign ranks to btf kinds (defined in function btf_type_rank) to set
> > > next order:
> > > 1. Anonymous enums/enums64
> > > 2. Named enums/enums64
> > > 3. Trivial types typedefs (ints, then floats)
> > > 4. Structs/Unions
> > > 5. Function prototypes
> > > 6. Forward declarations
> > >
> > > Type rank is set to maximum for unnamed reference types, structs and
> > > unions to avoid emitting those types early. They will be emitted as
> > > part of the type chain starting with named type.
> > >
> > > Lexicographical ordering
> > >
> > > Each type is assigned a sort_name and own_name.
> > > sort_name is the resolved name of the final base type for reference
> > > types (typedef, pointer, array etc). Sorting by sort_name allows to
> > > group typedefs of the same base type. sort_name for non-reference typ=
e
> > > is the same as own_name. own_name is a direct name of particular type=
,
> > > is used as final sorting step.
> > >
> > > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > ---
> > >  .../bpf/bpftool/Documentation/bpftool-btf.rst |   5 +-
> > >  tools/bpf/bpftool/bash-completion/bpftool     |   3 +
> > >  tools/bpf/bpftool/btf.c                       | 138 ++++++++++++++++=
+-
> > >  3 files changed, 139 insertions(+), 7 deletions(-)
> > >
> >
> > LGTM, tried it locally and it works well. In fact, see 6.8 kernel vs
> > latest bpf-next/master (with basically the same config) comparison.
> > It's quite minimal and easy to use to see what changes about some of
> > the BPF internal types.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Tested-by: Andrii Nakryiko <andrii@kernel.org>
> >
> >   [0] https://gist.github.com/anakryiko/8fd8ebf2aba73961ebd3cf6587de682=
2
>
> Just noticed:
>
> + ETHTOOL_A_TS_STAT_UNSPEC =3D 0,
> + ETHTOOL_A_TS_STAT_TX_PKTS =3D 1,
> + ETHTOOL_A_TS_STAT_TX_LOST =3D 2,
> + ETHTOOL_A_TS_STAT_TX_ERR =3D 3,
> + __ETHTOOL_A_TS_STAT_CNT =3D 4,
> + ETHTOOL_A_TS_STAT_MAX =3D 3,
> };
>
> I'm a bit surprised that enum values are not sorted.
> I'm guessing the enum names come in dwarf order and copied
> the same way in BTF ?
> I guess it's not an issue.

Yes, it's the order in which enumerators are defined (which DWARF and
thus BTF preserves). I think it makes sense to keep the original order
for those.

