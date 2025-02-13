Return-Path: <bpf+bounces-51333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD01A33465
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 02:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5563A3F66
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 01:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E382C7082F;
	Thu, 13 Feb 2025 01:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="djyt42cF"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375016FC3
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739408913; cv=none; b=jCO6KsVHEqz7xOkfhBdeiU3ff2hj2IRXnq6HJ5p12Jssq+S84PSYs84to4Akh3OTUV1bPtn+llNa8cZKpcgycAH8GRYVR20Sim/0NubpaFAd3pg2pWcyQVqfqDqszLjb1/zZR+Lp1W8fjhYnyUF9ZDtLglPIgw0ht3IydGh1PdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739408913; c=relaxed/simple;
	bh=PMmIPAgsqFOn0YIn7JOjg/LM/WhKKAyJD2E/XFiw+OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2FhKiTgZtUpdRf2yK4BlfLKzn/L9PfVbjqGbFHjVJen1dcURWcwDALVR5a0qffH0zk15+fofZQ7+YgUHG0G5yqnGWYFz9P4hlkwXp90EnxhvDIMHfwe8oX2IJp6QluNx6cQYPBAUEEug5EA8idVZMLZoemZRB541RRSfjMnawY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=djyt42cF; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4e51fae2-0b43-426f-8fae-ea267fe2839f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739408907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0FiEdnI/5PV2tOdLNOpW9wnUSqBg5piDnE+78JJgz4=;
	b=djyt42cFrjwns2v/ZfroXwFSvZOoFtz52uOYFIRpGOL9Xx+WR5loFFvfbcaDp+Te7ROWW6
	ygfFoU8TmkafWFlnWCPYKl1CNfn1K7t15H4bdiUNv1OZNs888B1SEqna4iSyhUUvsFWGcG
	3HrQOT0hIPGkVMWC3A+qJmf3vMqwBv8=
Date: Wed, 12 Feb 2025 17:08:18 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 12/12] selftests/bpf: add simple bpf tests in
 the tx path for timestamping feature
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
 <20250212061855.71154-13-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250212061855.71154-13-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/11/25 10:18 PM, Jason Xing wrote:
> BPF program calculates a couple of latency deltas between each tx
> timestamping callbacks. It can be used in the real world to diagnose
> the kernel behaviour in the tx path.
> 
> Check the safety issues by accessing a few bpf calls in
> bpf_test_access_bpf_calls() which are implemented in the patch 3 and 4.
> 
> Check if the bpf timestamping can co-exist with socket timestamping.
> 
> There remains a few realistic things[1][2] to highlight:
> 1. in general a packet may pass through multiple qdiscs. For instance
> with bonding or tunnel virtual devices in the egress path.
> 2. packets may be resent, in which case an ACK might precede a repeat
> SCHED and SND.
> 3. erroneous or malicious peers may also just never send an ACK.
> 
> [1]: https://lore.kernel.org/all/67a389af981b0_14e0832949d@willemb.c.googlers.com.notmuch/
> [2]: https://lore.kernel.org/all/c329a0c1-239b-4ca1-91f2-cb30b8dd2f6a@linux.dev/
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   .../bpf/prog_tests/net_timestamping.c         | 231 +++++++++++++++++
>   .../selftests/bpf/progs/net_timestamping.c    | 244 ++++++++++++++++++
>   2 files changed, 475 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/net_timestamping.c
>   create mode 100644 tools/testing/selftests/bpf/progs/net_timestamping.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/net_timestamping.c b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
> new file mode 100644
> index 000000000000..dcdc40473a7d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
> @@ -0,0 +1,231 @@
> +#include <linux/net_tstamp.h>
> +#include <sys/time.h>
> +#include <linux/errqueue.h>
> +#include "test_progs.h"
> +#include "network_helpers.h"
> +#include "net_timestamping.skel.h"
> +
> +#define CG_NAME "/net-timestamping-test"
> +#define NSEC_PER_SEC    1000000000LL
> +
> +static const char addr4_str[] = "127.0.0.1";
> +static const char addr6_str[] = "::1";
> +static struct net_timestamping *skel;
> +static int cfg_payload_len = 30;

const ?

