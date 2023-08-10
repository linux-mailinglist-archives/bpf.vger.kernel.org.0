Return-Path: <bpf+bounces-7410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A00776D9C
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 03:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECEA281E58
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 01:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B05653;
	Thu, 10 Aug 2023 01:45:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2393634
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 01:45:01 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD796E55
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 18:44:59 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLqQb44WBzcdDK;
	Thu, 10 Aug 2023 09:41:27 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 09:44:56 +0800
Subject: Re: [PATCH bpf-next] bpf: Remove unused declaration
 bpf_link_new_file()
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <andrii@kernel.org>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
References: <20230809140556.45836-1-yuehaibing@huawei.com>
 <99204aea-b71a-a1f9-ab28-4155de5c0523@linux.dev>
From: Yue Haibing <yuehaibing@huawei.com>
Message-ID: <b0b7189e-a20b-e159-a370-99e5f8b47ee7@huawei.com>
Date: Thu, 10 Aug 2023 09:44:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <99204aea-b71a-a1f9-ab28-4155de5c0523@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/10 6:10, Martin KaFai Lau wrote:
> On 8/9/23 7:05 AM, Yue Haibing wrote:
>> Commit a3b80e107894 ("bpf: Allocate ID for bpf_link")
>> removed the implementation but not the declaration.
> 
> It is good to remove unimplemented function. However, how many more of this you have already discovered? Unless it is like hundred line changes, can you please batch them all together and send them in one patch?

Ok, glad to follow this rule. For bpf I only found this one left now.

> 
>>
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>>   include/linux/bpf.h | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index db3fe5a61b05..cfabbcf47bdb 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2120,7 +2120,6 @@ void bpf_link_cleanup(struct bpf_link_primer *primer);
>>   void bpf_link_inc(struct bpf_link *link);
>>   void bpf_link_put(struct bpf_link *link);
>>   int bpf_link_new_fd(struct bpf_link *link);
>> -struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
>>   struct bpf_link *bpf_link_get_from_fd(u32 ufd);
>>   struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
>>   
> 
> .

