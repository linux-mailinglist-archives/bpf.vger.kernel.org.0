Return-Path: <bpf+bounces-48182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D00A04E42
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 01:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6980B1887AB8
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 00:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADB6175A5;
	Wed,  8 Jan 2025 00:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GmJEN+Ed"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F806AAD
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736297350; cv=none; b=EAsfZjxzM9nRJpuykbZsBEl8sw+H4rh8bhjvyC1M8uxsjTSHywYCeTT7X7SwYUSkg7D8ntGPDbRHWnrCWOIjmbR5Ru5a8wAgZW7XDnl8DnxdjMOkPUEArcad7ktqddtCGyyq2lVtiJyNmSOLWT4ir6qZaMk1MZrTrD/d094kTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736297350; c=relaxed/simple;
	bh=kT+CtTrM8CiyeLoR5LIUZDvX6Pxfd7G6w50Xe+e2FRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ko9kjskqbUTeGFRdxq6mKf3/TVn4ZwzDk78bcFcRc+a+mTDbJgBTfwjp6NkPsf4isX3NURuHhcfajYNX8O2wBHk8o11YwLFMhBFDwJc2NQMOXyfkD/CbLGlOS99ZezM8w6j2m7s24iOZZJaTKAOqMtG2dbqumA1bU8wdDSLbEL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GmJEN+Ed; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5ff5cb2b-625b-44ba-8472-95e007f24824@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736297338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8skuobeik2cGErmNEK7HqQ7AwlVSQpb754nlfxxuUrk=;
	b=GmJEN+Edw6LAtGfrDeXXPzfMnsL4Tb2kfJOURmd5gxX/+o4bNptph/94yltaQ22+a98cf6
	xmbRTbLKx4ETxy2jw58BrQcKiZpdMi9kUsyArnFu9mOfknN53LlmZFXy1O4NxhhHrMczDi
	nqTlzC1CGU1De7f4Z5kzm5XCrJ2SQxM=
Date: Tue, 7 Jan 2025 16:48:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 5/5] bpf/selftests: add selftest for
 bpf_smc_ops
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
 song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
 edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org
References: <20250107041715.98342-1-alibuda@linux.alibaba.com>
 <20250107041715.98342-6-alibuda@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250107041715.98342-6-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/6/25 8:17 PM, D. Wythe wrote:
