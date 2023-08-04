Return-Path: <bpf+bounces-7026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31A77705D2
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816E02827C9
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AE4198AF;
	Fri,  4 Aug 2023 16:22:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB0518054
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 16:22:06 +0000 (UTC)
Received: from out-65.mta0.migadu.com (out-65.mta0.migadu.com [IPv6:2001:41d0:1004:224b::41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C741BDD
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 09:22:03 -0700 (PDT)
Message-ID: <5fd74eee-34ce-6dfc-57f1-897ce26fc3d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691166120; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYytGRQNjPuwmyufltsDYogApZTqQDrkkvnOu3D+onA=;
	b=dkqx2/VW//AzhWEfjOV/nurTjqJHNCpO133oykWPJOs7GmtgcnMZvmoy9rderTTm0a6dRX
	NkqK5IfqSyEv4JyiXFUWqdDvXUnxZVVeA/gvCfkDga8fYZQUmew261abjuGp52ihPuvSMq
	1Tuf5ZkS+rsv3mfJMsyxOOLGo/S2gEI=
Date: Fri, 4 Aug 2023 09:21:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add selftest for
 fill_link_info
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
 jolsa@kernel.org
Cc: bpf@vger.kernel.org
References: <20230804105732.3768-1-laoar.shao@gmail.com>
 <20230804105732.3768-3-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230804105732.3768-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/4/23 3:57 AM, Yafang Shao wrote:
> Add selftest for the fill_link_info of uprobe, kprobe and tracepoint.
> The result:
> 
>    $ tools/testing/selftests/bpf/test_progs --name=fill_link_info
>    #79/1    fill_link_info/kprobe_link_info:OK
>    #79/2    fill_link_info/kretprobe_link_info:OK
>    #79/3    fill_link_info/kprobe_fill_invalid_user_buff:OK
>    #79/4    fill_link_info/tracepoint_link_info:OK
>    #79/5    fill_link_info/uprobe_link_info:OK
>    #79/6    fill_link_info/uretprobe_link_info:OK
>    #79/7    fill_link_info/kprobe_multi_link_info:OK
>    #79/8    fill_link_info/kretprobe_multi_link_info:OK
>    #79/9    fill_link_info/kprobe_multi_ubuff:OK
>    #79      fill_link_info:OK
>    Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED
> 
> The test case for kprobe_multi won't be run on aarch64, as it is not
> supported.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Ack with a few nits below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/testing/selftests/bpf/DENYLIST.aarch64       |   3 +
>   .../selftests/bpf/prog_tests/fill_link_info.c      | 337 +++++++++++++++++++++
>   .../selftests/bpf/progs/test_fill_link_info.c      |  42 +++
>   3 files changed, 382 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/fill_link_info.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_fill_link_info.c
> 
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> index 3b61e8b..b2f46b6 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -12,3 +12,6 @@ kprobe_multi_test/skel_api                       # libbpf: failed to load BPF sk
>   module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
>   fentry_test/fentry_many_args                     # fentry_many_args:FAIL:fentry_many_args_attach unexpected error: -524
>   fexit_test/fexit_many_args                       # fexit_many_args:FAIL:fexit_many_args_attach unexpected error: -524
> +fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_multi_opts unexpected error: -95
> +fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
> +fill_link_info/kprobe_multi_ubuff                # bpf_program__attach_kprobe_multi_opts unexpected error: -95
> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> new file mode 100644
> index 0000000..001a8b5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> @@ -0,0 +1,337 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
> +
> +#include <string.h>
> +#include <linux/bpf.h>
> +#include <linux/limits.h>
> +#include <test_progs.h>
> +#include "trace_helpers.h"
> +#include "test_fill_link_info.skel.h"
> +
> +#define TP_CAT "sched"
> +#define TP_NAME "sched_switch"
> +#define KPROBE_FUNC "tcp_rcv_established"
> +#define UPROBE_FILE "/proc/self/exe"
> +#define KMULTI_CNT (4)
> +
> +/* uprobe attach point */
> +static noinline void uprobe_func(void)
> +{
> +	asm volatile ("");
> +}
> +
> +static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long addr,
> +				 ssize_t offset, ssize_t entry_offset)
> +{
> +	struct bpf_link_info info;
> +	__u32 len = sizeof(info);
> +	char buf[PATH_MAX];
> +	int err = 0;
> +
> +	memset(&info, 0, sizeof(info));
> +	buf[0] = '\0';
> +
> +again:
> +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> +	if (!ASSERT_OK(err, "get_link_info"))
> +		return -1;
> +
> +	if (!ASSERT_EQ(info.type, BPF_LINK_TYPE_PERF_EVENT, "link_type"))
> +		return -1;
> +	if (!ASSERT_EQ(info.perf_event.type, type, "perf_type_match"))
> +		return -1;
> +
> +	switch (info.perf_event.type) {
> +	case BPF_PERF_EVENT_KPROBE:
> +	case BPF_PERF_EVENT_KRETPROBE:
> +		ASSERT_EQ(info.perf_event.kprobe.offset, offset, "kprobe_offset");
> +
> +		/* In case kernel.kptr_restrict is not permitted or MAX_SYMS is reached */
> +		if (addr)
> +			ASSERT_EQ(info.perf_event.kprobe.addr, addr + entry_offset,
> +				  "kprobe_addr");
> +
> +		if (!info.perf_event.kprobe.func_name) {
> +			ASSERT_EQ(info.perf_event.kprobe.name_len, 0, "name_len");
> +			info.perf_event.kprobe.func_name = ptr_to_u64(&buf);
> +			info.perf_event.kprobe.name_len = sizeof(buf);
> +			goto again;
> +		}
> +
> +		err = strncmp(u64_to_ptr(info.perf_event.kprobe.func_name), KPROBE_FUNC,
> +			      strlen(KPROBE_FUNC));
> +		ASSERT_EQ(err, 0, "cmp_kprobe_func_name");
> +		break;
> +	case BPF_PERF_EVENT_TRACEPOINT:
> +		if (!info.perf_event.tracepoint.tp_name) {
> +			ASSERT_EQ(info.perf_event.tracepoint.name_len, 0, "name_len");
> +			info.perf_event.tracepoint.tp_name = ptr_to_u64(&buf);
> +			info.perf_event.tracepoint.name_len = sizeof(buf);
> +			goto again;
> +		}
> +
> +		err = strncmp(u64_to_ptr(info.perf_event.tracepoint.tp_name), TP_NAME,
> +			      strlen(TP_NAME));
> +		ASSERT_EQ(err, 0, "cmp_tp_name");
> +		break;
> +	case BPF_PERF_EVENT_UPROBE:
> +	case BPF_PERF_EVENT_URETPROBE:
> +		ASSERT_EQ(info.perf_event.uprobe.offset, offset, "uprobe_offset");
> +
> +		if (!info.perf_event.uprobe.file_name) {
> +			ASSERT_EQ(info.perf_event.uprobe.name_len, 0, "name_len");
> +			info.perf_event.uprobe.file_name = ptr_to_u64(&buf);
> +			info.perf_event.uprobe.name_len = sizeof(buf);
> +			goto again;
> +		}
> +
> +		err = strncmp(u64_to_ptr(info.perf_event.uprobe.file_name), UPROBE_FILE,
> +			      strlen(UPROBE_FILE));
> +			ASSERT_EQ(err, 0, "cmp_file_name");
> +		break;
> +	default:

Is the 'default' case possible? Probably not, right? Then
let us add
		err = -1;
to indicate this path is not possible.

> +		break;
> +	}
> +	return err;
> +}
> +
[...]
> +
> +static void test_kprobe_fill_link_info(struct test_fill_link_info *skel,
> +				       enum bpf_perf_event_type type,
> +				       bool retprobe, bool invalid)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts,
> +		.attach_mode = PROBE_ATTACH_MODE_LINK,
> +		.retprobe = retprobe,
> +	);
> +	ssize_t offset = 0, entry_offset = 0;

