Return-Path: <bpf+bounces-52314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D56A414B9
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 06:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021A3188F08B
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 05:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1422C1A5B81;
	Mon, 24 Feb 2025 05:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wn3PFQjD"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C17A32
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 05:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740374744; cv=none; b=a1EhNs4PRmvdSyDsQhY2AHLhTaRyZ6IWKqJpXow0a2Vr5mu/ACMlsamVBhPFJ1QHaclVNFH1cBwBHDvDy/DWtzXoUhz7q+jKci+qA9jq+arMGzdaQ7JG78m9hDWMByyp8wGOiwOaEn3fTDL1BdriqGoeKuVkrcLHd5BySn2gyZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740374744; c=relaxed/simple;
	bh=p6/OiBpD7T4L57BFpDIeP2W1KL0lFodBwP++ko007g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kyc4hrZ36D9zV00aBLzv59xH/CHiNMahwDEfYL6F6uZ6HjAJ5SpIOEMGY5sTSWh4BAJfKmEFOBCFXteohEGM8WA+Je1gpItcUnvWRd0oHjMIevPs6yyL2YovbkxyEtjH9AgATTelHIrlOE9ksveZGMmVLB3KoomAe6q2mfQ4Dhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wn3PFQjD; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <71ce2e8c-95db-4a41-9cda-c01bd6845678@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740374738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZyxIrLVUDDk5hk5e/KZCK9j09B0WzPdMbDgQ5JGm+k=;
	b=wn3PFQjD5AjGHYGlIcBICNS1FG6zq2rAEmwKfTz6USlHla2pP0B37DEEilmdqrodHux3G5
	J8RsgcwsSgvp68CRpbmSnWXzwpeWPnR70uK+TFVDZjczVAXx6Bhr4nOVz7KLrakoyUhCTa
	+kcx7EJpAtI1LMGANUgqU2B7q6X7n8o=
Date: Mon, 24 Feb 2025 13:25:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH bpf-next v2 1/4] bpf: Introduce global percpu data
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Eddy Z <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>,
 Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com
References: <20250213161931.46399-1-leon.hwang@linux.dev>
 <20250213161931.46399-2-leon.hwang@linux.dev>
 <CAADnVQLhw8PgS6vcOvceJvdUdazfi77tXj6n_w0b=gD1fwMFsw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQLhw8PgS6vcOvceJvdUdazfi77tXj6n_w0b=gD1fwMFsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/2/19 09:47, Alexei Starovoitov wrote:
> On Thu, Feb 13, 2025 at 8:19 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>> +#ifdef CONFIG_SMP
> 
> What happens on !SMP ?
> I think the code assumes that the verifier will adjust ld_imm64
> with percpu insn.
> On !SMP ld_imm64 will be pointing where?

If !SMP, ld_imm64 correctly loads the address from array->pptrs[0].

Therefore, adding a percpu instruction is unnecessary for !SMP, although
it would still function correctly in that case.

For SMP, a percpu instruction is inserted after ld_imm64 to ensure
proper handling.

Thanks,
Leon


