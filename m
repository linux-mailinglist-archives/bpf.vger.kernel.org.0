Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DDC2DA6FA
	for <lists+bpf@lfdr.de>; Tue, 15 Dec 2020 04:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgLOD6N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Dec 2020 22:58:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40814 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbgLOD6M (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 14 Dec 2020 22:58:12 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BF3lm04019723;
        Mon, 14 Dec 2020 19:57:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=kfXjFlFxufa9Bu2NkRJtFJHR+uR5lcviObWOo/36mBc=;
 b=TcQFsgSyx/EiYHL+WBrgJ+AapRwTPvcKgpGSFHY/1YJhZb37mTrYy11iU6icVoFJrYr+
 jN9upJHFh+m78aCPPcmf6buYsvEJpLqfc+tWAH0rAsNI7KtsuWs+u447RWixEo4XlXPU
 C8eSiG0DykFTP6u3+mPdWUJiqr1ZAL6xcSs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35descguxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Dec 2020 19:57:18 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 14 Dec 2020 19:57:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYh7FBWk5iWjmRl1kFa4wv8MJuVTzHT6gBHQ+xjeWs1zo2W1/AflgMVGO0D4LD8A75UTHo5IhYZ9p9Ks3z5HcEsLYO7ziRHPKPMOCQEqxLqN1K5vAJJ6cDv9Kq0MSw38A2kfvYh9qDn1IJbjqWfhcRO89dGZvXMts2GaeFdcd3hLI3a/FihD0fMwtYyqggkHBpjFjJEg9OA6geUJfInhwO+ZedXRaQymtHxnfn5LdbDf2S+gU486ni3ZU0NZsh7C7TqAa7rxqxK53nGWoA2RFpp4EP9B+XB9HkHi1JitRjIg08AWpnToqvukKIIBrSLIpJECBE938BvkJxyu1HCK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfXjFlFxufa9Bu2NkRJtFJHR+uR5lcviObWOo/36mBc=;
 b=cWoZmyFNYI/jEm8b51g6F1rU1D8BePKOoWNV+k+sQj7O04UoaxxaUVUlKW7wjADguisMKdlblHirC9xleIuKtfpjdNw1GOc0VcetQRcWPtfJSGFHq5ONW0akPerHUcKTvQYjar9sPs2+tQUGdj+4R8yR/qfUtedDhKhPaN+mmGxgjpzuaWLDFoQbo3t20K1PGKiFYSY4ZLVuvfmMl7jLyHNdqE9RPsmLYGf2H+ciSdnyv5/P73ucfHSvSygVWMiPsDilQhzSxC3jbYz1PrlEYi6iIWTHeD848kJjeiLmtN2o3CMsSrN9lMMB9gepfV0FCrG33AEHzcTvK4EKbARf4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfXjFlFxufa9Bu2NkRJtFJHR+uR5lcviObWOo/36mBc=;
 b=PFGMc9PpzQuGSBrVcx1wFsVCuRygRaYHEIi1qHG9QHBOTgBM3PhLS88K8LQMsKiTro8o60YoIT38V+5utZYSZ/jfdEYQB2mFsDzdGT69X+FJ72E6WelRJddUjAIcTWpveJmRDgBdq18D91bF76sEA+EFmS/cWyf/Xa/q0sJau4s=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2407.namprd15.prod.outlook.com (2603:10b6:a02:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 15 Dec
 2020 03:57:15 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 03:57:15 +0000
Subject: Re: [PATCH bpf-next v3 1/2] bpf: permits pointers on stack for helper
 calls
To:     Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
References: <20201211034121.3452172-1-yhs@fb.com>
 <20201211034121.3452243-1-yhs@fb.com>
 <e48545be-6b03-aa2b-d5f6-a12b180ba116@iogearbox.net>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <12bc8fa8-0cb8-596a-995c-9312d2a390e2@fb.com>
Date:   Mon, 14 Dec 2020 19:57:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <e48545be-6b03-aa2b-d5f6-a12b180ba116@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:9862]
X-ClientProxiedBy: MW4PR04CA0191.namprd04.prod.outlook.com
 (2603:10b6:303:86::16) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::112b] (2620:10d:c090:400::5:9862) by MW4PR04CA0191.namprd04.prod.outlook.com (2603:10b6:303:86::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 03:57:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 460b7fd6-8720-42e5-849c-08d8a0ad82ac
X-MS-TrafficTypeDiagnostic: BYAPR15MB2407:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB24075E7A336B37238147E2E3D3C60@BYAPR15MB2407.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43rOXYvZZGat20jwdQsn92umRbDCAZWh/L9LrXkWty7ctqkoIEmCL/OT93SobwAcQg9a2ulgIVKKuP+rPXfFLDZCX1Ai/ax6bgfcbS9q4hE8CpoBqflaJxuH/hu1mQl+BRjxGujhpPoRJxfcyq9yCYSCye5SF4BXZRbqp5p3U/CgxJPtZUzTSP8kDp9k9Mit8hqTBMWVOcC79asp1k5aYTUnKSfG+LD+M1NcunUTyCWLn8ybjDT/BZm50JoSrW7v4WBmWZlWSMI1K0ELn7uxjiHo06LJKzjt26xL/bI/rG+x3Q752UyRmk9WdD+glaoBKmhDvl/OkoEiMua7AmfZ0k2aPvEbqa8vK8AaiR3safJ3VocIm6e7pFcMAc+EuXx7n+rz2vb1tGWDIapK7E3mgm2e3FXCbQ+JCcEDgqar014=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(346002)(508600001)(8936002)(86362001)(4326008)(6486002)(83380400001)(53546011)(36756003)(66946007)(5660300002)(31686004)(66476007)(2906002)(16526019)(54906003)(186003)(66556008)(31696002)(2616005)(52116002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V2k2eWdGREJmV1FJdDlTWkwzU25mTW5Pb0VRZTFpdXpnQ24yQXhrSDI3aU9M?=
 =?utf-8?B?dmhiYkthQTNOVmg0VzRrY2RsNGcwK29BTU9SUVU4MGJIUzRLY285cUlhMitW?=
 =?utf-8?B?anVNdk5icTF2aDZXMDkzdDVIRnhnZkgrcyttNVp1d2VFV0grNTFsKzZCcCsx?=
 =?utf-8?B?TDVpS3V2WngzeWdnUTFSdkRqYk1XMlNPL2twaWF2OG50ODZXNFNqOUlvQ0E4?=
 =?utf-8?B?YjdESXlCc2M2LzFpR0NBT1lrdzd5eW5HeUdyTjJmR0FrNzg1THpFSXJWcnpM?=
 =?utf-8?B?Y3BBYzhhVjdlUEM3akVzSXh0OXVNaHhrblBaalBNU1JIcG8xYi9KVmxXMmVu?=
 =?utf-8?B?NGI1QTdyS0d0dFlrZVJtVnVjOTM0ZG9sQXVQRTByZm93Q05LdmNSVmd0WFNn?=
 =?utf-8?B?ZW03VWdpZURpWmdSMVFzQmhrWllCYVhWalJMNnV2dTdRS3o2a291dW1IbEJx?=
 =?utf-8?B?WjJWaldqV2lPUkhQM3BnOVZ1djdyMVFEM1djR1pEaUZNK2JNSlhRZEhvajZ3?=
 =?utf-8?B?VlVpVTl2Zkx3NG9KLys0RTR2bzExSzdRTWlnMVZUck51OVRraWh4dDRBUEds?=
 =?utf-8?B?NHV6cDVJYlpZUHVUWlRSOWtvYi81dDhpNzNjN1M5cjlOVkxCQVRGelJhY0dR?=
 =?utf-8?B?SWs2VStHZmpBd0N2aGl3SFhlTU11eWc2aGd4NTJjcEVlL3NtTDI2dGJ2bnFu?=
 =?utf-8?B?ckJvQ0s3VGlBN2Q3QWk0TzZuYUtvb2FsVTA0OHBzODVzWG1Ka1FQRk5Xdlhx?=
 =?utf-8?B?NmNLZWd4L0RSZTdyY2tXN0hMNGVYNEs5VUxBSkwwNHo0aVVDNVpsUkVWYlZ3?=
 =?utf-8?B?akt0SU5RWG10c2hQTWMwamVaRW1NZnlvdEwySmUraHFwSTFEWE5JUW10Q2Iy?=
 =?utf-8?B?QkxkZXd3S3pRajBJNnRCUkMxUSs5QzM2eUk4QjZiU2VMMXBURmg3R3BMNFht?=
 =?utf-8?B?a2xuemNkekEzKytZZC9xN2dMOHJvUVdaaFZyOXEySzhRbk0ySkMvd0dsdG5T?=
 =?utf-8?B?T2xka0xNaGdHLzlkRS9TTFBYMCtJQmFGQnZCSkZUVlRtaEUxamU2c1NSU29n?=
 =?utf-8?B?TytWNWpHUmtkcFdod0lmSVg5UDhBZE4vWjZ1RUt5NjlpdVJTZGdhdURYUFFl?=
 =?utf-8?B?d1NHcDllbGl3WXpHSGVoVGMraHFwais1YkRrVkpDQTYrcHBtKzgxVHZtQkgx?=
 =?utf-8?B?ZHdlSEdGSHdzTXFHc05RRkFjdVN5YWJwQ2dUampVR21HV0dWbEJjdnZEdFpQ?=
 =?utf-8?B?SjVEbkhsMk1oKzBIR1J1UytTTStkanp5SXN5eTYydWZsVk1abW91V3RoS3dH?=
 =?utf-8?B?Ty9mOEpVMGxXWDBLWmJlSEVZblNXUXp4d045dXU4Rk9XMVRBZTJnSGNEaUNL?=
 =?utf-8?B?Nmd3bktRYmxkT2c9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 03:57:14.8089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 460b7fd6-8720-42e5-849c-08d8a0ad82ac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6N4w5VDMXGx4lj50amyjmJaoGHelXqM1EmulFpgfDRXVCmrUIQTjVYh9FKEaJPE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2407
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_03:2020-12-11,2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150022
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/14/20 1:26 PM, Daniel Borkmann wrote:
> On 12/11/20 4:41 AM, Yonghong Song wrote:
>> Currently, when checking stack memory accessed by helper calls,
>> for spills, only PTR_TO_BTF_ID and SCALAR_VALUE are
>> allowed.
>>
>> Song discovered an issue where the below bpf program
>>    int dump_task(struct bpf_iter__task *ctx)
>>    {
>>      struct seq_file *seq = ctx->meta->seq;
>>      static char[] info = "abc";
>>      BPF_SEQ_PRINTF(seq, "%s\n", info);
>>      return 0;
>>    }
>> may cause a verifier failure.
>>
>> The verifier output looks like:
>>    ; struct seq_file *seq = ctx->meta->seq;
>>    1: (79) r1 = *(u64 *)(r1 +0)
>>    ; BPF_SEQ_PRINTF(seq, "%s\n", info);
>>    2: (18) r2 = 0xffff9054400f6000
>>    4: (7b) *(u64 *)(r10 -8) = r2
>>    5: (bf) r4 = r10
>>    ;
>>    6: (07) r4 += -8
>>    ; BPF_SEQ_PRINTF(seq, "%s\n", info);
>>    7: (18) r2 = 0xffff9054400fe000
>>    9: (b4) w3 = 4
>>    10: (b4) w5 = 8
>>    11: (85) call bpf_seq_printf#126
>>     R1_w=ptr_seq_file(id=0,off=0,imm=0) 
>> R2_w=map_value(id=0,off=0,ks=4,vs=4,imm=0)
>>    R3_w=inv4 R4_w=fp-8 R5_w=inv8 R10=fp0 fp-8_w=map_value
>>    last_idx 11 first_idx 0
>>    regs=8 stack=0 before 10: (b4) w5 = 8
>>    regs=8 stack=0 before 9: (b4) w3 = 4
>>    invalid indirect read from stack off -8+0 size 8
>>
>> Basically, the verifier complains the map_value pointer at "fp-8" 
>> location.
>> To fix the issue, if env->allow_ptr_leaks is true, let us also permit
>> pointers on the stack to be accessible by the helper.
>>
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Reported-by: Song Liu <songliubraving@fb.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   kernel/bpf/verifier.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 93def76cf32b..eebb2d3e16bf 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3769,7 +3769,9 @@ static int check_stack_boundary(struct 
>> bpf_verifier_env *env, int regno,
>>               goto mark;
>>           if (state->stack[spi].slot_type[0] == STACK_SPILL &&
>> -            state->stack[spi].spilled_ptr.type == SCALAR_VALUE) {
>> +            (state->stack[spi].spilled_ptr.type == SCALAR_VALUE ||
>> +             (state->stack[spi].spilled_ptr.type != NOT_INIT &&
> 
> Thinking more on this, your v2 was actually correct since in such case 
> stype
> would have been STACK_MISC or STACK_ZERO and we would have jumped to 
> goto mark
> here instead, so the above is not reachable under NOT_INIT. Anyway, I 
> took the
> v2 in, thanks!

Thanks! I missed this (NOT_INIT is associated with STACK_MISC/STACK_ZERO 
spill type) too.

> 
>> +              env->allow_ptr_leaks))) {
>>               __mark_reg_unknown(env, &state->stack[spi].spilled_ptr);
>>               for (j = 0; j < BPF_REG_SIZE; j++)
>>                   state->stack[spi].slot_type[j] = STACK_MISC;
>>
> 
