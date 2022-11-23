Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55870635CB5
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 13:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbiKWMX0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 07:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbiKWMXH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 07:23:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006D595A1
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 04:23:03 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e11so16220011wru.8
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 04:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ns25ATzjLB941UUppT3JuAVyU+HwsxlUNnNXXyQ94c=;
        b=AJGOu6aaLuezpgX8JiBmZh3hGcl3YMWCvQMvMgo25TZVwbsZCtM9sXrP3iU75WIhs6
         /u1Fvr/BWjXCWPmtAw+Hmp9EMXlPi+xgYr4JpsKoJudj8XxyXQVCFCw3FD+UwjMsdM//
         1kJrZYz7fD/BlCcFcj7QtGzR+VN6LrYXlgJNHGsySYc1re3lNFiMdqVAtKKxvn1/5N7o
         eQHNhDJvYXUY2Nt1VarWtihfFUpSIT0QsmoiPnXDHddxAqoEdAdzi17+fJwlgQfpcFQr
         zCByz/3nLAT5Yi70hmSbYZEJmU0Qr0oJ0APBBMEe4xPDqXUcmL3ZwpffQGL2q77obPpk
         48Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ns25ATzjLB941UUppT3JuAVyU+HwsxlUNnNXXyQ94c=;
        b=TuQaf6KHCyP6o2LlXTLTZVAaKjQmjg1wQHTTZTxPKU4enNBcLBxdt8E0E5KlffW7yV
         7iAcw/bHl2hCqfqse+RjSzJG7IBCUzq6k2IeTEcZMa1QThoGclM/oPgH3k78Of/0ZZCw
         +K+0/y12qRO7ue0qCHB0GCJsCIQPEP2BjbeYPnqUoEl0qMhSuxrcCKalmaSl7Zl07jJX
         Jr4Q4jhUT7KRfsevo0pAULzPDhLRzrP803+VM7oxRPQnBx8e4Hbev5oZViSFUg2qpByy
         MKjY0t6Cgu4kkVTuA5Gg5jLW3IZ5kZy+FyQ8YFou9PcHYGU5ZDVb5HhKiReHpOHec0y9
         O0iw==
X-Gm-Message-State: ANoB5pkU/LKkSPkIfV4zXji06qutVVizpPPcrOrV+Dtkw03M7T2kQRIt
        xYMAapiyxinC1Am2SNbrpSI=
X-Google-Smtp-Source: AA0mqf4uzXfya49LzhGKwrf8/rAIFtgLoeWpeCZn3dGxBXHK9tmOClIYW7qnUKqiMR2EoO5nPGJ4BQ==
X-Received: by 2002:a5d:4845:0:b0:241:c1bd:9c75 with SMTP id n5-20020a5d4845000000b00241c1bd9c75mr8907848wrs.422.1669206182314;
        Wed, 23 Nov 2022 04:23:02 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id u14-20020a05600c19ce00b003b3307fb98fsm2447680wmq.24.2022.11.23.04.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 04:23:01 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 23 Nov 2022 13:23:00 +0100
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Make sure zero-len skbs
 aren't redirectable
Message-ID: <Y34QpET78/KX9JLh@krava>
References: <20221121180340.1983627-1-sdf@google.com>
 <20221121180340.1983627-2-sdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121180340.1983627-2-sdf@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 10:03:40AM -0800, Stanislav Fomichev wrote:
> LWT_XMIT to test L3 case, TC to test L2 case.
> 
> v2:
> - s/veth_ifindex/ipip_ifindex/ in two places (Martin)
> - add comment about which condition triggers the rejection (Martin)
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

