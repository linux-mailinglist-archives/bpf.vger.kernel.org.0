Return-Path: <bpf+bounces-67564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE3DB459F6
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 16:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27D05A867A
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 14:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480D82116E7;
	Fri,  5 Sep 2025 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7ObO8Iv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F682AE84
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080823; cv=none; b=bJxcscfGTZYOAqhrO+Ua3N93sRmkAI6IVp14c+7kgVMZQnaEsBFbHwHv1FP0Ir6u6O9oWPIBqENZbrAz6nQVdR7TonP1isEhnpXdJg/SiPp7KkR56K69yo0PZ1MXkmkLRXqTUWRlPQNeK4wP5wZR7ykJh0eo4emUHgwhKZ4Sl70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080823; c=relaxed/simple;
	bh=xangNiKrJi7AWXVDH2I6/NlavEH1Y2OmlAsyBUqNvjs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HgHa1c0Ttdf6uzXZ2b4fP826Fs04OBZ5H0kQZEzwayMzboXHmqUyNu438tUfFLNqWpZXwu4JP2ijhZ+Rf9I4Davu9vrSQdFzRaIwoeSYmT9w2u7ngS/M1FFm0EP8JLrYM0x0Tk1aLbsdweJ/gGcwEDvhwxm4Pv6w0FrOld73Imo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7ObO8Iv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27840C4CEF1;
	Fri,  5 Sep 2025 14:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757080823;
	bh=xangNiKrJi7AWXVDH2I6/NlavEH1Y2OmlAsyBUqNvjs=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=r7ObO8IveVNzMW8tewj4gI2KOesocpZNL1qhEuFetkVSfm4YV8MgiQBR/pXV+bEzi
	 ygoENNSh2dUTFGaVul30nrbyo7SRuq0vLEMMjC67/h9xYMdQEwBOPDnHkR9RO66UK4
	 WnQiqnxef7O/H3xhuAvzNpItC5rMiqGTWS43WBYvMAIxlrjgvrg5xDNcRowWnxiI3G
	 1caqROsRHz5FDQ64ltHyKsPjuvIfyzdsE8ZFYHa1XaBrAp40vF1bVak13ZeqrCxwOP
	 dTLGtmeFwazov6hyjPj9CfTBw2qOhBKpj0Lu2oPfEJfzZ4mCsok7rHNuedzGg4kDQW
	 ONhrmlBzanLsQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: Add tests for arena
 fault reporting
In-Reply-To: <3105c65cd99c483ecb4eb63d590fcec9601891bd.camel@gmail.com>
References: <20250901193730.43543-1-puranjay@kernel.org>
 <20250901193730.43543-5-puranjay@kernel.org>
 <3105c65cd99c483ecb4eb63d590fcec9601891bd.camel@gmail.com>
Date: Fri, 05 Sep 2025 14:00:19 +0000
Message-ID: <mb61ptt1hq9sc.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Mon, 2025-09-01 at 19:37 +0000, Puranjay Mohan wrote:
>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
>> index 9d0e5d93edee7..b2a85364e3c4f 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/stream.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
>> @@ -41,6 +41,22 @@ struct {
>>  		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
>>  		"|[ \t]+[^\n]+\n)*",
>>  	},
>> +	{
>> +		offsetof(struct stream, progs.stream_arena_read_fault),
>> +		"ERROR: Arena READ access at unmapped address 0x.*\n"
>> +		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
>> +		"Call trace:\n"
>> +		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
>> +		"|[ \t]+[^\n]+\n)*",
>> +	},
>> +	{
>> +		offsetof(struct stream, progs.stream_arena_write_fault),
>> +		"ERROR: Arena WRITE access at unmapped address 0x.*\n"
>> +		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
>> +		"Call trace:\n"
>> +		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
>> +		"|[ \t]+[^\n]+\n)*",
>> +	},
>
> I commented when prog_tests/stream.c was first introduced but it was
> decided to postpone the change back then.
> It would be nice to have the above expressed in terms similar to
> bpf_misc.h:__msg() macro. E.g. name it __bpf_{stdout,stderr} and
> have something like this in the progs/stream.c:
>
>   SEC("syscall")
>   __success __retval(0)
>   __bpf_stderr("ERROR: Arena WRITE access at unmapped address 0x{{.*}}")

I would prefer naming them __stderr and __stdout

>   __bpf_stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
>   ...
>   int stream_arena_write_fault(void *ctx)
>   {
> 	...
>   }
>
> Now that more tests are added, what do you think about such extension?

I tried implementing this and it looks nice, so I think we
should have it.
Will add it with the next version.

Thanks,
Puranjay

