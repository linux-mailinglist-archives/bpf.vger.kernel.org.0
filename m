Return-Path: <bpf+bounces-20744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADF78428B3
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB771C215D8
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 16:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A1386159;
	Tue, 30 Jan 2024 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eu+DgKHU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39DEAC7;
	Tue, 30 Jan 2024 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630689; cv=none; b=YMFXQcgNmPY2C3V7+WeR9/70N26rZ2zPP/LU5u0sabXeAeWl4Hz5NwzktSMzkjCUJIJwT2SIW36+tHpMSteghmBstVnrW7B7n4bBY6Yn6sDeqi0JqHSEsg77KXK+Uz0RUBpoY/6lJMXdzeuoIWUDTwGLL4mE5506AT7xYIvPjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630689; c=relaxed/simple;
	bh=Jxs0gSnJOiGvbx3haHRNhLP2dKu0vcPnwZd0IxIGE8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dg8cZES05LkmY1bAc2OT216nqF7yweslSRBIWGITZN1Z7jLSR65V9VrM+gxjxZ0cD9VIvIwSW2kM7ydJlF7BuGvTHAeiqbw7WSfuZW9WHnU1kV4GubFY2jlM0p83v1NqO4TetSgmjifaDqa3dxo8ktLukZmyafSYR5/yqLT0pG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eu+DgKHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B38C433F1;
	Tue, 30 Jan 2024 16:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706630688;
	bh=Jxs0gSnJOiGvbx3haHRNhLP2dKu0vcPnwZd0IxIGE8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Eu+DgKHUZYDBRukwGg6Zyh/V+BTZIkO7AO7alGt5EIl+jABBBBVTQHEZhhh7l5JNv
	 2hRM8qdMm4kR7NgORdhjfwwzlBn6LM9iYbZrFjep+H1Uug6WL+AWSOr8tBeaBpumZz
	 CVr5S+C+oZFjeiilqC2YLvctETR4FlyQMpNxIjiZhk8zAkOHl44X6PJk5gfx/MlTm8
	 zcMO/Mg9fKpdsqeuu7X/YbijWWlA0Dad9FYmwnPQfPDhs5WnKYzXW9dvqQi2EEmlYM
	 MZHwCVIVj+KWZ4dZnS+o0x2IebdREKFDxZ6uB5j3Dfnudli5pyB+5JpalA/oCcucmt
	 kYfhcOLbazXJA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Luke Nelson
 <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
 <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v2 1/4] riscv, bpf: Remove redundant
 ctx->offset initialization
In-Reply-To: <20240130040958.230673-2-pulehui@huaweicloud.com>
References: <20240130040958.230673-1-pulehui@huaweicloud.com>
 <20240130040958.230673-2-pulehui@huaweicloud.com>
Date: Tue, 30 Jan 2024 17:04:46 +0100
Message-ID: <87h6iuq02p.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> There is no gain in initializing ctx->offset and prev_insns, and
> ctx->offset is already zero-initialized. Let's remove this code.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

