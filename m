Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17D65B3D07
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 18:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiIIQbu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 12:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiIIQbt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 12:31:49 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0326FA1E
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 09:31:47 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289Fc9IZ020984;
        Fri, 9 Sep 2022 09:31:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=m149IRAssr5SAryW+akKfCoaAXGVvTEyHPw+MdeHIyo=;
 b=VP5ZkSysiM4sYOfHVBLB7E13OLEkz/83E99lpwdoWXBUy2YTsbdDFdgH++Q9eUBKoDWP
 GWYTRaKV3Ad1YfTeLXu5fuR0O/8vLeGOu6wlWP/Ldj4ozKDECmZ+68+rXqVevmfQC4s4
 89dD4jFgb+5T0eNwNsEL8e0XSI/qJyetFCc= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jfbqxauby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 09:31:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqAayTG8IMC2LDA0AwT2IOe0K/GodRyNB7DLEDPTyVpepbRl4GbxDbW6QeTb6J09S6XHWswiaB2sflg6o/sIYFdrtMwetsITA/bs+jIhe0Do5N8WjR10YsXDHVVjNdC16XHxcVwRtpGnLWdUgtMCAJoiu+Z4TBAmbfrTkjVvg1A6vA4mB7RF1LoMf9J2NEIASBuNXa39dfZ2wqRbZepH9HXAqnpkTuGeANqCVo1PoV/vK58TpO0deA4mztHrjtpM5SCn3mI/um81uu78ioyVmBfT0uls2cDelCyOxLQ8+cPqahog/NPfaAD/nWJKMMqB6LBt0JGjrl+SzV5KJFcmBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m149IRAssr5SAryW+akKfCoaAXGVvTEyHPw+MdeHIyo=;
 b=ffTNbgMadSnH4N3QkOOU/f9ObyROPp6ZAJ/5K1TrKk2JLBHc4LnmBmiR9FbO5BQkhONBsTwgA6ylVUWFkPbHpBqtwOchi0t9FQm85cwMOkARVaLs2jDOjkr+zKKWBFvBrncXt+BDGY1NlHye9big/j7IQtrNlDAVUcD9YG3m/FZtlta0WXlaDfUMbv+mmpnzTQLfUsUWmSdlMB7duMYyM9X59CKJnpC3CLb1bEL85eED6aMJ127/2qPZbJh5FN9jXIB9BzvZuMlnR2OV7zWK/BNEzfCMmc3gU51k3kFEtgLAR27g7EQo78jnPtAFMYiPx757CSTw5L2rPuMW7wuVXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1157.namprd15.prod.outlook.com (2603:10b6:903:110::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 16:31:30 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5612.019; Fri, 9 Sep 2022
 16:31:30 +0000
Message-ID: <c97c123d-9d4a-6aff-e8d3-31ccf3b3e9df@fb.com>
Date:   Fri, 9 Sep 2022 09:31:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v4 5/8] libbpf: Add new BPF_PROG2 macro
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220831152641.2077476-1-yhs@fb.com>
 <20220831152707.2079473-1-yhs@fb.com>
 <CAEf4BzZ9PopF-9jL4XXTXPNHRMCpKuR0Yc=HZTiRMTaRA-SqUw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzZ9PopF-9jL4XXTXPNHRMCpKuR0Yc=HZTiRMTaRA-SqUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:180::46) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CY4PR15MB1157:EE_
