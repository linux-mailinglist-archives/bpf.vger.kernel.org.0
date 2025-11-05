Return-Path: <bpf+bounces-73576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E944DC341FF
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 08:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C41114EA90B
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 07:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D20D2D060C;
	Wed,  5 Nov 2025 07:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FCNP8vhG"
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578D92BFC8F;
	Wed,  5 Nov 2025 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326255; cv=none; b=kCVFtd6QAg+1FZhtYw/uc6LdIC/AToyvzMMxQiD2bpoAPd/SQTvxrx0qZrRWnR9lrHVyj45OjrLWGdZ4KRzpyhHuoH2so3kSVbZvG/B1ovxICg/Zq/wOVG6zRPArlb+1O3w874/UYKIZedH+Gu9WM1zuxUL6AhTi3tV6ij1RvZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326255; c=relaxed/simple;
	bh=Fem9xkolDQS42qh4wWt9wApy6saqu7inl82Z7/IP2CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gupjTZe/PPSNnHMp/Ox/JwCcdxdKh1EjPhUuSz8i4qJMNL7KC8fqF5tGKhpGQWjYbRQTkq7/QuZJMA8BLMVXpvAPacz0sxrLLtPNb5TaVyD7x7jHpWE5URbRuV+wMGuuXhZUAlVxJaTVtN+wpP2dDO+w7uHA7pzMFplxTev6ksY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FCNP8vhG; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762326244; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=RtVyJOcPvAiuccZ/CktaIrpt3Nf2+6AFKpihHJLFrU4=;
	b=FCNP8vhGOzxeGGNgemUpV5JgbGMZdp8IeUHv1QMjoE81tn+YoRUubXBBSFMthCFMb+VyK5USqIW53m38o5N4xoowisPsyfmhZLyV+vu0FM2r/0jfeDeq6JOmfEOiixaHfwvmrMmUlTgWpo3mcMZo4AmvzTSXC1VsoSbmhrFajAg=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WrkOIeH_1762326242 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Nov 2025 15:04:02 +0800
Date: Wed, 5 Nov 2025 15:04:02 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
	song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
	edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	jolsa@kernel.org, mjambigi@linux.ibm.com, wenjia@linux.ibm.com,
	wintera@linux.ibm.com, dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	netdev@vger.kernel.org, sidraya@linux.ibm.com, jaka@linux.ibm.com
Subject: Re: [PATCH bpf-next v4 3/3] bpf/selftests: add selftest for
 bpf_smc_hs_ctrl
Message-ID: <20251105070402.GB31761@j66a10360.sqa.eu95>
References: <20251103073124.43077-1-alibuda@linux.alibaba.com>
 <20251103073124.43077-4-alibuda@linux.alibaba.com>
 <14bc0878-796e-415a-a319-baa609474a20@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14bc0878-796e-415a-a319-baa609474a20@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Nov 04, 2025 at 04:13:39PM -0800, Martin KaFai Lau wrote:
> On 11/2/25 11:31 PM, D. Wythe wrote:
> >+static bool setup_netns(void)
> >+{
> >+	test_netns = netns_new(TEST_NS, true);
> >+	if (!ASSERT_OK_PTR(test_netns, "open net namespace"))
> >+		goto fail_netns;
> >+
> >+	if (!ASSERT_OK(system("ip addr add 127.0.1.0/8 dev lo"),
> 
> SYS(fail_ip, "ip addr add ...")
> >+		       "add server node"))
> >+		goto fail_ip;
> >+
> >+	if (!ASSERT_OK(system("ip addr add 127.0.2.0/8 dev lo"),
> 
> same here.
> 
Take it.
> >+		       "server via risk path"))
> >+		goto fail_ip;
> >+
> >+	return true;
> >+fail_ip:
> >+	netns_free(test_netns);
> >+fail_netns:
> >+	return false;
> >+}
> >+
> >+static void cleanup_netns(void)
> >+{
> >+	netns_free(test_netns);
> >+	remove_netns(TEST_NS);
> 
> remove_netns should not be needed. netns_free() should have removed it.
Take it.
> 
> [ ... ]
> 
> >+	system("sysctl -w net.smc.hs_ctrl=linkcheck");
> 
> The "sysctl -w" will echo useless output to test_progs. just use
> write_sysctl().
>
Take it.
Thanks for the review, I'll address these points in the next
version.

Best wishes,
D. Wythe


