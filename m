Return-Path: <bpf+bounces-39885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83245978CF5
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 05:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE2A1F22CDF
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 03:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3504610A3E;
	Sat, 14 Sep 2024 03:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4Ebr6Pr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C93D62;
	Sat, 14 Sep 2024 03:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726282997; cv=none; b=PsWwX5a2d8S8bSh3OqePdhvVugYramPgwYPfJE8X+GmhPixB2uqFpIs47Q1K0QZcnW8jR8miyfbMfqZFYU8colU1yPAbldH1bZD56gMLfKJRo7HGg/a8vhGwF8Upz5UE3fYmoRyOZc8npS0JKP2082hE6uByE8NoLbnXiqpQrnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726282997; c=relaxed/simple;
	bh=wHRovX7RnBYXUTVQdCoomJetxBSN1EYFT4oLTbCD058=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8HS5dMzyhd2cW+fbj3iPQ9pKshClvNeOqk9K/gRBLZaCD9Jdj1HhJ9uv6xFeC0HXe+LJfmQ8AgImKvTk2EGHtIQXabJuAL1yLid0UuhobVxaGzEaIkeg53NSZ8I6niNHgBfI06hSWCLq8NSQYcZhqpQTiijZhhzOHP7+GrhspU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4Ebr6Pr; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3787ddbd5a2so1726040f8f.0;
        Fri, 13 Sep 2024 20:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726282994; x=1726887794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHRovX7RnBYXUTVQdCoomJetxBSN1EYFT4oLTbCD058=;
        b=f4Ebr6PrG7R64KFEUlNu8lt1FIdCh4+Qw/jEaRbNr1tzl3cqogBrx+NKYvFRwTN5+P
         CYff1eXmt9gvrBLhChlYP+tuBAJE0nTjU6rbFsiEvPvLmKzkZDtn6c/cTOzrjFb2h1Cf
         EYl5+fJz42uf8CBTQXEbN78to576FxB5+EQH6S7sBuKp+6TcozbQevSyuLxmCiC+kcjO
         KN1JhNc65rO2DHeMpONnDEY1fzFiMyXYtVhIP+d52QQ96I05XwYEOUkKPoAx5zNc3Xib
         N8GAyeNnUe3Xlakc3z7lzMZ7TpycRgJ94bK77+NxE395wZ9TCROlNBL24m6OB0mrDGkz
         KWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726282994; x=1726887794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHRovX7RnBYXUTVQdCoomJetxBSN1EYFT4oLTbCD058=;
        b=tZVJTVVNWniVKYfqWWugpT9d+HJK2sFl5Av3xWLZ++ypdj4RCgh/WOJ9p9VO2ur9XC
         UegBnh1GNWsbyN7AmaTPqWsX2t2mxPtMmO/zblCLp6RhYw95qgtNb8ZmZnBnLDmRAmvJ
         jJQ2gftC+xgd0xej8IySe4RGoIornmcWKv746A9BoXwXVoWQOeEUohGRAkBOSPA2do4K
         ESojvU2m3lD7L0aWTsKBQ0e1C1YN/BqHKBkTO1xCxxQCWclxKdJGOcsj02JAWV2vVfmF
         VnjVJt1hBFW+v4THhf7uRENXs1nLyARtnGfiI35dPxq4pf3n4l7+O0T+mEPGF541UPO9
         kbZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuToFmxnV3lGZCIRo83nblNayubAYJzaUFugy4K7dq4ihTztKw9742RJ5VqR4UdNr/gzg=@vger.kernel.org, AJvYcCWvpVYOHIz6OaAzYDJLUUwcGG1rPsHCSeqCPYTOMeAmA4Pog0s0G9gbuf3ebVFjIarkOueOKribH9mlwA6F@vger.kernel.org
X-Gm-Message-State: AOJu0YzFF+yRWmT+XH6u1fH/QaMwg7C2g6qrbrrR87ny5SAE9X2Ic4cm
	UTzMh3Md+9rxXrvJtDLihphmTLGl55Pv1EPDF3PW88JMEyZxFUDfim7MRNCN6WO38fLeYAYtMmL
	7FRfPeUsE6vZvpe4AxCOe/hQAokE=
X-Google-Smtp-Source: AGHT+IE6Te4DOj0dAlpaYwvHWTDV+Aas2h8lEFu/BGIZ+NBGJFXioJ3kNLILpRoarvahX1CeJTjDvcKi/Y/yknMQVac=
X-Received: by 2002:adf:b30e:0:b0:374:c33d:377b with SMTP id
 ffacd0b85a97d-378c2d5a7ddmr5138642f8f.45.1726282994197; Fri, 13 Sep 2024
 20:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913173759.1316390-1-masahiroy@kernel.org>
 <CAEf4Bzawf_EgHyHB+-=2U6eyJtBDVHVQ+Nx1JFw+TTbNSqSmuA@mail.gmail.com> <CAK7LNATurz9J-w+Vbc4FJ+r2Pov028+G+q8SrF12GjjZb1irtQ@mail.gmail.com>
In-Reply-To: <CAK7LNATurz9J-w+Vbc4FJ+r2Pov028+G+q8SrF12GjjZb1irtQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Sep 2024 20:03:02 -0700
Message-ID: <CAADnVQKnyRPWqJG1uL-BOeYjvfxd=+fnaMOFeikQc+Povc=HOw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] btf: remove redundant CONFIG_BPF test in scripts/link-vmlinux.sh
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 6:52=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Sat, Sep 14, 2024 at 7:26=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Sep 13, 2024 at 10:38=E2=80=AFAM Masahiro Yamada <masahiroy@ker=
nel.org> wrote:
> > >
> > > CONFIG_DEBUG_INFO_BTF depends on CONFIG_BPF_SYSCALL, which in turn
> > > selects CONFIG_BPF.
> > >
> > > When CONFIG_DEBUG_INFO_BTF=3Dy, CONFIG_BPF=3Dy is always met.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > > ---
> > >
> >
> > Masahiro,
> >
> > Are you planning to take this through your tree, or you'd prefer us
> > routing it through bpf-next?
>
> Hi,
>
> If possible, could you apply it to bpf-next
> for the upcoming MW?

Sure thing. We'll do.

