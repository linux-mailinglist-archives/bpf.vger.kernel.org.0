Return-Path: <bpf+bounces-73332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCA2C2AB36
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 10:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216091891DCE
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 09:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0F92E8B6C;
	Mon,  3 Nov 2025 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mQjV7pmZ"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643032E7BCE;
	Mon,  3 Nov 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762161521; cv=none; b=OhQ8hx0Tnd1Rk7U7UMFk9XV82R0CZyuUwTrDz7/Oy3U6AQuuxtjC+N4tvcRqcNa6imXR+TPi1pV/xW0/fBFrOdfXXYqVMXQAi2gHgz6Vh9BkZQ9wTp6roH22Ro8L6nFoA9m9+EzF+DOHQEesm0ZzYtmCRNEX1J00CiSdnxLpSqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762161521; c=relaxed/simple;
	bh=tYjeheWaba6I+qAn2srd2uQ5fTEtr6thhhFcGsL+Uao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SM9mOi/98YzgxN08dRYrl6Hoe/41xV6BtpOxiD0BLlCnKa6FUOeXznTNTwZcFVvII9GkWdQetLh9HuWK6Kga/i945Axrl+OtOlANcx45FgGf6IkLkKVejyCUvqdQYAvt+jmCL6aMxTQo/Vbh9WxDWc4lYJ+2qTjfwh8HASQzdb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mQjV7pmZ; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762161516; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=csce8FfSnvg8MDNzJGtiq+0fyNkhv/KcKz8tWavDAXA=;
	b=mQjV7pmZEvH3jkpjcv1QKmAKlB2uskVc/jE+bVOuJfwGMdBNiUpLisUzoWcO/9I3ghCXXdPIvZOyBh37nwQ4Cf7JXxRZ8RD5wyX6CbbkyT8lsiwQyv/bt3oyYmf9kpUwDdpyPX6lZagxzW+nL4GoyOFvvZpoLVkNyFk6DsYaX30=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WrZwqGU_1762161514 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Nov 2025 17:18:34 +0800
Date: Mon, 3 Nov 2025 17:18:34 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: bot+bpf-ci@kernel.org
Cc: alibuda@linux.alibaba.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, pabeni@redhat.com,
	song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
	edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	jolsa@kernel.org, mjambigi@linux.ibm.com, wenjia@linux.ibm.com,
	wintera@linux.ibm.com, dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	netdev@vger.kernel.org, sidraya@linux.ibm.com, jaka@linux.ibm.com,
	martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v4 2/3] net/smc: bpf: Introduce generic hook for
 handshake flow
Message-ID: <20251103091834.GA10875@j66a10360.sqa.eu95>
References: <20251103073124.43077-3-alibuda@linux.alibaba.com>
 <5866d0686028b734879265d8a47af12347e262a26ce86b0ab452b5d2a185d457@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5866d0686028b734879265d8a47af12347e262a26ce86b0ab452b5d2a185d457@mail.kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Nov 03, 2025 at 07:55:35AM +0000, bot+bpf-ci@kernel.org wrote:
> 
> ```
> commit b661eee197ec1c841de9195f171863daef37de34
> Author: D. Wythe <alibuda@linux.alibaba.com>
> 
> net/smc: bpf: Introduce generic hook for handshake flow
> 
> This patch introduces a BPF struct_ops mechanism that allows eBPF
> programs to control SMC protocol handshake decisions at runtime based on
> connection properties like IP addresses and ports.
> 
> > diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
> > index 2fab6456f..918516734 100644
> > --- a/net/smc/smc_sysctl.c
> > +++ b/net/smc/smc_sysctl.c
> 
> [ ... ]
> 
> > +#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
> > +static int smc_net_replace_smc_hs_ctrl(struct net *net, const char *name)
> > +{
> > +	struct smc_hs_ctrl *ctrl = NULL;
> > +
> > +	rcu_read_lock();
> > +	/* null or empty name ask to clear current ctrl */
> > +	if (name && name[0]) {
> > +		ctrl = smc_hs_ctrl_find_by_name(name);
> > +		if (!ctrl) {
> > +			rcu_read_unlock();
> > +			return -EINVAL;
> > +		}
> > +		/* no change, just return */
> > +		if (ctrl == rcu_dereference(net->smc.hs_ctrl)) {
> > +			rcu_read_unlock();
> > +			return 0;
> > +		}
> > +		if (!bpf_try_module_get(ctrl, ctrl->owner)) {
> > +			rcu_read_unlock();
> > +			return -EBUSY;
> > +		}
> > +	}
> > +	/* xhcg old ctrl with the new one atomically */
> > +	ctrl = unrcu_pointer(xchg(&net->smc.hs_ctrl, RCU_INITIALIZER(ctrl)));
> > +	/* release old ctrl */
> > +	if (ctrl)
> > +		bpf_module_put(ctrl, ctrl->owner);
> > +
> > +	rcu_read_unlock();
> > +	return 0;
> > +}
> 
> Can concurrent sysctl writes race in smc_net_replace_smc_hs_ctrl? If
> two threads both write the same ctrl name to the hs_ctrl sysctl:
> 
> Thread A: finds ctrl, bpf_try_module_get(ctrl) succeeds (refcount++)
> Thread B: finds ctrl, bpf_try_module_get(ctrl) succeeds (refcount++)
> Thread A: xchg(&net->smc.hs_ctrl, ctrl) returns old_ctrl
> Thread B: xchg(&net->smc.hs_ctrl, ctrl) returns ctrl (from Thread A)
> Thread A: bpf_module_put(old_ctrl)
> Thread B: bpf_module_put(ctrl)  <- drops ref on ctrl still in use
> 
> This leaves ctrl with one less reference than needed while it's assigned
> to net->smc.hs_ctrl, and old_ctrl leaks a reference. The xchg is atomic
> but the overall get-xchg-put sequence is not. Would a mutex around the
> entire operation resolve this?
>

Hi claude,

I don't think this is a problem:

1. The first thread sets hs_ctrl = ctrl and keeps its reference.
2. The second thread sees hs_ctrl is already ctrl, so its xchg returns ctrl,
   and it drops its own redundant reference.
3. The final state is hs_ctrl = ctrl with refcount=1, which is correct.

In all cases:

- The reference held by hs_ctrl is the one acquired by the last writer.
- Other writers only drop their own temporary references.

D. Wythe


