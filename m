Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5EB5F63D9
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 11:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiJFJyU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 05:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiJFJyT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 05:54:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338237E81F
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 02:54:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j7so1880734wrr.3
        for <bpf@vger.kernel.org>; Thu, 06 Oct 2022 02:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=32oVKVOfr75dIfCVljHFoksVvRK33khsj78jRFcLjX0=;
        b=GJFBiRThhIt7c2sogyjEdMDOTq6l2tZfIATOeXZB/Ma8wBZpf5kGtV05luoQkoPYDh
         iGt2kZ6YzRD6Zoj2bQUnX3Vrett1zJAQnPeMMlNCphul5qPyJYBLP70Y6HukuLTQILsw
         NvUU7y8Hvx7KCJlmCwOiXFrXXZ1k3OSwI8TI9GSPDeyx4luUqo8rgBWNDOoT9rgq8ZG+
         SLu1MwK0Req/5D3VJco0llwJfz+QSugszYnor75VcBaU6TEkzMp15dhR2Vc66lAQiup9
         /oq94b5Yh3hw3FYsthpTWHY6eisycpBqN6u+xhTwri5h0lSRW8/ciOXYAcvNy/IMeMBT
         fQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32oVKVOfr75dIfCVljHFoksVvRK33khsj78jRFcLjX0=;
        b=lBFsmuZVrVyFLtt55NvxB29Wj5OSB7oOz2OHrneA/x14365PgLhkxJ6V5kF4ChTyC2
         e7DDTrvMojmnCX0l1OyjeyiMYLiNv/WjzoVMWTLRLycBoWCzAfJtgiE3uBJA7uwdLdmZ
         drUM9C1f2Fw5ffw1TgLtcRHkChD2naTR/5R8LDgCpQAejb3AIf+eoju5FP9zkI2bIvRT
         xv1ZVPhy53ctXNnDeEc1Qg2J9wmBtt8LjQ8tK/O+C0EVzKtfxXISptdgWA9I7+lux/We
         SEj72tEw4wF5wrWgDUTLIzqWqpD9YfOlmUAaDc24IXAdWRW3+eEHHhOT2Y6P9oDfYRmb
         EaJw==
X-Gm-Message-State: ACrzQf0OaLsLSAKgSl47xg0NbvKwIYkDMwLnNN/6g7kmmO9ZFzWZHNJf
        eRxlMkAJKHCLz1ODYSDOhK8=
X-Google-Smtp-Source: AMsMyM75UsFbdtchhHXe80atKoXfrowbs0TisfPjsiAeL59S+xClQgNn5MTRfPASYq+iLKFoj8kWEQ==
X-Received: by 2002:a5d:4241:0:b0:22e:6d62:cca0 with SMTP id s1-20020a5d4241000000b0022e6d62cca0mr1547738wrr.79.1665050054565;
        Thu, 06 Oct 2022 02:54:14 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id h11-20020adfe98b000000b0022c906ffedasm17381954wrm.70.2022.10.06.02.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 02:54:14 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 6 Oct 2022 11:54:13 +0200
