Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540D858D072
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 01:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiHHXZX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 19:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiHHXZW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 19:25:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6982A6258
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 16:25:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k26so19355110ejx.5
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 16:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GKkTprBhPuCPHHHnb6WAlGgtQzVBAZdL/pEHv5Ea494=;
        b=TgHe9QXNoAtM5AHNr1Mt+nvcdZoeRZLj+Unc7QWWvKG72yQH1vHhvU2qpOM2BKVmNZ
         Cce5P83kZfqIJc6pD7+PSrVgNmhOrP0yYuTYjLgHZrikYd3+OJYJoRksq8j4IrDrIyii
         hnbhaAvjjo0he/vxGIYa9gS3PGtQqyK4hx1XPSvM8XrJvEHTSEJ6W1jOk6GK6XtqFQJ1
         luoJ/Ti7lqBIe4eD8n4qdtcFrqE4bCWisxgOBm08B44BSDvnwg8ZilICRTn4dRcJnApq
         ocpdLmp7PO6c08BFp+2WX86c8+jqcgHsbcVi5uoRJ6q7BQKKulajYwAGdpOTjNrE83t4
         ibmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GKkTprBhPuCPHHHnb6WAlGgtQzVBAZdL/pEHv5Ea494=;
        b=KbZnqEHBroWjq/EsXO1OQLjsQDm1YPX2+IB9/5XZViyPf37z9cIIncgT/25ZOgX1UD
         bzWMTNqtNKj7DsDa8ut5XEQD7N8yM9BdqI3nmTRmmaDb2o/oBqK7H8zFATE+lFs1YHD+
         GI59emzCIJzECFtirJ06f0MEJ7cnDIcfLgh/Zp+rYjPbY0ypFZpO753wY79Qlv5TatuK
         qFYYiui8ekp6m1OEOiiiVrwdUiqD8iEl3QyA5OkD1XJWdV41BttpgI6pKXYfJMUX/VTb
         RSjY800egtyWvVtcLLUjqkjCy6J6LQhAbgTZeut9o4QDua3ISfTNCrHTVdDAShm/ykGe
         WSpA==
X-Gm-Message-State: ACgBeo3y1YF2s44k08y9Iin+inC9MNd60+/SLeRWus7vBIL809ekHB8/
        HgSk4HFekm7tHWRjfb79mxYzMjBWj6pcGu7ZoSs=
X-Google-Smtp-Source: AA6agR5B0SUmELnfGiEULoNiSCejbfdSrlNK6CoqLru8wd4etZrM6AAdbbBJ9BK2O3wqGRKV5msE3z5zmYt/K7+7mbE=
X-Received: by 2002:a17:907:3d90:b0:730:a937:fb04 with SMTP id
 he16-20020a1709073d9000b00730a937fb04mr15568165ejc.176.1660001117957; Mon, 08
 Aug 2022 16:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220807175111.4178812-1-yhs@fb.com> <20220807175121.4179410-1-yhs@fb.com>
In-Reply-To: <20220807175121.4179410-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Aug 2022 16:25:06 -0700
Message-ID: <CAEf4BzaJydVpt+H6abR6udjcQ5Scu07W+LLQyo7jC9et9T=ZOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Perform necessary sign/zero extension
 for kfunc return values
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 7, 2022 at 10:51 AM Yonghong Song <yhs@fb.com> wrote:
>
> Tejun reported a bpf program kfunc return value mis-handling which
> may cause incorrect result. The following is an example to show
> the problem.
>   $ cat t.c
>   unsigned char bar();
>   int foo() {
>         if (bar() != 10) return 0; else return 1;
>   }
>   $ clang -target bpf -O2 -c t.c
>   $ llvm-objdump -d t.o
>   ...
>   0000000000000000 <foo>:
>        0:       85 10 00 00 ff ff ff ff call -1
>        1:       bf 01 00 00 00 00 00 00 r1 = r0
>        2:       b7 00 00 00 01 00 00 00 r0 = 1
>        3:       15 01 01 00 0a 00 00 00 if r1 == 10 goto +1 <LBB0_2>
>        4:       b7 00 00 00 00 00 00 00 r0 = 0
>
>   0000000000000028 <LBB0_2>:
>        5:       95 00 00 00 00 00 00 00 exit
>   $
>
> In the above example, the return type for bar() is 'unsigned char'.
> But in the disassembly code, the whole register 'r1' is used to
> compare to 10 without truncating upper 56 bits.
>
> If function bar() is implemented as a bpf function, everything
> should be okay since bpf ABI will make sure the caller do
> proper truncation of upper 56 bits.
>
> But if function bar() is implemented as a non-bpf kfunc,
> there could a mismatch between bar() implementation and bpf program.
> For example, if the host arch is x86_64, the bar() function
> may just put the return value in lower 8-bit subregister and all
> upper 56 bits could contain garbage. This is not a problem
> if bar() is called in x86_64 context as the caller will use
> %al to get the value.
>
> But this could be a problem if bar() is called in bpf context
> and there is a mismatch expectation between bpf and native architecture.
> Currently, bpf programs use the default llvm ABI ([1], function
> isPromotableIntegerTypeForABI()) such that if an integer type size
> is less than int type size, it is assumed proper sign or zero
> extension has been done to the return value. There will be a problem
> if the kfunc return value type is u8/s8/u16/s16.

Reading this I was still confused how (and whether) s32/u32 returns
are going to be handled correctly, especially on non-cpuv3 BPF object
code. So I played with this a bit and Clang does generate explicit <<
and >>/>>= shifts as expected. It might be worth it emphasizing that
for 32-bit returns Clang will generate explicit shifts?

>
> This patch intends to address this issue by doing proper sign or zero
> extension for the kfunc return value before it is used later.
>
>  [1] https://github.com/llvm/llvm-project/blob/main/clang/lib/CodeGen/TargetInfo.cpp
>
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf.h   |  2 ++
>  kernel/bpf/btf.c      |  9 +++++++++
>  kernel/bpf/verifier.c | 35 +++++++++++++++++++++++++++++++++--
>  3 files changed, 44 insertions(+), 2 deletions(-)
>

[...]
