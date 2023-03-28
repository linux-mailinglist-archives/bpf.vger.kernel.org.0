Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253B76CB994
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 10:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjC1Ii0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 04:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjC1IiM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 04:38:12 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BF25B8C;
        Tue, 28 Mar 2023 01:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=c2gJkGR3ZVhZjd+ydR7063pupKsOxtcVp5HBCZXf92Y=; b=IWCKPYunG2TLjovBm3mAvmLI+H
        DQWyS8H4iohgGN1q88CjKUi2pJs9F54e1Xv8zqf8aUsrykXFi1YOsV4SXu1AjREYSRCpga8/xaA/R
        bsc8u2eWRCJJmo/XWhU7JDViFWKzjoHknYuR84bo/91vjaLjA9Qtq+ha2EIZR6jofzBv2jS2Uc1Jp
        85lSdA9MyWwBsHjAp8xBsTavsw0+Hgjksxd+6ChmvbxK+Fore6L8473BiDS948cYF6XAAGxvneOQG
        S3I+Pny1cWHrTQ+TPjBO7SfxGPcuoEm5g/DNDBXaRwp/AFqpVWWQayhaH6cetvS0dM1LzAekctfle
        ahspeLwA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1ph4pu-000FI6-En; Tue, 28 Mar 2023 10:37:46 +0200
Received: from [219.59.88.22] (helo=localhost.localdomain)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ph4pt-000UJx-IV; Tue, 28 Mar 2023 10:37:45 +0200
Subject: Re: [PATCH v2] loongarch/bpf: Skip speculation barrier opcode, which
 caused ltp testcase bpf_prog02 to fail
To:     WANG Xuerui <kernel@xen0n.name>, George Guo <guodongtai@kylinos.cn>
Cc:     ast@kernel.org, bpf@vger.kernel.org, chenhuacai@kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        hengqi.chen@gmail.com, yangtiezhu@loongson.cn,
        tangyouling@loongson.cn
References: <c1932d0d-cf3f-5005-958d-7e08dddf42c9@iogearbox.net>
 <20230328071335.2664966-1-guodongtai@kylinos.cn>
 <ddb2f552-252f-4533-469b-31044b4fc2d6@iogearbox.net>
 <d4409486-7b3e-5b59-3b4e-9e832a7c98d5@xen0n.name>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a8640220-4555-7f14-b1d3-deaaae587331@iogearbox.net>
Date:   Tue, 28 Mar 2023 10:37:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d4409486-7b3e-5b59-3b4e-9e832a7c98d5@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26857/Tue Mar 28 09:23:39 2023)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/28/23 9:52 AM, WANG Xuerui wrote:
> On 2023/3/28 15:22, Daniel Borkmann wrote:
>> On 3/28/23 9:13 AM, George Guo wrote:
>>> Here just skip the opcode(BPF_ST | BPF_NOSPEC) that has no couterpart to the loongarch.
>>>
>>> <snip>
>>>
>>> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
>>> index 288003a9f0ca..d3c6b1c4ccbb 100644
>>> --- a/arch/loongarch/net/bpf_jit.c
>>> +++ b/arch/loongarch/net/bpf_jit.c
>>> @@ -1022,6 +1022,11 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>>>           emit_atomic(insn, ctx);
>>>           break;
>>> +    /* Speculation barrier */
>>> +    case BPF_ST | BPF_NOSPEC:
>>> +        pr_info_once("bpf_jit: skip speculation barrier opcode %0x2x\n", code);
>>> +        break;
>>
>> Thanks that looks better. Question to LoongArch folks (Cc): There is no equivalent
>> to a speculation barrier here, correct? Either way, I think the pr_info_once() can
>> just be removed given there is little value for a users to have this in the kernel
>> log. I can take care of this while applying, that's fine.
> 
> I can confirm there's currently no speculation barrier equivalent on lonogarch. (Loongson says there are builtin mitigations for Spectre-V1 and V2 on their chips, and AFAIK efforts to port the exploits to mips/loongarch have all failed a few years ago.)
> 
> And yes I'd agree with removing the warning altogether. Thanks for the reviews!
> 
> Acked-by: WANG Xuerui <git@xen0n.name>

Ok, sounds good. I've cleaned this up and applied to bpf tree. Thanks!

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=a6f6a95f25803500079513780d11a911ce551d76
