Return-Path: <bpf+bounces-20976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3D7845E89
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 18:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908B0B25106
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 17:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817A81649C0;
	Thu,  1 Feb 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK/ob+v7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063E463C90;
	Thu,  1 Feb 2024 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808639; cv=none; b=BfbvzvS0LzX2BKwfOT2eUoNR/nkU+R79z0WfK8byQ60Hk7IJv4HJ1a7ESRW7ZE6pAfQF3sVYuPYMKZWtvJ0Wf2sigSVCSLDn7GWnLecal9jUuOJHS1M6gUFuVqcJZergQoxc9RjHR5zqHFwCV1jxTDT0NKz/4DR9W6lHl1djqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808639; c=relaxed/simple;
	bh=i5MzbQtJxIJyUIioRZmwoAWCq7On376ElDaTQVJNDRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P6G+Bqx0l/nm2xq8bZRmenHYzhwcBAkX1X1b0F6w3vmpY+wH4S+HmOI+f38yzqT2Ww9dIz2MdYmuVLELIb6hp2DGbziW0XBneChCkdFSpEhNALz9FtGdJCWEatjcBrVHR/CU5olOdOvEZEBgY1cM7j2lTWe1JTHqjyWPZm7yt/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fK/ob+v7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279E3C433F1;
	Thu,  1 Feb 2024 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706808638;
	bh=i5MzbQtJxIJyUIioRZmwoAWCq7On376ElDaTQVJNDRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fK/ob+v7AOYnbbecuKFi2nISpVtsgLLSChG+9Wtqi4VPBBMhhbooyaUJYNEtpPnPm
	 1vLOp+/Ospfhf+IfugDdf95OuGpu5c2riFWTR9Fuu5S2k2b2zs3hBHPkxCLmhjYqAy
	 0gmL03GHU1088tECMtgAz6OktfBytZWF1G6Ed3sXYNtaq0YDc417G8pWPJ2k5ToMcR
	 qCD+Ipsd6x62DEAqZP3CPmN0VXsbac/kLz1uu27rBAJCswFcLQflNacfckx3/j1A9t
	 E/F2ls7LUcjh+st2+jsXjsWunA9DA1MXYFwBirRQBRl/tlx+4zAGERFC1LuhS1LZtG
	 6xSO0ZeY5y1mA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: Pu Lehui <pulehui@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>, Network Development
 <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Luke Nelson <luke.r.nels@gmail.com>, Pu Lehui
 <pulehui@huawei.com>, Leon Hwang <hffilwlqm@gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] Mixing bpf2bpf and tailcalls for RV64
In-Reply-To: <CAADnVQ+rLneO4t=YYmLYtc945Fz0=ucNTWZBxgvs8toFY-onRg@mail.gmail.com>
References: <20240201083351.943121-1-pulehui@huaweicloud.com>
 <1e7181e4-c4c5-d307-2c5c-5bf15016aa8a@iogearbox.net>
 <CAADnVQ+rLneO4t=YYmLYtc945Fz0=ucNTWZBxgvs8toFY-onRg@mail.gmail.com>
Date: Thu, 01 Feb 2024 18:30:35 +0100
Message-ID: <871q9w9jno.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Feb 1, 2024 at 2:56=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>>
>> > will be destroyed. So we implemented mixing bpf2bpf and tailcalls
>> > similar to x86_64, i.e. using a non-callee saved register to transfer
> ...
>> Iiuc, this still needs a respin as per the ongoing discussions. Also,
>> if you have worked on BPF selftests which exercise the corner case
>> around a6, please include them in the series as well for coverage.
>
> Hold on, folks.
> I'm not sure it's such a code idea to support tailcalls from subprogs
> in risc-v.
> They're broken on x86-64 and so far several attempts to fix them
> were not successful.
> If we don't have a fix soon we will disable this feature completely
> in the verifier.
> In general tailcalling from subprogs is a niche use case.
> If there are users they should transition to tail call from main prog onl=
y.
>
> See
> https://lore.kernel.org/bpf/CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggA=
iCZrpw@mail.gmail.com/

Got it. ...and it's broken on arm64 as well?

