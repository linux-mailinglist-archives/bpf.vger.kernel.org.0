Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DBE58D3F2
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 08:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiHIGl7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 02:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbiHIGl6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 02:41:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A70201AC
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 23:41:57 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 278NSIkY003012;
        Mon, 8 Aug 2022 23:41:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vNuu8uj6BRVYR1PX60CgPjzlzfCGDeVm2Lz7h85VZVM=;
 b=aGA2+/RaNznSIJlIU5+qBqNDSVgoicwUiBboyJMnFGf0JTjTec+AYo61dfcexqzgq28R
 0NgDyal8kYwQBZa0/fiRPvzOOTBj8Ki3dlifqvYKMjciapcOPNmwleXbBjcK/2MOsupb
 F/qvxp4hU00DB6k38N9s9xIQpB3sPwlKmUA= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hskt8ynq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 23:41:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfVe8dQgt/gt9YrN5gJr3lCMre+Xqn2ndo9ZOkoEHgZzR8d5rxIc8fhC3vchF3aAfPA1q/+lMR/hPe3oUFCVSj+A58fQExGIgyxMe7F4BOh7rtpeqKVIWkRxa0BN4IWFzJ8kYqdxNAsjnyBmKR4BOJn7pAkgG3IKYrhFWf2P/1539sptOTIvoTetQI3ir383v+cssSNY6E3VOb7b8fMZ9R2v3ku+LiixC5F1C8p1AdRaKXHvtw/3TZYglHVfLeWcz3z9K3B1RYGwcBn+akVd+On4/jHKV2jux0LraA7u81zGDq5eBzqehYhANW3WBZGAFn6KYJ40hJET06erMb96ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNuu8uj6BRVYR1PX60CgPjzlzfCGDeVm2Lz7h85VZVM=;
 b=h0JGrGC6B4HzIz7PR+bXkm4iiaGKMuD4kljsIGRt9u+phCL+OW4PgARnv1up71DHvKYoJM73THPoGwLgbl6zT+CBULQJy6T9cAapDCcfgPdlfu+koM+djlYJNjf7sgOp1jZgPdPE8QLTDCbNQ/tmIvoN6nG0i0ju7dH2dxQZHHmt3YWdrrw0MzByL94azNHr5KZVXX8RIQFYjcd6ogYyLupOwNWhOL52WqQKZkagRHcSaO8pPz0A29rGDcxXFewRWYsYzBMoiXidB9772MRYoCJTeC+I05DkCu2TNq2AdS3G1MJfPNYa9ygYfHgP+5aKKrIozlMAy3dNBpW0Nq6OpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB1998.namprd15.prod.outlook.com (2603:10b6:805:11::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 06:41:41 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 06:41:40 +0000
Message-ID: <2a3b9d6a-759a-cbfd-6f37-2ff804e87741@fb.com>
Date:   Mon, 8 Aug 2022 23:41:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add tests with u8/s16 kfunc
 return types
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
References: <20220807175111.4178812-1-yhs@fb.com>
 <20220807175126.4179877-1-yhs@fb.com>
 <CAEf4BzY7xdJx9uEGA-_Jx+VOnz2EdGrjyLrHENp-SsG2U+zPGw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzY7xdJx9uEGA-_Jx+VOnz2EdGrjyLrHENp-SsG2U+zPGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:a03:331::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 279b7171-3c4a-4ccd-4ea4-08da79d23788
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1998:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTjOvMePSEpubDddcGVQvOv1PS9LQ8GiG9TRIMReWl6L91/rB57HFJeu8iPNMRDaazyE73ychi0rwgysQw8chbZKD+zO1e+j/1fmXQC5NNH9+ytPyCmbiCnZQ5snGyqixMh7FlQbBhYdaH2Rd5VGRtS5DlK7Y//Cyk9E9EeSln6ZZJXaYLBtBqLYzo9fpWe2psKSyfT9ag22rpSf9BCIMepd3lrlZwLqe2qhyibch5RctJeZDMclGT3vR5i7Vz8E0LtGYZWAMNezx7b4C+waoTSuOmgRM05Uz6aCofAdDblqrzSyhyei5T8mp78h8klsmZY/QBndFEkive7Rj8mW50jXkWrjJQYttkFEtHBp9cmVVyalN3NxkDTjfkLTZfBmnCnTpmcvAnBn/Ep4Psy46LankacqBiALY7jFahdICoLro5Q7d16cXxKPsocZSIdyN/d1iXKc13jV8Dv5n3TipBFZrZzNqZOzk7kmC/8GgkqR0aq2g6ajXNb/nopt0zL+prwv+p61PxLa1KOoGJo8zDwQEAm36ueV8t7dT4jhT2l0+J1J09z0yPyG8NGgQwW5STP1zZuCi/ki9xBJN8XAgkhB8Xq2wCO8U7sx+5rZ20fiFwg1BrB/TBjiXGTfDRsMLbYR03FfF2r9mdXAVMwtW586cswWQqHfh0Klexa5M2h2ZmejXUWikkQ/KVT4eXRd9nLiHoJAl02797j/eH2FrvfWgI7Y6UDTdSI4dD3PeVBatCL+n/MdJ2+W3gembwdSLGI6EEH430m2vH6ZwZ12BiLrbuuxJ1WKFIcyLgaosBY2X9knuV5oeftNfWn7Vo9/7Tlt8bQeTeiug63z4rDSFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(66556008)(66476007)(8676002)(31686004)(36756003)(66946007)(4326008)(31696002)(8936002)(86362001)(6916009)(5660300002)(38100700002)(54906003)(2906002)(478600001)(6486002)(316002)(53546011)(6506007)(2616005)(6512007)(186003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGg4MVQ1VUZuNEFxUUVnMkxhSklOZUs4bXFGSU5JUjJzNDd6Wnd4K0ZEQUc4?=
 =?utf-8?B?WGVlY1QzL2VxVTFlQmdXUit3QXpDcHRVYUIzQU14bFpnc2JBb0N3bkQ5MUt4?=
 =?utf-8?B?WngzRkR3S1FUL256bUxsSDhFT29tVXVUZ1hoZWZoSkllTkZKdDRTNHAwOW8z?=
 =?utf-8?B?WlRHV29EUzJDZmRqdWp6TU1USkFvKzUycUhBMlNpUGtFMkRvK0QwZzU0R2E1?=
 =?utf-8?B?Ni9sWjFyZUEvTVozYlQ1YThCcDhycGJnbGxZWGQ4SlFJdDhXeE13OFByQWdu?=
 =?utf-8?B?WXFYL0xRQU9CdmlWbmlxNVBRL2VSeE1VNDBJaGs2QnZRNmNuRU5NL0xJeGNj?=
 =?utf-8?B?cjU1cGs4MzZDYnB3WERQWlVGRmcrWVhzVlpxYmhoM0tVbGpEQmMvSmN0VWJU?=
 =?utf-8?B?b2M2NGVob1JyZ1VnU2d1NDluVXNkL2ZGQnk5eXdDS3F2U1R2alcwK1hWZFJm?=
 =?utf-8?B?TEF3eTFaM3BOd2k2dmJSdytwdFpHdC95UmV1T3RkdzlUN3RTcFlIVG9tOGov?=
 =?utf-8?B?QjRRKzM3TFBqTi9aZENJSEN3cGtuOTlVZy9sOU9rdVFPZDRTU0FLOUgzUzcy?=
 =?utf-8?B?UjR0Y1BkQUh5YkVENnM0SGNZMVpuOG1FUGlocUgyR2hXTHlJL3Z2cFRUOHZv?=
 =?utf-8?B?dlVmbXJjaXpVTTNQM1VJVUg5ZUk4SWVhK1ZZMUlqaCtGcU1UZlEzNzYyZVJK?=
 =?utf-8?B?U2p3cXg4VWZQWFhQVlhkOEF1TWY3cC9DaXVSYlZEcmtTWm4rNThjNnhBV3Mr?=
 =?utf-8?B?VjQrcEE1K3Ryc3RuWHYxTEdiWHFFYWIwekpPKzJGczRqYTNUU2lvT1BhK2lL?=
 =?utf-8?B?aXdXaE1SK2UzLzQ0VGF2YktTcGl1MmxRa0taMmtUSkNaNS9FWVN5TGUwK2Ir?=
 =?utf-8?B?eTRhYmQ2WVhVZExVWXhKSnlZM1hPNERMUUJ2d1kzd2hhbHN5bXJlN2lBN3oz?=
 =?utf-8?B?dm9KTUVnOWhqL3dZZlJzSTJQdDF3LzZ3YnpVcDJCdm9BVitsTkg1aE9lQm8z?=
 =?utf-8?B?M3hja1NpNjdJem9zUm5jSFZaQlZ4QVpCVlBTczhncUduUG1lNWxvaXZKa2NR?=
 =?utf-8?B?WWVCcjlyQU54TWxWNXA2VjhIeTh0RlNBcnFka1Awb1BVRk1PQ0hCVG0xa2hF?=
 =?utf-8?B?TVZsWkJKRlZadE93L1FwWCtsWUFEa1lKZW9CNjR3U1hmSnVnZ2phVkFudGVJ?=
 =?utf-8?B?NVpRSXpueGs2TjlhV2ZNQzBPWDl2SjExSC9VUWo1eHlDKys0SDVsMFY4cXN0?=
 =?utf-8?B?Ry9jMmNWbHVFKyt0YWpNMlRQQmVXRUpET0E1K1dURFUyeVBjVjgvSk1ZN0RJ?=
 =?utf-8?B?OEU0aWZUT25zWVEyWHpQL0ZyREUwVXlLemU2V3N0bnFiajlKNTZoU09SRlFp?=
 =?utf-8?B?NWhIaXJ5aFNTL3QxQ1BpaDFFbVdNLzdlV2Zkd0dobDFNVVdUUURRSXhnbDJM?=
 =?utf-8?B?d2hSeGV4TTlzd3dXNlMzb3lSaks1YVJLWHkvYjZlSElkb0ExRVdicmRtd3pk?=
 =?utf-8?B?b2VpejJnY2JvR0dWOHY3eEN0TU91aGNzVGJFZFh1Q3BqTXNCc1luRFBhTzNN?=
 =?utf-8?B?eDQ5WDdINHUrQ2NxOXRsMUcyWmlVbWxGZ2ZWQ3FwS2FRa1ZQamh2dGZJV1E1?=
 =?utf-8?B?bEFOY2s3K05GSCtDUDRMT2dDaUFPemo2V3RTZ3BvYmRySFkyNk9aODBFYVRx?=
 =?utf-8?B?MzhuQXJNL2RzVzJtSUN4Z2kxdGpzVWVyZWpzbWVnNUhMQmYwcFRYQUU5MkZt?=
 =?utf-8?B?cDVCZ2JRR2swbklob3B4NGcrSlU0Z2JQTW51K2xWS3h1N3kzQWNnTm4rNkJW?=
 =?utf-8?B?QXVtOTN3RFRYeHQwME9oMGpCNjBibXo1Q2thZjZ1Rm9Ld1RjczZzM2h3cEJD?=
 =?utf-8?B?QlNvK0k5QWRSbzdqWjE3VWlCK3B0RHlseGFEOG1RNlNWaGVBeDk0S3A3Ylpl?=
 =?utf-8?B?aThqZnlycjBSRVdvOTNPd1Z5T2JhcmpkVkRrUjNwRldBZkJ1dmZwSHRLaHpV?=
 =?utf-8?B?c0RHSTdtN2ZWQUEzakNZemlCeFB1bmM5VDJXTTZzSDI2RFRSZDhUbjBuU29V?=
 =?utf-8?B?VkRqMHg4eEVTZnRUbFEzSUdRdmIwdTVOc0NiOEZxb1dUZXB1S0JBdmJFOElv?=
 =?utf-8?B?SmpiUk53L0hSSlVpaTRWeUdpM3pjMmVVNEdXMGhSaldDQ3NRV3ZxUmU2d1pD?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279b7171-3c4a-4ccd-4ea4-08da79d23788
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 06:41:40.9056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tydHk4wN0v3e380+a7ldsV5mSjCTBcDGNCF7k8x0jLAUN6QrJirjw/F0l787Lwbg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1998
X-Proofpoint-GUID: k7Lu19F8opUqsV9cpHqwi7hub9ysif3G
X-Proofpoint-ORIG-GUID: k7Lu19F8opUqsV9cpHqwi7hub9ysif3G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_03,2022-08-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/8/22 4:25 PM, Andrii Nakryiko wrote:
> On Sun, Aug 7, 2022 at 10:51 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add two program tests with kfunc return types u8/s16.
>> With previous patch, xlated codes looks like below:
>>    ...
>>    ; return bpf_kfunc_call_test4((struct sock *)sk, (1 << 16) + 0xff00, (1 << 16) + 0xff);
>>       5: (bf) r1 = r0
>>       6: (b4) w2 = 130816
>>       7: (b4) w3 = 65791
>>       8: (85) call bpf_kfunc_call_test4#8931696
>>       9: (67) r0 <<= 48
>>      10: (c7) r0 s>>= 48
>>      11: (bc) w6 = w0
>>    ; }
>>      12: (bc) w0 = w6
>>      13: (95) exit
>>    ...
>>    ; return bpf_kfunc_call_test5((struct sock *)sk, (1 << 8) + 1, (1 << 8) + 2);
>>       5: (bf) r1 = r0
>>       6: (b4) w2 = 257
>>       7: (b4) w3 = 258
>>       8: (85) call bpf_kfunc_call_test5#8931712
>>       9: (67) r0 <<= 56
>>      10: (77) r0 >>= 56
>>      11: (bc) w6 = w0
>>    ; }
>>      12: (bc) w0 = w6
>>      13: (95) exit
>>
>> For return type s16, proper sign extension for the return value is done
>> for kfunc bpf_kfunc_call_test4(). For return type s8, proper zero
>> extension for the return value is done for bpf_kfunc_call_test5().
>>
>> Without the previous patch, the test kfunc_call will fail with
>>    ...
>>    test_main:FAIL:test4-retval unexpected test4-retval: actual 196607 != expected 4294967295
>>    ...
>>    test_main:FAIL:test5-retval unexpected test5-retval: actual 515 != expected 3
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   net/bpf/test_run.c                            | 12 +++++++
>>   .../selftests/bpf/prog_tests/kfunc_call.c     | 10 ++++++
>>   .../selftests/bpf/progs/kfunc_call_test.c     | 32 +++++++++++++++++++
>>   3 files changed, 54 insertions(+)
>>
>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>> index cbc9cd5058cb..3a17ab4107f5 100644
>> --- a/net/bpf/test_run.c
>> +++ b/net/bpf/test_run.c
>> @@ -551,6 +551,16 @@ struct sock * noinline bpf_kfunc_call_test3(struct sock *sk)
>>          return sk;
>>   }
>>
>> +s16 noinline bpf_kfunc_call_test4(struct sock *sk, u32 a, u32 b)
>> +{
>> +       return a + b;
>> +}
>> +
>> +u8 noinline bpf_kfunc_call_test5(struct sock *sk, u32 a, u32 b)
>> +{
>> +       return a + b;
>> +}
> 
> Is there any upside of adding this to net/bpf/test_run.c instead of
> defining it in bpf_testmod?

I put these two functions in test_run.c since bpf_kfunc_call_test{1,2,3}
are defined here and they easily fit the existing kfunc_call testing code.

But yes, I just checked the bpf_testmod.c. Looks like I am able
to define kfunc's in bpf_testmod. Will respin in v2 with this change.

> 
>> +
>>   struct prog_test_member1 {
>>          int a;
>>   };
> 
> [...]
