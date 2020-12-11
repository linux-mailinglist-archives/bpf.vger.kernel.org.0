Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3212D6E1E
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 03:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391205AbgLKC0K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 21:26:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44802 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390315AbgLKC0D (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Dec 2020 21:26:03 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BB2OxN8026559;
        Thu, 10 Dec 2020 18:25:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Nwx5kcdH/dsbtQd8cL0RaDi+8hvwccYmXBKCQJDbsYA=;
 b=HBkMZ7PuqxdBtsrSqal6H0fTqq4dZXTIH0n7fR25zh7pA7f+K+RBUaw8yyXWW+30xzVd
 xuqa8J6vx+MxdE83xGzRdceuJEhn2iDmIhXJQJVgk9nXJNsTYnm5dnSLP9wKPJDDOj+6
 Dbx5hMvKm44BOJLNJphTheA4dnZ5xu4upHI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35avdhcwst-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Dec 2020 18:25:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Dec 2020 18:25:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIm2czhZaXfViy/MJ+g1V8BLzKAk1LZI5v/D8SykhJHJHUcejv2NEDkDdUnvxJihiu5Bck169EGqku9ZaGuIMCm4rfx1GMmwWjXp9gMP8a1zzAwzzsfYJL9WP/9YrCjIOAHuQ8zvgNgQs5wcaemRs23kzWe6OAngpBAFuhn+A/nVtAs7TDs5u2ZWcPGGhrtj1Ry5tux7P7blCfXf3txtTuN3/KngwNAUr2XYJvuwubmsVwHUKToEDn0U0nCLOLiBGov+xeCBVx+baLUpSncvQkAwsfzAi/545J7wFTG5I07LSXr0Zaa+t70kt/hJIirtMx0Htuil7ZsLx/PKIBLnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nwx5kcdH/dsbtQd8cL0RaDi+8hvwccYmXBKCQJDbsYA=;
 b=SqC1MGG/F2bKPdjIrbv45HwQ9jJ5ThiZXWoyyOtqbJy15PQhGmD0NQhXKZVGCFo4Iyz6DivcEhGeZNXD8gUQBDpw/4v91kpuwMAFRI0vZ9bHK+h3jTQmVrfMFSbu5qT/bnLaxvf2YqXoi2PTBHvKMiNI9Lb+iof1AqaNwTpZG1MkwQc1Bb+p25c9hriwxYBJYq0tpIb5hQ5os7KxfcVeqPbT76Ntv5dA6c2pP6QJz44xKodPjtFKQsbJ9G2FOlgIITvBpCDPGlNylLcORLKkGh9eqd46WtC9Pbh//XFohQwA78qr9/EkXZnlvLM7Aklqu3P8sXV7EcbOkabF1iG3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nwx5kcdH/dsbtQd8cL0RaDi+8hvwccYmXBKCQJDbsYA=;
 b=azImtLNe3aPSweInBADXmnQcDV9jEzly9fnfPg9RI6+KvI949VqBTZA1u5t3kFLN2AoB4JQBgBXj/R15xs+oOCT+o9U95byOpkQp3Kv0s5bBayb7vZ4A6ttEPwsN4y5vSY9y/rJ7vAiGRv58AkE90rRMHN2pk1fqgAKRbVWYsdI=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3413.namprd15.prod.outlook.com (2603:10b6:a03:10b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Fri, 11 Dec
 2020 02:24:59 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3654.017; Fri, 11 Dec 2020
 02:24:59 +0000
Subject: Re: [PATCH bpf-next v2 1/2] bpf: permits pointers on stack for helper
 calls
To:     Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
References: <20201210013348.943623-1-yhs@fb.com>
 <20201210013349.943719-1-yhs@fb.com>
 <27ad1c8d-5294-8ddb-a750-90d82bdfcd68@iogearbox.net>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <40e41380-22aa-129d-a412-83a22c999c6c@fb.com>
Date:   Thu, 10 Dec 2020 18:24:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <27ad1c8d-5294-8ddb-a750-90d82bdfcd68@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:ca19]
X-ClientProxiedBy: BYAPR06CA0039.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::16) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::113f] (2620:10d:c090:400::5:ca19) by BYAPR06CA0039.namprd06.prod.outlook.com (2603:10b6:a03:14b::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Fri, 11 Dec 2020 02:24:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4e6f972-c48b-4d9b-ca95-08d89d7bf561
X-MS-TrafficTypeDiagnostic: BYAPR15MB3413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB34136A325F29C1FC3BE01559D3CA0@BYAPR15MB3413.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lp7gDHbY7zMMZi8TeN7aCC4D2MaoAdpsa3jDYZ0Jm90xiJyy7wDFqMYcfP37i712JSRaOwe2Vhd9XeGZz9EH/rTrF+Uuf7miUtQLOSP/r2hUn13geUq3odSs6nkZhSlSf/fXVgP0nJX43xAPoyVveCWjp4mjMzcurQzfBPfa8U6SNUtgdv7YvHhlpwPEzdJ5p8lG1Xd2GM7+iPbg1EVcGq3EYf4qIZTj+5H4WUWDXlr07pElpDqIn0xaPIu2PjHuxFBtikse6sJ1wnXaL6UHG2ONdpmIYusrqD5PM0Ynf6METK2hzKftJf3X4pHfQpj/4JxyeZeVHy///BhdzPcs2VYiFEP9PITvxIP59TGhXwThdysChHz+Ck+/4TNJsO0Ayi0MPEV2ml9YhIQA3avUISbdbmOT63IwLmuIGLkFzsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(376002)(8936002)(508600001)(5660300002)(31696002)(2906002)(86362001)(2616005)(66476007)(66556008)(66946007)(16526019)(53546011)(54906003)(36756003)(83380400001)(6486002)(31686004)(52116002)(4326008)(186003)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eHpQL0I4TlJEUkVPRmNHQ2d1VHRrRm13NE02MWxLMC93ZjhHeFFsWjE4SC9T?=
 =?utf-8?B?QXpzS3dzUWhDcGhLTWNrWVVqb24xR1c1aVVsTXp1WmwwOUJML3BUcUk4WmFY?=
 =?utf-8?B?WWJ5YksvY01IUjN1bDRBOUtLZmN2UkkrQ1d2WHA0YjU4NEdBTUp4ZXRFV0xF?=
 =?utf-8?B?d21tMVVneWZnWU1ZeHQzbmhMbzFHTUdNdTFja1ZLVWNmV2JiUDY2T0w0a1hZ?=
 =?utf-8?B?d1NWYmZvNzZQU0kyUUN0TUIzeDU3a0xRVXFCaDlsQ2tCclV1TDhlL3p6bDRa?=
 =?utf-8?B?ZFY3OEhpalJBR1dZR0FWa2VWNUZiaDlQenlJd2NudWlISjd2Q3BIdkt0Z082?=
 =?utf-8?B?VVBKZ252VzR1a1JZVHJ3dVMrWCtuSW9Hb09XalEvdTZyaUZlV2xuV0k1KzJn?=
 =?utf-8?B?OTNydjBhV0xYY1hEUm1ubUJBMXpHYXpwcDJyU0U4TktnTytxbXBZMDNXUXVk?=
 =?utf-8?B?Z29GaFU1SXlRcWZsTmVGZHg0Y3VlbjNEeWQ4Q3RuWlplZDJJQzNyVjU2QmRy?=
 =?utf-8?B?cU5NSWV5bHhjaG1qdjNpWGF2RExmay9KMlBFMStlUnU1ODdGOGRlSmVONGZp?=
 =?utf-8?B?bW9NUnl5Tmx5dlA1NzJPNllhY3NHSnNmOW1SY3NIWVR1Q2h1NERtMGRoZlp1?=
 =?utf-8?B?NE15ekI1Vi9VMlYvN3BhSkJxSElpUzVuUkhtMTl1RUR5MklFSUxmWm5HOFhV?=
 =?utf-8?B?cW5VNzZJaG94d0RUSG1BdCtSemJWOTZYU1RKRHpGd0Z6dFVvTU9wb1hWZnBi?=
 =?utf-8?B?L1NGZkNhRTNBRHBQeFZ3bE9YWGRJRjQzcVhnakpYN2NZbCtoOHhGeVlkK241?=
 =?utf-8?B?Rmh2QTdrbVdlN3pyODNjMU9hV1Y2Ym9nMGNrY0dnbUdVejRpMVMyeWtFeFkx?=
 =?utf-8?B?cStiWjhYNVBmNUNSUDYxWW9qWkwwazRaUE8zdjlVL3lFSHVPb004YjBOQmRY?=
 =?utf-8?B?cVRGQjVtRENJWFpBc2UrSWRGUnRkanFsVzMremFOY2xtSGRvZDl0MGdjMGZX?=
 =?utf-8?B?WTV6VVIwRHNUdjVNL3MvaVgwTGtFc3N1amtzR1ZUd0lQaitZWUk4bXR5K2w4?=
 =?utf-8?B?UUdSc0hDZjBLS1NSeXBmZmJ0d052Vkc3QzVnRHhyaVFROVdISjhUYUx0UjM0?=
 =?utf-8?B?MVNheTlNZ2ZmUlNqaGx6R2Vrcy9FdjdsUnR5NzJXSDRXUkY0c2h2bzFvK3di?=
 =?utf-8?B?czNqaVNUT2VwUVNYdlpidGlvdGIwaU1LMFFGa2NTYkJ6bU05RTdzWFBTTGlI?=
 =?utf-8?B?aFJCcGdNbXkweHJLdEp0eS9ndy9wOC9uTzhPclJPNVRDallQZzlJYy9HRHJ6?=
 =?utf-8?B?REdvczFvVmliS2lkclloRExXaW5KL282a0RobDJHMWtMRTgwajg4UFhDSk9H?=
 =?utf-8?B?WkVGczJ0MmdtakE9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2020 02:24:59.5240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e6f972-c48b-4d9b-ca95-08d89d7bf561
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFtBSDxUBzLq2EEUIsGow5uwkM2iqFvccVBFqsjEcCy4zO2FmP12F/FwQdWI7aNs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3413
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-10_11:2020-12-09,2020-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012110013
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/10/20 4:10 PM, Daniel Borkmann wrote:
> On 12/10/20 2:33 AM, Yonghong Song wrote:
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
>>   kernel/bpf/verifier.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 93def76cf32b..9159c9822ede 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3769,7 +3769,8 @@ static int check_stack_boundary(struct 
>> bpf_verifier_env *env, int regno,
>>               goto mark;
>>           if (state->stack[spi].slot_type[0] == STACK_SPILL &&
>> -            state->stack[spi].spilled_ptr.type == SCALAR_VALUE) {
>> +            (state->stack[spi].spilled_ptr.type == SCALAR_VALUE ||
>> +             env->allow_ptr_leaks)) {
> 
> Afaik, in check_stack_write() we mark some of the spilled_ptr.type as 
> NOT_INIT,
> shouldn't we at least avoid an implicit transition of NOT_INIT into 
> SCALAR_VALUE?

Make sense! here we check env->allow_ptr_leaks and we should the 
spilled_ptr.type for allow_ptr_leaks should be a pointer (!= NOT_INIT).
Will send v3 soon.

> 
>>               __mark_reg_unknown(env, &state->stack[spi].spilled_ptr);
>>               for (j = 0; j < BPF_REG_SIZE; j++)
>>                   state->stack[spi].slot_type[j] = STACK_MISC;
>>
> 