hi,
I'm getting selftest fails and it looks like it's because of this test:

	[root@qemu bpf]# ./test_progs -n 62,98 
	#62      empty_skb:OK
	execute_one_variant:PASS:skel_open 0 nsec
	execute_one_variant:PASS:my_pid_map_update 0 nsec
	libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter' perf event ID: No such file or directory
	libbpf: prog 'handle_legacy': failed to create tracepoint 'raw_syscalls/sys_enter' perf event: No such file or directory
	libbpf: prog 'handle_legacy': failed to auto-attach: -2
	execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
	test_legacy_printk:FAIL:legacy_case unexpected error: -2 (errno 2)
	execute_one_variant:PASS:skel_open 0 nsec
	libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter' perf event ID: No such file or directory
	libbpf: prog 'handle_modern': failed to create tracepoint 'raw_syscalls/sys_enter' perf event: No such file or directory
	libbpf: prog 'handle_modern': failed to auto-attach: -2
	execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
	#98      legacy_printk:FAIL

	All error logs:
	execute_one_variant:PASS:skel_open 0 nsec
	execute_one_variant:PASS:my_pid_map_update 0 nsec
	libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter' perf event ID: No such file or directory
	libbpf: prog 'handle_legacy': failed to create tracepoint 'raw_syscalls/sys_enter' perf event: No such file or directory
	libbpf: prog 'handle_legacy': failed to auto-attach: -2
	execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
	test_legacy_printk:FAIL:legacy_case unexpected error: -2 (errno 2)
	execute_one_variant:PASS:skel_open 0 nsec
	libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter' perf event ID: No such file or directory
	libbpf: prog 'handle_modern': failed to create tracepoint 'raw_syscalls/sys_enter' perf event: No such file or directory
	libbpf: prog 'handle_modern': failed to auto-attach: -2
	execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
	#98      legacy_printk:FAIL
	Summary: 1/0 PASSED, 0 SKIPPED, 1 FAILED

when I run separately it passes:

	[root@qemu bpf]# ./test_progs -n 98 
	#98      legacy_printk:OK
	Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED


it seems that the open_netns/close_netns does not work properly,
and screw up access to tracefs for following tests

if I comment out all the umounts in setns_by_fd, it does not fail

jirka