> +static struct timespec usr_ts;
> +static u64 delay_tolerance_nsec = 10000000000; /* 10 seconds */
> +int SK_TS_SCHED;
> +int SK_TS_TXSW;
> +int SK_TS_ACK;
> +
> +static int64_t timespec_to_ns64(struct timespec *ts)
> +{
> +	return ts->tv_sec * NSEC_PER_SEC + ts->tv_nsec;
> +}
> +
> +static void validate_key(int tskey, int tstype)
> +{
> +	static int expected_tskey = -1;
> +
> +	if (tstype == SCM_TSTAMP_SCHED)
> +		expected_tskey = cfg_payload_len - 1;
> +
> +	ASSERT_EQ(expected_tskey, tskey, "tskey mismatch");
> +
> +	expected_tskey = tskey;
> +}
> +
> +static void validate_timestamp(struct timespec *cur, struct timespec *prev)
> +{
> +	int64_t cur_ns, prev_ns;
> +
> +	cur_ns = timespec_to_ns64(cur);
> +	prev_ns = timespec_to_ns64(prev);
> +
> +	ASSERT_TRUE((cur_ns - prev_ns) < delay_tolerance_nsec, "latency");

ASSERT_LT()

> +}
> +
> +static void test_socket_timestamp(struct scm_timestamping *tss, int tstype,
> +				  int tskey)
> +{
> +	static struct timespec *prev_ts = &usr_ts;
> +
> +	validate_key(tskey, tstype);
> +
> +	switch (tstype) {
> +	case SCM_TSTAMP_SCHED:
> +		validate_timestamp(&tss->ts[0], prev_ts);
> +		SK_TS_SCHED = 1;
> +		SK_TS_TXSW = SK_TS_ACK = 0;
> +		break;
> +	case SCM_TSTAMP_SND:
> +		validate_timestamp(&tss->ts[0], prev_ts);
> +		SK_TS_TXSW = 1;
> +		break;
> +	case SCM_TSTAMP_ACK:
> +		validate_timestamp(&tss->ts[0], prev_ts);
> +		SK_TS_ACK = 1;
> +		break;
> +	}
> +
> +	prev_ts = &tss->ts[0];
> +}
> +
> +static void test_recv_errmsg_cmsg(struct msghdr *msg)
> +{
> +	struct sock_extended_err *serr = NULL;
> +	struct scm_timestamping *tss = NULL;
> +	struct cmsghdr *cm;
> +
> +	for (cm = CMSG_FIRSTHDR(msg);
> +	     cm && cm->cmsg_len;
> +	     cm = CMSG_NXTHDR(msg, cm)) {
> +		if (cm->cmsg_level == SOL_SOCKET &&
> +		    cm->cmsg_type == SCM_TIMESTAMPING) {
> +			tss = (void *) CMSG_DATA(cm);
> +		} else if ((cm->cmsg_level == SOL_IP &&
> +			    cm->cmsg_type == IP_RECVERR) ||
> +			   (cm->cmsg_level == SOL_IPV6 &&
> +			    cm->cmsg_type == IPV6_RECVERR) ||
> +			   (cm->cmsg_level == SOL_PACKET &&
> +			    cm->cmsg_type == PACKET_TX_TIMESTAMP)) {
> +			serr = (void *) CMSG_DATA(cm);
> +			ASSERT_EQ(serr->ee_origin, SO_EE_ORIGIN_TIMESTAMPING,
> +				    "cmsg type");
> +		}
> +
> +		if (serr && tss)
> +			test_socket_timestamp(tss, serr->ee_info,
> +					      serr->ee_data);
> +	}
> +}
> +
> +static bool socket_recv_errmsg(int fd)
> +{
> +	static char ctrl[1024 /* overprovision*/];
> +	char data[cfg_payload_len];
> +	static struct msghdr msg;
> +	struct iovec entry;
> +	int n = 0;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	memset(&entry, 0, sizeof(entry));
> +	memset(ctrl, 0, sizeof(ctrl));
> +
> +	entry.iov_base = data;
> +	entry.iov_len = cfg_payload_len;
> +	msg.msg_iov = &entry;
> +	msg.msg_iovlen = 1;
> +	msg.msg_name = NULL;
> +	msg.msg_namelen = 0;
> +	msg.msg_control = ctrl;
> +	msg.msg_controllen = sizeof(ctrl);
> +
> +	n = recvmsg(fd, &msg, MSG_ERRQUEUE);
> +	if (n == -1)
> +		ASSERT_EQ(errno, EAGAIN, "recvmsg MSG_ERRQUEUE");
> +
> +	if (n >= 0)
> +		test_recv_errmsg_cmsg(&msg);
> +
> +	return n == -1;
> +
> +}
> +
> +static void test_socket_timestamping(int fd)
> +{
> +	while (!socket_recv_errmsg(fd));
> +
> +	ASSERT_EQ(SK_TS_SCHED, 1, "SCM_TSTAMP_SCHED");
> +	ASSERT_EQ(SK_TS_TXSW, 1, "SCM_TSTAMP_SND");
> +	ASSERT_EQ(SK_TS_ACK, 1, "SCM_TSTAMP_ACK");
> +}
> +
> +static void test_tcp(int family)
> +{
> +	struct net_timestamping__bss *bss = skel->bss;
> +	char buf[cfg_payload_len];
> +	int sfd = -1, cfd = -1;
> +	unsigned int sock_opt;
> +	int ret;
> +
> +	memset(bss, 0, sizeof(*bss));

No need to reset some of the new global variables, e.g. SK_TS_SCHED?

> +
> +	sfd = start_server(family, SOCK_STREAM,
> +			   family == AF_INET6 ? addr6_str : addr4_str, 0, 0);
> +	if (!ASSERT_OK_FD(sfd, "start_server"))
> +		goto out;
> +
> +	cfd = connect_to_fd(sfd, 0);
> +	if (!ASSERT_OK_FD(cfd, "connect_to_fd_server"))
> +		goto out;
> +
> +	sock_opt = SOF_TIMESTAMPING_SOFTWARE |
> +		   SOF_TIMESTAMPING_OPT_ID |
> +		   SOF_TIMESTAMPING_TX_SCHED |
> +		   SOF_TIMESTAMPING_TX_SOFTWARE |
> +		   SOF_TIMESTAMPING_TX_ACK;
> +	ret = setsockopt(cfd, SOL_SOCKET, SO_TIMESTAMPING,
> +			 (char *) &sock_opt, sizeof(sock_opt));

It also needs the original test in v9 to check the bpf timestamping works 
without the user space's SO_TIMESTAMPING, which is the major use case of this 
series.

It should be easy to do by conditionally enabling the SO_TIMESTAMPING here.

> +	if (!ASSERT_OK(ret, "setsockopt SO_TIMESTAMPING"))
> +		goto out;
> +
> +	ret = clock_gettime(CLOCK_REALTIME, &usr_ts);
> +	if (!ASSERT_OK(ret, "get user time"))
> +		goto out;
> +
> +	ret = write(cfd, buf, sizeof(buf));
> +	if (!ASSERT_EQ(ret, sizeof(buf), "send to server"))
> +		goto out;
> +
> +	/* Test if socket timestamping works correctly even with bpf
> +	 * extension enabled.
> +	 */
> +	test_socket_timestamping(cfd);
> +
> +	ASSERT_EQ(bss->nr_active, 1, "nr_active");
> +	ASSERT_EQ(bss->nr_snd, 2, "nr_snd");
> +	ASSERT_EQ(bss->nr_sched, 1, "nr_sched");
> +	ASSERT_EQ(bss->nr_txsw, 1, "nr_txsw");
> +	ASSERT_EQ(bss->nr_ack, 1, "nr_ack");
> +
> +out:
> +	if (sfd >= 0)
> +		close(sfd);
> +	if (cfd >= 0)
> +		close(cfd);
> +}
> +
> +void test_net_timestamping(void)
> +{
> +	struct netns_obj *ns;
> +	int cg_fd;
> +
> +	cg_fd = test__join_cgroup(CG_NAME);
> +	if (!ASSERT_OK_FD(cg_fd, "join cgroup"))
> +		return;
> +
> +	ns = netns_new("net_timestamping_ns", true);
> +	if (!ASSERT_OK_PTR(ns, "create ns"))
> +		goto done;
> +
> +	skel = net_timestamping__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open and load skel"))
> +		goto done;
> +
> +	if (!ASSERT_OK(net_timestamping__attach(skel), "attach skel"))
> +		goto done;
> +
> +	skel->links.skops_sockopt =
> +		bpf_program__attach_cgroup(skel->progs.skops_sockopt, cg_fd);
> +	if (!ASSERT_OK_PTR(skel->links.skops_sockopt, "attach cgroup"))
> +		goto done;
> +
> +	test_tcp(AF_INET6);
> +	test_tcp(AF_INET);

Considering the w and w/o SO_TIMESTAMPING combinations (i.e. x2), it is worth to 
have proper subtests. It is easy also. Take a look at the test__start_subtest() 
usage `under the prog_tests/.

> +
> +done:
> +	net_timestamping__destroy(skel);
> +	netns_free(ns);
> +	close(cg_fd);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/net_timestamping.c b/tools/testing/selftests/bpf/progs/net_timestamping.c
> new file mode 100644
> index 000000000000..d3e1da599626
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/net_timestamping.c
> @@ -0,0 +1,244 @@
> +#include "vmlinux.h"
> +#include "bpf_tracing_net.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +#include "bpf_kfuncs.h"
> +#include <errno.h>
> +
> +#define SK_BPF_CB_FLAGS 1009
> +#define SK_BPF_CB_TX_TIMESTAMPING 1

Remove these two defines. The vmlinux.h has it.

[ ... ]

> +SEC("fentry/tcp_sendmsg_locked")
> +int BPF_PROG(trace_tcp_sendmsg_locked, struct sock *sk, struct msghdr *msg, size_t size)
> +{
> +	u64 timestamp = bpf_ktime_get_ns();
> +	u32 flag = sk->sk_bpf_cb_flags;
> +	struct sk_stg *stg;
> +
> +	if (!flag)

I just noticed this one.

Lets replace the "flag" check with a better check (e.g. pid check used in other 
tests). Then it won't affect sk of other tests running in parallel.

It is pretty easy. Take a look at how bpf_get_current_pid_tgid() is used in 
progs/local_storage.c.


> +		return 0;
> +
> +	stg = bpf_sk_storage_get(&sk_stg_map, sk, 0,
> +				 BPF_SK_STORAGE_GET_F_CREATE);
> +	if (!stg)
> +		return 0;
> +
> +	stg->sendmsg_ns = timestamp;
> +	nr_snd += 1;
> +	return 0;
> +}
> +

