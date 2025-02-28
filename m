Return-Path: <bpf+bounces-52855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1D8A491C1
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 07:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBA816F737
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 06:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB19B1C330D;
	Fri, 28 Feb 2025 06:47:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5153139E;
	Fri, 28 Feb 2025 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740725257; cv=none; b=quto0odL4w0kSApgDnjhzfRdnw2eoPFYRobVglaqxdX4z+It7FSv4jup0B6tYGL2iCa61kW4S18paF5/SsMLxcTP0RR+a52dru3JL6fSTjWgPwmH9A4XcGT4ePXvPMvrZdEO1v+H2zMSlcOuV6y3XtvY19C/Z6ZzCyXE4mVX8Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740725257; c=relaxed/simple;
	bh=8erFOBCpRW578JQFMdC00ciuQNyiLf0rz4V10MaBu64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H37KGdqOZorkAWEinLroAMcwVBTQg/tF1I1gQPBEDmji+xWJlCE9hZT74JbQMgofw6PNTLYEk4SFh+MtdnSL+DTBzfp/gCbQsKBnm56QXZOrd/ppq2w1AgFshbsgU1b3aJCXdTqFFMthVLHBfMDm3UWvsXS3nF/P6NX9ceKSMfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z3zDs0hSKz1ltZG;
	Fri, 28 Feb 2025 14:43:25 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id ECA3A14037C;
	Fri, 28 Feb 2025 14:47:30 +0800 (CST)
Received: from kwepemn200003.china.huawei.com (7.202.194.126) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Feb 2025 14:47:30 +0800
Received: from localhost.localdomain (10.175.101.6) by
 kwepemn200003.china.huawei.com (7.202.194.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Feb 2025 14:47:29 +0800
From: zhangmingyi <zhangmingyi5@huawei.com>
To: <martin.lau@linux.dev>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<song@kernel.org>, <yhs@fb.com>, <john.fastabend@gmail.com>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yanan@huawei.com>, <wuchangye@huawei.com>, <xiesongyang@huawei.com>,
	<liuxin350@huawei.com>, <liwei883@huawei.com>, <tianmuyang@huawei.com>,
	<zhangmingyi5@huawei.com>
Subject: Re: [PATCH v2 2/2] bpf-next: selftest for TCP_ULP in bpf_setsockopt
Date: Fri, 28 Feb 2025 14:44:42 +0800
Message-ID: <20250228064442.3218835-1-zhangmingyi5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <4533d108-9617-4021-b7a9-befe209926da@linux.dev>
References: <4533d108-9617-4021-b7a9-befe209926da@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn200003.china.huawei.com (7.202.194.126)

On 2/13/25 3:19 PM, Martin KaFai Lau wrote:
> On 2/10/25 5:45 AM, zhangmingyi wrote:
> > From: Mingyi Zhang <zhangmingyi5@huawei.com>
> > 
> > We try to use bpf_set/getsockopt to set/get TCP_ULP in sockops, and "tls"
> > need connect is established.To avoid impacting other test cases, I 
> > have written a separate test case file.
> > 
> > Signed-off-by: Mingyi Zhang <zhangmingyi5@huawei.com>
> > Signed-off-by: Xin Liu <liuxin350@huawei.com>
> > ---
> >   .../bpf/prog_tests/setget_sockopt_tcp_ulp.c   | 78 +++++++++++++++++++
> >   .../bpf/progs/setget_sockopt_tcp_ulp.c        | 33 ++++++++
> >   2 files changed, 111 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/setget_sockopt_tcp_ulp.c
> >   create mode 100644 
> > tools/testing/selftests/bpf/progs/setget_sockopt_tcp_ulp.c
> > 
> > diff --git 
> > a/tools/testing/selftests/bpf/prog_tests/setget_sockopt_tcp_ulp.c 
> > b/tools/testing/selftests/bpf/prog_tests/setget_sockopt_tcp_ulp.c
> > new file mode 100644
> > index 000000000000..748da2c7d255
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt_tcp_ulp.c
> > @@ -0,0 +1,78 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) Meta Platforms, Inc. and affiliates. */
> 
> This is not right.
> 
> > +
> > +#define _GNU_SOURCE
> > +#include <net/if.h>
> > +
> > +#include "test_progs.h"
> > +#include "network_helpers.h"
> > +
> > +#include "setget_sockopt_tcp_ulp.skel.h"
> > +
> > +#define CG_NAME "/setget-sockopt-tcp-ulp-test"
> > +
> > +static const char addr4_str[] = "127.0.0.1"; static const char 
> > +addr6_str[] = "::1"; static struct setget_sockopt_tcp_ulp *skel; 
> > +static int cg_fd;
> > +
> > +static int create_netns(void)
> > +{
> > +	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
> > +		return -1;
> > +	if (!ASSERT_OK(system("ip link set dev lo up"), "set lo up"))
> > +		return -1;
> > +	return 0;
> > +}
> > +
> > +static int modprobe_tls(void)
> > +{
> > +	if (!ASSERT_OK(system("modprobe tls"), "tls modprobe failed"))
> > +		return -1;
> > +	return 0;
> > +}
> > +
> > +static void test_tcp_ulp(int family)
> 
> First, the bpf CI still fails to compile for the same reason as v1. You should 
> have received an email from bpf CI bot. Please ensure it is addressed first 
> before reposting. This repeated bpf CI error is an automatic nack.
> 

