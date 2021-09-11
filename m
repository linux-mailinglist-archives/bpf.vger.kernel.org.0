Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE9D4075B6
	for <lists+bpf@lfdr.de>; Sat, 11 Sep 2021 11:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhIKJQM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Sep 2021 05:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhIKJQL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Sep 2021 05:16:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A6BC061574
        for <bpf@vger.kernel.org>; Sat, 11 Sep 2021 02:14:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v5so6153422edc.2
        for <bpf@vger.kernel.org>; Sat, 11 Sep 2021 02:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Owb6Qwg9POi/ZZrGuwIBbbTGdJaosmhAKP8pHqSlahw=;
        b=ySexJISCW8MrRGvNMca4jBmqcyINEIpkss83Io4jv1/dS1v8bYLrn9y/GTA1IA6yHI
         mY1GeHXleQgP6AadAFz5VzgtvoJsoHeFiAvpvFiIPQIQWocYciqJCMe+GkUHa5SBQzr+
         SxVhoLOSOKOt0GEjdrx5vDv8dU3WS+lFHNdNbUBKJf+W3sLhNicrkZSAdcav0QqYkOrE
         RPjs72mbp2ffcJKCA6vBw2XFhva0/oVCGQL13dV5JTNpeBYrLmeNN68FtdUUFgjkjIyy
         Oyja8dLExjN6xPImX/HUfhhlek8OiLd1q+oODaKowwi2meb8SZhDyVeA3XBDAzFE9PGz
         E5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Owb6Qwg9POi/ZZrGuwIBbbTGdJaosmhAKP8pHqSlahw=;
        b=QBsimSFR9HO8tYm9FmM8aW423Z8KJZmagRSwfj55hljygb4Gq6d6xjmK6lev9ib4jw
         j7DI1wQooGnJ22hKc6hF0/K0HXAxxwl8NFZm3vWUjR9a1vwMSHOpAayURV2u6SrJNqWu
         E5OBzvkil90QOng4SWJTzoG9R34SuKCNgjzY0bosY7tiXAWt61O1Bx/uyxrVQkhwmCtW
         q1M7YQsxgh3p+AsJro6HywQKitkaCQJsAGsRWuIiKMIbq00gqlUKU1KW63VXZZWmy6dt
         Mel9r/X73IE4dgllamXQImko5v7KqR8Ga3gNPeKrMAEDg6ClQd/xtfMIwOXHFy/fHn4G
         7BKQ==
X-Gm-Message-State: AOAM530b32DxMxEBF2rXbHRFSG1Sxz2/+xf/tlWWqI0BV8EBi+deog0a
        vGYDVfPaDuJOOR4oZXiMr/Js
X-Google-Smtp-Source: ABdhPJyJKdN7dwaLcZxzbtuzdfyNDPj2SWQ6vA1EANYldVf3UA5lo3X+RIBiLVMZzmJnX8o7nLtIlA==
X-Received: by 2002:a05:6402:4cd:: with SMTP id n13mr2339360edw.215.1631351698120;
        Sat, 11 Sep 2021 02:14:58 -0700 (PDT)
Received: from Mem ([2a02:a210:a823:400:8047:f6b:24a1:d0ac])
        by smtp.gmail.com with ESMTPSA id js21sm506208ejc.35.2021.09.11.02.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 02:14:57 -0700 (PDT)
Date:   Sat, 11 Sep 2021 11:14:55 +0200
From:   Paul Chaignon <paul@cilium.io>
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, alexei.starovoitov@gmail.com,
        Andrii Nakryiko <andrii@kernel.org>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH bpf-next] bpf, selftests: Replicate tailcall limit test
 for indirect call case
