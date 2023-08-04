Return-Path: <bpf+bounces-6993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9F976FFF4
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 14:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6721C21808
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 12:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E312BA56;
	Fri,  4 Aug 2023 12:06:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46422AD37;
	Fri,  4 Aug 2023 12:06:45 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207A8B1;
	Fri,  4 Aug 2023 05:06:44 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHPYX10X0zrS2F;
	Fri,  4 Aug 2023 20:05:36 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 20:06:41 +0800
Message-ID: <40308d96-d141-8f90-76b5-c0c70f7d1fa5@huawei.com>
Date: Fri, 4 Aug 2023 20:06:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next 0/2] team: change return value of init and getter
 in the team_option structure to void
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20230804112825.1697920-1-shaozhengchao@huawei.com>
 <ZMzkgSQTDVhRe18v@nanopsycho>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <ZMzkgSQTDVhRe18v@nanopsycho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/4 19:44, Jiri Pirko wrote:
> Fri, Aug 04, 2023 at 01:28:23PM CEST, shaozhengchao@huawei.com wrote:
>> Because the init and getter function always returns 0, so change return
>> value of init and getter in the team_option structure to void and remove
>> redundant code.
> 
> Reading this 5 times, I don't understand the sentence :/
> 
> Also, why you send 2 patchsets and 2 seperate patches, all for team? Why
> don't you send it as one 6-patch patchset?
> 
Hi Jiri:
	Thank you for review. I will send a patchset.

Zhengchao Shao
> 
>>
>> Zhengchao Shao (2):
>>   team: change return value of init in the team_option structure to void
>>   team: change return value of getter in the team_option structure to
>>     void
>>
>> drivers/net/team/team.c                   | 60 +++++++++--------------
>> drivers/net/team/team_mode_activebackup.c |  8 ++-
>> drivers/net/team/team_mode_loadbalance.c  | 39 ++++++---------
>> include/linux/if_team.h                   |  4 +-
>> 4 files changed, 44 insertions(+), 67 deletions(-)
>>
>> -- 
>> 2.34.1
>>
> 

