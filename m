Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E071E6E43
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 00:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436737AbgE1V77 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 17:59:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42748 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436716AbgE1V7u (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 May 2020 17:59:50 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04SLxWPH032763;
        Thu, 28 May 2020 14:59:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=31KZyrW6KDH3s5lRZId+IbaWZtv1rGpGMC8gmli+6CI=;
 b=iMk1GaE3vIHV8FL9oY55qqoHxfdtP9taxLoXZBgM14YrJCZOYiYWQrDs0QG1Wgbk0+cK
 0nzK6Zz2yWx5Ftazfsqmz7eGAor7+GJSHb27AcCaw5h3tjWe1P2rcbgtbQq8KzLgYc1g
 nbmKjPb3lotAznHwro3WTF+kJ6Eqs6IOIKk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 319bqcxg9t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 May 2020 14:59:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 28 May 2020 14:58:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGCSaRarrV1tnvH4tFGAcsyjzDwxWgOIusHnIFc77rxk+J0PeonEiPccQ51q4cZbQlJ7z1/pKXMFwlvqE/Oc5E84EKBJoFi/kZW9KxqxlsCNkveiQtuMpEnweCZUZ2uAeF9cVG5R+/jvFEOgvOAhNihLlBZPZRgX0P01uqx757VGIqaJ1Uu3LsXClCeBJ5SupTSpO8zodtI0ZuF/VujE/CnwGyl2+djT0lKr1PBEEJLxH5NPbiG8mgUPA5raK3M33i/uaBWdvupZcnlEJ/LpUXwY1Is67zzHzVgytHmxTITGUCL9HLwYrgTwYu/R4xnbl0pmBBliy0xneDlxQ7VIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31KZyrW6KDH3s5lRZId+IbaWZtv1rGpGMC8gmli+6CI=;
 b=ANVi3Sv45xGB2lSdve6vRvY8XJdN/2R0dtWLqbxiCb+q4U29n7lw0Te+Q7oluOdgCYTiH+FoOcPsR31bkonh70ySda8tttxHWvoSecCUNiMsvRKM6B9q9xEDq+nlxC5vJDpJvT/Vt2xFcc8YvYYAZWbiDw/jqV0z6ruXNfOmyEP5lN5/+YVr+8xOpit0cmS7ASYD/LqWiESFLDqcnCyGqavshy8H6tPki/O43otILuc7H77TRv5puZYUZSREvSY8GaX6POcIx9eYFmYZxu6zIjfuFrmzeZoIoy15LfW1EHSNTZNwQbbc1Z4U3kvq8vlMsmAXPBIH/i8xmCEaifZuvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31KZyrW6KDH3s5lRZId+IbaWZtv1rGpGMC8gmli+6CI=;
 b=j5k2+ohWbBr+a2FEYKiPUwFOjjTRxrywDJ5spxT/4z0hmfSzMURfRl2f82REbQWR31NNO0nF6d9vAtqA/ew8KAVKjMqUK8OancfLqwd3ayoN4fphjDLa53yI8hkbeGSnkNclhFid96rRUWueakziSHF4EO/YM7IF6lJF5eUmXYc=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3208.namprd15.prod.outlook.com (2603:10b6:a03:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 21:58:56 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3021.030; Thu, 28 May 2020
 21:58:56 +0000
Subject: Re: [PATCH bpf 1/2] bpf: fix a verifier issue when assigning 32bit
 reg states to 64bit ones
To:     John Fastabend <john.fastabend@gmail.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <20200528165043.1568623-1-yhs@fb.com>
 <20200528165043.1568695-1-yhs@fb.com>
 <5ed02d7214c39_1fea2b263a20e5b435@john-XPS-13-9370.notmuch>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <74b999c8-5e0b-7d82-8f45-83813f5b20fc@fb.com>
Date:   Thu, 28 May 2020 14:58:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
In-Reply-To: <5ed02d7214c39_1fea2b263a20e5b435@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::37) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1908] (2620:10d:c090:400::5:95a7) by BYAPR02CA0024.namprd02.prod.outlook.com (2603:10b6:a02:ee::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend Transport; Thu, 28 May 2020 21:58:56 +0000
X-Originating-IP: [2620:10d:c090:400::5:95a7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea2ac5ab-bc75-46a7-96a4-08d8035251b1
X-MS-TrafficTypeDiagnostic: BYAPR15MB3208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3208620DB6C950A87E62CBE0D38E0@BYAPR15MB3208.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NovMDXGBsdkJyH10BtTWwMZZOGaPOJ1jw448aOYqszQ+kA4CcfV4e8rOFaMRFgm1G+El1qFH5tJ8KfjPoR6sej5q5u405+2FI8av8f65ggiOcpsw8rND63Sp/YP3qgoUSQ5A75FAshVlB4qD3CPfGKjyllqyM0tOnvVrKkZ3vjfqjMqBSGpsRbeuPM4FEWUvHuY6QBmXrm5la4ckl7DTN6WdqCcR5M27DRw7w4WZTqwBWCDAVdAmpBsuFavnVe61x6nrrSI/t/L3Cp1RqmjQd3BepIZmoOBdE7qhCLdELyWwkqyrUHYghk8NWKgCmdlHGJc3Sg1Y/ZYajN3AzAhmtfM5CumcGWn7x8suS2N2W5CA1xQpamMDWshmHHeKIxNw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(396003)(39860400002)(136003)(376002)(66556008)(6486002)(54906003)(52116002)(86362001)(5660300002)(8936002)(186003)(83380400001)(16526019)(53546011)(2616005)(8676002)(316002)(478600001)(36756003)(66946007)(31686004)(66476007)(4326008)(2906002)(31696002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Fo7RDC67IYfcs2f74emisFRnxVZe3JoZ1micfCbYJznhxy/RkjgKlQuvRIW4T3Ivoo2ND/J0ZQX3kygNufOCXqi1XE45vgjgfp8V+p1FMCauzExyvwWP+QK6gVMVZZ2C7OuhUPzT4UrMYjBKw327v1QO25cA+gxKF7HWSl/hSoI6bK0dnBbFpWmwTy7eVA5nu16iTksIjKoI42eBWorY8+uiUE8tJqq2GCbqjeXBCa5fgq+0mpEmsdiELbIbUFMlpVbdqJf1QSMrvxT59gy/ecOQHHzv3U468/ZNeEdMMwpyK5gH1CT8PCAG+qbYJuwKXJth92RRF6cTsLfNajn1ukvkUlzLbS+Jpnt1ofL1YVb5o4/xuPiiSQerr/VLHOMyyT+XYvqwTJLEn66YBmKo8ZkvdgHMcCvy7BSzohr+s8VUNDjyNGW73e+cgqZwPqqWZvGRKQeCRZtdW7RExSURqPjNxD/BlD4Q+xRXDK7qPu3Db5a/fvhkVoGYKIIzHD+dUy5Xj61wbVqPUVM/9XSflw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2ac5ab-bc75-46a7-96a4-08d8035251b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 21:58:56.6579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvyTpPr2gkc1vnSk7EtTL/SuWnUXF/FCqxkK8tDdpK/8V+8BQn7+djGIBkaSpBIY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3208
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_08:2020-05-28,2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005280141
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/28/20 2:30 PM, John Fastabend wrote:
> Yonghong Song wrote:
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
> 
> 
> Thanks!
> 
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
>>   }
>> -- 
>> 2.24.1
>>
> 
> How about the following, I think it will also cover the case above. We should be
> checking 'smin_value > 0' as well I believe.
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b3d2590..80d22de 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1217,14 +1217,14 @@ static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
>           * but must be positive otherwise set to worse case bounds
>           * and refine later from tnum.
>           */
> +       if (reg->s32_min_value >= 0 && reg->s32_max_value >= 0)

I agree that s32_min_value needs to be checked. Otherwise, a negative
s32_min_value, not sure how to derive reg->smax_value....

> +               reg->smax_value = reg->s32_max_value;
> +       else
> +               reg->smax_value = U32_MAX;
>          if (reg->s32_min_value > 0)
>                  reg->smin_value = reg->s32_min_value;
>          else
>                  reg->smin_value = 0;
> -       if (reg->s32_min_value >= 0 && reg->s32_max_value > 0)
> -               reg->smax_value = reg->s32_max_value;
> -       else
> -               reg->smax_value = U32_MAX;
>   }
> 
> This causes selftests failure I pasted it at the end of the email. By my
> analysis what happens here is after line 10 we get different bounds
> and this falls out so that we just miss triggering the failure case in
> check_reg_sane_offset()
> 
>          if (smin >= BPF_MAX_VAR_OFF || smin <= -BPF_MAX_VAR_OFF) {
>                  verbose(env, "value %lld makes %s pointer be out of bounds\n",
>                          smin, reg_type_str[type]);
>                  return false;
>          }
> 
> 
> However (would need to check, improve verifier test) that should still
> fail as soon as its read. WDYT? I can try to roll it into your test if

Which read, you mean r0 += r1? Yes, r1 range seems pretty big,
R1_w=inv(id=0,umax_value=72057594037927935,var_off=(0x0; 0xffffffffffffff))
so a failure should be right, I guess.

> you want or if you have time go for it. Let me know.

Since this is a little more involved and you are more familiar with
the code, please go ahead to make the change.

Thanks!

> 
> # ./test_verifier -v 66
> #66/p bounds check after truncation of boundary-crossing range (2) FAIL
> Unexpected success to load!
> func#0 @0
> 0: R1=ctx(id=0,off=0,imm=0) R10=fp0
> 0: (7a) *(u64 *)(r10 -8) = 0
> 1: R1=ctx(id=0,off=0,imm=0) R10=fp0 fp-8_w=mmmmmmmm
> 1: (bf) r2 = r10
> 2: R1=ctx(id=0,off=0,imm=0) R2_w=fp0 R10=fp0 fp-8_w=mmmmmmmm
> 2: (07) r2 += -8
> 3: R1=ctx(id=0,off=0,imm=0) R2_w=fp-8 R10=fp0 fp-8_w=mmmmmmmm
> 3: (18) r1 = 0xffff8883dba1e800
> 5: R1_w=map_ptr(id=0,off=0,ks=8,vs=8,imm=0) R2_w=fp-8 R10=fp0 fp-8_w=mmmmmmmm
> 5: (85) call bpf_map_lookup_elem#1
> 6: R0_w=map_value_or_null(id=1,off=0,ks=8,vs=8,imm=0) R10=fp0 fp-8_w=mmmmmmmm
> 6: (15) if r0 == 0x0 goto pc+9
>   R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R10=fp0 fp-8_w=mmmmmmmm
> 7: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R10=fp0 fp-8_w=mmmmmmmm
> 7: (71) r1 = *(u8 *)(r0 +0)
>   R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R10=fp0 fp-8_w=mmmmmmmm
> 8: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R1_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff)) R10=fp0 fp-8_w=mmmmmmmm
> 8: (07) r1 += 2147483584
> 9: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R1_w=inv(id=0,umin_value=2147483584,umax_value=2147483839,var_off=(0x0; 0xffffffff)) R10=fp0 fp-8_w=mmmmmmmm
> 9: (07) r1 += 2147483584
> 10: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R1_w=inv(id=0,umin_value=4294967168,umax_value=4294967423,var_off=(0x0; 0x1ffffffff)) R10=fp0 fp-8_w=mmmmmmmm
> 10: (bc) w1 = w1
> 11: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0 fp-8_w=mmmmmmmm
> 11: (17) r1 -= 2147483584
> 12: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R1_w=inv(id=0,smin_value=-2147483584,smax_value=2147483711) R10=fp0 fp-8_w=mmmmmmmm
> 12: (17) r1 -= 2147483584
> 13: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R1_w=inv(id=0,smin_value=-4294967168,smax_value=127) R10=fp0 fp-8_w=mmmmmmmm
> 13: (77) r1 >>= 8
> 14: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R1_w=inv(id=0,umax_value=72057594037927935,var_off=(0x0; 0xffffffffffffff)) R10=fp0 fp-8_w=mmmmmmmm
> 14: (0f) r0 += r1
> last_idx 14 first_idx 0
> regs=2 stack=0 before 13: (77) r1 >>= 8
> regs=2 stack=0 before 12: (17) r1 -= 2147483584
> regs=2 stack=0 before 11: (17) r1 -= 2147483584
> regs=2 stack=0 before 10: (bc) w1 = w1
> regs=2 stack=0 before 9: (07) r1 += 2147483584
> regs=2 stack=0 before 8: (07) r1 += 2147483584
> regs=2 stack=0 before 7: (71) r1 = *(u8 *)(r0 +0)
> 15: R0_w=map_value(id=0,off=0,ks=8,vs=8,umax_value=72057594037927935,var_off=(0x0; 0xffffffffffffff)) R1_w=invP(id=0,umax_value=72057594037927935,var_off=(0x0; 0xffffffffffffff)) R10=fp0 fp-8_w=mmmmmmmm
> 15: (b7) r0 = 0
> 16: R0=inv0 R1=invP(id=0,umax_value=72057594037927935,var_off=(0x0; 0xffffffffffffff)) R10=fp0 fp-8=mmmmmmmm
> 16: (95) exit
> 
> from 6 to 16: safe
> processed 17 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
> 
