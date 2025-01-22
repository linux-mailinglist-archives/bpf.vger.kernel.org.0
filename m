Return-Path: <bpf+bounces-49431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAE0A18A2F
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 03:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557AF169A25
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 02:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D174414B07A;
	Wed, 22 Jan 2025 02:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KDrbQgtq"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45792323D;
	Wed, 22 Jan 2025 02:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737514019; cv=none; b=AWCA5l1rdnvgWi9xnY+M9D0jaFO5Uhcs1wYQLO9ymA75cC/ZLTV7t3W1oYFteGKKQbJq7vTkrJ5n+zaN91ErKHFVRcFKSCgOX8CLWVHmZUE9R+tf+jGGSWwEO1CrLoebNJ5q/pP4r3fb+GWa3Pu1czxPKMQyWhIbPxC5EzNUtgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737514019; c=relaxed/simple;
	bh=C3NMnukzWY7C/OYqDh/ehO7GoWFm1c1QyFHAyKt5nTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6DAm93J2YDpS/wcY7XDLvW9TwdkPfBnB7QMCn2u7eXDkVxueX1FDN5xb8YQIQqJNlICezxEKjhRwax+I0k1aelTw1ytt6wvOEoChigVWAdI3iQszk10pXdVuOU9qDVZjoinmS5Xx1FqFfiO7yjNe/MzKSWNhCyEOzTWqQW8cJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KDrbQgtq; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737514014; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=D0Cs/TpPtr1epsPCo4fvFQC88EQfd/Rs+kZecKuIkfY=;
	b=KDrbQgtqQWwu0/9hWjl3KLiYIvwSct00KD4rO+wX11X5baCkCjcEi1Swp2RmSkaWZd1tySd6OQW8qZRgF6VMQPR34wlKbJ3f2gWqKyV6Fk/37UCMZRlyFBiz2vqveTDkXq2/T/FL7bEejuZbJTDIUKmqt3346AqCAY7y80ucksE=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WO6vyum_1737514011 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Jan 2025 10:46:52 +0800
Date: Wed, 22 Jan 2025 10:46:51 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, sdf@google.com,
	haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	guwen@linux.alibaba.com, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 5/5] bpf/selftests: add selftest for
 bpf_smc_ops
Message-ID: <20250122024651.GB81479@j66a10360.sqa.eu95>
References: <20250116074442.79304-1-alibuda@linux.alibaba.com>
 <20250116074442.79304-6-alibuda@linux.alibaba.com>
 <Z49Bv8ySi2EJ/jfl@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z49Bv8ySi2EJ/jfl@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jan 21, 2025 at 12:12:07PM +0530, Saket Kumar Bhaskar wrote:
> On Thu, Jan 16, 2025 at 03:44:42PM +0800, D. Wythe wrote:
> > This tests introduces a tiny smc_ops for filtering SMC connections based on
> > IP pairs, and also adds a realistic topology model to verify this ops.
> > 
> > Also, we can only use SMC loopback under CI test, so an
> > additional configuration needs to be enabled.
> > 
> > Follow the steps below to run this test.
> > 
> > make -C tools/testing/selftests/bpf
> > cd tools/testing/selftests/bpf
> > sudo ./test_progs -t smc
> > 
> > Results shows:
> > Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > ---
> >  tools/testing/selftests/bpf/config            |   4 +
> >  .../selftests/bpf/prog_tests/test_bpf_smc.c   | 397 ++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/bpf_smc.c   | 117 ++++++
> >  3 files changed, 518 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c
> > 
> > diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> > index c378d5d07e02..fac2f2a9d02f 100644
> > --- a/tools/testing/selftests/bpf/config
> > +++ b/tools/testing/selftests/bpf/config
> > @@ -113,3 +113,7 @@ CONFIG_XDP_SOCKETS=y
> > +};
> Tested this selftest with patches applied on powerpc.
> 
> #./test_progs -t bpf_smc
> 
> net.smc.ops = linkcheck
> #27/1    bpf_smc/topo:OK
> #27      bpf_smc:OK
> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> 
> Tested-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> 
> Thanks,
> Saket

Hi Saket,

Thanks for your testing. I hope you don't mind if I add your test-by in
the next version.

Best wishes,
D. Wythe

> > -- 
> > 2.45.0
> > 

