Return-Path: <bpf+bounces-30810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7AF8D29D3
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 03:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE1D1F259A2
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 01:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBE515AAD7;
	Wed, 29 May 2024 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QyCmql2V"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582AC1E86E
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945366; cv=none; b=jl4W4VTchFre0VxjYEFaV1PqBtsOV29v2wUijh8ydPfRQNmyw+AaUDnSEePhnhGEchKfNA78Y4+c8aTAwZdbs4ylrdYVh6j50UGhubB89152HKadOfunmyPV+wI7S9htDDFeMuYeMSXh42g2Xfu3aJK+gM7Rn2LjZs+U6guqHsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945366; c=relaxed/simple;
	bh=VbXMKPFRNM4rvJJUONqIaV2ZyDimdXjJrsK52bXShYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEBLLNiWIZWxPaiPEco30zxDgCcI468syZmnu/OUk+HhkFO3E4k/d48CHtuQC7UjuFyHO52PrarLBV7B2ZcB+Ec4eCzjpwMLMrM0gp/OYRdpkNeXYbXSDekAp5jXL5bI5xy8FeFVeqArzUQaT2hjYRs+q4FROJldQjksfIhMr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QyCmql2V; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: quic_abchauha@quicinc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716945360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zssiFsZDZZBTEpQvJYkG+CokD4QQQjIoL2kKugnyhxk=;
	b=QyCmql2V6OXKrZ5ZFlBeyb7JhYtjR5HEBKolnaVUPPakCu3U10iMi69Syi2uzvPpMvqQdu
	xFLJOQRaYAUoUs3/KycH3emfzXHatBCSXSetYR5/bBS/vKmy4qlT3tE1UHXWtajEsoPz0w
	sCKE3vb9kULn95vxftruVdj+vMYmDeI=
X-Envelope-To: davem@davemloft.net
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: ahalaney@redhat.com
X-Envelope-To: willemdebruijn.kernel@gmail.com
X-Envelope-To: martin.lau@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: kernel@quicinc.com
X-Envelope-To: syzbot+d7b227731ec589e7f4f0@syzkaller.appspotmail.com
X-Envelope-To: syzbot+30a35a2e9c5067cc43fa@syzkaller.appspotmail.com
Message-ID: <2c363f12-dd52-4163-bbcd-9a017cff6dd4@linux.dev>
Date: Tue, 28 May 2024 18:15:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: validate SO_TXTIME clockid coming from userspace
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
 kernel@quicinc.com, syzbot+d7b227731ec589e7f4f0@syzkaller.appspotmail.com,
 syzbot+30a35a2e9c5067cc43fa@syzkaller.appspotmail.com
References: <20240528224935.1020828-1-quic_abchauha@quicinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240528224935.1020828-1-quic_abchauha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/28/24 3:49 PM, Abhishek Chauhan wrote:
> Currently there are no strict checks while setting SO_TXTIME
> from userspace. With the recent development in skb->tstamp_type
> clockid with unsupported clocks results in warn_on_once, which causes
> unnecessary aborts in some systems which enables panic on warns.
> 
> Add validation in setsockopt to support only CLOCK_REALTIME,
> CLOCK_MONOTONIC and CLOCK_TAI to be set from userspace.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Link: https://lore.kernel.org/lkml/20240509211834.3235191-1-quic_abchauha@quicinc.com/
> Fixes: 1693c5db6ab8 ("net: Add additional bit to support clockid_t timestamp type")

Patch lgtm. This should target for net-next instead of net. The Fixes patch is 
in net-next only.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


