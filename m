Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43965BF9B1
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 10:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIUIsZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 04:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiIUIsQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 04:48:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9373B7B78D;
        Wed, 21 Sep 2022 01:48:15 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MXX5L6wcmzlVjg;
        Wed, 21 Sep 2022 16:44:06 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 16:48:13 +0800
Message-ID: <c416473b-af8b-3bf6-7ede-e1198b3496f5@huawei.com>
Date:   Wed, 21 Sep 2022 16:48:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v4,bpf-next] bpf: Don't redirect packets with invalid
 pkt_len
To:     Lorenz Bauer <oss@lmb.io>, Stanislav Fomichev <sdf@google.com>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
References: <20220715115559.139691-1-shaozhengchao@huawei.com>
 <20220914111936.19881-1-oss@lmb.io>
 <CAKH8qBujKnFh8_g+npxHpo7RGFshus3N0iysmVBohTtG1X2yow@mail.gmail.com>
 <5a3c5ea9-d557-6070-d778-1092f3c51257@huawei.com>
 <aec8ef40-260c-4ded-b806-d381a3075ff0@www.fastmail.com>
From:   shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <aec8ef40-260c-4ded-b806-d381a3075ff0@www.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/9/20 22:42, Lorenz Bauer wrote:
> On Mon, 19 Sep 2022, at 11:55, shaozhengchao wrote:
>> Sorry for the delay. I'm busy testing the TC module recently. I'm very
>> sorry for the user-space breakage.
>>
>> The root cause of this problem is that eth_type_trans() is called when
>> the protocol type of the SKB is parsed. The len value of the SKB is
>> reduced to 0. If the user mode requires that the forwarding succeed, or
>>    if the MAC header is added again after the MAC header is subtracted,
>> is this appropriate?
> 
> We don't require forwarding to succeed with a 14 byte input buffer. We also don't look at the MAC header.
> 
> I think refusing to forward 0 length packets would be OK. Not 100% certain I understood you correctly, let me know if this helps.
> 
> Best
> Lorenz
Hi Lorenz
	Sorry. But how does the rejection of the 0 length affect the
test case? Is the return value abnormal, send packet failure or some
others?

Zhengchao Shao
