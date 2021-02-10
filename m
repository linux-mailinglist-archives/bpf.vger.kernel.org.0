Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29956315B78
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 01:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhBJAmm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 19:42:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233912AbhBJAkk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 19:40:40 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11A0Zqer077396;
        Tue, 9 Feb 2021 19:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IlFkJfwfeLZamH0PZcYWsb2KG/RcPg/FTSxFdlfNgo4=;
 b=rXNHFKBMDWO7wx3Qz46/ubtE20/0hUoqSbA/1a8nESqJ1xHZhd9QF7UoKTwX7rPN5sPe
 qyOkAs8ph2mVALHibK2dJGKvh0tANHFefwQPekaLbd99+I86bfffergauFAACynX0aVk
 ncFx8E+fOD3q3Wo7bWhay/bsGxSn9ZGUpj749g1sEiIMzSQxaZGpKEF1eUHawBFeNRWC
 1sQ39jXcUJNdWPGtoYGQEGGWWhcmZdn69NAGJo07J2a1w5h96fPAhl4G15/a0ReMp2XR
 w389K3xtHaxIzW+Y4sR9S2UOoI0teg5Ny726BEhQJvtRI+/SUEZgGlKNArDeCTkvmiqL Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36m3unsrvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 19:39:54 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11A0ak7N080360;
        Tue, 9 Feb 2021 19:39:54 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36m3unsrum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 19:39:54 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11A0bptu016996;
        Wed, 10 Feb 2021 00:39:51 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 36m1m2r88j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 00:39:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11A0dd0527132378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 00:39:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49581AE056;
        Wed, 10 Feb 2021 00:39:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C43EAE055;
        Wed, 10 Feb 2021 00:39:49 +0000 (GMT)
Received: from [9.171.67.27] (unknown [9.171.67.27])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Feb 2021 00:39:49 +0000 (GMT)
Message-ID: <b1792bb3c51eb3e94b9d27e67665d3f2209bba7e.camel@linux.ibm.com>
Subject: What should BPF_CMPXCHG do when the values match?
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@fb.com>,
        Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>
Date:   Wed, 10 Feb 2021 01:39:48 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090129
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I'm implementing BPF_CMPXCHG for the s390x JIT and noticed that the
doc, the interpreter and the X64 JIT do not agree on what the behavior
should be when the values match.

If the operand size is BPF_W, this matters, because, depending on the
answer, the upper bits of R0 are either zeroed out out or are left
intact.

I made the experiment based on the following modification to the
"atomic compare-and-exchange smoketest - 32bit" test on top of commit
ee5cc0363ea0:

--- a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
@@ -57,8 +57,8 @@
                BPF_MOV32_IMM(BPF_REG_1, 4),
                BPF_MOV32_IMM(BPF_REG_0, 3),
                BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_10,
BPF_REG_1, -4),
-               /* if (old != 3) exit(4); */
-               BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
+               /* if ((u64)old != 3) exit(4); */
+               BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
                BPF_MOV32_IMM(BPF_REG_0, 4),
                BPF_EXIT_INSN(),
                /* if (val != 4) exit(5); */

and got the following results:

1) Documentation: Upper bits of R0 are zeroed out - but it looks as if
   there is a typo and either a period or the word "otherwise" is
   missing?

   > If they match it is replaced with ``src_reg``, The value that was
   > there before is loaded back to ``R0``.

2) Interpreter + KVM: Upper bits of R0 are zeroed out (C semantics)

3) X64 JIT + KVM: Upper bits of R0 are untouched (cmpxchg semantics)

   => 0xffffffffc0146bc7: lock cmpxchg %edi,-0x4(%rbp)
      0xffffffffc0146bcc: cmp $0x3,%rax
   (gdb) p/x $rax
   0x6bd5720c00000003
   (gdb) x/d $rbp-4
   0xffffc90001263d5c: 3

      0xffffffffc0146bc7: lock cmpxchg %edi,-0x4(%rbp)
   => 0xffffffffc0146bcc: cmp $0x3,%rax
   (gdb) p/x $rax
   0x6bd5720c00000003

4) X64 JIT + TCG: Upper bits of R0 are zeroed out (qemu bug?)

   => 0xffffffffc01441fc: lock cmpxchg %edi,-0x4(%rbp)
      0xffffffffc0144201: cmp $0x3,%rax
   (gdb) p/x $rax
   0x81776ea600000003
   (gdb) x/d $rbp-4
   0xffffc90001117d5c: 3

      0xffffffffc01441fc: lock cmpxchg %edi,-0x4(%rbp)
   => 0xffffffffc0144201: cmp $0x3,%rax
   (gdb) p/x $rax
   $3 = 0x3

So which option is the right one? In my opinion, it would be safer to
follow what the interpreter does and zero out the upper bits.

Best regards,
Ilya


