Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E0C4BF062
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 05:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiBVD7M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Feb 2022 22:59:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiBVD7L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Feb 2022 22:59:11 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718A143EE6
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 19:58:40 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K2ljz2bwszcfdK;
        Tue, 22 Feb 2022 11:57:27 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 11:58:37 +0800
Subject: Re: [PATCH bpf-next v3 2/2] bpf, arm64: calculate offset as
 byte-offset for bpf line info
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
CC:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20220208012539.491753-1-houtao1@huawei.com>
 <20220208012539.491753-3-houtao1@huawei.com>
 <4df19b70-6ed7-c521-ed25-97f92f703483@iogearbox.net>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <ec45ff91-050a-61d6-61b4-deef14750428@huawei.com>
Date:   Tue, 22 Feb 2022 11:58:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4df19b70-6ed7-c521-ed25-97f92f703483@iogearbox.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2/19/2022 7:20 AM, Daniel Borkmann wrote:
> On 2/8/22 2:25 AM, Hou Tao wrote:
>> insn_to_jit_off passed to bpf_prog_fill_jited_linfo() is calculated
>> in instruction granularity instead of bytes granularity, but bpf
>> line info requires byte offset, so fixing it by calculating ctx->offset
>> as byte-offset. bpf2a64_offset() needs to return relative instruction
>> offset by using ctx->offfset, so update it accordingly.
>>
>> Fixes: 37ab566c178d ("bpf: arm64: Enable arm64 jit to provide bpf_line_info")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>   arch/arm64/net/bpf_jit_comp.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
[snip]
>>           if (ret)
>> @@ -1105,7 +1111,7 @@ static int build_body(struct jit_ctx *ctx, bool
>> extra_pass)
>>        * instruction (end of program)
>>        */
>>       if (ctx->image == NULL)
>> -        ctx->offset[i] = ctx->idx;
>> +        ctx->offset[i] = ctx->idx * AARCH64_INSN_SIZE;
>
> Both patches look good to me. For this one specifically, given bpf2a64_offset()
> needs to return relative instruction offset via ctx->offfset, can't we just
> simplify it like this w/o the AARCH64_INSN_SIZE back/forth dance?
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 74f9a9b6a053..72f4702a9d01 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -999,7 +999,7 @@ struct arm64_jit_data {
>
>  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  {
> -    int image_size, prog_size, extable_size;
> +    int image_size, prog_size, extable_size, i;
>      struct bpf_prog *tmp, *orig_prog = prog;
>      struct bpf_binary_header *header;
>      struct arm64_jit_data *jit_data;
> @@ -1130,6 +1130,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>      prog->jited_len = prog_size;
>
>      if (!prog->is_func || extra_pass) {
> +        /* BPF line info needs byte-offset instead of insn-offset. */
> +        for (i = 0; i < prog->len + 1; i++)
> +            ctx.offset[i] *= AARCH64_INSN_SIZE;
>          bpf_prog_fill_jited_linfo(prog, ctx.offset + 1);
>  out_off:
>          kfree(ctx.offset);
The fix is much simpler. I will check whether or not it works.

Thanks,
Tao

