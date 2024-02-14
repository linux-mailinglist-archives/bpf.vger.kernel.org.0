Return-Path: <bpf+bounces-21949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7629E854287
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 06:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215961F2491B
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 05:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1C2D510;
	Wed, 14 Feb 2024 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDl2HzV4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87DF10A01
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 05:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707890008; cv=none; b=NMZBQpXgLQHYGiHZrfiWCwsyYznLyIvJO6PfOYQokoOEozsV9yngbtEohRBfdZZe34nRV/lYxShTMgCmGf1WBfDMoZPhqMBbhuQoEDoP35TahdgmSQnAsH2O6u/xYR27UcmGFrJbnpUv91AVF+x/Tg2HKg+bpTcHWQYDkvC7+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707890008; c=relaxed/simple;
	bh=i+oBjkiIakyu8O+RQOZUmMkml3yTxI6Ats67urmuOxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uqs5jGCJh2lntZC/+2fUflRWK6w8QKJwfsS5Pbybl2EJ4xokIvjN7qVKeDF5kgfa4yHyWOexMykSD8K4O0CuVMoBjFCoDMJYuJ+VANLUqXAzIHQyNTM4H/+3RfObXBiVhRP9tLMZcRUgLBJP+hXm+aKim9vf5keQppbgz4puArs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDl2HzV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8255C433C7;
	Wed, 14 Feb 2024 05:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707890007;
	bh=i+oBjkiIakyu8O+RQOZUmMkml3yTxI6Ats67urmuOxA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NDl2HzV4PoDw40sxOZ2gUoBKvxAHJ5zt59qxYHDQSnzWV6D+6hSpYHJs1jmROnUaz
	 686MzwXSCvBGKqFob4GqAmxIWM5oIOVCTOHTC56gcHCbuAKS1E/gXZhXzL25VQAt3j
	 J/9zBO1vNms0DWXxlGd4Tm3LSRV+Qu69JHL3qrM/Z3tZXtzEnAJV+G2wQWfUhX+xqr
	 nXyryGUea5tOrN4vtCFbSurAHf5ZCDU0rqLFmqQHYXBLFUCiLvY1U+K5L0oTd4LEeQ
	 8VJHxWmeifr4DvDC4Sn3NDDLCANrDI5afXo14d4A0lnl8mV+wkSyNQBQ7iFkmiZWtn
	 bqKk+k8NDEKQA==
Message-ID: <fe094c1e-805d-4ab2-82f2-b311f1432e14@kernel.org>
Date: Tue, 13 Feb 2024 21:53:19 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1] ARC: Add eBPF JIT support
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Shahab Vahedi <list+bpf@vahedi.org>
Cc: bpf <bpf@vger.kernel.org>, Shahab Vahedi <shahab@synopsys.com>,
 Vineet Gupta <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20240213131946.32068-1-list+bpf@vahedi.org>
 <CAADnVQLvh3dd5tXcJnKJis9bJZNV-_dR203PXVyrubZHBuU2_Q@mail.gmail.com>
From: Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <CAADnVQLvh3dd5tXcJnKJis9bJZNV-_dR203PXVyrubZHBuU2_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+CC Bjorn

On 2/13/24 18:39, Alexei Starovoitov wrote:
> On Tue, Feb 13, 2024 at 5:20 AM Shahab Vahedi <list+bpf@vahedi.org> wrote:
>> From: Shahab Vahedi <shahab@synopsys.com>
>>
>> This will add eBPF JIT support to the 32-bit ARCv2 processors. The
>> implementation is qualified by running the BPF tests on a Synopsys HSDK
>> board with "ARC HS38 v2.1c at 500 MHz" as the 4-core CPU.
> ...
>> Signed-off-by: Shahab Vahedi <shahab@synopsys.com>
>> ---
>>  Documentation/admin-guide/sysctl/net.rst |    1 +
>>  Documentation/networking/filter.rst      |    4 +-
>>  arch/arc/Kbuild                          |    1 +
>>  arch/arc/Kconfig                         |    1 +
>>  arch/arc/net/Makefile                    |    6 +
>>  arch/arc/net/bpf_jit.h                   |  161 ++
>>  arch/arc/net/bpf_jit_arcv2.c             | 3001 ++++++++++++++++++++++
>>  arch/arc/net/bpf_jit_core.c              | 1425 ++++++++++
>>  8 files changed, 4598 insertions(+), 2 deletions(-)
> This is pretty cool to see.
> I'm assuming this will get reviewed and will go through arc.git tree.

I'd be happy to take it via ARC tree and can review some of the arch
specific bits, but I'd hope BPF folks also review it critically.

Thx,
-Vineet

> Could you share performance numbers interpreter vs JITed ?


