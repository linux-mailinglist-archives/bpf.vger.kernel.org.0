Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35E8609FC0
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 13:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJXLGr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 07:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiJXLGd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 07:06:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8CF437FD
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 04:05:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so9675821wme.5
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 04:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aw7WbTvGAIb2gp+FLC2H3n+l9YTdw9JJHZNLme8cLlA=;
        b=IH8CZe9hucReNXpkVjoOwPItWWH9DFuScoskZLTvPY1EO+I8c6Ige9nSnoV20JKOJc
         pHbSDrNYdF8nKchXXIs4On1l0NXNI9IO6UXhcUhIYKmigvq3q5/WQvebYcorZsWjNn2y
         XnCpgXJ/5MKlCxCFgN1znJD66DFS/GMra+gZ4ry3XQy57O9MRiDJNMeaNQBGXwvdg1TO
         VaQLxzfnIAY1WCdsfY/x2iTpHtd5omneL6d21EZj+gSA3pEtmBdv7wKICplPwkOrKuiV
         NB32MDpfKoRXfC185SMf9rGp20L99eUPjDq/Hcuod+mxWSDMUzbxbMLQC0Ifg1Rk+9wn
         mZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aw7WbTvGAIb2gp+FLC2H3n+l9YTdw9JJHZNLme8cLlA=;
        b=2QRoHqVny58MZvI/3gLcqjMHYu+kTL7AFBOWSNsSOA6fQPyv3XFQ6Ek2XLqoEbim5s
         GnUDOA7F9gBPjW5z3MaHesr9orB8DuYlqhH2koEkA5Gmpq2e9MtAhwoWJfWHhgcwakYt
         7XxV7Alf+JglSvOKZnVKVeiADSFqYMQlM66J0uT+Mpr327H05WFyOnt+46jLDBY2Yv4Z
         WonMmCmVdlr1jJyxvRT4ubp2q7HVuoKowyfJmXAz/ogqx9KaL1tyZDZTsrwceYsyHIFF
         5/fELd7Paatl4AzCkTrpySU/uKesj3BuyjkQilDeAORrmIzLR0VyF8+88dDml34xdWTu
         1tEg==
X-Gm-Message-State: ACrzQf36c8CgNhBBKT/vFXgI/ssPPCexLOr1WLEYQHvieQRgQBqZ4o8K
        +h/uqEnaDQSnlXkYl7gmYXS64g==
X-Google-Smtp-Source: AMsMyM6zq0XGfJWFuW5Ugg6wDPyQ6b/btP/NNAZi3GGzIGqaCqw022pXYYo5L/zSHQ4sshHg4pMmnA==
X-Received: by 2002:a05:600c:1906:b0:3c6:f154:d4b5 with SMTP id j6-20020a05600c190600b003c6f154d4b5mr21745102wmq.94.1666609531111;
        Mon, 24 Oct 2022 04:05:31 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id i18-20020a5d5232000000b00236576c8eddsm8241168wra.12.2022.10.24.04.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 04:05:30 -0700 (PDT)
Message-ID: <1dc2c77a-2dea-25a4-fa64-b65460c7f1cb@isovalent.com>
Date:   Mon, 24 Oct 2022 12:05:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v3 6/8] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
Content-Language: en-GB
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
References: <20221020123704.91203-1-quentin@isovalent.com>
 <20221020123704.91203-7-quentin@isovalent.com>
 <CAADnVQKHk88YFcTE55GXu7HwQkTb0TGNpnrB8Ec7PVZy9uVhOw@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAADnVQKHk88YFcTE55GXu7HwQkTb0TGNpnrB8Ec7PVZy9uVhOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-10-20 10:49 UTC-0700 ~ Alexei Starovoitov
<alexei.starovoitov@gmail.com>
> On Thu, Oct 20, 2022 at 5:37 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> +
>> +/* This callback to set the ref_type is necessary to have the LLVM disassembler
>> + * print PC-relative addresses instead of byte offsets for branch instruction
>> + * targets.
>> + */
>> +static const char *
>> +symbol_lookup_callback(__maybe_unused void *disasm_info,
>> +                      __maybe_unused uint64_t ref_value,
>> +                      uint64_t *ref_type, __maybe_unused uint64_t ref_PC,
>> +                      __maybe_unused const char **ref_name)
>> +{
>> +       *ref_type = LLVMDisassembler_ReferenceType_InOut_None;
>> +       return NULL;
>> +}
> 
> Could you give an example before/after for asm
> that contains 'call foo' instructions?
> I'm not sure that above InOut_None will not break
> symbolization.

Hi Alexei, I ran a quick test and it doesn't seem we lose any
information. Building from:

	#include <linux/bpf.h>
	#include "bpf_helper_defs.h"

	#define SEC(name) __attribute__((section(name), used))

	static __attribute__((noinline))
	int bar(int b) {
		return bpf_get_prandom_u32() > b;
	}

	SEC("xdp")
	int foo(struct xdp_md *ctx) {
		void *data = (void *)(long)ctx->data;
		void *data_end = (void *)(long)ctx->data_end;

		return bar(data_end - data);
	}

