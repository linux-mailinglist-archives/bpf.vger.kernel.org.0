Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4416CB8B6
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjC1Hw6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 03:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjC1Hw4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 03:52:56 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCE3A3;
        Tue, 28 Mar 2023 00:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1679989971; bh=Jn2x0nOTgnxlUFnZ2c/7x81qzDXrhBH81tHUgVzMh84=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D4kjclj9I5MlPea1nrgZ+Jp1SADA82MHNz9O/BLHhL5rmlE2Pynqw4BDIYZsiQ8DN
         vdxcfu6HsITGmbGv41PgCAfRTn2AG3su0XSosEei+5OYdimDyyGMZtctbsj3KWaq7x
         4OAfX0q6HoOWQS2Boz5dIVSuH8/tETISuWhJj+VE=
Received: from [100.100.33.167] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 44761600CE;
        Tue, 28 Mar 2023 15:52:51 +0800 (CST)
Message-ID: <d4409486-7b3e-5b59-3b4e-9e832a7c98d5@xen0n.name>
Date:   Tue, 28 Mar 2023 15:52:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2] loongarch/bpf: Skip speculation barrier opcode, which
 caused ltp testcase bpf_prog02 to fail
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>,
        George Guo <guodongtai@kylinos.cn>
Cc:     ast@kernel.org, bpf@vger.kernel.org, chenhuacai@kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        hengqi.chen@gmail.com, yangtiezhu@loongson.cn,
        tangyouling@loongson.cn
References: <c1932d0d-cf3f-5005-958d-7e08dddf42c9@iogearbox.net>
 <20230328071335.2664966-1-guodongtai@kylinos.cn>
 <ddb2f552-252f-4533-469b-31044b4fc2d6@iogearbox.net>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <ddb2f552-252f-4533-469b-31044b4fc2d6@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2023/3/28 15:22, Daniel Borkmann wrote:
> On 3/28/23 9:13 AM, George Guo wrote:
>> Here just skip the opcode(BPF_ST | BPF_NOSPEC) that has no couterpart 
>> to the loongarch.
>>
>> <snip>
>>
>> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
>> index 288003a9f0ca..d3c6b1c4ccbb 100644
>> --- a/arch/loongarch/net/bpf_jit.c
>> +++ b/arch/loongarch/net/bpf_jit.c
>> @@ -1022,6 +1022,11 @@ static int build_insn(const struct bpf_insn 
>> *insn, struct jit_ctx *ctx, bool ext
>>           emit_atomic(insn, ctx);
>>           break;
>> +    /* Speculation barrier */
>> +    case BPF_ST | BPF_NOSPEC:
>> +        pr_info_once("bpf_jit: skip speculation barrier opcode 
>> %0x2x\n", code);
>> +        break;
> 
> Thanks that looks better. Question to LoongArch folks (Cc): There is no 
> equivalent
> to a speculation barrier here, correct? Either way, I think the 
> pr_info_once() can
> just be removed given there is little value for a users to have this in 
> the kernel
> log. I can take care of this while applying, that's fine.

I can confirm there's currently no speculation barrier equivalent on 
lonogarch. (Loongson says there are builtin mitigations for Spectre-V1 
and V2 on their chips, and AFAIK efforts to port the exploits to 
mips/loongarch have all failed a few years ago.)

And yes I'd agree with removing the warning altogether. Thanks for the 
reviews!

Acked-by: WANG Xuerui <git@xen0n.name>

> 
>>       default:
>>           pr_err("bpf_jit: unknown opcode %02x\n", code);
>>           return -EINVAL;
>>
> 

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

