Return-Path: <bpf+bounces-20633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B52484154E
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 22:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8731F23C01
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 21:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494F7159568;
	Mon, 29 Jan 2024 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpZIP9mN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9048158D89;
	Mon, 29 Jan 2024 21:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706565512; cv=none; b=t+wLMypiTsma/HJZ5tNOQtdjEPyBm9x/W7wC3Q2sXY0T8b5tv1AdFFXeWOazwdeyxbX2dz8I/sYPklWc69T/EFyKum4LeGdxzkEPRgMEWiB9oFpeJgvu0BoXyaI9znUUW83AWX/dB5+t8IIJkG9FwA0saX296pmYs4+e6Vi7dbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706565512; c=relaxed/simple;
	bh=DiuiMteWjtD0DGA2bnkTTz/tOuGTgdtmyO9VDZPqxk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAOv82/YUDPK4ssnZrki/xovqoDZWHwPYMCv6keFiNxKAoZ9+xq89J5vzY1+f4IeMUZO3p1Zicz3zvK4N4x4UQfzzyPLzfmSgw3BY7ix1+BF80zdE90Ab3sfCAd8sFf80tvVZl2RCLLjOzVkJEkl+xOAIYctT5lx5m0ea0RaXg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpZIP9mN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E92C433B1;
	Mon, 29 Jan 2024 21:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706565512;
	bh=DiuiMteWjtD0DGA2bnkTTz/tOuGTgdtmyO9VDZPqxk4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fpZIP9mN2Cq7MhgOxCLMF0x4xErZYqZyAXSjFI4ydzUNS2LP0oFaVJc3ZEteEprcr
	 V4nHpc+imoa1hiOfecKxrFcMh2BQGUKUymCpkR+Xfz4rgKcKpWZVoMakqYplYS58Q1
	 sfxhP7gvpBMbap61rfCU/4Uw7pifFJkTCYCBaTqKCzFp6cWZVoas1Io9cMoz7rSTdP
	 7dzGVRNM2mHrxBh/Eq/PBAvmO4uLHfumR4kuQ7OsFDYxXbzmRIKRFS3vCg4418Ym++
	 gANQKqkksz3wlD4zw94FAyEFigMBQFt0FN3sy/2GFWYPfLlkQa8DO8Vk3pzjL8Srp4
	 vak5BNgh0RzZQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51031ae95a1so2759046e87.0;
        Mon, 29 Jan 2024 13:58:32 -0800 (PST)
X-Gm-Message-State: AOJu0Yz5B7ITzukMBNCSs9yCFa4tysFT9N9hAiWXiAOv25O1B7Vbpwdk
	+bDAjXD99UgxHKdgE3AbX/SCK9Zs38ywwLfRVWKXNrnityVdqpFLnAUhbqaIs8pBuGGZYTCugWz
	2+crFN2tbsOJ9foA/PRn02dILT0I=
X-Google-Smtp-Source: AGHT+IGWAKr0Ycgzi/iZcSUte5256AaxVuyAn7qb7eWq9WOFrFNcVCiCcCsIO0JX8cH0WZIawFB//fulwJs6n5tMN7s=
X-Received: by 2002:a19:5f16:0:b0:510:2832:5625 with SMTP id
 t22-20020a195f16000000b0051028325625mr4145906lfb.52.1706565510279; Mon, 29
 Jan 2024 13:58:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123103241.2282122-1-pulehui@huaweicloud.com> <20240123103241.2282122-4-pulehui@huaweicloud.com>
In-Reply-To: <20240123103241.2282122-4-pulehui@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 29 Jan 2024 13:58:18 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4dUK4NN6HqEpw7AMwaWyUwvm1a=KmDPHfQsVZ1DphYtA@mail.gmail.com>
Message-ID: <CAPhsuW4dUK4NN6HqEpw7AMwaWyUwvm1a=KmDPHfQsVZ1DphYtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] riscv, bpf: Use bpf_prog_pack for RV64 bpf trampoline
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
	netdev@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Luke Nelson <luke.r.nels@gmail.com>, 
	Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 2:32=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.com> =
wrote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> We used bpf_prog_pack to aggregate bpf programs into huge page to
> relieve the iTLB pressure on the system. We can apply it to bpf
> trampoline, as Song had been implemented it in core and x86 [0]. This
> patch is going to use bpf_prog_pack to RV64 bpf trampoline. Since Song
> and Puranjay have done a lot of work for bpf_prog_pack on RV64,
> implementing this function will be easy. But one thing to mention is
> that emit_call in RV64 will generate the maximum number of instructions
> during dry run, but during real patching it may be optimized to 1
> instruction due to distance. This is no problem as it does not overflow
> the allocated RO image.
>
> Link: https://lore.kernel.org/all/20231206224054.492250-1-song@kernel.org=
 [0]
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Song Liu <song@kernel.org>

