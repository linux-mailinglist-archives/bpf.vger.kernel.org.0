Return-Path: <bpf+bounces-36810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 624B994D9D8
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 03:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D5DB220EC
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 01:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3BF12EBE1;
	Sat, 10 Aug 2024 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r3VzCJFP"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9F3624
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723253360; cv=none; b=hPtMmCUDoMuo5MSqdi5zyqye+yRQD49R3kvI9IgQxyzVa0bqXGqBRwFJ/HHrv5oG3KKS80sZkiZ/iSbGnX9tWimWxeT+MI/xesAbuuNV7NjCR7cYPAA+sMFPd1qwY3/9Xk3cUsUZ2/Ea7JzgVTSyjrZQ+6VMpgP2z00mi/COfTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723253360; c=relaxed/simple;
	bh=WhyMA3C3j6+bIYSN2gPRxTAKaR40XHKTYPXRt/VBcPo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=X3ObbqpzrdoNrR5Xr3PmiUKEoHGdNIPkLN8uPmdG5vNyjdFbaJPlqgyNNIWtc/frlwiNnCyE9kTgN940vobmP38O9ccxkXceu2TTWQY/44h78FLdNBIOX44EeXTEpYFzGWVwk7/rRhyg4A924DdoVRCFMryzumXlqZzRGInPp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r3VzCJFP; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <55b86502-f125-4d59-b356-7fbfb2f6d845@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723253354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lf0iWti53A+E6XaT1Uz35kuFXZhwhaIkqIDNU26ToZE=;
	b=r3VzCJFPFPRZR9FAUm4GUCPiYaHUcKMS/Ge0MXUpqPItYEIHXRRELWlogJ1LMpe29465xf
	LFdVuGpG2l3dsngI3GyJoQQcZz48iKoIFqjbyoRXoY1f2fvoNxM62o6DciqEwIaf2+ae36
	n4VBxLVMNYnv3UrE8eBRfQsImzqajdU=
Date: Fri, 9 Aug 2024 18:29:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Let callers of btf_parse_kptr()
 track life cycle of prog btf
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, houtao@huaweicloud.com,
 sinquersw@gmail.com, davemarchevsky@fb.com,
 Amery Hung <amery.hung@bytedance.com>
References: <20240809005131.3916464-1-amery.hung@bytedance.com>
 <20240809005131.3916464-2-amery.hung@bytedance.com>
 <2f9c21f8-1108-4f12-a06e-58837b53e7fe@linux.dev>
Content-Language: en-US
In-Reply-To: <2f9c21f8-1108-4f12-a06e-58837b53e7fe@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/9/24 4:06 PM, Martin KaFai Lau wrote:
> On 8/8/24 5:51 PM, Amery Hung wrote:
>> btf_parse_kptr() and btf_record_free() do btf_get() and btf_put()
>> respectively when working on btf_record in program and map if there are
>> kptr fields. If the kptr is from program BTF, since both callers has
>> already tracked the life cycle of program BTF, it is safe to remove the
>> btf_get() and btf_put().
>>
>> This change prevents memory leak of program BTF later when we start
>> searching for kptr fields when building btf_record for program. It can
>> happen when the btf fd is closed. The btf_put() corresponding to the
>> btf_get() in btf_parse_kptr() was supposed to be called by
>> btf_record_free() in btf_free_struct_meta_tab() in btf_free(). However,
>> it will never happen since the invocation of btf_free() depends on the
>> refcount of the btf to become 0 in the first place.
>>
>> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> 
> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
> 
> Need to fix the checkpatch warning though:
> 
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Amery Hung 
> <ameryhung@gmail.com>' != 'Signed-off-by: Amery Hung <amery.hung@bytedance.com>'
> 

There is a veristat failure also:

https://github.com/kernel-patches/bpf/actions/runs/10311824065/job/28546213338

|File                  |Program                         |Verdict                |States Diff (%)|
|----------------------|--------------------------------|-----------------------|---------------|
|local_kptr_stash.bpf.o|refcount_acquire_without_unstash|success -> failure (!!)|-100.00 %      |
|local_kptr_stash.bpf.o|stash_local_with_root           |success -> failure (!!)|-100.00 %      |
|local_kptr_stash.bpf.o|stash_plain                     |success -> failure (!!)|-100.00 %      |
|local_kptr_stash.bpf.o|stash_rb_nodes                  |success -> failure (!!)|-100.00 %      |
|local_kptr_stash.bpf.o|stash_refcounted_node           |success -> failure (!!)|-100.00 %      |
|local_kptr_stash.bpf.o|stash_test_ref_kfunc            |success -> failure (!!)|-100.00 %      |
|local_kptr_stash.bpf.o|unstash_rb_node                 |success -> failure (!!)|-100.00 %      |

