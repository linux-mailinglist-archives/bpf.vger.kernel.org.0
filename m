Return-Path: <bpf+bounces-73325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E0BC2A776
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 09:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F39F3BAFC5
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7162C2356;
	Mon,  3 Nov 2025 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4oU+Ryh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0FF299A94;
	Mon,  3 Nov 2025 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156536; cv=none; b=rf6HKt0pySXHHskjSf+CoOwq8NNCVNzsLjWy933vyPHmKI7UwCxwB0xoMGdqs/ecMKKWbX25BGzCx/Piage5Nm5vghgpbPsXZqp19NOgzXFXvEPO2PtzrfSjezqmGhy+Q1mdo6LoQoOP3afUQiQjHgPCi00ZIFpYByMAUJG4P/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156536; c=relaxed/simple;
	bh=YNPixSJYA3JDbHsT5BALFX8BA9BKMpCbGHtdSmu4c+Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MJCTyfOrX5MrPS5up5n5MJk1iuoI6KoJJrjNdWho6BdrlviIHlkvzyriTOYKUszIUtWoNS6PUrDvBLUuxBBs0bU5mf27JtcAAfny0qUMFDBoukCnwcp46IvoS4f54aA/OKoJXFqlHQb/mNdUjHRSS6Tx9TK0+ZfPAMTtPqfvUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4oU+Ryh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86465C4CEE7;
	Mon,  3 Nov 2025 07:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762156536;
	bh=YNPixSJYA3JDbHsT5BALFX8BA9BKMpCbGHtdSmu4c+Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=o4oU+RyhmIlMbUWlFLmmyQwX32IqXC5AIbMAZseu2CDO3GoHTXudUbw+I/yEpIu77
	 UjvK2LZDEBk0xVmaaVnq3zJMsx+bMumeyRKMeg9bi5c3vlaOh7xtPd1vXWw/+4dHg+
	 mY30cdJj2lSezVOXtRYguoKt8s4t2UAcKGZSvkXs7SDXaZ35xTX8VhTV7qWYQ7LI+d
	 sN8v8JCDgLepVlN4vCsZ3/gTj2hPcO3tjN2R7xNeb9ZPEQuYHRp8upNyDtPegMY8a6
	 OXeKOTL1hDLenbuVkz2i/mOeN+fKBJ9dAjgqlvZF7sfqv3BYpOm+dfnkrTAbjlAb32
	 DplqTnvwc2rpA==
Content-Type: multipart/mixed; boundary="===============7388337055491605420=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5866d0686028b734879265d8a47af12347e262a26ce86b0ab452b5d2a185d457@mail.kernel.org>
In-Reply-To: <20251103073124.43077-3-alibuda@linux.alibaba.com>
References: <20251103073124.43077-3-alibuda@linux.alibaba.com>
Subject: Re: [PATCH bpf-next v4 2/3] net/smc: bpf: Introduce generic hook for handshake flow
From: bot+bpf-ci@kernel.org
To: alibuda@linux.alibaba.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,sdf@google.com,haoluo@google.com,yhs@fb.com,edumazet@google.com,john.fastabend@gmail.com,kpsingh@kernel.org,jolsa@kernel.org,mjambigi@linux.ibm.com,wenjia@linux.ibm.com,wintera@linux.ibm.com,dust.li@linux.alibaba.com,tonylu@linux.alibaba.com,guwen@linux.alibaba.com
Cc: bpf@vger.kernel.org,davem@davemloft.net,kuba@kernel.org,netdev@vger.kernel.org,sidraya@linux.ibm.com,jaka@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  3 Nov 2025 07:55:35 +0000 (UTC)

--===============7388337055491605420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit b661eee197ec1c841de9195f171863daef37de34
Author: D. Wythe <alibuda@linux.alibaba.com>

net/smc: bpf: Introduce generic hook for handshake flow

This patch introduces a BPF struct_ops mechanism that allows eBPF
programs to control SMC protocol handshake decisions at runtime based on
connection properties like IP addresses and ports.

> diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
> index 2fab6456f..918516734 100644
> --- a/net/smc/smc_sysctl.c
> +++ b/net/smc/smc_sysctl.c

[ ... ]

> +#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
> +static int smc_net_replace_smc_hs_ctrl(struct net *net, const char *name)
> +{
> +	struct smc_hs_ctrl *ctrl = NULL;
> +
> +	rcu_read_lock();
> +	/* null or empty name ask to clear current ctrl */
> +	if (name && name[0]) {
> +		ctrl = smc_hs_ctrl_find_by_name(name);
> +		if (!ctrl) {
> +			rcu_read_unlock();
> +			return -EINVAL;
> +		}
> +		/* no change, just return */
> +		if (ctrl == rcu_dereference(net->smc.hs_ctrl)) {
> +			rcu_read_unlock();
> +			return 0;
> +		}
> +		if (!bpf_try_module_get(ctrl, ctrl->owner)) {
> +			rcu_read_unlock();
> +			return -EBUSY;
> +		}
> +	}
> +	/* xhcg old ctrl with the new one atomically */
> +	ctrl = unrcu_pointer(xchg(&net->smc.hs_ctrl, RCU_INITIALIZER(ctrl)));
> +	/* release old ctrl */
> +	if (ctrl)
> +		bpf_module_put(ctrl, ctrl->owner);
> +
> +	rcu_read_unlock();
> +	return 0;
> +}

Can concurrent sysctl writes race in smc_net_replace_smc_hs_ctrl? If
two threads both write the same ctrl name to the hs_ctrl sysctl:

Thread A: finds ctrl, bpf_try_module_get(ctrl) succeeds (refcount++)
Thread B: finds ctrl, bpf_try_module_get(ctrl) succeeds (refcount++)
Thread A: xchg(&net->smc.hs_ctrl, ctrl) returns old_ctrl
Thread B: xchg(&net->smc.hs_ctrl, ctrl) returns ctrl (from Thread A)
Thread A: bpf_module_put(old_ctrl)
Thread B: bpf_module_put(ctrl)  <- drops ref on ctrl still in use

This leaves ctrl with one less reference than needed while it's assigned
to net->smc.hs_ctrl, and old_ctrl leaks a reference. The xchg is atomic
but the overall get-xchg-put sequence is not. Would a mutex around the
entire operation resolve this?

> +
> +static int proc_smc_hs_ctrl(const struct ctl_table *ctl, int write,
> +			    void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct net *net = container_of(ctl->data, struct net, smc.hs_ctrl);
> +	char val[SMC_HS_CTRL_NAME_MAX];
> +	const struct ctl_table tbl = {
> +		.data = val,
> +		.maxlen = SMC_HS_CTRL_NAME_MAX,
> +	};
> +	struct smc_hs_ctrl *ctrl;
> +	int ret;
> +
> +	rcu_read_lock();
> +	ctrl = rcu_dereference(net->smc.hs_ctrl);
> +	if (ctrl)
> +		memcpy(val, ctrl->name, sizeof(ctrl->name));
> +	else
> +		val[0] = '\0';
> +	rcu_read_unlock();
> +
> +	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
> +	if (ret)
> +		return ret;
> +
> +	if (write)
> +		ret = smc_net_replace_smc_hs_ctrl(net, val);
> +	return ret;
> +}

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `net/smc: bpf: Introduce generic hook for handshake flow`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19027307093

--===============7388337055491605420==--

