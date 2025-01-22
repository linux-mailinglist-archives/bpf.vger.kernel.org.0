Return-Path: <bpf+bounces-49438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBC8A18B11
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 05:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEC41883C1B
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 04:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852EE16F8F5;
	Wed, 22 Jan 2025 04:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mYgY2h8V"
X-Original-To: bpf@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9EEECF;
	Wed, 22 Jan 2025 04:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737520552; cv=none; b=h6daPBmCNiaa2zcF1/mVqsd/QjK2GRyRxgSijWX1v9lbwO0lzc6fHdtS8oE12ALcRfxFBeGLSm0Rp0jeZo4kbOZNTHAOfWCzthN9eT6arhGbMzmRrGOyN4kuBsnl6r0zXsBsoRxVea531RbyUNpCIolqEPVOXS9VpD0bnfUqdG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737520552; c=relaxed/simple;
	bh=kx4htrhC1LwQWfgDqorHI8uXV4Zpz4t+IvJ7Z5oP+9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aufTdLKaftmeS2vqhLD16M7KRkLv3ckducaid3CTQMH6815BT18FOurPjXXWttC0TgzyImewTq9mWhJf4w0dzB1mURa79XUgigVXrhAR9QS3H0qlFedBrmDSzInPD4NVKKmM+4yNfrNPZf5RoNMFFE6taJxdQjDAz5gLIiEmir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mYgY2h8V; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737520540; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=IHehevSmLWkA9dPFMqFrIjYjGxd1L3QHCe+CuOPx340=;
	b=mYgY2h8V+fmrfLld9djLlPnK0vONOHRGBdUnfEYIjw34Bc/QZ7s4VN1AKUg+ctHzHzZVRL/0nnYz3/Yjf47nvEHNp7exqYT0Y0j3WetuaHxwCFL011He9rlVfRnDO9hbiAAIOIDM0Wg7z9aF84pWyNDeRwkKiR3f3JP0zjPQQhg=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WO7DQQg_1737520538 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Jan 2025 12:35:38 +0800
Date: Wed, 22 Jan 2025 12:35:38 +0800
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
Subject: Re: [PATCH bpf-next v6 2/5] net/smc: Introduce generic hook smc_ops
Message-ID: <20250122043538.GC81479@j66a10360.sqa.eu95>
References: <20250116074442.79304-1-alibuda@linux.alibaba.com>
 <20250116074442.79304-3-alibuda@linux.alibaba.com>
 <86948347-529b-433a-991d-0b298776db63@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86948347-529b-433a-991d-0b298776db63@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jan 17, 2025 at 03:50:48PM -0800, Martin KaFai Lau wrote:
> On 1/15/25 11:44 PM, D. Wythe wrote:
> >diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
> >index 2fab6456f765..2004241c3045 100644
> >--- a/net/smc/smc_sysctl.c
> >+++ b/net/smc/smc_sysctl.c
> >@@ -18,6 +18,7 @@
> >  #include "smc_core.h"
> >  #include "smc_llc.h"
> >  #include "smc_sysctl.h"
> >+#include "smc_ops.h"
> >  static int min_sndbuf = SMC_BUF_MIN_SIZE;
> >  static int min_rcvbuf = SMC_BUF_MIN_SIZE;
> >@@ -30,6 +31,69 @@ static int links_per_lgr_max = SMC_LINKS_ADD_LNK_MAX;
> >  static int conns_per_lgr_min = SMC_CONN_PER_LGR_MIN;
> >  static int conns_per_lgr_max = SMC_CONN_PER_LGR_MAX;
> >+#if IS_ENABLED(CONFIG_SMC_OPS)
> >+static int smc_net_replace_smc_ops(struct net *net, const char *name)
> >+{
> >+	struct smc_ops *ops = NULL;
> >+
> >+	rcu_read_lock();
> >+	/* null or empty name ask to clear current ops */
> >+	if (name && name[0]) {
> >+		ops = smc_ops_find_by_name(name);
> >+		if (!ops) {
> >+			rcu_read_unlock();
> >+			return -EINVAL;
> >+		}
> >+		/* no change, just return */
> >+		if (ops == rcu_dereference(net->smc.ops)) {
> >+			rcu_read_unlock();
> >+			return 0;
> >+		}
> >+	}
> >+	if (!ops || bpf_try_module_get(ops, ops->owner)) {
> >+		/* xhcg */
> 
> typo. I noticed it only because...
> 
> >+		ops = rcu_replace_pointer(net->smc.ops, ops, true);
> 
> ... rcu_replace_pointer() does not align with the above xchg
> comment. From looking into rcu_replace_pointer, it is not a xchg. It
> is also not obvious to me why it is safe to assume "true" here...
> 
> >+		/* release old ops */
> >+		if (ops)
> >+			bpf_module_put(ops, ops->owner);
> 
> ... together with a put here on the return value of the rcu_replace_pointer.
> 

Hi Martin,

This is indeed a very good catch. Initially, I used the xhcg()
for swapping, but later I thought there wouldn't be a situation where
smc_net_replace_smc_ops would be called simultaneously with the same net.

Therefore, I modified it to rcu_replace_pointer, which is also why I assumed
that it was true here, I thought the updates here was prevented. but now I
realize that sysctl might not be mutually exclusive. It seems that this should
be changed back to xhcg().

> >+	} else if (ops) {
> 
> nit. This looks redundant when looking at the "if (!ops || ..." test above
> Also a nit, I would move the bpf_try_module_get() immediately after
> the above "if (ops == rcu_dereference(net->smc.ops))" test. This
> should simplify the later cases.
> 

This is a very good suggestion. I tried it and the code became very
clean. I'll take it in next version.

> >+		rcu_read_unlock();
> >+		return -EBUSY;
> >+	}
> >+	rcu_read_unlock();
> >+	return 0;
> >+}
> >+
> >+static int proc_smc_ops(const struct ctl_table *ctl, int write,
> >+#if IS_ENABLED(CONFIG_SMC_OPS)
> >+		struct smc_ops *ops;
> >+
> >+		rcu_read_lock();
> >+		ops = rcu_dereference(init_net.smc.ops);
> >+		if (ops && ops->flags & SMC_OPS_FLAG_INHERITABLE) {
> >+			if (!bpf_try_module_get(ops, ops->owner)) {
> >+				rcu_read_unlock();
> >+				return -EBUSY;
> 
> Not sure if it should count as error when the ops is in the process
> of un-register-ing. The next smc_sysctl_net_init will have NULL ops
> and succeed. Something for you to consider.
>

It seems more reasonable that no need to prevent net initialization
just because ops is uninstalling... I plan to just skip that error.

> 
> Also, it needs an ack from the SMC maintainer for the SMC specific
> parts like the sysctl here.

Got it. I will communicate this matter with the SMC maintainers.

Best wishes,
D. Wythe

