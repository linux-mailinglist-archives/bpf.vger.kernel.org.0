Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DD9602181
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 04:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJRC5F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 22:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJRC5E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 22:57:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C3E97D72;
        Mon, 17 Oct 2022 19:57:03 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mrz0z0wRXz1P7Cv;
        Tue, 18 Oct 2022 10:52:19 +0800 (CST)
Received: from [10.174.179.191] (10.174.179.191) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 10:57:00 +0800
Message-ID: <b38c7c5e-bd88-0257-42f4-773d8791330a@huawei.com>
Date:   Tue, 18 Oct 2022 10:57:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [net 1/2] selftests/net: fix opening object file failed
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Lina Wang <lina.wang@mediatek.com>
CC:     <bpf@vger.kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <deso@posteo.net>, <netdev@vger.kernel.org>
References: <1665482267-30706-1-git-send-email-wangyufen@huawei.com>
 <1665482267-30706-2-git-send-email-wangyufen@huawei.com>
 <469d28c0-8156-37ad-d0d9-c11608ca7e07@linux.dev>
From:   wangyufen <wangyufen@huawei.com>
In-Reply-To: <469d28c0-8156-37ad-d0d9-c11608ca7e07@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.191]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/10/13 9:51, Martin KaFai Lau 写道:
> On 10/11/22 2:57 AM, Wang Yufen wrote:
>> The program file used in the udpgro_frglist testcase is 
>> "../bpf/nat6to4.o",
>> but the actual nat6to4.o file is in "bpf/" not "../bpf".
>> The following error occurs:
>>    Error opening object ../bpf/nat6to4.o: No such file or directory
>
> hmm... so it sounds like the test never works...
>
> The test seems like mostly exercising the tc-bpf?  It makes sense to 
> move it to the selftests/bpf. or staying in net is also fine for now 
> and only need to fix up the path here.
>
> However, if moving to selftests/bpf, I don't think it is a good idea 
> to only move the bpf prog but not moving the actual test program (the 
> script here) such that the bpf CI can continuously testing it.  
> Otherwise, it will just drift and rot slowly like patch 2.
>
> Also, if you prefer to move it to selftests/bpf, the bpf prog cannot 
> be moved in the current form.  eg. There is some convention on the SEC 
> name in the selftests/bpf/progs.  Also, the testing script needs to be 
> adapted to the selftests/bpf/test_progs infra.

hmm... if moving to selftests/bpf, the actual test programs also needs 
to move to selftests/bpf, e.g. udpgso_bench_*, in_netns.sh, udpgso*.sh, 
which may not be a good idea.

So, only fix up the path here.

Also fix up the bpf/nat6to4.o compile error as following:

     make -C tools/testing/selftests/net got the following err:
     bpf/nat6to4.c:43:10: fatal error: 'bpf/bpf_helpers.h' file not found
              ^~~~~~~~~~~~~~~~~~~

