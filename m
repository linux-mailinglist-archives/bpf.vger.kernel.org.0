Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141F064E9AD
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 11:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiLPKqD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 05:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiLPKpv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 05:45:51 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C66B1A381
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 02:45:44 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NYQhk60p0zRpgs;
        Fri, 16 Dec 2022 18:44:38 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 18:45:42 +0800
Subject: Re: [bpf-next 2/2] selftests/bpf: add test cases for htab map
From:   Hou Tao <houtao1@huawei.com>
To:     <xiangxia.m.yue@gmail.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Yonghong Song <yhs@meta.com>
References: <20221214103857.69082-1-xiangxia.m.yue@gmail.com>
 <20221214103857.69082-2-xiangxia.m.yue@gmail.com>
 <73b9ef21-de67-e421-378a-1814ffbc263f@meta.com>
 <a0c44452-70b0-8b05-151f-932c3b9e2fb0@huawei.com>
Message-ID: <406710d0-bd65-a6b0-a7b4-9fa8c72ccaa6@huawei.com>
Date:   Fri, 16 Dec 2022 18:45:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <a0c44452-70b0-8b05-151f-932c3b9e2fb0@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 12/16/2022 6:41 PM, Hou Tao wrote:
> Hi,
>
> On 12/16/2022 12:10 PM, Yonghong Song wrote:
>>
>> On 12/14/22 2:38 AM, xiangxia.m.yue@gmail.com wrote:
>>> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>>>
>>> This testing show how to reproduce deadlock in special case.
> Could you elaborate the commit message to show
Sorry about that. Just hit the send button too soon. It would be better if you
can describe the steps to reproduce the deadlock problem in commit message.

.

