Return-Path: <bpf+bounces-75966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABB1C9EF17
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 13:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2808A4E494C
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 12:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBB42F5A22;
	Wed,  3 Dec 2025 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFqo0cZB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A32F363A;
	Wed,  3 Dec 2025 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764763973; cv=none; b=VIqLFiK9j+YI6cgjQ1xkXMIX2Id9Fqz+ViO3PwQgadFXZv8ZLVQf6psV4k5dsYdNL8cOU6CCmwCJ0LkcbuLysn+0wP5znPThP2TEShp9jkQK6RGsvGI1tgFuJeJcqxfFdrWyQDN6SiByOwBpe63GV3l4lXwmI417F7ulw4xhjDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764763973; c=relaxed/simple;
	bh=ifPO+9rTSrcPIWQqxCTUClnBC/yfF7IqHiwQuzRc6ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVqvRO7alRmyFLI3zCBjSCyRfrb/RQ2d6Xc5BABUD9xgYeAixx5ri2b2LTg08Ajy8ncuuQgYdfMlY+c90Kz2EMgZJ2cqookNpZzodAklhQOyfRAFVuzSrNuoa6GVCqSVSaGMlIOMswRFhudBK//osrDz7lKp0A1AH3CECKDqgYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFqo0cZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1228C113D0;
	Wed,  3 Dec 2025 12:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764763972;
	bh=ifPO+9rTSrcPIWQqxCTUClnBC/yfF7IqHiwQuzRc6ME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EFqo0cZBhjf7zbUlJKBrib9AfaV8i8AXphBMdJJmticI4UgVOlLJQwvYSlbQ7k9gv
	 2axnj5Yy12tlXKSpHQY/FKoZZ87xAKkLBgZBMtDCKpehT49UMLxByPjctpge+0ksGu
	 POPrMRRZ2QLJDNBYDJ9+2ugIEQU1tQWFFyOxTlPp6I+CnMaCuoSnFyHdEP1Aprc051
	 eseH2GTIFHmB42RxbSDWOzG/WTNpIeVm/ERH8tP34ZG8h5/9O3Hw+HKMynpLAC18ha
	 U6I+0H0/6dKAqR3qofASeXO8riqn5PboPjcMdEwStKvevix9R6p4/teEcDjnHGNUNc
	 c4XmdKVnM4/oQ==
Message-ID: <7b6b9d1a-c160-4198-8a58-0586424b56e5@kernel.org>
Date: Wed, 3 Dec 2025 13:12:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v1 1/2] bpf: cpumap: propagate underlying error in
 cpu_map_update_elem()
To: Kohei Enju <enjuk@amazon.com>, alexei.starovoitov@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kohei.enju@gmail.com, kpsingh@kernel.org, kuba@kernel.org,
 lorenzo@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 sdf@fomichev.me, shuah@kernel.org, song@kernel.org, yonghong.song@linux.dev,
 kernel-team <kernel-team@cloudflare.com>
References: <CAADnVQLjw=iv3tDb8UadT_ahm_xuAFSQ6soG-W=eVPEjO_jGZw@mail.gmail.com>
 <20251203104037.40660-1-enjuk@amazon.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20251203104037.40660-1-enjuk@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/12/2025 11.40, Kohei Enju wrote:
> On Tue, 2 Dec 2025 17:08:32 -0800, Alexei Starovoitov wrote:
> 
>> On Fri, Nov 28, 2025 at 8:05 AM Kohei Enju <enjuk@amazon.com> wrote:
>>>
>>> After commit 9216477449f3 ("bpf: cpumap: Add the possibility to attach
>>> an eBPF program to cpumap"), __cpu_map_entry_alloc() may fail with
>>> errors other than -ENOMEM, such as -EBADF or -EINVAL.
>>>
>>> However, __cpu_map_entry_alloc() returns NULL on all failures, and
>>> cpu_map_update_elem() unconditionally converts this NULL into -ENOMEM.
>>> As a result, user space always receives -ENOMEM regardless of the actual
>>> underlying error.
>>>
>>> Examples of unexpected behavior:
>>>    - Nonexistent fd  : -ENOMEM (should be -EBADF)
>>>    - Non-BPF fd      : -ENOMEM (should be -EINVAL)
>>>    - Bad attach type : -ENOMEM (should be -EINVAL)
>>>
>>> Change __cpu_map_entry_alloc() to return ERR_PTR(err) instead of NULL
>>> and have cpu_map_update_elem() propagate this error.
>>>
>>> Fixes: 9216477449f3 ("bpf: cpumap: Add the possibility to attach an eBPF program to cpumap")
>>
>> The current behavior is what it is. It's not a bug and
>> this patch is not a fix. It's probably an ok improvement,
>> but since it changes user visible behavior we have to be careful.
> 
> Oops, got it.
> When I resend, I'll remove the tag and send to bpf-next, not to bpf.
> 
> Thank you for taking a look.
> 
>>
>> I'd like Jesper and/or other cpumap experts to confirm that it's ok.
>>
> 
> Sure, I'd like to wait for reactions from cpumap experts.

Skimmed the code changes[1] and they look good to me :-)

Bcc'ed some Cloudflare people that use cpumap, so add link to change:
  [1] https://lore.kernel.org/all/20251128160504.57844-2-enjuk@amazon.com/
  ... if they want to object

--Jesper

