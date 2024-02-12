Return-Path: <bpf+bounces-21772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E649851EED
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530861C21DAC
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 20:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E0B4CB3D;
	Mon, 12 Feb 2024 20:53:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B424C63D
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707771201; cv=none; b=c6yBathqNd++AOCoRViSZqDWNdEFhXp8rEIH0S64lQxC7tPhH1U0jUP8VlCm6+4M5agd7auphAP+4qS9/XWBtLKc9sJNR/vsNrd5ElUtA02L5UKqCipK1rHNM+4FKif9DmaZTCXINC8kVQZfNMJ6pZ/92BEix3jeFmqE1sDjyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707771201; c=relaxed/simple;
	bh=SSrGC0GB0cn1kLz/tZW59U5Q8UugZG2T2Vx4qxyj/Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMpK9AOLFDBBOsAKIuzWQku/8gWocRhsaZYgu6WGNHtRaXxsRNG1W2ugBfAb0OlOv+wN1SCbk4CNmY2VCWix/ptYPWGRFQNjnW1Y5LGkmmv8XUH9HWk5y6rgdDe/bFxeELQq0r8q3Zvsdvf8sEJFteJ9+n9hsuKT8Hg/uEHtryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68c2f4c3282so17521776d6.3
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 12:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707771197; x=1708375997;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCh+LpAxDje7B7msspWV1zLjdJ82yVqcHvv+2BsZFMA=;
        b=UEe7eJnJV4TM9ZMMsK84B2rvWIqt9XuevXeEhlfy8OmUHJtqvWojmRYXoGVRU18fqh
         9xL3bzkP2az3kwN82QwkaEbkAdLRcfn/QkScVfM91u8qkCdmSsO0W+Bu6ly55EkHKWrD
         bwf2ri5OtIZMKAlmGwifccMducklwjvPEpmOUely75rxvDA7c1oSQMFV08Yl+gXiMzaZ
         zGS7UVQ6HK2V67bMLhYH41a5YCSC/64qCLIHhJcvAuOnmnl06NTa9UE9kj9+miRs9hb/
         dsfWK301YPDWyvOzyddzIjyhdK13wkd6ipHhRRCzlS/ax9SBZihsRQouR0R1/PdDnioT
         1wOw==
X-Gm-Message-State: AOJu0YyEC1KBhKIKdTYMrVIMQmLcq1N8L6N0erRRr47l5msJBJ9/5Yo8
	o++bw78RRKntdthakvT1JUukXY6PCSlJzRsjs5CaqT/bnN5USrxh
X-Google-Smtp-Source: AGHT+IEe9+1b4xy06KiDQdvJIIhodE8DE59KiK3PMAUb/Wdzz/KjZ3MHPFaFhPE2csxeYy+4E84F9g==
X-Received: by 2002:a0c:e309:0:b0:68c:c057:8a07 with SMTP id s9-20020a0ce309000000b0068cc0578a07mr7168840qvl.18.1707771197155;
        Mon, 12 Feb 2024 12:53:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFkwPOC7wkhS4X2O0cE7Hv8RiWo1RFg7s08oJ6qQNtal+4DxHR+cjkxfONUWOQOgi0zeinHdPiH5dPDQ7Z5aJbj28/gfKdGA5NBa98KLzTPUVC7amLQGfBvkLECpn22ldrNuwL+biMihv+6tOIV+t1CyCKGCIqILm0hrhujSWZRe/xRtpL1ScFL0h3XLVcITuVUmESzrZWUaShISZgC2a+kyNfTI4wDoS6AHYVSeepd3cKqmhXunDTAQ4IbwZ5XPKHGVo0L3kfMEZmUPWy0xC4ib9SRQzLPOQt0IKNCg==
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id or32-20020a05621446a000b0068c9086c4d2sm540944qvb.10.2024.02.12.12.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 12:53:16 -0800 (PST)
Date: Mon, 12 Feb 2024 14:53:14 -0600
From: David Vernet <void@manifault.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>,
	Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>,
	Rishabh Iyer <rishabh.iyer@epfl.ch>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: Re: [RFC PATCH v1 14/14] selftests/bpf: Add tests for exceptions
 runtime cleanup
