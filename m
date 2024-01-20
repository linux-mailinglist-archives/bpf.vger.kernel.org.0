Return-Path: <bpf+bounces-19961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AFE833246
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 02:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E3AB22C17
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 01:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5020EFC1D;
	Sat, 20 Jan 2024 01:30:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB4EAF0;
	Sat, 20 Jan 2024 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705714201; cv=none; b=a/+w1GeY0DkMm/pnpyc+SRSGDKSg95hWj+0gO/szkD2DydESxpUAZcUH3IRCmkaLT2UJaDONIJgLn74mCbOThcbvussT00Zuq1NU9VJxE2/nil4isRMofY35QB/EeUor1wyM5wFxHradPPLgkA5xO/5VU9t47OShiBcdal0Q/mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705714201; c=relaxed/simple;
	bh=MZAFcNUX42DvZWaPmJOQSQ4sUhdk2XNLvhFLOgAqkPc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UO2I68gTGwbFdJRnN1YPk/T/gPKnn9zizPjJJZatf6YgYa3sjjJ8OaACPU/Uwb0S1KRif+B7vlM42DHvTa/vZGeu2K4a2AEfsAwjdLONvaZWXMEQBDfdVqMMTKwze+z7gRxv9iFFbpkA7UfK+TTwS/naHYXIeV+DqkdVWJsfVzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TGzRv3Zygz4f3jHc;
	Sat, 20 Jan 2024 09:29:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B50F31A0171;
	Sat, 20 Jan 2024 09:29:49 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBXdQ4LIqtlqRR+BQ--.33617S2;
	Sat, 20 Jan 2024 09:29:49 +0800 (CST)
Subject: Re: [PATCH bpf 1/3] x86/mm: Move is_vsyscall_vaddr() into
 mm_internal.h
To: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org, bpf@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, xingwei lee <xrivendell7@gmail.com>,
 Jann Horn <jannh@google.com>, houtao1@huawei.com
References: <20240119073019.1528573-1-houtao@huaweicloud.com>
 <20240119073019.1528573-2-houtao@huaweicloud.com>
 <8511e5c6-eddb-4deb-932e-125e34cddba6@intel.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <979ee85e-6f36-fa9c-847f-a9be1b92063f@huaweicloud.com>
Date: Sat, 20 Jan 2024 09:29:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8511e5c6-eddb-4deb-932e-125e34cddba6@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBXdQ4LIqtlqRR+BQ--.33617S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYx7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
	04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/20/2024 8:35 AM, Sohil Mehta wrote:
> On 1/18/2024 11:30 PM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Moving is_vsyscall_vaddr() into mm_internal.h to make it available for
>> copy_from_kernel_nofault_allowed() in arch/x86/mm/maccess.c.
>>
> Instead of mm_internal.h would a better place for is_vsyscall_vaddr() be
> arch/x86/include/asm/vsyscall.h?

Yes, asm/vsyscall.h is better indeed. Will update in v2. Thanks for the
suggestion.
>
> Sohil
>
> .


