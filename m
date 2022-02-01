Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBFD4A66C2
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 22:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiBAVBZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 16:01:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233651AbiBAVBY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Feb 2022 16:01:24 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211JsC5Q032060;
        Tue, 1 Feb 2022 21:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=UnJ0MJVPvbHewTYnKJ9f2k+kwPCnBaeCeyjsdEiXNYA=;
 b=Nt9+5l5E6lbCEf45J/YMb6Fu8q0YP+cKymjBUDSVbJiFBWciAy7HaygUzkyXCtdMueuQ
 CpPOaGaGuSKbDEhcBnrDFWZQaliQADKWnTFE6dnHI54gCKYltc1PcfX+lFFibuJPPHtz
 J1uGQyY/zYCRKvy2qUljdy3XAMQhkb3nxkRaBPA96pixPgT6HzBk+Cr6B/jJAipxAi/0
 uMzBLES7P9QJ0jYJA/t42Lq4+rnMuyNX+G/8+TX8IXKj4BaGjXj9TIee89objNjJ0MEq
 LjKQKe/mTFI+AsaxQMCMIOUh6QNjUsDZI0qri6WP9em0O7hR3KrUMF52HqhuI0ivLvd/ Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dybe5924e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 21:01:07 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211KkAoH029248;
        Tue, 1 Feb 2022 21:01:07 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dybe5923n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 21:01:07 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211KsZ0c002577;
        Tue, 1 Feb 2022 21:01:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3dvw79pspu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 21:01:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211L12F843843924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 21:01:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C536AA404D;
        Tue,  1 Feb 2022 21:01:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BF11A4051;
        Tue,  1 Feb 2022 21:01:02 +0000 (GMT)
Received: from [9.171.78.41] (unknown [9.171.78.41])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 21:01:02 +0000 (GMT)
Message-ID: <6001ffd7f68ae6ecabbeb629045cc7bdc1e70fd4.camel@linux.ibm.com>
Subject: Re: [PATCH v5 3/3] libbpf: Add a test to confirm
 PT_REGS_PARM4_SYSCALL
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kenta Tada <Kenta.Tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Date:   Tue, 01 Feb 2022 22:01:01 +0100
In-Reply-To: <CAEf4BzaNjGLAzBWXybmbDHaAa4Sse=aVcn1vWV4GXvUYDXF8hw@mail.gmail.com>
References: <20220124141622.4378-1-Kenta.Tada@sony.com>
         <20220124141622.4378-4-Kenta.Tada@sony.com>
         <CAEf4BzZGARxqmCFmGhJduAu+Wsg2t0RVHLXrfX=KuHuhnhv+OA@mail.gmail.com>
         <CAEf4BzaNjGLAzBWXybmbDHaAa4Sse=aVcn1vWV4GXvUYDXF8hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SIKZ2jpty7yehFJLK2CcPZ1PoeM_Vxsa
