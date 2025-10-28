Return-Path: <bpf+bounces-72579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D04C15C92
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BCAD4EBE23
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E025B346A01;
	Tue, 28 Oct 2025 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JYfk+FKC"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759DC346763
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668448; cv=none; b=gCRFzGPXPKFjKKpRGL6sZr7ydvlYUnHtDtv0gzhwCdCpmybWztdQKqxoyAZIbTHMDA5Rv8GJw68PYAvJbrR2rOf9QZOqFFLemwszGjDE7MW9R98SNWszTi6ce+0drxfoQI1bONjHppQd2d23Tpy52BXPGc7sPrXi30tZf6dKhdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668448; c=relaxed/simple;
	bh=oAjQ67mpYKtgoIO3WiLiVHBR/yKeC8Zz0b/+wDFYSdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I+ZRxWaAmLo6bncw76BsUnYiBG/xlP+UFJ15+3D249slzJkchSDEuTz336eK7CgBnzs2jRwuVuuvYkIXNrUArAS5wmvYpl4nJFu24lvpfwF/f9FXdMzwI4iwElCVoRt/+hy3LgEEiJtL5t9d0wehqwAiM6i9rA7c0D7UMCcPwIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JYfk+FKC; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761668444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1Bzn1s/zljRcvmyCS22gE0OJ0NnMFMhi+daqWj4zl4=;
	b=JYfk+FKCUMOYMGJgaGlJf9TmW/4P0jgdth++YnXfK+QdAEhpOOljW1c48Q+XvhndVmdBS5
	OmMYmRRYsEbZ5eGbXAF2c3q+ui9LlFAkh+tWlfZXcQ+7a72N3erlgGJq82bEi3gaoQ5vMk
	bCDUD+3f/LiC61x+0iHbzTwe1H5eCFo=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Chris Mason <clm@meta.com>
Cc: bot+bpf-ci@kernel.org,  akpm@linux-foundation.org,
  linux-kernel@vger.kernel.org,  ast@kernel.org,  surenb@google.com,
  mhocko@kernel.org,  shakeel.butt@linux.dev,  hannes@cmpxchg.org,
  andrii@kernel.org,  inwardvessel@gmail.com,  linux-mm@kvack.org,
  cgroups@vger.kernel.org,  bpf@vger.kernel.org,  martin.lau@kernel.org,
  song@kernel.org,  memxor@gmail.com,  tj@kernel.org,
  daniel@iogearbox.net,  eddyz87@gmail.com,  yonghong.song@linux.dev,
  ihor.solodrai@linux.dev
Subject: Re: [PATCH v2 14/23] mm: allow specifying custom oom constraint for
 BPF triggers
In-Reply-To: <a1d4d200-5a35-4990-8499-6dc7ea6d65ac@meta.com> (Chris Mason's
	message of "Tue, 28 Oct 2025 11:58:50 -0400")
References: <20251027232206.473085-4-roman.gushchin@linux.dev>
	<634e7371353c8466b3d0fa0dd7ceeaf17c8c4d7b274f4f7369d3094d22872cd6@mail.kernel.org>
	<a1d4d200-5a35-4990-8499-6dc7ea6d65ac@meta.com>
Date: Tue, 28 Oct 2025 09:20:36 -0700
Message-ID: <87v7jz3smj.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Chris Mason <clm@meta.com> writes:

> On 10/27/25 7:48 PM, bot+bpf-ci@kernel.org wrote:
>>> @@ -1350,11 +1367,14 @@ __bpf_kfunc int bpf_oom_kill_process(struct oom_control *oc,
>>>   * Returns a negative value if an error occurred.
>>>   */
>>>  __bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
>>> -				  int order, u64 flags)
>>> +				  int order, u64 flags,
>>> +				  const char *constraint_text__nullable)
>>>  {
>>>  	struct oom_control oc = {
>>>  		.memcg = memcg__nullable,
>>>  		.order = order,
>>> +		.constraint = CONSTRAINT_BPF,
>>> +		.bpf_constraint = constraint_text__nullable,
>>>  	};
>>>  	int ret;
>> 
>> When CONSTRAINT_BPF is set in bpf_out_of_memory(), the early return in
>> constrained_alloc() prevents oc->totalpages from being initialized.  This
>> leaves totalpages at zero (from the designated initializer).
>> 
>> Later in the call chain out_of_memory()->select_bad_process()->
>> oom_evaluate_task()->oom_badness(), the code performs division by
>> totalpages at line 237:
>> 
>>     adj *= totalpages / 1000;
>> 
>> Can this cause a division by zero?  The path is reachable when a BPF
>> program calls bpf_out_of_memory() and either no BPF OOM handler is
>> registered or the handler fails to free memory, causing execution to fall
>> through to select_bad_process().
>
> Looks like the AI got a little excited about finding the uninit variable
> chain and forgot what dividing by zero really means.  I'll add a false
> positive check for this.

Yup, it was *almost* correct :)

But overall I'm really impressed: it found few legit bugs as well.
The only thing: I wish I could run it privately before posting to
public mailing lists...

Thanks,
Chris!

