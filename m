Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8691603256
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 20:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJRSYP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 14:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiJRSXr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 14:23:47 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBA588DD4
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 11:23:23 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 126-20020a630284000000b0043942ef3ac7so8479654pgc.11
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQmq9UzNO8/vpVEaRPhIfDjBEjrQBce6+yHluipsWs8=;
        b=iOz4xb6iC2gHx1KFSZp9OpL8tO7q9fl+7BL5RAeSEv2WTiyOwwLwp1/uEFZs2SkMC/
         Fcg1V2Pkyv7hVH+Z6FKwXEd6Ms34hV+yS7Pe8pkdNJdu661oAIpV2PikS8T+xxJtB7HR
         LEcIfGzZqhzZULKDwi7Ll8tY8A8rw9dHXClwiDQ0Q/6rTCwbG+XH9AQ7+SA8pwsGUi8t
         Z5JA5mz+7Dw1sX3zwdC+bYDsFWZfJ2pUQJExBYC33hxDxX8Ik+fEfuDIDRrYmcQRZ6DY
         XYDU/XWd+4/u9XBFScmVwOFJYkMidPsriTo+mvG+FaKV5ifKTOcZNc6otEMcKVJc7hjt
         iu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQmq9UzNO8/vpVEaRPhIfDjBEjrQBce6+yHluipsWs8=;
        b=cKdMrweEyKonlE6kvjQHbHu0ZhEbZDWt0TFo8PeYz73P0MeldOKO37qzmkB4s4sLQ9
         v5lKv3LHxDlalrW8eb7SqMZaUy2lAnjIXKeT6PnVTrRpSIvVhjj+QBuf44jDuyLvckvi
         CqDdC2r2WQCSFjuWrgoHDp9QP9wSHqOKtQqvBxdFYeaoPe/+RKXuEDleZjRldJ19b1jW
         87fZ7c8KwE5FnGhGi88d0AgbiC29OQB8kr7M/5XdWVSUAgBjyG6+4e+XfCV9fKS90Oyi
         Mq4/iGkTj3op66O1SlRwBtrLza9jbbOWUyyXCVkVYJoVDv9XblqIdxizKD5hVg2BRuKQ
         s0EQ==
X-Gm-Message-State: ACrzQf361ammc0Ybs9c1DiXXRPzfyDDRAHyZ7b+9vRN8RnB18FQajEtl
        uFcnAjf2WWnYl1Z8Q3Xv3Wbj/lU=
X-Google-Smtp-Source: AMsMyM7/nYZh0LdADEN+Racs+MemJDU1EWmwxhvm2vIczehsYmVIbpMTrReEUwhaO1TWM4T0PlXqEZA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:2305:b0:565:60b0:40d9 with SMTP id
 h5-20020a056a00230500b0056560b040d9mr4480046pfh.77.1666117403213; Tue, 18 Oct
 2022 11:23:23 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:23:21 -0700
In-Reply-To: <20221018122708.823792-1-jolsa@kernel.org>
Mime-Version: 1.0
References: <20221018122708.823792-1-jolsa@kernel.org>
Message-ID: <Y07vGVPIf913gND8@google.com>
Subject: Re: [PATCH] x86: Include asm/ptrace.h in syscall_wrapper header
From:   sdf@google.com
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Akihiro HARAI <jharai0815@gmail.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/18, Jiri Olsa wrote:
> From: Jiri Olsa <olsajiri@gmail.com>

> With just the forward declaration of the 'struct pt_regs' in
> syscall_wrapper.h, the syscall stub functions:

>    __[x64|ia32]_sys_*(struct pt_regs *regs)

> will have different definition of 'regs' argument in BTF data
> based on which object file they are defined in.

> If the syscall's object includes 'struct pt_regs' definition,
> the BTF argument data will point to 'struct pt_regs' record,
> like:

>    [226] STRUCT 'pt_regs' size=168 vlen=21
>           'r15' type_id=1 bits_offset=0
>           'r14' type_id=1 bits_offset=64
>           'r13' type_id=1 bits_offset=128
>    ...

> If not, it will point to fwd declaration record:

>    [15439] FWD 'pt_regs' fwd_kind=struct

> and make bpf tracing program hooking on those functions unable
> to access fields from 'struct pt_regs'.

Is the core issue here is that we can't / don't resolve FWD declarations
at load time (or dedup time)? I'm assuming 'struct pt_regs' is still
exposed somewhere in BTF via some other obj file, it's just those
syscall definitions that have FWD decl?

Applying this patch seems fine for now, but also seems fragile. Should
we instead/also teach verifier/dedup/whatever to resolve those FWD
declarations?

> Including asm/ptrace.h directly in syscall_wrapper.h to make
> sure all syscalls see 'struct pt_regs' definition and resulted
> BTF for '__*_sys_*(struct pt_regs *regs)' functions point to
> actual struct, not just forward declaration.

> Reported-by: Akihiro HARAI <jharai0815@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>   arch/x86/include/asm/syscall_wrapper.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/arch/x86/include/asm/syscall_wrapper.h  
> b/arch/x86/include/asm/syscall_wrapper.h
> index 59358d1bf880..fd2669b1cb2d 100644
> --- a/arch/x86/include/asm/syscall_wrapper.h
> +++ b/arch/x86/include/asm/syscall_wrapper.h
> @@ -6,7 +6,7 @@
>   #ifndef _ASM_X86_SYSCALL_WRAPPER_H
>   #define _ASM_X86_SYSCALL_WRAPPER_H

> -struct pt_regs;
> +#include <asm/ptrace.h>

>   extern long __x64_sys_ni_syscall(const struct pt_regs *regs);
>   extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
> --
> 2.37.3

