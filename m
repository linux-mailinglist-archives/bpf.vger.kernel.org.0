Return-Path: <bpf+bounces-51549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4639EA35A1E
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 10:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503B01667EC
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 09:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF8622F3B8;
	Fri, 14 Feb 2025 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nXvwb20R"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C228A21B182;
	Fri, 14 Feb 2025 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524938; cv=none; b=J6/Ci0jHb5h7gbDvJKTl/1jDtbpOiD+cA/HZ870tSlmpSGletXSxac5ID1GKu4J/C63SCKCYqd6n2voEq9z3q9Nh8C2VVIEcFh/1e5xa3eIOfEKswSEaRzBZ5Qy11ZNc4aW90a5IBnvAqpjH/ZpdDqA4yxzoZZ1akA0BC09E/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524938; c=relaxed/simple;
	bh=pQjK/iwCJO75ufgOTvx8cDDg/C9fbt+wixPYVCFqHfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S450BJE/MMDCRqmSeqdiyFVqlo/cI5YLzH/zFDHikUwKv40YfsOr8umNwLdwAv3Q/ljLExCFiqidzFknrIMBe8zCdb+zBSVRxJRo8VUYVmeCNO7+qE/2fqKvDrGIMQ5Cwx9RWw7XOTH6N8VNxnR3J1E42Ybk24rZruVnGk08ogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nXvwb20R; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739524931; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=+D9V3WWQDBd/ZszSS/N9OZirb9lKepZNme5vqrAR1sQ=;
	b=nXvwb20RU9oNju8SMnPYRFheTB/8zBCFsKKq2yFEhpV8H8EOrpVtT2FkvDhEogd18ikpKNiHOhFgv71Z5xTwUTH/gMaqPOxI2FOvBO1iK/JpimA3gKJqAvpBIpUdXJh6naB28EV3fyHckDrILbH/HF0SAP7G0nDMu0wrzv7zOmg=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WPQIbTz_1739524929 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 14 Feb 2025 17:22:09 +0800
Date: Fri, 14 Feb 2025 17:22:09 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: "D. Wythe" <alibuda@linux.alibaba.com>, wenjia@linux.ibm.com,
	jaka@linux.ibm.com
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
	sdf@google.com, haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	guwen@linux.alibaba.com, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 0/6] net/smc: Introduce smc_ops
Message-ID: <20250214092209.GA88970@j66a10360.sqa.eu95>
References: <20250123015942.94810-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123015942.94810-1-alibuda@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Jan 23, 2025 at 09:59:36AM +0800, D. Wythe wrote:
> This patch aims to introduce BPF injection capabilities for SMC and
> includes a self-test to ensure code stability.
> 
> Since the SMC protocol isn't ideal for every situation, especially
> short-lived ones, most applications can't guarantee the absence of
> such scenarios. Consequently, applications may need specific strategies
> to decide whether to use SMC. For example, an application might limit SMC
> usage to certain IP addresses or ports.
> 
> To maintain the principle of transparent replacement, we want applications
> to remain unaffected even if they need specific SMC strategies. In other
> words, they should not require recompilation of their code.
> 
> Additionally, we need to ensure the scalability of strategy implementation.
> While using socket options or sysctl might be straightforward, it could
> complicate future expansions.
> 
> Fortunately, BPF addresses these concerns effectively. Users can write
> their own strategies in eBPF to determine whether to use SMC, and they can
> easily modify those strategies in the future.

Hi smc folks, @Wenjia @Ian

Is there any feedback regarding this patches ? This series of code has
gone through multiple rounds of community reviews. However, the parts
related to SMC, including the new sysctl and ops name, really needs
your input and acknowledgment.

Additionally, this series includes a bug fix for SMC, which is easily
reproducible in the BPF CI tests.

Thanks,
D. Wythe


