Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2260D31D145
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 20:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhBPT41 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 14:56:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229811AbhBPT41 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 16 Feb 2021 14:56:27 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11GJW3Ds165880;
        Tue, 16 Feb 2021 14:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=FJasGMz6yQ2mJBAMr8M5KHdBzgAua7aGkxTsa/2cCog=;
 b=N61vDsbTWf3iUTNkdkO1Qz4O1f0fN1rvkD+C2PGVLqsxddBf4Lsz1p4ygjIZQrAB/Nyn
 /+PlQgBqfX18eWiRWbh+Ajgb/DrhS8GbkAXW3Hfv7fF7MGPqcXhz0ZNxV4UE90qgMaY6
 vQA/i/DDHDrYWnV0fX6bE5qrhrycT/ultjzm5u7WsWZNZk6/zZoi/ASgF5fxozIvHtKW
 NAPmPAi7+logn/lcxjkd/VHVRFt8jkX7XVWvECpEpib43/g6c5WSGxbnx1VhH03Poj99
 Rzj9oG0VNPBkpsxFD6AaPfpAYFJId8SQQdfXS7fWR1q0dJaYDlHV7+DxCmm1dEbOdYfr KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36rm0ph36d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 14:55:33 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11GJYWsb182787;
        Tue, 16 Feb 2021 14:55:32 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36rm0ph35p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 14:55:32 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11GJleDE003317;
        Tue, 16 Feb 2021 19:55:29 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 36p6d8b27s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 19:55:29 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11GJtRVe48693514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 19:55:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7647B52052;
        Tue, 16 Feb 2021 19:55:27 +0000 (GMT)
Received: from [9.171.64.123] (unknown [9.171.64.123])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 142CB5204E;
        Tue, 16 Feb 2021 19:55:27 +0000 (GMT)
Message-ID: <7bcfe4bfd5a2c4768fb07908b709e10ec089903b.camel@linux.ibm.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit
 cmpxchg
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Date:   Tue, 16 Feb 2021 20:55:26 +0100
In-Reply-To: <20210216141925.1549405-1-jackmanb@google.com>
References: <20210216141925.1549405-1-jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-16_09:2021-02-16,2021-02-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160158
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2021-02-16 at 14:19 +0000, Brendan Jackman wrote:
> As pointed out by Ilya and explained in the new comment, there's a
> discrepancy between x86 and BPF CMPXCHG semantics: BPF always loads
> the value from memory into r0, while x86 only does so when r0 and the
> value in memory are different. The same issue affects s390.
> 
> At first this might sound like pure semantics, but it makes a real
> difference when the comparison is 32-bit, since the load will
> zero-extend r0/rax.
> 
> The fix is to explicitly zero-extend rax after doing such a
> CMPXCHG. Since this problem affects multiple archs, this is done in
> the verifier by patching in a BPF_ZEXT_REG instruction after every
> 32-bit cmpxchg. Any archs that don't need such manual zero-extension
> can do a look-ahead with insn_is_zext to skip the unnecessary mov.
> 
> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
> 
> Difference from v1[1]: Now solved centrally in the verifier instead
> of
>   specifically for the x86 JIT. Thanks to Ilya and Daniel for the
> suggestions!
> 
> [1] 
> https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t
> 
>  kernel/bpf/verifier.c                         | 36
> +++++++++++++++++++
>  .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25 +++++++++++++
>  .../selftests/bpf/verifier/atomic_or.c        | 26 ++++++++++++++
>  3 files changed, 87 insertions(+)

I tried this with my s390 atomics patch, and it's working, thanks!

I was thinking whether this could go through the existing zext_dst
flag infrastructure, but it probably won't play too nicely with the
x86_64 JIT, which doesn't override bpf_jit_needs_zext().

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>

[...]

