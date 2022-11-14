Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA7C628345
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 15:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbiKNOyv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 09:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbiKNOyt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 09:54:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901081D0EC
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 06:54:47 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AEEe1pp016774;
        Mon, 14 Nov 2022 14:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CPLUVuSddiqPTrAv/T1QltnIxi/Oy94b+jEh/U/735Y=;
 b=oYUABfhp177203Uu7VdUHhMmf9ElDFV6XtVsiJcp6agx+ZYxhK1ksu+V1tNSfyHeptEZ
 I5u0ydmmFW7YcbYMyhDB8aTmD00FdMAn7ezfmZG2Vb6gkcO4qtMs3imFqbZ8yptx1WPp
 h1b0mpW0M3T7x0v9QLkLeyzTMihPPQfiUkBC80+xihtFqXt7ik1CL4Ymocs8RF2OxdEY
 4O37qqAJQ2cA75cOaKe5Y/QA55QBADGF5Pc0pBis6NdeE4mcW/PiEnZ8Sy5yB69xgu4q
 Uxn0TLZz4sXVL8zznxpmRpkxmRiWvU1Gl3SHXuXNCN0yxMv/1R5bDkgANrAteh3ZicKb /Q== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kuqmt0c6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 14:54:27 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AEEpkOD020586;
        Mon, 14 Nov 2022 14:54:24 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3kt348tqpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 14:54:24 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AEEsMSw59310488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 14:54:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B160A4055;
        Mon, 14 Nov 2022 14:54:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A7F5A404D;
        Mon, 14 Nov 2022 14:54:18 +0000 (GMT)
Received: from [9.163.90.158] (unknown [9.163.90.158])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Nov 2022 14:54:17 +0000 (GMT)
Message-ID: <e6304866-26f4-51f6-c825-9355a2d15b80@linux.ibm.com>
Date:   Mon, 14 Nov 2022 20:24:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH 1/3] powerpc/bpf: implement bpf_arch_text_copy
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20221110184303.393179-1-hbathini@linux.ibm.com>
 <20221110184303.393179-2-hbathini@linux.ibm.com>
 <cd26aa17-962f-aaab-a7bc-203a0d63f6c9@csgroup.eu>
From:   Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <cd26aa17-962f-aaab-a7bc-203a0d63f6c9@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K71pGfrlLeUo6vXHWxXlp-Js6z6RCWly
X-Proofpoint-GUID: K71pGfrlLeUo6vXHWxXlp-Js6z6RCWly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 13/11/22 6:47 pm, Christophe Leroy wrote:
> Le 10/11/2022 à 19:43, Hari Bathini a écrit :
>> bpf_arch_text_copy is used to dump JITed binary to RX page, allowing
>> multiple BPF programs to share the same page. Using patch_instruction
>> to implement it.
> 
> Using patch_instruction() is nice for a quick implementation, but it is
> probably suboptimal. Due to the amount of data to be copied, it is worth

Yeah.

> a dedicated function that maps a RW copy of the page to be updated then
> does the copy at once with memcpy() then unmaps the page.

I will see if I can come up with such implementation for the respin.

> 
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> ---
>>    arch/powerpc/net/bpf_jit_comp.c | 39 ++++++++++++++++++++++++++++++++-
>>    1 file changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
>> index 43e634126514..7383e0effad2 100644
>> --- a/arch/powerpc/net/bpf_jit_comp.c
>> +++ b/arch/powerpc/net/bpf_jit_comp.c
>> @@ -13,9 +13,12 @@
>>    #include <linux/netdevice.h>
>>    #include <linux/filter.h>
>>    #include <linux/if_vlan.h>
>> -#include <asm/kprobes.h>
>> +#include <linux/memory.h>
>>    #include <linux/bpf.h>
>>    
>> +#include <asm/kprobes.h>
>> +#include <asm/code-patching.h>
>> +
>>    #include "bpf_jit.h"
>>    
>>    static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
>> @@ -23,6 +26,35 @@ static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
>>    	memset32(area, BREAKPOINT_INSTRUCTION, size / 4);
>>    }
>>    
>> +/*
>> + * Patch 'len' bytes of instructions from opcode to addr, one instruction
>> + * at a time. Returns addr on success. ERR_PTR(-EINVAL), otherwise.
>> + */
>> +static void *bpf_patch_instructions(void *addr, void *opcode, size_t len)
>> +{
>> +	void *ret = ERR_PTR(-EINVAL);
>> +	size_t patched = 0;
>> +	u32 *inst = opcode;
>> +	u32 *start = addr;
>> +
>> +	if (WARN_ON_ONCE(core_kernel_text((unsigned long)addr)))
>> +		return ret;
>> +
>> +	mutex_lock(&text_mutex);
>> +	while (patched < len) {
>> +		if (patch_instruction(start++, ppc_inst(*inst)))
>> +			goto error;
>> +
>> +		inst++;
>> +		patched += 4;
>> +	}
>> +
>> +	ret = addr;
>> +error:
>> +	mutex_unlock(&text_mutex);
>> +	return ret;
>> +}
>> +
>>    /* Fix updated addresses (for subprog calls, ldimm64, et al) during extra pass */
>>    static int bpf_jit_fixup_addresses(struct bpf_prog *fp, u32 *image,
>>    				   struct codegen_context *ctx, u32 *addrs)
>> @@ -357,3 +389,8 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, int pass, struct code
>>    	ctx->exentry_idx++;
>>    	return 0;
>>    }
>> +
>> +void *bpf_arch_text_copy(void *dst, void *src, size_t len)
>> +{
>> +	return bpf_patch_instructions(dst, src, len);
>> +}
> 
> I can't see the added value of having two functions when the first one
> just calls the second one and is the only user of it. Why not have
> implemented bpf_patch_instructions() directly inside bpf_arch_text_copy() ?
> 
> By the way, it can be nice to have two functions, but split them
> differently, to avoid the goto: etc ....
> 
> I also prefer using for loops instead of while loops.
> 

> It could have looked like below (untested):
> 
> static void *bpf_patch_instructions(void *addr, void *opcode, size_t len)
> {
> 	u32 *inst = opcode;
> 	u32 *start = addr;
> 	u32 *end = addr + len;
> 
> 	for (inst = opcode, start = addr; start < end; inst++, start++) {
> 		if (patch_instruction(start, ppc_inst(*inst)))
> 			return ERR_PTR(-EINVAL);
> 	}
> 
> 	return addr;
> }
> 
> void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> {
> 	if (WARN_ON_ONCE(core_kernel_text((unsigned long)dst)))
> 		return ret;
> 
> 	mutex_lock(&text_mutex);
> 
> 	ret = bpf_patch_instructions(dst, src, len);
> 
> 	mutex_unlock(&text_mutex);
> 
> 	return ret;
> }
> 
> 

Sure. Will use this.

Thanks
Hari
