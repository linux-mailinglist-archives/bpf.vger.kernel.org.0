Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA8C576ADF
	for <lists+bpf@lfdr.de>; Sat, 16 Jul 2022 01:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiGOXzH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 19:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiGOXzE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 19:55:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0A1904DA
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 16:55:03 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FKOHdA009661;
        Fri, 15 Jul 2022 23:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=FTd7oFzWvwtgDkfIHDWML6l6gs0Sz1k4koz20YlvmMQ=;
 b=RUWnKZSX4EuQi9Lcibcmujx9Tn1ncdjf0skG6WjHK0XS9pJQE4YMZKIDLycbUopR5b4y
 Peq1KPHgLL6KxgvxvREJY94Bm/88Zf7vXcuzS57YqLI8eFiIFhG6Wma8NYT8SM3sNBce
 W4/hvMZ6uuAP9IhW9cVNga3NevPld+4fhsHutQrYTvKzRsZZHp3BAqLUyuvnaVnLyz5n
 AWkXKWmeCDKXUcD47aFG0iMVLl/RBP2m0siT1GdAkqXJaTg+4kteJdqJJdOTuS6bCOis
 tzLvfvHKFMbz5PhIeC41JssYOE3COWLCd/SnFg8tbleWN47HXIK0kcjRfeIGFdmDHl6d lw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hbes6kw0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 23:54:47 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26FNp2WH021338;
        Fri, 15 Jul 2022 23:54:45 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3h70xj0xu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 23:54:44 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26FNsgTB24117690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 23:54:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B7F64C044;
        Fri, 15 Jul 2022 23:54:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E69D24C040;
        Fri, 15 Jul 2022 23:54:41 +0000 (GMT)
Received: from [9.171.44.177] (unknown [9.171.44.177])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Jul 2022 23:54:41 +0000 (GMT)
Message-ID: <523a6ebc348221ae4e1a34f017899da863a68cbd.camel@linux.ibm.com>
Subject: Re: [PATCH v2 bpf-next 5/5] selftests/bpf: use BPF_KSYSCALL and
 SEC("ksyscall") in selftests
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>
Date:   Sat, 16 Jul 2022 01:54:41 +0200
In-Reply-To: <06631b122b9bd6258139a36b971bba3e79543503.camel@linux.ibm.com>
References: <20220714070755.3235561-1-andrii@kernel.org>
         <20220714070755.3235561-6-andrii@kernel.org>
         <06631b122b9bd6258139a36b971bba3e79543503.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MwreLXtrv11C_4a5Nquru8iiTpcbnRUW
