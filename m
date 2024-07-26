Return-Path: <bpf+bounces-35757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA46793D930
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 21:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DF21F248AC
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 19:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA8D4AEE9;
	Fri, 26 Jul 2024 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b/Epst7l"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628EE38DEE
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022721; cv=none; b=DE1iWPk18BJRYi36/le8Cj+UR3LGJg9JugGTBrW0YddRf8hO7idyLQPo7CRIenNj9saANoWDbQhuGWb6ZTIR41+n01oR3gG2GP9P2DnIo+RI3Xcf8c41BFsjWuZxCl8TDeM0/FeMDfv1PpA0cYYDRslnR9zPS+GJlHckqO7+Fds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022721; c=relaxed/simple;
	bh=tOBByrLlajf8ngiJjccFbWxFRB/kO5pbL/lJk2zZzWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfWafP9bIztdUKJ/GlGMgoxZ1G4UZpX53iPE3mauSQptaPr5IHQcCyITkYxwjN0vVpY/ZH7aCAO19rzz3pEGdVDq1B9pK0x2Exzxc+iqKgQ7M6z9PHXYanmPaXYGRjhErMnw17/13JX3aBkP8HljyY4XrME6rQSOmrADzX1MvIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b/Epst7l; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <562a4618-1f4e-4f1d-a0e4-7a3c52307100@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722022717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fI1aXhEOGpcfEUJYtfwm5W8V3sMJ1XaL3EkLR+e6wiQ=;
	b=b/Epst7lGdRXLLi8RENwrcIe3TKqbv2rcp/mlqwzIqx1g2s6pfXF9ZLanTWo4m61bdWjaI
	X2K5do5COWHIl773OLXsYJ9UHMDVt/qpBsJ+FCbcG6yewI3RCWHPgfL+CKO/vODPo06sjg
	8/spwvW4ZqH11y2ijCP7jnlIQOEguJc=
Date: Fri, 26 Jul 2024 12:38:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add testcase for updating
 attached freplace prog to prog_array map
Content-Language: en-GB
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, eddyz87@gmail.com, wutengda@huaweicloud.com,
 kernel-patches-bot@fb.com
References: <20240726153952.76914-1-leon.hwang@linux.dev>
 <20240726153952.76914-3-leon.hwang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240726153952.76914-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/26/24 8:39 AM, Leon Hwang wrote:
> Add a selftest to confirm the issue, which gets -EINVAL when update
> attached freplace prog to prog_array map, has been fixed.
>
> cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
> 327/25  tailcalls/tailcall_freplace:OK
> 327     tailcalls:OK
> Summary: 1/25 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

