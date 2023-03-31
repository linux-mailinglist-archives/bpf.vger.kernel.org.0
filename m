Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA556D23EF
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 17:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjCaP0x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 11:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjCaP0w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 11:26:52 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC751D2E7
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 08:26:51 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VE3A7x024009;
        Fri, 31 Mar 2023 08:26:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=VZTgFLESSv7xzg44RKh98B/sCMoqlMGapinwg8spUvE=;
 b=RTmjhtLg2bS7/khQ/q58teaPpxG04epVWFwiY7XhxFU7//x+KYTddp75VGQbmbcBLzsR
 8IRJ6ziGxCseE6+0hGGDI6T8NrLviiPfbHKlt4wCimctj5ZUNqtgngwaXLSsN3vJcH0r
 PCFGwjjuak/8BQwC8tz9Yema8PN7a2Ow4jQNPoGNHAsOYRkQJGyGpEpy79CjAMK+NHmC
 mDNXiTEL0XH/w/lUkH0xofK2GOk1w1ngsSRTONzcMN0gcq1rXkCqBFLR1jM7ZgRcr8x6
 LIWZDtauR67L1vJ783sLA5tNFsOLt7fw/gXmIhO8yZRcBRm0siNMF055v2UagmytxRoA sw== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pp0xc8kp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 08:26:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qn8gLlHHHzR03hznXaWwBOwoXt26fvPpCkVtEBlhYsWoor545TPPo4n71CTtKE/ApgtW8cStVsR+DcbcH90mk7fQSUgVttMmMVybsu5gV5teGrHchNMxMJBnZkbzpB4jb3d3xWYQ4jI8T0tqMEzuTpfH7HZ2Qfx159gXSrtTvfiFNcpl1BqVkNiffFdUyS3c4Hp1cOZyAl2kic2w6vTE9RaSVRdTbzsJuYnVr1xYf7W1P7UXO6sKXHcRE4GzGZT8nzGQ5/O9jqm6QRxSMk6GdbagqO4rBtiFbg5TclB48BxZTSZLG+WWqXjUjYlng+0/6Lw3o4RJzyDVmr+IUaHGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZTgFLESSv7xzg44RKh98B/sCMoqlMGapinwg8spUvE=;
 b=ByEQxIqLfvGks3whNZDPXNECIi0bL9v1kW4EkY7bAAAya4GIqivdzmNbWVeqjLEs3BL8lzuCTcwiWB16aHEWr7J/v0Idixoui42IxqzyPaXuxL/KMMmud09QqhlfTp/isu2OItP9fhvlQce982gLaoDBlrDtgZbxRkIsmaUq3jGSTPUHeb6xNBiXjZxqV1iVTDYnXHccGKoqCEZt+uMRmaUJWGKszuAH28hpIyyFRGke2quAVWAWKnSG/mwlLJQzUCFmdeltAioC0tdFvmeSTz2bRPZSamwX7nVA6sqCie5d52BV3vulAIHFn/D7fMSrfIUJsZQQ8mCyJ43ddpw0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH0PR15MB6295.namprd15.prod.outlook.com (2603:10b6:610:185::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 15:26:34 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%5]) with mapi id 15.20.6254.021; Fri, 31 Mar 2023
 15:26:34 +0000