X-Proofpoint-ORIG-GUID: MwreLXtrv11C_4a5Nquru8iiTpcbnRUW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_15,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207150102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 2022-07-16 at 01:28 +0200, Ilya Leoshkevich wrote:
> On Thu, 2022-07-14 at 00:07 -0700, Andrii Nakryiko wrote:
> > Convert few selftest that used plain SEC("kprobe") with arch-
> > specific
> > syscall wrapper prefix to ksyscall/kretsyscall and corresponding
> > BPF_KSYSCALL macro. test_probe_user.c is especially benefiting from
> > this
> > simplification.
> > 
> > Tested-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  .../selftests/bpf/progs/bpf_syscall_macro.c   |  6 ++---
> >  .../selftests/bpf/progs/test_attach_probe.c   | 15 +++++------
> >  .../selftests/bpf/progs/test_probe_user.c     | 27 +++++----------
> > --
> > --
> >  3 files changed, 16 insertions(+), 32 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> > b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> > index 05838ed9b89c..e1e11897e99b 100644
> > --- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> > +++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> > @@ -64,9 +64,9 @@ int BPF_KPROBE(handle_sys_prctl)
> >         return 0;
> >  }
> >  
> > -SEC("kprobe/" SYS_PREFIX "sys_prctl")
> > -int BPF_KPROBE_SYSCALL(prctl_enter, int option, unsigned long
> > arg2,
> > -                      unsigned long arg3, unsigned long arg4,
> > unsigned long arg5)
> > +SEC("ksyscall/prctl")
> > +int BPF_KSYSCALL(prctl_enter, int option, unsigned long arg2,
> > +                unsigned long arg3, unsigned long arg4, unsigned
> > long arg5)
> >  {
> >         pid_t pid = bpf_get_current_pid_tgid() >> 32;
> >  
> > diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c
> > b/tools/testing/selftests/bpf/progs/test_attach_probe.c
> > index f1c88ad368ef..a1e45fec8938 100644
> > --- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
> > +++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
> > @@ -1,11 +1,10 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  // Copyright (c) 2017 Facebook
> >  
> > -#include <linux/ptrace.h>
> > -#include <linux/bpf.h>
> > +#include "vmlinux.h"
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> > -#include <stdbool.h>
> > +#include <bpf/bpf_core_read.h>
> >  #include "bpf_misc.h"
> >  
> >  int kprobe_res = 0;
> > @@ -31,8 +30,8 @@ int handle_kprobe(struct pt_regs *ctx)
> >         return 0;
> >  }
> >  
> > -SEC("kprobe/" SYS_PREFIX "sys_nanosleep")
> > -int BPF_KPROBE(handle_kprobe_auto)
> > +SEC("ksyscall/nanosleep")
> > +int BPF_KSYSCALL(handle_kprobe_auto, struct __kernel_timespec
> > *req,
> > struct __kernel_timespec *rem)
> >  {
> >         kprobe2_res = 11;
> >         return 0;
> > @@ -56,11 +55,11 @@ int handle_kretprobe(struct pt_regs *ctx)
> >         return 0;
> >  }
> >  
> > -SEC("kretprobe/" SYS_PREFIX "sys_nanosleep")
> > -int BPF_KRETPROBE(handle_kretprobe_auto)
> > +SEC("kretsyscall/nanosleep")
> > +int BPF_KRETPROBE(handle_kretprobe_auto, int ret)
> >  {
> >         kretprobe2_res = 22;
> > -       return 0;
> > +       return ret;
> >  }
> >  
> >  SEC("uprobe")
> > diff --git a/tools/testing/selftests/bpf/progs/test_probe_user.c
> > b/tools/testing/selftests/bpf/progs/test_probe_user.c
> > index 702578a5e496..8e1495008e4d 100644
> > --- a/tools/testing/selftests/bpf/progs/test_probe_user.c
> > +++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
> > @@ -1,35 +1,20 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -
> > -#include <linux/ptrace.h>
> > -#include <linux/bpf.h>
> > -
> > -#include <netinet/in.h>
> > -
> > +#include "vmlinux.h"
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> > +#include <bpf/bpf_core_read.h>
> >  #include "bpf_misc.h"
> >  
> >  static struct sockaddr_in old;
> >  
> > -SEC("kprobe/" SYS_PREFIX "sys_connect")
> > -int BPF_KPROBE(handle_sys_connect)
> > +SEC("ksyscall/connect")
> > +int BPF_KSYSCALL(handle_sys_connect, int fd, struct sockaddr_in
> > *uservaddr, int addrlen)
> >  {
> > -#if SYSCALL_WRAPPER == 1
> > -       struct pt_regs *real_regs;
> > -#endif
> >         struct sockaddr_in new;
> > -       void *ptr;
> > -
> > -#if SYSCALL_WRAPPER == 0
> > -       ptr = (void *)PT_REGS_PARM2(ctx);
> > -#else
> > -       real_regs = (struct pt_regs *)PT_REGS_PARM1(ctx);
> > -       bpf_probe_read_kernel(&ptr, sizeof(ptr),
> > &PT_REGS_PARM2(real_regs));
> > -#endif
> >  
> > -       bpf_probe_read_user(&old, sizeof(old), ptr);
> > +       bpf_probe_read_user(&old, sizeof(old), uservaddr);
> >         __builtin_memset(&new, 0xab, sizeof(new));
> > -       bpf_probe_write_user(ptr, &new, sizeof(new));
> > +       bpf_probe_write_user(uservaddr, &new, sizeof(new));
> >  
> >         return 0;
> >  }
> 
> Hi,
> 
> The first two tests succeed, but test_probe_user fails on s390x with:
> 
>     serial_test_probe_user:FAIL:check_kprobe_res
>     wrong kprobe res from probe read: 0.0.0.0:0
> 
> I'm not sure what is causing this, but at least the loaded BPF code
> looks sane:
> 
> # bpftool prog dump xlated id 81
> int handle_sys_connect(struct pt_regs * ctx):
>    0: (bf) r6 = r1                      ; kernel pt_regs
>    1: (18) r1 = map[id:33][0]+0
>    3: (71) r1 = *(u8 *)(r1 +0)
>    4: (79) r6 = *(u64 *)(r6 +40)        ; kernel gpr2
>                                         ; PT_REGS_PARM1
>    5: (b7) r1 = 152
>    6: (bf) r3 = r6
>    7: (0f) r3 += r1                     ; user orig_gpr2
>                                         ; PT_REGS_PARM1_CORE_SYSCALL
>                                         ; fd
>    8: (bf) r1 = r10
>    9: (07) r1 += -16
>   10: (b4) w2 = 8
>   11: (bc) w2 = w2
>   12: (85) call bpf_probe_read_kernel#-76640 ; (&tmp, 8, &fd)
>   13: (b7) r1 = 48
>   14: (bf) r3 = r6
>   15: (0f) r3 += r1                     ; user gpr3
>                                         ; __PT_PARM2_REG
>                                         ; uservaddr
>   16: (bf) r1 = r10
>   17: (07) r1 += -16
>   18: (b4) w2 = 8
>   19: (bc) w2 = w2
>   20: (85) call bpf_probe_read_kernel#-76640 (&tmp, 8, &uservaddr)
>   21: (b7) r1 = 56
>   22: (0f) r6 += r1                     ; user gpr4 
>                                         ; __PT_PARM3_REG
>                                         ; addrlen
>   23: (79) r7 = *(u64 *)(r10 -16)       ; uservaddr
>   24: (bf) r1 = r10
>   25: (07) r1 += -16
>   26: (b4) w2 = 8
>   27: (bc) w2 = w2
>   28: (bf) r3 = r6
>   29: (85) call bpf_probe_read_kernel#-76640 (&tmp, 8, &addrlen)
>   30: (18) r1 = map[id:32][0]+0         ; &old
>   32: (b4) w2 = 16
>   33: (bc) w2 = w2
>   34: (bf) r3 = r7
>   35: (85) call bpf_probe_read_user#-76928 (&old, 16, uservaddr)
>   36: (18) r1 = 0xabababababababab
>   38: (7b) *(u64 *)(r10 -16) = r1       ; memset(&new, 0xab, 16)
>   39: (7b) *(u64 *)(r10 -8) = r1
>   40: (bf) r2 = r10
>   41: (07) r2 += -16
>   42: (bf) r1 = r7
>   43: (b4) w3 = 16
>   44: (bc) w3 = w3
>   45: (85) call bpf_probe_write_user#-76352 (uservaddr, &new, 16)
>   46: (b4) w0 = 0
>   47: (bc) w0 = w0
>   48: (95) exit
> 
> Best regards,
> Ilya

I haven't noticed that this test was already in the s390x blacklist, so
the failure has nothing to do with this series.

The problem is that the BPF code is not called at all, since s390x uses
socketcall multiplexer. I addressed a similar issue in samples/bpf a
while ago:

commit f55f4c349a03d820c27145bdf457013b42e4b487
Author: Ilya Leoshkevich <iii@linux.ibm.com>
Date:   Tue Sep 15 13:55:19 2020 +0200

    samples/bpf: Fix test_map_in_map on s390
    
    s390 uses socketcall multiplexer instead of individual socket
    syscalls.
    Therefore, "kprobe/" SYSCALL(sys_connect) does not trigger and
    test_map_in_map fails. Fix by using "kprobe/__sys_connect" instead.

Would it make sense to add two probes here: one for connect() and
another for socketcall(SYS_CONNECT)?

I also think that this deserves a mention in the list of quirks.

Best regards,
Ilya
