Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2608A5FF9D3
	for <lists+bpf@lfdr.de>; Sat, 15 Oct 2022 13:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJOLdT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Oct 2022 07:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJOLdS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Oct 2022 07:33:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C70956012
        for <bpf@vger.kernel.org>; Sat, 15 Oct 2022 04:33:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so7713689wma.3
        for <bpf@vger.kernel.org>; Sat, 15 Oct 2022 04:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0L4pJkBYP+yCRt6EwqXc9KxacqjaCrsXl648VQKIr4=;
        b=EAswOLlSdgV5u+HquGxIc/7aa1tBKGE7t+UnXybmr7dzGmjvC37dHK/PTrzJPnU+Md
         R14AG6Lqi/rInqcftRrbSIWlirJaHuzGKxxPMUYAJjc/oIdldeP9cwnkS4eLTnTnRKVr
         v7HZtXM1rVzxM9DvPJn2eG6SOaViV42S56SPeOQlpWNamuk7jxJ4iItADI1GubCE+Mij
         O1m8hkOKCDzOS6BvfDi4oWpbiAJnsXxutVWVW/78KHbms0Zy/Nw/To8h97xNSBOiodx/
         XERMy07RBwxfp0dhBR2lHJJQdYeV9PhHgKsEcPQAsLlDGAR0IkZJFz5aeMB0VxY7lrEF
         UIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0L4pJkBYP+yCRt6EwqXc9KxacqjaCrsXl648VQKIr4=;
        b=nma+5sdrVoVDrSOh5sUQpG9S28DkwA0wKyexDM+Q+h4TD6cbKaycyoXXo6GK0ovI47
         kJfHlSKqoaNO/AFUpXysYpeHmOMJEzi0WOpDc+KR0cUW2Ml3GezBZysntAc1x3yJD7cF
         2YXX1nVPQIrs8Fbef6++YsNvnoup9DR9NgupMXecax4pQowDqTldXnIJc22NG05GlwXV
         nUoM3yEw963sEx5iWLK438fLFcQ/7uCyN0prv+m69T5GX0+xqV2SrKAbhCXcSUm5ioP4
         6V1ViB/pcywzBZKThwiKFzr8koOxAZrRMPS9ioSscUsE26cchhSVvCA2RTPkXE/x8Z9D
         BMwA==
X-Gm-Message-State: ACrzQf04o8P9PIXgLnFNhp7OKTi32Y89CfCh6OPXI/FkcorXJeMhK/Kg
        tSa+uauOYuHG1F2oaLr7cxE18o9LFDo=
X-Google-Smtp-Source: AMsMyM4m9B1nRwM6Q0Rjp7LKKyO4/kyyV4s7lpscQCKMmy5LOAG1F4WOfe7w4B6HaVcCbTc/bAgtdg==
X-Received: by 2002:a05:600c:6010:b0:3c6:be4d:e219 with SMTP id az16-20020a05600c601000b003c6be4de219mr1505379wmb.10.1665833594756;
        Sat, 15 Oct 2022 04:33:14 -0700 (PDT)
Received: from krava ([83.240.63.167])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d550a000000b0022860e8ae7csm3856085wrv.77.2022.10.15.04.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 04:33:14 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sat, 15 Oct 2022 13:33:12 +0200
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Akihiro HARAI <jharai0815@gmail.com>, bpf@vger.kernel.org
Subject: Re: Inconsistent BTF entries for `struct pt_regs *regs` parameter
Message-ID: <Y0qaeOZHsbiPNfnT@krava>
References: <CAFo4XKvHU8gn9PoYwrFA0OyBDGY7=bBvwMDNuWGxR6gkLgudOg@mail.gmail.com>
 <Yz6lxZLRxAalQCHd@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz6lxZLRxAalQCHd@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 06, 2022 at 11:54:13AM +0200, Jiri Olsa wrote:
