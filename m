Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B56156A740
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 17:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbiGGPv0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 11:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbiGGPv0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 11:51:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2285420BC2
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 08:51:25 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267EMfFW022578;
        Thu, 7 Jul 2022 15:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jf+wEizyDI0ZDzx/X6OYGFl9KRq2rYgZ8LrBreZwSxU=;
 b=mbZ7HARkjHfIrKnqa4ecuHlK1PfhcaRvvnzKYf7YzMnaG7BJjB2NCyKUK5Bl8HAm8QxY
 rwzevAOqs/4f2txhs+T5pTrqapxx8J/AicJku15Txc5OJCM+CtmtRAToiLAuFyoMG2AG
 axrfWKEtd3rIbgiS23kJs9iZ0zoOebBlsTs+37buCTbuwAbHPA7pt1C7JKe3TohVV4WZ
 Uj0XWXaZ4MRb/+6E3lO6hVvHZCKl/1qqlK2wIDCdZbQRpf9i+OzhULN/AGRHaHCGzzNi
 RVFxCik93/LbTq2HjOohThHk+ELKWlwaDAq02hEQRn8+gvH/OHY+e58a0d/CscvQ3s+H uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h612q3ee2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 15:51:08 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267EsoFk010300;
        Thu, 7 Jul 2022 15:51:07 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h612q3ede-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 15:51:07 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267FJeCE011703;
        Thu, 7 Jul 2022 15:51:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3h4ujsjsuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 15:51:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267FniU223200164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 15:49:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 008B3A4040;
        Thu,  7 Jul 2022 15:51:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B610DA4051;
        Thu,  7 Jul 2022 15:51:02 +0000 (GMT)
Received: from [9.155.208.113] (unknown [9.155.208.113])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 15:51:02 +0000 (GMT)
Message-ID: <50414987fbd393cde6d28ac9877e9f9b1527cb28.camel@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 0/3] libbpf: add better syscall kprobing
 support
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Kenta Tada <kenta.tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Date:   Thu, 07 Jul 2022 17:51:02 +0200
In-Reply-To: <20220707004118.298323-1-andrii@kernel.org>
References: <20220707004118.298323-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3f45W0_h-VzrRwyOKjGZ8JANLyrn1H6S
X-Proofpoint-ORIG-GUID: 682wOXb_YAbVyzcGcGlTszVngFncAERu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-07-06 at 17:41 -0700, Andrii Nakryiko wrote:
> This RFC patch set is to gather feedback about new
> SEC("ksyscall") and SEC("kretsyscall") section definitions meant to
> simplify
> life of BPF users that want to trace Linux syscalls without having to
> know or
> care about things like CONFIG_ARCH_HAS_SYSCALL_WRAPPER and related
> arch-specific
> vs arch-agnostic __<arch>_sys_xxx vs __se_sys_xxx function names,
> calling
> convention woes ("nested" pt_regs), etc. All this is quite annoying
> to
> remember and care about as BPF user, especially if the goal is to
> write
> achitecture- and kernel version-agnostic BPF code (e.g., things like
> libbpf-tools, etc).
> 
> By using SEC("ksyscall/xxx")/SEC("kretsyscall/xxx") user clearly
> communicates
> the desire to kprobe/kretprobe kernel function that corresponds to
> the
> specified syscall. Libbpf will take care of all the details of
> determining
> correct function name and calling conventions.
> 
> This patch set also improves BPF_KPROBE_SYSCALL (and renames it to
> BPF_KSYSCALL to match SEC("ksyscall")) macro to take into account
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER instead of hard-coding whether host
> architecture is expected to use syscall wrapper or not (which is less
> reliable
> and can change over time).
> 
> It would be great to get feedback about the overall feature, but also
> I'd
> appreciate help with testing this, especially for non-x86_64
> architectures.
> 
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Kenta Tada <kenta.tada@sony.com>
> Cc: Hengqi Chen <hengqi.chen@gmail.com>
> 
> Andrii Nakryiko (3):
>   libbpf: improve and rename BPF_KPROBE_SYSCALL
>   libbpf: add ksyscall/kretsyscall sections support for syscall
> kprobes
>   selftests/bpf: use BPF_KSYSCALL and SEC("ksyscall") in selftests
> 
>  tools/lib/bpf/bpf_tracing.h                   |  44 +++++--
>  tools/lib/bpf/libbpf.c                        | 109
> ++++++++++++++++++
>  tools/lib/bpf/libbpf.h                        |  16 +++
>  tools/lib/bpf/libbpf.map                      |   1 +
>  tools/lib/bpf/libbpf_internal.h               |   2 +
>  .../selftests/bpf/progs/bpf_syscall_macro.c   |   6 +-
>  .../selftests/bpf/progs/test_attach_probe.c   |   6 +-
>  .../selftests/bpf/progs/test_probe_user.c     |  27 +----
>  8 files changed, 172 insertions(+), 39 deletions(-)

Hi Andrii,

Looks interesting, I will give it a try on s390x a bit later.

In the meantime just one remark: if we want to create a truly seamless
solution, we might need to take care of quirks associated with the
following kernel #defines:

* __ARCH_WANT_SYS_OLD_MMAP (real arguments are in memory)
* CONFIG_CLONE_BACKWARDS (child_tidptr/tls swapped)
* CONFIG_CLONE_BACKWARDS2 (newsp/clone_flags swapped)
* CONFIG_CLONE_BACKWARDS3 (extra arg: stack_size)

or at least document that users need to be careful with mmap() and
clone() probes. Also, there might be more of that out there, but that's
what I'm constantly running into on s390x.

Best regards,
Ilya
