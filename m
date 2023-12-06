Return-Path: <bpf+bounces-16952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76268807C31
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 00:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992471C2111F
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 23:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB1C2E40A;
	Wed,  6 Dec 2023 23:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dS18CKis"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E01D62
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 15:16:45 -0800 (PST)
Message-ID: <274e98da-9f9e-4828-8a8f-7891c6775770@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701904603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FHuasGM6oLD+nettU8HJ7yej6lQ3moldFLuV0C1CWo4=;
	b=dS18CKisB2Fx5pJudCaX6zrOP53pIWFrKOZaxlPNphFEjD5lSHb7IEOdN8P/IrFRdiyQ0o
	9/OFlDCRCYaANrh3DT0b8KXKTwIIIxtC+3SqvuQ2WhDOp6A3wxaSz5eSi/u2vqoX+07qvp
	IM07rk+vMmaUx0AYHy/wpV/xuGC/UP8=
Date: Wed, 6 Dec 2023 15:16:35 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Test the release of map btf
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com
References: <20231206110625.3188975-1-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231206110625.3188975-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/6/23 6:06 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> When there is bpf_list_head or bpf_rb_root field in map value, the free
> of map btf and the free of map value may run concurrently and there may
> be use-after-free problem, so add two test cases to demonstrate it.
>
> The first test case tests the racing between the free of map btf and the
> free of array map. It constructs the racing by releasing the array map in
> the end after other ref-counter of map btf has been released. But it is
> still hard to reproduce the UAF problem, and I managed to reproduce it
> by queuing multiple kworkers to stress system_unbound_wq concurrently.

Thanks a lot for your test cases! I tried your patch on top of bpf-next
and run over 20 times and still cannot reproduce the issue.
Based on your description, you need to do
"
queuing multiple kworkers to stress system_unbound_wq concurrently
"
What specific steps you are doing here to stree system_unbound_wq?
I guess we have to have some kind of logic in the patch to stree
system_unbound_wq to trigger a failure?

>
> The second case tests the racing between the free of map btf and the
> free of inner map. Beside using the similar method as the first one
> does, it uses bpf_map_delete_elem() to delete the inner map and to defer
> the release of inner map after one RCU grace period. The UAF problem can
> been easily reproduced by using bpf_next tree and a KASAN-enabled kernel.

This test is solid and I can reproduce it easily and with my patch
   https://lore.kernel.org/bpf/20231206210959.1035724-1-yonghong.song@linux.dev/
the test can run successfully.

