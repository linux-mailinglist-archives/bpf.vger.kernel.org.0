Return-Path: <bpf+bounces-71253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E191BEB5F9
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 21:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C3D3AFCAC
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 19:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC2624DCE5;
	Fri, 17 Oct 2025 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL5w0O8b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5C533F8DD
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728741; cv=none; b=jvZV/MVxU774k8U5UyenXbtPcx2tFv4cYQgbxqWfdhdcRrpoG/iikqsryfHrvKBojBCCaumOtKDd44UiIcXupTa2xpVKZ30wT3SSRzhHHI7aMOAmUP1dfOX1Dq2YOXjTqnqkeYOQVJDkMdkwSnyxsXuNWXxa2NPMDzXgLp8JIog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728741; c=relaxed/simple;
	bh=WS6icpBjjEm12+xIuQI9IoJt3gSU2PiVX4yToPTJ2Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9jeAzGK9QD7xZOAN7Emx0HOv8s6QHICGWtzIUZ0BqRyP2iLRCIyrVSzSSoIaFNdAw/stOka7Q0/Q8bfAckTTAWSc4kHAzKq2FXP0gDXAm6jJIuklejKO96bqIiOv2Kcpt05StIhyp6AwMBzLphqm6hP5C7t59JTaZyYbrXiVJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KL5w0O8b; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso441022266b.0
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 12:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760728738; x=1761333538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Lcz8zWqDd1/czyJsOvu2b7Zs2cTFtgMQEoCxeRvT2Q=;
        b=KL5w0O8bJC9luspz2OrD5480D7b5sI2ra8jnC0sf89fEpRmUdrhsGNNxK2tkA2F/Vz
         YZilGAylmlQHa7rq8s69j1EZ26qhpZA1nYqKMZ5FC3Quux7Eg6BXIoh0+auP/QUPNyVC
         XQzlrU6LICA5BeFBw6sLgt8aNxskqWoHqEliViWdnjeA4AmGQ5gs7hecLUjCMBdEWKKk
         aOc3uaParq5q4GwGkwHtXJE40B2K6xL3ZTHbYVLSR2IeU5DL746zfmcDq6ajjnNV6326
         92YCi/NXaRk7/u0hJ0m8sOUM/QJoHzdU+2kjDH2p5Rk8DZyQskhNOEawJz4sF38reL4P
         ZHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760728738; x=1761333538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Lcz8zWqDd1/czyJsOvu2b7Zs2cTFtgMQEoCxeRvT2Q=;
        b=oXcqrA8t7tUv6hIFHM2L+1os2kp26+aNL1+eeLe8HmNIo3yVkH4h/MRLQNL4EgvaIE
         lNFdcOFg7GpNPOY3VT1uKjaT9QPaFTQ9J+9tUXHLvDn71snFU6ONFqiI+7rxt1Wix/Rg
         0iSNTRbnYK6Nxjie1qxAbnCCRt6fMzeXpuPtuTUSjJmORvLf8pPLuLfBvwoPpqU38zNc
         XtjsHvi7oeLRHxTCaaG6eXF9HDxhR5/uHcgk1jEofsdupcmRyDZJTiWYyVpdIaAMFny5
         tViMMzcXGdfLSEvVM2cQ6H8UlQIuW7t/04/KX1SY7OwkMv7lz3Qtz2ywiM9nzKTfdgQl
         RCdg==
X-Forwarded-Encrypted: i=1; AJvYcCUnCaPycsOKBp5dRAzgaAimsFcPU6C4oIiCx/KZ6R1y+K5tx74nyB1c8oBpvTxdfPFnlnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0wjVxCxsnVpX/BNeb9z/Qt1YpBk+uRR4OJuYnUx16rMZVoF2+
	qtcx1AdUpICfX2fc1tlPo1d3Dw3JQ+7pEErGAtn6KsdlqybWa1WbZYtmoP6m24Z/5eysFEFOrJw
	kBfnpUBfM3BdTXdhEqbO6WuNtmeW2Glw=
