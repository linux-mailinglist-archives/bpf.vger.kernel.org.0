Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957CD3EA72D
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 17:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhHLPKE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Aug 2021 11:10:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237682AbhHLPKE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Aug 2021 11:10:04 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CF3wXd161614;
        Thu, 12 Aug 2021 11:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=C8E+QM2xwcm0ixap6NSYpO8bppkpkB4zb/AQw2TJmaI=;
 b=cJJBXknPxdf32Oh/7/BY8BAV2oKzHN03+WlVGgg+FG+ejlKV349iipeqJNXEHTHlpu6z
 5e/w+29B2khkJ8Tdeik9f7JfOuJMSx/Pb/jhSr2KALdbHZTxbnMQWt5K8xfWDfP9MfbK
 MwJRCSZmOQqiqLECjdiqQU5eh2QZbhPK8RqV6abK2/1UxZLGCJvCN0um0UVO86dhBL2F
 9JHSodjqMtHCtHbVfe2hOSNM6LGL35/HD/9uLmtMm2oZjc1uady1wJhnqv049/HvqJ1k
 b4m33pSZmFVeVn11wazvTmjDadMT8VVapEQ7i6wZQl5lEBgrltZn7czzetMMdhbtPERn WQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ad4hxk5mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 11:09:27 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17CF51xd016834;
        Thu, 12 Aug 2021 15:09:25 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3acf0ktn3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 15:09:25 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17CF9L9v44368294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 15:09:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83C3652052;
        Thu, 12 Aug 2021 15:09:21 +0000 (GMT)
Received: from sig-9-145-77-113.uk.ibm.com (unknown [9.145.77.113])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 36C9D5204F;
        Thu, 12 Aug 2021 15:09:21 +0000 (GMT)
Message-ID: <ad395f50f2a717aefbdfafca042c34ae538ce40c.camel@linux.ibm.com>
Subject: Re: [PATCH bpf 2/2] selftests: bpf: test that dead ldx_w insns are
 accepted
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Thu, 12 Aug 2021 17:09:20 +0200
In-Reply-To: <20210812140518.183178-3-iii@linux.ibm.com>
References: <20210812140518.183178-1-iii@linux.ibm.com>
         <20210812140518.183178-3-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GmzDBPSO2lqzXXSGfji8hleu_iYVo3Vc
X-Proofpoint-GUID: GmzDBPSO2lqzXXSGfji8hleu_iYVo3Vc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_05:2021-08-12,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120098
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2021-08-12 at 16:05 +0200, Ilya Leoshkevich wrote:
> Prevent regressions related to zero-extension metadata handling during
> dead code sanitization.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/verifier/dead_code.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/verifier/dead_code.c
> b/tools/testing/selftests/bpf/verifier/dead_code.c
> index 2c8935b3e65d..c642138b7fc2 100644
> --- a/tools/testing/selftests/bpf/verifier/dead_code.c
> +++ b/tools/testing/selftests/bpf/verifier/dead_code.c
> @@ -159,3 +159,16 @@
>         .result = ACCEPT,
>         .retval = 2,
>  },
> +{
> +       "dead code: zero extension",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 0, 1),
> +       BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .errstr_unpriv = "invalid read from stack R10 off=0 size=4",
> +       .result_unpriv = REJECT,
> +       .result = ACCEPT,
> +       .retval = 0,
> +},

Please disregard this patch: the test does not fail in absence of the
fix. What rather fails is:

	BPF_MOV64_IMM(BPF_REG_0, 0),
	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4),
	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 0, 1),
	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -4),
	BPF_EXIT_INSN(),

The difference is that here the dead ldx_w is actually safe. I will
send a v3 shortly (I also realized I forgot to tag this series with
v2).

