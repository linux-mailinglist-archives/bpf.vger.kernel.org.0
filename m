Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D4C66089C
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 22:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjAFVIL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 16:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjAFVIK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 16:08:10 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B61780631
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 13:08:08 -0800 (PST)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pDtwa-000It6-MW; Fri, 06 Jan 2023 22:08:04 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pDtwa-000EgJ-G9; Fri, 06 Jan 2023 22:08:04 +0100
Subject: Re: [Bpf] [PATCH] bpf, docs: Fix modulo zero, division by zero,
 overflow, and underflow
To:     Dave Thaler <dthaler@microsoft.com>,
        "sdf@google.com" <sdf@google.com>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "bpf@ietf.org" <bpf@ietf.org>
References: <20230105163223.3472-1-dthaler1968@googlemail.com>
 <Y7cefSXEQ3M3C9pk@google.com>
 <51a639d4-c140-a10e-cd67-fff92ebcda9d@iogearbox.net>
 <BN6PR21MB07880DB65051DCAC6F8D0021A3FB9@BN6PR21MB0788.namprd21.prod.outlook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ac61c733-73f3-8347-83db-b611967459ca@iogearbox.net>
Date:   Fri, 6 Jan 2023 22:08:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <BN6PR21MB07880DB65051DCAC6F8D0021A3FB9@BN6PR21MB0788.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26773/Fri Jan  6 09:48:44 2023)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/6/23 7:11 PM, Dave Thaler wrote:
> Daniel Borkmann wrote:
> [...]
>>>> +Also note that the division and modulo operations are unsigned,
>>>> +where 'imm' is first sign extended to 64 bits and then converted to
>>>> +an unsigned 64-bit value.  There are no instructions for signed
>>>> +division or modulo.
>>>
>>> Less sure about this part, but it looks to be true at least by looking
>>> at the interpreter which does:
>>>
>>> DST = DST / IMM
>>>
>>> where:
>>>
>>> DST === (u64) regs[insn->dst_reg]
>>> IMM === (s32) insn->imm
>>>
>>> (and s32 is sign-expanded to u64 according to C rules)
>>
>> Yeap, the actual operation is in the target width, so for 32 bit it's casted to
>> u32, e.g. for modulo (note that the verifier rewrites it into `(src != 0) ?
>> (dst % src) : dst` form, so here is just the extract of the plain mod insn and it's
>> similar for div):
>>
>>           ALU64_MOD_X:
>>                   div64_u64_rem(DST, SRC, &AX);
>>                   DST = AX;
>>                   CONT;
>>           ALU_MOD_X:
>>                   AX = (u32) DST;
>>                   DST = do_div(AX, (u32) SRC);
>>                   CONT;
>>           ALU64_MOD_K:
>>                   div64_u64_rem(DST, IMM, &AX);
>>                   DST = AX;
>>                   CONT;
>>           ALU_MOD_K:
>>                   AX = (u32) DST;
>>                   DST = do_div(AX, (u32) IMM);
>>                   CONT;
>>
>> So in above phrasing the middle part needs to be adapted or just removed.
> 
> The phrasing was based on the earlier discussion on this list (see
> https://lore.kernel.org/bpf/CAADnVQJ387tWd7WgxqfoB44xMe17bY0RRp_Sng3xMnKsywFpxg@mail.gmail.com/) where
> Alexei wrote "imm32 is _sign_ extended everywhere",
> and I cited the div_k tests in lib/test_bpf.c that assume sign extension
> not zero extension.

`Where 'imm' is first sign extended to 64 bits and then converted to an unsigned
64-bit value` is true for the 64 bit operation, for the 32-bit it's just converted
to an unsigned 32-bit value, see the (u32)IMM which is (u32)(s32) insn->imm. From
the phrasing, it was a bit less clear perhaps.

Thanks,
Daniel
