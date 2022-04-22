Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B958450B0CA
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 08:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbiDVGsH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 02:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444501AbiDVGsH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 02:48:07 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D5CDF69
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 23:45:13 -0700 (PDT)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23M6iprG004053;
        Fri, 22 Apr 2022 15:44:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Fri, 22 Apr 2022 15:44:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23M6ioGL004047
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Apr 2022 15:44:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d21e278f-a3ff-8603-f6ba-b51a8cddafa8@I-love.SAKURA.ne.jp>
Date:   Fri, 22 Apr 2022 15:44:50 +0900
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
 <27376147-9939-e1d6-650d-3c2d9599ec0c@I-love.SAKURA.ne.jp>
In-Reply-To: <27376147-9939-e1d6-650d-3c2d9599ec0c@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2022/04/21 20:15, Tetsuo Handa wrote:
>> I feel that amount of output above is too short for "char program[2053]".
>> How can TCP/IPv6 socket be created from this quite limited operations?
> 
> Since bpf_skb_load_helper_8() nothing but reads a byte, I don't think that
> bpf(BPF_PROG_LOAD) / setsockopt(SOL_SOCKET, SO_ATTACH_BPF) can affect this
> use-after-free bug, unless "char program[2053]" is doing something other
> than reading a byte.

It turned out that only first 37 bytes of "char program[2053]" was meaningful.

        const union bpf_attr attr = {
                .prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
                .insn_cnt = 5,
                .insns = (unsigned long long)
                "\xbf\x16\x00\x00\x00\x00\x00\x00\xb7\x07\x00\x00\x01\x00\xf0\xff"
                "\x50\x70\x00\x00\x00\x00\x00\x00\x30\x00\x00\x00\x00\x00\xc0\x00"
                "\x95\x00\x00\x00\x00",
                .license = (unsigned long long) "GPL",
        };

Thus, I think that the output of "tools/bpf/bpftool/bpftool prog dump xlat id $NUM"
was correct.

Moreover, it turned out that even no-op program which does only

	r0 = 0
	exit

can trigger this use-after-free bug.

        const union bpf_attr attr = {
                .prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
                .insn_cnt = 2,
                .insns = (unsigned long long) "\xb7\x00\x00\x00\x00\x00\x00\x00\x95\x00\x00\x00\x00\x00\x00\x00",
                .license = (unsigned long long) "GPL",
        };

That is, it seems that loading a BPF program using bpf(BPF_PROG_LOAD) and attaching
that program using setsockopt(SOL_SOCKET, SO_ATTACH_BPF) itself somehow affects this
use-after-free bug.

Now, I suspect that some refcount is taken by setsockopt(SOL_SOCKET, SO_ATTACH_BPF)
and is causing the socket to stay alive long enough to fire tcp_retransmit_timer().
Any ideas?