Message-ID: <CAHMuVODpACoTY2DxzkTxxJsww7qaiCmFkr+aGPsXiooxzuKnzw@mail.gmail.com>
References: <20210910091900.16119-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910091900.16119-1-daniel@iogearbox.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 10, 2021 at 11:19:00AM +0200, Daniel Borkmann wrote:
> The tailcall_3 test program uses bpf_tail_call_static() where the JIT
> would patch a direct jump. Add a new tailcall_6 test program replicating
> exactly the same test just ensuring that bpf_tail_call() uses a map
> index where the verifier cannot make assumptions this time.
>
> In other words, this will now cover both on x86-64 JIT, meaning, JIT
> images with emit_bpf_tail_call_direct() emission as well as JIT images
> with emit_bpf_tail_call_indirect() emission.
>
>   # echo 1 > /proc/sys/net/core/bpf_jit_enable
>   # ./test_progs -t tailcalls
>   #136/1 tailcalls/tailcall_1:OK
>   #136/2 tailcalls/tailcall_2:OK
>   #136/3 tailcalls/tailcall_3:OK
>   #136/4 tailcalls/tailcall_4:OK
>   #136/5 tailcalls/tailcall_5:OK
>   #136/6 tailcalls/tailcall_6:OK
>   #136/7 tailcalls/tailcall_bpf2bpf_1:OK
>   #136/8 tailcalls/tailcall_bpf2bpf_2:OK
>   #136/9 tailcalls/tailcall_bpf2bpf_3:OK
>   #136/10 tailcalls/tailcall_bpf2bpf_4:OK
>   #136/11 tailcalls/tailcall_bpf2bpf_5:OK
>   #136 tailcalls:OK
>   Summary: 1/11 PASSED, 0 SKIPPED, 0 FAILED
>
>   # echo 0 > /proc/sys/net/core/bpf_jit_enable
>   # ./test_progs -t tailcalls
>   #136/1 tailcalls/tailcall_1:OK
>   #136/2 tailcalls/tailcall_2:OK
>   #136/3 tailcalls/tailcall_3:OK
>   #136/4 tailcalls/tailcall_4:OK
>   #136/5 tailcalls/tailcall_5:OK
>   #136/6 tailcalls/tailcall_6:OK
>   [...]
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
>   [...]
>    b:   push   %rax
>    c:   push   %rbx
>    d:   push   %r13
>    f:   mov    %rdi,%rbx
>   12:   movabs $0xffff8d3f5afb0200,%r13
>   1c:   mov    %rbx,%rdi
>   1f:   mov    %r13,%rsi
>   22:   xor    %edx,%edx                 _
>   24:   mov    -0x4(%rbp),%eax          |  limit check
>   2a:   cmp    $0x20,%eax               |
>   2d:   ja     0x0000000000000046       |
>   2f:   add    $0x1,%eax                |
>   32:   mov    %eax,-0x4(%rbp)          |_
>   38:   nopl   0x0(%rax,%rax,1)
>   3d:   pop    %r13
>   3f:   pop    %rbx
>   40:   pop    %rax
>   41:   jmpq   0xffffffffffffe377
>   [...]
>
> * tailcall_6 disasm, emit_bpf_tail_call_indirect():
>
>   [...]
>   47:   movabs $0xffff8d3f59143a00,%rsi
>   51:   mov    %edx,%edx
>   53:   cmp    %edx,0x24(%rsi)
>   56:   jbe    0x0000000000000093        _
>   58:   mov    -0x4(%rbp),%eax          |  limit check
>   5e:   cmp    $0x20,%eax               |
>   61:   ja     0x0000000000000093       |
>   63:   add    $0x1,%eax                |
>   66:   mov    %eax,-0x4(%rbp)          |_
>   6c:   mov    0x110(%rsi,%rdx,8),%rcx
>   74:   test   %rcx,%rcx
>   77:   je     0x0000000000000093
>   79:   pop    %rax
>   7a:   mov    0x30(%rcx),%rcx
>   7e:   add    $0xb,%rcx
>   82:   callq  0x000000000000008e
>   87:   pause
>   89:   lfence
>   8c:   jmp    0x0000000000000087
>   8e:   mov    %rcx,(%rsp)
>   92:   retq
>   [...]
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Johan Almbladh <johan.almbladh@anyfinetworks.com>
> Cc: Paul Chaignon <paul@cilium.io>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Link: https://lore.kernel.org/bpf/CAM1=_QRyRVCODcXo_Y6qOm1iT163HoiSj8U2pZ8Rj3hzMTT=HQ@mail.gmail.com

Acked-by: Paul Chaignon <paul@cilium.io>