X-Gm-Gg: ASbGncvQ3L0w+UclKHxXOnxaK/BJtf9U4/I8Sl+8qoUWNLU//m3j/JLAJ1sNG82ixp4
	SUsZ+ZQhv0htzMhjIQoZQIW+NhJZwuVeZArM7AmeixQzKgDbxz+pyDNAwThkoEZ3RNslQeI9/NE
	dhnG04kFzI/TNWCszngPKCGt1Wj5bN67mrRNhb9LSfYIqfUeHQtSXjTMdlr5gseAVD0qgDpF4cV
	3GGr9pVOiIf8Epb5Y/esK/Gy1Tb9XiNG75LeOpbcL3j4643+BH3L3pb2U1LQSKFFrxoXK7qgAMs
	/vTVLlddk2XZ1Ym3137R9cpXNog5xBXXbo4DOA==
X-Google-Smtp-Source: AGHT+IGc90pSZdVkdbqVLz17++MtSeLJGx2apKCGzmJAX8D//wbKfdORj9CLzsJyowwmix1KST8wNCIGEgct0puGp9E=
X-Received: by 2002:a17:906:9c83:b0:b42:9689:cabf with SMTP id
 a640c23a62f3a-b647395272emr530035366b.38.1760728737762; Fri, 17 Oct 2025
 12:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141727.51355-1-puranjay@kernel.org> <CAADnVQLp2w-C+mV+x=A_hxhoNHUk0k5n0gGGFULT_9WiVoABtA@mail.gmail.com>
In-Reply-To: <CAADnVQLp2w-C+mV+x=A_hxhoNHUk0k5n0gGGFULT_9WiVoABtA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 17 Oct 2025 21:18:45 +0200
X-Gm-Features: AS18NWDRDvFOysb69Q3_PEQfEjFFrmL54uDxRquYssf5eMhTzOwLa2mRlG7vKUs
Message-ID: <CANk7y0hs9FORh1ONS38+8s5S3fN4gMyv4Nc9PkKPapwjQkZpxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix list_del() in arena list
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 8:41=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 17, 2025 at 7:17=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > The __list_del fuction doesn't set the previous node's next pointer to
> > the next node of the node to be deleted. It just updates the local vari=
able
> > and not the actual pointer in the previous node.
> >
> > The test was passing up till now because the bpf code is doing bpf_free=
()
> > after list_del and therfore reading head->first from the userspace will
> > read all zeroes. But after arena_list_del() is finished, head->first sh=
ould
> > point to NULL;
> >
> > If you remove the bpf_free() call in arena_list_del(), the test will st=
art
> > crashing because now the userpsace will read 0x100 (LIST_POISON1) in
> > head->first and segfault.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/bpf_arena_list.h | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_arena_list.h b/tools/testi=
ng/selftests/bpf/bpf_arena_list.h
> > index 85dbc3ea4da5..e16fa7d95fcf 100644
> > --- a/tools/testing/selftests/bpf/bpf_arena_list.h
> > +++ b/tools/testing/selftests/bpf/bpf_arena_list.h
> > @@ -64,14 +64,12 @@ static inline void list_add_head(arena_list_node_t =
*n, arena_list_head_t *h)
> >
> >  static inline void __list_del(arena_list_node_t *n)
> >  {
> > -       arena_list_node_t *next =3D n->next, *tmp;
> > +       arena_list_node_t *next =3D n->next;
> >         arena_list_node_t * __arena *pprev =3D n->pprev;
> >
> >         cast_user(next);
> >         cast_kern(pprev);
> > -       tmp =3D *pprev;
> > -       cast_kern(tmp);
> > -       WRITE_ONCE(tmp, next);
> > +       WRITE_ONCE(*pprev, next);
>
> This looks wrong, since cast_kern() is necessary on older llvm
> that don't have arena support.
> On newer llvm above change should make no difference.
> list_del() will still do the poisoning as it should.
>
> I'm missing what you're trying to "fix".


The logic is broken, __list_del() is not removing the node.

For a second assume, everything is in kernel code and not arena,
I am also removing WRITE_ONCE for the sake of explanation:

so, the lines will become (removing all arena magic):


arena_list_node_t *next =3D n->next, *tmp;
arena_list_node_t **pprev =3D n->pprev;

tmp =3D *pprev;
tmp =3D next;

[...]

tmp is a local variable and setting it to next doesn't modify the list.

What we want to do is:

*pprev =3D next;

see: https://github.com/kernel-patches/bpf/actions/runs/18602175717/job/530=
43507792


Thanks,
Puranjay

