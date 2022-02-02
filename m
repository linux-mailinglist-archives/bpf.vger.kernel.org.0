Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B78B4A72E0
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 15:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344850AbiBBOTj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 09:19:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33542 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344866AbiBBOTa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 09:19:30 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212CeQUR014759;
        Wed, 2 Feb 2022 14:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=I/mu5q+yvmG72n6jgiUrdW1v/7+WWly2Iyic2t43xGM=;
 b=B/PxEW5tTEw5bD4fVdftFiHbB3iuXajf9bOWzNDascqj3J8XrzebbgsMXrv4DUcb2Yi6
 U2D4TJfp+gHW+4/i3vSoz/bfe/RcCh9Te5buHMW1rYzG6qI/OPSbcptf/2jgysQacfnW
 6B5c6qT646dCbWrXmHCs+9e37bRHmNKfFcPKcNbPJY7bQ64FsuffqVY0EmS+eV/chaFs
 hwxugL3KufNQG965ET6eIiAJX6UbDrj8eILY7UEg0T3K5uRWVox835DH7aJaX6LKgA7m
 7SQR+vYSBjll2XnzE79Tb2Uw/dg9M3vVqSel/iUwR6rqSIihmz/1yEBC0D9Q4qmUqJgc Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dysraajw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 14:19:12 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 212DTPwq039381;
        Wed, 2 Feb 2022 14:19:11 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dysraajvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 14:19:11 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 212EDFBa024347;
        Wed, 2 Feb 2022 14:19:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3dvw79wuj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 14:19:09 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 212EJ6jC19202548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Feb 2022 14:19:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A07DA405C;
        Wed,  2 Feb 2022 14:19:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28161A405B;
        Wed,  2 Feb 2022 14:19:06 +0000 (GMT)
Received: from localhost (unknown [9.171.17.127])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Feb 2022 14:19:06 +0000 (GMT)
Date:   Wed, 2 Feb 2022 15:19:04 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH bpf-next 1/3] s390/bpf: Add orig_gpr2 to user_pt_regs
Message-ID: <your-ad-here.call-01643811544-ext-7630@work.hours>
References: <20220201234200.1836443-1-iii@linux.ibm.com>
 <20220201234200.1836443-2-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220201234200.1836443-2-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -c-zP2TbeIo64_0GHL2mTTLecR0WhRce
X-Proofpoint-GUID: AO7uChh7Mb66jT9nnVDE2i5Go14J2dPj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_06,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 mlxlogscore=944 mlxscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020078
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 02, 2022 at 12:41:58AM +0100, Ilya Leoshkevich wrote:
> user_pt_regs is used by eBPF in order to access userspace registers -
> see commit 466698e654e8 ("s390/bpf: correct broken uapi for
> BPF_PROG_TYPE_PERF_EVENT program type"). In order to access the first
> syscall argument from eBPF programs, we need to export orig_gpr2.

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

It could be a good opportunity to get rid of that "args[1]" which is not
used for syscall parameters handling since commit baa071588c3f ("[S390]
cleanup system call parameter setup") [v2.6.37], as well as completely
unused now, and shouldn't really be exported to eBPF. And luckily eBPF
never used it.

So, how about reusing "args[1]" slot for orig_gpr2 instead?
