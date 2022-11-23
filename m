Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144F86366CF
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 18:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbiKWRRr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 12:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239234AbiKWRRk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 12:17:40 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17EC2180
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 09:17:35 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-391bd92f931so165976237b3.22
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 09:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/aF6BmW5fOCO1WxpD6DgG/ICn9kSD6WsSvGML1HrVcc=;
        b=SFXXCSgALTEZt4rgEYXgIb6M5ATh1LYo4WngrI0Kez/gkrFOvS52gzMHXmN5mZDOPn
         5BKwAXyxtSr/FtthwiKdJTt429LSHa3TwbXPfcKq+7VQUjERRKLTFrudxfXHPBDSonyw
         Z/jBld353anouOUBGpJTA1Bwul25a/FjVTm991gD0FAgXAKej9Zy003xeAWlnXXqIO7P
         FFpZbG5TVehH6+hXCS2d62CX6mLX1pThqKzz0djKVPad2fXNEJFz+B8Qb10WDsq5W+s6
         OVYpB/Teo/EsQkiS0/OhisOHmrVLvmyfxBWMOwspOByrEpRCbZkcVjZ+hCXwzG/96eZb
         g9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/aF6BmW5fOCO1WxpD6DgG/ICn9kSD6WsSvGML1HrVcc=;
        b=JyfMwKUd3goe3gCwaRyBL6rDJIiTylBtNixDNlffsxW2+40JPQGVSBb+mgVVBJdizS
         v5GavvAKarwBlWjar/jgR/SbAtX+bq0sDVwzp7XqYwq8fN9okmw//bMxdyzmiITTnj3F
         aAQs35zoz0ejAwdQichnuZt3BRQt37peweHm9E9A0VIRhYzOOT4zPcGUTjl1nW1t0nVh
         jgAPmz8o0/y4VvEiqlFjrrMV1mQGM7XuLh872A6rEUW0z0H0/yTcOSZpS0h8X/8ee8mo
         27WPz/tAfY1TOR8dN2XmXW+/t9I4OHzZf0ChvVNrPh6I0YiT4GLNynhGoEPWr+l8kleT
         QvYA==
X-Gm-Message-State: ANoB5pl80taCfObX03Yddn5BeSL3L/jgT7S+Be5pXyPaRjLF1QPHwW/I
        O2BOxg0rEn5v7zdurxwkIT0977U=
X-Google-Smtp-Source: AA0mqf79dlioUb5EbJS51KymRRMfv6izuQZI4WCzCRGXKAFT/NUFkSTWCwktR7VgG+8+XTBzhrUvFCc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:4193:0:b0:6f0:118d:f775 with SMTP id
 o141-20020a254193000000b006f0118df775mr3521957yba.295.1669223855151; Wed, 23
 Nov 2022 09:17:35 -0800 (PST)
Date:   Wed, 23 Nov 2022 09:17:33 -0800
In-Reply-To: <34cb2b2f-ac3b-65c4-c479-0c4ed3dda096@meta.com>
Mime-Version: 1.0
References: <20221121180340.1983627-1-sdf@google.com> <20221121180340.1983627-2-sdf@google.com>
 <Y34QpET78/KX9JLh@krava> <34cb2b2f-ac3b-65c4-c479-0c4ed3dda096@meta.com>
Message-ID: <Y35VrXvKBFg2RJ7y@google.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Make sure zero-len skbs
 aren't redirectable
From:   sdf@google.com
To:     Yonghong Song <yhs@meta.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/23, Yonghong Song wrote:


> On 11/23/22 4:23 AM, Jiri Olsa wrote:
> > On Mon, Nov 21, 2022 at 10:03:40AM -0800, Stanislav Fomichev wrote:
> > > LWT_XMIT to test L3 case, TC to test L2 case.
> > >
> > > v2:
> > > - s/veth_ifindex/ipip_ifindex/ in two places (Martin)
> > > - add comment about which condition triggers the rejection (Martin)
> > >
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> >
> > hi,
> > I'm getting selftest fails and it looks like it's because of this test:
> >
> > 	[root@qemu bpf]# ./test_progs -n 62,98
> > 	#62      empty_skb:OK
> > 	execute_one_variant:PASS:skel_open 0 nsec
> > 	execute_one_variant:PASS:my_pid_map_update 0 nsec
> > 	libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter' perf  
> event ID: No such file or directory
> > 	libbpf: prog 'handle_legacy': failed to create  
> tracepoint 'raw_syscalls/sys_enter' perf event: No such file or directory
> > 	libbpf: prog 'handle_legacy': failed to auto-attach: -2
> > 	execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
> > 	test_legacy_printk:FAIL:legacy_case unexpected error: -2 (errno 2)
> > 	execute_one_variant:PASS:skel_open 0 nsec
> > 	libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter' perf  
> event ID: No such file or directory
> > 	libbpf: prog 'handle_modern': failed to create  
> tracepoint 'raw_syscalls/sys_enter' perf event: No such file or directory
> > 	libbpf: prog 'handle_modern': failed to auto-attach: -2
> > 	execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
> > 	#98      legacy_printk:FAIL
> >
> > 	All error logs:
> > 	execute_one_variant:PASS:skel_open 0 nsec
> > 	execute_one_variant:PASS:my_pid_map_update 0 nsec
> > 	libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter' perf  
> event ID: No such file or directory
> > 	libbpf: prog 'handle_legacy': failed to create  
> tracepoint 'raw_syscalls/sys_enter' perf event: No such file or directory
> > 	libbpf: prog 'handle_legacy': failed to auto-attach: -2
> > 	execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
> > 	test_legacy_printk:FAIL:legacy_case unexpected error: -2 (errno 2)
> > 	execute_one_variant:PASS:skel_open 0 nsec
> > 	libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter' perf  
> event ID: No such file or directory
> > 	libbpf: prog 'handle_modern': failed to create  
> tracepoint 'raw_syscalls/sys_enter' perf event: No such file or directory
> > 	libbpf: prog 'handle_modern': failed to auto-attach: -2
> > 	execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
> > 	#98      legacy_printk:FAIL
> > 	Summary: 1/0 PASSED, 0 SKIPPED, 1 FAILED
> >
> > when I run separately it passes:
> >
> > 	[root@qemu bpf]# ./test_progs -n 98
> > 	#98      legacy_printk:OK
> > 	Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> >
> >
> > it seems that the open_netns/close_netns does not work properly,
> > and screw up access to tracefs for following tests
> >
> > if I comment out all the umounts in setns_by_fd, it does not fail

> Agreed with the above observations.
> With the current bpf-next, I can easily hit the above perf event ID issue.

> But if I backout the following two patches:
> 68f8e3d4b916531ea3bb8b83e35138cf78f2fce5 selftests/bpf: Make sure zero-len
> skbs aren't redirectable
> 114039b342014680911c35bd6b72624180fd669a bpf: Move skb->len == 0 checks  
> into
> __bpf_redirect


> and run a few times with './test_progs -j' and I didn't hit any issues.

My guess would be that we need to remount debugfs in setns_by_fd?

diff --git a/tools/testing/selftests/bpf/network_helpers.c  
b/tools/testing/selftests/bpf/network_helpers.c
index bec15558fd93..1f37adff7632 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -426,6 +426,10 @@ static int setns_by_fd(int nsfd)
  	if (!ASSERT_OK(err, "mount /sys/fs/bpf"))
  		return err;

+	err = mount("debugfs", "/sys/kernel/debug", "debugfs", 0, NULL);
+	if (!ASSERT_OK(err, "mount /sys/kernel/debug"))
+		return err;
+
  	return 0;
  }