>
> The reason for using two skeletons is to prevent the release of outer
> map and inner map in map_in_map_btf.c interfering the release of bpf
> map in normal_map_btf.c.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
> Hi,
>
> I was also working on the UAF problem caused by the racing between the
> free map btf and the free map value. However considering Yonghong posted
> the patch first [1], I decided to post the selftest for the problem. The
> reliable reproduce of the problem depends on the "Fix the release of
> inner map" patch-set in bpf-next.
>
> [1]: https://lore.kernel.org/bpf/20231205224812.813224-1-yonghong.song@linux.dev/
>
>   .../selftests/bpf/prog_tests/map_btf.c        | 88 +++++++++++++++++++
>   .../selftests/bpf/progs/map_in_map_btf.c      | 73 +++++++++++++++
>   .../selftests/bpf/progs/normal_map_btf.c      | 56 ++++++++++++
>   3 files changed, 217 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/map_btf.c
>   create mode 100644 tools/testing/selftests/bpf/progs/map_in_map_btf.c
>   create mode 100644 tools/testing/selftests/bpf/progs/normal_map_btf.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/map_btf.c b/tools/testing/selftests/bpf/prog_tests/map_btf.c
> new file mode 100644
> index 000000000000..5304eee0e8f8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/map_btf.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
> +#define _GNU_SOURCE
> +#include <sched.h>
> +#include <pthread.h>
> +#include <stdbool.h>
> +#include <bpf/btf.h>
> +#include <test_progs.h>
> +
> +#include "normal_map_btf.skel.h"
> +#include "map_in_map_btf.skel.h"
> +
> +static void do_test_normal_map_btf(void)
> +{
> +	struct normal_map_btf *skel;
> +	int err, new_fd = -1;
> +
> +	skel = normal_map_btf__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_load"))
> +		return;
> +
> +	err = normal_map_btf__attach(skel);
> +	if (!ASSERT_OK(err, "attach"))
> +		goto out;
> +
> +	skel->bss->pid = getpid();
> +	usleep(1);
> +	ASSERT_TRUE(skel->bss->done, "done");
> +
> +	/* Close array fd later */
> +	new_fd = dup(bpf_map__fd(skel->maps.array));
> +out:
> +	normal_map_btf__destroy(skel);
> +	if (new_fd < 0)
> +		return;
> +	/* Use kern_sync_rcu() to wait for the start of the free of the bpf
> +	 * program and use an assumed delay to wait for the release of the map
> +	 * btf which is held by other maps (e.g, bss). After that, array map
> +	 * holds the last reference of map btf.
> +	 */
> +	kern_sync_rcu();
> +	usleep(2000);

I tried 2000/20000/200000 and all of them cannot reproduce the issue.
I guess this usleep will not only delay freeing the map, but also
delaying some other system activity, e.g., freeing the btf?

> +	close(new_fd);
> +}
> +
> +static void do_test_map_in_map_btf(void)
> +{
> +	int err, zero = 0, new_fd = -1;
> +	struct map_in_map_btf *skel;
> +
> +	skel = map_in_map_btf__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_load"))
> +		return;
> +
> +	err = map_in_map_btf__attach(skel);
> +	if (!ASSERT_OK(err, "attach"))
> +		goto out;
> +
> +	skel->bss->pid = getpid();
> +	usleep(1);
> +	ASSERT_TRUE(skel->bss->done, "done");
> +
> +	/* Close inner_array fd later */
> +	new_fd = dup(bpf_map__fd(skel->maps.inner_array));
> +	/* Defer the free of inner_array */
> +	err = bpf_map__delete_elem(skel->maps.outer_array, &zero, sizeof(zero), 0);
> +	ASSERT_OK(err, "delete inner map");
> +out:
> +	map_in_map_btf__destroy(skel);
> +	if (new_fd < 0)
> +		return;
> +	/* Use kern_sync_rcu() to wait for the start of the free of the bpf
> +	 * program and use an assumed delay to wait for the free of the outer
> +	 * map and the release of map btf. After that, array map holds the last

array map refers to inner map, right? It would be good to be explicit
to use 'inner' map?

> +	 * reference of map btf.
> +	 */
> +	kern_sync_rcu();
> +	usleep(10000);
> +	close(new_fd);
> +}
> +
> +void test_map_btf(void)
> +{
> +	if (test__start_subtest("array_btf"))
> +		do_test_normal_map_btf();
> +	if (test__start_subtest("inner_array_btf"))
> +		do_test_map_in_map_btf();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/map_in_map_btf.c b/tools/testing/selftests/bpf/progs/map_in_map_btf.c
> new file mode 100644
> index 000000000000..6a000dd789d3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/map_in_map_btf.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#include "bpf_misc.h"
> +#include "bpf_experimental.h"
> +
> +struct node_data {
> +	__u64 data;
> +	struct bpf_list_node node;
> +};
> +
> +struct map_value {
> +	struct bpf_list_head head __contains(node_data, node);
> +	struct bpf_spin_lock lock;
> +};
> +
> +struct inner_array_type {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__type(key, int);
> +	__type(value, struct map_value);
> +	__uint(max_entries, 1);
> +} inner_array SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> +	__uint(key_size, 4);
> +	__uint(value_size, 4);
> +	__uint(max_entries, 1);
> +	__array(values, struct inner_array_type);
> +} outer_array SEC(".maps") = {
> +	.values = {
> +		[0] = &inner_array,
> +	},
> +};
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int pid = 0;
> +bool done = false;
> +
> +SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> +int add_to_list_in_inner_array(void *ctx)
> +{
> +	struct map_value *value;
> +	struct node_data *new;
> +	struct bpf_map *map;
> +	int zero = 0;
> +

If 'done' is true here we can just return, right?

> +	if ((u32)bpf_get_current_pid_tgid() != pid)
> +		return 0;
> +
> +	map = bpf_map_lookup_elem(&outer_array, &zero);
> +	if (!map)
> +		return 0;
> +
> +	value = bpf_map_lookup_elem(map, &zero);
> +	if (!value)
> +		return 0;
> +
> +	new = bpf_obj_new(typeof(*new));
> +	if (!new)
> +		return 0;
> +
> +	bpf_spin_lock(&value->lock);
> +	bpf_list_push_back(&value->head, &new->node);
> +	bpf_spin_unlock(&value->lock);
> +	done = true;
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/normal_map_btf.c b/tools/testing/selftests/bpf/progs/normal_map_btf.c
> new file mode 100644
> index 000000000000..c8a19e30f8a9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/normal_map_btf.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#include "bpf_misc.h"
> +#include "bpf_experimental.h"
> +
> +struct node_data {
> +	__u64 data;
> +	struct bpf_list_node node;
> +};
> +
> +struct map_value {
> +	struct bpf_list_head head __contains(node_data, node);
> +	struct bpf_spin_lock lock;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__type(key, int);
> +	__type(value, struct map_value);
> +	__uint(max_entries, 1);
> +} array SEC(".maps");
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int pid = 0;
> +bool done = false;
> +
> +SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> +int add_to_list_in_array(void *ctx)
> +{
> +	struct map_value *value;
> +	struct node_data *new;
> +	int zero = 0;
> +

The same here. If 'done' is true, we can return, right?

> +	if ((u32)bpf_get_current_pid_tgid() != pid)
> +		return 0;
> +
> +	value = bpf_map_lookup_elem(&array, &zero);
> +	if (!value)
> +		return 0;
> +
> +	new = bpf_obj_new(typeof(*new));
> +	if (!new)
> +		return 0;
> +
> +	bpf_spin_lock(&value->lock);
> +	bpf_list_push_back(&value->head, &new->node);
> +	bpf_spin_unlock(&value->lock);
> +	done = true;
> +
> +	return 0;
> +}

