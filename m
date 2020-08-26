Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65A92525CE
	for <lists+bpf@lfdr.de>; Wed, 26 Aug 2020 05:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHZDgk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 23:36:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23392 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726682AbgHZDgj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Aug 2020 23:36:39 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07Q3SXJ6017478;
        Tue, 25 Aug 2020 20:36:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=EnY6J2SB3a28mQaRbKX6PhCr5Yf/SJhJXMYt13mpCns=;
 b=Qh8QEO6on7SaVMQKiszHSM7Ox29wi//Mq6V3xHXE5GprBLNMdYpSD+5Vn/EBY8vFI1ye
 xhpGTu+Pmdj7P9sG/yGTjPHR/8Ghu7s+3+Fura9/VZD6mcPaCSjNb/PdgxKoftTSNHII
 MlV39pl8RaZHdCyldVNl6vXjeFfvw0k5xrM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 333kmn6x0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 Aug 2020 20:36:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 25 Aug 2020 20:36:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8hJ21oBKNCR7BlV/u4ZeIA10angR8YF7HNulxQu2KMSXSWXz8t0Qbd5VtqHHgUtvgh9hfW/ciPrD4iLbQYlrrQKfgmiE7WiXeYLM37WB6T+IUuDzISm3EqoJGW7njAjUWrZPByeGWaweq2mito4hlclOxQEpjEy44DpigN7iIcMNd94gr2xAPRRMoGBqgXMVO3GS2uoW8jNhQPD3pvaPNxYVdMDDuBZu/CZtA8ZLd2/usWHvMf7TEzMCJeluReyAOncCr1qTiunJM/Tzf4N9csvdmv/Kvs9frDGEV/ES0Qa41tEdEq70OfS25g/GOR/HrKavB98PdsSAGOk/oKeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnY6J2SB3a28mQaRbKX6PhCr5Yf/SJhJXMYt13mpCns=;
 b=llyEbJ8v5w0cVe4eJQ2P7SYhwfEAq5bIssRjxvspVWolrLOCo2L7b5Mb6Ohi+R3Wvhy6PWEYZEaKaB45WNl9VbAKMIPyzDZAKm2td2eFWHrhYb2rP1n9yrfCXRTmJ54qhvJpcudQhOH+4eQxLnV/Ba2M8d+rItu+6Xb9Y/geh0pG7+8SYJtqENemm7xQhTyqp6P34IInW+3RhONJzZzu5QacA6n1l/tewc/UTSY8+WYl+D92RJ3seovROmgt4u4jgStaKtY+NuHu61IqME6p+3Zdufi/k7W+GKLT+ZSlkhCrq1MzobCudlaqShYMRvFtm+6DWab2aOHfGR9lpzOTcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnY6J2SB3a28mQaRbKX6PhCr5Yf/SJhJXMYt13mpCns=;
 b=VvSaw7cX5hWqjrtQErVbrRiNmQLHgTFq+j2Y6cgNnal2U1K67+DIt7xiHiKJyvrxIOuqTMH/2nxwfS8iVKoAfnNN1XwXkMZCzeeIKd7uC8lBZbywULUN8V2OUGr58vpGtH3Udx9nmG8hHhl70ovbmY3VDf5iRbZaTxDlhR0k9gc=
