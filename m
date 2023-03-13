Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353CA6B6D86
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 03:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCMCbH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Mar 2023 22:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCMCbG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Mar 2023 22:31:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728AF34301
        for <bpf@vger.kernel.org>; Sun, 12 Mar 2023 19:31:05 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PZgZX54BfzHwd0;
        Mon, 13 Mar 2023 10:28:52 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 10:20:05 +0800
Message-ID: <c6d5e819-3e57-8e54-3cfd-d5a9814d96d1@huawei.com>
Date:   Mon, 13 Mar 2023 10:20:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC] Implementing the BPF dispatcher on ARM64
Content-Language: en-US
To:     Puranjay Mohan <puranjay12@gmail.com>, <bjorn@rivosinc.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        <daniel@iogearbox.net>
CC:     <bjorn@kernel.org>, <andrii@kernel.org>, <ast@kernel.org>,
        <bpf@vger.kernel.org>, <memxor@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <CANk7y0gsUpnVnDMh=Wbs5h2Z=25bzMEZ5La03-MX133DPd=eDA@mail.gmail.com>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <CANk7y0gsUpnVnDMh=Wbs5h2Z=25bzMEZ5La03-MX133DPd=eDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ cc arm list ]

On 3/10/2023 5:33 PM, Puranjay Mohan wrote:
> Hi,
> I am starting this thread to know if someone is implementing the BPF
> dispatcher for ARM64 and if not, what would be needed to make this
> happen.
> 
> The basic infra + x86 specific code was introduced in [1] by Björn Töpel.
> 
> To make BPF dispatcher work on ARM64, the
> arch_prepare_bpf_dispatcher() has to be implemented in
> arch/arm64/net/bpf_jit_comp.c.
> 
> As I am not well versed with XDP and the JIT, I have a few questions
> regarding this.
> 
> 1. What is the best way to test this? Is there a selftest that will
> fail now and will pass once the dispatcher is implemented?
> 2. As there is no CONFIG_RETPOLINE in ARM64, will the dispatcher be useful.

Hello,

I have some thoughts for bpf dispatcher in arm64.

bpf dispatcher uses static call to convert indirect call instructions to direct
call instructions, to avoid performance penalty introduced by retpoline. Since
there is no retpoline or static call in arm64, bpf dispatcher seems useless.

In addition, the range for a direct call instruction in arm64 is +-128MB, but
jited bpf image address is outside of +-128MB, so it may not be possible to call
a bpf prog with direct call instruction.

> 
> [1] https://github.com/torvalds/linux/commit/75ccbef6369e94ecac696a152a998a978d41376b
> 

