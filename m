Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980BE407499
	for <lists+bpf@lfdr.de>; Sat, 11 Sep 2021 04:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbhIKCRp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 22:17:45 -0400
Received: from mail.loongson.cn ([114.242.206.163]:58700 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231864AbhIKCRo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 22:17:44 -0400
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxNeVnETxhUBEEAA--.12974S3;
        Sat, 11 Sep 2021 10:16:08 +0800 (CST)
Subject: Re: [PATCH bpf-next] bpf, selftests: Replicate tailcall limit test
 for indirect call case
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
References: <20210910091900.16119-1-daniel@iogearbox.net>
Cc:     alexei.starovoitov@gmail.com, andrii@kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Paul Chaignon <paul@cilium.io>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <955d6907-7abe-fb3f-5225-8711974818c7@loongson.cn>
Date:   Sat, 11 Sep 2021 10:16:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20210910091900.16119-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxNeVnETxhUBEEAA--.12974S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAryfWrW3JF47JF47tFyxKrg_yoW5ZF48pr
        9xXw1Y9rWkZ345AF42gw40gF98AFWDAFyDJw1rC3sxAF4kury2gF4jkFy8CFyYkr1Yqa4j
        qwn7Zr18t3Z5CaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU5DOzDUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09/10/2021 05:19 PM, Daniel Borkmann wrote:
> The tailcall_3 test program uses bpf_tail_call_static() where the JIT
> would patch a direct jump. Add a new tailcall_6 test program replicating
> exactly the same test just ensuring that bpf_tail_call() uses a map
> index where the verifier cannot make assumptions this time.
>
> In other words, this will now cover both on x86-64 JIT, meaning, JIT
> images with emit_bpf_tail_call_direct() emission as well as JIT images
> with emit_bpf_tail_call_indirect() emission.
>
>    # echo 1 > /proc/sys/net/core/bpf_jit_enable
>    # ./test_progs -t tailcalls
>    #136/1 tailcalls/tailcall_1:OK
>    #136/2 tailcalls/tailcall_2:OK
>    #136/3 tailcalls/tailcall_3:OK
>    #136/4 tailcalls/tailcall_4:OK
>    #136/5 tailcalls/tailcall_5:OK
>    #136/6 tailcalls/tailcall_6:OK
>    #136/7 tailcalls/tailcall_bpf2bpf_1:OK
>    #136/8 tailcalls/tailcall_bpf2bpf_2:OK
>    #136/9 tailcalls/tailcall_bpf2bpf_3:OK
>    #136/10 tailcalls/tailcall_bpf2bpf_4:OK
>    #136/11 tailcalls/tailcall_bpf2bpf_5:OK
>    #136 tailcalls:OK
>    Summary: 1/11 PASSED, 0 SKIPPED, 0 FAILED
>
>    # echo 0 > /proc/sys/net/core/bpf_jit_enable
>    # ./test_progs -t tailcalls
>    #136/1 tailcalls/tailcall_1:OK
>    #136/2 tailcalls/tailcall_2:OK
>    #136/3 tailcalls/tailcall_3:OK
>    #136/4 tailcalls/tailcall_4:OK
>    #136/5 tailcalls/tailcall_5:OK
>    #136/6 tailcalls/tailcall_6:OK
>    [...]
>
> For interpreter, the tailcall_1-6 tests are passing as well. The later
> tailcall_bpf2bpf_* are failing due lack of bpf2bpf + tailcall support
> in interpreter, so this is expected.
>
> Also, manual inspection shows that both loaded programs from tailcall_3
> and tailcall_6 test case emit the expected opcodes:
>
> * tailcall_3 disasm, emit_bpf_tail_call_direct():
>
>    [...]
>     b:   push   %rax
>     c:   push   %rbx
>     d:   push   %r13
>     f:   mov    %rdi,%rbx
>    12:   movabs $0xffff8d3f5afb0200,%r13
>    1c:   mov    %rbx,%rdi
>    1f:   mov    %r13,%rsi
>    22:   xor    %edx,%edx                 _
>    24:   mov    -0x4(%rbp),%eax          |  limit check
>    2a:   cmp    $0x20,%eax               |
>    2d:   ja     0x0000000000000046       |
>    2f:   add    $0x1,%eax                |
>    32:   mov    %eax,-0x4(%rbp)          |_
>    38:   nopl   0x0(%rax,%rax,1)
>    3d:   pop    %r13
>    3f:   pop    %rbx
>    40:   pop    %rax
>    41:   jmpq   0xffffffffffffe377
>    [...]
>
> * tailcall_6 disasm, emit_bpf_tail_call_indirect():
>
>    [...]
>    47:   movabs $0xffff8d3f59143a00,%rsi
>    51:   mov    %edx,%edx
>    53:   cmp    %edx,0x24(%rsi)
>    56:   jbe    0x0000000000000093        _
>    58:   mov    -0x4(%rbp),%eax          |  limit check
>    5e:   cmp    $0x20,%eax               |
>    61:   ja     0x0000000000000093       |
>    63:   add    $0x1,%eax                |
>    66:   mov    %eax,-0x4(%rbp)          |_
>    6c:   mov    0x110(%rsi,%rdx,8),%rcx
>    74:   test   %rcx,%rcx
>    77:   je     0x0000000000000093
>    79:   pop    %rax
>    7a:   mov    0x30(%rcx),%rcx
>    7e:   add    $0xb,%rcx
>    82:   callq  0x000000000000008e
>    87:   pause
>    89:   lfence
>    8c:   jmp    0x0000000000000087
>    8e:   mov    %rcx,(%rsp)
>    92:   retq
>    [...]
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Johan Almbladh <johan.almbladh@anyfinetworks.com>
> Cc: Paul Chaignon <paul@cilium.io>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Link: https://lore.kernel.org/bpf/CAM1=_QRyRVCODcXo_Y6qOm1iT163HoiSj8U2pZ8Rj3hzMTT=HQ@mail.gmail.com

Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>

