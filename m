Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2B64AA51D
	for <lists+bpf@lfdr.de>; Sat,  5 Feb 2022 01:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiBEAgl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 19:36:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30438 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230266AbiBEAgk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 19:36:40 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214NnKrQ023803;
        Sat, 5 Feb 2022 00:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=19D2PusZXb2cI6QW+3CBlSsDPrdO7trXqWy92AKGvk4=;
 b=lkP7pO9Gzv3Dr14fpwGziUV+bbH2sUVWoZwrhX+zeKwt1YtaPFN6iZv2kc1UFfoMqcmv
 RPPY3odaIFzWm6EEyn37NbIAxH24efWLlO0E0jxKusXi1eGdwhbcfInN8pZPSiS2Pft5
 2mUprPR2//b+nLa4a520BOpyOY1r+yXO06PVa7jG+yBnURFyN1AKOADsn6pwdPR/RrjY
 Bvphfn3oiM/YeHEH8Akaov6oJgTHQdpSXCPt2oE2ZgOyGeYbpsOcxYZPPvZP4Cro4G/y
 vpAPgRMPcNsPAWJrS00hNOey5MQ3l8d935sBf57RS6LaJR+fpHN5lRdjGuyLyrqDy1Hg sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0rj617nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 00:36:20 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2150aKSE022980;
        Sat, 5 Feb 2022 00:36:20 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0rj617n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 00:36:20 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2150TIZ7018226;
        Sat, 5 Feb 2022 00:36:17 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3e0r0u8c7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 00:36:17 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2150aExV46072182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 00:36:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FF3B5204F;
        Sat,  5 Feb 2022 00:36:14 +0000 (GMT)
Received: from osiris (unknown [9.145.82.196])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id D76FE5204E;
        Sat,  5 Feb 2022 00:36:13 +0000 (GMT)
Date:   Sat, 5 Feb 2022 01:36:12 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 02/11] s390/bpf: Add orig_gpr2 to user_pt_regs
Message-ID: <Yf3GfAkkAyXP91mW@osiris>
References: <20220204145018.1983773-1-iii@linux.ibm.com>
 <20220204145018.1983773-3-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204145018.1983773-3-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bv8q41x_521BhacVNeeIJeOGw8X3W63C
X-Proofpoint-GUID: ZzT731UMlUUDs5YpC9IUpmz1MEUfvB9I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=805 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202050000
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 04, 2022 at 03:50:09PM +0100, Ilya Leoshkevich wrote:
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

Acked-by: Heiko Carstens <hca@linux.ibm.com>
