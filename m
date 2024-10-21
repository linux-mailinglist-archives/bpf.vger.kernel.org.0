Return-Path: <bpf+bounces-42628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E269A6AE8
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5703287C11
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 13:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EA31F8EE9;
	Mon, 21 Oct 2024 13:46:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95941F891F
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518372; cv=none; b=KPXISTp0jFH0C6rFstpmWElGqEYF2Ug3DUJ+52pJ3rdI4twJI/Yd1QtvXXlrsumLdgavWt2fRMQb8msnhLlfYm1l1RB621w4+4smHm4bj8v0bpqa6P1B2LtuKxrpX/1t5hNuWCORgj47uVH4ndQcyMe3JWulLXBMv1j2YdnZgsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518372; c=relaxed/simple;
	bh=Fpf0PIMhidVCIzDcfRUUJVyszeQqZP/BsDbijWINbRM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nB7s2YIj5KjvCiBOYM9slENXVGtt+Ek1Mk8XS39R4it23uyf7K5mkYzkF1II/yHlMzv7gq9FSaKCDm9iUFkY/k49rguSw0uWNK3uPxEKc06gDmU9uq57FOcsjEhnzFKlT7K1hGna+bXqJnm1WV67HyTFMzUwg/OH1pkc4Zglo8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXGm95BQ2z4f3nTw
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 21:45:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DA68D1A018D
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 21:46:03 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAnUi4XWxZn4IdaEg--.57048S2;
	Mon, 21 Oct 2024 21:46:03 +0800 (CST)
Subject: Re: [PATCH bpf-next 01/16] bpf: Introduce map flag
 BPF_F_DYNPTR_IN_KEY
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20241008091501.8302-1-houtao@huaweicloud.com>
 <20241008091501.8302-2-houtao@huaweicloud.com>
 <CAADnVQJ67TERc5Ag22f_O0BJJPmNpQYvxP08uBa0ur6FRdJoFw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <39cd6231-0d58-14fd-efd0-52dcf0c25a06@huaweicloud.com>
Date: Mon, 21 Oct 2024 21:45:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJ67TERc5Ag22f_O0BJJPmNpQYvxP08uBa0ur6FRdJoFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAnUi4XWxZn4IdaEg--.57048S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr17Zw1xAryUJry3GFyrXrb_yoWfuFX_Aa
	y8uF4fG3WDXry7GFyjkF17CrZFkF93ZFs7WF95Xr1xtF95XryrJr409r97C34DG39Fyr4D
	G3yFqayvv3Z0qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/10/2024 10:21 AM, Alexei Starovoitov wrote:
> On Tue, Oct 8, 2024 at 2:02 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> index c6cd7c7aeeee..07f7df308a01 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1409,6 +1409,9 @@ enum {
>>
>>  /* Do not translate kernel bpf_arena pointers to user pointers */
>>         BPF_F_NO_USER_CONV      = (1U << 18),
>> +
>> +/* Create a map with bpf_dynptr in key */
>> +       BPF_F_DYNPTR_IN_KEY     = (1U << 19),
>>  };
> If I'm reading the other patches correctly this uapi flag
> is unnecessary.
> BTF describes the fields and dynptr is either there or not.
> Why require users to add an extra flag ?

Sorry for the late reply. The reason for an extra flag is to make a bpf
map which had already used bpf_dynptr in its key to work as before. I
was not sure whether or not there is such case, so I added an extra
flag. If the case is basically impossible, I can remove it in the next
revision.