Authentication-Results: solarflare.com; dkim=none (message not signed)
 header.d=none;solarflare.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3569.namprd15.prod.outlook.com (2603:10b6:a03:1ff::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 03:36:19 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3326.019; Wed, 26 Aug 2020
 03:36:19 +0000
Subject: Re: [PATCH bpf-next 1/2] bpf: fix a verifier failure with xor
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        <ecree@solarflare.com>
References: <20200825064608.2017878-1-yhs@fb.com>
 <20200825064608.2017937-1-yhs@fb.com>
 <20200826015836.2rlfvhoznylkabp6@ast-mbp.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f2056e3c-e300-6fa0-8b8e-fa19ed5580bd@fb.com>
Date:   Tue, 25 Aug 2020 20:36:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <20200826015836.2rlfvhoznylkabp6@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:208:15e::23) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR17CA0010.namprd17.prod.outlook.com (2603:10b6:208:15e::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Wed, 26 Aug 2020 03:36:17 +0000
X-Originating-IP: [2620:10d:c091:480::1:e440]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d16f3e49-fa95-4226-64b4-08d849713213
X-MS-TrafficTypeDiagnostic: BY5PR15MB3569:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB3569B26F7BF07DF0FC3D1CDDD3540@BY5PR15MB3569.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYpgh54UwZYkZYDJyrEhib/rjHMicdDnBgFXYdQdnmsS2+/sKuHOT9gDh3015xhPwgXWx7alKUvpIFPPrhMnFSozFAfU94PSyvKS9FwgVjmN/+LZnvZtKazKDi1D2FPOKlG1oaV59DY/PxUG4T6sggfyoQpBJmeP/MZ0XYSCumiRtZMYWBUfqECk9zSnYxtqT1keBJPasV1RXJWoB8saiwp22/6xBorjIGPueeEUumrpdICP1TXnPojw4RMNB8e46sP4+FbhY8hIJV39v2+yG3vP0kf1GUVEE/F/RrDSUXyXorqaeZ7HUpMnCRU4qYJy8UtJq0xBJMBHJN0F0H40pvyTXKWXaOLyo5v8OZfrnZ+ShTrG84tmx9ApZcuE0mWl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(39860400002)(396003)(366004)(66946007)(2616005)(956004)(66476007)(66556008)(8936002)(4326008)(31686004)(6916009)(83380400001)(8676002)(478600001)(186003)(86362001)(52116002)(31696002)(53546011)(36756003)(2906002)(16576012)(5660300002)(6486002)(54906003)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ci91TfmJUFrHh3eiRRaFiHjv8xaLD67ABUr27i4AqB6sHbVmsx5/ocWpoNQdtKmeRuNxzwGe4VhMQlZHX2ZKVQ+8L+dg7uDt3iTXhsAT1s2qomV2jQOy6PzymYZfkGdwp2qKZhcVa5aVq377so7WEgCC7D3/SL2tI/GnTAPEptiL8tsnAeEaEslKXLlW+hCxg/nQUWLdEAVrjmmmRlUBV1haQqjXVca241tKifFP59ihlyHp8jzTfetBLPr8P9U/tcEdqKAInj3SN0g4giPE/7dIIWfHCn/vS6fN5IwxNfZX4gM4rAVPgsjPfX+MTUXG+4ueCtKFQVh8Ydc4gNYYe3Q+F93eNUAlkrtfjffgSYaFsmuFUqMQ5J+rsuiMl0GPVYC5gDwzcJ5rbpilu9FzWVXaH4UYYmR06m31VM5vxulBmryMH6ZDJO9WgTccVtsngShk4ikrSWca/kjQO3OmLipkK6DmGMITE68/iayawEWK67PumaLCnz2HX1EKovYTELk/w0XRlRaivU+TzLlBMe5qcyfC9icpnhNHoKC5eZwJAtKbeULcyKIre0MaaSa6MHy1fsv/o5Xbe/8HsVq7qcC4krXmSvLS3T0Tq4XDuEcfIvUhzGrsPZ30iAZLiWxdcibgSuztdMzBSJTDSLKwfgN0DdL+SdsclCMQCWuMNo8=
X-MS-Exchange-CrossTenant-Network-Message-Id: d16f3e49-fa95-4226-64b4-08d849713213
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 03:36:19.5557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eocLEAqhpLbZv9zvIlg9fp9hU2zLI+kHPiy7GfvGq7eaWyNnrVPQnE1kN7mLybyC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3569
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_11:2020-08-25,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 clxscore=1011 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260025
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/25/20 6:58 PM, Alexei Starovoitov wrote:
> On Mon, Aug 24, 2020 at 11:46:08PM -0700, Yonghong Song wrote:
>> bpf selftest test_progs/test_sk_assign failed with llvm 11 and llvm 12.
>> Compared to llvm 10, llvm 11 and 12 generates xor instruction which
>> is not handled properly in verifier. The following illustrates the
>> problem:
>>
>>    16: (b4) w5 = 0
>>    17: ... R5_w=inv0 ...
>>    ...
>>    132: (a4) w5 ^= 1
>>    133: ... R5_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) ...
>>    ...
>>    37: (bc) w8 = w5
>>    38: ... R5=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
>>            R8_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) ...
>>    ...
>>    41: (bc) w3 = w8
>>    42: ... R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) ...
>>    45: (56) if w3 != 0x0 goto pc+1
>>     ... R3_w=inv0 ...
>>    46: (b7) r1 = 34
>>    47: R1_w=inv34 R7=pkt(id=0,off=26,r=38,imm=0)
>>    47: (0f) r7 += r1
>>    48: R1_w=invP34 R3_w=inv0 R7_w=pkt(id=0,off=60,r=38,imm=0)
>>    48: (b4) w9 = 0
>>    49: R1_w=invP34 R3_w=inv0 R7_w=pkt(id=0,off=60,r=38,imm=0)
>>    49: (69) r1 = *(u16 *)(r7 +0)
>>    invalid access to packet, off=60 size=2, R7(id=0,off=60,r=38)
>>    R7 offset is outside of the packet
>>
>> At above insn 132, w5 = 0, but after w5 ^= 1, we give a really conservative
>> value of w5. At insn 45, in reality the condition should be always false.
>> But due to conservative value for w3, the verifier evaluates it could be
>> true and this later leads to verifier failure complaining potential
>> packet out-of-bound access.
>>
>> This patch implemented proper XOR support in verifier.
>> In the above example, we have:
>>    132: R5=invP0
>>    132: (a4) w5 ^= 1
>>    133: R5_w=invP1
>>    ...
>>    37: (bc) w8 = w5
>>    ...
>>    41: (bc) w3 = w8
>>    42: R3_w=invP1
>>    ...
>>    45: (56) if w3 != 0x0 goto pc+1
>>    47: R3_w=invP1
>>    ...
>>    processed 353 insns ...
>> and the verifier can verify the program successfully.
>>
>> Cc: John Fastabend <john.fastabend@gmail.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   kernel/bpf/verifier.c | 66 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index dd24503ab3d3..a08cabc0f683 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5801,6 +5801,67 @@ static void scalar_min_max_or(struct bpf_reg_state *dst_reg,
>>   	__update_reg_bounds(dst_reg);
>>   }
>>   
>> +static void scalar32_min_max_xor(struct bpf_reg_state *dst_reg,
>> +				 struct bpf_reg_state *src_reg)
>> +{
>> +	bool src_known = tnum_subreg_is_const(src_reg->var_off);
>> +	bool dst_known = tnum_subreg_is_const(dst_reg->var_off);
>> +	struct tnum var32_off = tnum_subreg(dst_reg->var_off);
>> +	s32 smin_val = src_reg->s32_min_value;
>> +
>> +	/* Assuming scalar64_min_max_xor will be called so it is safe
>> +	 * to skip updating register for known case.
>> +	 */
>> +	if (src_known && dst_known)
>> +		return;
> 
> why?
> I've looked at _and() and _or() variants that do the same and
> couldn't quite remember why it's ok to do so.

Yes, I copied what _and() and _or() did. What I thought is
if both known, 64bit scalar_min_max_xor() handled this and did
not go though the approximation below, so that is why we return here.
John, could you confirm?

> 
>> +
>> +	/* We get both minimum and maximum from the var32_off. */
>> +	dst_reg->u32_min_value = var32_off.value;
>> +	dst_reg->u32_max_value = var32_off.value | var32_off.mask;
>> +
>> +	if (dst_reg->s32_min_value >= 0 && smin_val >= 0) {
>> +		/* XORing two positive sign numbers gives a positive,
>> +		 * so safe to cast u32 result into s32.
>> +		 */
>> +		dst_reg->s32_min_value = dst_reg->u32_min_value;
>> +		dst_reg->s32_max_value = dst_reg->u32_max_value;
>> +	} else {
>> +		dst_reg->s32_min_value = S32_MIN;
>> +		dst_reg->s32_max_value = S32_MAX;
>> +	}
>> +}
>> +
>> +static void scalar_min_max_xor(struct bpf_reg_state *dst_reg,
>> +			       struct bpf_reg_state *src_reg)
>> +{
>> +	bool src_known = tnum_is_const(src_reg->var_off);
>> +	bool dst_known = tnum_is_const(dst_reg->var_off);
>> +	s64 smin_val = src_reg->smin_value;
>> +
>> +	if (src_known && dst_known) {
>> +		/* dst_reg->var_off.value has been updated earlier */
> 
> right, but that means that there is sort-of 'bug' (unnecessary operation)
> that caused me a lot of head scratching.
> scalar_min_max_and() and scalar_min_max_or() do the alu in similar situation:
>          if (src_known && dst_known) {
>                  __mark_reg_known(dst_reg, dst_reg->var_off.value |
>                                            src_reg->var_off.value);
> I guess it's still technically correct to repeat alu operation.
> second & and second | won't change the value of dst_reg,
> but it feels that it's correct by accident?
> John ?

I think for or and add, additional dst_reg op src_reg is okay. For 
example, for "and", the computation looks like
    dst = dst & src
    dst = dst & src
result will be the same as
    dst = dst & src
and the second is redundant and can be replaced with dst.
The same for or,
    dst = dst | src
    dst = dst | src
is the same as "dst = dst | src" and the second is redundant. So
for and/or, the __mark_reg_known can just take dst_reg->var_off.value,
but the current code is also correct but can be simplified.

This is not the case xor (^). The extra computation will
change expected value.

> 
>> +		__mark_reg_known(dst_reg, dst_reg->var_off.value);
>> +		return;
>> +	}
>> +
>> +	/* We get both minimum and maximum from the var_off. */
>> +	dst_reg->umin_value = dst_reg->var_off.value;
>> +	dst_reg->umax_value = dst_reg->var_off.value | dst_reg->var_off.mask;
> 
> I think this is correct, but I hope somebody else can analyze this as well.
> John, Ed ?

Please do double check. Thanks.

> 
>> +
>> +	if (dst_reg->smin_value >= 0 && smin_val >= 0) {
>> +		/* XORing two positive sign numbers gives a positive,
>> +		 * so safe to cast u64 result into s64.
>> +		 */
>> +		dst_reg->smin_value = dst_reg->umin_value;
>> +		dst_reg->smax_value = dst_reg->umax_value;
>> +	} else {
>> +		dst_reg->smin_value = S64_MIN;
>> +		dst_reg->smax_value = S64_MAX;
>> +	}
>> +
>> +	__update_reg_bounds(dst_reg);
>> +}