> ---
>  .../selftests/bpf/prog_tests/empty_skb.c      | 146 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/empty_skb.c |  37 +++++
>  2 files changed, 183 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/empty_skb.c
>  create mode 100644 tools/testing/selftests/bpf/progs/empty_skb.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
> new file mode 100644
> index 000000000000..32dd731e9070
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include <net/if.h>
> +#include "empty_skb.skel.h"
> +
> +#define SYS(cmd) ({ \
> +	if (!ASSERT_OK(system(cmd), (cmd))) \
> +		goto out; \
> +})
> +
> +void test_empty_skb(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, tattr);
> +	struct empty_skb *bpf_obj = NULL;
> +	struct nstoken *tok = NULL;
> +	struct bpf_program *prog;
> +	char eth_hlen_pp[15];
> +	char eth_hlen[14];
> +	int veth_ifindex;
> +	int ipip_ifindex;
> +	int err;
> +	int i;
> +
> +	struct {
> +		const char *msg;
> +		const void *data_in;
> +		__u32 data_size_in;
> +		int *ifindex;
> +		int err;
> +		int ret;
> +		bool success_on_tc;
> +	} tests[] = {
> +		/* Empty packets are always rejected. */
> +
> +		{
> +			/* BPF_PROG_RUN ETH_HLEN size check */
> +			.msg = "veth empty ingress packet",
> +			.data_in = NULL,
> +			.data_size_in = 0,
> +			.ifindex = &veth_ifindex,
> +			.err = -EINVAL,
> +		},
> +		{
> +			/* BPF_PROG_RUN ETH_HLEN size check */
> +			.msg = "ipip empty ingress packet",
> +			.data_in = NULL,
> +			.data_size_in = 0,
> +			.ifindex = &ipip_ifindex,
> +			.err = -EINVAL,
> +		},
> +
> +		/* ETH_HLEN-sized packets:
> +		 * - can not be redirected at LWT_XMIT
> +		 * - can be redirected at TC to non-tunneling dest
> +		 */
> +
> +		{
> +			/* __bpf_redirect_common */
> +			.msg = "veth ETH_HLEN packet ingress",
> +			.data_in = eth_hlen,
> +			.data_size_in = sizeof(eth_hlen),
> +			.ifindex = &veth_ifindex,
> +			.ret = -ERANGE,
> +			.success_on_tc = true,
> +		},
> +		{
> +			/* __bpf_redirect_no_mac
> +			 *
> +			 * lwt: skb->len=0 <= skb_network_offset=0
> +			 * tc: skb->len=14 <= skb_network_offset=14
> +			 */
> +			.msg = "ipip ETH_HLEN packet ingress",
> +			.data_in = eth_hlen,
> +			.data_size_in = sizeof(eth_hlen),
> +			.ifindex = &ipip_ifindex,
> +			.ret = -ERANGE,
> +		},
> +
> +		/* ETH_HLEN+1-sized packet should be redirected. */
> +
> +		{
> +			.msg = "veth ETH_HLEN+1 packet ingress",
> +			.data_in = eth_hlen_pp,
> +			.data_size_in = sizeof(eth_hlen_pp),
> +			.ifindex = &veth_ifindex,
> +		},
> +		{
> +			.msg = "ipip ETH_HLEN+1 packet ingress",
> +			.data_in = eth_hlen_pp,
> +			.data_size_in = sizeof(eth_hlen_pp),
> +			.ifindex = &ipip_ifindex,
> +		},
> +	};
> +
> +	SYS("ip netns add empty_skb");
> +	tok = open_netns("empty_skb");
> +	SYS("ip link add veth0 type veth peer veth1");
> +	SYS("ip link set dev veth0 up");
> +	SYS("ip link set dev veth1 up");
> +	SYS("ip addr add 10.0.0.1/8 dev veth0");
> +	SYS("ip addr add 10.0.0.2/8 dev veth1");
> +	veth_ifindex = if_nametoindex("veth0");
> +
> +	SYS("ip link add ipip0 type ipip local 10.0.0.1 remote 10.0.0.2");
> +	SYS("ip link set ipip0 up");
> +	SYS("ip addr add 192.168.1.1/16 dev ipip0");
> +	ipip_ifindex = if_nametoindex("ipip0");
> +
> +	bpf_obj = empty_skb__open_and_load();
> +	if (!ASSERT_OK_PTR(bpf_obj, "open skeleton"))
> +		goto out;
> +
> +	for (i = 0; i < ARRAY_SIZE(tests); i++) {
> +		bpf_object__for_each_program(prog, bpf_obj->obj) {
> +			char buf[128];
> +			bool at_tc = !strncmp(bpf_program__section_name(prog), "tc", 2);
> +
> +			tattr.data_in = tests[i].data_in;
> +			tattr.data_size_in = tests[i].data_size_in;
> +
> +			tattr.data_size_out = 0;
> +			bpf_obj->bss->ifindex = *tests[i].ifindex;
> +			bpf_obj->bss->ret = 0;
> +			err = bpf_prog_test_run_opts(bpf_program__fd(prog), &tattr);
> +			sprintf(buf, "err: %s [%s]", tests[i].msg, bpf_program__name(prog));
> +
> +			if (at_tc && tests[i].success_on_tc)
> +				ASSERT_GE(err, 0, buf);
> +			else
> +				ASSERT_EQ(err, tests[i].err, buf);
> +			sprintf(buf, "ret: %s [%s]", tests[i].msg, bpf_program__name(prog));
> +			if (at_tc && tests[i].success_on_tc)
> +				ASSERT_GE(bpf_obj->bss->ret, 0, buf);
> +			else
> +				ASSERT_EQ(bpf_obj->bss->ret, tests[i].ret, buf);
> +		}
> +	}
> +
> +out:
> +	if (bpf_obj)
> +		empty_skb__destroy(bpf_obj);
> +	if (tok)
> +		close_netns(tok);
> +	system("ip netns del empty_skb");
> +}
> diff --git a/tools/testing/selftests/bpf/progs/empty_skb.c b/tools/testing/selftests/bpf/progs/empty_skb.c
> new file mode 100644
> index 000000000000..4b0cd6753251
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/empty_skb.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_endian.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int ifindex;
> +int ret;
> +
> +SEC("lwt_xmit")
> +int redirect_ingress(struct __sk_buff *skb)
> +{
> +	ret = bpf_clone_redirect(skb, ifindex, BPF_F_INGRESS);
> +	return 0;
> +}
> +
> +SEC("lwt_xmit")
> +int redirect_egress(struct __sk_buff *skb)
> +{
> +	ret = bpf_clone_redirect(skb, ifindex, 0);
> +	return 0;
> +}
> +
> +SEC("tc")
> +int tc_redirect_ingress(struct __sk_buff *skb)
> +{
> +	ret = bpf_clone_redirect(skb, ifindex, BPF_F_INGRESS);
> +	return 0;
> +}
> +
> +SEC("tc")
> +int tc_redirect_egress(struct __sk_buff *skb)
> +{
> +	ret = bpf_clone_redirect(skb, ifindex, 0);
> +	return 0;
> +}
> -- 
> 2.38.1.584.g0f3c55d4c2-goog
> 