Remove 'offset = 0'.

> +	int link_fd, err;
> +	long addr;
> +
> +	skel->links.kprobe_run = bpf_program__attach_kprobe_opts(skel->progs.kprobe_run,
> +								 KPROBE_FUNC, &opts);
> +	if (!ASSERT_OK_PTR(skel->links.kprobe_run, "attach_kprobe"))
> +		return;
> +
> +	link_fd = bpf_link__fd(skel->links.kprobe_run);
> +	addr = ksym_get_addr(KPROBE_FUNC);
> +	if (!invalid) {
> +		/* See also arch_adjust_kprobe_addr(). */
> +		if (skel->kconfig->CONFIG_X86_KERNEL_IBT)
> +			entry_offset = 4;
> +		err = verify_perf_link_info(link_fd, type, addr, offset, entry_offset);

Replease 'offset' with '0'.

> +		ASSERT_OK(err, "verify_perf_link_info");
> +	} else {
> +		kprobe_fill_invalid_user_buffer(link_fd);
> +	}
> +	bpf_link__detach(skel->links.kprobe_run);
> +}
> +
[...]
> +
> +static void test_kprobe_multi_fill_link_info(struct test_fill_link_info *skel,
> +					     bool retprobe, bool buffer)
> +{
> +	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> +	const char *syms[KMULTI_CNT] = {
> +		"schedule_timeout_interruptible",
> +		"schedule_timeout_uninterruptible",
> +		"schedule_timeout_idle",
> +		"schedule_timeout_killable",
> +	};
> +	__u64 addrs[KMULTI_CNT];
> +	int link_fd, i, err = 0;

'err = 0' => 'err'.

> +
> +	qsort(syms, KMULTI_CNT, sizeof(syms[0]), symbols_cmp_r);
> +	opts.syms = syms;
> +	opts.cnt = KMULTI_CNT;
> +	opts.retprobe = retprobe;
> +	skel->links.kmulti_run = bpf_program__attach_kprobe_multi_opts(skel->progs.kmulti_run,
> +								       NULL, &opts);
> +	if (!ASSERT_OK_PTR(skel->links.kmulti_run, "attach_kprobe_multi"))
> +		return;
> +
> +	link_fd = bpf_link__fd(skel->links.kmulti_run);
> +	for (i = 0; i < KMULTI_CNT; i++)
> +		addrs[i] = ksym_get_addr(syms[i]);
> +
> +	if (!buffer)
> +		err = verify_kmulti_link_info(link_fd, addrs, retprobe);
> +	else
> +		verify_kmulti_user_buffer(link_fd, addrs);
> +	ASSERT_OK(err, "verify_kmulti_link_info");

if (!buffer) {
	err = verify_kmulti_link_info(link_fd, addrs, retprobe);
	ASSERT_OK(err, "verify_kmulti_link_info");
} else {
	verify_kmulti_user_buffer(link_fd, addrs);
}

> +	bpf_link__detach(skel->links.kmulti_run);
> +}
> +
[...]