Message-ID: <20240212205314.GC2200361@maniforge.lan>
References: <20240201042109.1150490-1-memxor@gmail.com>
 <20240201042109.1150490-15-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pvx2Q3781o2xIZn/"
Content-Disposition: inline
In-Reply-To: <20240201042109.1150490-15-memxor@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--Pvx2Q3781o2xIZn/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 04:21:09AM +0000, Kumar Kartikeya Dwivedi wrote:
> Add tests for the runtime cleanup support for exceptions, ensuring that
> resources are correctly identified and released when an exception is
> thrown. Also, we add negative tests to exercise corner cases the
> verifier should reject.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
>  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
>  .../bpf/prog_tests/exceptions_cleanup.c       |  65 +++
>  .../selftests/bpf/progs/exceptions_cleanup.c  | 468 ++++++++++++++++++
>  .../bpf/progs/exceptions_cleanup_fail.c       | 154 ++++++
>  .../selftests/bpf/progs/exceptions_fail.c     |  13 -
>  6 files changed, 689 insertions(+), 13 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions_cle=
anup.c
>  create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup.c
>  create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
fail.c
>=20
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing=
/selftests/bpf/DENYLIST.aarch64
> index 5c2cc7e8c5d0..6fc79727cd14 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -1,6 +1,7 @@
>  bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api=
_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
>  bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api=
_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
>  exceptions					 # JIT does not support calling kfunc bpf_throw: -524
> +exceptions_unwind				 # JIT does not support calling kfunc bpf_throw: -5=
24
>  fexit_sleep                                      # The test never return=
s. The remaining tests cannot start.
>  kprobe_multi_bench_attach                        # needs CONFIG_FPROBE
>  kprobe_multi_test                                # needs CONFIG_FPROBE
> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/s=
elftests/bpf/DENYLIST.s390x
> index 1a63996c0304..f09a73dee72c 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> @@ -1,5 +1,6 @@
>  # TEMPORARY
>  # Alphabetical order
>  exceptions				 # JIT does not support calling kfunc bpf_throw				       =
(exceptions)
> +exceptions_unwind			 # JIT does not support calling kfunc bpf_throw				 =
      (exceptions)
>  get_stack_raw_tp                         # user_stack corrupted user sta=
ck                                             (no backchain userspace)
>  stacktrace_build_id                      # compare_map_keys stackid_hmap=
 vs. stackmap err -2 errno 2                   (?)
> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c =
b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> new file mode 100644
> index 000000000000..78df037b60ea
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> @@ -0,0 +1,65 @@
> +#include "bpf/bpf.h"
> +#include "exceptions.skel.h"
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +
> +#include "exceptions_cleanup.skel.h"
> +#include "exceptions_cleanup_fail.skel.h"
> +
> +static void test_exceptions_cleanup_fail(void)
> +{
> +	RUN_TESTS(exceptions_cleanup_fail);
> +}
> +
> +void test_exceptions_cleanup(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, ropts,
> +		.data_in =3D &pkt_v4,
> +		.data_size_in =3D sizeof(pkt_v4),
> +		.repeat =3D 1,
> +	);
> +	struct exceptions_cleanup *skel;
> +	int ret;
> +
> +	if (test__start_subtest("exceptions_cleanup_fail"))
> +		test_exceptions_cleanup_fail();

RUN_TESTS takes care of doing test__start_subtest(), etc. You should be
able to just call RUN_TESTS(exceptions_cleanup_fail) directly here.

> +
> +	skel =3D exceptions_cleanup__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "exceptions_cleanup__open_and_load"))
> +		return;
> +
> +	ret =3D exceptions_cleanup__attach(skel);
> +	if (!ASSERT_OK(ret, "exceptions_cleanup__attach"))
> +		return;
> +
> +#define RUN_EXC_CLEANUP_TEST(name)                                      \

