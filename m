Return-Path: <bpf+bounces-38563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1034966655
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 17:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEF3287196
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A811B86EA;
	Fri, 30 Aug 2024 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThIyfz+n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98961A4ABC
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033525; cv=none; b=erkkuRuBT7MJUXRv9qG5yp20m9FCPavM1IKfME7dqswFWdtw8yxsfTqmlLLdc8UGUh3153uSqIE44ENRjqeYJi3LFr4VvVpahUEUMFanpwA4CIfiN6pEEHyBboairWNmjld75VcmNGRYQhxM6uNzD/7/iK6BiUATICA6plHksf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033525; c=relaxed/simple;
	bh=QSGkwVsTLtT28VOKpcgmUfGbFalGVUjM6fFLGBmZFwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAE6iyzzO2RL4lH1JzymheAnxZp9KUL7yq2jXWRKgcV7ZpBChpWTARISKdFdYSqkG/yQNg3IpbBrde4WrbTNgFeUfCOnm4MBCe6Gq+3w2U1nJvWlcpltIfijbVpTp0pVisx5uW+w/XzNTAAwAcG4kx/zD5aNB0+/7HBaD4L5wQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThIyfz+n; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7cd835872ceso1452777a12.3
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725033523; x=1725638323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSGkwVsTLtT28VOKpcgmUfGbFalGVUjM6fFLGBmZFwc=;
        b=ThIyfz+nns1OQkohERNJn3nj56AbXBNrG5KOYt8eOIkxOJAjtFBMSfESUmRQ42pPG7
         btdpY9UgBdhmQlac6uPErt6np7dcrphTwO9IvECjDDHUwhsXS7iLGrZn7hgMToGqJmvR
         5p2VYcuZlUTXzWktA2RdsFiLOHfkmI1yGcOqvsIloAbjX9IERGa4SBedrHubAYBl1wkv
         Wzcz143klB9Z1P5DlieegHtKLprCYh0di6p0SSOmUOYalV9fyaoRtY+LKG2Pl4j9afAz
         +uVYpMWiRP095TysxT1CvNz/mtzhmCfzhrefxxs8lYbWlPiqUzlpfOGnidhwUR7TXM4W
         g3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725033523; x=1725638323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSGkwVsTLtT28VOKpcgmUfGbFalGVUjM6fFLGBmZFwc=;
        b=E/BVkZfChvoZXCzmrct5CflHc89owgGNmbnX973f7kItS5TahUAu755Q/bo7XY+fcO
         ObHWRsnkfwYj6rS2iZQ9qW8RAsXtqK0L5n4tCZKS9jYQfEqtKx5iwzUYQYcXnJFWLJwp
         KG5ySkdtR17O+LVozxVjFwi1SLT7/ptOq7Rv3R9Xys1K13HXtyCgttseQUwRsohYHVxg
         odJdWfXY3QgKuibVB9LbnJSYjoXCxjsbveOOg4hZnzk2oGA5mpzu/0yuPLWegqWfMILe
         un2A/Y2rwL+UzfGVEbSj8lzqTzhP4Az2/GOCI0F9yapvFrg9eDkal8urLLqDk3od3iZ2
         b68g==
X-Forwarded-Encrypted: i=1; AJvYcCWlD/oRDPgE//W54z2WbZfw7uBBM+OXoopp8oBxuZwgVwTUsq4j22NLdoh3PWkTJDBdHDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsUTLfEUXY60kVpEbDrRUTrR2+OcylnNKr2uy0PYBUt9AnyONO
	bgV1kCCydHhXKVeHCScc5mC51PUiUeXiEbqvD+0jxpS5Ad551msJUJTLb3Zs6ITU/OWPFdsckP6
	ibSAd3JToPq1QxZf+lg5qGnQeHe5kBw==
X-Google-Smtp-Source: AGHT+IHZosd8heIhy7N0IgqgmfNefpDYC6gWCQo3OLARm8Vtp6SdCUrJKJlhpe0PySGBwxxMz1ArAi3GCaXrHJjqLYU=
X-Received: by 2002:a17:90a:d996:b0:2d8:898c:3e93 with SMTP id
 98e67ed59e1d1-2d8898c4089mr850171a91.22.1725033523025; Fri, 30 Aug 2024
 08:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5be4f797c3d5092b34d243361ebd0609f3301452.camel@gmail.com>
 <20240830095150.278881-1-tony.ambardar@gmail.com> <7425efdc2c8f52a780e2b4817e15911f8dd491f2.camel@gmail.com>
 <5d5fe5b6-49bd-4ae3-8d6a-973ec627624a@oracle.com>
In-Reply-To: <5d5fe5b6-49bd-4ae3-8d6a-973ec627624a@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 08:58:31 -0700
Message-ID: <CAEf4BzZD5iv_VRmyuSH_30gMtDEYpGJAnNzNVKuC66qop2wr6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] libbpf: ensure new BTF objects inherit input endianness
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 4:26=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 30/08/2024 12:15, Eduard Zingerman wrote:
> > On Fri, 2024-08-30 at 02:51 -0700, Tony Ambardar wrote:
> >> The pahole master branch recently added support for "distilled BTF" ba=
sed
> >> on libbpf v1.5, but may add .BTF and .BTF.base sections with the wrong=
 byte
> >> order (e.g. on s390x BPF CI), which then lead to kernel Oops when load=
ed.
> >>
> >> Fix by updating libbpf's btf__distill_base() and btf_new_empty() to re=
tain
> >> the byte order of any source BTF objects when creating new ones.
> >>
> >> Reported-by: Song Liu <song@kernel.org>
> >> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> >> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> >> Link: https://lore.kernel.org/bpf/6358db36c5f68b07873a0a5be2d062b1af5e=
a5f8.camel@gmail.com/
> >> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> >> ---
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >
>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
>
> Thanks for the fix!
>
> > But we also need a test for this. Like the one attached.
> > Or Alan can share his test, which is much shorter but skips round trip =
to bytes and back.
> >
>
> Eduard's test is better than mine; mine was a simple addition to
> btf_endian() tests that checked split/distilled BTF matched endianness
> of the originating BTF for non-native endianness. Having actual
> non-native endianness _use_ as in Eduard's test is much preferred I think=
.

Eduard, please send it as a proper patch?

>
> > [...]

