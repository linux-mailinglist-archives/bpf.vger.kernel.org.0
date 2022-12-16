Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADF164E6BE
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 05:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiLPEkO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 23:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLPEkM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 23:40:12 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E915830F51
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 20:40:10 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG4Zpvq012052;
        Thu, 15 Dec 2022 20:39:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=N1WrU9IEawp7Lbep0gqZ85oq6RTOfZ8n/1Sr9QROrOI=;
 b=gHgLRyi2VcmTj4QVliPP32PTT9eQOv7d0JXr9IMfEWLa5YQafEs9dCtuGIr/x4pRXpON
 3779f7LTruKPvx9L/QFFgmBAuBma7caRsBfUnAdEs3eTIl1dCtmawD2eijLIWnx7ul4M
 Bss96fWzWSMo2sYRdfWuaEb4XLgke51k6XBiU5L+1gxal+6iU7zw7jSC7TYn3PObIuSs
 WQVjTabKGkY/+kMOoSkraeEvX/jDmCkGI+q305iyaX7MUOZYuCJ46w5Lt9i9nqJGK156
 OfxbW2pQxZP2xYeWxy1TBoTXPRC1LqChz5qyymYl0/vUibnsI6axulO2RTGJQ6D2tw5Z uA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mfrs91aeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 20:39:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOVV2mXr0KGxueONpDa1JEm0BrZXFzA7nrAkaD6R9tG7S6IRUmJYLFWj3ujs/asejJcaxCIlOA1P/PJrOTA6J9Cv0P12UKeJJmnBudyQMBtOCrSMsGpAWI1Hge1LipKRX4H2Ne6XnMxM4t9QuRsBVA1c9Z9yZXAweaAIHJDBwjK04rmt+f3QqtCnitlmoElSfQcs6tZiALBF0oLvxc8s6CWVZc6ftY4meG5jB7hR6fH7xI65c81wuMYdGqN8W/Cy6gqhJzGuKyRntIGfQ0/TkPZbfAj9Oa0gmlulZpnxxteVsu5n589afiQsX0rsoeoxvLAc1kbaumDHMUHerUjrqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1WrU9IEawp7Lbep0gqZ85oq6RTOfZ8n/1Sr9QROrOI=;
 b=BMeAwZ8o2DgEZqDJ0EI2RAHc6XN1wu3sr6MEUJMSdQPBZ++meC0CeE3l0sL3nkKSeSSVLoKrsoLMVrUpQHpKDkNIGdYGGv2sdSes0t5f4zjJlYWdjx1bmnxJjJagZ8Z7pGBmRlNSxKVaIOau7+s0lDl9vIJpBEgN+H7BLBBVylv43UOt/Bur+Xbg5Ds7j+/OCPojfWKZklCzdE7jq1V5734U+mY0QzQcZ+Umnz/Sj6rJ/VNx3Qod5s28ESEj1hnSrsOcUyZDD0nYrB5CgwKWJVF8Rc25P4cE9I1U5hv8NBG3kDNUMR3VRZ6fCUKW2Q8uyO+lGW4UJUsIGK5z03oH+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by MN2PR15MB3181.namprd15.prod.outlook.com (2603:10b6:208:fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 16 Dec
 2022 04:39:52 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::7124:3442:50ed:e480]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::7124:3442:50ed:e480%7]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 04:39:52 +0000
Message-ID: <6bf3ee92-55a1-57f9-6df5-4f8fa64f884b@meta.com>
Date:   Thu, 15 Dec 2022 23:39:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add verifier test exercising
 jit PROBE_MEM logic
