Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F005FF80A
	for <lists+bpf@lfdr.de>; Sat, 15 Oct 2022 04:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJOCgu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 22:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJOCgt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 22:36:49 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CDA2B1AA;
        Fri, 14 Oct 2022 19:36:48 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mq6j50HSmz1P7MC;
        Sat, 15 Oct 2022 10:32:09 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 15 Oct 2022 10:36:46 +0800
Message-ID: <ce5d58a3-32ed-fa81-d490-ce854cfca927@huawei.com>
Date:   Sat, 15 Oct 2022 10:36:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v4,bpf-next] bpf: Don't redirect packets with invalid
 pkt_len
To:     <sdf@google.com>, Lorenz Bauer <oss@lmb.io>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
References: <20220715115559.139691-1-shaozhengchao@huawei.com>
 <20220914111936.19881-1-oss@lmb.io>
 <CAKH8qBujKnFh8_g+npxHpo7RGFshus3N0iysmVBohTtG1X2yow@mail.gmail.com>
 <5a3c5ea9-d557-6070-d778-1092f3c51257@huawei.com>
 <aec8ef40-260c-4ded-b806-d381a3075ff0@www.fastmail.com>
 <c416473b-af8b-3bf6-7ede-e1198b3496f5@huawei.com>
 <bc69e8a3-d474-451f-853e-1c936f776ef9@app.fastmail.com>
 <cf6a99a1-e77f-113d-101a-5b5a52111df5@huawei.com>
 <04d2eb4a-7365-495a-ab74-704febac2789@app.fastmail.com>
 <Y0mUjLXEpVuheSUc@google.com>
From:   shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <Y0mUjLXEpVuheSUc@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/10/15 0:55, sdf@google.com wrote:
> On 10/14, Lorenz Bauer wrote:
>> On Thu, 13 Oct 2022, at 11:44, shaozhengchao wrote:
>> >     Sorry, I haven't fully understood your intentions yet.
>> > Can you explain it more detail?
> 
>> I'll try! Roughly, we do the following:
> 
>> 1. Create a BPF_PROG_TYPE_SOCKET_FILTER program that just returns 0
>> 2. Load the program into the kernel
>> 3. Call BPF_PROG_RUN with data_size_in == 14
> 
>> After your bugfix, it seems like step 3 is rejected due to 
>> data_size_in == 14. We had to increase data_size_in to 15 to
>> avoid this, see [0].
> 
>> This breaks user space, so it would be great if you could fix this in 
>> a way that doesn't refuse BPF_PROG_RUN with
> 
> [..]
> 
>> data_size_in == 14. Since I don't understand the original problem very 
>> well I can't tell you what the best fix is however.
> 
> The problem was that we were able to generate skb with len=0 via
> BPF_PROG_RUN. Prohibiting those cases breaks backwards compatibility, so
> we either have to:
> 
> a) (preferred?) accept inputs with <14, but maybe internally pad to 14
> bytes to make the core stack happy
> b) revert the patch and instead have length checks at runtime; doesn't 
> seem to
> be worth the penalty in the forwarding path because of some corner cases
> like these ?
> 
Hi sdf:
	a） looks better and I'll put up a patch as soon as possible to
fix it.

Zhengchao Shao
> 
>> 0: 
>> https://github.com/cilium/ebpf/commit/a38fb6b5a46ab3b5639ea4d421232a10013596c0
> 
>> Thanks
>> Lorenz
