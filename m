Return-Path: <bpf+bounces-47536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E016E9FA93D
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 03:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A401885C1F
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 02:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA6038FB0;
	Mon, 23 Dec 2024 02:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="p6YKCvs/"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F1718052;
	Mon, 23 Dec 2024 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734919737; cv=none; b=IFOOzczk+El/CqheVhPk71Fl4QBsmiCeax+N8F784SNIk8ZxGwhxHOpbV2qoWDehhYh/F7x7VEt3Ept+uMrOuKnGvAWYEwITLu61QpHqM/Noe6DieXw7quGxdWSeFV/OSr+ANsInw/74ESE3tk2B+iPbg30YqtP7k4rbwuWEWTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734919737; c=relaxed/simple;
	bh=qYH90uO0cr7ROO/1VUN5DQ4hZ7Rb6iINEhYGgfLowbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rA1wMAvNwSMXda5GwZUZm5efTN2cLfaCzTn/BJKe75Q4FzjdyIpV0xDP4O/Vn5JzSn2bjgFewtwE46zb2tXSBhdwvkPcIRVvtChy5+4E+SNE2XCPVE+w38qFSl4+NBvahRIfesndgGUR6yuCIUpCEoKLw4vtGLycTHvzW3JomUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=p6YKCvs/; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734919731; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=gXh82g4Y441IlXRcXxsPuJyDqn5dmGo3UaGNK44TgNo=;
	b=p6YKCvs/1dRbicZ/so7r7K++oLxYsr6PYARpGv2USY4l7AogSjIN8rh2dNnbYK7kyo4+LIo7vLx731V/YhzWCYnAS2rjW0izEINMLkxJ/jFvy86X+3DKozWtK5rOuPTPLzeXFE50tV4d+80VP+dMyYcgcZpX3wvzQJ/J/+P1Cy0=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WLzyf4N_1734919406 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Dec 2024 10:03:26 +0800
Date: Mon, 23 Dec 2024 10:03:26 +0800
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
Subject: Re: [PATCH bpf-next v3 5/5] bpf/selftests: add selftest for
 bpf_smc_ops
Message-ID: <20241223020326.GB36000@j66a10360.sqa.eu95>
References: <20241218024422.23423-1-alibuda@linux.alibaba.com>
 <20241218024422.23423-6-alibuda@linux.alibaba.com>
 <e3bf6bf6-5e81-4b6b-a9cd-40476cff67df@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3bf6bf6-5e81-4b6b-a9cd-40476cff67df@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Dec 19, 2024 at 02:59:15PM -0800, Martin KaFai Lau wrote:
> On 12/17/24 6:44 PM, D. Wythe wrote:
> >+// SPDX-License-Identifier: GPL-2.0
> >+
> >+#include "vmlinux.h"
> >+
> >+#include <bpf/bpf_helpers.h>
> >+#include <bpf/bpf_tracing.h>
> >+#include "bpf_tracing_net.h"
> >+
> >+char _license[] SEC("license") = "GPL";
> >+
> >+struct smc_sock {
> 
> I suspect this should be "smc_sock___local". Otherwise, it can't
> compile if the same type is found in vmlinux.h.
> 

Yes, it has been changed to ___local.

> I only looked at the high level of prog_tests/test_bpf_smc.c. A few comments,
> 
> Try to reuse the helpers in network_helpers.c and test_progs.c, e.g.
> netns creation helpers, start_server, ...etc. There are many
> examples in selftests/bpf/prog_tests using them.
> 
> I see 1s timeout everywhere. BPF CI could be slow some time. Please
> consider how reliable the multi-thread test is. If the test is too
> flaky, it will be put in the selftests/bpf/DENYLIST.
> 

Got it, I will remove those timeouts in the next version. I have tried
reusing these helpers, it is very convenient and makes code more
concise!

D. Wythe

> >+	struct sock sk;
> >+	struct smc_sock *listen_smc;
> >+	bool use_fallback;
> >+} __attribute__((preserve_access_index));
> >+

