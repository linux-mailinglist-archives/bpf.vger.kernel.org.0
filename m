Return-Path: <bpf+bounces-73575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1334FC341F0
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 08:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFC474EB97F
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 07:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3172C21D1;
	Wed,  5 Nov 2025 07:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fTK+K2e8"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAC71E231E;
	Wed,  5 Nov 2025 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326108; cv=none; b=Py8RdEAzHkuuXrErzInndmV0tXHCPZ9+PiKOHyqYW6KMiZTCOXPLTsvuCKmL0GEIEb0whUlg8467PFTFBquzG6wR/2vemEiM8ItOBAN8TaYjNER3TAaQ4x+2B/3zHlHDO8oAOMBtJMRp8PQ9mrXdfYq7PvDfNNcVAU5avfxScfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326108; c=relaxed/simple;
	bh=zaNmRtse4opRZFdFVp2/88MUGwUrTeOwkZa8Omja2zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFNVMGg5iwAuc4IlUzo8kW7TfssWX+jlujSWdBTVEWX2eoKauZTNcHKBvjQ/DPmaKo+/v9mrEDHiHSh3BXlnxB3U6QiEnpmlg3CB7F8eA8KS9inH+57RFeypHCmAjkgPSRwVN2bqdQtCoF4sNyRvuKAvq7co9fxoeivAxo4SISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fTK+K2e8; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762326102; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=pAFmk8zdrpmyWSoXViiXp4r+9ZTn4cw9wTDEjHSLBp8=;
	b=fTK+K2e8+vg4V4EaNviS4f0tj2F3xRKKjJJXmkJAdluSeRda/D/LbLmIYyMF3b54URtcPnrEYcgNE0Y+xQ2gQ79igEZIUP1mGJwYhVdcxjQfwXgXQErl3O7Gz3L+XY70g4V94dQSNKXe8HvMykct+evr/bARcPiOxTkUwsk75Kk=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WrkF.dW_1762326100 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Nov 2025 15:01:40 +0800
Date: Wed, 5 Nov 2025 15:01:40 +0800
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
Subject: Re: [PATCH bpf-next v4 2/3] net/smc: bpf: Introduce generic hook for
 handshake flow
Message-ID: <20251105070140.GA31761@j66a10360.sqa.eu95>
References: <20251103073124.43077-1-alibuda@linux.alibaba.com>
 <20251103073124.43077-3-alibuda@linux.alibaba.com>
 <4450b847-6b31-46f2-bc2d-a8b3197d15c7@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4450b847-6b31-46f2-bc2d-a8b3197d15c7@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Nov 04, 2025 at 04:03:46PM -0800, Martin KaFai Lau wrote:
> 
> 
> On 11/2/25 11:31 PM, D. Wythe wrote:
> >+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
> >+#define smc_call_hsbpf(init_val, sk, func, ...) ({		\
> >+	typeof(init_val) __ret = (init_val);			\
> >+	struct smc_hs_ctrl *ctrl;				\
> >+	rcu_read_lock();					\
> >+	ctrl = rcu_dereference(sock_net(sk)->smc.hs_ctrl);	\
> 
> The smc_hs_ctrl (and its ops) is called from the netns, so the
> bpf_struct_ops is attached to a netns. Attaching bpf_struct_ops to a
> netns has not been done before. More on this later.
> 
> >+	if (ctrl && ctrl->func)					\
> >+		__ret = ctrl->func(__VA_ARGS__);		\
> >+
> >+	if (static_branch_unlikely(&tcp_have_smc) && tp->syn_smc) {
> >+		tp->syn_smc = !!smc_call_hsbpf(1, sk, syn_option, tp);
> 
> ... so just pass tp instead of passing both sk and tp?
> 
> [ ... ]
> 

You're right, it is a bit redundant. However, if we merge the parameters,
every user of this macro will be forced to pass tp. In fact, we’re
already considering adding some callback functions that don’t take tp as
a parameter.

I’ve been considering this: since smc_hs_ctrl is called from the netns,
maybe we should replace the sk parameter with netns directly. After all,
the only reason we pass sk here is to extract sock_net(sk). Doing so
would remove the redundancy and also keep the interface more flexible
for future extensions. What do you think?

> >+static int smc_bpf_hs_ctrl_init(struct btf *btf) { return 0; }
> >+
> >+static int smc_bpf_hs_ctrl_reg(void *kdata, struct bpf_link *link)
> 
> More on attaching to netns. There is discussion on how to attach a
> bpf_struct_ops to a particular cgroup in a link. I think the link
> should be able to attach a bpf_struct_ops to a particular netns
> also.
> 
> I would suggest to reject link now. Later, link support can be added
> to attach to a particular netns. This will be the last non-link-only
> bpf_struct_ops addition, considering the blast radius is limited on
> smc_hs_ctrl and the smc effort was started a while ago. I could have
> missed things here. Other experts could chime in.
> 
> 	if (link)
> 		return -EOPNOTSUPP;

Got it. This approach looks good to me. I’ll send out the next version
with this change.


