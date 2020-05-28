Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570481E6D91
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 23:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436518AbgE1VXC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 17:23:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7230 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436515AbgE1VW7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 May 2020 17:22:59 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04SLF5jP025247;
        Thu, 28 May 2020 14:22:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=RGfmePC4giNIhN8LiKFqev2fjRyfnCVAD6A2t/I9oDU=;
 b=ove8ww+8QlDmrQh8FsP6OP+2Br05rzK2chxzzg7inv18HBVIAuI4CUygE9VrHHCkG9G0
 h4/GpOfmPwOghgh0fWf26xOyCcpm8JCSedisNjmTQmcZKRouFC3R/PGPagdLEpgDAMyR
 MIkLLdqbUCAX6SOG/9GXLlq1avUxa1KymW0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31ag6rk3bh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 May 2020 14:22:44 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 28 May 2020 14:22:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQdFj4x/oc0LfPbCG746Jz/4lHLmJsQJ/HwSbn10GxBVFlW1OD8jqln5FJO5kbjSroz7foqCWTL9kOmV1iZfYH3xuksFpndl4h6koYtm+VDI9t2cSYAEWaI92gQX2OKnQMddx6D3ZB/K6C7B9HLEax6Fc6Jrt0MkURBzTgXEBsld7Xf81rD40Qd+dEU12xK66k0q3a1ss/RZPjtC1XRniYP1h89tQVTpzapm3SlljWvMu83QhBvnaIeuo2c5qXPemwuHoyEg4XGJmo74nWF/2e92K/vC432cetf+GXfJHYOmFpmkuQWR/xLrqFzoBPMPNx5bX/1x1B53GVlb3/NHBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGfmePC4giNIhN8LiKFqev2fjRyfnCVAD6A2t/I9oDU=;
 b=gqFatgMfYeD4XMbv38n4no2yHkDoWx7aZeWl2JF9L1V7IVOQR8+79KFzd8j4hX2TXU9p5V42jj/Mvv37zLNyC4yT9i0HzfvZB2wcrwwUUOHGO32th/Q9qHVIOMlAE7hHNic5rPiPI5JnhJxr/TxDfEdNdL4iaSuaIWjvodEB8huP0E6vJR3UFFHCpsJVqhIctjwg5OtE56mX8ygDysC5Xu+kGzjLvgoNLWhK6QNYkl6TDVFKP/tMJpojZUrz9+CMDfK/JCYKW34sneh2PLjuVOVAoI+reBq2vYUlnugWzEvU6zQrZkHCrc0cMd3cp8+QCE4OncNb/0ddk7H6L5umfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGfmePC4giNIhN8LiKFqev2fjRyfnCVAD6A2t/I9oDU=;
 b=f33S8hfx3yC8Wnb/S486X7uhRD4paNKB524XvKFS4IsqcWxv5VNbaO5h8uxGsSfnwwAJwMElMDdcTVBePF2HkvuwwBvHAwPuPCiRPMT0mLttGfme+3aJ2yyeJxHuGGT342SAVmS8GL7rjmLkL71dYEwnYfujzZ8lSwaZWZDnFco=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3367.namprd15.prod.outlook.com (2603:10b6:a03:105::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 21:22:36 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3021.030; Thu, 28 May 2020
 21:22:36 +0000
Subject: Re: [PATCH bpf 1/2] bpf: fix a verifier issue when assigning 32bit
 reg states to 64bit ones
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
References: <20200528165043.1568623-1-yhs@fb.com>
 <20200528165043.1568695-1-yhs@fb.com>
 <20200528203618.gsk6utptz5gls2di@ast-mbp.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <7c0c1762-e5a8-0425-6e16-dfc292baced1@fb.com>
Date:   Thu, 28 May 2020 14:22:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
In-Reply-To: <20200528203618.gsk6utptz5gls2di@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:74::33) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MacBook-Pro-52.local (2620:10d:c090:400::5:95a7) by BYAPR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:74::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.7 via Frontend Transport; Thu, 28 May 2020 21:22:36 +0000
X-Originating-IP: [2620:10d:c090:400::5:95a7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75cf52b5-529e-4cee-d24c-08d8034d3e52
X-MS-TrafficTypeDiagnostic: BYAPR15MB3367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3367C00C2D3F95A670EC0D3ED38E0@BYAPR15MB3367.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bmpxIKAScurSje8rCnVUNGtI72kT+w01MYCw/p1gAsrPZplOOsTKBkk08KgMKpaID/Nz9WciteUJ1T/mygHTbv6fbUzqEqkznOHYfPkPJixxGyi/xMBzHb33v8sDpeo4NdHpgBTUOQiRtL9u6xj99VBnVbh3ZVG4kpUlGj2mMnFHQUzAG1zCD/hWkdfiscxQj052N/4K4ifIrN15UtoBZJRayySNJ7z8sEiwjwo6A9iL6X8PNjHgmcb+7N9g2UBpOWzCs1xVDpD857R8LftNGZU1JGrVkZYrxEMhmP2Bn1HtDRnc9JjbAu0xATxXVCv5/Zh7+eiE/apZdErxrBzot9bZRBRLM+46eF8eG9AAjPKcbw2vXRp8ZItihdBJlg0I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(39860400002)(366004)(396003)(6486002)(8676002)(36756003)(6666004)(6512007)(31696002)(478600001)(6916009)(83380400001)(5660300002)(66946007)(66556008)(66476007)(53546011)(31686004)(4326008)(2616005)(86362001)(8936002)(316002)(186003)(52116002)(6506007)(54906003)(2906002)(16526019)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 7JrboHr9twihasZNKyDZ9lpQYoMoGa15ePM/ySM7xviYxujM2rPytfahfI6KHAq30hOm9Co+g9Vy42l0zYKc8P9/zxylO1aMf9cUJ78451fyrgDqStLpmA+QZfo3GsbRFsTidW6yrb0nhuzvPyJBynX9WDLUxSGK783Rq0MEs+lzu2TR42S0bVTclDNY4PHLM+GPWT+Lmx5OyiEQgEitgLf6APHDSzgehVxdLvHGPCihAtp5Xk8C9hwyE5Le0WC11K1RqtEtfG3cjy5zpizaCtpehBcT7EauWUIImLKMx/9W14047c1qfYHo8AGmujT0ZrTqsZjS4u3CUJZCH4K4CaUQkN/XKIReCfrbodsB5RYtE9FHccdASds5RK7QSiVQppUwwkzSqyRiq7HFf++7CVzdTxrVquzmDfbQxr2kS87VR5i4S7EHCrVRQfVGG2MOV8ESGk3hIrbi7H5XPCcST6UrH4GZqfB3ce7eciPaOEec4xEe3INJYL42hShPCOnZGVuAz39Iv1/zn0toBdeqZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cf52b5-529e-4cee-d24c-08d8034d3e52
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 21:22:36.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUEanO9JfHzYYs8hVoGttHEe6VXoVxwXPZ0N0XCvyGU1CPDCRULr2EF4RRFmiD/U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3367
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_08:2020-05-28,2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 cotscore=-2147483648 clxscore=1015 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280136
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/28/20 1:36 PM, Alexei Starovoitov wrote:
> On Thu, May 28, 2020 at 09:50:43AM -0700, Yonghong Song wrote:
>> With the latest trunk llvm (llvm 11), I hit a verifier issue for
>> test_prog subtest test_verif_scale1.
>>
>> The following simplified example illustrate the issue:
>>      w9 = 0  /* R9_w=inv0 */
>>      r8 = *(u32 *)(r1 + 80)  /* __sk_buff->data_end */
>>      r7 = *(u32 *)(r1 + 76)  /* __sk_buff->data */
>>      ......
>>      w2 = w9 /* R2_w=inv0 */
>>      r6 = r7 /* R6_w=pkt(id=0,off=0,r=0,imm=0) */
>>      r6 += r2 /* R6_w=inv(id=0) */
>>      r3 = r6 /* R3_w=inv(id=0) */
>>      r3 += 14 /* R3_w=inv(id=0) */
>>      if r3 > r8 goto end
>>      r5 = *(u32 *)(r6 + 0) /* R6_w=inv(id=0) */
>>         <== error here: R6 invalid mem access 'inv'
>>      ...
>>    end:
>>
>> In real test_verif_scale1 code, "w9 = 0" and "w2 = w9" are in
>> different basic blocks.
>>
>> In the above, after "r6 += r2", r6 becomes a scalar, which eventually
>> caused the memory access error. The correct register state should be
>> a pkt pointer.
>>
>> The inprecise register state starts at "w2 = w9".
>> The 32bit register w9 is 0, in __reg_assign_32_into_64(),
>> the 64bit reg->smax_value is assigned to be U32_MAX.
>> The 64bit reg->smin_value is 0 and the 64bit register
>> itself remains constant based on reg->var_off.
>>
>> In adjust_ptr_min_max_vals(), the verifier checks for a known constant,
>> smin_val must be equal to smax_val. Since they are not equal,
>> the verifier decides r6 is a unknown scalar, which caused later failure.
>>
>> The llvm10 does not have this issue as it generates different code:
>>      w9 = 0  /* R9_w=inv0 */
>>      r8 = *(u32 *)(r1 + 80)  /* __sk_buff->data_end */
>>      r7 = *(u32 *)(r1 + 76)  /* __sk_buff->data */
>>      ......
>>      r6 = r7 /* R6_w=pkt(id=0,off=0,r=0,imm=0) */
>>      r6 += r9 /* R6_w=pkt(id=0,off=0,r=0,imm=0) */
>>      r3 = r6 /* R3_w=pkt(id=0,off=0,r=0,imm=0) */
>>      r3 += 14 /* R3_w=pkt(id=0,off=14,r=0,imm=0) */
>>      if r3 > r8 goto end
>>      ...
>>
>> To fix the issue, if 32bit register is a const 0,
>> then just assign max vaue 0 to 64bit register smax_value as well.
>>
>> Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")
>> Cc: John Fastabend <john.fastabend@gmail.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   kernel/bpf/verifier.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8d7ee40e2748..5123ce54695f 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -1174,6 +1174,9 @@ static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
>>   		reg->smin_value = 0;
>>   	if (reg->s32_max_value > 0)
>>   		reg->smax_value = reg->s32_max_value;
>> +	else if (reg->s32_max_value == 0 && reg->s32_min_value == 0 &&
>> +		 tnum_is_const(reg->var_off))
>> +		reg->smax_value = 0; /* const 0 */
>>   	else
>>   		reg->smax_value = U32_MAX;
> 
> wouldn't this be a more general fix ?
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 01c7d3634151..83450d5d24ab 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1217,11 +1217,11 @@ static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
>           * but must be positive otherwise set to worse case bounds
>           * and refine later from tnum.
>           */
> -       if (reg->s32_min_value > 0)
> +       if (reg->s32_min_value >= 0)
>                  reg->smin_value = reg->s32_min_value;
>          else
>                  reg->smin_value = 0;
> -       if (reg->s32_max_value > 0)
> +       if (reg->s32_max_value >= 0)
>                  reg->smax_value = reg->s32_max_value;

I thought this way, but not 100% sure about s32_max_value == 0 means
actually the max_value of 0 or some kind of default value (e.g. from
kzalloc). Hence my conservative approach.

I guess you probably right. Let me double check the code.

>          else
>                  reg->smax_value = U32_MAX;
> 
