Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBCE4AD8E3
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 14:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349676AbiBHNQG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 08:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376570AbiBHNKo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 08:10:44 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B33C03FECE
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 05:10:44 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218D38h9023001;
        Tue, 8 Feb 2022 13:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=io5lnY67HJOeqqX11zdSbLLWaSJVzdC2AnGsBNC6PQw=;
 b=WdVvxPHMSBeJ+pj/Z9kO92kD7luQCWVYpuynwbphfUWK6UerjDVmlAIK6vC1QP6T8YIW
 j6q5SyElvtHv7Y8ggGt5ODkR3X2iVOuPJuvX8RXsurAOYMqw+HlxQTxiU0OKJYSAsISu
 J3DAMi51GbqJYPUnldA36H1PD+aulb7rDxe6WkfgwTCrvOQgdEwgUxWu+uQX192kzVOp
 4g5qbbB8ipFpnvH1xGFIomWuzXO0MXATvwTPNct7d36WPsggY1hv1iGN2C42qfE1TkHY
 LiPfGkx/YHxArjPIblNiRC5vzVuu99MOaAHhaH9EndAo+3WhNco78fS2dhaniA5FPBRh zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22kqs9yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 13:10:24 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 218CKMYq019544;
        Tue, 8 Feb 2022 13:10:23 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22kqs9xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 13:10:23 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 218D8vN0001081;
        Tue, 8 Feb 2022 13:10:20 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3e1gv95vj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 13:10:20 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 218DAEAU34668872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 13:10:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 459ADAE063;
        Tue,  8 Feb 2022 13:10:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2695AE05A;
        Tue,  8 Feb 2022 13:10:13 +0000 (GMT)
Received: from [9.171.78.41] (unknown [9.171.78.41])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 13:10:13 +0000 (GMT)
Message-ID: <c65b4185d76c52f91bc0873ad28508a205d1e120.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v4 11/14] libbpf: Fix accessing the first
 syscall argument on s390
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Date:   Tue, 08 Feb 2022 14:10:13 +0100
In-Reply-To: <20220208051635.2160304-12-iii@linux.ibm.com>
References: <20220208051635.2160304-1-iii@linux.ibm.com>
         <20220208051635.2160304-12-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 17qip6200OY7_LxIAKWm9NncRF6G2zTZ
X-Proofpoint-ORIG-GUID: -I3Q45ELawpm-xa9TUiel2RqW95QBl11
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_04,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-02-08 at 06:16 +0100, Ilya Leoshkevich wrote:
> On s390, the first syscall argument should be accessed via orig_gpr2
> (see arch/s390/include/asm/syscall.h). Currently gpr[2] is used
> instead, leading to bpf_syscall_macro test failure.
> 
> Note that this is unfixable for CO-RE when vmlinux.h is not included.
> Simply fail the build in this case.
> 
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/bpf_tracing.h
> b/tools/lib/bpf/bpf_tracing.h
> index 88ed5ba9510c..5911b177728f 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -2,6 +2,8 @@
>  #ifndef __BPF_TRACING_H__
>  #define __BPF_TRACING_H__
>  
> +#include <bpf/bpf_common_helpers.h>
> +
>  /* Scan the ARCH passed in from ARCH env variable (see Makefile) */
>  #if defined(__TARGET_ARCH_x86)
>         #define bpf_target_x86
> @@ -118,9 +120,20 @@
>  
>  #define __BPF_ARCH_HAS_SYSCALL_WRAPPER
>  
> -#if !defined(__KERNEL__) && !defined(__VMLINUX_H__)
> +#if defined(__KERNEL__) || defined(__VMLINUX_H__)
> +#define __PT_PARM1_REG_SYSCALL orig_gpr2
> +#else
>  /* s390 provides user_pt_regs instead of struct pt_regs to userspace
> */
>  #define __PT_REGS_CAST(x) ((const user_pt_regs *)(x))
> +/*
> + * struct pt_regs.orig_gpr2 is not exposed through user_pt_regs, and
> the ABI
> + * prohibits extending user_pt_regs. In non-CO-RE case, make use of
> the fact
> + * that orig_gpr2 comes right after gprs in struct pt_regs. CO-RE
> does not
> + * allow such hacks, so there is no way to access orig_gpr2.
> + */
> +#define PT_REGS_PARM1_SYSCALL(x) \
> +       (*(unsigned long *)(((char *)(x) + offsetofend(user_pt_regs,
> gprs))))
> +#define __PT_PARM1_REG_SYSCALL __unsupported__
>  #endif
>  
>  #define __PT_PARM1_REG gprs[2]

This might be too pessimistic.

While I don't see a way to add real CO-RE support here, and doing
something like __CORE_RELO(gprs, BYTE_OFFSET) + __CORE_RELO(gprs,
BYTE_SIZE) defeats the purpose of using CO-RE, we promise not to move
orig_gpr2 around. So just this:

#define PT_REGS_PARM1_CORE_SYSCALL(x) ({\
	unsigned long __tmp; \
	bpf_probe_read_kernel(&tmp, sizeof(__tmp),
&PT_REGS_PARM1_SYSCALL(x)); \
	tmp; \
})

does the trick here in a sense that, having been compiled once, it
would run everywhere. What do you think?