Here is the output from the existing version (using libbfd):

	# bpftool version
	bpftool v7.1.0
	using libbpf v1.1
	features: libbfd, libbpf_strict, skeletons

	# bpftool prog dump jited name foo
	int foo(struct xdp_md * ctx):
	bpf_prog_65e359e7b0251046_foo:
	; void *data = (void *)(long)ctx->data;
	   0:   nopl   0x0(%rax,%rax,1)
	   5:   xchg   %ax,%ax
	   7:   push   %rbp
	   8:   mov    %rsp,%rbp
	   b:   mov    0x0(%rdi),%rsi
	; void *data_end = (void *)(long)ctx->data_end;
	   f:   mov    0x8(%rdi),%rdi
	; return bar(data_end - data);
	  13:   sub    %esi,%edi
	; return bar(data_end - data);
	  15:   call   0x0000000000000038
	; return bar(data_end - data);
	  1a:   leave
	  1b:   ret

	int bar(int b):
	bpf_prog_9b001d67a67f01cc_bar:
	; int bar(int b) {
	   0:   nopl   0x0(%rax,%rax,1)
	   5:   xchg   %ax,%ax
	   7:   push   %rbp
	   8:   mov    %rsp,%rbp
	   b:   push   %rbx
	   c:   mov    %edi,%ebx
	; return bpf_get_prandom_u32() > b;
	   e:   call   0xffffffffcab00454
	  13:   mov    %eax,%edi
	  15:   mov    $0x1,%eax
	; return bpf_get_prandom_u32() > b;
	  1a:   cmp    %ebx,%edi
	  1c:   ja     0x0000000000000020
	  1e:   xor    %eax,%eax
	; return bpf_get_prandom_u32() > b;
	  20:   pop    %rbx
	  21:   leave
	  22:   ret

Did you expect "bar" to appear on insn '15:'? I don't think we get this
from bpftool at the moment? Or did I misunderstand your question?

The output from LLVM's disassembler comes below:

	# ./bpftool version
	bpftool v7.1.0
	using libbpf v1.1
	features: llvm, libbpf_strict, skeletons

	# ./bpftool prog dump jited name foo
	int foo(struct xdp_md * ctx):
	bpf_prog_65e359e7b0251046_foo:
	; void *data = (void *)(long)ctx->data;
	   0:   nopl    (%rax,%rax)
	   5:   nop
	   7:   pushq   %rbp
	   8:   movq    %rsp, %rbp
	   b:   movq    (%rdi), %rsi
	; void *data_end = (void *)(long)ctx->data_end;
	   f:   movq    8(%rdi), %rdi
	; return bar(data_end - data);
	  13:   subl    %esi, %edi
	; return bar(data_end - data);
	  15:   callq   0x38
	; return bar(data_end - data);
	  1a:   leave
	  1b:   retq

	int bar(int b):
	bpf_prog_9b001d67a67f01cc_bar:
	; int bar(int b) {
	   0:   nopl    (%rax,%rax)
	   5:   nop
	   7:   pushq   %rbp
	   8:   movq    %rsp, %rbp
	   b:   pushq   %rbx
	   c:   movl    %edi, %ebx
	; return bpf_get_prandom_u32() > b;
	   e:   callq   0xffffffffcab00454
	  13:   movl    %eax, %edi
	  15:   movl    $1, %eax
	; return bpf_get_prandom_u32() > b;
	  1a:   cmpl    %ebx, %edi
	  1c:   ja      0x20
	  1e:   xorl    %eax, %eax
	; return bpf_get_prandom_u32() > b;
	  20:   popq    %rbx
	  21:   leave
	  22:   retq

LLVM, but _without_ the LLVMDisassembler_ReferenceType_InOut_None:

	int foo(struct xdp_md * ctx):
	bpf_prog_65e359e7b0251046_foo:
	; void *data = (void *)(long)ctx->data;
	   0:   nopl    (%rax,%rax)
	   5:   nop
	   7:   pushq   %rbp
	   8:   movq    %rsp, %rbp
	   b:   movq    (%rdi), %rsi
	; void *data_end = (void *)(long)ctx->data_end;
	   f:   movq    8(%rdi), %rdi
	; return bar(data_end - data);
	  13:   subl    %esi, %edi
	; return bar(data_end - data);
	  15:   callq   30
	; return bar(data_end - data);
	  1a:   leave
	  1b:   retq

	int bar(int b):
	bpf_prog_9b001d67a67f01cc_bar:
	; int bar(int b) {
	   0:   nopl    (%rax,%rax)
	   5:   nop
	   7:   pushq   %rbp
	   8:   movq    %rsp, %rbp
	   b:   pushq   %rbx
	   c:   movl    %edi, %ebx
	; return bpf_get_prandom_u32() > b;
	   e:   callq   -894434239
	  13:   movl    %eax, %edi
	  15:   movl    $1, %eax
	; return bpf_get_prandom_u32() > b;
	  1a:   cmpl    %ebx, %edi
	  1c:   ja      2
	  1e:   xorl    %eax, %eax
	; return bpf_get_prandom_u32() > b;
	  20:   popq    %rbx
	  21:   leave
	  22:   retq

