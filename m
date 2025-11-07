Return-Path: <bpf+bounces-73931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC65C3E4FB
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 04:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7451188BF5D
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 03:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DCC2C21F3;
	Fri,  7 Nov 2025 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O51cbQOt"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31072AF1B;
	Fri,  7 Nov 2025 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762485103; cv=none; b=cCyu+1skVac1GfvBGjktnt/bfFqRLeP9zzhhKl6rSfm8H7FJE/QIv8+mNjOn+pzKZ+IRHXVu3pMt2zAYfIzilfK58GL1jv5IxwiLlZlV39hzUCgst0drj3BiZAnHUsGwVD1PxluRiBBBu9hRvJjLDBajywagcDAk01uXTX3iN5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762485103; c=relaxed/simple;
	bh=3ZP8PPkWkyXrp4/aDPXsoHLda/BrPQk+AvDNgnKmNOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojc1ACxg+E2CQ8j+80vkl1Qt2nFbB9CJ8IbNV6kRCN+e5p7GfPB3KsWdcmmgpF/dMzece06KRAIYZNyuyZGkMRKYIaMqnPXtHs4uqGhX7s9uM5sBCEFxYoBs4zf4vLFk2IFoLLgp7ay17eAnF26L++XoFyg57Vbjdo9VsHHCAHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O51cbQOt; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762485092; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=4BO6EsevzKqH6P+VD8vIf0y2+kccgp4F9N7TnPgw8CE=;
	b=O51cbQOtVyeq6BUxu9RP2noUp7fIdFaIPO/w86uiPQjhnhqzqBhO98JRxAE/OaJOa//Eoe3PjCLKlHoGBNW8NhUo7PKnHOYB3gU5UyCp2M8vuMwCSxzCRzoibXkB/xKhmkHEiQpsyv332vrXbCgzfiFMMJ6TiCrg0hSO8rjmzW0=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WrrHF8i_1762485090 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Nov 2025 11:11:30 +0800
Date: Fri, 7 Nov 2025 11:11:30 +0800
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
Message-ID: <20251107031130.GA89050@j66a10360.sqa.eu95>
References: <20251103073124.43077-1-alibuda@linux.alibaba.com>
 <20251103073124.43077-3-alibuda@linux.alibaba.com>
 <4450b847-6b31-46f2-bc2d-a8b3197d15c7@linux.dev>
 <20251105070140.GA31761@j66a10360.sqa.eu95>
 <dfed97fb-4e0c-416e-b5d8-8de7b3edce69@linux.dev>
 <20251106023302.GA44223@j66a10360.sqa.eu95>
 <d6a53bed-b197-432c-84e5-ac324b36137e@linux.dev>
 <20251106083429.GA35123@j66a10360.sqa.eu95>
 <c4e481e6-570e-45bc-b390-fa21192782f8@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4e481e6-570e-45bc-b390-fa21192782f8@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Nov 06, 2025 at 09:15:54AM -0800, Martin KaFai Lau wrote:
> 
> 
> On 11/6/25 12:34 AM, D. Wythe wrote:
> >On Wed, Nov 05, 2025 at 08:16:45PM -0800, Martin KaFai Lau wrote:
> >>
> >>
> >>On 11/5/25 6:33 PM, D. Wythe wrote:
> >>>On Wed, Nov 05, 2025 at 02:58:48PM -0800, Martin KaFai Lau wrote:
> >>>>
> >>>>
> >>>>On 11/4/25 11:01 PM, D. Wythe wrote:
> >>>>>On Tue, Nov 04, 2025 at 04:03:46PM -0800, Martin KaFai Lau wrote:
> >>>>>>
> >>>>>>
> >>>>>>On 11/2/25 11:31 PM, D. Wythe wrote:
> >>>>>>>+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
> >>>>>>>+#define smc_call_hsbpf(init_val, sk, func, ...) ({		\
> >>>>>>>+	typeof(init_val) __ret = (init_val);			\
> >>>>>>>+	struct smc_hs_ctrl *ctrl;				\
> >>>>>>>+	rcu_read_lock();					\
> >>>>>>>+	ctrl = rcu_dereference(sock_net(sk)->smc.hs_ctrl);	\
> >>>>>>
> >>>>>>The smc_hs_ctrl (and its ops) is called from the netns, so the
> >>>>>>bpf_struct_ops is attached to a netns. Attaching bpf_struct_ops to a
> >>>>>>netns has not been done before. More on this later.
> >>>>>>
> >>>>>>>+	if (ctrl && ctrl->func)					\
> >>>>>>>+		__ret = ctrl->func(__VA_ARGS__);		\
> >>>>>>>+
> >>>>>>>+	if (static_branch_unlikely(&tcp_have_smc) && tp->syn_smc) {
> >>>>>>>+		tp->syn_smc = !!smc_call_hsbpf(1, sk, syn_option, tp);
> >>>>>>
> >>>>>>... so just pass tp instead of passing both sk and tp?
> >>>>>>
> >>>>>>[ ... ]
> >>>>>>
> >>>>>
> >>>>>You're right, it is a bit redundant. However, if we merge the parameters,
> >>>>>every user of this macro will be forced to pass tp. In fact, we’re
> >>>>>already considering adding some callback functions that don’t take tp as
> >>>>>a parameter.
> >>>>
> >>>>If the struct_ops callback does not take tp, then don't pass it to the
> >>>>callback. I have a hard time to imagine why the bpf prog will not be
> >>>>interested in the tp/sk pointer though.
> >>>>
> >>>>or you meant the caller does not have tp? and where is the future caller?
> >>>
> >>>My initial concern was that certain ctrl->func callbacks might
> >>>eventually need to operate on an smc_sock rather than a tcp_sock.
> >>
> >>hmm...in that case, I think it first needs to understand where else
> >>the smc struct_ops is planned to be called in the future. I thought
> >>the smc struct_ops is something unique to the af_smc address family
> >>but I suspect the future ops addition may not be the case. Can you
> >>share some details on where the future callback will be? e.g. in
> >>smc_{connect, sendmsg, recvmsg...} that has the smc_sock?
> >
> >The design scope of hs_ctrl (handshake control) is limited to
> >the SMC protocol's handshake phase. This means it will not be involved
> >in data transmission functions like smc_sendmsg and smc_recvmsg, Instead,
> >its focus is on:
> >
> >1. During the TCP three-way handshake
> >2. During the SMC protocol's own handshake. (proposal -> confirm ->
> >accept)
> >
> >Within the SMC module, hs_ctrl's primary future call points are
> >concentrated within the __smc_connect() and smc_listen_work(). These
> >two functions cover the SMC protocol handshake process.
> >
> >And we have a plan involving private extensions to the SMC protocol.
> >In the SMC protocol, different implementers can extend protocol functionality
> >based on their Vendor Organizationally Unique Identifier (vendor_oui). You might
> >notice that currently, the SMC implementation only has this vendor_oui field,
> >but without corresponding functionality. This is highly significant for our
> >applications, as many of our internal features rely on these private extensions.
> >However, due to their inherent nature, these private features cannot be
> >upstreamed. Therefore, BPF is the best way to implement these. Since
> >these private extensions are essentially part of the SMC handshake
> >process, hs_ctrl has become our first choice.
> >
> >Beyond that, we are also considering other minor extensions to be
> >implemented via hs_ctrl. These include assisting in the selection of the
> >appropriate SMC device type and making decisions regarding which RDMA
> >GID to use. (also in __smc_connect() and smc_listen_work()).
> 
> Thanks for the details.
> 
> Regarding the "net" passing and the future smc_sock, the net can
> still be obtained from smc_sock. It seems like a naming change on
> "tp" is needed when it may be a smc_sock in the future. It is a nit,
> so I will leave it as a fruit of thought for you and feel free to
> ignore.
> 
> Please re-spin.

Thank you for the feedback. Your suggestions make sense. I'll follow your
advice and remove the redundant parameter. For now, I'll keep tp as the
parameter name, and we can adjust it later if needed for future extensions.

