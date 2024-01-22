Return-Path: <bpf+bounces-20014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C330836EA8
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 18:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 201D9B2A5A3
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 17:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D7955C2E;
	Mon, 22 Jan 2024 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye4H0ite"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A625338DC7;
	Mon, 22 Jan 2024 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941005; cv=none; b=UKdtwc1QypTkJ1hDhLAIOrAaGM6QmiJXYUmYB3B2nkzUA/7tel4Y+6FqooGXZ0vmOcXE2YDDUe9tFGR3f7nNO59soDd66vYLJgvkiqTyeRi7PTXfWRVptbIHzZtS2/M9d/GSjf9s72m4uLyufJkDX0eBGaxe6EVuhTwexStxO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941005; c=relaxed/simple;
	bh=OzGrYxrAboZ3xNAP6YdI4Gj21H01FR+mtvCInhIDFhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XfGFDTsAHXQgLobOd95RsC6CMGiT+Q04owD45R9SjdXCJ3VX29Bfx6RaFALRfcnPUO2wCkn4KfIneUnR8cgLUPSriMY+n+/FSIvngn6L7WYSB/4Ud1npLA45giftCV3f2qGs3Ie21IO1mzKvs8pq03tWj/MwO/ftBgUJv7MK/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye4H0ite; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48EBC433C7;
	Mon, 22 Jan 2024 16:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705941005;
	bh=OzGrYxrAboZ3xNAP6YdI4Gj21H01FR+mtvCInhIDFhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ye4H0itenIlvmOTqqOw+9kFyYzXK16wx1XFlVTPJt9fq+Kgp36t2JlNaFNoiTCEWC
	 5eS9z+LT1q7dljVuP2r1aozVPuACc5+yQxLH0JUwMu419BwByhMqTZqGyMAFm4badq
	 SaSawt9e67OemZmajio5b5sOHfYrTKzimqiZrG6aTQZ2VGD/DkZQKJqGW1h+OjMAtV
	 iiuP3KBY4HLcuTa7ergelTvjX1Bdc49othKQIgX7oKMFTMfP0nX3jZDeTMrfRbqqa0
	 i1lNZX/pKw5qydYjrblS66wqIE4cn5spyVU5tVhjdmnWba/LTcy1SvNPAzyLNVBiI+
	 MpBnuWubPalHA==
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
In-Reply-To: <f73cdabe-eba3-4842-8da2-a6316590eb1e@huaweicloud.com>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
 <87il3lqvye.fsf@all.your.base.are.belong.to.us>
 <baffbab8-721f-462a-8b58-64972f5eae70@huaweicloud.com>
 <878r4hqvgq.fsf@all.your.base.are.belong.to.us>
 <874jf5qudx.fsf@all.your.base.are.belong.to.us>
 <f73cdabe-eba3-4842-8da2-a6316590eb1e@huaweicloud.com>
Date: Mon, 22 Jan 2024 17:30:02 +0100
Message-ID: <87zfwxpbzp.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> On 2024/1/22 23:07, Bj=C3=B6rn T=C3=B6pel wrote:
>> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>>=20
>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>
>>>> On 2024/1/22 22:33, Bj=C3=B6rn T=C3=B6pel wrote:
>>>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>>>
>>>>>> Add Zbb support [0] to optimize code size and performance of RV64 JI=
T.
>>>>>> Meanwhile, adjust the code for unification and simplification. Tests
>>>>>> test_bpf.ko and test_verifier have passed, as well as the relative
>>>>>> testcases of test_progs*.
>>>>>>
>>>>>> Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.=
0/bitmanip-1.0.0-38-g865e7a7.pdf [0]
>>>>>>
>>>>>> v3 resend:
>>>>>> - resend for mail be treated as spam.
>>>>>>
>>>>>> v3:
>>>>>> - Change to early-exit code style and make code more explicit.
>>>>>
>>>>> Lehui,
>>>>>
>>>>> Sorry for the delay. I'm chasing a struct_ops RISC-V BPF regression in
>>>>> 6.8-rc1, I will need to wrap my head around that prior reviewing
>>>>> properly.
>>>>>
>>>>
>>>> Oh, I also found the problem with struct ops and fixed it
>>=20
>> Pu, with your patch bpf_iter_setsockopt, bpf_tcp_ca, and dummy_st_ops
>> passes!
>>=20
>> Please spin a proper fixes patch, and feel free to add:
>>=20
>> Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>>=20
>
> Is that in a hurry? If not, I would like to send it with the upcoming=20
> patchset.

This is a separate fix, right? What patchset are you referring to where
the fix would be in?

As of now 6.8-rc1 is broken! It would be a great with a fix asap...


Cheers,
Bj=C3=B6rn

