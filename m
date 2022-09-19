Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10CA5BCA25
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 12:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiISK6r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 06:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiISK62 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 06:58:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1DD2A24B;
        Mon, 19 Sep 2022 03:55:37 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWM1W3QdczmVVN;
        Mon, 19 Sep 2022 18:51:43 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 18:55:35 +0800
Message-ID: <5a3c5ea9-d557-6070-d778-1092f3c51257@huawei.com>
Date:   Mon, 19 Sep 2022 18:55:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v4,bpf-next] bpf: Don't redirect packets with invalid
 pkt_len
To:     Stanislav Fomichev <sdf@google.com>, Lorenz Bauer <oss@lmb.io>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
References: <20220715115559.139691-1-shaozhengchao@huawei.com>
 <20220914111936.19881-1-oss@lmb.io>
 <CAKH8qBujKnFh8_g+npxHpo7RGFshus3N0iysmVBohTtG1X2yow@mail.gmail.com>
From:   shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <CAKH8qBujKnFh8_g+npxHpo7RGFshus3N0iysmVBohTtG1X2yow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/9/17 23:46, Stanislav Fomichev wrote:
> On Wed, Sep 14, 2022 at 4:20 AM Lorenz Bauer <oss@lmb.io> wrote:
>>
>> Hi,
>>
>> I think this patch is causing user-space breakage, see [0].
>>
>> The gist is that we do BPF_PROG_RUN of a socket filter with 14 byte input to determine whether
>> BPF_PROG_RUN is available or not. I'll fix this in cilium/ebpf, but I think this patch
>> needs more work since users may be doing the same thing in their code.
> 
> Ooops, sorry about that.
> 
> Instead of rejecting len=0 data, we might accept the packet but add
> some safe header? I think that should be more backwards compatible?
> Zhengchao, something you can look into?
> 
> 
Sorry for the delay. I'm busy testing the TC module recently. I'm very 
sorry for the user-space breakage.

The root cause of this problem is that eth_type_trans() is called when
the protocol type of the SKB is parsed. The len value of the SKB is
reduced to 0. If the user mode requires that the forwarding succeed, or
  if the MAC header is added again after the MAC header is subtracted, 
is this appropriate?

Zhengchao Shao
>> Thanks,
>> Lorenz
>>
>> 0: https://github.com/cilium/ebpf/pull/788
