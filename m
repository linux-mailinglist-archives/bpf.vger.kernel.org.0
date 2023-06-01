Return-Path: <bpf+bounces-1625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DFD71F2D2
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 21:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359E71C210EC
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 19:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0051E2098F;
	Thu,  1 Jun 2023 19:18:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152A23DF
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 19:18:25 +0000 (UTC)
Received: from out-16.mta0.migadu.com (out-16.mta0.migadu.com [91.218.175.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D57189
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 12:18:22 -0700 (PDT)
Message-ID: <95b5da7c-ee52-3ecb-0a4e-f6a7a114f269@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685647100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IgQZpjSw84vHYzWJzYdDrGuuO8eVETVsB+aIQNPgeJo=;
	b=T5TRCpFPEJWIYl7mNS9gOtoXuy3z/cFxsJM4qoVYA9XPtITZxRANGN4Ldk58dRi1mIrA3X
	6ADfH8TO+l/v9ZFMMpebcSUEey5zfCSEGLYrSu6Vp6oanVkUFdySPYHH37YcEdcTWD1x86
	qJHP6DVnwIpsrsOc/JPIJgNEj6W58Fw=
Date: Thu, 1 Jun 2023 12:18:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Fix elem_size not being set for inner maps
Content-Language: en-US
To: Rhys Rustad-Elliott <me@rhysre.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230601000713.506358-1-me@rhysre.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230601000713.506358-1-me@rhysre.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/31/23 5:08 PM, Rhys Rustad-Elliott wrote:
> Commit d937bc3449fa ("bpf: make uniform use of array->elem_size
> everywhere in arraymap.c") changed array_map_gen_lookup to use
> array->elem_size instead of round_up(map->value_size, 8) as the element
> size when generating code to access a value in an array map.
> 
> array->elem_size, however, is not set by bpf_map_meta_alloc when
> initializing an BPF_MAP_TYPE_ARRAY_OF_MAPS or BPF_MAP_TYPE_HASH_OF_MAPS.
> This results in array_map_gen_lookup incorrectly outputting code that
> always accesses index 0 in the array (as the index will be calculated
> via a multiplication with the element size, which is incorrectly set to
> 0).
> 
> Set elem_size on the bpf_array object when allocating an array or hash
> of maps and add a selftest that accesses an inner map at a nonzero index
> to prevent regressions.
> 
> Fixes: d937bc3449fa ("bpf: make uniform use of array->elem_size everywhere in arraymap.c")
> Signed-off-by: Rhys Rustad-Elliott <me@rhysre.net>
> ---
>   kernel/bpf/map_in_map.c                       |  8 +++-
>   .../map_in_map_inner_array_lookup.c           | 33 ++++++++++++++
>   .../test_map_in_map_inner_array_lookup.c      | 45 +++++++++++++++++++
>   3 files changed, 84 insertions(+), 2 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/map_in_map_inner_array_lookup.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_map_in_map_inner_array_lookup.c
> 
> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> index 2c5c64c2a53b..8d65b12e0834 100644
> --- a/kernel/bpf/map_in_map.c
> +++ b/kernel/bpf/map_in_map.c
> @@ -69,9 +69,13 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>   	/* Misc members not needed in bpf_map_meta_equal() check. */
>   	inner_map_meta->ops = inner_map->ops;
>   	if (inner_map->ops == &array_map_ops) {
> +		struct bpf_array *inner_array_meta =
> +			container_of(inner_map_meta, struct bpf_array, map);
> +		struct bpf_array *inner_array = container_of(inner_map, struct bpf_array, map);
> +
> +		inner_array_meta->index_mask = inner_array->index_mask;
> +		inner_array_meta->elem_size = round_up(inner_map->value_size, 8);

How about directly use inner_array->elem_size instead of
"round_up(inner_map->value_size, 8)"?

>   		inner_map_meta->bypass_spec_v1 = inner_map->bypass_spec_v1;
> -		container_of(inner_map_meta, struct bpf_array, map)->index_mask =
> -		     container_of(inner_map, struct bpf_array, map)->index_mask;
>   	}
>   
>   	fdput(f);
> diff --git a/tools/testing/selftests/bpf/prog_tests/map_in_map_inner_array_lookup.c b/tools/testing/selftests/bpf/prog_tests/map_in_map_inner_array_lookup.c
> new file mode 100644
> index 000000000000..264d4788e5fd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/map_in_map_inner_array_lookup.c

Separate the selftests into another patch.

> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <test_progs.h>
> +
> +#include "test_map_in_map_inner_array_lookup.skel.h"
> +
> +static int duration;

Use the ASSERT_* macro instead of CHECK, then no need for
"static int duration;".

> +
> +void test_map_in_map_inner_array_lookup(void)

nit. A shorter name? may be test_inner_array_lookup().

> +{
> +	int map1_fd, err;
> +	int key = 3;
> +	int val = 1;
> +	struct test_map_in_map_inner_array_lookup *skel;
> +
> +	skel = test_map_in_map_inner_array_lookup__open_and_load();
> +	if (CHECK(!skel, "skel_open", "failed to open&load skeleton\n"))
> +		return;
> +
> +	err = test_map_in_map_inner_array_lookup__attach(skel);
> +	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
> +		goto cleanup;
> +
> +	map1_fd = bpf_map__fd(skel->maps.inner_map1);
> +	bpf_map_update_elem(map1_fd, &key, &val, 0);
> +	usleep(1);

Why usleep is needed?

> +	/* Probe should have set the element at index 3 to 2 */
> +	bpf_map_lookup_elem(map1_fd, &key, &val);
> +	CHECK(val != 2, "inner1", "got %d != exp %d\n", val, 2);
> +
> +cleanup:
> +	test_map_in_map_inner_array_lookup__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map_inner_array_lookup.c b/tools/testing/selftests/bpf/progs/test_map_in_map_inner_array_lookup.c
> new file mode 100644
> index 000000000000..c2c8f2fa451d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_map_in_map_inner_array_lookup.c

nit. A shorter name also, inner_array_lookup.c?

> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct inner_map {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 5);
> +	__type(key, int);
> +	__type(value, int);
> +} inner_map1 SEC(".maps");
> +
> +struct outer_map {
> +	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
> +	__uint(max_entries, 3);
> +	__type(key, int);
> +	__array(values, struct inner_map);
> +} outer_map1 SEC(".maps") = {
> +	.values = {
> +		[2] = &inner_map1,
> +	},
> +};
> +
> +SEC("raw_tp/sys_enter")
> +int handle__sys_enter(void *ctx)
> +{
> +	int outer_key = 2, inner_key = 3;
> +	int *val;
> +	void *map;
> +
> +	map = bpf_map_lookup_elem(&outer_map1, &outer_key);
> +	if (!map)
> +		return 1;
> +
> +	val = bpf_map_lookup_elem(map, &inner_key);
> +	if (!val)
> +		return 1;
> +
> +	if (*val == 1)
> +		*val = 2;
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";


