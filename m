Return-Path: <bpf+bounces-21663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DE185009E
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 00:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC4BB24F46
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 23:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C99374C6;
	Fri,  9 Feb 2024 23:14:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584E219E4
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707520480; cv=none; b=lfH3r8CnIUNH/6LS/s8XydP4XVfAPsefY14ZWoQrnhiIrjMWcKMVIitCldQhnwS5UGO7yzWfZ7zlutiSQkQ7qB6CGef1aILIkkFDFFQbx0IYpXMODjtXurSTPJGIjjT4Mm2a32ganka+wNHavZayrDXYZzSODDN2sTaWV7pfA1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707520480; c=relaxed/simple;
	bh=CiWZkPv1CK4uBEASs68WpCQk029xDKVsIYFq7rytJ8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACOdUgPz0u40pbYcEv9PWEkT+RcRkautCgXQZ7mr6GtoIyX02Csb+waHyiJfLLXn1Sr+0d7J5n5Ja+IuGPl5Q5UYJ6XYFZZr3hfVYYnWUMjRr0U4v5uaafT9LZI4N4p1cjMS3koZhWeNspEbWCMV83Gllqv2u1+Sr6Pv8cJPA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bfdd9fa13eso770812b6e.1
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 15:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707520477; x=1708125277;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRPj+jysUNcaTqxrb9blVKYV08fOWVEOBJPFpCCyyAQ=;
        b=uxGpgo1ZSiypZCrfNrpLj7CTCtfImvz/zOk6mzir4mwe9BIKiHvYvoVa1F0ZLYzfQu
         5xGZ5rPiqRTnOjmaFMML/4IASJ4Sytz/oJ3f1kyQxAANo2mcr85pW53/NeqeOL3IhXgN
         pFrNAtXEa+IIrvAJO9cjqTRAG35TSxS4ysYPJH8VtgBTymFXdilCe2FyBUUctMp1ykDj
         lvLlLwLcpNdYBa221v/hyRDN2NCKzOwCZJY3K2pCV1Zjh4N/IIPBCFMlxQUD3DBlrKZo
         Ugb+JBKvY64LNys8i/IPy7NeSEFBsCt95hd+XmX1OB8vgctOESuO5mFAIK50skApUSjO
         r+Xg==
X-Gm-Message-State: AOJu0Yxlfmy77fReKsWT7dJRvftO9sBcqWrM26lFenp6qWZdXPsjCKbb
	a/aKz/RNmXZ046+9+2hy9trCrGyaw0j72ISpKyLrM0+ljl/q7bp3
X-Google-Smtp-Source: AGHT+IGdE53EhunSk/Cv0mEfpIYVJZ1Kx2cabFyRtVSFQtVa7WI2F3wVrXIBAzYPRAHW6QZL9KTjYA==
X-Received: by 2002:a05:6808:120d:b0:3be:7321:a572 with SMTP id a13-20020a056808120d00b003be7321a572mr605967oil.17.1707520477059;
        Fri, 09 Feb 2024 15:14:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnR6nkcTCpefaah5HaxdXcY3wQGZhioualvKVIK90tIuAyUb3YpheIBr55/7AUSMMT4p9XcLWgSWyoOnJHlGxUMHhCTBVtZPFnFmYIE5QLJ3wuSS0C2oh9EEoQ1mww06UL+lUhuJv2stBzQ8mqrxsrN4UFzWVH8TNkeeLSIif9AEhsiE5NK8uGyFs4wJniZPfGkgfz2noJzfBFLsaT75ZSsrp/wUW7cNt++jJV6c8DYuyTG9Vxvu+Q89q42vubLc/4QfIkluHsStcACtLuMebPB8CgWeyTA7dAIKyMaSAX6YIuAwXZDKaUqmI/anhGpBlqnz6Vml0MKjtoH5BMWzGzhkWmuzCwR6GP6o4nug5GKM0cXyWx8/BYsCzBKdtn7qghOrPE+VkObeY39kE=
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id ay20-20020a05620a179400b007855f767745sm163291qkb.73.2024.02.09.15.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 15:14:36 -0800 (PST)
Date: Fri, 9 Feb 2024 17:14:33 -0600
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, brho@google.com,
	hannes@cmpxchg.org, lstoakes@gmail.com, akpm@linux-foundation.org,
	urezki@gmail.com, hch@infradead.org, linux-mm@kvack.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 17/20] selftests/bpf: Add unit tests for
 bpf_arena_alloc/free_pages