Message-ID: <fb8ae234-119f-de7f-91b3-77734f3b03a3@meta.com>
Date:   Fri, 31 Mar 2023 08:26:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH bpf-next 3/7] bpf: Improve handling of pattern '<const>
 <cond_op> <non_const>' in verifier
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@meta.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230330055600.86870-1-yhs@fb.com>
 <20230330055615.89935-1-yhs@fb.com>
 <57694299-9960-0ab7-be61-4f6ba903b72b@meta.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <57694299-9960-0ab7-be61-4f6ba903b72b@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CH0PR15MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 233659b0-3f54-406f-af79-08db31fc4fff
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLeOOkrrVD454S1iFnukzwyA9M0gGmqjL/C8SsHSbMqOdHuAtB3Go1ZvWbkycS7xu5RU4a9Z2FE6vQTBaLQc9Y2WRYZaKhtVYkn3CeBuTfERQhEIxkwXO/z9ZDPB7XKQDyXedOtLPvnTNY0NadRxVVLG1Zd/PsKBh+FWK0IDPggeOpDP7a0epeBgCkZDBC9FjsBd3eJB/80nUwcoZ0FF2Oa6hSO9KGyy7dVGzrYHd01PI4JDkPtjckmN3ZxcBH8aLMzr5gRyKEjFLANumAQqDc6qk7mtEd5wYFJGFLmdRrNTSfcSTQ4FOsXgv1pSEAdMhgq2wxiNI9S1YF67gzVWzx9eKAaM1KnjXFkVTJ+TaLlAA+v6GGr6Gn3en1CMbKajKtja7B+ugT6zsV0Cnef5ApCSH09FK/NmuZd3JVLsOIYCSQiYC6SIxURFPC1pP1XTHQ/GG5Be93cYwsZ+gyRYp+bWxkVVZ5sxW2/DIar4/tEBDPj9lDs4tkO3V1VBtNCuXLzuoFHUPTZCzWTpTSmPkf3CVYCEw5oWPI6jHL8jMhxU22NTy1UYBki8EmLpXv38/6P37B6UBfFD9Wu5zm2m3ETdOVUBRqgXmuiVof/eEzdH6wo5H9a2SG5xNT3Mfe5DBlDHl7zcsDa5bMPA8tvHCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199021)(83380400001)(2616005)(8936002)(5660300002)(186003)(38100700002)(86362001)(6666004)(6512007)(6506007)(31696002)(31686004)(6486002)(53546011)(66556008)(66946007)(66476007)(41300700001)(478600001)(4326008)(110136005)(316002)(54906003)(36756003)(8676002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk0vYkFDMnQ1bDJ0V0RudmY3SGQ3TS8zMGVaSUFiekZqU0x0V2hqWWR3TS9x?=
 =?utf-8?B?UEt3VzB1dmF3NDJZc0NHelpXamNoM2NTQVorTEJSNVZPaEJJcnBMamIzMEg5?=
 =?utf-8?B?cnJSN1FRZHgrckEzYisxWUtoU1F5ZW5UcGRUOU9BbEpiRXBpWU5Ra2h5eTZU?=
 =?utf-8?B?OWdBN0tFbzZZSzVYYUhXNWIrRnY3VWQ1T1F1NEtVR0p4bUxhZlhsSnhkbTQ2?=
 =?utf-8?B?aURrbXdUQWttQXgxQUUwbVZ2Qlh3UUFocVVrdjcxa2ZsWHlzQk5hZ254aEdT?=
 =?utf-8?B?ODRDV2hTQTRteTQveGxQQko0K1pLa3BBbk03WUd5cEZ4RkMrZVlvMkJSL2Zo?=
 =?utf-8?B?L3BRaTZINkJoUHJjNFF4dnlkQURZZExJRjhLOHRVZlpmVXI3UGFBRnRBRHRl?=
 =?utf-8?B?Mkl3UjR6bFoxbWNWUktUYU1PcjdCM1V1OFNPT3Uwelp1SzNoRnNWem9TOC9L?=
 =?utf-8?B?WEdtWjRkbVNnMStvWXJDK0plbzFLdHFtY095dE5mUXgyazRzai9QQUpuY3FI?=
 =?utf-8?B?MG1PWGRSREpibURwNXhSM3RDTjZDZ3cydUhkVVY4RjRHNEo5S09nRXhqYTRO?=
 =?utf-8?B?b0IrTXhkdHVkY2pOdmp0UUFma0F2U1FJZGw4UkZ3TGZTcVkzS3pHdjlKTUN4?=
 =?utf-8?B?dWM0cVFPRXhLOEtpQW5oVnNUMldUL1FqYWMrN1dHMXZ1akdNSTJpeFJ4Q2Vj?=
 =?utf-8?B?c01LcUg4MmlJdEN4aW5qZWZoS0UrcEVrMU8zd1UvT3liYUlMdUtUdGJ6S1B6?=
 =?utf-8?B?M0Y3N2lGT0VUTWtVZDhhSWJRV0xGL0NsOEJ6eGtGcmtpS1E2RmxOS2VuRGxW?=
 =?utf-8?B?aC95d29lUjlOYm53Q2VralJvYXBYTFkwWmdmSmdMZ2ExS09hWm1MSm5BM0pY?=
 =?utf-8?B?dXVWc2JiMkFIZkE2ODVwSi9PbGR3MGNIU1d0MTlGUW9VQ0lVODROK3JQc3VD?=
 =?utf-8?B?UTBYUFJiZTk5U2VnbTZTWjVNd2NPeE5yWi90TjhUbTVuLzk5ZE5FSnFkaExU?=
 =?utf-8?B?Q3IwVUhGdTd3OGZkV0VmZEx0ajNRdHltMUFudU5NNDZhblkyWEZMbmlVNTlv?=
 =?utf-8?B?anVTenpmcU9EVHA5TkRLUkQ4dFU1R1gySGNxSU1rY2M3eENVZFpSTk9LcTQw?=
 =?utf-8?B?T2NROE41WHFJYlRlOERkTlc0MFYwR0s0eHEzVTZMTjNhSnduWHZZdElmOVUv?=
 =?utf-8?B?cTJHM2hDS3RIS0RIZG8zNVQxc0FyWk0wYlVKZDNPNmFUVEwzOXVqeFFpTVdC?=
 =?utf-8?B?RDMza3M2QW1jUkxlUnRQUU85cThvTGxVSG5mZTVGbnpmNEtSeGo5TC9NWkN3?=
 =?utf-8?B?ZTJrODBOdEJjM0kydXhxZjEzMmMwMTBVMjFqSXY3b0xudlJoM3dLMVpwdDZX?=
 =?utf-8?B?eldDTW9vcFI0QVZYQm41S2FzRmk1L2V1dElSVFRKbmsyTmFrUjdXeUQzcVRF?=
 =?utf-8?B?RFNXOXNMZ0lobzRmTHZ6RGFtOEFtbTZUT1RqdHM5eEp4UThiNnQ2Qjh4Wjd4?=
 =?utf-8?B?VWc5S3ErWk5CSzJMSnBWaEtDbm56RGRkN2ZXNWFZVzFUR1VSVUxUbzRqR0oy?=
 =?utf-8?B?b25oVVZFWnJjQnlYYTdmS1gzTE8yRExjZ2tGTDhudmdHYkRyR09CdjJQc3hY?=
 =?utf-8?B?YWNTeWs1emZNQk1CQnh6a1BEaDB5NWxaNllwNVdnMjJ5ZjNTMG43NnZXdmQz?=
 =?utf-8?B?bS9QNFdWYlZWUmlzN2tVdHZva0dlZWYwZjE5R256QkdFQUpsbnJucjJuMUY3?=
 =?utf-8?B?WW9qU2RoamVLaEIvN0pkazR3aFNqZVNIajdRTEZ5azZIZnl6MXNkRTU1MFVN?=
 =?utf-8?B?ZXNmS2dGallzS1hWdi9hamJJZVlYMnFWSFVJSEpKcDhhU1VtVHJDRldRRjR1?=
 =?utf-8?B?UXpPTmZuRUV6Qjl3a2o5am9naVdFMmZjZmdjVjJCVGM2VHlvbC8zd2lxdEU2?=
 =?utf-8?B?STA2L3ZmdW02bHBaNUpqK3BJLytGL04yM0dDb1hxb2FGNFNNOFo5bGlVVTFM?=
 =?utf-8?B?Mno0Q05ZK2RVajIvcnZBcVpHc3FlVXRxSnBqME5MOE8ySkZGV3R6aVZsZlpY?=
 =?utf-8?B?V1NEWUkxSFQ4UzFDODNUeFd2SjhSMEtVMWx6YjFkSUhna1crcWJVa1dvTVhK?=
 =?utf-8?B?cWIwcFM4bllyYzdwZUZLMzAwZmhiM0NyNWVucXpuMHlOUERKNFhUMW9Xaytk?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233659b0-3f54-406f-af79-08db31fc4fff
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 15:26:34.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jpS2sftnznfQDFqVJXJbpfM1DFtQtyGwGCIPT2GoltdMFy2Ygl70dba2LVyQoln
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR15MB6295
X-Proofpoint-ORIG-GUID: DU-J1T-dIRMHwCxREmpIQuOFNO32He4G
X-Proofpoint-GUID: DU-J1T-dIRMHwCxREmpIQuOFNO32He4G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/30/23 3:54 PM, Dave Marchevsky wrote:
> On 3/30/23 1:56 AM, Yonghong Song wrote:
>> Currently, the verifier does not handle '<const> <cond_op> <non_const>' well.
>> For example,
>>    ...
>>    10: (79) r1 = *(u64 *)(r10 -16)       ; R1_w=scalar() R10=fp0
>>    11: (b7) r2 = 0                       ; R2_w=0
>>    12: (2d) if r2 > r1 goto pc+2
>>    13: (b7) r0 = 0
>>    14: (95) exit
>>    15: (65) if r1 s> 0x1 goto pc+3
>>    16: (0f) r0 += r1
>>    ...
>> At insn 12, verifier decides both true and false branch are possible, but
>> actually only false branch is possible.
>>
>> Currently, the verifier already supports patterns '<non_const> <cond_op> <const>.
>> Add support for patterns '<const> <cond_op> <non_const>' in a similar way.
>>
>> Also fix selftest 'verifier_bounds_mix_sign_unsign/bounds checks mixing signed and unsigned, variant 10'
>> due to this change.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   kernel/bpf/verifier.c                                | 12 ++++++++++++
>>   .../bpf/progs/verifier_bounds_mix_sign_unsign.c      |  2 +-
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 90bb6d25bc9c..d070943a8ba1 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -13302,6 +13302,18 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>>   				       src_reg->var_off.value,
>>   				       opcode,
>>   				       is_jmp32);
>> +	} else if (dst_reg->type == SCALAR_VALUE &&
>> +		   is_jmp32 && tnum_is_const(tnum_subreg(dst_reg->var_off))) {
>> +		pred = is_branch_taken(src_reg,
>> +				       tnum_subreg(dst_reg->var_off).value,
>> +				       flip_opcode(opcode),
>> +				       is_jmp32);
>> +	} else if (dst_reg->type == SCALAR_VALUE &&
>> +		   !is_jmp32 && tnum_is_const(dst_reg->var_off)) {
>> +		pred = is_branch_taken(src_reg,
>> +				       dst_reg->var_off.value,
>> +				       flip_opcode(opcode),
>> +				       is_jmp32);
>>   	} else if (reg_is_pkt_pointer_any(dst_reg) &&
>>   		   reg_is_pkt_pointer_any(src_reg) &&
>>   		   !is_jmp32) {
> 
> Looking at the two SCALAR_VALUE 'else if's above these added lines, these
> additions make sense. Having four separate 'else if' checks for essentially
> similar logic makes this hard to read, though, maybe it's an opportunity to
> refactor a bit.
> 
> While trying to make sense of the logic here I attempted to simplify with
> a helper:
> 
> @@ -13234,6 +13234,21 @@ static void find_equal_scalars(struct bpf_verifier_state *vstate,
>          }));
>   }
> 
> +static int maybe_const_operand_branch(struct tnum maybe_const_op,
> +                                     struct bpf_reg_state *other_op_reg,
> +                                     u8 opcode, bool is_jmp32)
> +{
> +       struct tnum jmp_tnum = is_jmp32 ? tnum_subreg(maybe_const_op) :
> +                                         maybe_const_op;
> +       if (!tnum_is_const(jmp_tnum))
> +               return -1;
> +
> +       return is_branch_taken(other_op_reg,
> +                              jmp_tnum.value,
> +                              opcode,
> +                              is_jmp32);
> +}
> +
>   static int check_cond_jmp_op(struct bpf_verifier_env *env,
>                               struct bpf_insn *insn, int *insn_idx)
>   {
> @@ -13287,18 +13302,12 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
> 
>          if (BPF_SRC(insn->code) == BPF_K) {
>                  pred = is_branch_taken(dst_reg, insn->imm, opcode, is_jmp32);
> -       } else if (src_reg->type == SCALAR_VALUE &&
> -                  is_jmp32 && tnum_is_const(tnum_subreg(src_reg->var_off))) {
> -               pred = is_branch_taken(dst_reg,
> -                                      tnum_subreg(src_reg->var_off).value,
> -                                      opcode,
> -                                      is_jmp32);
> -       } else if (src_reg->type == SCALAR_VALUE &&
> -                  !is_jmp32 && tnum_is_const(src_reg->var_off)) {
> -               pred = is_branch_taken(dst_reg,
> -                                      src_reg->var_off.value,
> -                                      opcode,
> -                                      is_jmp32);
> +       } else if (src_reg->type == SCALAR_VALUE) {
> +               pred = maybe_const_operand_branch(src_reg->var_off, dst_reg,
> +                                                 opcode, is_jmp32);
> +       } else if (dst_reg->type == SCALAR_VALUE) {
> +               pred = maybe_const_operand_branch(dst_reg->var_off, src_reg,
> +                                                 flip_opcode(opcode), is_jmp32);
>          } else if (reg_is_pkt_pointer_any(dst_reg) &&
>                     reg_is_pkt_pointer_any(src_reg) &&
>                     !is_jmp32) {
> 
> 
> I think the resultant logic is the same as your patch, but it's easier to
> understand, for me at least. Note that I didn't test the above.

Thanks. Will do refactoring to simplify logic in the next revision.
