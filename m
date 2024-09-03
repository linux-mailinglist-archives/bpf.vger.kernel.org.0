Return-Path: <bpf+bounces-38779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C653696A123
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 16:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025781C24115
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964F71509B4;
	Tue,  3 Sep 2024 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xfmRkjjs"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECFF1422A2
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375026; cv=none; b=g7KOOpceWooL91xYoNxoavaXhMW0Zhe481ZALQbbs36aOrafgtqfx9nVmf/xCB+dUOcMJyJh8HTja5c7HW6KWGNDdvmV1coynCKKpVsBGTbiuE47Ogz/zRCGzlePRbFLM7y296gqQ2CRqLl51tNDuG70kB/po13jJL6Kkfrp/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375026; c=relaxed/simple;
	bh=cQ5bKlfgDV6CP+VemL0Z/tXaRaRDYqUMTvPJPqT4AJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NPGN+SsoFWSGQFheUavBNf/Zs9KJKOc120Tir22QaWmlQclyKpA9P8QhQkkACgVJnJ5vYkNKhfSg/XKD/XP/O1DYkDEfavqQWhZVDHqHbcL4S9fSjUklIepi+t9gS+hQ0Ee8mhzBX1amEG6wihem0mkveRBjSNHeU5iudqmub/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xfmRkjjs; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c39622e0-a88c-4bb5-8ae4-83e138b3e2a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725375022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQ5bKlfgDV6CP+VemL0Z/tXaRaRDYqUMTvPJPqT4AJY=;
	b=xfmRkjjsPw3p+lKypxmgqLCzDHdKllavYXBlV2l5tBpp1SNsgQ+3VuEEJhlLdn+/1vPWkd
	q6FhUt1XHjoIa/6xemogSeMVMvjP5Enrae/nsf/Wo/GMpyB8G2+ENwO1hJXKnuiBhR4ryk
	+SPPvsEJQKc/z/4fbzcgKt2coqJDd28=
Date: Tue, 3 Sep 2024 07:50:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Change default cpu version from v1 to v3 in llvm20
Content-Language: en-GB
To: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>
References: <ac144cc8-db10-47ea-b364-c9ebf2fe69d3@linux.dev>
 <fc2f30b5-c51b-3e2d-4282-2b22fb998285@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <fc2f30b5-c51b-3e2d-4282-2b22fb998285@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/2/24 11:52 PM, Daniel Borkmann wrote:
> On 9/3/24 6:10 AM, Yonghong Song wrote:
>> Hi,
>>
>> Suggested by Alexei, I put a llvm20 diff to make cpu=v3 as the default
>> cpu version:
>>     https://github.com/llvm/llvm-project/pull/107008
>>
>> cpu=v3 has been introduced in llvm9 (2019 H2) and the kernel cpu=v3
>> support should be available around the same time although I
>> cannot remember the exact kernel version.
>>
>> There are two motivation to move cpu version default from v1 to v3.
>>
>> First, to resolve correct usage of code like
>>     (void)__sync_fetch_and_add(&ptr, value);
>> In cpu v1/v2, the above insn generates locked add insn, and
>> for cpu >= v3, the above insn generates atomic_fetch_add insn.
>> The atomic_fetch_add insn is the correct way for the eventual
>> insn for arm64. Otherwise, with locked add insn in arm64,
>> proper barrier will be missing and incorrect results may
>> be generated.
>>
>> Second, cpu=v3 should have better performance than cpu=v1
>> in most cases. In Meta, several years ago, we have conducted
>> performance evaluation to compare v1 and v3 for major bpf
>> programs running in our platform and we concluded v3 is
>> better than v1 in most cases and in other rare cases v1 and v3
>> have the same performance. So moving to v3 can help
>> performance too.
>>
>> If in rare cases, e.g. really old kernels, v1/v2 is the only
>> option, then users can set -mcpu=v1 explicitly.
>>
>> Please let us know if you still have some concerns in your
>> setup w.r.t. cpu v1->v3 transition.
>
> Sounds good to me! Is there a place somewhere in LLVM where this
> can be documented for the BPF backend (along with the various
> extensions), so that developers can find sth in the official LLVM
> docs if they search the web? I see that riscv and some other archs
> have documentation under [0] which seems to get deployed under [1].

Thanks Daniel.

Trying to have llvm doc for BPF backend has been discussed
before. IIRC, Fangrui Song suggested this when we tried to
add BPF reloc documents in Documentation/bpf/llvm_reloc.rst.
Eventually we added llvm_reloc.rst to kernel since this doc
is mostly interesting for kernel/bpf folks. We should add
an entry in bpf_devel_QA.rst to mention that default cpu
version change from v1 to v3.

Not sure whether we should have the same doc in
llvm.org/docs/. Let me discuss with other folks on this.

>
>   [0] https://github.com/llvm/llvm-project/tree/main/llvm/docs
>   [1] https://llvm.org/docs/RISCV/RISCVVectorExtension.html
>
> Thanks,
> Daniel