X-MS-Office365-Filtering-Correlation-Id: be38f790-2667-4798-2443-08da9280c018
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cg0vQ1yQE6T5zz6rwtp1uHQuSU66B+X5LXfSffGAevxMuZPQNvth+0Xtv794kawIsFwCS4FH7QDoTle02Q1iqHe1zM3ddFZgqg3yEbfJ5ZVPXE8TyG2xv93KA7QoMnjPugf3GzqJnEq2B0Pntmou3Iqy5EVaciwiNzgm25TH/xgfyNbdFZvDRNfkOFITd2w5OluuZwo3E7vnzYZdSzFWKCEqs7cE4H3Deys2LizVbINofxgFoQz4FnSJ6jBqI193qIg5iEurdZA4D1CGVhNM8ht9Brhm6hu8UftnVnFxNmCHeK5hU0DoZkVRO1SYVYtPaKj6KBXb6jlaSVbVPpQDeHC0dXK0udrWrUF7CK0+vzKX2/Gfkh4Sb5512UhlK8AMX4YG2/YdtTsc8Q+9KtYlA4mpQTJe33KtU+ojYSarhX8whNSVX/mrtBd537AUMuTHuBHJJnweyGNepeWbIOHvqYseHH3gLUyFNO4AYqhfOVL78zIjApbhusy+ZQmnU2DrM9z9pZSWrpRMrgUmeN1ucqXo56vGbcxA7DGDHmWDzQSEbA+xKD1ugO4tr0hkU1wptw4+iT7BewRDfY0rGQVUo3TijhkVmM2v0pESke1Wup/3sS0dUS4r/KBwWP4BDLcOG+gy73kWWn7LSC9LxcZIUYWE/IsMsV0+v5KY0f014N9d09J9O/gPqwEUiXQJ/Yi/xPsAWAYlSAt4ZTaQEuUm40pugOM14jsZwQnQfDdRtd5E8+rpw0Iov1v6FZXz79XPHJzm0Z4HCaK7PbQBR05KwiPTnm8wdLIGr5aijB1e8bo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(8676002)(6506007)(36756003)(2906002)(30864003)(5660300002)(8936002)(66476007)(66946007)(4326008)(2616005)(66556008)(31686004)(86362001)(6512007)(478600001)(186003)(6486002)(41300700001)(53546011)(31696002)(54906003)(316002)(6916009)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVpwWmpGVEppTEdINDU4VVUzRkpLdldtV1NFTUVPQjI4d05iNVorTHdNbmUv?=
 =?utf-8?B?dWZDZG9uc3YxMU84Lzk2bThBWjJIQUoreGdmZUFiblg3VFJPWDFONHNreGUx?=
 =?utf-8?B?NnZvWmRONUtXRi9JZlJESnA0M1ZyRjV1RTh4WFZITS9COXI2RFhMNUpKTjVM?=
 =?utf-8?B?MElOQ2xQT3dOMVM4TVlOL1I0bFFveWxxU3pzMnZLamZldE93eldQNnZNQnRj?=
 =?utf-8?B?bEl0L2ZROUJvNDNmRTNyRnNscVFWZjJMWDE4SDd5enRBMnhlNWJhdXVUc2dr?=
 =?utf-8?B?T0N5NUlHTDVGVlplQkI4R1p2VDNGbUY4ZVA4ZkRQMHFxdndDT0V5Q0pwZjAy?=
 =?utf-8?B?b0JkeXNmRjN4b3NYQnUzWEZOSVF0TG9Gd2J1aDVlMHd5TFhkMHJ0OU9SWXZs?=
 =?utf-8?B?YklucDlvbGRwc0dOU08wZ001NUErM0VrRjdzL0RzN2gxdk9nekY5dEhsQkdo?=
 =?utf-8?B?cHpJTnhsT1Iydmh1N0REODBSZnpOdi84UkIzWGhlVHNDR2dxc3lITDVxQ1lY?=
 =?utf-8?B?L1c5K01UbnR4U01sVUR0ZzFRMndCUUNvUldSR3J0aVBVWjBRKzZ5QkkwejhN?=
 =?utf-8?B?SkViUGNWMDV0WDJ6WWVycTBmNHBqVyszNjNQNWd0WTBQeGNHd2hINW91cW5i?=
 =?utf-8?B?VVFTc05qcS8wODBER2s0Z2xHSDNNZm9GeWhidFhSYVdzYmVjUnFFcER6YUxm?=
 =?utf-8?B?dmYxTHVZalZBbnpZbDJJYmI3WHA5S2dSRnpxV24yWDRRKzM3aWw4L2NJaVgz?=
 =?utf-8?B?Z3RzeHl1MVE3RWovS0U2aHlQbXdVMk8yemxLcEV4cUdOVFZ0Vm8xRlYrVTM5?=
 =?utf-8?B?cEtkT3RUbDhEbnhlL0lhM0NjUmtLN0s4OCtYeTQ2OVUvT3ZHa2JVWnVTaURO?=
 =?utf-8?B?QWtOZFBRbHh3Uk1pSDJvcXo4ZVpQNVdXb1RRSEw0V2o2K0MybVhTNUw3aUNz?=
 =?utf-8?B?Zk1KUk1LQllhWW4wL2VtcUlUczdpa0I5MEM5dEFhc0VaeGw4TW0zZ004UEVP?=
 =?utf-8?B?b1FSWXd3dXpaOWQwM2FnRUV0UU5SbnNDMDE0dENBRDVZVFp3WVRSakd6MStH?=
 =?utf-8?B?ekJnNlVVdE1RRzlpNVBxZjFCanlCUTNjcERlNllETWRnVjlKY25pWTlvcmsz?=
 =?utf-8?B?SUFDSzhOKzRFRC84TEI3N29nYllSK01wbkgxSXVNTlpnNEFuTnY5b1hPSUZn?=
 =?utf-8?B?cWFrTHNrSm10QmlTMFphSnY2aVJxTlROcXdML1JvVXBZTEVCN1dreC9jYkdh?=
 =?utf-8?B?Qm5yNjZXRlZFbGlpbVRyVW1kU2w1UTRFTnd4SCsyYlVDVzk0MENWejRVZzBa?=
 =?utf-8?B?VjVlaFArWFpBOTVsWmlPSURYNHEwdTVWZ2VSTDVYMi9rdlhNd3BVQ1k3NUE5?=
 =?utf-8?B?Y2NDY25veHk1N3IzU0Y0aEgzU0FUWWJRUjVET2ljMnZnT2ZZMy9kRTltVkRU?=
 =?utf-8?B?ZHRLR0JCdGRQSTZvd0tKN2FkN2lwMVhDRitrendoWmRDSmE4b2dxT0JiS3Fx?=
 =?utf-8?B?Umt2WWUzRnFSMkhkbTJvTmFtdmZHR0JZQUJyRlRUNjJHNjczekNHd2p0Z3Yv?=
 =?utf-8?B?Skh4OENGaGRGTk5IeW80OHVUQTFsYUtRMThSY3RXQi9KZnoySDJTMlZMUUt6?=
 =?utf-8?B?R1dKdVhZS0t2dHo1RFdtTDkydkZMNWExTXdmWE4vR29MN1ZRSkNxc1VLS3Zj?=
 =?utf-8?B?amFyRUZudlFVVnpheVdJMnduTWxxYm9nUGljdEg1VzZ0OHFvZzZZNFZKYzcv?=
 =?utf-8?B?dUg5Q1N4ZUFwL2p2TzhNN0o0T2hJeUQvMW5KNGZwT2tIVlFzVVB5RDE1V2RZ?=
 =?utf-8?B?RFd4b0U5S1kvM2lPNnRNeUhhMDBEb1hFZCtTdnRkQnZBTnZtaUt3c3dGSXJ3?=
 =?utf-8?B?MWlJVENoKys3UXo2c0dRSXdRQXozbjlpREJ4MmkxTlNhd2ZDdlpacUJ5QzlQ?=
 =?utf-8?B?dlI3R1o0N1RPOUY2VnRmeU9QVDV5K3NIQXhOdmZaVHg0M2s4REtxQ3pJcVBX?=
 =?utf-8?B?Z0VBakVKYWNIM2M4YzdEcXkzVmYwc1ZkL2hXMWFCa244R3lRNWFNWW1Nc05m?=
 =?utf-8?B?dmpuaDBHR0ovQ1I2cDd4OWRDYy93TTRGMTk2N3pacmFoWWovdHZFTVBwWnN6?=
 =?utf-8?Q?R1XnW7i7Jzc1w67lljUAXEoV3?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be38f790-2667-4798-2443-08da9280c018
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:31:30.4185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqjmHpfrYcdntCCN6RPkWK0dwTLQG+ipt3nOXuVaKtLJFOFazssIrHMwsYez2JS+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1157
X-Proofpoint-GUID: bQ2Ss6qo4ATlLKrHJcgZb5_Y9L9fIi1V
X-Proofpoint-ORIG-GUID: bQ2Ss6qo4ATlLKrHJcgZb5_Y9L9fIi1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/8/22 5:11 PM, Andrii Nakryiko wrote:
> On Wed, Aug 31, 2022 at 8:27 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> To support struct arguments in trampoline based programs,
>> existing BPF_PROG doesn't work any more since
>> the type size is needed to find whether a parameter
>> takes one or two registers. So this patch added a new
>> BPF_PROG2 macro to support such trampoline programs.
>>
>> The idea is suggested by Andrii. For example, if the
>> to-be-traced function has signature like
>>    typedef struct {
>>         void *x;
>>         int t;
>>    } sockptr;
>>    int blah(sockptr x, char y);
>>
>> In the new BPF_PROG2 macro, the argument can be
>> represented as
>>    __bpf_prog_call(
>>       ({ union {
>>            struct { __u64 x, y; } ___z;
>>            sockptr x;
>>          } ___tmp = { .___z = { ctx[0], ctx[1] }};
>>          ___tmp.x;
>>       }),
>>       ({ union {
>>            struct { __u8 x; } ___z;
>>            char y;
>>          } ___tmp = { .___z = { ctx[2] }};
>>          ___tmp.y;
>>       }));
>> In the above, the values stored on the stack are properly
>> assigned to the actual argument type value by using 'union'
>> magic. Note that the macro also works even if no arguments
>> are with struct types.
>>
>> Note that new BPF_PROG2 works for both llvm16 and pre-llvm16
>> compilers where llvm16 supports bpf target passing value
>> with struct up to 16 byte size and pre-llvm16 will pass
>> by reference by storing values on the stack. With static functions
>> with struct argument as always inline, the compiler is able
>> to optimize and remove additional stack saving of struct values.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/bpf_tracing.h | 79 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 79 insertions(+)
>>
>> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
>> index 5fdb93da423b..8d4bdd18cb3d 100644
>> --- a/tools/lib/bpf/bpf_tracing.h
>> +++ b/tools/lib/bpf/bpf_tracing.h
>> @@ -438,6 +438,85 @@ typeof(name(0)) name(unsigned long long *ctx)                                  \
>>   static __always_inline typeof(name(0))                                     \
>>   ____##name(unsigned long long *ctx, ##args)
>>
>> +#ifndef ____bpf_nth
>> +#define ____bpf_nth(_, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, N, ...) N
>> +#endif
> 
> we already have ___bpf_nth (triple underscore) variant, wouldn't
> extending that one to support up to 24 argument work? It's quite
> confusing to have ___bpf_nth and ____bpf_nth. Maybe let's consolidate?
> 
> And I'd totally wrap this long line :)

