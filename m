Return-Path: <bpf+bounces-13641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F7C7DC19D
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 22:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A244B20E4C
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 21:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844101C2A4;
	Mon, 30 Oct 2023 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cVrwi4rr"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190431A713
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 21:10:38 +0000 (UTC)
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BB1E1
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 14:10:36 -0700 (PDT)
Message-ID: <45000107-b119-46d5-aa01-c3f08d0a1921@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698700234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+xJXCd1tt7lV6SbkNIQA+C0UMRD1a9biaymvRej+fKg=;
	b=cVrwi4rrnS2UomXhC+yigCdl4HOOfJdudVGtn21DDkEpm5eF5kg+nH79zeLspOo6rlRmsc
	oXWg5968XLrx/RSoA66LUcxXHvHf8Adl0pfD8w6MoXqU+aWcXs8w7W0dpNP1drLRb2Y3T5
	28SkqCZtI5F2BYE6SOdilyi62I+ANjI=
Date: Mon, 30 Oct 2023 14:10:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 4/4] selftests/bpf: Add tests exercising
 aggregate type BTF field search
Content-Language: en-GB
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20231023220030.2556229-1-davemarchevsky@fb.com>
 <20231023220030.2556229-5-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231023220030.2556229-5-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/23/23 3:00 PM, Dave Marchevsky wrote:
> The newly-added test file attempts to kptr_xchg a prog_test_ref_kfunc
> kptr into a kptr field in a variety of nested aggregate types. If the
> verifier recognizes that there's a kptr field where we're trying to
> kptr_xchg, then the aggregate type digging logic works as expected.
>
> Some of the refactoring changes in this series are tested as well.
> Specifically:
>    * BTF_FIELDS_MAX is now higher and represents the max size of the
>      growable array. Confirm that btf_parse_fields fails for a type which
>      contains too many fields.
>    * If we've already seen BTF_FIELDS_MAX fields, we should continue
>      looking for fields and fail if we find another one, otherwise the
>      search should succeed and return BTF_FIELDS_MAX btf_field_infos.
>      Confirm that this edge case works as expected.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   .../selftests/bpf/prog_tests/array_kptr.c     |  12 ++
>   .../testing/selftests/bpf/progs/array_kptr.c  | 179 ++++++++++++++++++
>   2 files changed, 191 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/array_kptr.c
>   create mode 100644 tools/testing/selftests/bpf/progs/array_kptr.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/array_kptr.c b/tools/testing/selftests/bpf/prog_tests/array_kptr.c
> new file mode 100644
> index 000000000000..9d088520bdfe
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/array_kptr.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include <test_progs.h>
> +
> +#include "array_kptr.skel.h"
> +
> +void test_array_kptr(void)
> +{
> +	if (env.has_testmod)
> +		RUN_TESTS(array_kptr);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/array_kptr.c b/tools/testing/selftests/bpf/progs/array_kptr.c
> new file mode 100644
> index 000000000000..f34872e74024
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/array_kptr.c
> @@ -0,0 +1,179 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include "../bpf_testmod/bpf_testmod_kfunc.h"
> +#include "bpf_misc.h"
> +
> +struct val {
> +	int d;
> +	struct prog_test_ref_kfunc __kptr *ref_ptr;
> +};
> +
> +struct val2 {
> +	char c;
> +	struct val v;
> +};
> +
> +struct val_holder {
> +	int e;
> +	struct val2 first[2];
> +	int f;
> +	struct val second[2];
> +};
> +
> +struct array_map {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__type(key, int);
> +	__type(value, struct val);
> +	__uint(max_entries, 10);
> +} array_map SEC(".maps");
> +
> +struct array_map2 {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__type(key, int);
> +	__type(value, struct val2);
> +	__uint(max_entries, 10);
> +} array_map2 SEC(".maps");
> +
> +__hidden struct val array[25];
> +__hidden struct val double_array[5][5];
> +__hidden struct val_holder double_holder_array[2][2];
> +
> +/* Some tests need their own section to force separate bss arraymap,
> + * otherwise above arrays wouldn't have btf_field_info either
> + */
> +#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
> +private(A) struct val array_too_big[300];
> +
> +private(B) struct val exactly_max_fields[256];
> +private(B) int ints[50];
> +
> +SEC("tc")
> +__success __retval(0)
> +int test_arraymap(void *ctx)
> +{
> +	struct prog_test_ref_kfunc *p;
> +	unsigned long dummy = 0;
> +	struct val *v;
> +	int idx = 0;
> +
> +	v = bpf_map_lookup_elem(&array_map, &idx);
> +	if (!v)
> +		return 1;
> +
> +	p = bpf_kfunc_call_test_acquire(&dummy);
> +	if (!p)
> +		return 2;
> +
> +	p = bpf_kptr_xchg(&v->ref_ptr, p);
> +	if (p) {
> +		bpf_kfunc_call_test_release(p);
> +		return 3;
> +	}
> +
> +	return 0;
> +}
> +
> ...
> +
> +SEC("tc")
> +__failure __msg("map '.bss.A' has no valid kptr")

The .bss.A might have valid kptr.
To reflect realiaty, maybe error message can be
'has too many special fields'?

> +int test_array_fail__too_big(void *ctx)
> +{
> +	/* array_too_big's btf_record parsing will fail due to the
> +	 * number of btf_field_infos being > BTF_FIELDS_MAX
> +	 */
> +	return test_array_xchg(&array_too_big[50]);
> +}
> +
> +char _license[] SEC("license") = "GPL";

