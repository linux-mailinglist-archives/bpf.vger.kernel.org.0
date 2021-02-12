Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0EE3198C1
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 04:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBLD1c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Feb 2021 22:27:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229587AbhBLD1b (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Feb 2021 22:27:31 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11C38Won148081;
        Thu, 11 Feb 2021 22:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yKF+IoiXjp3de2rnBHePtLE9iNRpp4bFwTRErFmMDKM=;
 b=gaeb0/WCw7ODAQsHz24brNpByRnP2a4/EnLDgFvPJ0vylKERKQy84Nq53YKIYaqVlbJ2
 l/CBp80WaVYFD0K2q2QbC2lBjztW7RqEAXmUGfrlBuG0f40d0Wl5DbIImXRYVWkhIuAe
 BBWVBku3lVAfxAZOOifh+I6Px/bj4g776u37JCs0Rl+afJv6ub50lA5KYEz2bzbQ04Ml
 qO/oN5QDgClldUrJqNxr2YTYaiGr0zol0Skx21sLSoqA83Jk6zNUEx/ZP2GWWczBJW+V
 1T4MRjSUNDoqbfyswgq2VL7+8OWHFCSUGOraYpSwTB30CnK0VuZTiDzBM7/YHnBi1wT/ 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36nhgh88fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 22:26:36 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11C3KOwB185237;
        Thu, 11 Feb 2021 22:26:36 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36nhgh88fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 22:26:36 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11C3DExr001242;
        Fri, 12 Feb 2021 03:26:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 36j94wnjc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 03:26:34 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11C3QM9Y37814584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 03:26:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DD72AE045;
        Fri, 12 Feb 2021 03:26:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E7E3AE04D;
        Fri, 12 Feb 2021 03:26:32 +0000 (GMT)
Received: from [9.171.67.27] (unknown [9.171.67.27])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Feb 2021 03:26:32 +0000 (GMT)
Message-ID: <1e54f82603c361e7ee1464621a9937c1efb3b254.camel@linux.ibm.com>
Subject: Re: [PATCH v4 bpf-next 1/9] bpf: Optimize program stats
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Date:   Fri, 12 Feb 2021 04:26:31 +0100
In-Reply-To: <20210210033634.62081-2-alexei.starovoitov@gmail.com>
References: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
         <20210210033634.62081-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=925 clxscore=1011 spamscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120018
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2021-02-09 at 19:36 -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Move bpf_prog_stats from prog->aux into prog to avoid one extra load
> in critical path of program execution.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h     |  8 --------
>  include/linux/filter.h  | 14 +++++++++++---
>  kernel/bpf/core.c       |  8 ++++----
>  kernel/bpf/syscall.c    |  2 +-
>  kernel/bpf/trampoline.c |  2 +-
>  kernel/bpf/verifier.c   |  2 +-
>  6 files changed, 18 insertions(+), 18 deletions(-)

...

> @@ -249,10 +249,10 @@ void __bpf_prog_free(struct bpf_prog *fp)
>         if (fp->aux) {
>                 mutex_destroy(&fp->aux->used_maps_mutex);
>                 mutex_destroy(&fp->aux->dst_mutex);
> -               free_percpu(fp->aux->stats);
>                 kfree(fp->aux->poke_tab);
>                 kfree(fp->aux);
>         }
> +       free_percpu(fp->stats);

On s390 this line causes the following in "ld_abs: vlan + abs, test 1"
with the latest bpf-next:

Unable to handle kernel pointer dereference in virtual kernel address
space
Failing address: 0000000000000000 TEID: 0000000000000483
Fault in home space mode while using kernel ASCE.
AS:0000000001bd0007 R3:00000001ffff0007 S:00000001ffffd000
P:000000000000003d 
Oops: 0004 ilc:2 [#1] SMP 
Modules linked in:
CPU: 0 PID: 184 Comm: test_verifier Not tainted 5.11.0-rc4-00952-
g6fdd671baaf5 #7
Hardware name: IBM 3906 M03 703 (KVM/Linux)
Krnl PSW : 0404c00180000000 000000000042707a
(refill_obj_stock+0x11a/0x1e0)
           R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
Krnl GPRS: 0000000000000000 0000000000000000 0000000000000018
0000000100000000
           0000000000000000 000000008764ca88 00000000013d3ff8
000000000141d140
           0000000000000080 0000000000000000 0000000000000000
00000001ff61c8f0
           000000008764c000 00000000012eb678 0000000000427066
00000380001bb888
Krnl Code: 0000000000427070: a7380000           lhi     %r3,0
           0000000000427074: 5810a018           l       %r1,24(%r10)
          #0000000000427078: 1841               lr      %r4,%r1
          >000000000042707a: ba432000           cs      %r4,%r3,0(%r2)
           000000000042707e: a774fffb           brc    
7,0000000000427074
           0000000000427082: 1a18               ar      %r1,%r8
           0000000000427084: 5010b018           st      %r1,24(%r11)
           0000000000427088: c21f00001000       clfi    %r1,4096
Call Trace:
 [<000000000042707a>] refill_obj_stock+0x11a/0x1e0 
([<0000000000427066>] refill_obj_stock+0x106/0x1e0)
 [<000000000039bd86>] free_percpu.part.0+0xd6/0x428 
 [<00000000002ef738>] bpf_prog_realloc+0xa0/0xd8 
 [<00000000002efae8>] bpf_patch_insn_single+0x88/0x208 
 [<000000000030762e>] bpf_patch_insn_data+0x36/0x290 
 [<00000000003086ca>] fixup_bpf_calls+0x572/0xa28 
 [<000000000031045c>] bpf_check+0xb44/0xcb8 
 [<00000000002f747a>] bpf_prog_load+0x5fa/0x968 
 [<00000000002fa25c>] __do_sys_bpf+0x634/0x700 
 [<0000000000a2f3ca>] system_call+0xe2/0x28c 
INFO: lockdep is turned off.
Last Breaking-Event-Address:
 [<0000000000203f76>] lock_release+0x6e/0x218
Kernel panic - not syncing: Fatal exception: panic_on_oops

Here is the better backtrace (line numbers correspond to commit
6fdd671baaf5):

#0  refill_obj_stock (objcg=objcg@entry=0x0, nr_bytes=<optimized out>)
at mm/memcontrol.c:3248
#1  0x0000000000427a08 in obj_cgroup_uncharge (objcg=objcg@entry=0x0,
size=<optimized out>) at mm/memcontrol.c:3300
#2  0x000000000039bd86 in pcpu_memcg_free_hook (size=32, off=<optimized
out>, chunk=0x82d4fa00) at ./include/linux/bitmap.h:400
#3  free_percpu (ptr=0x3fd813b5960) at mm/percpu.c:2105
#4  0x000000000039c0ec in free_percpu (ptr=<optimized out>) at
mm/percpu.c:2089
#5  0x00000000002ef738 in __bpf_prog_free (fp=0x380001ce000) at
kernel/bpf/core.c:262
#6  bpf_prog_realloc (fp_old=fp_old@entry=0x380001ce000, size=249856,
size@entry=245776, gfp_extra_flags=gfp_extra_flags@entry=1051840) at
kernel/bpf/core.c:248
#7  0x00000000002efae8 in bpf_patch_insn_single (prog=0x380001ce000,
off=off@entry=2205, patch=patch@entry=0x380001bbba0, len=len@entry=6)
at ./include/linux/filter.h:788
#8  0x000000000030762e in bpf_patch_insn_data
(env=env@entry=0x87566000, off=off@entry=2205,
patch=patch@entry=0x380001bbba0, len=<optimized out>) at
kernel/bpf/verifier.c:10669
#9  0x00000000003086ca in fixup_bpf_calls (env=env@entry=0x87566000) at
kernel/bpf/verifier.c:11539
#10 0x000000000031045c in bpf_check (prog=prog@entry=0x380001bbda0,
attr=attr@entry=0x380001bbe80, uattr=uattr@entry=0x3ffe66fe9d0) at
kernel/bpf/verifier.c:12573
#11 0x00000000002f747a in bpf_prog_load (attr=attr@entry=0x380001bbe80,
uattr=uattr@entry=0x3ffe66fe9d0) at kernel/bpf/syscall.c:2209
#12 0x00000000002fa25c in __do_sys_bpf (cmd=<optimized out>,
uattr=0x3ffe66fe9d0, size=120) at kernel/bpf/syscall.c:4388
#13 0x0000000000a2f3ca in system_call () at
arch/s390/kernel/entry.S:439

So we end up with objcg=NULL, but I'm not sure why this happens.
Please let me know if you need more info.

