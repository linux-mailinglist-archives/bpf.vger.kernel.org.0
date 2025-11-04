Return-Path: <bpf+bounces-73510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA75C33386
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 23:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B43318C5A7F
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 22:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22EA30CDB1;
	Tue,  4 Nov 2025 22:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kFh9Gvlk"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A5303C83
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295134; cv=none; b=CmUcb9DZNDRaHupq02NhHCysZhwNsRmGBNWrdR0geZTpihTYmUmY2UxLGAGk94XnhnR8DSCgbZC/eJs9tB4lcIF7b49Bx8oiUFGN93PY8eCmMwz/6QpkYLomXQK3URBBt012Vyhghtn07nTebZwJVlE3sywixKfqbDtUqYagRRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295134; c=relaxed/simple;
	bh=5crydRXTrnywt6zdETFn5BA/f0fX+hJmHFJq34cEROg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkzLqAaZDV7pARl43FHWQJjwvNc27wq2FR+zoGc5O798P4oMFAj9ZUmIde5M8ofJN8yFTsdOqbP1XaaMXLpDlC7lUNA2jRW37b2TcVKEVp0MeATy2LytiYmqpTK+HlBQ6zuKoj9qOqwpKDLbXPyiY48qE83ZKQWGc+QIgBeL3iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kFh9Gvlk; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762295129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/KY9S6Qe8h1EfJoFHSjU2F7IE//rilhOx8ubsEhClk=;
	b=kFh9GvlkEZVb+0l3LEXjFYX+fD/PpJC51Sx1QCAh3f0CpFtTi4iK6WkFw762TppWrZ3R0l
	mV+fs8T6ZYwox2HsR/wV2XsuzQ8VFrXutG634zhSS3JhFSnD4m5B6ikpZrf3QKSA4ku75D
	YEDSp/mDV842BtGsM0Lkcn5DeRc3jP8=
Date: Tue, 4 Nov 2025 14:25:24 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v1 0/3] btf_encoder: support for BPF magic kernel
 functions
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 dwarves@vger.kernel.org, acme@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, eddyz87@gmail.com, tj@kernel.org,
 kernel-team@meta.com
References: <20251029190249.3323752-1-ihor.solodrai@linux.dev>
 <517837f0-127e-42bc-83f4-2c85203ef468@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <517837f0-127e-42bc-83f4-2c85203ef468@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/4/25 12:59 PM, Alan Maguire wrote:
> On 29/10/2025 19:02, Ihor Solodrai wrote:
>> This series implements BTF encoding of BPF kernel functions marked
>> with KF_MAGIC_ARGS flag in pahole.
>>
>> The kfunc flag indicates that the arguments of a kfunc with __magic
>> suffix are implicitly set by the verifier, and so pahole must emit two
>> functions to BTF:
>>   * kfunc_impl() with the arguments matching kernel declaration
>>   * kfunc() with __magic arguments omitted
>>
>> For more details see relevant patch series for BPF:
>> "bpf: magic kernel functions"
>>
>> This series is built upon KF_IMPLICIT_PROG_AUX_ARG support [1],
>> although the approach changed signifcantly to call it a v2.
>>
>> [1] https://lore.kernel.org/dwarves/20250924211512.1287298-1-ihor.solodrai@linux.dev/
>>
>> Ihor Solodrai (3):
>>   btf_encoder: refactor btf_encoder__add_func_proto
>>   btf_encoder: factor out btf_encoder__add_bpf_kfunc()
>>   btf_encoder: support kfuncs with KF_MAGIC_ARGS flag
>>
>>  btf_encoder.c | 292 ++++++++++++++++++++++++++++++++++++++------------
>>  1 file changed, 222 insertions(+), 70 deletions(-)
>>
> 
> seems like we could potentially pull in patches 1 and 2 as cleanups
> prior to handling the KF_MAGIC/IMPLICIT change; would that be worthwhile?
> 

Hi Alan.

Feel free to merge in the refactoring patches if you think they are
useful. No objections.

I've had another off-list discussion with Andrii, and I am going to
try implementing the next iteration of KF_IMPLICIT_ARGS (no magic,
sorry) feature via resolve_btfids in the kernel tree.

As you of course well know, maintaining backwards compatibility by
tracking pahole version and ensuring correct feature flags in the
Linux kernel build has been tiresome.

We are thinking to address this by separating BTF generation for the
kernel into two independent stages:
  * generate BTF from DWARF with pahole
  * then modify BTF with kernel-specific transformations (with
    resolve_btfids, or however we rename it)

This will reduce the burden from pahole to know the kernel-specific
tweaks of the BTF: adding kfunc decl tags, handling kernel function
flags, etc. pahole will only be concerned with "generic" BTF
generation from DWARF.

This will also free us from the need to control exactly what pahole
features are available (maybe except specifying minimum version) in
the kernel build, because btf2btf transformations will live in the
Linux tree.

KF_IMPLICIT_ARGS will be the proof-of-concept for the approach. If it
works well, then eventually we can migrate existing kernel-specific
BTF generation out from pahole.

Let me know what you think about all this.

Thank you.


> Thanks!
> 
> Alan


