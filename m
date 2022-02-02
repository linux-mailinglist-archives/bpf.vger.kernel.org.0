Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C9A4A7942
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 21:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344869AbiBBUPS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 15:15:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236790AbiBBUPS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 15:15:18 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212JwQBa006846;
        Wed, 2 Feb 2022 20:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=jQDSPRTLZzlBRVEPxF5Nk1BmDHz5yP93GfKt4Mpu8xo=;
 b=knDuO1Yyi8qjdMO5f2UGlAwKSri2PWBP139MVRP8jgNER2GscTeW2ShMeWnb6q0c4Yjc
 cKxQ1Llu1zLhGMcAXKXBja26FVPu4WqDOCaT/GS54FGfi9z3uFsFDjkqcHHUX16sRPPw
 e/vpaq4/+BIleNpjOJDY+nEVjPThAhbiJe04UzhwKlqUnqqffwf4gknFzfUwRdRGvlq/
 XuuYlsxMbdyikpw27q4wqnyH4xBtjj2Isr3+QhGNdQUXB7YjBakf8dmqF58gzTn3EUyg
 r/o4H+M9bGlwgPgAEvQy7PHimN9xoVSPQ2yPnDIhS96fqyRD0lnV06Q7nNx63pN9W2ai bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dyveh64gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 20:14:59 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 212JwWRp007328;
        Wed, 2 Feb 2022 20:14:58 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dyveh64fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 20:14:58 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 212K7C4i019138;
        Wed, 2 Feb 2022 20:14:56 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3dvw79pnx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 20:14:56 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 212KErhj44368268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Feb 2022 20:14:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5041F4C050;
        Wed,  2 Feb 2022 20:14:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A92EA4C046;
        Wed,  2 Feb 2022 20:14:52 +0000 (GMT)
Received: from osiris (unknown [9.145.72.91])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Feb 2022 20:14:52 +0000 (GMT)
Date:   Wed, 2 Feb 2022 21:14:51 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        bpf@vger.kernel.org, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH bpf-next 1/3] s390/bpf: Add orig_gpr2 to user_pt_regs
Message-ID: <YfrmO+pcSqrrbC3E@osiris>
References: <20220201234200.1836443-1-iii@linux.ibm.com>
 <20220201234200.1836443-2-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201234200.1836443-2-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mThhunb_pLMNwp_edE1Dz8DPpqu7wQYJ
X-Proofpoint-ORIG-GUID: AgG9nBc2VSo0g2DjOn_Tb9kpuDVfKGXG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=768 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020109
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 02, 2022 at 12:41:58AM +0100, Ilya Leoshkevich wrote:
> user_pt_regs is used by eBPF in order to access userspace registers -
> see commit 466698e654e8 ("s390/bpf: correct broken uapi for
> BPF_PROG_TYPE_PERF_EVENT program type"). In order to access the first
> syscall argument from eBPF programs, we need to export orig_gpr2.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/include/asm/ptrace.h      | 2 +-
>  arch/s390/include/uapi/asm/ptrace.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
> index 4ffa8e7f0ed3..c8698e643904 100644
> --- a/arch/s390/include/asm/ptrace.h
> +++ b/arch/s390/include/asm/ptrace.h
> @@ -83,9 +83,9 @@ struct pt_regs {
>  			unsigned long args[1];
>  			psw_t psw;
>  			unsigned long gprs[NUM_GPRS];
> +			unsigned long orig_gpr2;
>  		};
>  	};
> -	unsigned long orig_gpr2;
>  	union {
>  		struct {
>  			unsigned int int_code;
> diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
> index ad64d673b5e6..b3dec603f507 100644
> --- a/arch/s390/include/uapi/asm/ptrace.h
> +++ b/arch/s390/include/uapi/asm/ptrace.h
> @@ -295,6 +295,7 @@ typedef struct {
>  	unsigned long args[1];
>  	psw_t psw;
>  	unsigned long gprs[NUM_GPRS];
> +	unsigned long orig_gpr2;
>  } user_pt_regs;

Isn't this broken on nearly all architectures? I just checked powerpc,
arm64, and riscv. While powerpc seems to mirror pt_regs as user_pt_regs,
and therefore exports orig_gpr3, the bpf macros still seem to access the
wrong location to access the first syscall parameter(?).

For arm64 and riscv it seems that orig_x0 or orig_a0 respectively need to
be added to user_pt_regs too, and the same fix like for s390 needs to be
applied as well.
