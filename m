Return-Path: <bpf+bounces-77148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D19CCFCB1
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 13:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72AFF3011B17
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 12:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C52B32143D;
	Fri, 19 Dec 2025 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VTyhYmTH"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8231AF37
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766147310; cv=none; b=GLthvstx31dd6qyszyzu9z99CcfWm85oAtdmTqV9yexkuT8BaRv6xK8e4KMQVXfEg6R+HnZLS6JcDeJ3S/tZapHPPhP//DjkYhe3gQUGNXFoNM4by3W2ieeBZeS/IHpK7+dC26FNV2sKoFWn1Ee510lDXsvZqMbY1iu+eHcsyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766147310; c=relaxed/simple;
	bh=X/x1LnpMQXL4eyhPMjonU6Gyu+r6ybeFAl5OSO1qNRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHq3zniKgPqkegEqHRR4QVk6I46cbFQrDwcC+mcyqBT5UIlIIwgsi05ty5Kbx/KskhIrzeMzcqYwDiHY5clEgwJGKR51NxmEXlwEg46xlXBPVGgQ1tVG5dy7PzCkn9XMfOdBo9zFl88CWUV0Lvoih5xkUle1BYM9y/yqggp8W+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VTyhYmTH; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766147297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qJlRhz4EpTERncBnrOiB8jIiNe7UFsfDD9FRMuJEcU=;
	b=VTyhYmTH2MlImfb3hCc/m8y1Xce3/ZY87nHvHksc4abkjCtPOfv6kClwnR+Q8FU2AV4j7D
	VK3IonRR0TBimdWLYzE/ay22Y9TObAUlkSNxC+fhmKAD90MXUL+JwDz3uzpirfyhWm3q0T
	v1KxDBomw6As7XtXyL0ERwsYfQopkXg=
From: Menglong Dong <menglong.dong@linux.dev>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
 rostedt@goodmis.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, jiang.biao@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject:
 Re: [PATCH bpf-next v3 3/6] bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
Date: Fri, 19 Dec 2025 20:27:37 +0800
Message-ID: <5070743.31r3eYUQgx@7950hx>
In-Reply-To: <875xa2g0m0.fsf@igel.home>
References:
 <20251118123639.688444-1-dongml2@chinatelecom.cn> <3730454.R56niFO833@7940hx>
 <875xa2g0m0.fsf@igel.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/12/19 19:41, Andreas Schwab wrote:
> On Dez 19 2025, Menglong Dong wrote:
> 
> > BPF_TRAMP_F_ORIG_STACK
> 
> How can that ever be set?

Oops, my bad! It should be BPF_TRAMP_F_CALL_ORIG here. I think
it is some kind of copy-paste mistake. I'll send a fix for it.

Thanks!
Menglong Dong

> 
> 	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
> 		return -ENOTSUPP;
> 
> 





