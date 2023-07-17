Return-Path: <bpf+bounces-5098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9A57566C6
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8712813B2
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 14:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51820253BB;
	Mon, 17 Jul 2023 14:49:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3162A253AD
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 14:49:03 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B43FE45
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 07:49:01 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b73564e98dso68214761fa.3
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 07:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689605340; x=1692197340;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dBrce25jO1yG7ybVN5XwBjBWblxyUzo74dEqZlkU8a8=;
        b=T04zhRpixf9bR+hMKc4RF6DoTWkQ6EpDpg+coy1Fl0PUxOEjY57rMHDGghGfc+c6Lk
         e+uPCgTp9hwA+QLf2TktUO4V4tN9LMv4IuKfRo/LFOg2iIziYkBvs7jOclbpcADF059O
         MJVAxA1V2S2a4drTnigPHh0qvKu7LHd9TAlDiUu30tOSsGgyCgm/LvF9o8fNS8/AqCC+
         Qzif5lEh8ya9Sl2hzP01VFHt4jncoMX2WEW7NQBk/og21TqoXOiDfKDlp7pmm3uG0oMD
         oDlqIwHNPsjowrnarTaP17J6uyqPbocSDsB2NsB4L/hRtw3/RGTiYXY6jMjM8OJtTFUb
         Kvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689605340; x=1692197340;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBrce25jO1yG7ybVN5XwBjBWblxyUzo74dEqZlkU8a8=;
        b=GEBDjElQnr5XTy3SgIa6xHSlbU9U+0+rljprgUTIB4GW5OiJCzEWIe9bVakq0SrV5T
         N/eXxRsT5LZNdyT8QRH3wanwEyrgiQ+/wyxEb1tOAlEUbguT5YtFZuIFwmQi05AlU2B3
         nGL0DxAffrDk2PCnHIVaPVxWwFknacPvq2s8ly/w2Pq21gNjGNN6CWmxGPy5iHDpmnKg
         jxsQfPgRy6OicjkEjpUJ+AzLfEKIEoRBtYFMTWvlPCc/WrKfHiddq1tnLqYgeMGQgi7O
         sGUZQRNYsB2IpMCXdej8bNboeFsTsisLtZNX9vqypYpn501vKq8tb41bysH6POtG5qsN
         N6dQ==
X-Gm-Message-State: ABy/qLbro65jML3rlU8ercWN6SnMWzSyYNJEtEppa3mpbnPSra9w2L8X
	xVRR4BAEhgaqW5XPnu2SH2USomCL9yJqsIoC1mY=
X-Google-Smtp-Source: APBJJlF+0aqcQNCLN720eMRPTiCnDeInMvWwW3jY0SOKJ/bSzsiXrHt1axBEt7IUJ5j4EYz3cnHGhw==
X-Received: by 2002:a2e:9455:0:b0:2b6:ccd6:3eae with SMTP id o21-20020a2e9455000000b002b6ccd63eaemr8262357ljh.17.1689605339696;
        Mon, 17 Jul 2023 07:48:59 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s26-20020a7bc39a000000b003fa74bff02asm8208441wmj.26.2023.07.17.07.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:48:57 -0700 (PDT)
Date: Mon, 17 Jul 2023 17:48:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: imagedong@tencent.com
Cc: bpf@vger.kernel.org
Subject: [bug report] bpf, x86: allow function arguments up to 12 for TRACING
Message-ID: <09784025-a812-493f-9829-5e26c8691e07@moroto.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Menglong Dong,

The patch 473e3150e30a: "bpf, x86: allow function arguments up to 12
for TRACING" from Jul 13, 2023 (linux-next), leads to the following
Smatch static checker warning:

	arch/x86/net/bpf_jit_comp.c:1999 save_args()
	error: uninitialized symbol 'first_off'.

arch/x86/net/bpf_jit_comp.c
    1925 static void save_args(const struct btf_func_model *m, u8 **prog,
    1926                       int stack_size, bool for_call_origin)
    1927 {
    1928         int arg_regs, first_off, nr_regs = 0, nr_stack_slots = 0;
    1929         int i, j;
    1930 
    1931         /* Store function arguments to stack.
    1932          * For a function that accepts two pointers the sequence will be:
    1933          * mov QWORD PTR [rbp-0x10],rdi
    1934          * mov QWORD PTR [rbp-0x8],rsi
    1935          */
    1936         for (i = 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++) {
    1937                 arg_regs = (m->arg_size[i] + 7) / 8;
    1938 
    1939                 /* According to the research of Yonghong, struct members
    1940                  * should be all in register or all on the stack.
    1941                  * Meanwhile, the compiler will pass the argument on regs
    1942                  * if the remaining regs can hold the argument.
    1943                  *
    1944                  * Disorder of the args can happen. For example:
    1945                  *
    1946                  * struct foo_struct {
    1947                  *     long a;
    1948                  *     int b;
    1949                  * };
    1950                  * int foo(char, char, char, char, char, struct foo_struct,
    1951                  *         char);
    1952                  *
    1953                  * the arg1-5,arg7 will be passed by regs, and arg6 will
    1954                  * by stack.
    1955                  */
    1956                 if (nr_regs + arg_regs > 6) {

first_off is not set on else path.  It's also in a loop so maybe there
is some guarantee that we will hit an else path...

    1957                         /* copy function arguments from origin stack frame
    1958                          * into current stack frame.
    1959                          *
    1960                          * The starting address of the arguments on-stack
    1961                          * is:
    1962                          *   rbp + 8(push rbp) +
    1963                          *   8(return addr of origin call) +
    1964                          *   8(return addr of the caller)
    1965                          * which means: rbp + 24
    1966                          */
    1967                         for (j = 0; j < arg_regs; j++) {
    1968                                 emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
    1969                                          nr_stack_slots * 8 + 0x18);
    1970                                 emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
    1971                                          -stack_size);
    1972 
    1973                                 if (!nr_stack_slots)
    1974                                         first_off = stack_size;
    1975                                 stack_size -= 8;
    1976                                 nr_stack_slots++;
    1977                         }
    1978                 } else {
    1979                         /* Only copy the arguments on-stack to current
    1980                          * 'stack_size' and ignore the regs, used to
    1981                          * prepare the arguments on-stack for orign call.
    1982                          */
    1983                         if (for_call_origin) {
    1984                                 nr_regs += arg_regs;
    1985                                 continue;
    1986                         }
    1987 
    1988                         /* copy the arguments from regs into stack */
    1989                         for (j = 0; j < arg_regs; j++) {
    1990                                 emit_stx(prog, BPF_DW, BPF_REG_FP,
    1991                                          nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs,
    1992                                          -stack_size);
    1993                                 stack_size -= 8;
    1994                                 nr_regs++;
    1995                         }
    1996                 }
    1997         }
    1998 
--> 1999         clean_stack_garbage(m, prog, nr_stack_slots, first_off);
    2000 }

regards,
dan carpenter

