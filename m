Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928494DDBD3
	for <lists+bpf@lfdr.de>; Fri, 18 Mar 2022 15:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbiCROmf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Mar 2022 10:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiCROmf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Mar 2022 10:42:35 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90BE72E1B
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 07:41:15 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nVDmx-0007Vt-4B; Fri, 18 Mar 2022 15:41:11 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nVDmw-000WIs-MF; Fri, 18 Mar 2022 15:41:10 +0100
Subject: Re: [PATCH bpf-next v4 3/4] bpf, arm64: adjust the offset of
 str/ldr(immediate) to positive number
To:     Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hou Tao <houtao1@huawei.com>, Fuad Tabba <tabba@google.com>,
        James Morse <james.morse@arm.com>
References: <20220317140243.212509-1-xukuohai@huawei.com>
 <20220317140243.212509-4-xukuohai@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b45a3be2-58f2-bbad-0ca2-32f3ffde130a@iogearbox.net>
Date:   Fri, 18 Mar 2022 15:41:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220317140243.212509-4-xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26485/Fri Mar 18 09:26:47 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/17/22 3:02 PM, Xu Kuohai wrote:
> The BPF STX/LDX instruction uses offset relative to the FP to address
> stack space. Since the BPF_FP locates at the top of the frame, the offset
> is usually a negative number. However, arm64 str/ldr immediate instruction
> requires that offset be a positive number.  Therefore, this patch tries to
> convert the offsets.
> 
> The method is to find the negative offset furthest from the FP firstly.
> Then add it to the FP, calculate a bottom position, called FPB, and then
> adjust the offsets in other STR/LDX instructions relative to FPB.
> 
> FPB is saved using the callee-saved register x27 of arm64 which is not
> used yet.
> 
> Before adjusting the offset, the patch checks every instruction to ensure
> that the FP does not change in run-time. If the FP may change, no offset
> is adjusted.
> 
> For example, for the following bpftrace command:
> 
>    bpftrace -e 'kprobe:do_sys_open { printf("opening: %s\n", str(arg1)); }'
> 
> Without this patch, jited code(fragment):
> 
>     0:   bti     c
>     4:   stp     x29, x30, [sp, #-16]!
>     8:   mov     x29, sp
>     c:   stp     x19, x20, [sp, #-16]!
>    10:   stp     x21, x22, [sp, #-16]!
>    14:   stp     x25, x26, [sp, #-16]!
>    18:   mov     x25, sp
>    1c:   mov     x26, #0x0                       // #0
>    20:   bti     j
>    24:   sub     sp, sp, #0x90
>    28:   add     x19, x0, #0x0
>    2c:   mov     x0, #0x0                        // #0
>    30:   mov     x10, #0xffffffffffffff78        // #-136
>    34:   str     x0, [x25, x10]
>    38:   mov     x10, #0xffffffffffffff80        // #-128
>    3c:   str     x0, [x25, x10]
>    40:   mov     x10, #0xffffffffffffff88        // #-120
>    44:   str     x0, [x25, x10]
>    48:   mov     x10, #0xffffffffffffff90        // #-112
>    4c:   str     x0, [x25, x10]
>    50:   mov     x10, #0xffffffffffffff98        // #-104
>    54:   str     x0, [x25, x10]
>    58:   mov     x10, #0xffffffffffffffa0        // #-96
>    5c:   str     x0, [x25, x10]
>    60:   mov     x10, #0xffffffffffffffa8        // #-88
>    64:   str     x0, [x25, x10]
>    68:   mov     x10, #0xffffffffffffffb0        // #-80
>    6c:   str     x0, [x25, x10]
>    70:   mov     x10, #0xffffffffffffffb8        // #-72
>    74:   str     x0, [x25, x10]
>    78:   mov     x10, #0xffffffffffffffc0        // #-64
>    7c:   str     x0, [x25, x10]
>    80:   mov     x10, #0xffffffffffffffc8        // #-56
>    84:   str     x0, [x25, x10]
>    88:   mov     x10, #0xffffffffffffffd0        // #-48
>    8c:   str     x0, [x25, x10]
>    90:   mov     x10, #0xffffffffffffffd8        // #-40
>    94:   str     x0, [x25, x10]
>    98:   mov     x10, #0xffffffffffffffe0        // #-32
>    9c:   str     x0, [x25, x10]
>    a0:   mov     x10, #0xffffffffffffffe8        // #-24
>    a4:   str     x0, [x25, x10]
>    a8:   mov     x10, #0xfffffffffffffff0        // #-16
>    ac:   str     x0, [x25, x10]
>    b0:   mov     x10, #0xfffffffffffffff8        // #-8
>    b4:   str     x0, [x25, x10]
>    b8:   mov     x10, #0x8                       // #8
>    bc:   ldr     x2, [x19, x10]
>    [...]
> 
> With this patch, jited code(fragment):
> 
>     0:   bti     c
>     4:   stp     x29, x30, [sp, #-16]!
>     8:   mov     x29, sp
>     c:   stp     x19, x20, [sp, #-16]!
>    10:   stp     x21, x22, [sp, #-16]!
>    14:   stp     x25, x26, [sp, #-16]!
>    18:   stp     x27, x28, [sp, #-16]!
>    1c:   mov     x25, sp
>    20:   sub     x27, x25, #0x88
>    24:   mov     x26, #0x0                       // #0
>    28:   bti     j
>    2c:   sub     sp, sp, #0x90
>    30:   add     x19, x0, #0x0
>    34:   mov     x0, #0x0                        // #0
>    38:   str     x0, [x27]
>    3c:   str     x0, [x27, #8]
>    40:   str     x0, [x27, #16]
>    44:   str     x0, [x27, #24]
>    48:   str     x0, [x27, #32]
>    4c:   str     x0, [x27, #40]
>    50:   str     x0, [x27, #48]
>    54:   str     x0, [x27, #56]
>    58:   str     x0, [x27, #64]
>    5c:   str     x0, [x27, #72]
>    60:   str     x0, [x27, #80]
>    64:   str     x0, [x27, #88]
>    68:   str     x0, [x27, #96]
>    6c:   str     x0, [x27, #104]
>    70:   str     x0, [x27, #112]
>    74:   str     x0, [x27, #120]
>    78:   str     x0, [x27, #128]
>    7c:   ldr     x2, [x19, #8]
>    [...]
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Could you elaborate how this works across tail calls / bpf2bpf calls? Could we
run into a situation where is_lsi_offset() on off_adj doesn't hold true anymore
and we ended up emitting e.g. STR32I instead of MOV_I+STR32?

Thanks,
Daniel
