Return-Path: <bpf+bounces-7103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403437717A6
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 03:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5449E1C208DB
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 01:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6CA64F;
	Mon,  7 Aug 2023 01:03:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCEB19D;
	Mon,  7 Aug 2023 01:03:47 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DBA1722;
	Sun,  6 Aug 2023 18:03:43 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RJyj52Fh3zrSF7;
	Mon,  7 Aug 2023 09:02:33 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 09:03:37 +0800
Message-ID: <699377e7-d581-95bf-fe2f-3e3d01fab5e3@huawei.com>
Date: Mon, 7 Aug 2023 09:03:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next 0/6] team: do some cleanups in team driver
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@resnulli.us>, <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20230804123116.2495908-1-shaozhengchao@huawei.com>
 <ZM44lK+bu8/ng4cR@vergenet.net>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <ZM44lK+bu8/ng4cR@vergenet.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/5 19:55, Simon Horman wrote:
> On Fri, Aug 04, 2023 at 08:31:10PM +0800, Zhengchao Shao wrote:
>> Do some cleanups in team driver.
>>
>> Zhengchao Shao (6):
>>    team: add __exit modifier to team_nl_fini()
>>    team: remove unreferenced header in activebackup/broadcast/roundrobin
>>      files
>>    team: change the init function in the team_option structure to void
>>    team: change the getter function in the team_option structure to void
>>    team: get lb_priv from team directly in lb_htpm_select_tx_port
>>    team: remove unused input parameters in lb_htpm_select_tx_port and
>>      lb_hash_select_tx_port
> 
> Hi Zhengchao Shao,
> 
> Some of these patches appear to have been posted several times within
> a few hours. Please follow the guidance that at least 24h must elapse
> between posting the same patch. This is to allow time for review,
> else things can get really confusing for the reviewers.
> 
> Link: https://docs.kernel.org/process/maintainer-netdev.html

Hi Simon:
	I'll follow this rule. Thank you for reminding me.

Zhengchao Shao

