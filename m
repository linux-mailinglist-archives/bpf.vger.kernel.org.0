Return-Path: <bpf+bounces-15391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5837F1C40
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 19:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29B12825BD
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 18:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B2730651;
	Mon, 20 Nov 2023 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lhF1J45j"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5AEBA
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 10:22:36 -0800 (PST)
Message-ID: <a76c9ee4-d381-477d-b7f6-19f4dc4c0b42@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700504555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qM89Y7HVgHLEBnbdFJcYx2brvgb77OwZUT/vHWZJqn8=;
	b=lhF1J45jIBEhmpfbloaZGuJhgyTLzOOh+vMjPzM3RxCckz7cQwa96dkTp1ZZ5B3tv+SRiG
	d6erABP5toIqvIj0uFxdITtFMNKaaGoBgcfiN5jyQUDZpDcZeMzfjDu/vDNwgm9I+BxT5L
	hJrGezYgC5JzA70IacLMFqLGt1fR8xw=
Date: Mon, 20 Nov 2023 10:22:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bpf-next 5/6] selftests/bpf: Add link_info test for
 uprobe_multi link
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
References: <20231120145639.3179656-1-jolsa@kernel.org>
 <20231120145639.3179656-6-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231120145639.3179656-6-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/20/23 9:56 AM, Jiri Olsa wrote:
> Adding fill_link_info test for uprobe_multi link.
>
> Setting up uprobes with bogus ref_ctr_offsets and cookie values
> to test all the bpf_link_info::uprobe_multi fields.
>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>   .../selftests/bpf/prog_tests/fill_link_info.c | 191 ++++++++++++++++++
>   .../selftests/bpf/progs/test_fill_link_info.c |   6 +
>   2 files changed, 197 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> index 9294cb8d7743..fdf2c6b8c0cf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> @@ -7,6 +7,7 @@
>   #include <test_progs.h>
>   #include "trace_helpers.h"
>   #include "test_fill_link_info.skel.h"
> +#include "bpf/libbpf_internal.h"
>   
>   #define TP_CAT "sched"
>   #define TP_NAME "sched_switch"
> @@ -300,6 +301,189 @@ static void test_kprobe_multi_fill_link_info(struct test_fill_link_info *skel,
>   	bpf_link__destroy(link);
>   }
>   
> +/* Initialize semaphore variables so they don't end up in bss
> + * section and we could get retrieve their offsets.
> + */
> +static short uprobe_link_info_sema_1 = 1;
> +static short uprobe_link_info_sema_2 = 1;
> +static short uprobe_link_info_sema_3 = 1;

I guess The typical sema value starting value should be 0, right?
If this is the case, the above is not a good example.
So the issue is that current libbpf does not support
retrieving offset from .bss section? Do you know why?

In selftest udst.c, we have semaphore defined as
usdt.c:unsigned short test_usdt0_semaphore SEC(".probes");
usdt.c:unsigned short test_usdt3_semaphore SEC(".probes");
usdt.c:unsigned short test_usdt12_semaphore SEC(".probes");

Will the following work?
static short uprobe_link_info_sema_1 SEC(".probes");
...