I tried earlier and it doesn't work. I will try again. If it still not 
works, I will change the name to ___bpf_nth2 similar to ___bpf_narg2 below.

> 
> 
>> +#ifndef ____bpf_narg
>> +#define ____bpf_narg(...) ____bpf_nth(_, ##__VA_ARGS__, 12, 12, 11, 11, 10, 10, 9, 9, 8, 8, 7, 7, 6, 6, 5, 5, 4, 4, 3, 3, 2, 2, 1, 1, 0)
>> +#endif
> 
> similar confusiong with triple underscore bpf_narg. Given this is used
> in BPF_PROG2, how about renaming it to bpf_narg2 to make this
> connection? And also note that all similar macros use triple
> underscore, while you added quad underscores everywhere. Can you
> please follow up with a rename to use triple underscore for
> consistency?

Sounds good. Will change to ___bpf_narg2.

> 
>> +
>> +#define BPF_REG_CNT(t) \
> 
> this looks like a "public API", but I don't think this was the
> intention, right? Let's rename it to ___bpf_reg_cnt()?

Yes, I can do it.

> 
>> +       (__builtin_choose_expr(sizeof(t) == 1 || sizeof(t) == 2 || sizeof(t) == 4 || sizeof(t) == 8, 1, \
> 
> nit: seeing ____bpf_union_arg implementation below I prefer one case
> per line there as well. How about doing one __builtin_choose_expr per
> each supported size?

Actually, I did have each individual case per line in the beginning. But 
later on I changed to the above based on Kui-Feng's comment. I can 
change back to each case per line in the next revision to be aligned
with other usages.

> 
>> +        __builtin_choose_expr(sizeof(t) == 16, 2,                                                      \
>> +                              (void)0)))
>> +
>> +#define ____bpf_reg_cnt0()                     (0)
>> +#define ____bpf_reg_cnt1(t, x)                 (____bpf_reg_cnt0() + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt2(t, x, args...)                (____bpf_reg_cnt1(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt3(t, x, args...)                (____bpf_reg_cnt2(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt4(t, x, args...)                (____bpf_reg_cnt3(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt5(t, x, args...)                (____bpf_reg_cnt4(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt6(t, x, args...)                (____bpf_reg_cnt5(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt7(t, x, args...)                (____bpf_reg_cnt6(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt8(t, x, args...)                (____bpf_reg_cnt7(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt9(t, x, args...)                (____bpf_reg_cnt8(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt10(t, x, args...)       (____bpf_reg_cnt9(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt11(t, x, args...)       (____bpf_reg_cnt10(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt12(t, x, args...)       (____bpf_reg_cnt11(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt(args...)        ___bpf_apply(____bpf_reg_cnt, ____bpf_narg(args))(args)
>> +
>> +#define ____bpf_union_arg(t, x, n) \
>> +       __builtin_choose_expr(sizeof(t) == 1, ({ union { struct { __u8 x; } ___z; t x; } ___tmp = { .___z = {ctx[n]}}; ___tmp.x; }), \
>> +       __builtin_choose_expr(sizeof(t) == 2, ({ union { struct { __u16 x; } ___z; t x; } ___tmp = { .___z = {ctx[n]} }; ___tmp.x; }), \
>> +       __builtin_choose_expr(sizeof(t) == 4, ({ union { struct { __u32 x; } ___z; t x; } ___tmp = { .___z = {ctx[n]} }; ___tmp.x; }), \
>> +       __builtin_choose_expr(sizeof(t) == 8, ({ union { struct { __u64 x; } ___z; t x; } ___tmp = {.___z = {ctx[n]} }; ___tmp.x; }), \
>> +       __builtin_choose_expr(sizeof(t) == 16, ({ union { struct { __u64 x, y; } ___z; t x; } ___tmp = {.___z = {ctx[n], ctx[n + 1]} }; ___tmp.x; }), \
>> +                             (void)0)))))
> 
> looking at this again, we can do a bit better by using arrays, please
> consider using that. At the very least results in shorter lines:
> 
>   #define ____bpf_union_arg(t, x, n) \
> -       __builtin_choose_expr(sizeof(t) == 1, ({ union { struct { __u8
> x; } ___z; t x; } ___tmp = { .___z = {ctx[n]}}; ___tmp.x; }), \
> -       __builtin_choose_expr(sizeof(t) == 2, ({ union { struct {
> __u16 x; } ___z; t x; } ___tmp = { .___z = {ctx[n]} }; ___tmp.x; }), \
> -       __builtin_choose_expr(sizeof(t) == 4, ({ union { struct {
> __u32 x; } ___z; t x; } ___tmp = { .___z = {ctx[n]} }; ___tmp.x; }), \
> -       __builtin_choose_expr(sizeof(t) == 8, ({ union { struct {
> __u64 x; } ___z; t x; } ___tmp = {.___z = {ctx[n]} }; ___tmp.x; }), \
> -       __builtin_choose_expr(sizeof(t) == 16, ({ union { struct {
> __u64 x, y; } ___z; t x; } ___tmp = {.___z = {ctx[n], ctx[n + 1]} };
> ___tmp.x; }), \
> +       __builtin_choose_expr(sizeof(t) == 1, ({ union { __u8 z[1]; t
> x; } ___tmp = { .z = {ctx[n]} }; ___tmp.x; }), \
> +       __builtin_choose_expr(sizeof(t) == 2, ({ union { __u16 z[1]; t
> x; } ___tmp = { .z = {ctx[n]} }; ___tmp.x; }), \
> +       __builtin_choose_expr(sizeof(t) == 4, ({ union { __u32 z[1]; t
> x; } ___tmp = { .z = {ctx[n]} }; ___tmp.x; }), \
> +       __builtin_choose_expr(sizeof(t) == 8, ({ union { __u64 z[1]; t
> x; } ___tmp = {.z = {ctx[n]} }; ___tmp.x; }), \
> +       __builtin_choose_expr(sizeof(t) == 16, ({ union { __u64 z[2];
> t x; } ___tmp = {.z = {ctx[n], ctx[n + 1]} }; ___tmp.x; }), \
>                                (void)0)))))
> 
> It is using one- or two-element arrays, and it also has uniform
> {ctx[n]} or {ctx[n], ctx[n + 1]} initialization syntax. Seems a bit
> nicer than union { struct { ... combo.

Sounds good. Will try to do this.

> 
>> +
>> +#define ____bpf_ctx_arg0(n, args...)
>> +#define ____bpf_ctx_arg1(n, t, x)              , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt1(t, x))
>> +#define ____bpf_ctx_arg2(n, t, x, args...)     , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt2(t, x, args)) ____bpf_ctx_arg1(n, args)
>> +#define ____bpf_ctx_arg3(n, t, x, args...)     , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt3(t, x, args)) ____bpf_ctx_arg2(n, args)
>> +#define ____bpf_ctx_arg4(n, t, x, args...)     , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt4(t, x, args)) ____bpf_ctx_arg3(n, args)
>> +#define ____bpf_ctx_arg5(n, t, x, args...)     , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt5(t, x, args)) ____bpf_ctx_arg4(n, args)
>> +#define ____bpf_ctx_arg6(n, t, x, args...)     , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt6(t, x, args)) ____bpf_ctx_arg5(n, args)
>> +#define ____bpf_ctx_arg7(n, t, x, args...)     , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt7(t, x, args)) ____bpf_ctx_arg6(n, args)
>> +#define ____bpf_ctx_arg8(n, t, x, args...)     , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt8(t, x, args)) ____bpf_ctx_arg7(n, args)
>> +#define ____bpf_ctx_arg9(n, t, x, args...)     , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt9(t, x, args)) ____bpf_ctx_arg8(n, args)
>> +#define ____bpf_ctx_arg10(n, t, x, args...)    , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt10(t, x, args)) ____bpf_ctx_arg9(n, args)
>> +#define ____bpf_ctx_arg11(n, t, x, args...)    , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt11(t, x, args)) ____bpf_ctx_arg10(n, args)
>> +#define ____bpf_ctx_arg12(n, t, x, args...)    , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt12(t, x, args)) ____bpf_ctx_arg11(n, args)
>> +#define ____bpf_ctx_arg(n, args...)    ___bpf_apply(____bpf_ctx_arg, ____bpf_narg(args))(n, args)
>> +
>> +#define ____bpf_ctx_decl0()
>> +#define ____bpf_ctx_decl1(t, x)                        , t x
>> +#define ____bpf_ctx_decl2(t, x, args...)       , t x ____bpf_ctx_decl1(args)
>> +#define ____bpf_ctx_decl3(t, x, args...)       , t x ____bpf_ctx_decl2(args)
>> +#define ____bpf_ctx_decl4(t, x, args...)       , t x ____bpf_ctx_decl3(args)
>> +#define ____bpf_ctx_decl5(t, x, args...)       , t x ____bpf_ctx_decl4(args)
>> +#define ____bpf_ctx_decl6(t, x, args...)       , t x ____bpf_ctx_decl5(args)
>> +#define ____bpf_ctx_decl7(t, x, args...)       , t x ____bpf_ctx_decl6(args)
>> +#define ____bpf_ctx_decl8(t, x, args...)       , t x ____bpf_ctx_decl7(args)
>> +#define ____bpf_ctx_decl9(t, x, args...)       , t x ____bpf_ctx_decl8(args)
>> +#define ____bpf_ctx_decl10(t, x, args...)      , t x ____bpf_ctx_decl9(args)
>> +#define ____bpf_ctx_decl11(t, x, args...)      , t x ____bpf_ctx_decl10(args)
>> +#define ____bpf_ctx_decl12(t, x, args...)      , t x ____bpf_ctx_decl11(args)
>> +#define ____bpf_ctx_decl(args...)      ___bpf_apply(____bpf_ctx_decl, ____bpf_narg(args))(args)
>> +
>> +/*
>> + * BPF_PROG2 can handle struct arguments.
> 
> We have to expand comment here. Let's not slack on this. Point out
> that it's the similar use and idea as with BPF_PROG, but emphasize the
> difference in syntax between BPF_PROG and BPF_PROG2. I'd show two
> simple examples of the same function with BPF_PROG and BPF_PROG2 here.
> Please follow up.

Will add detailed comments to explain why BPF_PROG2 and its core usage
and difference from BPF_PROG in the followup patch.

> 
>> + */
>> +#define BPF_PROG2(name, args...)                                               \
>> +name(unsigned long long *ctx);                                                 \
>> +static __always_inline typeof(name(0))                                         \
>> +____##name(unsigned long long *ctx ____bpf_ctx_decl(args));                    \
>> +typeof(name(0)) name(unsigned long long *ctx)                                  \
>> +{                                                                              \
>> +       return ____##name(ctx ____bpf_ctx_arg(____bpf_reg_cnt(args), args));    \
> 
> nit: you could have simplified this by doing ____bpf_reg_cnt() call
> inside ____bpf_ctx_decl(args...) definition. I think it's a bit more
> self-contained that way.

Will do this in the follow-up patch.

> 
>> +}                                                                              \
>> +static __always_inline typeof(name(0))                                         \
>> +____##name(unsigned long long *ctx ____bpf_ctx_decl(args))
>> +
>>   struct pt_regs;
>>
>>   #define ___bpf_kprobe_args0()           ctx
>> --
>> 2.30.2
>>
