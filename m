Return-Path: <bpf+bounces-20308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF6083BB07
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 08:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB241F26A4C
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 07:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F413AEA;
	Thu, 25 Jan 2024 07:54:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C645217727;
	Thu, 25 Jan 2024 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169273; cv=none; b=A6uRMVVBUhPOedCE3oFRkCGtyEYV+0DQ2b0+Gx/5++nEplAVX6tfLmNLx6KH5/9INBK960jlKR69IUV26C8QvnORqVPC6tGQaWwYGXCPPihybd3H4Y1C6XOFBGrSUOpesCUod+jcv/yaengSRr33Ve2AiiHvBxxXx2qnLSEDy4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169273; c=relaxed/simple;
	bh=UMDbxq3jf+9EqNgsfHnnGSI8sD1Rgib9GfvR7FCbXDk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nEL3qu66ESZ1f79y/mMIdc6knUsl+Mrw/8lwrWrJ/lvJAIOL7V1q4j1pe483ptEreHqMfz1t6T1zORhlJhITjDtp0Jp8mVLd8b5CwU69NjoD8eILefHJLet9gOhcBPMUTqBNzjNO7hOobb8W8aOZj7DjGT0ZX+Sp81HUP4jrV44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TLClM333vz4f3kjC;
	Thu, 25 Jan 2024 15:54:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5E7601A027B;
	Thu, 25 Jan 2024 15:54:27 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBXJxCtE7JlzoysBw--.1154S2;
	Thu, 25 Jan 2024 15:54:24 +0800 (CST)
Subject: Re: [PATCH bpf 3/3] selftest/bpf: Test the read of vsyscall page
 under x86-64
To: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org, bpf@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, xingwei lee <xrivendell7@gmail.com>,
 Jann Horn <jannh@google.com>, houtao1@huawei.com
References: <20240119073019.1528573-1-houtao@huaweicloud.com>
 <20240119073019.1528573-4-houtao@huaweicloud.com>
 <1c260ab1-d4c0-48e6-bf2b-df69bf083d27@intel.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <01ce6947-8b46-9e27-6ce2-ce5763e3c5a9@huaweicloud.com>
Date: Thu, 25 Jan 2024 15:54:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1c260ab1-d4c0-48e6-bf2b-df69bf083d27@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBXJxCtE7JlzoysBw--.1154S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF15KF4fCFy5KF1xXrW8WFg_yoWDXrX_u3
	9IkFyDJw4xJw17AF43X345uFW2grWDCFy5J39rurW7tryrJasxJwsY9rWruF15GFWIgrs8
	GF4Iqa1UKr1Y9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 1/23/2024 8:25 AM, Sohil Mehta wrote:
> On 1/18/2024 11:30 PM, Hou Tao wrote:
>
>> vsyscall page could be disabled by CONFIG_LEGACY_VSYSCALL_NONE or
>> vsyscall=none boot cmd-line, but it doesn't affect the reproduce of the
>> problem and the returned error codes.
>>
> With vsyscall=emulate a direct read of the vsyscall address from
> userspace is expected to go through. This is mode deprecated so maybe it
> wouldn't matter much. Without the fix in patch 2/3, do you see the same
> behavior with vsyscall=emulate set in the cmdline?

Er, I think it depends on whether or not SMAP [1] feature is available.
When SMAP feature is enabled, even the vsyscall page is populated,
reading the vsyscall page through bpf_read_kernel() will trigger a page
fault and then oops. But when there is not SMAP, bpf_read_kernel() will
succeed. So I think the test may need to be skipped if vsyscall_mode is
emulate.

[1]: https://en.wikipedia.org/wiki/Supervisor_Mode_Access_Prevention
>
> Sohil