I'm sorry I didn't notice this and I'll fix this in the next patch

> pw-bot: cr
> 
> The subject tagging should be "[PATCH v2 bpf-next ...] selftests/bpf: ... ". 
> There are many examples to follow in the mailing list if it is not clear.
> 
> Regarding the v1 comment: "...separate it out into its own BPF program..."
> 
> The comment was made at the bpf prog file, "progs/setget_sockopt.c". I meant 
> only create a separate bpf program. The user space part can stay in 
> prog_tests/setget_sockopt.c.
> 
> Move this function, test_tcp_ulp, to prog_tests/setget_sockopt.c. Then all the 
> above config preparation codes and the test_setget_sockopt_tcp_ulp() can be 
> saved. modprobe_tls() is not needed also. Do it after the test_ktls().
> Take a look at test_nonstandard_opt() in prog_tests/setget_sockopt.c.
> It is testing another bpf prog in the same prog_tests/setget_sockopt.c.
>

Well, it seems that I misunderstood you, and I'll change it according to
your intentions.
 
> Also, for the bpf prog, do you really need to test at 
> BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB? If not, just testing at 
> SEC("lsm_cgroup/socket_post_create") will be easier. You can detach the 
> previously attached skel->links.socket_post_create by using bpf_link__destroy() 
> first and then attach yours bpf prog to do the test.

My idea is that since tls needs to be setockopt after the link is established,
it would be easier for me to test BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB in
sockops ebpf program.

> > +{
> > +	struct setget_sockopt_tcp_ulp__bss *bss = skel->bss;
> > +	int sfd, cfd;
> > +
> > +	memset(bss, 0, sizeof(*bss));
> > +	sfd = start_server(family, SOCK_STREAM,
> > +			   family == AF_INET6 ? addr6_str : addr4_str, 0, 0);
> > +	if (!ASSERT_GE(sfd, 0, "start_server"))
> > +		return;
> > +
> > +	cfd = connect_to_fd(sfd, 0);
> > +	if (!ASSERT_GE(cfd, 0, "connect_to_fd_server")) {
> > +		close(sfd);
> > +		return;
> > +	}
> > +	close(sfd);
> > +	close(cfd);
> > +
> > +	ASSERT_EQ(bss->nr_tcp_ulp, 3, "nr_tcp_ulp"); }
> > +
> > +void test_setget_sockopt_tcp_ulp(void) {
> > +	cg_fd = test__join_cgroup(CG_NAME);
> > +	if (cg_fd < 0)
> > +		return;
> > +	if (create_netns() && modprobe_tls())
> > +		goto done;
> > +	skel = setget_sockopt_tcp_ulp__open();
> > +	if (!ASSERT_OK_PTR(skel, "open skel"))
> > +		goto done;
> > +	if (!ASSERT_OK(setget_sockopt_tcp_ulp__load(skel), "load skel"))
> > +		goto done;
> > +	skel->links.skops_sockopt_tcp_ulp =
> > +		bpf_program__attach_cgroup(skel->progs.skops_sockopt_tcp_ulp, cg_fd);
> > +	if (!ASSERT_OK_PTR(skel->links.skops_sockopt_tcp_ulp, "attach_cgroup"))
> > +		goto done;
> > +	test_tcp_ulp(AF_INET);
> > +	test_tcp_ulp(AF_INET6);
> > +done:
> > +	setget_sockopt_tcp_ulp__destroy(skel);
> > +	close(cg_fd);
> > +}
> > diff --git 
> > a/tools/testing/selftests/bpf/progs/setget_sockopt_tcp_ulp.c 
> > b/tools/testing/selftests/bpf/progs/setget_sockopt_tcp_ulp.c
> > new file mode 100644
> > index 000000000000..bd1009766463
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/setget_sockopt_tcp_ulp.c
> > @@ -0,0 +1,33 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) Meta Platforms, Inc. and affiliates. */
> 
> Same here.
> 
> > +
> > +#include "vmlinux.h"
> > +#include "bpf_tracing_net.h"
> > +#include <bpf/bpf_helpers.h>
> > +
> > +int nr_tcp_ulp;
> > +
> > +SEC("sockops")
> > +int skops_sockopt_tcp_ulp(struct bpf_sock_ops *skops) {
> > +	static const char target_ulp[] = "tls";
> > +	char verify_ulp[sizeof(target_ulp)];
> > +
> > +	switch (skops->op) {
> > +	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
> > +		if (bpf_setsockopt(skops, IPPROTO_TCP, TCP_ULP, (void *)target_ulp,
> > +							sizeof(target_ulp)) != 0)
> > +			return 1;
> > +		nr_tcp_ulp++;
> > +		if (bpf_getsockopt(skops, IPPROTO_TCP, TCP_ULP, verify_ulp,
> > +							sizeof(verify_ulp)) != 0)
> > +			return 1;
> > +		nr_tcp_ulp++;
> > +		if (bpf_strncmp(verify_ulp, sizeof(target_ulp), "tls") != 0)
> > +			return 1;
> > +		nr_tcp_ulp++;
> > +	}
> > +	return 1;
> > +}
> > +
> > +char _license[] SEC("license") = "GPL";
> > \ No newline at end of file
> 

