Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281E54AE57E
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 00:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbiBHXfy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 18:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbiBHXfy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 18:35:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E97AC061576
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 15:35:53 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218M7bNe006750;
        Tue, 8 Feb 2022 23:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=zgrAGNkq699DJYT1BPfwIeuaxTVDY1xeKNMo7wJ9CXQ=;
 b=PViomtxrPOR3c6OG6TJzN/8YVheegMYo+WepOoc4U7Ydm1bDzTA+oqO+HVyH9Z/GL/CD
 3Orrm0COtvsBdHLfj8MRlzPM8W+4rE+1z47K0HJ/PqyCSDsFrlwW2b9dZvJXWm9//X39
 6xoLKOqzXbrXZm/6Dj2v4UiCEyjrJbDCaScoTor0bw0U76Gxr+KQaPWpjcw2GnbQYyPz
 GoQjREUi2lLzsQAh4Egv+9Wwcf6cy3/WQ1FpSt7ZzRRZKSDZJOoRZ7Yfcl4RIlV7nMcO
 h09dwIQT/11+r5g1p8xmwqSr/SW3arux4Dry3P7kEZoE6pRR5hlT8J/RzrkGRDjUzQfW fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e3uv81gxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 23:35:11 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 218MoPvj005176;
        Tue, 8 Feb 2022 23:35:11 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e3uv81gxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 23:35:10 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 218NWpxg031556;
        Tue, 8 Feb 2022 23:35:09 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3e1ggk21tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 23:35:09 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 218NZ5XJ42402140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 23:35:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FF2652052;
        Tue,  8 Feb 2022 23:35:05 +0000 (GMT)
Received: from [9.171.78.41] (unknown [9.171.78.41])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 071A052050;
        Tue,  8 Feb 2022 23:35:04 +0000 (GMT)
Message-ID: <5a68b6dfc4b0257601015f99cdd4bfcb50103840.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v4 08/14] libbpf: Use struct pt_regs when
 compiling with kernel headers
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, bpf <bpf@vger.kernel.org>
Date:   Wed, 09 Feb 2022 00:35:04 +0100
In-Reply-To: <CAEf4Bzbt4Bj=a0QmmDyrRE0dk1khvKE6XqErH2vimGp-Smi+oQ@mail.gmail.com>
References: <20220208051635.2160304-1-iii@linux.ibm.com>
         <20220208051635.2160304-9-iii@linux.ibm.com>
         <CAEf4Bzbt4Bj=a0QmmDyrRE0dk1khvKE6XqErH2vimGp-Smi+oQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -NlHzfPWgHle-lJokJUsAAzMmUSeee38
X-Proofpoint-ORIG-GUID: BAp_RaRGO-PtKNL2nPAKkH9WeN1maVHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_07,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080135
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-02-08 at 14:12 -0800, Andrii Nakryiko wrote:
> On Mon, Feb 7, 2022 at 9:16 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > Andrii says: "... with CO-RE and vmlinux.h it would be more
> > reliable
> > and straightforward to just stick to kernel-internal struct pt_regs
> > everywhere ...".
> > 
> > Actually, if vmlinux.h is available, then it's ok to do so for both
> > CO-RE and non-CO-RE cases, since the beginning of struct pt_regs
> > must
> > match (struct) user_pt_regs, which must never change.
> > 
> > Implement this by not defining __PT_REGS_CAST if the user included
> > vmlinux.h.
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> 
> If we are using CO-RE we don't have to assume vmlinux.h, we can
> define
> our own definition of pt_regs with custom "flavor":
> 
> struct pt_regs___s390x {
>     long gprs[10];
>     long orig_gpr2; /* whatever the right types and names, but order
> doesn't matter */
> } __attribute__((preserve_access_index));
> 
> 
> And then use `struct pt_regs__s390x` for s390x macros. That way we
> don't assume any specific included header, we have minimal definition
> we need (and it can be different for each architecture. It's still
> CO-RE, still relocatable, and we don't need all these ugly #if
> defined() checks.

I haven't considered using flavors - this will indeed improve the CO-RE
side of things, thanks!

> 
> >  tools/lib/bpf/bpf_tracing.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/tools/lib/bpf/bpf_tracing.h
> > b/tools/lib/bpf/bpf_tracing.h
> > index 7a015ee8fb11..07e291d77e83 100644
> > --- a/tools/lib/bpf/bpf_tracing.h
> > +++ b/tools/lib/bpf/bpf_tracing.h
> > @@ -118,8 +118,11 @@
> > 
> >  #define __BPF_ARCH_HAS_SYSCALL_WRAPPER
> > 
> > +#if !defined(__KERNEL__) && !defined(__VMLINUX_H__)
> >  /* s390 provides user_pt_regs instead of struct pt_regs to
> > userspace */
> >  #define __PT_REGS_CAST(x) ((const user_pt_regs *)(x))
> > +#endif
> > +
> >  #define __PT_PARM1_REG gprs[2]
> >  #define __PT_PARM2_REG gprs[3]
> >  #define __PT_PARM3_REG gprs[4]
> > @@ -148,8 +151,11 @@
> > 
> >  #define __BPF_ARCH_HAS_SYSCALL_WRAPPER
> > 
> > +#if !defined(__KERNEL__) && !defined(__VMLINUX_H__)
> >  /* arm64 provides struct user_pt_regs instead of struct pt_regs to
> > userspace */
> >  #define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
> > +#endif
> > +
> >  #define __PT_PARM1_REG regs[0]
> >  #define __PT_PARM2_REG regs[1]
> >  #define __PT_PARM3_REG regs[2]
> > @@ -207,7 +213,10 @@
> > 
> >  #elif defined(bpf_target_riscv)
> > 
> > +#if !defined(__KERNEL__) && !defined(__VMLINUX_H__)
> >  #define __PT_REGS_CAST(x) ((const struct user_regs_struct *)(x))
> > +#endif
> > +
> >  #define __PT_PARM1_REG a0
> >  #define __PT_PARM2_REG a1
> >  #define __PT_PARM3_REG a2
> > --
> > 2.34.1
> > 