X-Proofpoint-ORIG-GUID: gMPLK_MFhs8Qsx3WmrNsrvzdpFAOABKp
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010116
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-02-01 at 11:36 -0800, Andrii Nakryiko wrote:
> +cc Ilya
> 
> 
> On Mon, Jan 24, 2022 at 9:05 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > 
> > +cc Hengqi
> > 
> > On Mon, Jan 24, 2022 at 6:20 AM Kenta Tada <Kenta.Tada@sony.com>
> > wrote:
> > > 
> > > Add a selftest to verify the behavior of PT_REGS_xxx
> > > and the CORE variant.
> > > 
> > > Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> > > ---
> > >  .../bpf/prog_tests/test_bpf_syscall_macro.c   | 63
> > > ++++++++++++++++++
> > >  .../selftests/bpf/progs/bpf_syscall_macro.c   | 64
> > > +++++++++++++++++++
> > >  2 files changed, 127 insertions(+)
> > >  create mode 100644
> > > tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
> > >  create mode 100644
> > > tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> > > 
> > 
> > [...]
> > 
> > > diff --git
> > > a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> > > b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> > > new file mode 100644
> > > index 000000000000..cfeccd85f40e
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> > > @@ -0,0 +1,64 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright 2022 Sony Group Corporation */
> > > +#include <vmlinux.h>
> > > +
> > > +#include <bpf/bpf_core_read.h>
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <bpf/bpf_tracing.h>
> > > +#include "bpf_misc.h"
> > > +
> > > +int arg1 = 0;
> > > +unsigned long arg2 = 0;
> > > +unsigned long arg3 = 0;
> > > +unsigned long arg4_cx = 0;
> > > +unsigned long arg4 = 0;
> > > +unsigned long arg5 = 0;
> > > +
> > > +int arg1_core = 0;
> > > +unsigned long arg2_core = 0;
> > > +unsigned long arg3_core = 0;
> > > +unsigned long arg4_core_cx = 0;
> > > +unsigned long arg4_core = 0;
> > > +unsigned long arg5_core = 0;
> > > +
> > > +const volatile pid_t filter_pid = 0;
> > > +
> > > +SEC("kprobe/" SYS_PREFIX "sys_prctl")
> > > +int BPF_KPROBE(handle_sys_prctl)
> > > +{
> > > +       struct pt_regs *real_regs;
> > > +       int orig_arg1;
> > > +       unsigned long orig_arg2, orig_arg3, orig_arg4_cx,
> > > orig_arg4, orig_arg5;
> > > +       pid_t pid = bpf_get_current_pid_tgid() >> 32;
> > > +
> > > +       if (pid != filter_pid)
> > > +               return 0;
> > > +
> > > +       /* test for PT_REGS_PARM */
> > > +       real_regs = (struct pt_regs *)PT_REGS_PARM1(ctx);
> > > +       bpf_probe_read_kernel(&orig_arg1, sizeof(orig_arg1),
> > > &PT_REGS_PARM1_SYSCALL(real_regs));
> > > +       bpf_probe_read_kernel(&orig_arg2, sizeof(orig_arg2),
> > > &PT_REGS_PARM2_SYSCALL(real_regs));
> > > +       bpf_probe_read_kernel(&orig_arg3, sizeof(orig_arg3),
> > > &PT_REGS_PARM3_SYSCALL(real_regs));
> > > +       bpf_probe_read_kernel(&orig_arg4_cx,
> > > sizeof(orig_arg4_cx), &PT_REGS_PARM4(real_regs));
> > > +       bpf_probe_read_kernel(&orig_arg4, sizeof(orig_arg4),
> > > &PT_REGS_PARM4_SYSCALL(real_regs));
> > > +       bpf_probe_read_kernel(&orig_arg5, sizeof(orig_arg5),
> > > &PT_REGS_PARM5_SYSCALL(real_regs));
> > > +       /* copy all actual args and the wrong arg4 on x86_64 */
> > > +       arg1 = orig_arg1;
> > > +       arg2 = orig_arg2;
> > > +       arg3 = orig_arg3;
> > > +       arg4_cx = orig_arg4_cx;
> > > +       arg4 = orig_arg4;
> > > +       arg5 = orig_arg5;
> > 
> > I don't get why you needed orig_argX variables and then copying
> > them
> > into argX variables. I changed this to read directly into argX. I
> > suspect arg1 handling might break on big-endian arches due to int
> > vs
> > long differences, please check that and send a follow up fix.
> > 
> > Also keep in mind that selftest changes should come with
> > "selftests/bpf:" subject prefix, not "libbpf:". Fixed that up as
> > well.
> > 
> > Applied to bpf-next, thanks.
> 
> This selftest is failing on s390x (see [0]). Ilya, do you know if
> something special needs to be done for s390x for this case?
> 
> Here are the two failures:
> 
> test_bpf_syscall_macro:FAIL:syscall_arg1 unexpected syscall_arg1:
> actual -1 != expected 1001
> test_bpf_syscall_macro:FAIL:syscall_arg1_core_variant unexpected
> syscall_arg1_core_variant: actual -38 != expected 1001
> 
>   [0]
> https://github.com/libbpf/libbpf/runs/5025905587?check_suite_focus=true
> 

I think we need to use orig_gpr2 for the first syscall argument
(see arch/s390/include/asm/syscall.h). I'll test it and send a patch.
> 
