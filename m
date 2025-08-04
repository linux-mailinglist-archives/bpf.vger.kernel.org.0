Return-Path: <bpf+bounces-65015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1287FB1AA22
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 22:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE631886DC6
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 20:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFA423372C;
	Mon,  4 Aug 2025 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJjfFllp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9008222586;
	Mon,  4 Aug 2025 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754339370; cv=none; b=FuhluR6rRvu/mt6hSfAE7nCRHW6koX/mAToXupzPeAWvFy9KYmeaMDt4mfLAGEg9oASidLCaBWzJS2E/kmA5OyZXjHYfgTQki3wf6QVGfUeZlUHrrfIva/G9IT5Ep6796eCT3Vr27Vw+taaDRS/6/mAcm5590WgQqNUsXf/KtkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754339370; c=relaxed/simple;
	bh=4BPsES3b5klXzdk6RpmOqf1VgsIU8ZAY8khzKwSwfwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pkv1NAy+nZwlt/t7lyaJR/I6JpU6Jblhmz2pFt5VW2BwVUSa9VKqk6tA4gKus6S1ZSzeVIvcTw3K96cRw2ULAbvNi7SVr2K7/LfzQbXV64/bgh7bv0ZCZZiea5/NUb+OC0HRB1hXgFtwG/op4n5yiAc8gYFnKOhmA/vZFjYHiK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJjfFllp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD6FC4CEE7;
	Mon,  4 Aug 2025 20:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754339370;
	bh=4BPsES3b5klXzdk6RpmOqf1VgsIU8ZAY8khzKwSwfwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iJjfFllp9A5t0b3evqDJ86gBmdgbLw5CO5nbxRfYOF6T6zvYvTJplqmOZMF4ThZIo
	 rfobGezjJOtX/4wBS1Vk8pP70muPLRhZvC7BSpdi9LBXuciPN6JVp4ZmbxfnGxAPlt
	 F2pr/W0FtNniSZnsJ2+qO5E4eRlppbsRuZougnurPEQoriP4vL/c6WS6GDjE/0waXr
	 KygzMNkPN6s9HyzUlxoVkon6bRUzRG3pIVdGKQYfE2IItRdcVRlP4mbp3Dc1o43HHX
	 1TGjSl/9ZjSU37FkaDT1TDUea1L8WdHxiUVUbvp/8tAE1RHZ8f6iRV1eS0AptBRwS1
	 ohcd9/z6+3Gnw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Pu Lehui
 <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 04/10] riscv: Separate toolchain support
 dependency from RISCV_ISA_ZACAS
In-Reply-To: <20250719091730.2660197-5-pulehui@huaweicloud.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
 <20250719091730.2660197-5-pulehui@huaweicloud.com>
Date: Mon, 04 Aug 2025 22:29:27 +0200
Message-ID: <87qzxq3k60.fsf@all.your.base.are.belong.to.us>
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
> RV64 bpf is going to support ZACAS instructions. Let's separate
> toolchain support dependency from RISCV_ISA_ZACAS.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

