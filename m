Return-Path: <bpf+bounces-74258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F13AAC4FB1C
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 21:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F12E189DA12
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 20:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40FC33D6E1;
	Tue, 11 Nov 2025 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ueOwwkFK"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDD8329E7E
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762892590; cv=none; b=YDsQEdv6JhFnnFcHSGp6RSMqJ60cCpvLuNPFKbp2LYG/eipn/lqbMxkBE8Umh6t87BS8hsvb2AejjwRg6tW/pz8aJVhAqPgAAHmiuRRKOT3n+JEIwJL/a9V4ObbDHDZvWrAEfw2YFelNHgp1Pwi3m/mjeJRusgxFaF+gUP//ISA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762892590; c=relaxed/simple;
	bh=zLhsizFAe55OtR0Cf8/78BB9NKB2bJDiodRq5Szf1t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsLFfkzBaCfwdB/10VOT2GwVzZUYzDF6GNHOJDRRdfw1XxVvc5djrKZ7xo17c4vWxHsP7+TyxyWLMer48eFLgll+Kx6Ub2Ymr4/gdz0U75PwWnyMxyTfyEhvnnLPzl2rv44SdxhZXsnAr2xPxJJYdV2Ffc89iluvSIhs8RDKtWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ueOwwkFK; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fce1c70c-c848-415d-8be4-9fba21c70fee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762892584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mX/V6DxBbpL7d7tujJeXyP718nTReA7UG/ylICigU9w=;
	b=ueOwwkFKR/9Oi52yiCCi+FG79J/JBvUXcjqrDF++ptmeQIFdWiJHz4F22hadJLssoZxqbw
	Tsba5T+dFRFhLrPfH0DxOTM4Os+AlAuyR8XZ7WorFx6bBW9VDzLZg6sSv1b66eXb3XMhI7
	noVZSeEtZtBk3NHC6wQhYsMw3kNCPsY=
Date: Tue, 11 Nov 2025 12:22:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: use preempt_disable/enable() to protect
 bpf_bprintf_buffers nesting
Content-Language: en-GB
To: Sahil Chandna <chandna.sahil@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bigeasy@linutronix.de, bpf@vger.kernel.org
Cc: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
References: <20251111170628.410641-1-chandna.sahil@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251111170628.410641-1-chandna.sahil@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/11/25 9:06 AM, Sahil Chandna wrote:
> The bpf_bprintf_prepare() and related helpers (bpf_try_get_buffers() /
> bpf_put_buffers()) rely on a per-CPU counter bpf_bprintf_nest_level to
> manage nested buffer usage. However, when invoked from different contexts
> (process, softirq, NMI), the nesting counter can become inconsistent if
> task  migration occurs between CPUs during these operations. This can
> result in warnings such as:
>
> WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 bpf_try_get_buffers kernel/bpf/helpers.c:781 [inline]
> WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 bpf_bprintf_prepare+0x12cf/0x13a0 kernel/bpf/helpers.c:834
>
> Having only migrate_disable is insufficient here to prevent nesting,
> hence add preempt_disable()/enable() around buffer acquisition and release.
>
> Reported-by: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68f6a4c8.050a0220.1be48.0011.GAE@google.com/
> Fixes: 4223bf833c849 ("bpf: Remove preempt_disable in bpf_try_get_buffers")
> Suggested-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Sahil Chandna <chandna.sahil@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>