To:     Akihiro HARAI <jharai0815@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: Re: Inconsistent BTF entries for `struct pt_regs *regs` parameter
Message-ID: <Yz6lxZLRxAalQCHd@krava>
References: <CAFo4XKvHU8gn9PoYwrFA0OyBDGY7=bBvwMDNuWGxR6gkLgudOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFo4XKvHU8gn9PoYwrFA0OyBDGY7=bBvwMDNuWGxR6gkLgudOg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 06, 2022 at 04:34:46PM +0900, Akihiro HARAI wrote:
> Depending on distribution/kernel/syscall combination, BTF entry for
> `struct pt_regs *regs` parameter differs.
> 
> For example, Amazon Linux 2 with kernel-5.15 package enabled has a FWD
> entry for `__x64_sys_recvmsg` function:
> 
> ```
> $ uname -a
> Linux ip-10-1-1-66.ap-northeast-1.compute.internal
> 5.15.43-20.123.amzn2.x86_64 #1 SMP Fri May 27 00:28:44 UTC 2022 x86_64
> x86_64 x86_64 GNU/Linux
> 
> $ bpftool btf dump file /sys/kernel/btf/vmlinux format raw
> ...
> [15439] FWD 'pt_regs' fwd_kind=struct
> [15440] CONST '(anon)' type_id=15439
> [15441] PTR '(anon)' type_id=15440
> [15442] FUNC_PROTO '(anon)' ret_type_id=34 vlen=1
>         '__unused' type_id=15441
> ...
> [15694] FUNC '__x64_sys_recvmsg' type_id=15442 linkage=static
> ...
> ```
> 
> while Ubuntu 20.04 LTS with newer kernel has a STRUCT entry for the
> same function:
> 
> ```
> $ uname -a
> Linux xxx-XPS-13-9300 5.13.0-51-generic #58~20.04.1-Ubuntu SMP Tue Jun
> 14 11:29:12 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
> 
> $ bpftool btf dump file /sys/kernel/btf/vmlinux format raw
> [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> ...
> [226] STRUCT 'pt_regs' size=168 vlen=21
>         'r15' type_id=1 bits_offset=0
>         'r14' type_id=1 bits_offset=64
>         'r13' type_id=1 bits_offset=128
>         'r12' type_id=1 bits_offset=192
>         'bp' type_id=1 bits_offset=256
>         'bx' type_id=1 bits_offset=320
>         'r11' type_id=1 bits_offset=384
>         'r10' type_id=1 bits_offset=448
>         'r9' type_id=1 bits_offset=512
>         'r8' type_id=1 bits_offset=576
>         'ax' type_id=1 bits_offset=640
>         'cx' type_id=1 bits_offset=704
>         'dx' type_id=1 bits_offset=768
>         'si' type_id=1 bits_offset=832
>         'di' type_id=1 bits_offset=896
>         'orig_ax' type_id=1 bits_offset=960
>         'ip' type_id=1 bits_offset=1024
>         'cs' type_id=1 bits_offset=1088
>         'flags' type_id=1 bits_offset=1152
>         'sp' type_id=1 bits_offset=1216
>         'ss' type_id=1 bits_offset=1280
> ...
> [5183] CONST '(anon)' type_id=226
> ...
> [5189] PTR '(anon)' type_id=5183
> ...
> [5321] FUNC_PROTO '(anon)' ret_type_id=42 vlen=1
>         '__unused' type_id=5189
> ...
> [17648] FUNC '__x64_sys_recvmsg' type_id=5321 linkage=static
> ...
> ```
> 
> Yet another distribution/kernel/syscall combination has multiple `FUNC
> '__x64_sys_[SYSCALL]'` entries, one for FWD and the other for STRUCT:
> 
> ```
> $ uname -a
> Linux ip-10-5-0-115.ap-northeast-1.compute.internal
> 5.10.112-108.499.amzn2.x86_64 #1 SMP Wed Apr 27 23:39:40 UTC 2022
> x86_64 x86_64 x86_64 GNU/Linux
> 
> ```
> $ bpftool btf dump file /sys/kernel/btf/vmlinux format raw | grep
> __x64_sys_mprotect
> ...
> [175] STRUCT 'pt_regs' size=168 vlen=21
>         'r15' type_id=2 bits_offset=0
>         'r14' type_id=2 bits_offset=64
>         'r13' type_id=2 bits_offset=128
>         'r12' type_id=2 bits_offset=192
>         'bp' type_id=2 bits_offset=256
> ...
> [4215] CONST '(anon)' type_id=175
> ...
> [4220] PTR '(anon)' type_id=4215
> ...
> [6062] FUNC_PROTO '(anon)' ret_type_id=36 vlen=1
>         'regs' type_id=4220
> ...
> [11461] FWD 'pt_regs' fwd_kind=struct
> [11462] CONST '(anon)' type_id=11461
> [11463] PTR '(anon)' type_id=11462
> [11464] FUNC_PROTO '(anon)' ret_type_id=36 vlen=1
>         '__unused' type_id=11463
> ...
> [11698] FUNC '__x64_sys_mprotect' type_id=11464 linkage=static
> ...
> [23528] FUNC '__x64_sys_mprotect' type_id=6062 linkage=static
> ...
> ```
> 
> Trying to read `regs` parameter with FWD entry results in "invalid
> bpf_context access" error:
> 
> ```
> SEC("fentry/__x64_sys_recvfrom")
> int BPF_PROG(fentry_syscall, struct pt_regs *regs) {
>   struct event t;
> 
>   bpf_get_current_comm(t.comm, TASK_COMM_LEN);
> 
>   u64 id = bpf_get_current_pid_tgid();
>   t.pid = id >> 32;
> 
>   // This causes an error on some environments.
>   t.fd = PT_REGS_PARM1_CORE(regs);
> 
>   bpf_printk("comm: %s, pid: %d, fd: %d", t.comm, t.pid, t.fd);
> 
>   return 0;
> ```
> 
> ```
> $ sudo ./output
> 2022/07/01 03:33:01 loading objects: field FentrySyscall: program
> fentry_syscall: load program: permission denied:
>         arg#0 type is not a struct
>         Unrecognized arg#0 type PTR
>         ; int BPF_PROG(fentry_syscall, struct pt_regs *regs) {
>         0: (79) r6 = *(u64 *)(r1 +0)
>         func '__x64_sys_recvfrom' arg0 type FWD is not a struct
>         invalid bpf_context access off=0 size=8
>         processed 1 insns (limit 1000000) max_states_per_insn 0
> total_states 0 peak_states 0 mark_read 0
> ```
> 
> Is this a bug related to toolchain?

nice, I think it's specific to each object that defines syscall

if such object has 'struct pt_regs' header with definition included
it will have full struct pt_regs, if not it will be just fwd ref

not sure this would break anything else, but change below
fixes it for me

jirka


---
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 59358d1bf880..fd2669b1cb2d 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -6,7 +6,7 @@
 #ifndef _ASM_X86_SYSCALL_WRAPPER_H
 #define _ASM_X86_SYSCALL_WRAPPER_H
 
-struct pt_regs;
+#include <asm/ptrace.h>
 
 extern long __x64_sys_ni_syscall(const struct pt_regs *regs);
 extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