LGTM with some comments below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   .../selftests/bpf/prog_tests/tailcalls.c      | 65 ++++++++++++++++++-
>   .../selftests/bpf/progs/tailcall_freplace.c   | 25 +++++++
>   .../testing/selftests/bpf/progs/tc_bpf2bpf.c  | 21 ++++++
>   3 files changed, 110 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/tailcall_freplace.c
>   create mode 100644 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> index e01fabb8cc415..21c5a37846ade 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> @@ -5,7 +5,8 @@
>   #include "tailcall_poke.skel.h"
>   #include "tailcall_bpf2bpf_hierarchy2.skel.h"
>   #include "tailcall_bpf2bpf_hierarchy3.skel.h"
> -
> +#include "tailcall_freplace.skel.h"
> +#include "tc_bpf2bpf.skel.h"
>   
>   /* test_tailcall_1 checks basic functionality by patching multiple locations
>    * in a single program for a single tail call slot with nop->jmp, jmp->nop
> @@ -1495,6 +1496,66 @@ static void test_tailcall_bpf2bpf_hierarchy_3(void)
>   	RUN_TESTS(tailcall_bpf2bpf_hierarchy3);
>   }
>   
> +/* test_tailcall_freplace checks that the attached freplace prog is OK to
> + * update the prog_array map.
> + */
> +static void test_tailcall_freplace(void)
> +{
> +	struct tailcall_freplace *freplace_skel = NULL;
> +	struct bpf_link *freplace_link = NULL;
> +	struct bpf_program *freplace_prog;
> +	struct tc_bpf2bpf *tc_skel = NULL;
> +	int prog_fd, map_fd;
> +	char buff[128] = {};
> +	int err, key;
> +
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		    .data_in = buff,
> +		    .data_size_in = sizeof(buff),
> +		    .repeat = 1,
> +	);
> +
> +	freplace_skel = tailcall_freplace__open();
> +	if (!ASSERT_OK_PTR(freplace_skel, "tailcall_freplace__open"))
> +		return;
> +
> +	tc_skel = tc_bpf2bpf__open_and_load();
> +	if (!ASSERT_OK_PTR(tc_skel, "tc_bpf2bpf__open_and_load"))
> +		goto out;
> +
> +	prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
> +	freplace_prog = freplace_skel->progs.entry_freplace;
> +	err = bpf_program__set_attach_target(freplace_prog, prog_fd, "subprog");
> +	if (!ASSERT_OK(err, "set_attach_target"))
> +		goto out;
> +
> +	err = tailcall_freplace__load(freplace_skel);
> +	if (!ASSERT_OK(err, "tailcall_freplace__load"))
> +		goto out;
> +
> +	freplace_link = bpf_program__attach_freplace(freplace_prog, prog_fd,
> +						     "subprog");
> +	if (!ASSERT_OK_PTR(freplace_link, "attach_freplace"))
> +		goto out;
> +
> +	map_fd = bpf_map__fd(freplace_skel->maps.jmp_table);
> +	prog_fd = bpf_program__fd(freplace_prog);
> +	key = 0;
> +	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
> +	if (!ASSERT_OK(err, "update jmp_table"))
> +		goto out;
> +
> +	prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> +	ASSERT_OK(err, "test_run");
> +	ASSERT_EQ(topts.retval, 34, "test_run retval");
> +
> +out:
> +	bpf_link__destroy(freplace_link);
> +	tc_bpf2bpf__destroy(tc_skel);
> +	tailcall_freplace__destroy(freplace_skel);
> +}
> +
>   void test_tailcalls(void)
>   {
>   	if (test__start_subtest("tailcall_1"))
> @@ -1543,4 +1604,6 @@ void test_tailcalls(void)
>   		test_tailcall_bpf2bpf_hierarchy_fentry_entry();
>   	test_tailcall_bpf2bpf_hierarchy_2();
>   	test_tailcall_bpf2bpf_hierarchy_3();
> +	if (test__start_subtest("tailcall_freplace"))
> +		test_tailcall_freplace();
>   }
> diff --git a/tools/testing/selftests/bpf/progs/tailcall_freplace.c b/tools/testing/selftests/bpf/progs/tailcall_freplace.c
> new file mode 100644
> index 0000000000000..2966efc06ae8f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tailcall_freplace.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> +	__uint(max_entries, 1);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u32));
> +} jmp_table SEC(".maps");
> +
> +int count = 0;
> +
> +SEC("freplace")
> +int entry_freplace(struct __sk_buff *skb)
> +{
> +	count++;
> +
remove empty line here.
> +	bpf_tail_call_static(skb, &jmp_table, 0);
> +
remove empty line here.
> +	return count;
> +}
> +
> +char __license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
> new file mode 100644
> index 0000000000000..980bb810b481c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +__noinline
> +int subprog(struct __sk_buff *skb)
> +{
> +	volatile int ret = 1;
> +
remove empty line here.
> +	asm volatile (""::"r+"(ret));
remove above 'volatile' key word and replace asm volatile with __sink(ret).
> +	return ret;
> +}
> +
> +SEC("tc")
> +int entry_tc(struct __sk_buff *skb)
> +{
> +	return subprog(skb);
> +}
> +
> +char __license[] SEC("license") = "GPL";

