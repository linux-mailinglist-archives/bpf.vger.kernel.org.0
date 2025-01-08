Return-Path: <bpf+bounces-48247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E102A05DBF
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 14:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93643A8652
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 13:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135081FDE1B;
	Wed,  8 Jan 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b+iWfO05"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B571FCFEE;
	Wed,  8 Jan 2025 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344581; cv=none; b=Pw3Fb0yCzrFcwmeBAc9hl8yNfbMxyDCISOPVVsKgsLLvUPYmEydnP2S5mDfJDM2QWGjcy/yvXIbpCzLuzYIesd7F3+FWrdNbW13dHeDxkxdTI5ok4rcMa0/R2mUlE+5A2xOBmkFHkZL/TKsCSApZvV52IesTrmHCbBGaVNkE6+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344581; c=relaxed/simple;
	bh=pc4lU5q3Vg5I+/c4kH2jkIvXc1TmkuC/ik4mSuPEovw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bb/7RD4KfUhvxKMWDeID03VVyw2hzbZpsigvmiBZ8BUWHSBnxL/vKPqJxTw/RDHzgUTJN7/giQfsQVcJxzDKS6yN1OX4ZkGDElSDx0RCM/WxCIRxsfmZ/aA/5e/32PKzp486SIaxxNTXl3dTGUKDcpR7ZvDsD4ThkOCoic92MIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b+iWfO05; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736344569; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=upKJAJq1cpY+dKRFkgN4ANfmP0Qld4oqm5SVhIFXhTM=;
	b=b+iWfO05K98apl67Dl7w3HjtaLn3ncETXXt1igfqcsZbgsGU6m61rLMafZkkbrx6MCJBt1h25O5wsFCyjFhvZgYq+C6Lh+jSHCQPrQLXsi1Pn8G3m02AMg5f0Abndl0869N7rV+KDixgXEBKWFVf72wOhAax9xRgSd/c+vsjsPw=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WNEIZlZ_1736344566 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jan 2025 21:56:07 +0800
Date: Wed, 8 Jan 2025 21:56:06 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
	song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
	edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 5/5] bpf/selftests: add selftest for
 bpf_smc_ops
Message-ID: <20250108135606.GB86266@j66a10360.sqa.eu95>
References: <20250107041715.98342-1-alibuda@linux.alibaba.com>
 <20250107041715.98342-6-alibuda@linux.alibaba.com>
 <5ff5cb2b-625b-44ba-8472-95e007f24824@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ff5cb2b-625b-44ba-8472-95e007f24824@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jan 07, 2025 at 04:48:51PM -0800, Martin KaFai Lau wrote:
> On 1/6/25 8:17 PM, D. Wythe wrote:
> >+static int send_cmd(int fd, __u16 nlmsg_type, __u32 nlmsg_pid, __u16 nlmsg_flags,
> >+			__u8 genl_cmd, __u16 nla_type,
> >+	while ((r = sendto(fd, buf, buflen, 0, (struct sockaddr *) &nladdr,
> >+			   sizeof(nladdr))) < buflen) {
> >+		if (r > 0) {
> >+			buf += r;
> >+			buflen -= r;
> >+		} else if (errno != EAGAIN)
> >+			return -1;
> >+		}
> 
> The "}" indentation is off.
> 
> I was wondering if it missed a "}" for the while loop. Turns out the
> "else if" does not have braces while the "if" has. I would add
> braces to the "else if" also to avoid confusion like this.
> 
Take it. I fix change it in next version.
> >+	return 0;
> >+}
> >+
> >+static bool get_smc_nl_family_id(void)
> >+{
> >+	struct sockaddr_nl nl_src;
> >+	struct msgtemplate msg;
> >+	ret = send_cmd(fd, smc_nl_family_id, pid,
> >+		       NLM_F_REQUEST | NLM_F_ACK, op, SMC_NLA_EID_TABLE_ENTRY,
> >+	(void *)test_ueid, sizeof(test_ueid));
> 
> Same. Indentation is off.
Take it. Thanks for pointing it out.
> 
> >+	if (!ASSERT_EQ(ret, 0, "ueid cmd"))
> >+		goto fail;
> >+
> >+	nstoken = open_netns(TEST_NS);
> 
> Instead of make_netns and then immediately open_netns, try
> netns_new(TEST_NS, true) from the test_progs.c.
Got it, I'll try it in next version.
> 
> >+	if (!ASSERT_OK_PTR(nstoken, "open net namespace"))
> >+		goto fail_open_netns;
> >+
> >+	if (!ASSERT_OK(system("ip addr add 127.0.1.0/8 dev lo"), "add server node"))
> >+		goto fail_ip;
> >+
> >+	if (!ASSERT_OK(system("ip addr add 127.0.2.0/8 dev lo"), "server via risk path"))
> >+	close_netns(nstoken);
> >+	return false;
> >+}
> >+
> >+	/* Configure ip strat */
> >+	block_link(map_fd, CLIENT_IP, SERVER_IP_VIA_RISK_PATH);
> >+	block_link(map_fd, SERVER_IP, SERVER_IP);
> >+	close(map_fd);
> 
> No need to close(map-fd) here. bpf_smc__destroy(skel) will do it.
Got it. Many thanks.
> 
> It seems the new selftest fails also. not always though which is concerning.
> 
This might not be a random failure, but rather related to s390x, which
carries a seid by default, which may affect my action of deleting ueid.
I am requesting IBM folks to help me analyze this issue since i have no
s390x machine.

Anyway, I will solve it in the next version.

Best wishes,
D. Wythe

> pw-bot: cr
> 
> >+
> >+	/* should go with smc */
> >+	run_link(CLIENT_IP, SERVER_IP, SERVICE_1);
> >+	/* should go with smc fallback */
> >+	run_link(SERVER_IP, SERVER_IP, SERVICE_2);
> >+
> >+	ASSERT_EQ(skel->bss->smc_cnt, 2, "smc count");
> >+	ASSERT_EQ(skel->bss->fallback_cnt, 1, "fallback count");
> >+
> >+	/* should go with smc */
> >+	run_link(CLIENT_IP, SERVER_IP, SERVICE_2);
> >+
> >+	ASSERT_EQ(skel->bss->smc_cnt, 3, "smc count");
> >+	ASSERT_EQ(skel->bss->fallback_cnt, 1, "fallback count");
> >+
> >+	/* should go with smc fallback */
> >+	run_link(CLIENT_IP, SERVER_IP_VIA_RISK_PATH, SERVICE_3);
> >+
> >+	ASSERT_EQ(skel->bss->smc_cnt, 4, "smc count");
> >+	ASSERT_EQ(skel->bss->fallback_cnt, 2, "fallback count");
> >+
> >+fail:
> >+	bpf_smc__destroy(skel);
> >+}
> 

