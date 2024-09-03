Return-Path: <bpf+bounces-38823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D256F96A6A7
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 20:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115371C24477
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E293F1917E3;
	Tue,  3 Sep 2024 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="eeYAg6K1"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4013015574F
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388524; cv=none; b=kPfKdy4kA84Iy8D4UHKigBZKn0B8BHhODy2Ln0tt2vVl/jcJKO/zGnUH2CJ1sSYEFK8hWVmXjg8CQYWmyaHBriTmfrUzspAGgKgGkJ4yYoNZVsc0jE7HkhKPp5hBeimDxXjlTSrZyBSg+XEB3z/F1L0uIWnFS6d8SPJXKiDdOL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388524; c=relaxed/simple;
	bh=NxFrFfd82CCA6OILly4tV9TQfSfi5DJ7xBdRB8AbJO8=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Bg4UpisHII8238O/Cr2KJd6VUvWAbLHtdGcdS9HYBX0Jqd3UxJBcJKZoNrmVSPS2NeMVYq1ptJrxFLgWKq5G4oRAlhqT0DjYO4cdFKmd1DKerbTjnIgsvxhAd1Vd71HkGM+CqE7xUENsjse9sinfEOupCobB0RD8KBw4Zh4DFQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=eeYAg6K1; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2cwxTc8zSXz8LWhFThzELMFR5EjQIhNHIzE1dzCpuko=; b=eeYAg6K1WY9PFJZfRRU7ovI8mq
	Zvak2quf54bS8MHVDfNm/XV+Huzej7srTzkpQQo6VoLdfeyFZpeLJywtKY2c3EWnsAEyotuvVdfWO
	Zxep2DYAj85gOy4vuYLAT5RFEbKFZ8iQYPaDJlK7Qqx6dp8iUUwmDS0K5SRmDO1NKJbjFDtvVF+W1
	tADtVl3IThsfnnS8g+eYMtR/LoCAdhYvmCZ5wrMMxC5YSMAJwrFcT/U2SoryBn03H3mDpoughqjUc
	CIJJv2QwaVAOWuIJtxhMHPgs/K33P9JYZY6XTFVKtqvhidwlQOzenFaFWtjgMJTIIo8xZNBUeKmSy
	ww/4+ubA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1slYN5-000IKq-TT; Tue, 03 Sep 2024 20:35:19 +0200
Received: from [178.197.248.23] (helo=linux-2.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1slYN6-000MDO-02;
	Tue, 03 Sep 2024 20:35:19 +0200
Subject: Re: Change default cpu version from v1 to v3 in llvm20
To: Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>
References: <ac144cc8-db10-47ea-b364-c9ebf2fe69d3@linux.dev>
 <fc2f30b5-c51b-3e2d-4282-2b22fb998285@iogearbox.net>
 <c39622e0-a88c-4bb5-8ae4-83e138b3e2a2@linux.dev>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <90a00496-bcf9-358c-3b9e-e7a861728733@iogearbox.net>
Date: Tue, 3 Sep 2024 20:35:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c39622e0-a88c-4bb5-8ae4-83e138b3e2a2@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27387/Tue Sep  3 10:38:04 2024)

On 9/3/24 4:50 PM, Yonghong Song wrote:
> On 9/2/24 11:52 PM, Daniel Borkmann wrote:
>> On 9/3/24 6:10 AM, Yonghong Song wrote:
>>> Hi,
>>>
>>> Suggested by Alexei, I put a llvm20 diff to make cpu=v3 as the default
>>> cpu version:
>>>     https://github.com/llvm/llvm-project/pull/107008
>>>
>>> cpu=v3 has been introduced in llvm9 (2019 H2) and the kernel cpu=v3
>>> support should be available around the same time although I
>>> cannot remember the exact kernel version.
>>>
>>> There are two motivation to move cpu version default from v1 to v3.
>>>
>>> First, to resolve correct usage of code like
>>>     (void)__sync_fetch_and_add(&ptr, value);
>>> In cpu v1/v2, the above insn generates locked add insn, and
>>> for cpu >= v3, the above insn generates atomic_fetch_add insn.
>>> The atomic_fetch_add insn is the correct way for the eventual
>>> insn for arm64. Otherwise, with locked add insn in arm64,
>>> proper barrier will be missing and incorrect results may
>>> be generated.
>>>
>>> Second, cpu=v3 should have better performance than cpu=v1
>>> in most cases. In Meta, several years ago, we have conducted
>>> performance evaluation to compare v1 and v3 for major bpf
>>> programs running in our platform and we concluded v3 is
>>> better than v1 in most cases and in other rare cases v1 and v3
>>> have the same performance. So moving to v3 can help
>>> performance too.
>>>
>>> If in rare cases, e.g. really old kernels, v1/v2 is the only
>>> option, then users can set -mcpu=v1 explicitly.
>>>
>>> Please let us know if you still have some concerns in your
>>> setup w.r.t. cpu v1->v3 transition.
>>
>> Sounds good to me! Is there a place somewhere in LLVM where this
>> can be documented for the BPF backend (along with the various
>> extensions), so that developers can find sth in the official LLVM
>> docs if they search the web? I see that riscv and some other archs
>> have documentation under [0] which seems to get deployed under [1].
> 
> Thanks Daniel.
> 
> Trying to have llvm doc for BPF backend has been discussed
> before. IIRC, Fangrui Song suggested this when we tried to
> add BPF reloc documents in Documentation/bpf/llvm_reloc.rst.
> Eventually we added llvm_reloc.rst to kernel since this doc
> is mostly interesting for kernel/bpf folks. We should add
> an entry in bpf_devel_QA.rst to mention that default cpu
> version change from v1 to v3.
> 
> Not sure whether we should have the same doc in
> llvm.org/docs/. Let me discuss with other folks on this.

I was mostly thinking that not everyone might be looking into
kernel docs (say, eBPF for Windows folks using LLVM), and at
least on gcc docs/wiki you'll find information & quirks about
gcc-bpf backend [2].

   [2] https://gcc.gnu.org/wiki/BPFBackEnd

>>   [0] https://github.com/llvm/llvm-project/tree/main/llvm/docs
>>   [1] https://llvm.org/docs/RISCV/RISCVVectorExtension.html
>>
>> Thanks,
>> Daniel


