Return-Path: <bpf+bounces-9718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D575079C6E0
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 08:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B301C209AF
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 06:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9457D171B9;
	Tue, 12 Sep 2023 06:26:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F425171B1
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 06:26:10 +0000 (UTC)
Received: from out-216.mta0.migadu.com (out-216.mta0.migadu.com [91.218.175.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90122AF
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 23:26:09 -0700 (PDT)
Message-ID: <d8194c20-443e-d574-18c5-cecc7c5ce702@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694499967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXe7Go0n5O6ds1fKh6BJavzWDya8M8+rp8RT20P6NKU=;
	b=nnD52Br7tvg4R5aSIWUWDw3R2FNLzOivMjQtGiYaE9DIkxP/wAyOC0sQqq7Xr/sngBVdzi
	zOCN3HZmOXy8UjpcOmp75a50HbnrraiC1b/eToO5zLG2JxYlhneFf1ZBZYpQp/40FysW6B
	B5zOyW/Edga8JaubZH128iR8d8XCMrQ=
Date: Mon, 11 Sep 2023 23:26:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Offloaded prog after
 non-offloaded should not cause BUG
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
 yonghong.song@linux.dev, sdf@google.com, kuba@kernel.org,
 bpf@vger.kernel.org, ast@kernel.org
References: <20230912005539.2248244-1-eddyz87@gmail.com>
 <20230912005539.2248244-3-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230912005539.2248244-3-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/11/23 5:55 PM, Eduard Zingerman wrote:
> Check what happens if non-offloaded dev bound BPF
> program is followed by offloaded dev bound program.
> Test case adapated from syzbot report [1].
> 
> [1] https://lore.kernel.org/bpf/000000000000d97f3c060479c4f8@google.com/
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   .../bpf/prog_tests/xdp_dev_bound_only.c       | 58 +++++++++++++++++++
>   1 file changed, 58 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c b/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
> new file mode 100644
> index 000000000000..5ee4c16d2e21
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <net/if.h>
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +
> +#define LOCAL_NETNS "xdp_dev_bound_only_netns"
> +
> +int load_dummy_prog(char *name, __u32 ifindex, __u32 flags)

I added static.

> +{
> +	struct bpf_insn insns[] = { BPF_MOV64_IMM(BPF_REG_0, 0), BPF_EXIT_INSN() };
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts);
> +
> +	opts.prog_flags = flags;
> +	opts.prog_ifindex = ifindex;
> +	return bpf_prog_load(BPF_PROG_TYPE_XDP, name, "GPL", insns, ARRAY_SIZE(insns), &opts);
> +}
> +
> +/* A test case for bpf_offload_netdev->offload handling bug:
> + * - create a veth device (does not support offload);
> + * - create a device bound XDP program with BPF_F_XDP_DEV_BOUND_ONLY flag
> + *   (such programs are not offloaded);
> + * - create a device bound XDP program without flags (such programs are offloaded).
> + * This might lead to 'BUG: kernel NULL pointer dereference'.
> + */
> +void test_xdp_dev_bound_only_offdev(void)
> +{
> +	struct nstoken *tok = NULL;
> +	__u32 ifindex;
> +	int fd1 = -1;
> +	int fd2 = -1;
> +
> +	SYS(out, "ip netns add " LOCAL_NETNS);
> +	tok = open_netns(LOCAL_NETNS);

Also added NULL check for tok.

> +	SYS(out, "ip link add eth42 type veth");
> +	ifindex = if_nametoindex("eth42");
> +	if (!ASSERT_NEQ(ifindex, 0, "if_nametoindex")) {
> +		perror("if_nametoindex");
> +		goto out;
> +	}
> +	fd1 = load_dummy_prog("dummy1", ifindex, BPF_F_XDP_DEV_BOUND_ONLY);
> +	if (!ASSERT_GE(fd1, 0, "load_dummy_prog #1")) {
> +		perror("load_dummy_prog #1");
> +		goto out;
> +	}
> +	/* Program with ifindex is considered offloaded, however veth
> +	 * does not support offload => error should be reported.
> +	 */
> +	fd2 = load_dummy_prog("dummy2", ifindex, 0);
> +	ASSERT_EQ(fd2, -EINVAL, "load_dummy_prog #2 (offloaded)");
> +
> +out:
> +	close(fd1);
> +	close(fd2);
> +	SYS_NOFAIL("ip link delete eth42");
> +	SYS_NOFAIL("ip netns del " LOCAL_NETNS);
> +	if (tok)

close_netns() can handle NULL, so removed this tok check.

Applied. Thanks for the fix and test!

> +		close_netns(tok);
> +}