> +static int send_cmd(int fd, __u16 nlmsg_type, __u32 nlmsg_pid, __u16 nlmsg_flags,
> +			__u8 genl_cmd, __u16 nla_type,
> +			void *nla_data, int nla_len)
> +{
> +	struct nlattr *na;
> +	struct sockaddr_nl nladdr;
> +	int r, buflen;
> +	char *buf;
> +
> +	struct msgtemplate msg = {0};
> +
> +	msg.n.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
> +	msg.n.nlmsg_type = nlmsg_type;
> +	msg.n.nlmsg_flags = nlmsg_flags;
> +	msg.n.nlmsg_seq = 0;
> +	msg.n.nlmsg_pid = nlmsg_pid;
> +	msg.g.cmd = genl_cmd;
> +	msg.g.version = 1;
> +	na = (struct nlattr *) GENLMSG_DATA(&msg);
> +	na->nla_type = nla_type;
> +	na->nla_len = nla_len + 1 + NLA_HDRLEN;
> +	memcpy(NLA_DATA(na), nla_data, nla_len);
> +	msg.n.nlmsg_len += NLMSG_ALIGN(na->nla_len);
> +
> +	buf = (char *) &msg;
> +	buflen = msg.n.nlmsg_len;
> +	memset(&nladdr, 0, sizeof(nladdr));
> +	nladdr.nl_family = AF_NETLINK;
> +
> +	while ((r = sendto(fd, buf, buflen, 0, (struct sockaddr *) &nladdr,
> +			   sizeof(nladdr))) < buflen) {
> +		if (r > 0) {
> +			buf += r;
> +			buflen -= r;
> +		} else if (errno != EAGAIN)
> +			return -1;
> +		}

The "}" indentation is off.

I was wondering if it missed a "}" for the while loop. Turns out the "else if" 
does not have braces while the "if" has. I would add braces to the "else if" 
also to avoid confusion like this.

> +	return 0;
> +}
> +
> +static bool get_smc_nl_family_id(void)
> +{
> +	struct sockaddr_nl nl_src;
> +	struct msgtemplate msg;
> +	struct nlattr *nl;
> +	int fd, ret;
> +	pid_t pid;
> +
> +	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
> +	if (!ASSERT_GT(fd, 0, "nl_family socket"))
> +		return false;
> +
> +	pid = getpid();
> +
> +	memset(&nl_src, 0, sizeof(nl_src));
> +	nl_src.nl_family = AF_NETLINK;
> +	nl_src.nl_pid = pid;
> +
> +	ret = bind(fd, (struct sockaddr *) &nl_src, sizeof(nl_src));
> +	if (!ASSERT_GE(ret, 0, "nl_family bind"))
> +		goto fail;
> +
> +	ret = send_cmd(fd, GENL_ID_CTRL, pid,
> +		       NLM_F_REQUEST, CTRL_CMD_GETFAMILY,
> +		       CTRL_ATTR_FAMILY_NAME, (void *)SMC_GENL_FAMILY_NAME,
> +		       strlen(SMC_GENL_FAMILY_NAME));
> +	if (!ASSERT_EQ(ret, 0, "nl_family query"))
> +		goto fail;
> +
> +	ret = recv(fd, &msg, sizeof(msg), 0);
> +	if (!ASSERT_FALSE(msg.n.nlmsg_type == NLMSG_ERROR || (ret < 0) ||
> +			  !NLMSG_OK((&msg.n), ret), "nl_family response"))
> +		goto fail;
> +
> +	nl = (struct nlattr *) GENLMSG_DATA(&msg);
> +	nl = (struct nlattr *) ((char *) nl + NLA_ALIGN(nl->nla_len));
> +	if (!ASSERT_EQ(nl->nla_type, CTRL_ATTR_FAMILY_ID, "nl_family nla type"))
> +		goto fail;
> +
> +	smc_nl_family_id = *(uint16_t *) NLA_DATA(nl);
> +	close(fd);
> +	return true;
> +fail:
> +	close(fd);
> +	return false;
> +}
> +
> +static bool smc_ueid(int op)
> +{
> +	struct sockaddr_nl nl_src;
> +	struct msgtemplate msg;
> +	struct nlmsgerr *err;
> +	char test_ueid[32];
> +	int fd, ret;
> +	pid_t pid;
> +
> +	/* UEID required */
> +	memset(test_ueid, '\x20', sizeof(test_ueid));
> +	memcpy(test_ueid, SMC_BPFTEST_UEID, strlen(SMC_BPFTEST_UEID));
> +	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
> +	if (!ASSERT_GT(fd, 0, "ueid socket"))
> +		return false;
> +
> +	pid = getpid();
> +	memset(&nl_src, 0, sizeof(nl_src));
> +	nl_src.nl_family = AF_NETLINK;
> +	nl_src.nl_pid = pid;
> +
> +	ret = bind(fd, (struct sockaddr *) &nl_src, sizeof(nl_src));
> +	if (!ASSERT_GE(ret, 0, "ueid bind"))
> +		goto fail;
> +
> +	ret = send_cmd(fd, smc_nl_family_id, pid,
> +		       NLM_F_REQUEST | NLM_F_ACK, op, SMC_NLA_EID_TABLE_ENTRY,
> +	(void *)test_ueid, sizeof(test_ueid));

Same. Indentation is off.

> +	if (!ASSERT_EQ(ret, 0, "ueid cmd"))
> +		goto fail;
> +
> +	ret = recv(fd, &msg, sizeof(msg), 0);
> +	if (!ASSERT_FALSE((ret < 0) || !NLMSG_OK((&msg.n), ret), "ueid response"))
> +		goto fail;
> +
> +	if (msg.n.nlmsg_type == NLMSG_ERROR) {
> +		err = NLMSG_DATA(&msg);
> +		switch (op) {
> +		case SMC_NETLINK_REMOVE_UEID:
> +			if (!ASSERT_FALSE((err->error && err->error != -ENOENT), "ueid remove"))
> +				goto fail;
> +			break;
> +		case SMC_NETLINK_ADD_UEID:
> +			if (!ASSERT_EQ(err->error, 0, "ueid add"))
> +				goto fail;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +	close(fd);
> +	return true;
> +fail:
> +	close(fd);
> +	return false;
> +}
> +
> +static bool setup_netns(void)
> +{
> +	if (!ASSERT_OK(make_netns(TEST_NS), "create net namespace"))
> +		return false;
> +
> +	nstoken = open_netns(TEST_NS);

Instead of make_netns and then immediately open_netns, try netns_new(TEST_NS, 
true) from the test_progs.c.

> +	if (!ASSERT_OK_PTR(nstoken, "open net namespace"))
> +		goto fail_open_netns;
> +
> +	if (!ASSERT_OK(system("ip addr add 127.0.1.0/8 dev lo"), "add server node"))
> +		goto fail_ip;
> +
> +	if (!ASSERT_OK(system("ip addr add 127.0.2.0/8 dev lo"), "server via risk path"))
> +		goto fail_ip;
> +
> +	return true;
> +fail_open_netns:
> +	remove_netns(TEST_NS);
> +fail_ip:
> +	close_netns(nstoken);
> +	return false;
> +}
> +
> +static void cleanup_netns(void)
> +{
> +	close_netns(nstoken);
> +	remove_netns(TEST_NS);
> +}
> +
> +static bool setup_ueid(void)
> +{
> +	/* get smc nl id */
> +	if (!get_smc_nl_family_id())
> +		return false;
> +	/* clear old ueid for bpftest */
> +	smc_ueid(SMC_NETLINK_REMOVE_UEID);
> +	/* smc-loopback required ueid */
> +	return smc_ueid(SMC_NETLINK_ADD_UEID);
> +}
> +
> +static void cleanup_ueid(void)
> +{
> +	smc_ueid(SMC_NETLINK_REMOVE_UEID);
> +}
> +
> +static bool setup_smc(void)
> +{
> +	if (!setup_ueid())
> +		return false;
> +
> +	if (!setup_netns())
> +		goto fail_netns;
> +
> +	return true;
> +fail_netns:
> +	cleanup_ueid();
> +	return false;
> +}
> +
> +static int set_client_addr_cb(int fd, void *opts)
> +{
> +	const char *src = (const char *)opts;
> +	struct sockaddr_in localaddr;
> +
> +	localaddr.sin_family = AF_INET;
> +	localaddr.sin_port = htons(0);
> +	localaddr.sin_addr.s_addr = inet_addr(src);
> +	return !ASSERT_EQ(bind(fd, &localaddr, sizeof(localaddr)), 0, "client bind");
> +}
> +
> +static void run_link(const char *src, const char *dst, int port)
> +{
> +	struct network_helper_opts opts = {0};
> +	int server, client;
> +
> +	server = start_server_str(AF_INET, SOCK_STREAM, dst, port, NULL);
> +	if (!ASSERT_OK_FD(server, "start service_1"))
> +		return;
> +
> +	opts.proto = IPPROTO_TCP;
> +	opts.post_socket_cb = set_client_addr_cb;
> +	opts.cb_opts = (void *)src;
> +
> +	client = connect_to_fd_opts(server, &opts);
> +	if (!ASSERT_OK_FD(client, "start connect"))
> +		goto fail_client;
> +
> +	close(client);
> +fail_client:
> +	close(server);
> +}
> +
> +static void block_link(int map_fd, const char *src, const char *dst)
> +{
> +	struct smc_strat_ip_value val = { .mode = /* block */ 0 };
> +	struct smc_strat_ip_key key = {
> +		.sip = inet_addr(src),
> +		.dip = inet_addr(dst),
> +	};
> +
> +	bpf_map_update_elem(map_fd, &key, &val, BPF_ANY);
> +}
> +
> +/*
> + * This test describes a real-life service topology as follows:
> + *
> + *                             +-------------> service_1
> + *            link1            |                     |
> + *   +--------------------> server                   |  link 2
> + *   |                         |                     V
> + *   |                         +-------------> service_2
> + *   |        link 3
> + *  client -------------------> server_via_unsafe_path -> service_3
> + *
> + * Among them,
> + * 1. link-1 is very suitable for using SMC.
> + * 2. link-2 is not suitable for using SMC, because the mode of this link is kind of
> + *     short-link services.
> + * 3. link-3 is also not suitable for using SMC, because the RDMA link is unavailable and
> + *     needs to go through a long timeout before it can fallback to TCP.
> + *
> + * To achieve this goal, we use a customized SMC ip strategy via smc_ops.
> + */
> +static void test_topo(void)
> +{
> +	struct bpf_smc *skel;
> +	int rc, map_fd;
> +
> +	skel = bpf_smc__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "bpf_smc__open_and_load"))
> +		return;
> +
> +	rc = bpf_smc__attach(skel);
> +	if (!ASSERT_EQ(rc, 0, "bpf_smc__attach"))
> +		goto fail;
> +
> +	map_fd = bpf_map__fd(skel->maps.smc_strats_ip);
> +	if (!ASSERT_GT(map_fd, 0, "bpf_map__fd"))
> +		goto fail;
> +
> +	/* Mock the process of transparent replacement, since we will modify protocol
> +	 * to ipproto_smc accropding to it via fmod_ret/update_socket_protocol.
> +	 */
> +	system("sysctl -w net.smc.ops=linkcheck");
> +
> +	/* Configure ip strat */
> +	block_link(map_fd, CLIENT_IP, SERVER_IP_VIA_RISK_PATH);
> +	block_link(map_fd, SERVER_IP, SERVER_IP);
> +	close(map_fd);

No need to close(map-fd) here. bpf_smc__destroy(skel) will do it.

It seems the new selftest fails also. not always though which is concerning.

pw-bot: cr

> +
> +	/* should go with smc */
> +	run_link(CLIENT_IP, SERVER_IP, SERVICE_1);
> +	/* should go with smc fallback */
> +	run_link(SERVER_IP, SERVER_IP, SERVICE_2);
> +
> +	ASSERT_EQ(skel->bss->smc_cnt, 2, "smc count");
> +	ASSERT_EQ(skel->bss->fallback_cnt, 1, "fallback count");
> +
> +	/* should go with smc */
> +	run_link(CLIENT_IP, SERVER_IP, SERVICE_2);
> +
> +	ASSERT_EQ(skel->bss->smc_cnt, 3, "smc count");
> +	ASSERT_EQ(skel->bss->fallback_cnt, 1, "fallback count");
> +
> +	/* should go with smc fallback */
> +	run_link(CLIENT_IP, SERVER_IP_VIA_RISK_PATH, SERVICE_3);
> +
> +	ASSERT_EQ(skel->bss->smc_cnt, 4, "smc count");
> +	ASSERT_EQ(skel->bss->fallback_cnt, 2, "fallback count");
> +
> +fail:
> +	bpf_smc__destroy(skel);
> +}