To:     Yonghong Song <yhs@meta.com>,
        Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20221213182726.325137-1-davemarchevsky@fb.com>
 <20221213182726.325137-2-davemarchevsky@fb.com>
 <e2daa940-ec64-6b72-c8e9-b3157162af5b@meta.com>
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <e2daa940-ec64-6b72-c8e9-b3157162af5b@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:208:32f::16) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|MN2PR15MB3181:EE_
X-MS-Office365-Filtering-Correlation-Id: 309ce42e-9339-4b59-3025-08dadf1f9258
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aih9RfnuczE3mwuuxMKkaxAKgZmVzOWhxn/48ZEnIKevVfRFddHTNHp59PrQy2tRo+lhwvzY8WeKzSf+jOFZ547UsqTVIWsEvSipR6MPUfIFVsYu3Rwe3W8c06JWcJBv/3Mak8mPkqPUmi9AnQrQw5ggwQTyxyVNzJ8YmrLo8PIw0NCU+OpEKLoYLzVrbObk410x8BRY41qK4oijEJzB1nChQJafu3GhQTc/0FS101rNm60FAb/D7J65WCqCvbPfTJnrLBZtDfUPbB0B3wLcCoCJ1pxAPKbrqOaoAUPpmxVdDb3mWbglLmEESWZ7M9VeHyE7fQI7TGh4ldZSg/jY95/RmJ0jxKpkVcQPXS4xV0VqoQT6ryjMKZF7Ox7XMFU/beTsPVufL1U3w1HUEiOx5C866nMusO8S//UsaqPmyEtpKcF2EbLMu6ZQ7mXVDsyAZgWLbvsqP1Js24O971GYyh8tJk+NGgRa7AxjI1vaxrXWi9GDj2gGItGdD3mitxiEnFy2GGQDhj/Ng+E25fwrlyrujvAb3PROPxXVufSYGj6CgLNgWWs21k9cofI9sJVSVmAD7uIBeQnJ97nYuoJIBooeLYZpeGsF9QqQqE7yFdzfRz1RDt1Mtsh4vmmjdt7Kj8ltm54aTF0Tm8LJ0JXaD5sRm3GIm8ZjEDE7S3w2LXhinUHURbSrDcpD9rn3QqAHQwCJ0uM1SzyL3+zerVy6bqyhCgYe2Au9M3ypitGbYCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199015)(5660300002)(83380400001)(8936002)(2906002)(186003)(86362001)(31696002)(41300700001)(38100700002)(36756003)(53546011)(6486002)(31686004)(478600001)(6512007)(6506007)(4326008)(2616005)(66476007)(66556008)(6666004)(110136005)(316002)(54906003)(8676002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1liVWt3bHlWRTh1YVpZY09IN3hteEtBQisvK0VSUDVIR1N2byswelJITkUv?=
 =?utf-8?B?WjIvUW9PaFdQZFdsUEVsVGJibVlRd3NLczF4Y2NncGlRU2RwMS9oZDEzNVkr?=
 =?utf-8?B?TkQrZTk0NjFOd1NHSWtaQWNFTEx5R2Q4V09QREJ5WlZsMlBnTHVYMzg4aGRK?=
 =?utf-8?B?WXNiOFBEZDcrdGxQWnprQk90aFN4WWg4Lzhyd1pLODdQVE9KUHQxTXRNMzNQ?=
 =?utf-8?B?Ti8xTmhHYVRwZk5zVHlucFBKUHI2K3liRHg3VndoaCszdnpsZmpjYms2M3Fi?=
 =?utf-8?B?ZStrNGQ1dElzLzhzNkVaZFVRSjlhSkdNUHhYRUk2QXJIcVUwUHBxSmVwRk4w?=
 =?utf-8?B?MHdJdnU1d0ZoeitIU1UwbWlBWXU0QWtxNGtEZVluWGNmYTVTM3hLSVVReFNy?=
 =?utf-8?B?ZkdjdExaYjlPcnZicGJyU3hsSldkMS9VQ2N2TjBkVjZkQ1F6cUxrMGlUWERH?=
 =?utf-8?B?SHE0OGZRMnpRb0lhejI1QkZDTzdiNk1kK2Jyc0hrK1k5dDZVRWt2ZFI2TS9o?=
 =?utf-8?B?MTJycjIyUmdvSWM1RWV5amV6UGRObHlRdGxUUUVIZERNLzBQcG0rWERBaGZS?=
 =?utf-8?B?Q21GZDBWcjdSR2srVVRoVVdLdE5acGdXVWdhNVo0V0VFa1I4NmRjaUhvN0pz?=
 =?utf-8?B?Sm1laDJsK0VWMThyTlZSdWJuMnJxWnZQZHN1Rm8vcXZqRnpLbzVPbWhuVlYz?=
 =?utf-8?B?UEppbVJrZFFHNXpaVDJGTTE4VUR1NUJxWndBWlZSWXhOKzdTZ1FsdndTeWg1?=
 =?utf-8?B?SW9rbTZLNGpUcmtlUkRrWVJLenpRYzRnZG43RWdBajNibjhteTZzTTYrY0tv?=
 =?utf-8?B?NU5OZGZRV0d4V0tMTlJtUlROT3IzTHB3bndxejhmd1JTdkxucW1BWFZ4Y1Av?=
 =?utf-8?B?RzYzOXBIRWp4dW40N0RSYnhscS9raGVxT01idGF4MVRpS3JwOW1PbGd6ZkNN?=
 =?utf-8?B?T2ZWcXhKQUg1WDB3ZndIVFZzazlRUlVqbURCeDhjT1Z0QldpbXdmNDNKdDVB?=
 =?utf-8?B?U0JNYklTbVkrQlJuaEpqS3g3MkdaelE1WFg1WERQektrMzd6Zm53bGFIZDls?=
 =?utf-8?B?SW5nRHdYSlJET2NEeFlWaHRzaXB5bmdXU2FiSWFYOTVpMVR1SlgyTGhSU24z?=
 =?utf-8?B?RW1KSUNqcTNHdUpLYittSFJVaGQ3aGk5WXZtMjZwRjR5MXdkYnRsenlTeFR2?=
 =?utf-8?B?UDVBamNndlBzeWlyOXFYV2pSWXN1Y1JJYnRFNlAxV0dKR2kxczZENmNDYWN0?=
 =?utf-8?B?Ym1TNkNPelJPU0x2QkEvaGtLa1Rrbks5YkhML2FaTWlwRTh5WG91M3ZhN0ti?=
 =?utf-8?B?QXFvYW9SUWFnSmg5VmQ3aDJLT3ltb00xeCs3dzlueHdIbjZONzVKK0pkbHFC?=
 =?utf-8?B?eFNhM2k3WmRvVXAvZWZQVUlXTEV6VVoxQllHaTdKUE1NMWh6V2hQQWQ4em0v?=
 =?utf-8?B?SzN3dUxNU3ViOFQwSTRTd3BoS0Nqd01ZTXFsMUpSV2ZsUGY4cUNXMmQ5by96?=
 =?utf-8?B?QUxvWHdkTHdjakwxZFMrTGxkeisyQUxPelBFOGxGcVJkU2dHYTFBVEFYcjlG?=
 =?utf-8?B?aEZhM3FicmM4Q2grUzdJYUFFV1RRSDNrZmE3UHFRNzVvTTNuMHpPV2pBalZJ?=
 =?utf-8?B?dGdIWEFBZUlZeHBOZ1dBRXdMbThFOGpXa2hZZElPOHZSVTVGYi85TlJiS1hu?=
 =?utf-8?B?QThJelZRU29KT3hZYTN0cWN0SDdRY216NmZDTCtjZXYrb1dOWVlCcW1sN1RD?=
 =?utf-8?B?cFpGUGlNb2VJaUthci9TOUl6NXVQMnVwVzhHN1IzQjZ0TDRRYlFmWTZqK1BP?=
 =?utf-8?B?MjZTQkFVRVFUSm9QbURhdGlBeUhlTzdDWjNYaHZsbUVXMHk1b1N6Z20yYmlC?=
 =?utf-8?B?ajI4QWR3TVNvRUdUdDU2Zzg2TEJsVG9EbTF4VEg1ZjRTWUc5dTRScTljc3Mv?=
 =?utf-8?B?OEtZdnlSaEV3aDNzM0lISG1udVJ5SUdWdHNYN3pQY1JyUWs1Tm1GcVhPUm1S?=
 =?utf-8?B?Y3k0Sy9XQ1BrMXQ4dnpJSWtwdVJ6eDVXOHFVaElYcGxVN2NWQjh4VVNKSkNS?=
 =?utf-8?B?UGMyUmdYMk4rODBUVDk4dVFVM0JNWUpacDBUbll5UmNEQWIwTG1lNXhmVmlY?=
 =?utf-8?B?RDVlcXlKbjN6NnRrUzRhc0ZvQzc0WWZzM09yU2dWaFVYVmd6SmNQbC9yR24w?=
 =?utf-8?Q?6s0hem82HYqAQibHNmxFX1M=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309ce42e-9339-4b59-3025-08dadf1f9258
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 04:39:52.0141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYFGvmiZwuyPXtpJ3sT372if8lzDQLZMB1gDYoyW7DB94ExxbfLiamgkkJhfnwHG/rF+iIyd3roBWk06QnKMnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3181
X-Proofpoint-ORIG-GUID: z9yogPxBN_sUxK1XlGSZTR3gxrFUwELA
X-Proofpoint-GUID: z9yogPxBN_sUxK1XlGSZTR3gxrFUwELA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_02,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/15/22 10:34 PM, Yonghong Song wrote:
> 
> 
> On 12/13/22 10:27 AM, Dave Marchevsky wrote:
>> This patch adds a test exercising logic that was fixed / improved in
>> the previous patch in the series, as well as general sanity checking for
>> jit's PROBE_MEM logic which should've been unaffected by the previous
>> patch.
>>
>> The added verifier test does the following:
>>    * Acquire a referenced kptr to struct prog_test_ref_kfunc using
>>      existing net/bpf/test_run.c kfunc
>>      * Helper returns ptr to a specific prog_test_ref_kfunc whose first
>>        two fields - both ints - have been prepopulated w/ vals 42 and
>>        108, respectively
>>    * kptr_xchg the acquired ptr into an arraymap
>>    * Do a direct map_value load of the just-added ptr
>>      * Goal of all this setup is to get an unreferenced kptr pointing to
>>        struct with ints of known value, which is the result of this step
>>    * Using unreferenced kptr obtained in previous step, do loads of
>>      prog_test_ref_kfunc.a (offset 0) and .b (offset 4)
>>    * Then incr the kptr by 8 and load prog_test_ref_kfunc.a again (this
>>      time at offset -8)
>>    * Add all the loaded ints together and return
>>
>> Before the PROBE_MEM fixes in previous patch, the loads at offset 0 and
>> 4 would succeed, while the load at offset -8 would incorrectly fail
>> runtime check emitted by the JIT and 0 out dst reg as a result. This
>> confirmed by retval of 150 for this test before previous patch - since
>> second .a read is 0'd out - and a retval of 192 with the fixed logic.
>>
>> The test exercises the two optimizations to fixed logic added in last
>> patch as well:
>>    * BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0) exercises "insn->off is
>>      0, no need to add / sub from src_reg" optimization
>>    * BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, -8) exercises "src_reg ==
>>      dst_reg, no need to restore src_reg after load" optimization
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> 
> The test is quite complicated. Is it possible we could write a C code
> with every small portion of asm to test jit functionality. For
> b = p->a, the asm will simulate like below
>     p += offsetof(p_type, a)
>     b = *(u32 *)(p - offsetof(p_type, a))
> Could the above be a little bit simpler and easy to understand?
> I think you might be able to piggy back with some existing selftests.
> 

