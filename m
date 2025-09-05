Return-Path: <bpf+bounces-67576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9306B45D24
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 17:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD6E5C2A03
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 15:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF15431D746;
	Fri,  5 Sep 2025 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cu/U+6Ps"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C78B31D727
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087712; cv=none; b=kfZZv6jEsX9VpipMhpRVpVXxPuTkeDPy1+LKf7b21UK5RtXJbbfrvBoIkVP0Ef9HG48pBkvCwMhbJDDbQNVOkfoIwGZVdEZE4HDizhYguIxkClpgOr0Wqpf0POsQiKeizeEdQK5mMibkOWXszr8ZKKfv9TN0dN89cLC0C48sor8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087712; c=relaxed/simple;
	bh=VK5L9ZQl5SjCnEBuOT7vVdJruIk2fkLuhS+o/xPYcMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZN9M0gpiEZuvW299/OEXjNlR1mSKAbPbOom/P+GEprhc0FxZBHEomUWDOoFxBAOkVieej8Uou+DgQ/y4XK+TWNzEWm/a+8W5+rFNrtpz/BjTNgCQ0MkDakQ21h6vvsSDMH8xXIMKGjxzDwgty0+hBloeqm13sN2g2uM26uVf2/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cu/U+6Ps; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ca64e62b-740e-4e02-a386-e1016317b071@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757087706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5SkhDx01VH5ULkTtGZmBjnS7ayJVpHz3ZygQmDSZ2dE=;
	b=Cu/U+6PsLuRwZnWv3E3Wzw7kScSJJHds5FQyisY7hZ2cFZhr1wFebmDS00NgIUvDISC20c
	jqLR1yuKPB/o4rskbDHmRuCW9PQ1W88xlz4xNKj8JykWG/iTU2llI7HZIojAN8dn8KU1kW
	vgZ9r3FJPxIJrxzu629/XpqNrIiGBRU=
Date: Fri, 5 Sep 2025 08:54:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v2 1/1] libbpf: add compile-time OOB warning to
 bpf_tail_call_static
Content-Language: en-GB
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: netdev@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "open list:BPF [LIBRARY] (libbpf)" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
References: <20250905051814.291254-1-hoyeon.lee@suse.com>
 <20250905051814.291254-2-hoyeon.lee@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250905051814.291254-2-hoyeon.lee@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 9/4/25 10:18 PM, Hoyeon Lee wrote:
> Add a compile-time check to bpf_tail_call_static() to warn when a
> constant slot(index) >= map->max_entries. This uses a small
> BPF_MAP_ENTRIES() macro together with Clang's diagnose_if attribute.
>
> Clang front-end keeps the map type with a '(*max_entries)[N]' field,
> so the expression
>
>      sizeof(*(m)->max_entries) / sizeof(**(m)->max_entries)
>
> is resolved to N entirely at compile time. This allows diagnose_if()
> to emit a warning when a constant slot index is out of range.
>
> Out-of-bounds tail calls are currently silent no-ops at runtime, so
> emitting a compile-time warning helps detect logic errors earlier.
> This is currently limited to Clang (due to diagnose_if) and only for
> constant indices, but should still catch the common cases.
>
> Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> ---
> Changes in V2:
> - add function definition for __bpf_tail_call_warn for compile error
>
>   tools/lib/bpf/bpf_helpers.h | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 80c028540656..98bc1536c497 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -173,6 +173,27 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>   		     :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
>   		     : "r0", "r1", "r2", "r3", "r4", "r5");
>   }
> +
> +#if __has_attribute(diagnose_if)
> +static __always_inline void __bpf_tail_call_warn(int oob)
> +	__attribute__((diagnose_if(oob, "bpf_tail_call: slot >= max_entries",
> +				   "warning"))) {};
> +
> +#define BPF_MAP_ENTRIES(m) \
> +	((__u32)(sizeof(*(m)->max_entries) / sizeof(**(m)->max_entries)))
> +
> +#ifndef bpf_tail_call_static
> +#define bpf_tail_call_static(ctx, map, slot)				      \
> +({									      \
> +	/* wrapped to avoid double evaluation. */                             \
> +	const __u32 __slot = (slot);                                          \
> +	__bpf_tail_call_warn(__slot >= BPF_MAP_ENTRIES(map));                 \
> +	/* Avoid re-expand & invoke original as (bpf_tail_call_static)(..) */ \
> +	(bpf_tail_call_static)(ctx, map, __slot);                             \
> +})
> +#endif /* bpf_tail_call_static */
> +#endif

I got the following error with llvm21.

progs/tailcall_bpf2bpf3.c:20:3: error: bpf_tail_call: slot >= max_entries [-Werror,-Wuser-defined-warnings]
    20 |                 bpf_tail_call_static(skb, &jmp_table,progs/tailcall_bpf2bpf2.c:17:3 10);
       | :                ^
  /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:190:53: note: expanded from macro
       'bpf_tail_call_static'
   190 |         __bpf_tail_call_warn(__slot >= BPF_MAP_ENTRIES(map));                 \
       |                                                            ^
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:179:17: note: from 'diagnose_if'
       attribute on '__bpf_tail_call_warn':
   179 |         __attribute__((diagnose_if(oob, "bpf_tail_call: slot >= max_entries",
       |                        ^           ~~~
error: bpf_tail_call: slot >= max_entries [-Werror,-Wuser-defined-warnings]
    17 |                 bpf_tail_call_static(skb, &jmp_table, 1);
       |                 ^
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:190:53: note: expanded from macro
       'bpf_tail_call_static'
   190 |         __bpf_tail_call_warn(__slot >= BPF_MAP_ENTRIES(map));                 \
       |                                                            ^
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:179:17: note: from 'diagnose_if'
       attribute on '__bpf_tail_call_warn':
   179 |         __attribute__((diagnose_if(oob, "bpf_tail_call: slot >= max_entries",
       |                        ^           ~~~
   CLNG-BPF [test_progs] tailcall_poke.bpf.o
1 error generated.
make: *** [Makefile:733: /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tailcall_bpf2bpf3.bpf.o] Error 1

> +
>   #endif
>   #endif
>
> --
> 2.51.0