Message-ID: <20240209231433.GE975217@maniforge.lan>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-18-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2B/LGZNqLS+Y8GQz"
Content-Disposition: inline
In-Reply-To: <20240209040608.98927-18-alexei.starovoitov@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--2B/LGZNqLS+Y8GQz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 08:06:05PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Add unit tests for bpf_arena_alloc/free_pages() functionality
> and bpf_arena_common.h with a set of common helpers and macros that
> is used in this test and the following patches.
>=20
> Also modify test_loader that didn't support running bpf_prog_type_syscall
> programs.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
>  tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
>  .../testing/selftests/bpf/bpf_arena_common.h  | 70 ++++++++++++++
>  .../selftests/bpf/prog_tests/verifier.c       |  2 +
>  .../selftests/bpf/progs/verifier_arena.c      | 91 +++++++++++++++++++
>  tools/testing/selftests/bpf/test_loader.c     |  9 +-
>  6 files changed, 172 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/bpf_arena_common.h
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena.c
>=20
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing=
/selftests/bpf/DENYLIST.aarch64
> index 5c2cc7e8c5d0..8e70af386e52 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -11,3 +11,4 @@ fill_link_info/kprobe_multi_link_info            # bpf_=
program__attach_kprobe_mu
>  fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_k=
probe_multi_opts unexpected error: -95
>  fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_k=
probe_multi_opts unexpected error: -95
>  missed/kprobe_recursion                          # missed_kprobe_recursi=
on__attach unexpected error: -95 (errno 95)
> +verifier_arena                                   # JIT does not support =
arena
> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/s=
elftests/bpf/DENYLIST.s390x
> index 1a63996c0304..ded440277f6e 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> @@ -3,3 +3,4 @@
>  exceptions				 # JIT does not support calling kfunc bpf_throw				       =
(exceptions)
>  get_stack_raw_tp                         # user_stack corrupted user sta=
ck                                             (no backchain userspace)
>  stacktrace_build_id                      # compare_map_keys stackid_hmap=
 vs. stackmap err -2 errno 2                   (?)
> +verifier_arena                           # JIT does not support arena
> diff --git a/tools/testing/selftests/bpf/bpf_arena_common.h b/tools/testi=
ng/selftests/bpf/bpf_arena_common.h
> new file mode 100644
> index 000000000000..07849d502f40
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpf_arena_common.h
> @@ -0,0 +1,70 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +#pragma once
> +
> +#ifndef WRITE_ONCE
> +#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *) &(x)) =3D (val))
> +#endif
> +
> +#ifndef NUMA_NO_NODE
> +#define	NUMA_NO_NODE	(-1)
> +#endif
> +
> +#ifndef arena_container_of

Why is this ifndef required if we have a pragma once above?

> +#define arena_container_of(ptr, type, member)			\
> +	({							\
> +		void __arena *__mptr =3D (void __arena *)(ptr);	\
> +		((type *)(__mptr - offsetof(type, member)));	\
> +	})
> +#endif
> +
> +#ifdef __BPF__ /* when compiled as bpf program */
> +
> +#ifndef PAGE_SIZE
> +#define PAGE_SIZE __PAGE_SIZE
> +/*
> + * for older kernels try sizeof(struct genradix_node)
> + * or flexible:
> + * static inline long __bpf_page_size(void) {
> + *   return bpf_core_enum_value(enum page_size_enum___l, __PAGE_SIZE___l=
) ?: sizeof(struct genradix_node);
> + * }
> + * but generated code is not great.
> + */
> +#endif
> +
> +#if defined(__BPF_FEATURE_ARENA_CAST) && !defined(BPF_ARENA_FORCE_ASM)
> +#define __arena __attribute__((address_space(1)))
> +#define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
> +#define cast_user(ptr) /* nop for bpf prog. emitted by LLVM */
> +#else
> +#define __arena
> +#define cast_kern(ptr) bpf_arena_cast(ptr, BPF_ARENA_CAST_KERN, 1)
> +#define cast_user(ptr) bpf_arena_cast(ptr, BPF_ARENA_CAST_USER, 1)
> +#endif
> +
> +void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __u32=
 page_cnt,
