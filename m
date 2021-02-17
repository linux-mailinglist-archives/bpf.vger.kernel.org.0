Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A3F31DF1E
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 19:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhBQSb3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 13:31:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231562AbhBQSb3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Feb 2021 13:31:29 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11HIEMrf166837;
        Wed, 17 Feb 2021 13:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ZwXqOxSXQiFojdectj5qglC19JaxNzi8zZ9eSEwI3Xo=;
 b=fEeT4uSHb2lWB71KWwoKta8/WmR2Ie5GyZ0wupppU8Yami338uqra2rkdS+4Q2eJQiuw
 uXAp31XquwYW1eEEvppelxOM7QnBN6cVM/PH/QuO0XtgjSKzE3k8w/YmauaMC6ZJ42GI
 r7HtLj4O3/BhucAM3Fd4iMnDSLl62iMsQ+Y1utUhKmXhOZZ/Zcabl6e8PePc1lRpjQ5F
 3gg4bWUe8gmZ724hbrSSGZbyjN2VDNxY9RzV0I3NFtvOzbzOnRPYtKadcRG8oajTR1DD
 7qhGI5hMq6xmnBxS9r0+HJGWWrvksJb+J6j/W9jtGnWKjRwC9H/wZa6tMwT2oKt6pS6O 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36s887rery-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 13:30:32 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11HIGP59174431;
        Wed, 17 Feb 2021 13:30:32 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36s887repq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 13:30:32 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11HIRZAx017340;
        Wed, 17 Feb 2021 18:30:29 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 36rw3u8j3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 18:30:29 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11HIUG2o34406792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Feb 2021 18:30:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FE87A4051;
        Wed, 17 Feb 2021 18:30:27 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08297A4055;
        Wed, 17 Feb 2021 18:30:27 +0000 (GMT)
Received: from [9.171.64.123] (unknown [9.171.64.123])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Feb 2021 18:30:26 +0000 (GMT)
Message-ID: <c20a494cfeb112093dcefe45838c63f62d781621.camel@linux.ibm.com>
Subject: Re: [PATCH v3 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit
 cmpxchg
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Date:   Wed, 17 Feb 2021 19:30:26 +0100
In-Reply-To: <20210217092831.2366396-1-jackmanb@google.com>
References: <20210217092831.2366396-1-jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_13:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102170131
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2021-02-17 at 09:28 +0000, Brendan Jackman wrote:
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
> Differences v2->v3[1]:
>  - Moved patching into fixup_bpf_calls (patch incoming to rename this
> function)
>  - Added extra commentary on bpf_jit_needs_zext
>  - Added check to avoid adding a pointless zext(r0) if there's
> already one there.
> 
> Difference v1->v2[1]: Now solved centrally in the verifier instead of
>   specifically for the x86 JIT. Thanks to Ilya and Daniel for the
> suggestions!
> 
> [1] v2: 
> https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
>     v1: 
> https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t
> 
>  kernel/bpf/core.c                             |  4 +++
>  kernel/bpf/verifier.c                         | 26
> +++++++++++++++++++
>  .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25
> ++++++++++++++++++
>  .../selftests/bpf/verifier/atomic_or.c        | 26
> +++++++++++++++++++
>  4 files changed, 81 insertions(+)

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 16ba43352a5f..a0d19be13558 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11662,6 +11662,32 @@ static int fixup_bpf_calls(struct
> bpf_verifier_env *env)
>                         continue;
>                 }
> 
> +               /* BPF_CMPXCHG always loads a value into R0,
> therefore always
> +                * zero-extends. However some archs' equivalent
> instruction only
> +                * does this load when the comparison is successful.
> So here we
> +                * add a BPF_ZEXT_REG after every 32-bit CMPXCHG, so
> that such
> +                * archs' JITs don't need to deal with the issue.
> Archs that
> +                * don't face this issue may use insn_is_zext to
> detect and skip
> +                * the added instruction.
> +                */
> +               if (insn->code == (BPF_STX | BPF_W | BPF_ATOMIC) &&
> insn->imm == BPF_CMPXCHG) {
> +                       struct bpf_insn zext_patch[2] = { [1] =
> BPF_ZEXT_REG(BPF_REG_0) };
> +
> +                       if (!memcmp(&insn[1], &zext_patch[1],
> sizeof(struct bpf_insn)))
> +                               /* Probably done by
> opt_subreg_zext_lo32_rnd_hi32. */
> +                               continue;
> +

Isn't opt_subreg_zext_lo32_rnd_hi32() called after fixup_bpf_calls()?

[...]

