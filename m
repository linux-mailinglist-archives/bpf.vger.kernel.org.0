Return-Path: <bpf+bounces-62846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAF1AFF50E
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 00:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62075A259F
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 22:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6C8242D7E;
	Wed,  9 Jul 2025 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7cYflf0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD3F1FF1C4;
	Wed,  9 Jul 2025 22:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101855; cv=none; b=X46y9PcYBYzwUWMb5xQdZ7IeKO7Iy84LC0CI43L2XSm6cNIHFTsBgCVAEhEsAcZKq9/3YCpKltzCQm0ej2ZFBo9YziQWunXxbiNNFbdY0rZhzMdFsWwW4QvoUN5Y/qbjtf26rY3aeO0xl8g/Qar/cnOBvAbZvNMsg33wzWeTwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101855; c=relaxed/simple;
	bh=yIfy5HUzoyFJKEp5fkslceaEoSylMXWxfkSP2uLnMiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkDzFp+mkECufZfGOEf2rpYXRal1XP1m4MpurzCCuDv7SMadIfJhZyMJT5wS2NxT8oivAUBEi5bT+hDXEcQBml1L00kZt6xn2NT55r7deu0MbX+KF2s6pLm1k7GCKtRKap/GPJkbrJwenIeJ9DGe0sO8Ed11PV1aNvxX93OfRPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7cYflf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97755C4CEF5;
	Wed,  9 Jul 2025 22:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752101853;
	bh=yIfy5HUzoyFJKEp5fkslceaEoSylMXWxfkSP2uLnMiQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S7cYflf0KTzsZR4tKzfZFtcW+3qGAL3ExFyE074MtSuQYNOrB1C69bINAhSinNkjE
	 r4ddJoQpd5yMl18+jJcVyI8QX5Ww5mQ4RFiH0SLrvHHbbmgYSYgZQUwDqre7b4omPt
	 AXbRIYDNoa0SlpK1PhJMven2CA2HKGp46fhNxrUcaB4gu86ZtxJBjfPiXhdp776ZC7
	 jwo87NhW+U8rFGRlM+3YyWhUtaNwIzyOWXlV0cnN3CPwvrYq0fTmNtRUBKqIJtJesv
	 06iiatxhk0qDSfJGBDAN+gmiLq0iqZXpNfBfgh4/x8hIBmozQE8GqAkHbVLrd4eGJZ
	 aikDtradsoJeA==
Message-ID: <14b08e7c-c2e8-435c-a1dd-bd51cfb42060@kernel.org>
Date: Thu, 10 Jul 2025 00:57:28 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/4] mm/vmalloc: allow to set node and align in
 vrealloc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, linux-mm <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 rust-for-linux <rust-for-linux@vger.kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org,
 bpf <bpf@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172416.1031970-1-vitaly.wool@konsulko.se>
 <CAADnVQ+bikqCO7D+5_rAtiJXv3F6xn=0_hgGH5CkoTPpdi8j6Q@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CAADnVQ+bikqCO7D+5_rAtiJXv3F6xn=0_hgGH5CkoTPpdi8j6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/10/25 12:53 AM, Alexei Starovoitov wrote:
> On Wed, Jul 9, 2025 at 10:25 AM Vitaly Wool <vitaly.wool@konsulko.se> wrote:
>>
>>
>> -void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
>> +void *vrealloc_node_align_noprof(const void *p, size_t size, unsigned long align,
>> +                                gfp_t flags, int node)
>>   {
> 
> imo this is a silly pattern to rename functions because they
> got new arguments.
> The names of the args are clear enough "align" and "node".
> I see no point in adding the same suffixes to a function name.
> In the future this function will receive another argument and
> the function would be renamed again?!
> "_noprof" suffix makes sense, since it's there for alloc_hooks,
> but "_node_align_" is unnecessary.

Do you have an alternative proposal given that we also have vrealloc() and
vrealloc_node()?