> On Thu, Oct 06, 2022 at 04:34:46PM +0900, Akihiro HARAI wrote:
> > Depending on distribution/kernel/syscall combination, BTF entry for
> > `struct pt_regs *regs` parameter differs.
> > 
> > For example, Amazon Linux 2 with kernel-5.15 package enabled has a FWD
> > entry for `__x64_sys_recvmsg` function:
> > 
> > ```
> > $ uname -a
> > Linux ip-10-1-1-66.ap-northeast-1.compute.internal
> > 5.15.43-20.123.amzn2.x86_64 #1 SMP Fri May 27 00:28:44 UTC 2022 x86_64
> > x86_64 x86_64 GNU/Linux
> > 
> > $ bpftool btf dump file /sys/kernel/btf/vmlinux format raw
> > ...
> > [15439] FWD 'pt_regs' fwd_kind=struct
> > [15440] CONST '(anon)' type_id=15439
> > [15441] PTR '(anon)' type_id=15440
> > [15442] FUNC_PROTO '(anon)' ret_type_id=34 vlen=1
> >         '__unused' type_id=15441
> > ...
> > [15694] FUNC '__x64_sys_recvmsg' type_id=15442 linkage=static
> > ...
> > ```
> > 
> > while Ubuntu 20.04 LTS with newer kernel has a STRUCT entry for the
> > same function:
> > 
> > ```
> > $ uname -a
> > Linux xxx-XPS-13-9300 5.13.0-51-generic #58~20.04.1-Ubuntu SMP Tue Jun
> > 14 11:29:12 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
> > 
> > $ bpftool btf dump file /sys/kernel/btf/vmlinux format raw
> > [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> > ...
> > [226] STRUCT 'pt_regs' size=168 vlen=21
> >         'r15' type_id=1 bits_offset=0
> >         'r14' type_id=1 bits_offset=64
> >         'r13' type_id=1 bits_offset=128
> >         'r12' type_id=1 bits_offset=192
> >         'bp' type_id=1 bits_offset=256
> >         'bx' type_id=1 bits_offset=320
> >         'r11' type_id=1 bits_offset=384
> >         'r10' type_id=1 bits_offset=448
> >         'r9' type_id=1 bits_offset=512
> >         'r8' type_id=1 bits_offset=576
> >         'ax' type_id=1 bits_offset=640
> >         'cx' type_id=1 bits_offset=704
> >         'dx' type_id=1 bits_offset=768
> >         'si' type_id=1 bits_offset=832
> >         'di' type_id=1 bits_offset=896
> >         'orig_ax' type_id=1 bits_offset=960
> >         'ip' type_id=1 bits_offset=1024
> >         'cs' type_id=1 bits_offset=1088
> >         'flags' type_id=1 bits_offset=1152
> >         'sp' type_id=1 bits_offset=1216
> >         'ss' type_id=1 bits_offset=1280
> > ...
> > [5183] CONST '(anon)' type_id=226
> > ...
> > [5189] PTR '(anon)' type_id=5183
> > ...
> > [5321] FUNC_PROTO '(anon)' ret_type_id=42 vlen=1
> >         '__unused' type_id=5189
> > ...
> > [17648] FUNC '__x64_sys_recvmsg' type_id=5321 linkage=static
> > ...
> > ```
> > 
> > Yet another distribution/kernel/syscall combination has multiple `FUNC
> > '__x64_sys_[SYSCALL]'` entries, one for FWD and the other for STRUCT:
> > 
> > ```
> > $ uname -a
> > Linux ip-10-5-0-115.ap-northeast-1.compute.internal
> > 5.10.112-108.499.amzn2.x86_64 #1 SMP Wed Apr 27 23:39:40 UTC 2022
> > x86_64 x86_64 x86_64 GNU/Linux
> > 
> > ```
> > $ bpftool btf dump file /sys/kernel/btf/vmlinux format raw | grep
> > __x64_sys_mprotect
> > ...
> > [175] STRUCT 'pt_regs' size=168 vlen=21
> >         'r15' type_id=2 bits_offset=0
> >         'r14' type_id=2 bits_offset=64
> >         'r13' type_id=2 bits_offset=128
> >         'r12' type_id=2 bits_offset=192
> >         'bp' type_id=2 bits_offset=256
> > ...
> > [4215] CONST '(anon)' type_id=175
> > ...
> > [4220] PTR '(anon)' type_id=4215
> > ...
> > [6062] FUNC_PROTO '(anon)' ret_type_id=36 vlen=1
> >         'regs' type_id=4220
> > ...
> > [11461] FWD 'pt_regs' fwd_kind=struct
> > [11462] CONST '(anon)' type_id=11461
> > [11463] PTR '(anon)' type_id=11462
> > [11464] FUNC_PROTO '(anon)' ret_type_id=36 vlen=1
> >         '__unused' type_id=11463
> > ...
> > [11698] FUNC '__x64_sys_mprotect' type_id=11464 linkage=static
> > ...
> > [23528] FUNC '__x64_sys_mprotect' type_id=6062 linkage=static
> > ...
> > ```
> > 
> > Trying to read `regs` parameter with FWD entry results in "invalid
> > bpf_context access" error:
> > 
> > ```
> > SEC("fentry/__x64_sys_recvfrom")
> > int BPF_PROG(fentry_syscall, struct pt_regs *regs) {
> >   struct event t;
> > 
> >   bpf_get_current_comm(t.comm, TASK_COMM_LEN);
> > 
> >   u64 id = bpf_get_current_pid_tgid();
> >   t.pid = id >> 32;
> > 
> >   // This causes an error on some environments.
> >   t.fd = PT_REGS_PARM1_CORE(regs);
> > 
> >   bpf_printk("comm: %s, pid: %d, fd: %d", t.comm, t.pid, t.fd);
> > 
> >   return 0;
> > ```
> > 
> > ```
> > $ sudo ./output
> > 2022/07/01 03:33:01 loading objects: field FentrySyscall: program
> > fentry_syscall: load program: permission denied:
> >         arg#0 type is not a struct
> >         Unrecognized arg#0 type PTR
> >         ; int BPF_PROG(fentry_syscall, struct pt_regs *regs) {
> >         0: (79) r6 = *(u64 *)(r1 +0)
> >         func '__x64_sys_recvfrom' arg0 type FWD is not a struct
> >         invalid bpf_context access off=0 size=8
> >         processed 1 insns (limit 1000000) max_states_per_insn 0
> > total_states 0 peak_states 0 mark_read 0
> > ```
> > 
> > Is this a bug related to toolchain?
> 
> nice, I think it's specific to each object that defines syscall
> 
> if such object has 'struct pt_regs' header with definition included
> it will have full struct pt_regs, if not it will be just fwd ref
> 
> not sure this would break anything else, but change below
> fixes it for me

hi,
did this help? I'll send it as formal patch anyway,
since it fixes the issue for me

jirka

> 
> jirka
> 
> 
> ---
> diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
> index 59358d1bf880..fd2669b1cb2d 100644
> --- a/arch/x86/include/asm/syscall_wrapper.h
> +++ b/arch/x86/include/asm/syscall_wrapper.h
> @@ -6,7 +6,7 @@
>  #ifndef _ASM_X86_SYSCALL_WRAPPER_H
>  #define _ASM_X86_SYSCALL_WRAPPER_H
>  
> -struct pt_regs;
> +#include <asm/ptrace.h>
>  
>  extern long __x64_sys_ni_syscall(const struct pt_regs *regs);
>  extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