> >
> > jirka
> >
> >
> > > ---
> > >   .../selftests/bpf/prog_tests/empty_skb.c      | 146  
> ++++++++++++++++++
> > >   tools/testing/selftests/bpf/progs/empty_skb.c |  37 +++++
> > >   2 files changed, 183 insertions(+)
> > >   create mode 100644  
> tools/testing/selftests/bpf/prog_tests/empty_skb.c
> > >   create mode 100644 tools/testing/selftests/bpf/progs/empty_skb.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c  
> b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
> > > new file mode 100644
> > > index 000000000000..32dd731e9070
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
> > > @@ -0,0 +1,146 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include <test_progs.h>
> > > +#include <network_helpers.h>
> > > +#include <net/if.h>
> > > +#include "empty_skb.skel.h"
> > > +
> > > +#define SYS(cmd) ({ \
> > > +	if (!ASSERT_OK(system(cmd), (cmd))) \
> > > +		goto out; \
> > > +})
> > > +
> > > +void test_empty_skb(void)
> > > +{
> > > +	LIBBPF_OPTS(bpf_test_run_opts, tattr);
> > > +	struct empty_skb *bpf_obj = NULL;
> > > +	struct nstoken *tok = NULL;
> > > +	struct bpf_program *prog;
> > > +	char eth_hlen_pp[15];
> > > +	char eth_hlen[14];
> > > +	int veth_ifindex;
> > > +	int ipip_ifindex;
> > > +	int err;
> > > +	int i;
> > > +
> > > +	struct {
> > > +		const char *msg;
> > > +		const void *data_in;
> > > +		__u32 data_size_in;
> > > +		int *ifindex;
> > > +		int err;
> > > +		int ret;
> > > +		bool success_on_tc;
> > > +	} tests[] = {
> > > +		/* Empty packets are always rejected. */
> > > +
> > > +		{
> > > +			/* BPF_PROG_RUN ETH_HLEN size check */
> > > +			.msg = "veth empty ingress packet",
> > > +			.data_in = NULL,
> > > +			.data_size_in = 0,
> > > +			.ifindex = &veth_ifindex,
> > > +			.err = -EINVAL,
> > > +		},
> > > +		{
> > > +			/* BPF_PROG_RUN ETH_HLEN size check */
> > > +			.msg = "ipip empty ingress packet",
> > > +			.data_in = NULL,
> > > +			.data_size_in = 0,
> > > +			.ifindex = &ipip_ifindex,
> > > +			.err = -EINVAL,
> > > +		},
> > > +
> > > +		/* ETH_HLEN-sized packets:
> > > +		 * - can not be redirected at LWT_XMIT
> > > +		 * - can be redirected at TC to non-tunneling dest
> > > +		 */
> > > +
> > > +		{
> > > +			/* __bpf_redirect_common */
> > > +			.msg = "veth ETH_HLEN packet ingress",
> > > +			.data_in = eth_hlen,
> > > +			.data_size_in = sizeof(eth_hlen),
> > > +			.ifindex = &veth_ifindex,
> > > +			.ret = -ERANGE,
> > > +			.success_on_tc = true,
> > > +		},
> > > +		{
> > > +			/* __bpf_redirect_no_mac
> > > +			 *
> > > +			 * lwt: skb->len=0 <= skb_network_offset=0
> > > +			 * tc: skb->len=14 <= skb_network_offset=14
> > > +			 */
> > > +			.msg = "ipip ETH_HLEN packet ingress",
> > > +			.data_in = eth_hlen,
> > > +			.data_size_in = sizeof(eth_hlen),
> > > +			.ifindex = &ipip_ifindex,
> > > +			.ret = -ERANGE,
> > > +		},
> > > +
> > > +		/* ETH_HLEN+1-sized packet should be redirected. */
> > > +
> > > +		{
> > > +			.msg = "veth ETH_HLEN+1 packet ingress",
> > > +			.data_in = eth_hlen_pp,
> > > +			.data_size_in = sizeof(eth_hlen_pp),
> > > +			.ifindex = &veth_ifindex,
> > > +		},
> > > +		{
> > > +			.msg = "ipip ETH_HLEN+1 packet ingress",
> > > +			.data_in = eth_hlen_pp,
> > > +			.data_size_in = sizeof(eth_hlen_pp),
> > > +			.ifindex = &ipip_ifindex,
> > > +		},
> > > +	};
> > > +
> > > +	SYS("ip netns add empty_skb");
> > > +	tok = open_netns("empty_skb");
> > > +	SYS("ip link add veth0 type veth peer veth1");
> > > +	SYS("ip link set dev veth0 up");
> > > +	SYS("ip link set dev veth1 up");
> > > +	SYS("ip addr add 10.0.0.1/8 dev veth0");
> > > +	SYS("ip addr add 10.0.0.2/8 dev veth1");
> > > +	veth_ifindex = if_nametoindex("veth0");
> > > +
> > > +	SYS("ip link add ipip0 type ipip local 10.0.0.1 remote 10.0.0.2");
> > > +	SYS("ip link set ipip0 up");
> > > +	SYS("ip addr add 192.168.1.1/16 dev ipip0");
> > > +	ipip_ifindex = if_nametoindex("ipip0");
> > > +
> > > +	bpf_obj = empty_skb__open_and_load();
> > > +	if (!ASSERT_OK_PTR(bpf_obj, "open skeleton"))
> > > +		goto out;
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(tests); i++) {
> > > +		bpf_object__for_each_program(prog, bpf_obj->obj) {
> > > +			char buf[128];
> > > +			bool at_tc = !strncmp(bpf_program__section_name(prog), "tc", 2);
> > > +
> > > +			tattr.data_in = tests[i].data_in;
> > > +			tattr.data_size_in = tests[i].data_size_in;
> > > +
> > > +			tattr.data_size_out = 0;
> > > +			bpf_obj->bss->ifindex = *tests[i].ifindex;
> > > +			bpf_obj->bss->ret = 0;
> > > +			err = bpf_prog_test_run_opts(bpf_program__fd(prog), &tattr);
> > > +			sprintf(buf, "err: %s [%s]", tests[i].msg,  
> bpf_program__name(prog));
> > > +
> > > +			if (at_tc && tests[i].success_on_tc)
> > > +				ASSERT_GE(err, 0, buf);
> > > +			else
> > > +				ASSERT_EQ(err, tests[i].err, buf);
> > > +			sprintf(buf, "ret: %s [%s]", tests[i].msg,  
> bpf_program__name(prog));
> > > +			if (at_tc && tests[i].success_on_tc)
> > > +				ASSERT_GE(bpf_obj->bss->ret, 0, buf);
> > > +			else
> > > +				ASSERT_EQ(bpf_obj->bss->ret, tests[i].ret, buf);
> > > +		}
> > > +	}
> > > +
> > > +out:
> > > +	if (bpf_obj)
> > > +		empty_skb__destroy(bpf_obj);
> > > +	if (tok)
> > > +		close_netns(tok);
> > > +	system("ip netns del empty_skb");
> > > +}
> > > diff --git a/tools/testing/selftests/bpf/progs/empty_skb.c  
> b/tools/testing/selftests/bpf/progs/empty_skb.c
> > > new file mode 100644
> > > index 000000000000..4b0cd6753251
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/empty_skb.c
> > > @@ -0,0 +1,37 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> > > +#include <linux/bpf.h>
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <bpf/bpf_endian.h>
> > > +
> > > +char _license[] SEC("license") = "GPL";
> > > +
> > > +int ifindex;
> > > +int ret;
> > > +
> > > +SEC("lwt_xmit")
> > > +int redirect_ingress(struct __sk_buff *skb)
> > > +{
> > > +	ret = bpf_clone_redirect(skb, ifindex, BPF_F_INGRESS);
> > > +	return 0;
> > > +}
> > > +
> > > +SEC("lwt_xmit")
> > > +int redirect_egress(struct __sk_buff *skb)
> > > +{
> > > +	ret = bpf_clone_redirect(skb, ifindex, 0);
> > > +	return 0;
> > > +}
> > > +
> > > +SEC("tc")
> > > +int tc_redirect_ingress(struct __sk_buff *skb)
> > > +{
> > > +	ret = bpf_clone_redirect(skb, ifindex, BPF_F_INGRESS);
> > > +	return 0;
> > > +}
> > > +
> > > +SEC("tc")
> > > +int tc_redirect_egress(struct __sk_buff *skb)
> > > +{
> > > +	ret = bpf_clone_redirect(skb, ifindex, 0);
> > > +	return 0;
> > > +}
> > > --
> > > 2.38.1.584.g0f3c55d4c2-goog
> > >
