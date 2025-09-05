Return-Path: <bpf+bounces-67529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C2AB44C8A
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 06:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3958F7AB563
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 03:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3DA221265;
	Fri,  5 Sep 2025 04:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r4/2gz2F"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80091684B4
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 04:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757044858; cv=none; b=RY5WajR2HfQYmQFZ4/HXWwQa9rUaUKStKwp2hpUF6VIGHMZe9evjO2HH1ryyvcV3HE+pFQUWu28Qwgh3RT2IGpcK9qELW+US0jerXQ6JZeFDAca4X24re4tQxt+LViQwbH5vE1Tsqq0/2X+GK6Ps6hq0CvGGzr/1IoPoegV/XVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757044858; c=relaxed/simple;
	bh=rLaqlph0538ajH36AIEbPc/SPTncMLcESZo0Bgf6XgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUOf8s6eJLyqoOmB1hm5InibnDsGvDYsMnRoFl297DZE0GBQuWpikjYWb0gNDJNW+pDZRr4+wl2ajyPg1dQ1aJ4uOlPu5tZT+M8gQg3bYE/493QL+WGUbL74SWB3TImgEiv65w/ctnSU9cNu42g4cekV5fe8/XDALYwgaMiSJxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r4/2gz2F; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6b52caf8-51f0-45ed-8f59-11f24dd2861e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757044852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xU4WiHHqDbAwz19vt8XJQJ1JAgeIb0EHNdRyJYIcNnw=;
	b=r4/2gz2FDcv4CZMR9YY/B2P6q/X5hJ1+gOJZfwzKQAE/DHa/BQd7plMzDAumvl6o9piLwI
	vz5dSpNo1DHizUdQaJIXDY9mppn/bavc1UjkTm77TBq+TIcMDxqx/3clpOMtC3Eou/N8G7
	JTN/ZOuBtsYTNxZBtK0zXZO2mr5Sil8=
Date: Thu, 4 Sep 2025 21:00:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next 1/1] libbpf: add compile-time OOB warning to
 bpf_tail_call_static
Content-Language: en-GB
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
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
References: <20250905025314.245650-1-hoyeon.lee@suse.com>
 <20250905025314.245650-2-hoyeon.lee@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250905025314.245650-2-hoyeon.lee@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 9/4/25 7:53 PM, Hoyeon Lee wrote:
> Add a compile-time check to bpf_tail_call_static() to warn when a
> constant slot(index) is >= map->max_entries. This uses a small
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
> Out-of-bounds tail call checkup is no-ops at runtime. Emitting a
> compile-time warning can help developers detect mistakes earlier. The
> check is currently limited to Clang (due to diagnose_if) and constant
> indices, but should catch common errors.
>
> Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> ---
>   tools/lib/bpf/bpf_helpers.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 80c028540656..0d9551bb90c0 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -173,6 +173,26 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>   		     :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
>   		     : "r0", "r1", "r2", "r3", "r4", "r5");
>   }
> +
> +#if __has_attribute(diagnose_if)
> +static __always_inline void __bpf_tail_call_warn(int oob)
> +	__attribute__((diagnose_if(oob, "bpf_tail_call: slot >= max_entries", "warning")));
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
> +
>   #endif
>   #endif

I got compilation failures with llvm21.

In file included from progs/bpf_flow.c:19:
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:178:29: error: function '__bpf_tail_call_warn' has internal
       linkage but is not defined [-Werror,-Wundefined-internal]
   178 | static __always_inline void __bpf_tail_call_warn(int oob)
       |   CLNG-BPF [test_progs] btf_type_tag_percpu.bpf.o
                             ^
progs/bpf_flow.c:122:3: note: used here
   122 |                 bpf_tail_call_static(skb, &jmp_table, IP);
       |                 ^
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:189:2: note: expanded from macro 'bpf_tail_call_static'
   189 |         __bpf_tail_c  CLNG-BPF [test_progs] btf_type_tag_user.bpf.o
all_warn(__slot >= BPF_MAP_ENTRIES(map));             CLNG-BPF [test_progs] cb_refs.bpf.o
       \
       |         ^


>
> --
> 2.51.0


