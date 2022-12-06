Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89663643F04
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 09:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiLFIt6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 03:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbiLFItp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 03:49:45 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A41AA471;
        Tue,  6 Dec 2022 00:49:44 -0800 (PST)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NRDbp4lPNz15N9g;
        Tue,  6 Dec 2022 16:48:54 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 16:49:41 +0800
Message-ID: <db4c483d-d798-fcfa-1791-856f61decfd7@huawei.com>
Date:   Tue, 6 Dec 2022 16:49:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf v2] riscv, bpf: Emit fixed-length instructions for
 BPF_PSEUDO_FUNC
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Pu Lehui <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20221202094837.3872444-1-pulehui@huaweicloud.com>
 <87y1rq848x.fsf@all.your.base.are.belong.to.us>
 <0ade59ea-6863-4d68-607c-22e4b9405a0d@huaweicloud.com>
 <87359t3r0h.fsf@all.your.base.are.belong.to.us>
 <0620000f-4d06-de15-09d9-24b5b0c47410@huaweicloud.com>
 <87359szzw3.fsf@all.your.base.are.belong.to.us>
From:   Pu Lehui <pulehui@huawei.com>
In-Reply-To: <87359szzw3.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/12/6 16:42, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>>> Wouldn't that work?
>>>
>>
>> It definitely works. But auipc+addi may be some holes, while
>> lui+addi+slli support all the address of kernel and module. And this
>> might be help for the future feature porting.
> 
> We're already using auipc/jalr for calls, and I'd say it *very* unlikely
> that we'll hit the non-covered range. I'd say go with auipc/addi +
> error, and we can change if this really is a problem.

Well, thank you for your patience, will send new soon.
