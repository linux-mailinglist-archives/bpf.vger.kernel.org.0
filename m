Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDC86E0510
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 05:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDMDJX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 23:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDMDJW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 23:09:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ADC5249
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 20:09:18 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33D2Ce1G002505;
        Thu, 13 Apr 2023 03:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=d+39xIfrz+s9GMA65GMEP1e1Ju6EqucmdQveh0TftpM=;
 b=Shnd6vnksLk6CzKLCWHh778fokEszQvCXZVBicoqb2qH0u0hsnXXc2iCmNFnXCiFaYQ4
 uboxxRSw/SpQ0z23zYwNsloy1N8h1aOSNl8LlRQP1pYQAkItVJAYwzjMyqyn/yZafvC6
 RS3Y1/ywaAW/6mz68JzHM7cVBQlBD6DxAXj0yrorImRJiwwpkXJJ49bNEiPZYIz3Snfv
 /ur7xOLMiNtK9I6AAkULOgj8Ga41eQSmuqWqWODaOLVV4+eMO7ioezIFbOp9IiA7zqbq
 LaV4HqdjJPPxA/MCZ+A+xnwHXh66F+2Z8caKqdTbIN7BbQVF2MXISJS2umTJJvbjz0EH 6g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3px6j0qe1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 03:08:56 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33D2JO2n021599;
        Thu, 13 Apr 2023 03:08:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pu0m22qe2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 03:08:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33D38pwP30540454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 03:08:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 505AF20040;
        Thu, 13 Apr 2023 03:08:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BA802004B;
        Thu, 13 Apr 2023 03:08:49 +0000 (GMT)
Received: from [9.43.76.81] (unknown [9.43.76.81])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 13 Apr 2023 03:08:49 +0000 (GMT)
Message-ID: <0d136b2a-2db8-f2b1-418e-f245e95c921f@linux.ibm.com>
Date:   Thu, 13 Apr 2023 08:38:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] powerpc/bpf: populate extable entries only during the
 last pass
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
References: <20230406073519.75059-1-hbathini@linux.ibm.com>
 <857125b9-90b3-fba1-beed-6ffda703f873@csgroup.eu>
Content-Language: en-US
From:   Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <857125b9-90b3-fba1-beed-6ffda703f873@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 326X7szBomm_ckE3LzPjXNaGj3altYnD
X-Proofpoint-ORIG-GUID: 326X7szBomm_ckE3LzPjXNaGj3altYnD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_14,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 spamscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130026
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Christophe,

Thanks for the review.

On 07/04/23 11:31 am, Christophe Leroy wrote:
> 
> 
> Le 06/04/2023 à 09:35, Hari Bathini a écrit :
>> Since commit 85e031154c7c ("powerpc/bpf: Perform complete extra passes
>> to update addresses"), two additional passes are performed to avoid
>> space and CPU time wastage on powerpc. But these extra passes led to
>> WARN_ON_ONCE() hits in bpf_add_extable_entry(). Fix it by not adding
>> extable entries during the extra pass.
> 
> Are you sure this change is correct ?

Actually, I was in two minds about that owing to commit 04c04205bc35
("bpf powerpc: Remove extra_pass from bpf_jit_build_body()").

> During the extra pass the code can get shrinked or expanded (within the
> limits of the size of the preliminary pass). Shouldn't extable entries
> be populated during the last pass ?

Unlikely, but the intention there was to eliminate a regression in case
extra_pass ends up being 'false' always in any subsequent change.

- Hari

>>
>> Fixes: 85e031154c7c ("powerpc/bpf: Perform complete extra passes to update addresses")
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> ---
>>    arch/powerpc/net/bpf_jit_comp32.c | 2 +-
>>    arch/powerpc/net/bpf_jit_comp64.c | 2 +-
>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
>> index 7f91ea064c08..e788b1fbeee6 100644
>> --- a/arch/powerpc/net/bpf_jit_comp32.c
>> +++ b/arch/powerpc/net/bpf_jit_comp32.c
>> @@ -977,7 +977,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>>    			if (size != BPF_DW && !fp->aux->verifier_zext)
>>    				EMIT(PPC_RAW_LI(dst_reg_h, 0));
>>    
>> -			if (BPF_MODE(code) == BPF_PROBE_MEM) {
>> +			if (BPF_MODE(code) == BPF_PROBE_MEM && !extra_pass) {
>>    				int insn_idx = ctx->idx - 1;
>>    				int jmp_off = 4;
>>    
>> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
>> index 8dd3cabaa83a..1cc2777ec846 100644
>> --- a/arch/powerpc/net/bpf_jit_comp64.c
>> +++ b/arch/powerpc/net/bpf_jit_comp64.c
>> @@ -921,7 +921,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>>    			if (size != BPF_DW && insn_is_zext(&insn[i + 1]))
>>    				addrs[++i] = ctx->idx * 4;
>>    
>> -			if (BPF_MODE(code) == BPF_PROBE_MEM) {
>> +			if (BPF_MODE(code) == BPF_PROBE_MEM && !extra_pass) {
>>    				ret = bpf_add_extable_entry(fp, image, pass, ctx, ctx->idx - 1,
>>    							    4, dst_reg);
>>    				if (ret)
