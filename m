Return-Path: <bpf+bounces-67077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEF0B3D826
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 06:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5C91897CCE
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 04:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC742223323;
	Mon,  1 Sep 2025 04:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dGCiokMu"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC03C120
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 04:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756700288; cv=none; b=kyt91MtlLu22ZwgJm7xj7Xzd0g/wQ4td3445pqqEBsHA6NDuMgkJ2Y4Dr3OW17aTW2erzKbuKHSbMZPzs9iiZY3gw/JGmJsuGKLud2QJmbfrfec92fyBJ4R8pLhXC9V66qoHfJFNOokkvvKkYCkwey9qpT/TJyEsuk71a2Hi79o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756700288; c=relaxed/simple;
	bh=Pm+AntJbu0iXgne3tdX0tqcWXaMnQV5XbVKiM12T++g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNKM2Cw4x+K2FNUSBNwoMd3kfxC+G7AGNWp0F/hLuBLb2Z4cYNDPv9g5H3lRqBs4EtKr3riXIHdh+DkJ5gRvU9De2WX+l+D4StSAfbr9Zz592h3HfHwPIdrFp0893I9IU8zFh8ztcl9C6Kqx41tmaZONrHjbsnTZl+3UnexYBD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dGCiokMu; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <466d45ae-ce97-4256-9444-9f25f3328c51@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756700271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFeYnyXdg1pMpnZ72S/DLX86BgoZXsFUwGGQ62Eq+mM=;
	b=dGCiokMuunRYSNRaCRuXgu9X9AhIlQlGreoeOTQWCA9EcRRVeZuJ77jeox15pef6DAsmnE
	H2muw6r6Wp4WVvHa7X/EtL7uEbPmRw5vlJu1aVcKBk1Z/m1+8N67U8GvMtKIfW3qTZL4Qz
	Yk45/WtnYkRH1xAfWpAR7ytLwtiN1vo=
Date: Sun, 31 Aug 2025 21:17:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] libbpf: add support for printing BTF character
 arrays as strings
To: Ian Rogers <irogers@google.com>, Blake Jones <blakejones@google.com>,
 namhyung@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-perf-users <linux-perf-users@vger.kernel.org>,
 Howard Chu <howardchu95@gmail.com>
References: <20250603203701.520541-1-blakejones@google.com>
 <174915723301.3244853.343931856692302765.git-patchwork-notify@kernel.org>
 <CAP-5=fWJQcmUOP7MuCA2ihKnDAHUCOBLkQFEkQES-1ZZTrgf8Q@mail.gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAP-5=fWJQcmUOP7MuCA2ihKnDAHUCOBLkQFEkQES-1ZZTrgf8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/29/25 10:19 PM, Ian Rogers wrote:
> On Thu, Jun 5, 2025 at 2:00 PM <patchwork-bot+netdevbpf@kernel.org> wrote:
>> Hello:
>>
>> This series was applied to bpf/bpf-next.git (master)
>> by Andrii Nakryiko <andrii@kernel.org>:
>>
>> On Tue,  3 Jun 2025 13:37:00 -0700 you wrote:
>>> The BTF dumper code currently displays arrays of characters as just that -
>>> arrays, with each character formatted individually. Sometimes this is what
>>> makes sense, but it's nice to be able to treat that array as a string.
>>>
>>> This change adds a special case to the btf_dump functionality to allow
>>> 0-terminated arrays of single-byte integer values to be printed as
>>> character strings. Characters for which isprint() returns false are
>>> printed as hex-escaped values. This is enabled when the new ".emit_strings"
>>> is set to 1 in the btf_dump_type_data_opts structure.
>>>
>>> [...]
>> Here is the summary with links:
>>    - [v3,1/2] libbpf: add support for printing BTF character arrays as strings
>>      https://git.kernel.org/bpf/bpf-next/c/87c9c79a02b4
>>    - [v3,2/2] Tests for the ".emit_strings" functionality in the BTF dumper.
>>      https://git.kernel.org/bpf/bpf-next/c/a570f386f3d1
>>
>> You are awesome, thank you!
> I believe this patch is responsible for segvs occurring in v6.17 in
> various perf tests when the perf tests run in parallel. There's lots

Could you share the command line to reproduce this failure?
This will help debugging. Thanks!

> of BPF things happening in parallel in the test but the failures are
> happening in a shell and I did get to attach a debugger. I've not seen
> this problem earlier as the patches weren't in the perf-tools-next
> tree. Through bisection I was able to blame the patch and I came up
> with this minimal fix:
> ```
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index ccfd905f03df..71e198b30c5f 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -326,10 +326,10 @@ struct btf_dump_type_data_opts {
>         bool compact;           /* no newlines/indentation */
>         bool skip_names;        /* skip member/type names */
>         bool emit_zeroes;       /* show 0-valued fields */
> -       bool emit_strings;      /* print char arrays as strings */
> +       //bool emit_strings;    /* print char arrays as strings */
>         size_t :0;
> };
> -#define btf_dump_type_data_opts__last_field emit_strings
> +#define btf_dump_type_data_opts__last_field emit_zeroes
>
> LIBBPF_API int
> btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index f09f25eccf3c..c7b5a376642f 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -2599,7 +2599,7 @@ int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
>         d->typed_dump->compact = OPTS_GET(opts, compact, false);
>         d->typed_dump->skip_names = OPTS_GET(opts, skip_names, false);
>         d->typed_dump->emit_zeroes = OPTS_GET(opts, emit_zeroes, false);
> -       d->typed_dump->emit_strings = OPTS_GET(opts, emit_strings, false);
> +       d->typed_dump->emit_strings = true; // OPTS_GET(opts,
> emit_strings, false);
>
>         ret = btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);
>
>
> ```
> So I think the problem relates to modifying struct
> btf_dump_type_data_opts. Given I'm statically linking libbpf into perf
> I'm not sure on the exact route of the segv, no doubt this report will
> be enough for someone else to figure it out.
>
> Given this is a regression what should the fix be?
>
> Thanks,
> Ian


