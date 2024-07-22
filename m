Return-Path: <bpf+bounces-35244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EC893933E
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 19:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65FE281A45
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 17:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE09D16EBF4;
	Mon, 22 Jul 2024 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bcBCBfI3"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279916EB54
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721669661; cv=none; b=p3aaDllvlRo8Ps6NRwZQTiNfah4SxxHbNnKakBteUf6AlwDkWlmR/1+508MSKZX5H0IVE0FHr1wyV2onGIjrNZGrF81ZhoDXcmLAeovP9I0lF6OPa+YL2L1LDDVbRE6u++z6ktAvNGiOmGx0hV0CBQ3FZ3ZqahA9qvEVQJvEm0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721669661; c=relaxed/simple;
	bh=4BP7UBsRwlqIi7VaSeoy3l80CdZqg1W/Bs4Td9anQqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCwjP5tzdO3+RB99E12ioE5aQheor1+bifbhkuWGHKIvxYG+QjaD37INQ7D4Qlk7r6Wle3gxYKpTqogD0bCD7/PNj7oIhKYv8Xdn1gqw4pT6anZhnirtlCM9AQdIDLAbYY7nKd5MtH9zZD3sLVfuVnULFWt6l3AyV1MA31M7RWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bcBCBfI3; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ameryhung@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721669655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQdMNJP4i1gVJdDt4KGwYKNyaZiZvTPZU5XJNRiWMQA=;
	b=bcBCBfI3XzfBRRoh2S9EfMoTaFbzxvUsY4a92sKM37q5yJ6ViJ8SjtI6itV8r//1sGviwO
	zLPCnw0YqfQvrRBUXWfylhqvWOZWjVFv9gY2f7lkxc6Ctq9FdC0vno8KmDkkU0Qi6/QwOA
	36/LjjTyB6RoLUp8Jx0ChN7D8dFUEos=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: oe-kbuild-all@lists.linux.dev
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: lkp@intel.com
Message-ID: <15f7db68-e1b1-4ce5-8855-735fc5aae718@linux.dev>
Date: Mon, 22 Jul 2024 10:34:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Check unsupported ops from the
 bpf_struct_ops's cfi_stubs
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
 kernel test robot <lkp@intel.com>
References: <20240720062233.2319723-2-martin.lau@linux.dev>
 <202407202244.HvnUVyjM-lkp@intel.com>
 <CAMB2axM565hLp1uuYggcEEPDA8y0NCpTn8gESmn6cPuyWfELJQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axM565hLp1uuYggcEEPDA8y0NCpTn8gESmn6cPuyWfELJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/21/24 3:45 PM, Amery Hung wrote:
> On Sat, Jul 20, 2024 at 7:45 AM kernel test robot <lkp@intel.com> wrote:
>>
>> Hi Martin,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on bpf-next/master]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Martin-KaFai-Lau/bpf-Check-unsupported-ops-from-the-bpf_struct_ops-s-cfi_stubs/20240720-144313
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
>> patch link:    https://lore.kernel.org/r/20240720062233.2319723-2-martin.lau%40linux.dev
>> patch subject: [PATCH bpf-next 1/3] bpf: Check unsupported ops from the bpf_struct_ops's cfi_stubs
>> config: i386-randconfig-001-20240720 (https://download.01.org/0day-ci/archive/20240720/202407202244.HvnUVyjM-lkp@intel.com/config)
>> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240720/202407202244.HvnUVyjM-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202407202244.HvnUVyjM-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>     kernel/bpf/bpf_struct_ops.c: In function 'bpf_struct_ops_supported':
>>>> kernel/bpf/bpf_struct_ops.c:1045:48: warning: dereferencing 'void *' pointer
>>       void *func_ptr = *(void **)(&st_ops->cfi_stubs[moff]);
>>                                                     ^
>>
>>
>> vim +1045 kernel/bpf/bpf_struct_ops.c
>>
>>    1042
>>    1043  int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 moff)
>>    1044  {
>>> 1045          void *func_ptr = *(void **)(&st_ops->cfi_stubs[moff]);
> 
> The compiler warning can be fixed with:
> void *func_ptr = *(void **)(st_ops->cfi_stubs + moff);
> 
> The patch looks good to me. I tested it with bpf qdisc, and it does
> what it is supposed to do by prohibiting users to attach to an
> operator whose cfi stub is not defined.

Thanks for testing. I just tried gcc and can repro it. I will respin.


