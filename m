Return-Path: <bpf+bounces-35069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAA293752C
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 10:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73381F221D2
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 08:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7165378B4C;
	Fri, 19 Jul 2024 08:41:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD86EB7D;
	Fri, 19 Jul 2024 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378500; cv=none; b=fqg7oPKPemqOHyzQBZBBKeZpP8RVhmt9tIwYRRR2Ad6WgBr6rvdwwxNFK8PbncJVbfEmzIBHNO2W+2+nRyGzvSFTUIbrFNp5fzgIfbfva5ohXn6ufX/xDatX6Z8IQ0Zxzq7uBTYJgnm//X63AJ2nM4CM533jlK9YcU4k1nwFFK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378500; c=relaxed/simple;
	bh=ltFMXkvKbF0yWyNLbYFdmWl6T1kM47/dP3cmoxr1iAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/fA0oNXS+kAPt3eHakYRIyRvhrhHD0kt7EWd8dTM725TIFPoyK3nGDqkHGshTAbgN4q1Y8CtOSC3WjptTZIenZDbRtkT2r2LX9GjxiMgLylIiuMfrJiiXMl5Gfqy6Xbldaw+HZsGWganG/IXmPXHAkX9F/iDJVNKrwrPZ9iS7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WQNSJ5GFdz4f3kvw;
	Fri, 19 Jul 2024 16:41:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0CD111A0572;
	Fri, 19 Jul 2024 16:41:34 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgDHZXe7JppmKhspAg--.59809S2;
	Fri, 19 Jul 2024 16:41:32 +0800 (CST)
Message-ID: <1895b546-9ae1-48b1-a2b1-902b73e28384@huaweicloud.com>
Date: Fri, 19 Jul 2024 16:41:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 5/9] bpf, verifier: improve signed ranges
 inference for BPF_AND
Content-Language: en-US
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Matt Bobrowski <mattbobrowski@google.com>, Yafang Shao
 <laoar.shao@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 James Morris <jamorris@linux.microsoft.com>, Kees Cook <kees@kernel.org>,
 Brendan Jackman <jackmanb@google.com>, Florent Revest <revest@google.com>
References: <20240719081749.769748-1-xukuohai@huaweicloud.com>
 <20240719081749.769748-6-xukuohai@huaweicloud.com>
 <onr3unastba5zd22wfkgotnrwcipuhznw2k6ip6f2mhlreyu3b@xdbae6cx5ds3>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <onr3unastba5zd22wfkgotnrwcipuhznw2k6ip6f2mhlreyu3b@xdbae6cx5ds3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDHZXe7JppmKhspAg--.59809S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1xCFyDtw13tF4fKrWfKrg_yoW3Cwc_ur
	yDuwnrCwn0gw4FgF4Iqw45tryqqayUG34Utw13K3yfKr95Ar15uFn5GFnYgw1Fgayrtwn0
	9F98t3Wavrs3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/19/2024 4:23 PM, Shung-Hsi Yu wrote:
> On Fri, Jul 19, 2024 at 04:17:45PM GMT, Xu Kuohai wrote:
>> From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
>>
>> This commit teach the BPF verifier how to infer signed ranges directly
>> from signed ranges of the operands to prevent verifier rejection, which
>> is needed for the following BPF program's no-alu32 version, as shown by
>> Xu Kuohai:
>>
> [...]
> 
> Ah, I just sent and updated version of this patch[1] about the same time
> as you, sorry about not communicating this clearer. Could you use the
> update version instead?
> 
> Thanks,
> Shung-Hsi
> 
> 0: https://lore.kernel.org/bpf/20240719081702.137173-1-shung-hsi.yu@suse.com/
> 

Interesting, we've sent the patch almost at the same time. I'll post an update
with your new patch, thanks.


