Return-Path: <bpf+bounces-20683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9E2841AF6
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 05:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040E51F27176
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 04:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FF8381DF;
	Tue, 30 Jan 2024 04:20:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AFA381B6;
	Tue, 30 Jan 2024 04:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706588410; cv=none; b=R6FpvnB6OYn5TOqbdkhGYTftR1lxctkJIv+MRFg8VJOoigGGqc5OTEUozyZqE2LYJSugYjJrv6HTA3Z/yeIn4VqzwgfV9509o1HdWjwzCJdKTmEnffjDf3lVvhcLCJtBfPfuZgftThrlUw8m9d9y1WvXtDY4g+RD5IWUvcij7bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706588410; c=relaxed/simple;
	bh=wpynsECXfwdN5FMfXVF0/SEgWc5k0ukuXRXAKJP9C+U=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=C7Kh5EiTlaNKhza4/GO8Dll7tcWGSJfW5AQ+Oi3TDZNnVpIDoKge8W7XdkF7CbuAUUjuDgXTIEZvkbWCLk1TvPM56jg20NamIzZkOd5OVSFZh3q8AOBJ3gxzmk3/Oa7LsP2NR6ZXKjnsP1hLmupAYbrHZfdH8P8CV4ZFasgzpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TPBlc5fnBz4f3mHM;
	Tue, 30 Jan 2024 12:19:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 42BC01A0172;
	Tue, 30 Jan 2024 12:20:03 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCn+mzweLhlrLnHCQ--.27109S2;
	Tue, 30 Jan 2024 12:20:02 +0800 (CST)
Subject: Re: [PATCH bpf v2 1/3] x86/mm: Move is_vsyscall_vaddr() into
 asm/vsyscall.h
To: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org, bpf@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, xingwei lee <xrivendell7@gmail.com>,
 Jann Horn <jannh@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 houtao1@huawei.com
References: <20240126115423.3943360-1-houtao@huaweicloud.com>
 <20240126115423.3943360-2-houtao@huaweicloud.com>
 <76af5d2e-7598-42b4-9ed9-8fec25ece057@intel.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <74d6548c-2de7-9204-ce23-d198387de82c@huaweicloud.com>
Date: Tue, 30 Jan 2024 12:20:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <76af5d2e-7598-42b4-9ed9-8fec25ece057@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCn+mzweLhlrLnHCQ--.27109S2
X-Coremail-Antispam: 1UD129KBjvdXoWrXFW8JF18KFWfCrW5XF4fXwb_yoWxXrb_CF
	W0vFWkWrZ3Jas3JF90yr15XFWkKr48GF45GFn8Gr9xJFnIqFykJrnYyr4vvr4YqF10q3y3
	Gr9xZrWDZrnrKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 1/30/2024 7:56 AM, Sohil Mehta wrote:
> On 1/26/2024 3:54 AM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Moving is_vsyscall_vaddr() into asm/vsyscall.h to make it available for
> s/Moving/Move

Will update in v3.
>
>> copy_from_kernel_nofault_allowed() in arch/x86/mm/maccess.c.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  arch/x86/include/asm/vsyscall.h | 10 ++++++++++
>>  arch/x86/mm/fault.c             |  9 ---------
>>  2 files changed, 10 insertions(+), 9 deletions(-)
>>
>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

Thank you for the review and all of your suggestions.


