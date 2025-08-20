Return-Path: <bpf+bounces-66064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882C0B2D52D
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 09:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BDC16C016
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 07:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E942C11D2;
	Wed, 20 Aug 2025 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="TKeYPKFf"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43154227563
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755676089; cv=none; b=DNZzy45YzUAkR3i8lX8R1QowtTYMCCPw+QXqgDQloIft38SuSIAzMJwCIa1gN7Y64yOGeNnt6U2Nkfc86dsdnfpxO+C8SLkE7SSinc8/3PsMPbMgaKfPcSZK2GTfNi/jUi1Ou8+nz3td/absx2egrTHTAtP56RW0n1+oSpyMBMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755676089; c=relaxed/simple;
	bh=sPQ+GNnyeDIiWlD9x/lg86FI9kidylBiDIYxR31vjCo=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:Cc:From:
	 In-Reply-To:Content-Type; b=Lh2m6wKuJLL1OWMQfwVTDIL+yOczoJBDuKySak98eupKe2quoR2ep2uqvVxFy2nQRZ3mnt22tkv0zafOxT7GDZ3o4VO4gKXAanTFYxNzbxIkc38SQKJKZXEHaF0PmaAQ4AJcF/WvAxbD9djrH3KY5Mrl0ymrx3cS3G0vTz+t9DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=TKeYPKFf; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from [10.128.8.2] (unknown [14.139.174.50])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id D804544C53;
	Wed, 20 Aug 2025 07:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1755676084;
	bh=sPQ+GNnyeDIiWlD9x/lg86FI9kidylBiDIYxR31vjCo=;
	h=Date:Subject:References:To:Cc:From:In-Reply-To:From;
	b=TKeYPKFf9Pym/0RMNnuXXs/BabEDJlfNvVpgE8+FB3UF/qmPIERLHkmr3hs0MPxqr
	 c3KXcqMlOfaQ4r4DmSF+mWM9GjVxGZYMgry1c7X5gZMl38lr+OYxGImabbJqeetZqk
	 5OKi7Q1c8Nr16QtD4hu1cenkz01hVQNuva5H80Wnj1e4Qdiyieif8cEFWmNB5UBg/H
	 RMqLKM4QefpbwFFPZ5IRwInMSmCCI32lnSaNfx94ZPxOkOY///oZdLipwIWtaC2UKI
	 PO3zViRcuvadcq0+7fkwpJEYU0ntfDa2hZtcFGiA6wynoTeYkYy5RHX7S6Eve9i8tf
	 fD6EVaYwDrsig==
Message-ID: <c1296815-67f5-4f31-99fe-b9a86bb7a117@nandakumar.co.in>
Date: Wed, 20 Aug 2025 13:18:01 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: [PATCH v2 bpf-next] bpf: improve the general precision of
 tnum_mul
Content-Language: en-US
References: <0ba41cd7-adc0-4c65-b1e0-defd8ebc2d64@nandakumar.co.in>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
In-Reply-To: <0ba41cd7-adc0-4c65-b1e0-defd8ebc2d64@nandakumar.co.in>
X-Forwarded-Message-Id: <0ba41cd7-adc0-4c65-b1e0-defd8ebc2d64@nandakumar.co.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/08/25 11:45, Harishankar Vishwanathan wrote:
> This is nice work on improving the precision of the tnum_mul algorithm
> Nandakumar. I had a few questions and comments (below).
Thanks a lot for going through this seriously.
> If I understand the idea correctly, when the multiplier's (i.e. tnum a) bit is
> unknown, it can either be 0 or 1. If it is 0, then we add nothing to
> accumulator, i.e. TNUM(0, 0). If it is 1, we can add b to the accumulator
> (appropriately shifted). The main idea is to take the union of these two
> possible partial products, and add that to the accumulator. If so, could we also
> do the following?
>
> acc = tnum_add(acc, tnum_union(TNUM(0, 0), b));

But tnum_union(TNUM(0, 0), b) would introduce a concrete 0 to the set, 
right?

> The comments in your algorithm seem different from what the code implements: I
> believe the comment should read:
> /* acc = tnum_union(acc_0, acc_1), where acc_0 and ... */
Yes, thanks a lot for pointing out! Will fix in v3.
> Finally, what is the guarantee that this algorithm is sound? It will be useful
> to have a proof to ensure that we are maintaining correctness.

Been working on it.

Thank you,

-- 
Nandakumar Edamana


