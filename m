Return-Path: <bpf+bounces-20426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD04983E2B3
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 20:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89197284DA2
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 19:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD1C225AC;
	Fri, 26 Jan 2024 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vhGoTgrv"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272DF224DA
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297820; cv=none; b=XZHYHkSCGVrKcM0mhWfVA2o034foi2gvB1qQxsOmHlRdST/56kSaWOM+aZ6hUHeW1Dcgjw3/W1sIyW0aly/kY56OnFF8WooRuAkTN+jQc0DKgJoG3cGAC5UTsNy+uwn7tlUPXc11CPrTwJw/iEY4Bm1xGikI5kccJck4NNktAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297820; c=relaxed/simple;
	bh=uxac+B2JSnMISJQXpWFxm1pKIyER1ZrasfJLcPmesmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uya5p7hIIrlSB7hOTpES1jQ04qZIf+20d7loDX/VV+OWy28+jrz3oJOIgTyPlL0uBQ5zc+njyAgiamaos1nZOcvM1oyZupWl//xESbU73YydcyDb5Q/U5/6jAeXCf3dIqGPgTh7Y4gNP/UwijTRp2y7ezSAhKQUZKpOmv3ZUfS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vhGoTgrv; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d4859e88-d105-4de2-b19c-f59bf7bd5e88@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706297816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEVd0QafPgt3Yab5rVKzY8wr3GSCC3qWRHifh5DcWZ0=;
	b=vhGoTgrvH/0NZsFkHqENAmU0SSZn3JpCHs8TfdckqNJrksIb122b3AEoLVwebtkbRxp1hT
	g8U9j1TPUr/Te+IC6VLfrg7sq8jjg4IJz7MTFkjKIWSgyqPhk9Pz10Cz/j/rdNWMtGKwPK
	e358/DPprgYwehYRy+see+F/9kfDzY0=
Date: Fri, 26 Jan 2024 11:36:48 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 3/3] selftest/bpf: Test the read of vsyscall page
 under x86-64
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, x86@kernel.org, bpf@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, xingwei lee <xrivendell7@gmail.com>,
 Jann Horn <jannh@google.com>, Sohil Mehta <sohil.mehta@intel.com>,
 houtao1@huawei.com
References: <20240126115423.3943360-1-houtao@huaweicloud.com>
 <20240126115423.3943360-4-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240126115423.3943360-4-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/26/24 3:54 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> Under x86-64, when using bpf_probe_read_kernel{_str}() or
> bpf_probe_read{_str}() to read vsyscall page, the read may trigger oops,
> so add one test case to ensure that the problem is fixed. Beside those
> four bpf helpers mentioned above, testing the read of vsyscall page by
> using bpf_probe_read_user{_str} and bpf_copy_from_user{_task}() as well.
>
> The test case passes the address of vsyscall page to these six helpers
> and checks whether the returned values are expected:
>
> 1) For bpf_probe_read_kernel{_str}()/bpf_probe_read{_str}(), the
>     expected return value is -ERANGE as shown below:
>
> bpf_probe_read_kernel_common
>    copy_from_kernel_nofault
>      // false, return -ERANGE
>      copy_from_kernel_nofault_allowed
>
> 2) For bpf_probe_read_user{_str}(), the expected return value is -EFAULT
>     as show below:
>
> bpf_probe_read_user_common
>    copy_from_user_nofault
>      // false, return -EFAULT
>      __access_ok
>
> 3) For bpf_copy_from_user(), the expected return value is -EFAULT:
>
> // return -EFAULT
> bpf_copy_from_user
>    copy_from_user
>      _copy_from_user
>        // return false
>        access_ok
>
> 4) For bpf_copy_from_user_task(), the expected return value is -EFAULT:
>
> // return -EFAULT
> bpf_copy_from_user_task
>    access_process_vm
>      // return 0
>      vma_lookup()
>      // return 0
>      expand_stack()
>
> The occurrence of oops depends on the availability of CPU SMAP [1]
> feature and there are three possible configurations of vsyscall page in
> boot cmd-line: vsyscall={xonly|none|emulate}, so there are totally six
> possible combinations. Under all these combinations, the running of the
> test case succeeds.
>
> [1]: https://en.wikipedia.org/wiki/Supervisor_Mode_Access_Prevention
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

The first two patches look good to me but I think it would be better
if x86 folks can ack on them. The selftest patch LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