Should we add a call to if (test__start_subtest(#name)) to this macro?

> +	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.name), \
> +				     &ropts);                           \
> +	if (!ASSERT_OK(ret, #name ": return value"))                    \
> +		return;                                                 \
> +	if (!ASSERT_EQ(ropts.retval, 0xeB9F, #name ": opts.retval"))    \
> +		return;                                                 \
> +	ret =3D bpf_prog_test_run_opts(                                   \
> +		bpf_program__fd(skel->progs.exceptions_cleanup_check),  \
> +		&ropts);                                                \
> +	if (!ASSERT_OK(ret, #name " CHECK: return value"))              \
> +		return;                                                 \
> +	if (!ASSERT_EQ(ropts.retval, 0, #name " CHECK: opts.retval"))   \
> +		return;													\
> +	skel->bss->only_count =3D 0;
> +
> +	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_prog_num_iter);
> +	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_prog_num_iter_mult);
> +	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_prog_dynptr_iter);
> +	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_obj);
> +	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_percpu_obj);
> +	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_ringbuf);
> +	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_reg);
> +	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_null_or_ptr_do_ptr);
> +	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_null_or_ptr_do_null);
> +	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_callee_saved);
> +	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_frame);
> +	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_loop_iterations);
> +	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_dead_code_elim);
> +	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_frame_dce);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c b/too=
ls/testing/selftests/bpf/progs/exceptions_cleanup.c
> new file mode 100644
> index 000000000000..ccf14fe6bd1b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
> @@ -0,0 +1,468 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +#include <bpf/bpf_endian.h>
> +#include "bpf_misc.h"
> +#include "bpf_kfuncs.h"
> +#include "bpf_experimental.h"
> +
> +struct {
> +    __uint(type, BPF_MAP_TYPE_RINGBUF);
> +    __uint(max_entries, 8);
> +} ringbuf SEC(".maps");
> +
> +enum {
> +    RES_DYNPTR,
> +    RES_ITER,
> +    RES_REG,
> +    RES_SPILL,
> +    __RES_MAX,
> +};
> +
> +struct bpf_resource {
> +    int type;
> +};
> +
> +struct {
> +    __uint(type, BPF_MAP_TYPE_HASH);
> +    __uint(max_entries, 1024);
> +    __type(key, int);
> +    __type(value, struct bpf_resource);
> +} hashmap SEC(".maps");
> +
> +const volatile bool always_false =3D false;
> +bool only_count =3D false;
> +int res_count =3D 0;
> +
> +#define MARK_RESOURCE(ptr, type) ({ res_count++; bpf_map_update_elem(&ha=
shmap, &(void *){ptr}, &(struct bpf_resource){type}, 0); });
> +#define FIND_RESOURCE(ptr) ((struct bpf_resource *)bpf_map_lookup_elem(&=
hashmap, &(void *){ptr}) ?: &(struct bpf_resource){__RES_MAX})
> +#define FREE_RESOURCE(ptr) bpf_map_delete_elem(&hashmap, &(void *){ptr})
> +#define VAL 0xeB9F
> +
> +SEC("fentry/bpf_cleanup_resource")
> +int BPF_PROG(exception_cleanup_mark_free, struct bpf_frame_desc_reg_entr=
y *fd, void *ptr)
> +{
> +    if (fd->spill_type =3D=3D STACK_INVALID)
> +        bpf_probe_read_kernel(&ptr, sizeof(ptr), ptr);
> +    if (only_count) {
> +        res_count--;
> +        return 0;
> +    }
> +    switch (fd->spill_type) {
> +    case STACK_SPILL:
> +        if (FIND_RESOURCE(ptr)->type =3D=3D RES_SPILL)
> +            FREE_RESOURCE(ptr);
> +        break;
> +    case STACK_INVALID:
> +        if (FIND_RESOURCE(ptr)->type =3D=3D RES_REG)
> +            FREE_RESOURCE(ptr);
> +        break;
> +    case STACK_ITER:
> +        if (FIND_RESOURCE(ptr)->type =3D=3D RES_ITER)
> +            FREE_RESOURCE(ptr);
> +        break;
> +    case STACK_DYNPTR:
> +        if (FIND_RESOURCE(ptr)->type =3D=3D RES_DYNPTR)
> +            FREE_RESOURCE(ptr);
> +        break;
> +    }
> +    return 0;
> +}
> +
> +static long map_cb(struct bpf_map *map, void *key, void *value, void *ct=
x)
> +{
> +    int *cnt =3D ctx;
> +
> +    (*cnt)++;
> +    return 0;
> +}
> +
> +SEC("tc")
> +int exceptions_cleanup_check(struct __sk_buff *ctx)
> +{
> +    int cnt =3D 0;
> +
> +    if (only_count)
> +        return res_count;
> +    bpf_for_each_map_elem(&hashmap, map_cb, &cnt, 0);
> +    return cnt;
> +}
> +
> +SEC("tc")
> +int exceptions_cleanup_prog_num_iter(struct __sk_buff *ctx)
> +{
> +    int i;
> +
> +    bpf_for(i, 0, 10) {
> +        MARK_RESOURCE(&___it, RES_ITER);
> +        bpf_throw(VAL);
> +    }
> +    return 0;
> +}
> +
> +SEC("tc")
> +int exceptions_cleanup_prog_num_iter_mult(struct __sk_buff *ctx)
> +{
> +    int i, j, k;
> +
> +    bpf_for(i, 0, 10) {
> +        MARK_RESOURCE(&___it, RES_ITER);
> +        bpf_for(j, 0, 10) {
> +            MARK_RESOURCE(&___it, RES_ITER);
> +            bpf_for(k, 0, 10) {
> +                MARK_RESOURCE(&___it, RES_ITER);
> +                bpf_throw(VAL);
> +            }
> +        }
> +    }
> +    return 0;
> +}
> +
> +__noinline
> +static int exceptions_cleanup_subprog(struct __sk_buff *ctx)
> +{
> +    int i;
> +
> +    bpf_for(i, 0, 10) {
> +        MARK_RESOURCE(&___it, RES_ITER);
> +        bpf_throw(VAL);
> +    }
> +    return ctx->len;
> +}
> +
> +SEC("tc")
> +int exceptions_cleanup_prog_dynptr_iter(struct __sk_buff *ctx)
> +{
> +    struct bpf_dynptr rbuf;
> +    int ret =3D 0;
> +
> +    bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, &rbuf);
> +    MARK_RESOURCE(&rbuf, RES_DYNPTR);
> +    if (ctx->protocol)
> +        ret =3D exceptions_cleanup_subprog(ctx);
> +    bpf_ringbuf_discard_dynptr(&rbuf, 0);
> +    return ret;
> +}
> +
> +SEC("tc")
> +int exceptions_cleanup_obj(struct __sk_buff *ctx)
> +{
> +    struct { int i; } *p;
> +
> +    p =3D bpf_obj_new(typeof(*p));
> +    MARK_RESOURCE(&p, RES_SPILL);
> +    bpf_throw(VAL);
> +    return p->i;
> +}
> +
> +SEC("tc")
> +int exceptions_cleanup_percpu_obj(struct __sk_buff *ctx)
> +{
> +    struct { int i; } *p;
> +
> +    p =3D bpf_percpu_obj_new(typeof(*p));
> +    MARK_RESOURCE(&p, RES_SPILL);
> +    bpf_throw(VAL);

It would be neat if we could have the bpf_throw() kfunc signature be
marked as __attribute__((noreturn)) and have things work correctly;
meaning you wouldn't have to even return a value here. The verifier
should know that bpf_throw() is terminal, so it should be able to prune
any subsequent instructions as unreachable anyways.

> +    return !p;
> +}
> +
> +SEC("tc")
> +int exceptions_cleanup_ringbuf(struct __sk_buff *ctx)
> +{
> +    void *p;
> +
> +    p =3D bpf_ringbuf_reserve(&ringbuf, 8, 0);
> +    MARK_RESOURCE(&p, RES_SPILL);
> +    bpf_throw(VAL);
> +    return 0;
> +}
> +
> +SEC("tc")
> +int exceptions_cleanup_reg(struct __sk_buff *ctx)
> +{
> +    void *p;
> +
> +    p =3D bpf_ringbuf_reserve(&ringbuf, 8, 0);
> +    MARK_RESOURCE(p, RES_REG);
> +    bpf_throw(VAL);
> +    if (p)
> +        bpf_ringbuf_discard(p, 0);

Does the prog fail to load if you don't have this bpf_ringbuf_discard()
check? I assume not given that in
exceptions_cleanup_null_or_ptr_do_ptr() and elsewhere we do a reserve
without discarding. Is there some subtle stack state difference here or
something?

> +    return 0;
> +}
> +
> +SEC("tc")
> +int exceptions_cleanup_null_or_ptr_do_ptr(struct __sk_buff *ctx)
> +{
> +    union {
> +        void *p;
> +        char buf[8];
> +    } volatile p;
> +    u64 z =3D 0;
> +
> +    __builtin_memcpy((void *)&p.p, &z, sizeof(z));
> +    MARK_RESOURCE((void *)&p.p, RES_SPILL);
> +    if (ctx->len)
> +        p.p =3D bpf_ringbuf_reserve(&ringbuf, 8, 0);
> +    bpf_throw(VAL);
> +    return 0;
> +}
> +
> +SEC("tc")
> +int exceptions_cleanup_null_or_ptr_do_null(struct __sk_buff *ctx)
> +{
> +    union {
> +        void *p;
> +        char buf[8];
> +    } volatile p;
> +
> +    p.p =3D 0;
> +    MARK_RESOURCE((void *)p.buf, RES_SPILL);
> +    if (!ctx->len)
> +        p.p =3D bpf_ringbuf_reserve(&ringbuf, 8, 0);
> +    bpf_throw(VAL);
> +    return 0;
> +}
> +
> +__noinline static int mark_resource_subprog(u64 a, u64 b, u64 c, u64 d)
> +{
> +    MARK_RESOURCE((void *)a, RES_REG);
> +    MARK_RESOURCE((void *)b, RES_REG);
> +    MARK_RESOURCE((void *)c, RES_REG);
> +    MARK_RESOURCE((void *)d, RES_REG);
> +    return 0;
> +}
> +
> +SEC("tc")
> +int exceptions_cleanup_callee_saved(struct __sk_buff *ctx)
> +{
> +    asm volatile (
> +       "r1 =3D %[ringbuf] ll;             \
> +        r2 =3D 8;                         \
> +        r3 =3D 0;                         \
> +        call %[bpf_ringbuf_reserve];    \
> +        r6 =3D r0;                        \
> +        r1 =3D %[ringbuf] ll;             \
> +        r2 =3D 8;                         \
> +        r3 =3D 0;                         \
> +        call %[bpf_ringbuf_reserve];    \
> +        r7 =3D r0;                        \
> +        r1 =3D %[ringbuf] ll;             \
> +        r2 =3D 8;                         \
> +        r3 =3D 0;                         \
> +        call %[bpf_ringbuf_reserve];    \
> +        r8 =3D r0;                        \
> +        r1 =3D %[ringbuf] ll;             \
> +        r2 =3D 8;                         \
> +        r3 =3D 0;                         \
> +        call %[bpf_ringbuf_reserve];    \
> +        r9 =3D r0;                        \
> +        r1 =3D r6;                        \
> +        r2 =3D r7;                        \
> +        r3 =3D r8;                        \
> +        r4 =3D r9;                        \
> +        call mark_resource_subprog;     \
> +        r1 =3D 0xeB9F;                    \
> +        call bpf_throw;                 \
> +    " : : __imm(bpf_ringbuf_reserve),
> +          __imm_addr(ringbuf)
> +      : __clobber_all);
> +    mark_resource_subprog(0, 0, 0, 0);
> +    return 0;
> +}
> +
> +SEC("tc")
> +int exceptions_cleanup_callee_saved_noopt(struct __sk_buff *ctx)
> +{
> +    mark_resource_subprog(1, 2, 3, 4);
> +    return 0;
> +}
> +
> +__noinline int global_subprog_throw(struct __sk_buff *ctx)
> +{
> +    u64 *p =3D bpf_ringbuf_reserve(&ringbuf, 8, 0);
> +    bpf_throw(VAL);
> +    return p ? *p : 0 + ctx->len;
> +}
> +
> +__noinline int global_subprog(struct __sk_buff *ctx)
> +{
> +    u64 *p =3D bpf_ringbuf_reserve(&ringbuf, 8, 0);
> +    if (!p)
> +        return ctx->len;
> +    global_subprog_throw(ctx);
> +    bpf_ringbuf_discard(p, 0);
> +    return !!p + ctx->len;
> +}
> +
> +__noinline static int static_subprog(struct __sk_buff *ctx)
> +{
> +    struct bpf_dynptr rbuf;
> +    u64 *p, r =3D 0;
> +
> +    bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, &rbuf);
> +    p =3D bpf_dynptr_data(&rbuf, 0, 8);
> +    if (!p)
> +        goto end;
> +    *p =3D global_subprog(ctx);
> +    r +=3D *p;
> +end:
> +    bpf_ringbuf_discard_dynptr(&rbuf, 0);
> +    return r + ctx->len;
> +}
> +
> +SEC("tc")
> +int exceptions_cleanup_frame(struct __sk_buff *ctx)
> +{
> +    struct foo { int i; } *p =3D bpf_obj_new(typeof(*p));
> +    int i;
> +    only_count =3D 1;
> +    res_count =3D 4;
> +    if (!p)
> +        return 1;
> +    p->i =3D static_subprog(ctx);
> +    i =3D p->i;
> +    bpf_obj_drop(p);
> +    return i + ctx->len;
> +}
> +
> +SEC("tc")
> +__success
> +int exceptions_cleanup_loop_iterations(struct __sk_buff *ctx)
> +{
> +    struct { int i; } *f[50] =3D {};
> +    int i;
> +
> +    only_count =3D true;
> +
> +    for (i =3D 0; i < 50; i++) {
> +        f[i] =3D bpf_obj_new(typeof(*f[0]));
> +        if (!f[i])
> +            goto end;
> +        res_count++;
> +        if (i =3D=3D 49) {
> +            bpf_throw(VAL);
> +        }
> +    }
> +end:
> +    for (i =3D 0; i < 50; i++) {
> +        if (!f[i])
> +            continue;
> +        bpf_obj_drop(f[i]);
> +    }
> +    return 0;
> +}
> +
> +SEC("tc")
> +int exceptions_cleanup_dead_code_elim(struct __sk_buff *ctx)
> +{
> +    void *p;
> +
> +    p =3D bpf_ringbuf_reserve(&ringbuf, 8, 0);
> +    if (!p)
> +        return 0;
> +    asm volatile (
> +        "r0 =3D r0;        \
> +         r0 =3D r0;        \
> +         r0 =3D r0;        \
> +         r0 =3D r0;        \
> +         r0 =3D r0;        \
> +         r0 =3D r0;        \
> +         r0 =3D r0;        \
> +    " ::: "r0");
> +    bpf_throw(VAL);
> +    bpf_ringbuf_discard(p, 0);
> +    return 0;
> +}
> +
> +__noinline int global_subprog_throw_dce(struct __sk_buff *ctx)
> +{
> +    u64 *p =3D bpf_ringbuf_reserve(&ringbuf, 8, 0);
> +    bpf_throw(VAL);
> +    return p ? *p : 0 + ctx->len;
> +}
> +
> +__noinline int global_subprog_dce(struct __sk_buff *ctx)
> +{
> +    u64 *p =3D bpf_ringbuf_reserve(&ringbuf, 8, 0);
> +    if (!p)
> +        return ctx->len;
> +    asm volatile (
> +        "r0 =3D r0;        \
> +         r0 =3D r0;        \
> +         r0 =3D r0;        \
> +         r0 =3D r0;        \
> +         r0 =3D r0;        \
> +         r0 =3D r0;        \
> +         r0 =3D r0;        \
> +    " ::: "r0");
> +    global_subprog_throw_dce(ctx);
> +    bpf_ringbuf_discard(p, 0);
> +    return !!p + ctx->len;
> +}
> +
> +__noinline static int static_subprog_dce(struct __sk_buff *ctx)
> +{
> +    struct bpf_dynptr rbuf;
> +    u64 *p, r =3D 0;
> +
> +    bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, &rbuf);
> +    p =3D bpf_dynptr_data(&rbuf, 0, 8);
> +    if (!p)
> +        goto end;
> +    asm volatile (
> +        "r0 =3D r0;        \
> +         r0 =3D r0;        \
> +         r0 =3D r0;        \
> +         r0 =3D r0;        \
> +         r0 =3D r0;        \
> +         r0 =3D r0;        \
> +         r0 =3D r0;        \
> +    " ::: "r0");
> +    *p =3D global_subprog_dce(ctx);
> +    r +=3D *p;
> +end:
> +    bpf_ringbuf_discard_dynptr(&rbuf, 0);
> +    return r + ctx->len;
> +}
> +
> +SEC("tc")
> +int exceptions_cleanup_frame_dce(struct __sk_buff *ctx)
> +{
> +    struct foo { int i; } *p =3D bpf_obj_new(typeof(*p));
> +    int i;
> +    only_count =3D 1;
> +    res_count =3D 4;
> +    if (!p)
> +        return 1;
> +    p->i =3D static_subprog_dce(ctx);
> +    i =3D p->i;
> +    bpf_obj_drop(p);
> +    return i + ctx->len;
> +}
> +
> +SEC("tc")
> +int reject_slot_with_zero_vs_ptr_ok(struct __sk_buff *ctx)
> +{
> +    asm volatile (
> +       "r7 =3D *(u32 *)(r1 + 0);          \
> +        r0 =3D 0;                         \
> +        *(u64 *)(r10 - 8) =3D r0;         \
> +        r1 =3D %[ringbuf] ll;             \
> +        r2 =3D 8;                         \
> +        r3 =3D 0;                         \
> +        if r7 !=3D 0 goto jump4;          \
> +        call %[bpf_ringbuf_reserve];    \
> +        *(u64 *)(r10 - 8) =3D r0;         \
> +    jump4:                              \
> +        r0 =3D 0;                         \
> +        r1 =3D 0;                         \
> +        call bpf_throw;                 \
> +    " : : __imm(bpf_ringbuf_reserve),
> +          __imm_addr(ringbuf)
> +      : "memory");
> +    return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c =
b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
> new file mode 100644
> index 000000000000..b3c70f92b35f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +
> +#include "bpf_misc.h"
> +#include "bpf_experimental.h"
> +
> +struct {
> +    __uint(type, BPF_MAP_TYPE_RINGBUF);
> +    __uint(max_entries, 8);
> +} ringbuf SEC(".maps");
> +
> +SEC("?tc")
> +__failure __msg("Unreleased reference")
> +int reject_with_reference(void *ctx)
> +{
> +	struct { int i; } *f;
> +
> +	f =3D bpf_obj_new(typeof(*f));
> +	if (!f)
> +		return 0;
> +	bpf_throw(0);
> +	return 0;
> +}
> +
> +SEC("?tc")
> +__failure __msg("frame_desc: merge: failed to merge old and new frame de=
sc entry")
> +int reject_slot_with_distinct_ptr(struct __sk_buff *ctx)
> +{
> +    void *p;
> +
> +    if (ctx->len) {
> +        p =3D bpf_ringbuf_reserve(&ringbuf, 8, 0);
> +    } else {
> +        p =3D bpf_obj_new(typeof(struct { int i; }));
> +    }
> +    bpf_throw(0);
> +    return !p;
> +}
> +
> +SEC("?tc")
> +__failure __msg("frame_desc: merge: failed to merge old and new frame de=
sc entry")
> +int reject_slot_with_distinct_ptr_old(struct __sk_buff *ctx)
> +{
> +    void *p;
> +
> +    if (ctx->len) {
> +        p =3D bpf_obj_new(typeof(struct { int i; }));
> +    } else {
> +        p =3D bpf_ringbuf_reserve(&ringbuf, 8, 0);
> +    }
> +    bpf_throw(0);
> +    return !p;
> +}
> +
> +SEC("?tc")
> +__failure __msg("frame_desc: merge: failed to merge old and new frame de=
sc entry")
> +int reject_slot_with_misc_vs_ptr(struct __sk_buff *ctx)
> +{
> +    void *p =3D (void *)bpf_ktime_get_ns();
> +
> +    if (ctx->protocol)
> +        p =3D bpf_ringbuf_reserve(&ringbuf, 8, 0);
> +    bpf_throw(0);
> +    return !p;
> +}
> +
> +SEC("?tc")
> +__failure __msg("Unreleased reference")
> +int reject_slot_with_misc_vs_ptr_old(struct __sk_buff *ctx)
> +{
> +    void *p =3D bpf_ringbuf_reserve(&ringbuf, 8, 0);
> +
> +    if (ctx->protocol)
> +        p =3D (void *)bpf_ktime_get_ns();
> +    bpf_throw(0);
> +    return !p;
> +}
> +
> +SEC("?tc")
> +__failure __msg("frame_desc: merge: failed to merge old and new frame de=
sc entry")
> +int reject_slot_with_invalid_vs_ptr(struct __sk_buff *ctx)
> +{
> +    asm volatile (
> +       "r7 =3D r1;                        \
> +        r1 =3D %[ringbuf] ll;             \
> +        r2 =3D 8;                         \
> +        r3 =3D 0;                         \
> +        r4 =3D *(u32 *)(r7 + 0);          \
> +        r6 =3D *(u64 *)(r10 - 8);         \
> +        if r4 =3D=3D 0 goto jump;           \
> +        call %[bpf_ringbuf_reserve];    \
> +        r6 =3D r0;                        \
> +    jump:                               \
> +        r0 =3D 0;                         \
> +        r1 =3D 0;                         \
> +        call bpf_throw;                 \
> +    " : : __imm(bpf_ringbuf_reserve),
> +          __imm_addr(ringbuf)
> +      : "memory");
> +    return 0;
> +}
> +
> +SEC("?tc")
> +__failure __msg("Unreleased reference")
> +int reject_slot_with_invalid_vs_ptr_old(struct __sk_buff *ctx)
> +{
> +    asm volatile (
> +       "r7 =3D r1;                        \
> +        r1 =3D %[ringbuf] ll;             \
> +        r2 =3D 8;                         \
> +        r3 =3D 0;                         \
> +        call %[bpf_ringbuf_reserve];    \
> +        r6 =3D r0;                        \
> +        r4 =3D *(u32 *)(r7 + 0);          \
> +        if r4 =3D=3D 0 goto jump2;          \
> +        r6 =3D *(u64 *)(r10 - 8);         \
> +    jump2:                              \
> +        r0 =3D 0;                         \
> +        r1 =3D 0;                         \
> +        call bpf_throw;                 \
> +    " : : __imm(bpf_ringbuf_reserve),
> +          __imm_addr(ringbuf)
> +      : "memory");
> +    return 0;
> +}
> +
> +SEC("?tc")
> +__failure __msg("Unreleased reference")
> +int reject_slot_with_zero_vs_ptr(struct __sk_buff *ctx)
> +{
> +    asm volatile (
> +       "r7 =3D *(u32 *)(r1 + 0);          \
> +        r1 =3D %[ringbuf] ll;             \
> +        r2 =3D 8;                         \
> +        r3 =3D 0;                         \
> +        call %[bpf_ringbuf_reserve];    \
> +        *(u64 *)(r10 - 8) =3D r0;         \
> +        r0 =3D 0;                         \
> +        if r7 !=3D 0 goto jump3;          \
> +        *(u64 *)(r10 - 8) =3D r0;         \
> +    jump3:                              \
> +        r0 =3D 0;                         \
> +        r1 =3D 0;                         \
> +        call bpf_throw;                 \
> +    " : : __imm(bpf_ringbuf_reserve),
> +          __imm_addr(ringbuf)
> +      : "memory");
> +    return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/=
testing/selftests/bpf/progs/exceptions_fail.c
> index dfd164a7a261..1e73200c6276 100644
> --- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
> +++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
> @@ -182,19 +182,6 @@ int reject_with_rbtree_add_throw(void *ctx)
>  	return 0;
>  }
> =20
> -SEC("?tc")
> -__failure __msg("Unreleased reference")
> -int reject_with_reference(void *ctx)
> -{
> -	struct foo *f;
> -
> -	f =3D bpf_obj_new(typeof(*f));
> -	if (!f)
> -		return 0;
> -	bpf_throw(0);

Hmm, so why is this a memory leak exactly? Apologies if this is already
explained clearly elsewhere in the stack.

> -	return 0;
> -}
> -
>  __noinline static int subprog_ref(struct __sk_buff *ctx)
>  {
>  	struct foo *f;
> --=20
> 2.40.1
>=20

--Pvx2Q3781o2xIZn/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcqFOgAKCRBZ5LhpZcTz
ZJbzAP0cocGsCHEFsZqPqjcwMWLQLjnIQ9iQByrV1JgX1Ce9GAEAkmf8l24q63Xj
n5fOb289m4DjYWP/Q9ip2XiFytx07Qo=
=8P1r
-----END PGP SIGNATURE-----

--Pvx2Q3781o2xIZn/--

