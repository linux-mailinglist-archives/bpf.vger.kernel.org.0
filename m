Return-Path: <bpf+bounces-20010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D224D836900
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 16:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FC3282CC2
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F1E4A99B;
	Mon, 22 Jan 2024 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbnVcHEy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A107073168;
	Mon, 22 Jan 2024 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936045; cv=none; b=N7nW/oyrJvrS+2RWtUQNqZy3OBncPHB/2ejiOd5pQstai2Hqh9wB+illEcAXKrc4TqHCSpgd3D8sTNKEmkeDuzl856tCrZSLMpkwzo34HPhpSDZTIbJlp7gpSBkCRapKZyYDVuxoxpJ2LANF2wLAAr6cYjC6zbAx2x4Dt9GB5ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936045; c=relaxed/simple;
	bh=C4Pf/vtgwLjODbCX6iJQ/lW7YJ0cu5nY/RezoggfNhQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ijtvWSnMSdio/8I5phsgaAglStfwIQS3vCuVCeQwLM6EcGhM++adbC72lsk/yGfN5KQNzc5c/2WFd+ytBCdl4Jhm2nWPxOQHzZSqP/EU3NArkD97rt/9fHM84OJ1SAocLmKPvO2A1n8HfznLWnJHZyDCiRnJMrMjt40ffIYGr44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbnVcHEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E0CC433F1;
	Mon, 22 Jan 2024 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936045;
	bh=C4Pf/vtgwLjODbCX6iJQ/lW7YJ0cu5nY/RezoggfNhQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IbnVcHEyw4bB2vApZD4XltuW4l6nP3uGksN7ElYJtQWlQuCgEIWCTWEV0ce4jL4CK
	 E1NEtjVLHC+sPHWbkbWupyw20zhyH6Z48MHONKxH2sX3hcYlYnJ9koEvFfmpluFAS7
	 gxWP54ZbuFcwTNkq/WciHVXzXK2W2rcImGcFPBG+8o1Iu/qELd9AQn116bJwrsfi29
	 psHLU2D/6sre0i63ytF57ld9yZcbtXlbfDM0Oj2wF+OucVYdF2S60PkO+rqPuAVi2K
	 TG7p7/SAZBckT3zqJYe+cFxuYEXrxOxttcBG5Xte39hW+RqhF2YfHl/tvskMnKuYEO
	 tj+Y3osIlbI8A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke Nelson
 <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH RESEND bpf-next v3 0/6] Zbb support and code
 simplification for RV64 JIT
In-Reply-To: <878r4hqvgq.fsf@all.your.base.are.belong.to.us>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
 <87il3lqvye.fsf@all.your.base.are.belong.to.us>
 <baffbab8-721f-462a-8b58-64972f5eae70@huaweicloud.com>
 <878r4hqvgq.fsf@all.your.base.are.belong.to.us>
Date: Mon, 22 Jan 2024 16:07:22 +0100
Message-ID: <874jf5qudx.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Pu Lehui <pulehui@huaweicloud.com> writes:
>
>> On 2024/1/22 22:33, Bj=C3=B6rn T=C3=B6pel wrote:
>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>=20
>>>> Add Zbb support [0] to optimize code size and performance of RV64 JIT.
>>>> Meanwhile, adjust the code for unification and simplification. Tests
>>>> test_bpf.ko and test_verifier have passed, as well as the relative
>>>> testcases of test_progs*.
>>>>
>>>> Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/=
bitmanip-1.0.0-38-g865e7a7.pdf [0]
>>>>
>>>> v3 resend:
>>>> - resend for mail be treated as spam.
>>>>
>>>> v3:
>>>> - Change to early-exit code style and make code more explicit.
>>>=20
>>> Lehui,
>>>=20
>>> Sorry for the delay. I'm chasing a struct_ops RISC-V BPF regression in
>>> 6.8-rc1, I will need to wrap my head around that prior reviewing
>>> properly.
>>>=20
>>
>> Oh, I also found the problem with struct ops and fixed it

Pu, with your patch bpf_iter_setsockopt, bpf_tcp_ca, and dummy_st_ops
passes!

Please spin a proper fixes patch, and feel free to add:

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>


Bj=C3=B6rn

