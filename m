Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634704B867A
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 12:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiBPLKV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 06:10:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiBPLKU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 06:10:20 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D583888F0
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 03:10:08 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JzFVw5Q2tzZfVh;
        Wed, 16 Feb 2022 19:05:44 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 19:10:06 +0800
Subject: Re: [PATCH bpf-next v3 0/2] bpf, arm64: fix bpf line info
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Will Deacon <will@kernel.org>
CC:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20220208012539.491753-1-houtao1@huawei.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <8575de6e-e806-9c60-1c94-f8bb6868e560@huawei.com>
Date:   Wed, 16 Feb 2022 19:10:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220208012539.491753-1-houtao1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

ping ?

On 2/8/2022 9:25 AM, Hou Tao wrote:
> Hi,
>
> The patchset addresses two issues in bpf line info for arm64:
>
> (1) insn_to_jit_off only considers the body itself and ignores
>     prologue before the body. Fixed in patch #1.
>
> (2) insn_to_jit_off passed to bpf_prog_fill_jited_linfo() is
>     calculated in instruction granularity instead of bytes
>     granularity. Fixed in patch #2.
>
> Comments are always welcome.
>
> Regards,
> Tao
>
> Change Log:
> v3:
>  * patch #2: explain why bpf2a64_offset() needs update
>  * add Fixes tags in both patches
>
> v2: https://lore.kernel.org/bpf/20220125105707.292449-1-houtao1@huawei.com
>  * split into two independent patches (from Daniel)
>  * use AARCH64_INSN_SIZE instead of defining INSN_SIZE
>
> v1: https://lore.kernel.org/bpf/20220104014236.1512639-1-houtao1@huawei.com
>
> Hou Tao (2):
>   bpf, arm64: call build_prologue() first in first JIT pass
>   bpf, arm64: calculate offset as byte-offset for bpf line info
>
>  arch/arm64/net/bpf_jit_comp.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>

