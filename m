Return-Path: <bpf+bounces-20985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FAC8461FC
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 21:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37801C2323C
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 20:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D0A29403;
	Thu,  1 Feb 2024 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE7S+0Jp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44491111E;
	Thu,  1 Feb 2024 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706819805; cv=none; b=g/+pHXI9OE3SLsQ3Ri2eJw4fql/u2UdQWTDCGJwkY+BH50ymkX1bnLJ2KO+lNV01ElzW+oMI3M89WxDYp2f7vEvzEDQpLR94ZvXvXxlr/pW5zSxCSx60CLcV6OZLO3Ehl3Z4lDrSZewAJAQgD50d85S68YfCawGRy1T7RXD8D2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706819805; c=relaxed/simple;
	bh=E1rOAnks+IZIRKFOoQxMMgMUJD9hU55SNyeP1OvjJ+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTyuArBPyA1wcvSb5dF/MmWpPiQM2F35dh2e5IV8Nl6l1oDtn6Ag5TH9pcL+IhpPR0jmKTG0ocuyYvNJOMRU65XvZ7x7CANs6/eLOU2dpv+584Hd+k3DspFb/71meRJLoA1kzLKseKNJiFRVbDWJW7aE1luqO/261X2ZqEKbXd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EE7S+0Jp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fafae5532so12124445e9.1;
        Thu, 01 Feb 2024 12:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706819802; x=1707424602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1rOAnks+IZIRKFOoQxMMgMUJD9hU55SNyeP1OvjJ+E=;
        b=EE7S+0JpwOm8TI4i6/BUg0xx8R+uGAEWGvhZPhfbf110jcnGMwSRdnVKcCA81hkMmk
         NHYJHqLZB0iPg5CfckqVnjQAQwvXiVP7+2AMtF21FiHqvbiwViwmZd/ACUIXmhM6OLTA
         xQ15FDiE3BEraiJVIpwmIFL2PiBmCEyLNUwpkfly2/7OTinejTRSwG4DIBiHiFBWqMwJ
         g+T1GDBHTBVeAtthCgOjKdjjwjmT6rU7uP1d6yHIEvwjmT0KR8MV3Y6RIWWCA8XFGffZ
         f53073l9XAhjxCVXlvjx7mFs1PCIbHjng+F7S/zBXI20kM3ZOwCMMO3jwfwK4mzBPJdx
         c6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706819802; x=1707424602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1rOAnks+IZIRKFOoQxMMgMUJD9hU55SNyeP1OvjJ+E=;
        b=tTAyM1ePjFhClSl/rMxrVxmLUMf6Yxkjlu8lmO8VcQGvJqGXDjnD+EFFTyN8nW+sac
         C50bGsAVjbeKytbdshdqYZpiiLgJQTGbYMmbWM32wZUSYjjNR7LNwSbIoI+rPVfCrQ+S
         lHXpPBXpgsbRJR+8vNIlWw2eMu/wPr4AwDfOvhlYjNCg1TNUX+YhNCHXPAbnNrcDuC3h
         hB5Em4kAAXQ4/02RAL90jBlB490vVRrDFrglp4kCKSJbVH83Idc7LrnMXBmat7WoM71l
         8Wp9n2N2jyTwXWKS3wWFd61ERXYJpiHCLp3I51TDtxinDmt3GaVfPtkif0Gt7FyWjGmy
         nuuQ==
X-Gm-Message-State: AOJu0YxC7pjyrUJTISK7yIsY3d/InEBXE1/GNFpbXeupwbkS6YRCZ9aB
	mBWOX3ppIxqfsAOkEy275qrio6AP+t7+qXorqn6o1Prb92t60kAG8lbeFmtxcvPipHEbzx3WTJs
	kOeoeDh/eDp7XAKF/cv17j5rtPG0=
X-Google-Smtp-Source: AGHT+IFFBt5YrQiVi1KM33MeIXTr84iePPwBvMBSrk2lEQIfOz8KCrXcZ9iChz/3hYD9+MHfSxbpDLnqctJ+uMo7MAk=
X-Received: by 2002:adf:ef44:0:b0:33a:e4de:9afd with SMTP id
 c4-20020adfef44000000b0033ae4de9afdmr3650651wrp.29.1706819802156; Thu, 01 Feb
 2024 12:36:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201083351.943121-1-pulehui@huaweicloud.com>
 <1e7181e4-c4c5-d307-2c5c-5bf15016aa8a@iogearbox.net> <CAADnVQ+rLneO4t=YYmLYtc945Fz0=ucNTWZBxgvs8toFY-onRg@mail.gmail.com>
 <871q9w9jno.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <871q9w9jno.fsf@all.your.base.are.belong.to.us>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 1 Feb 2024 12:36:31 -0800
Message-ID: <CAADnVQKftCnTnvyGwwWZu73zeqP8f_acoyMjwSpE+tj2dN1irQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] Mixing bpf2bpf and tailcalls for RV64
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Pu Lehui <pulehui@huaweicloud.com>, 
	bpf <bpf@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, 
	Network Development <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Luke Nelson <luke.r.nels@gmail.com>, 
	Pu Lehui <pulehui@huawei.com>, Leon Hwang <hffilwlqm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 9:30=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Thu, Feb 1, 2024 at 2:56=E2=80=AFAM Daniel Borkmann <daniel@iogearbo=
x.net> wrote:
> >>
> >> > will be destroyed. So we implemented mixing bpf2bpf and tailcalls
> >> > similar to x86_64, i.e. using a non-callee saved register to transfe=
r
> > ...
> >> Iiuc, this still needs a respin as per the ongoing discussions. Also,
> >> if you have worked on BPF selftests which exercise the corner case
> >> around a6, please include them in the series as well for coverage.
> >
> > Hold on, folks.
> > I'm not sure it's such a code idea to support tailcalls from subprogs
> > in risc-v.
> > They're broken on x86-64 and so far several attempts to fix them
> > were not successful.
> > If we don't have a fix soon we will disable this feature completely
> > in the verifier.
> > In general tailcalling from subprogs is a niche use case.
> > If there are users they should transition to tail call from main prog o=
nly.
> >
> > See
> > https://lore.kernel.org/bpf/CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvg=
gAiCZrpw@mail.gmail.com/
>
> Got it. ...and it's broken on arm64 as well?

Not sure. arm64, s390, loongarch, x86 claim to support it.
For a long time we thought that it works on x86 until Leon came up
with a way to break it.

