Return-Path: <bpf+bounces-73775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A94AEC38E02
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 03:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B426D4EBC5C
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 02:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F0019D07E;
	Thu,  6 Nov 2025 02:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Pi6y3z/O"
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72038F54;
	Thu,  6 Nov 2025 02:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396395; cv=none; b=DFDFK8KP04kr/Xr2MnPmXPORGZOFv339TTPmwEthUnk8Rn9ByHi7sb758cJHX5FlcQUSegXVaGGb26l974iR7UwMYCBcMygywaWdSHmyEHoLqXnHyyofBMj7WGiH5E914KsSOX7tLhyj9Vu1t0j+AhHIp7KoTaRO84ZN8zfEePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396395; c=relaxed/simple;
	bh=6QCHulsPjkwv23mm5p9pInM4t/KIzWqHph6bKhJA+/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udxPArtHSnM5Av3kPcBbmY8Q5T0OwQHJQV+FsA0gqhnMfn/6x0jnsRAMnAJBIoAXfQgVRaGGZZoFOvf8+C4YY2NlDa+3TQR8uqsB8wGOZblC7nNxo9h/cS7oSR8f4l/JsmbiAyZNVJpDSqQLRHkCSFT4RVZNQAKFbeZo/DD4FyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Pi6y3z/O; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762396384; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=+2A9MuuqsDuWi1HYvLUVx6lOu3Rr0Oj3EUDLerzUFRo=;
	b=Pi6y3z/OwpdKOA+4oBEOaxYvPCpk99ztG/NxAQvR5S/b9T51c6SH5oTaHCZbj05hs/wKosmONlnD9SLTv/d2KVwfJ8etqbSKBdXtS44YyffI5I63/2Zl7/SWBoFrhjSu94A+nkw5yyzoDl4O/RPPK03iamqNDlygAhL+pU/xvHQ=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WrnbUO8_1762396382 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Nov 2025 10:33:02 +0800
Date: Thu, 6 Nov 2025 10:33:02 +0800
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
Message-ID: <20251106023302.GA44223@j66a10360.sqa.eu95>
References: <20251103073124.43077-1-alibuda@linux.alibaba.com>
 <20251103073124.43077-3-alibuda@linux.alibaba.com>
 <4450b847-6b31-46f2-bc2d-a8b3197d15c7@linux.dev>
 <20251105070140.GA31761@j66a10360.sqa.eu95>
 <dfed97fb-4e0c-416e-b5d8-8de7b3edce69@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfed97fb-4e0c-416e-b5d8-8de7b3edce69@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Nov 05, 2025 at 02:58:48PM -0800, Martin KaFai Lau wrote:
> 
> 
> On 11/4/25 11:01 PM, D. Wythe wrote:
> >On Tue, Nov 04, 2025 at 04:03:46PM -0800, Martin KaFai Lau wrote:
> >>
> >>
> >>On 11/2/25 11:31 PM, D. Wythe wrote:
> >>>+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
> >>>+#define smc_call_hsbpf(init_val, sk, func, ...) ({		\
> >>>+	typeof(init_val) __ret = (init_val);			\
> >>>+	struct smc_hs_ctrl *ctrl;				\
> >>>+	rcu_read_lock();					\
> >>>+	ctrl = rcu_dereference(sock_net(sk)->smc.hs_ctrl);	\
> >>
> >>The smc_hs_ctrl (and its ops) is called from the netns, so the
> >>bpf_struct_ops is attached to a netns. Attaching bpf_struct_ops to a
> >>netns has not been done before. More on this later.
> >>
> >>>+	if (ctrl && ctrl->func)					\
> >>>+		__ret = ctrl->func(__VA_ARGS__);		\
> >>>+
> >>>+	if (static_branch_unlikely(&tcp_have_smc) && tp->syn_smc) {
> >>>+		tp->syn_smc = !!smc_call_hsbpf(1, sk, syn_option, tp);
> >>
> >>... so just pass tp instead of passing both sk and tp?
> >>
> >>[ ... ]
> >>
> >
> >You're right, it is a bit redundant. However, if we merge the parameters,
> >every user of this macro will be forced to pass tp. In fact, we’re
> >already considering adding some callback functions that don’t take tp as
> >a parameter.
> 
> If the struct_ops callback does not take tp, then don't pass it to the
> callback. I have a hard time to imagine why the bpf prog will not be
> interested in the tp/sk pointer though.
> 
> or you meant the caller does not have tp? and where is the future caller?

My initial concern was that certain ctrl->func callbacks might
eventually need to operate on an smc_sock rather than a tcp_sock.
Crucially, we cannot always derive the owning smc_sock from a given
tcp_sock (at least not with the current design). Therefore, a macro
unconditionally passing tp (a tcp_sock pointer) would be unable to
handle future scenarios requiring operation on an smc_sock. This could
create an awkward situation with an unconditional tp argument.

However, considering the current situation, I believe the proposed
approach is workable. And for future cases where smc_sock-specific
callbacks become necessary, we can certainly introduce a new, dedicated
macro at that point to address it. Therefore, I'm happy to proceed with
your suggested change.

> >
> >I’ve been considering this: since smc_hs_ctrl is called from the netns,
> >maybe we should replace the sk parameter with netns directly. After all,
> >the only reason we pass sk here is to extract sock_net(sk). Doing so
> >would remove the redundancy and also keep the interface more flexible
> >for future extensions. What do you think?
> 
> The net can be obtained from the tp also.
> 
> Like in this patch, all the caller needs to type
> "const struct sock *sk = &tp->inet_conn.icsk_inet.sk;". I can imagine all
> the callers will have to type "sock_net((struct sock *)tp)" if passing net.
> Why not just do that in the smc_hs_ctrl instead of asking all the callers
> to type that?
> 
> I meant something like this (untested):
> 
> -#define smc_call_hsbpf(init_val, sk, func, ...) ({             \
> +#define smc_call_hsbpf(init_val, func, tp, ...) ({             \
> 	typeof(init_val) __ret = (init_val);                    \
> 	struct smc_hs_ctrl *ctrl;                               \
> 	rcu_read_lock();                                        \
> -	ctrl = rcu_dereference(sock_net(sk)->smc.hs_ctrl);      \
> +	ctrl = rcu_dereference(sock_net((struct sock *)(tp))->smc.hs_ctrl);     \
> 	if (ctrl && ctrl->func)                                 \
> -		__ret = ctrl->func(__VA_ARGS__);                \
> +		__ret = ctrl->func(tp, ##__VA_ARGS__);          \
> 	rcu_read_unlock();                                      \
> 	__ret;                                                  \
>  })
> 
>
Take it. I’ll send the updated version with this change.

