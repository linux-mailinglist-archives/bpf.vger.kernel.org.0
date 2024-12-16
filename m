Return-Path: <bpf+bounces-47056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9180A9F38BC
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 19:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BB1169B92
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 18:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3104206F13;
	Mon, 16 Dec 2024 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pzbf2BZg"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA58206266
	for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373144; cv=none; b=QHX1vVGasRIzKRuGQqxL6OWFYefrrW1/NfYIvecKo4YWCeqraDdpmai2ZQFe/3lLBCr6fspkt4OzLcYEiMkrRcZO742GZc63itFcI2JVGUbuLVWL9cV3w6y8vT040JRfNOFB5rYZwP2C6RlN5351bOyBGmkSNMMLrPPQcZPSCYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373144; c=relaxed/simple;
	bh=XeADyxpmxvEtydFIGRMY2qnAnOg/81ED90oQ6Jejlz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwsR6tYOH/VCo/BTijwtYLOReGvxuh8kYE2dRaTeuA6oTPAH1T5jwA+YDY8xM1oj2Piu2awgWOy4R1zKy6YW2K5R3+9iUtRA8J+P62PFCrdd+oZrlAArY+tPBmc5HrRAVqgsuvWj3f4ZN7UkAEg+/YOR7VmywzWHprr0eVaHjsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pzbf2BZg; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4ed0fa29-dd37-4a7e-8ba6-c84af9d735d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734373140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hx9bZkqjNfX4MWYa0iqLCx36co82y3p1t4Gc07zmj2k=;
	b=pzbf2BZg2GMFupJ4xWvqp0O6robV7hOTxw+PkeddgVQtAmxaX7aphfY0Epcktr5oIEm/Ta
	/99rQ1hfQTfwnGGLp6yOz12wDh9CYk8vdY2HtKnGUFDtLxcOhkZqR9a07EZRKC0Am1OxSo
	nlJZc7OIhUKYMGeC9dnNg3ovO4r6gOw=
Date: Mon, 16 Dec 2024 10:18:45 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/5] bpf: tcp: Mark bpf_load_hdr_opt() arg2 as
 read-write
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: pabeni@redhat.com, kuba@kernel.org, andrii@kernel.org, ast@kernel.org,
 edumazet@google.com, memxor@gmail.com, davem@davemloft.net,
 daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1734045451.git.dxu@dxuuu.xyz>
 <3de5c7e513e3161e040ee0ad6eb8cc4b7d71aa4c.1734045451.git.dxu@dxuuu.xyz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <3de5c7e513e3161e040ee0ad6eb8cc4b7d71aa4c.1734045451.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/12/24 3:22 PM, Daniel Xu wrote:
> MEM_WRITE attribute is defined as: "Non-presence of MEM_WRITE means that
> MEM is only being read". bpf_load_hdr_opt() both reads and writes from
> its arg2 - void *search_res.
> 
> This matters a lot for the next commit where we more precisely track
> stack accesses. Without this annotation, the verifier will make false
> assumptions about the contents of memory written to by helpers and
> possibly prune valid branches.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