Good point. Will give it a try.

>> ---
>>   tools/testing/selftests/bpf/test_verifier.c | 75 ++++++++++++++----
>>   tools/testing/selftests/bpf/verifier/jit.c  | 84 +++++++++++++++++++++
>>   2 files changed, 146 insertions(+), 13 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
>> index 8c808551dfd7..14f8d0231e3c 100644
>> --- a/tools/testing/selftests/bpf/test_verifier.c
>> +++ b/tools/testing/selftests/bpf/test_verifier.c
>> @@ -55,7 +55,7 @@
>>   #define MAX_UNEXPECTED_INSNS    32
>>   #define MAX_TEST_INSNS    1000000
>>   #define MAX_FIXUPS    8
>> -#define MAX_NR_MAPS    23
>> +#define MAX_NR_MAPS    24
>>   #define MAX_TEST_RUNS    8
>>   #define POINTER_VALUE    0xcafe4all
>>   #define TEST_DATA_LEN    64
>> @@ -131,6 +131,7 @@ struct bpf_test {
>>       int fixup_map_ringbuf[MAX_FIXUPS];
>>       int fixup_map_timer[MAX_FIXUPS];
>>       int fixup_map_kptr[MAX_FIXUPS];
>> +    int fixup_map_probe_mem_read[MAX_FIXUPS];
>>       struct kfunc_btf_id_pair fixup_kfunc_btf_id[MAX_FIXUPS];
>>       /* Expected verifier log output for result REJECT or VERBOSE_ACCEPT.
>>        * Can be a tab-separated sequence of expected strings. An empty string
> [...]
