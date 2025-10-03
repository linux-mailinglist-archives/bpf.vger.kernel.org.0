Return-Path: <bpf+bounces-70269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0818BB5CA1
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 04:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42F224E5C4B
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 02:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067B32C21C6;
	Fri,  3 Oct 2025 02:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cIOzOAws"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC8D1C8FBA
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759457234; cv=none; b=Cmvj7nE8NZfILd+1ePQB1OJtoYRbUzkjeMvQtC96le9K8dy53jsHxosn6lKdc5oUX2bjzqOlsnxNv1baYTw14KE6embVg7Q5mYC9gKjsnNAErsEmBXjQGgGxkWhZZMAFL0E2DHrQSBk0ItN/dygYd7Yjo5SnarLBIsxSk/k/6cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759457234; c=relaxed/simple;
	bh=ZQcXMNmEl+sOmSASZafeAAeLILs0XLx1Qo8GKODxry4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeTrtmm1hTo/HZVcRXUPzAuNV55GuS0/98hetOcQWGIPKw1uZEK5MnPUZrs85rl4xFtnwICWrApPgrJp5wti2o2QPnz+znXnw3+3JTQn758AENsrQ52NvXF//du+Ko5lEI7nvIwuzF2jBBhnJjpwY9a0aRitAOi/syrHIaJDGi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cIOzOAws; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <69432b06-bf1c-41c7-83a4-7c8bfbd0b2a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759457223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0RPMdNl5hOiHQjtAkol3jle9qbrzfwer74Rx739Db0M=;
	b=cIOzOAwsaCCJnIkJIHFUjgH4EPbBtXDKJYDpmfH3VOuyMzgd87xDPEMGARaYy5IqFlxMOF
	yrwLKRTQblqrAUx684V/S+cWbZGADa4q3nMqIQdmgJWS/TTidA6sAMDdLyFvnygwNgbUnY
	1mzd6JbqLTQsjmEdiE8AqgAbEtDNeAI=
Date: Fri, 3 Oct 2025 10:06:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v3 03/10] bpf: Refactor reporting
 log_true_size for prog_load
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
References: <20251002154841.99348-1-leon.hwang@linux.dev>
 <20251002154841.99348-4-leon.hwang@linux.dev>
 <CAADnVQKarwu9xciE=itxxXDS+DRtdHmVxD3rftuqBU5iu9FYLA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQKarwu9xciE=itxxXDS+DRtdHmVxD3rftuqBU5iu9FYLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 3/10/25 02:34, Alexei Starovoitov wrote:
> On Thu, Oct 2, 2025 at 8:49 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> In the next commit, it will be able to report logs via extended common
>> attributes, which will report 'log_true_size' via the extended common
>> attributes meanwhile.
>>
>> Therefore, refactor the way of 'log_true_size' reporting in order to
>> report 'log_true_size' via the extended common attributes easily.
>>

[...]

>>
>> +static int copy_prog_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, unsigned int size)
>> +{
>> +       if (!attr->log_true_size)
>> +               return 0;
> 
> We've been through this many times :(
> The commit log says that it's a refactoring patch, but
> you introduce this new logic.
> Do NOT do it.
> If you want to add such additional check, do it in a separate patch
> and explain why it's ok.
> 
> So why is it ok to skip writing to user space when it's zero?
> 

My mistake — I see now that introducing this extra check changes the
behavior and doesn't belong in a refactoring patch.

My original intention was just to avoid calling copy_to_user() when
there is no log, but as you pointed out, it's important to still report
log_true_size back to user space, even if it's zero. That way, users can
reliably check if a log is present.

I'll drop this new logic in the next revision and keep the patch
strictly as a refactoring.

Thanks,
Leon

