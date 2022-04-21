Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890D5509E64
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 13:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358982AbiDULSf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 07:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiDULSd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 07:18:33 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D186C15A20
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 04:15:43 -0700 (PDT)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23LBFIZx057604;
        Thu, 21 Apr 2022 20:15:19 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Thu, 21 Apr 2022 20:15:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23LBFC7R057556
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 21 Apr 2022 20:15:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <27376147-9939-e1d6-650d-3c2d9599ec0c@I-love.SAKURA.ne.jp>
Date:   Thu, 21 Apr 2022 20:15:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: How to disassemble a BPF program?
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <4ed4a01e-3d1e-bf1e-803a-608df187bde5@I-love.SAKURA.ne.jp>
 <909c72b6-83f9-69a0-af80-d9cb3bc2bd0e@I-love.SAKURA.ne.jp>
 <CAEf4Bzbugg4dy_2J=cFKYYQEJx-irF-cRZvkkwCx4QQwXm5OpA@mail.gmail.com>
 <e6f25385-c5d0-f56e-27e8-1e2fd2378755@I-love.SAKURA.ne.jp>
In-Reply-To: <e6f25385-c5d0-f56e-27e8-1e2fd2378755@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2022/04/21 16:17, Tetsuo Handa wrote:
> Also, I tried to find what bpf_skb_load_helper_8_no_cache() is doing
> but I couldn't find the implementation of ____bpf_skb_load_helper_8().
> Where is ____bpf_skb_load_helper_8() defined?
> 
> ----------------------------------------
> BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
>            int, offset)
> {
>         return ____bpf_skb_load_helper_8(skb, skb->data, skb->len - skb->data_len,
>                                          offset);
> }
> ----------------------------------------
> 

Ah, OK. Since BPF_CALL_x macro defines

        static __always_inline                                                 \
        u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__))

, BPF_CALL_4(bpf_skb_load_helper_8) will define

	static __always_inline u64 ____bpf_skb_load_helper_8()

for to be called from BPF_CALL_2(bpf_skb_load_helper_8_no_cache).

> I feel that amount of output above is too short for "char program[2053]".
> How can TCP/IPv6 socket be created from this quite limited operations?

Since bpf_skb_load_helper_8() nothing but reads a byte, I don't think that
bpf(BPF_PROG_LOAD) / setsockopt(SOL_SOCKET, SO_ATTACH_BPF) can affect this
use-after-free bug, unless "char program[2053]" is doing something other
than reading a byte.