> +
> +noinline void uprobe_link_info_func_1(void)
> +{
> +	uprobe_link_info_sema_1++;
> +	asm volatile ("");

The 'asm volatile' above intends to prevent compiler from
doing 'implicit' inlining. So as a convention let us
switch statement order to

	asm volatile ("");
	uprobe_link_info_sema_1++;

Similarly for below.

> +}
> +
> +noinline void uprobe_link_info_func_2(void)
> +{
> +	uprobe_link_info_sema_2++;
> +	asm volatile ("");
> +}
> +
> +noinline void uprobe_link_info_func_3(void)
> +{
> +	uprobe_link_info_sema_3++;
> +	asm volatile ("");
> +}
> +
> +static int
> +verify_umulti_link_info(int fd, bool retprobe, __u64 *offsets,
> +			__u64 *cookies, __u64 *ref_ctr_offsets)
> +{
> +	char path[PATH_MAX], path_buf[PATH_MAX];
> +	struct bpf_link_info info;
> +	__u32 len = sizeof(info);
> +	__u64 ref_ctr_offsets_buf[3];
> +	__u64 offsets_buf[3];
> +	__u64 cookies_buf[3];
> +	int i, err, bit;
> +	__u32 count = 0;
> +
> +	memset(path, 0, sizeof(path));
> +	err = readlink("/proc/self/exe", path, sizeof(path));
> +	if (!ASSERT_NEQ(err, -1, "readlink"))
> +		return -1;
> +
> +	for (bit = 0; bit < 8; bit++) {
> +		memset(&info, 0, sizeof(info));
> +		info.uprobe_multi.path = ptr_to_u64(path_buf);
> +		info.uprobe_multi.path_size = sizeof(path_buf);
> +		info.uprobe_multi.count = count;
> +
> +		if (bit & 0x1)
> +			info.uprobe_multi.offsets = ptr_to_u64(offsets_buf);
> +		if (bit & 0x2)
> +			info.uprobe_multi.cookies = ptr_to_u64(cookies_buf);
> +		if (bit & 0x4)
> +			info.uprobe_multi.ref_ctr_offsets = ptr_to_u64(ref_ctr_offsets_buf);
> +
> +		err = bpf_link_get_info_by_fd(fd, &info, &len);
> +		if (!ASSERT_OK(err, "bpf_link_get_info_by_fd"))
> +			return -1;
> +
> +		if (!ASSERT_EQ(info.type, BPF_LINK_TYPE_UPROBE_MULTI, "info.type"))
> +			return -1;
> +
> +		ASSERT_EQ(info.uprobe_multi.pid, getpid(), "info.uprobe_multi.pid");
> +		ASSERT_EQ(info.uprobe_multi.count, 3, "info.uprobe_multi.count");
> +		ASSERT_EQ(info.uprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN,
> +			  retprobe, "info.uprobe_multi.flags.retprobe");
> +		ASSERT_EQ(info.uprobe_multi.path_size, strlen(path), "info.uprobe_multi.path_size");
> +		ASSERT_STREQ(path_buf, path, "info.uprobe_multi.path");
> +
> +		for (i = 0; i < info.uprobe_multi.count; i++) {
> +			if (info.uprobe_multi.offsets)
> +				ASSERT_EQ(offsets_buf[i], offsets[i], "info.uprobe_multi.offsets");
> +			if (info.uprobe_multi.cookies)
> +				ASSERT_EQ(cookies_buf[i], cookies[i], "info.uprobe_multi.cookies");
> +			if (info.uprobe_multi.ref_ctr_offsets) {
> +				ASSERT_EQ(ref_ctr_offsets_buf[i], ref_ctr_offsets[i],
> +					  "info.uprobe_multi.ref_ctr_offsets");
> +			}
> +		}
> +		count = count ?: info.uprobe_multi.count;
> +	}
> +
> +	return 0;
> +}
> +
> +static void verify_umulti_invalid_user_buffer(int fd)
> +{
> +	struct bpf_link_info info;
> +	__u32 len = sizeof(info);
> +	__u64 buf[3];
> +	int err;
> +
> +	/* upath_size defined, not path */
> +	memset(&info, 0, sizeof(info));
> +	info.uprobe_multi.path_size = 3;
> +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> +	ASSERT_EQ(err, -EINVAL, "failed_upath_size");
> +
> +	/* path has wrong pointer */
> +	memset(&info, 0, sizeof(info));
> +	info.uprobe_multi.path_size = PATH_MAX;
> +	info.uprobe_multi.path = 123;
> +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> +	ASSERT_EQ(err, -EFAULT, "failed_bad_path_ptr");
> +
> +	/* count zero, with offsets */
> +	memset(&info, 0, sizeof(info));
> +	info.uprobe_multi.offsets = ptr_to_u64(buf);
> +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> +	ASSERT_EQ(err, -EINVAL, "failed_count");
> +
> +	/* offsets not big enough */
> +	memset(&info, 0, sizeof(info));
> +	info.uprobe_multi.offsets = ptr_to_u64(buf);
> +	info.uprobe_multi.count = 2;
> +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> +	ASSERT_EQ(err, -ENOSPC, "failed_small_count");
> +
> +	/* offsets has wrong pointer */
> +	memset(&info, 0, sizeof(info));
> +	info.uprobe_multi.offsets = 123;
> +	info.uprobe_multi.count = 3;
> +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> +	ASSERT_EQ(err, -EFAULT, "failed_wrong_offsets");
> +}
> +
> +static void test_uprobe_multi_fill_link_info(struct test_fill_link_info *skel,
> +					     bool retprobe, bool invalid)
> +{
> +	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts,
> +		.retprobe = retprobe,
> +	);
> +	const char *syms[3] = {
> +		"uprobe_link_info_func_1",
> +		"uprobe_link_info_func_2",
> +		"uprobe_link_info_func_3",
> +	};
> +	__u64 cookies[3] = {
> +		0xdead,
> +		0xbeef,
> +		0xcafe,
> +	};
> +	const char *sema[3] = {
> +		"uprobe_link_info_sema_1",
> +		"uprobe_link_info_sema_2",
> +		"uprobe_link_info_sema_3",
> +	};
> +	__u64 *offsets, *ref_ctr_offsets;
> +	struct bpf_link *link;
> +	int link_fd, err;
> +
> +	err = elf_resolve_syms_offsets("/proc/self/exe", 3, sema,
> +				       (unsigned long **) &ref_ctr_offsets, STT_OBJECT);
> +	if (!ASSERT_OK(err, "elf_resolve_syms_offsets_object"))
> +		return;
> +
> +	err = elf_resolve_syms_offsets("/proc/self/exe", 3, syms,
> +				       (unsigned long **) &offsets, STT_FUNC);
> +	if (!ASSERT_OK(err, "elf_resolve_syms_offsets_func"))
> +		return;

potential leak of ref_ctr_offsets?

> +
> +	opts.syms = syms;
> +	opts.cookies = &cookies[0];
> +	opts.ref_ctr_offsets = (unsigned long *) &ref_ctr_offsets[0];
> +	opts.cnt = ARRAY_SIZE(syms);
> +
> +	link = bpf_program__attach_uprobe_multi(skel->progs.umulti_run, 0,
> +						"/proc/self/exe", NULL, &opts);
> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
> +		goto out;
> +
> +	link_fd = bpf_link__fd(link);
> +	if (invalid)
> +		verify_umulti_invalid_user_buffer(link_fd);
> +	else
> +		verify_umulti_link_info(link_fd, retprobe, offsets, cookies, ref_ctr_offsets);
> +
> +	bpf_link__destroy(link);
> +out:
> +	free(offsets);

Should we free ref_ctr_offsets here?

> +}
> +
> [...]

