Return-Path: <bpf+bounces-49427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C7FA189B6
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 02:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AA73A5074
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 01:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE4B13A3ED;
	Wed, 22 Jan 2025 01:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Hgapfv9T"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978E2196;
	Wed, 22 Jan 2025 01:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737510684; cv=none; b=Wbd+X/fg1Bv2oIO0P6cpMUBVjiXBlrLYeqwPrHAe2SJVm6eiWsYI2UmTH9MbqjiUQvTix/MIbNqS8rH7sJGrFFZIHYh9VG/8w1Q8r0dsza5UxttwFEGqKFXifA4GxlffTC0j0+icPtYPqryeejkeCNRU4NS91c/fM5bXMWS42eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737510684; c=relaxed/simple;
	bh=o1vUhCZ1MIuPW9x3umjNxpr2woaO3N38+8noBsgoSXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqR0HsXbUsqxZ5XW4vxvlUUgu0BNWnwcT5lgnvI7sHVDcYf7O344xck0knLXylfzNX9Jp5cYzQ0CaMn+BN+lER3VJc7eqH/95VgcWdnfN+Q22YYni8F9UvtiMI26tP10y8fs4iwKeBHTnNqfQ8ijy1/Y7t/UZZkySfWL4S5xm8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Hgapfv9T; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737510672; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=TFugPd9VsPU5LVMlrqc07WRWFR2jP8A5f/qqWIHyWZ0=;
	b=Hgapfv9TkqlOQZjVbLdbsP/K3uhaQNMGUgpCUJ5bKkaSI5hz2dIGsksFEtiX7i6RviMoBjSwG1+tVYWPzqpTdaaCJ8TDPpyHlVCVerQ4Upw5lsqwE6RhBAVYIIGem/zOq1jfFjw00Oc31r0uTRUmO9rpNopCfpjfoqhRQld6EfU=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WO6n6eL_1737510670 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Jan 2025 09:51:10 +0800
Date: Wed, 22 Jan 2025 09:51:09 +0800
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
Subject: Re: [PATCH bpf-next v6 5/5] bpf/selftests: add selftest for
 bpf_smc_ops
Message-ID: <20250122015109.GA11751@j66a10360.sqa.eu95>
References: <20250116074442.79304-1-alibuda@linux.alibaba.com>
 <20250116074442.79304-6-alibuda@linux.alibaba.com>
 <0d398524-f335-4346-902d-7d7cd3b0685b@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d398524-f335-4346-902d-7d7cd3b0685b@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jan 17, 2025 at 04:37:04PM -0800, Martin KaFai Lau wrote:
> On 1/15/25 11:44 PM, D. Wythe wrote:
> >This tests introduces a tiny smc_ops for filtering SMC connections based on
> >IP pairs, and also adds a realistic topology model to verify this ops.
> >
> >Also, we can only use SMC loopback under CI test, so an
> >additional configuration needs to be enabled.
> >
> >Follow the steps below to run this test.
> >
> >make -C tools/testing/selftests/bpf
> >cd tools/testing/selftests/bpf
> >sudo ./test_progs -t smc
> >
> >Results shows:
> >Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> >
> >Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> >---
> >  tools/testing/selftests/bpf/config            |   4 +
> >  .../selftests/bpf/prog_tests/test_bpf_smc.c   | 397 ++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/bpf_smc.c   | 117 ++++++
> >  3 files changed, 518 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c
> >
> >diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> >index c378d5d07e02..fac2f2a9d02f 100644
> >--- a/tools/testing/selftests/bpf/config
> >+++ b/tools/testing/selftests/bpf/config
> >@@ -113,3 +113,7 @@ CONFIG_XDP_SOCKETS=y
> >  CONFIG_XFRM_INTERFACE=y
> >  CONFIG_TCP_CONG_DCTCP=y
> >  CONFIG_TCP_CONG_BBR=y
> >+CONFIG_INFINIBAND=y
> >+CONFIG_SMC=y
> >+CONFIG_SMC_OPS=y
> >+CONFIG_SMC_LO=y
> >\ No newline at end of file
> >+	int fd, ret;
> >+	pid_t pid;
> >+
> >+	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
> >+	if (!ASSERT_GT(fd, 0, "nl_family socket"))
> 
> Should be _GE. or just use ASSERT_OK_FD.
> 
Take it.
> >+	if (!ASSERT_GE(ret, 0, "nl_family bind"))
> 
> nit. ASSERT_OK.
> 
> >+	if (!ASSERT_EQ(ret, 0, "nl_family query"))
> 
> ASSERT_OK.
> 
> >+	if (!ASSERT_GT(fd, 0, "ueid socket"))
> 
> ASSERT_OK_FD
> 
> >+		return false;
> >+	ret = bind(fd, (struct sockaddr *) &nl_src, sizeof(nl_src));
> >+	if (!ASSERT_GE(ret, 0, "ueid bind"))
> 
> ASSERT_OK
> 
> >+		goto fail;
> >+	ret = send_cmd(fd, smc_nl_family_id, pid,
> >+		       (void *)test_ueid, sizeof(test_ueid));
> >+	if (!ASSERT_EQ(ret, 0, "ueid cmd"))
> 
> ASSERT_OK
> 

The parts of the assert macro have been all fixed, thanks for your
suggestion.

> >+		goto fail;
> >+
> >+int BPF_PROG(bpf_smc_switch_to_fallback, struct smc_sock___local *smc)
> >+{
> >+	/* only count from one side (client) */
> >+	if (smc && !BPF_CORE_READ(smc, listen_smc))
> 
> It should not need BPF_CORE_READ. smc can be directly read like the
> above sock->sk->...

Got it. I'll fix it in next version.

Thanks,
D. Wythe

> 
> >+		fallback_cnt++;
> >+	return 0;
> >+}

