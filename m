Return-Path: <bpf+bounces-8428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9DF786492
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 03:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C4B2813F4
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 01:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF1017CF;
	Thu, 24 Aug 2023 01:23:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80537F;
	Thu, 24 Aug 2023 01:23:21 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F465A8;
	Wed, 23 Aug 2023 18:23:20 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RWQJV2zsDzVjt7;
	Thu, 24 Aug 2023 09:20:58 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 24 Aug 2023 09:23:14 +0800
Message-ID: <2c099f21-7e3a-6263-d9ba-013c5571671e@huawei.com>
Date: Thu, 24 Aug 2023 09:23:13 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Enable cpu v4 tests for RV64
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>
CC: Pu Lehui <pulehui@huaweicloud.com>, linux-riscv
	<linux-riscv@lists.infradead.org>, bpf <bpf@vger.kernel.org>, Network
 Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Xu Kuohai <xukuohai@huawei.com>,
	Puranjay Mohan <puranjay12@gmail.com>
References: <20230823231059.3363698-1-pulehui@huaweicloud.com>
 <20230823231059.3363698-8-pulehui@huaweicloud.com>
 <87zg2hk44i.fsf@all.your.base.are.belong.to.us>
 <CAADnVQLu5twbe_UpiJrD0wKq1YyHzZbfzYhsW-mte7vDmyna5g@mail.gmail.com>
 <875y55tu5n.fsf@all.your.base.are.belong.to.us>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <875y55tu5n.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/24 3:50, Björn Töpel wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> 
>> On Wed, Aug 23, 2023 at 11:25 AM Björn Töpel <bjorn@kernel.org> wrote:
>>>
>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>
>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>
>>>> Enable cpu v4 tests for RV64, and the relevant tests have passed.
>>>>
>>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>>
>>> Acked-by: Björn Töpel <bjorn@kernel.org>
>>
>> Bjorn,
>>
>> Thanks a lot for the quick review!
>> Could you give it a spin as well and hopefully add Tested-by ?
>>
>> We still have time to get it into bpf-next for the upcoming merge window.
> 
> I'll kick a run! But I'd like a change to mov 8/16b patch (#3) prior
> pulling.
> 
>> We still have time to get it into bpf-next for the upcoming merge window.
> 
> @Lehui Do you have time to cook a v2?

Sorry guys for the late reply due to sleep. V2 is ready and will send soon.

> 
> 
> Björn

