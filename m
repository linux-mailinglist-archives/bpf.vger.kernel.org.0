Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDC14AA8C8
	for <lists+bpf@lfdr.de>; Sat,  5 Feb 2022 13:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiBEMhy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Feb 2022 07:37:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25442 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232229AbiBEMhx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 5 Feb 2022 07:37:53 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 215AYQwb004642;
        Sat, 5 Feb 2022 12:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=UOzQXehQQiMF+U2dTPxLPUXcUb3QgMjoDAxXbc2K7YQ=;
 b=c7X2K90wa9LBfnmKT3Wjnbjh3YO9IMfkzNsLT9hGdeEvLKl74sYBieRBRO1fioQRKBug
 yUN3Tdbxvn8h2UgyNelVgACerg8bgEotgTqjtU/9TIcGVnjicYI28r5yn8W6YP/m+Yc8
 EewlaBZb31duahLl0/EZglDaSmUKHwMEIvBFcyYZ5JbesIvQVsV90V7MWW6qahc9fT0S
 M1YqWMWZ6vE90bu2dBwUPtgBwoaS4S+uPVSIyuSL8bBQ0hl7uftchO+4b2zatk8bxFnl
 K3WfgHv8vZRhY/AK3sTilGLN6glvdFnJv4fcO5ga5ifeBTGJ8NPsTudGCqI5C0xxDfrf /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1hq7nvxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 12:37:27 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 215CZ3Ds024916;
        Sat, 5 Feb 2022 12:37:26 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1hq7nvxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 12:37:26 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 215CHdZY004244;
        Sat, 5 Feb 2022 12:37:25 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3e1gghhuf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 12:37:25 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 215CRNLs38797606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 12:27:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCC294C046;
        Sat,  5 Feb 2022 12:37:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BD024C044;
        Sat,  5 Feb 2022 12:37:21 +0000 (GMT)
Received: from localhost (unknown [9.171.4.88])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  5 Feb 2022 12:37:21 +0000 (GMT)
Date:   Sat, 5 Feb 2022 13:37:20 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 02/11] s390/bpf: Add orig_gpr2 to user_pt_regs
Message-ID: <your-ad-here.call-01644064640-ext-0194@work.hours>
References: <20220204145018.1983773-1-iii@linux.ibm.com>
 <20220204145018.1983773-3-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220204145018.1983773-3-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yQe7oe3RDCR79BTfz5PaJzBpgJgu6GhQ
X-Proofpoint-ORIG-GUID: h0_rlAEtT75yaVmtxk96e9v6TPJ212Xo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=846 impostorscore=0
 spamscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202050084
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

Acked-by: Vasily Gorbik <gor@linux.ibm.com>