> +				    int node_id, __u64 flags) __ksym __weak;
> +void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt) =
__ksym __weak;
> +
> +#else /* when compiled as user space code */
> +
> +#define __arena
> +#define __arg_arena
> +#define cast_kern(ptr) /* nop for user space */
> +#define cast_user(ptr) /* nop for user space */
> +__weak char arena[1];
> +
> +#ifndef offsetof
> +#define offsetof(type, member)  ((unsigned long)&((type *)0)->member)
> +#endif
> +
> +static inline void __arena* bpf_arena_alloc_pages(void *map, void *addr,=
 __u32 page_cnt,
> +						  int node_id, __u64 flags)
> +{
> +	return NULL;
> +}
> +static inline void bpf_arena_free_pages(void *map, void __arena *ptr, __=
u32 page_cnt)
> +{
> +}
> +
> +#endif
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index 9c6072a19745..985273832f89 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -4,6 +4,7 @@
> =20
>  #include "cap_helpers.h"
>  #include "verifier_and.skel.h"
> +#include "verifier_arena.skel.h"
>  #include "verifier_array_access.skel.h"
>  #include "verifier_basic_stack.skel.h"
>  #include "verifier_bitfield_write.skel.h"
> @@ -118,6 +119,7 @@ static void run_tests_aux(const char *skel_name,
>  #define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
> =20
>  void test_verifier_and(void)                  { RUN(verifier_and); }
> +void test_verifier_arena(void)                { RUN(verifier_arena); }
>  void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack=
); }
>  void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_wr=
ite); }
>  void test_verifier_bounds(void)               { RUN(verifier_bounds); }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/t=
esting/selftests/bpf/progs/verifier_arena.c
> new file mode 100644
> index 000000000000..0e667132ef92
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +#include "bpf_experimental.h"
> +#include "bpf_arena_common.h"
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARENA);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +	__uint(max_entries, 2); /* arena of two pages close to 32-bit boundary*/
> +	__ulong(map_extra, (1ull << 44) | (~0u - __PAGE_SIZE * 2 + 1)); /* star=
t of mmap() region */
> +} arena SEC(".maps");
> +
> +SEC("syscall")
> +__success __retval(0)
> +int basic_alloc1(void *ctx)
> +{
> +	volatile int __arena *page1, *page2, *no_page, *page3;
> +
> +	page1 =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	if (!page1)
> +		return 1;
> +	*page1 =3D 1;
> +	page2 =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	if (!page2)
> +		return 2;
> +	*page2 =3D 2;
> +	no_page =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	if (no_page)
> +		return 3;
> +	if (*page1 !=3D 1)
> +		return 4;
> +	if (*page2 !=3D 2)
> +		return 5;
> +	bpf_arena_free_pages(&arena, (void __arena *)page2, 1);
> +	if (*page1 !=3D 1)
> +		return 6;
> +	if (*page2 !=3D 0) /* use-after-free should return 0 */

So I know that longer term the plan is to leverage exceptions and have
us exit and unwind the program here, but I think it's somewhat important
to underscore how significant of a usability improvement that will be.
Reading 0 isn't terribly uncommon for typical scheduling use cases. For
example, if we stored a set of cpumasks in arena pages, we may AND them
together and not be concerned if there are no CPUs set as that would be
a perfectly normal state. E.g. if we're using arena cpumasks to track
idle cores and a task's allowed CPUs, and we AND them together and see
0.  We'd just assume there were no idle cores available on the system.
Another example would be scx_nest where we would incorrectly think that
a nest didn't have enough cores, seeing if a task could run in a domain,
etc.

Obviously it's way better for us to actually have arenas in the interim
so this is fine for now, but UAF bugs could potentially be pretty
painful until we get proper exception unwinding support.

Otherwise, in terms of usability, this looks really good. The only thing
to bear in mind is that I don't think we can fully get away from kptrs
that will have some duplicated logic compared to what we can enable in
an arena. For example, we will have to retain at least some of the
struct cpumask * kptrs for e.g. copying a struct task_struct's struct
cpumask *cpus_ptr field.

For now, we could iterate over the cpumask and manually set the bits, so
maybe even just supporting bpf_cpumask_test_cpu() would be enough
(though donig a bitmap_copy() would be better of course)? This is
probably fine for most use cases as we'd likely only be doing struct
cpumask * -> arena copies on slowpaths. But is there any kind of more
generalized integration we want to have between arenas and kptrs?  Not
sure, can't think of any off the top of my head.

> +		return 7;
> +	page3 =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	if (!page3)
> +		return 8;
> +	*page3 =3D 3;
> +	if (page2 !=3D page3)
> +		return 9;
> +	if (*page1 !=3D 1)
> +		return 10;

Should we also test doing a store after an arena has been freed?

> +	return 0;
> +}

--2B/LGZNqLS+Y8GQz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcax2QAKCRBZ5LhpZcTz
ZJG4AQCkFmA10tQnMrnqflB6zJBOlBX2iv7ItVv/DeUYUUP9mQD/Qdq98ieEmfwz
GeHNlL4FND0GdDv7KsduwHLwznGtRAY=
=NPrb
-----END PGP SIGNATURE-----

--2B/LGZNqLS+Y8GQz--

