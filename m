Return-Path: <bpf+bounces-35956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9DB9401FD
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 02:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06111C21E95
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 00:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2374A21;
	Tue, 30 Jul 2024 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CIoBVdlJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B923E3C17
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722298817; cv=none; b=EpUZvCwWVMZLiHMHnpX6d+V/T4mBIe2Xqza6BA1C1jILfmQgp+9yO2P+KBW1QG3OBht0s4JO5mALhjG5Qy/quVlKvwvsLtKaPdWRfaRzSiN+kHv8fcb/NTARNR46AFykAXMb05IohOCqne+LAnVnPINoIljNVjhw/1iytZ9nQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722298817; c=relaxed/simple;
	bh=XC+x+d4hoRmAcpxmpCSeZUnCHsTeyvtfpT75aozl8Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9sTAja1mfWSBdvfaKnf+wIjOdsxPdVpRgdXgjdydot6CtFnqn7RMipJmqQ+Vj/VCnsfHQ0kgJ5FPJI98r9dNv/5iAqHVyzv+Ri1L7AUfrRB1rNrIhSCdbeaB7fq9graF77R0rQGojCVX1zlCjbY6KumvTix4IxWM+z6X/322/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CIoBVdlJ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a5ffa6da-b58e-4b83-961e-23d730eb5f25@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722298812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0t4Am9sQ981nqeF0wgRdUH+gyyigUKFZMdXOPvNK98=;
	b=CIoBVdlJkOuufV2uw8sfVl7pBRLtKKYfmPPNPkLkXyeyjN6QGWxSx0Li8B7jLtG5bVyXHB
	eO+tP6xb4fCzTucNq8GlF0kmCGxRWAF03eJ5KzO+eTOWzJjY5Dk6B4EFDWsXeTQ8Su9/0r
	2utguttf4DYBUa+j+F2miwsWefm6kpg=
Date: Mon, 29 Jul 2024 17:20:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v9 07/11] bpf: net_sched: Allow more optional
 operators in Qdisc_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 yepeilin.cs@gmail.com, Stanislav Fomichev <sdf@fomichev.me>
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-8-amery.hung@bytedance.com>
 <f3bfe9a5-40e8-4a1c-a5e5-0f7f24b9e395@linux.dev>
 <CAMB2axNNmoGAE8DBULe8Pjd3jtc=Tt4xKCyamPwqtB8fT5j75A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axNNmoGAE8DBULe8Pjd3jtc=Tt4xKCyamPwqtB8fT5j75A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/26/24 3:30 PM, Amery Hung wrote:
>> The pre/post is mainly to initialize and cleanup the "struct bpf_sched_data"
>> before/after calling the bpf prog.
>>
>> For the pre (init), there is a ".gen_prologue(...., const struct bpf_prog
>> *prog)" in the "bpf_verifier_ops". Take a look at the tc_cls_act_prologue().
>> It calls a BPF_FUNC_skb_pull_data helper. It potentially can call a kfunc
>> bpf_qdisc_watchdog_cancel. However, the gen_prologue is invoked too late in the
>> verifier for kfunc calling now. This will need some thoughts and works.
>>
>> For the post (destroy,reset), there is no "gen_epilogue" now. If
>> bpf_qdisc_watchdog_schedule() is not allowed to be called in the ".reset" and
>> ".destroy" bpf prog. I think it can be changed to pre also? There is a ".filter"
>> function in the "struct btf_kfunc_id_set" during the kfunc register.
>>
> I can see how that would work. The ability to add prologue, epilogue
> to struct_ops operators is one thing on my wish list.
> 
> Meanwhile, I am not sure whether that should be written in the kernel
> or rewritten by the verifier. An argument for keeping it in the kernel
> is that the prologue or epilogue can get quite complex and involves
> many kernel structures not exposed to the bpf program (pre-defined ops
> in Qdisc_ops in v8).

Can the v8 pre-defined ops be called as a kfunc? The qdisc_watchdog_cancel/init 
in v9 could be a kfunc and called by pro/epilogue.

For checking and/or resetting skb->dev, it should be simple enough without 
kfunc. e.g. when reusing the skb->rbnode in the future followup effort.

[ Unrelated to qdisc. bpf_tcp_ca can also use help to ensure the cwnd is sane. ]

> 
> Maybe we can keep the current approach in the initial version as they
> are not in the fast path, and then move to (gen_prologue,
> gen_epilogue) once the plumbing is done?

Sure. It can be improved when things are ready.

I am trying some ideas on how to do gen_epilogue and will share when I get some 
tests working.

