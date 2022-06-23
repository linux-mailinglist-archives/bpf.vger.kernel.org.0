Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40064557137
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 04:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiFWCzs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 22:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiFWCxx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 22:53:53 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B8343488
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 19:53:52 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25N0wWMR017423;
        Wed, 22 Jun 2022 19:53:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5OO/P01dwVG5KqSR66odbD/YrgGUEdNPCKm4ZBP7Nw8=;
 b=BwjfrCN44hocq3ehKIq4JWdeHQCRAB3nLuVlmae3+EdqYUTlmil1coSsrc07oh3XSWk6
 KBX2Owzx7ftpCsgO2et9EroGY8APbhRhWFbd0oXpPt5v/StyM9eEz6fK1PnOB10HkiEI
 zvqi0igKRJepltPFXu03JwraqVIuz9Ahs5g= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3guef4vjde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 19:53:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5FhU6CHlwWFYyUAqlX6a9tT2gjNszFvA1w7s430AphKLOPglgC3hjQ71vd9wg6dvtKtJCgtgJoOblCFR/V/DBsLoAxDedqMWF/JGWCK0vETbFrWCl+JtWxS0PYdKq5IyH6EDhJaTstbB0n4K2T756sjTeYm5taUhkZp5ez2ImMX9bzx97DZH8iXJvO3mJ6ROJmFLPo/KK2GR6Hk7RQ0R6KRuJeVH2/b7Kkxd/VYTGeJXec2Vp9WDSG12V2w2Al+eQFlEzdBrsD1gYf7Mi8PwIaXdUMY7G8QJFSj/A4eUQEKwgl767oUGOwDKopceCZfGQNRk9JXBl08oSt7LQIkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OO/P01dwVG5KqSR66odbD/YrgGUEdNPCKm4ZBP7Nw8=;
 b=B4Icx8xueKBwveZpELuiczKk6uxIiNss7UTKYOcmKgoVunKRxwbPJHZB3HBfgapIAPFxbj/GTUecseqomQGtZ7cqsqebUr6B+wSqMTYwoM0J8+j4Yfb6Vd6CivuCQA3IwtB7PQdi8dN7Ez6XqKmsfvblSumsctmm7qVd1uIJSXtNKD11oj2E5BDxjhjhUt0FkwQBz9XlL8F4/G2279jwDD80EFX8sy7ZcwlnXv3/1NjmHCUvFjOK7tsuutaopDRRo1IiecGoJe4wMO783qq8CXyFz2/d2Ty8QpjRf/c6SVwqVhWN5gQ29mQjh031fpki0sbO/PNjh9U5MwuK/kJt3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BN7PR15MB2225.namprd15.prod.outlook.com (2603:10b6:406:81::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 02:53:32 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::2197:2f04:3527:d764]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::2197:2f04:3527:d764%8]) with mapi id 15.20.5373.015; Thu, 23 Jun 2022
 02:53:32 +0000
Message-ID: <31bba044-6bb0-1a78-d706-f9fd9fbb1e2c@fb.com>
Date:   Wed, 22 Jun 2022 22:53:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v6 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
Content-Language: en-US
To:     John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20220620222554.270578-1-davemarchevsky@fb.com>
 <62b21962dc64_1627420844@john.notmuch>
 <20220622002952.6334ieb3kfysx7vl@kafai-mbp>
 <62b2ad7a21e88_34dc820812@john.notmuch>
 <20220622172632.psejkta24nwz3k5m@kafai-mbp.dhcp.thefacebook.com>
 <62b3c156ad70a_6a3b2208d7@john.notmuch>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <62b3c156ad70a_6a3b2208d7@john.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:208:32a::20) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb2d0be0-be59-4ab5-3e93-08da54c38f3c
X-MS-TrafficTypeDiagnostic: BN7PR15MB2225:EE_
X-Microsoft-Antispam-PRVS: <BN7PR15MB2225A8392AFCA92A7C388C9EA0B59@BN7PR15MB2225.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3ZAc7kYf9JXsOHFkPP+uNvs04EMPi/4uy71WWwwXUiD5ZhQP0M8fR8aDP+MWAxDDhrOqfE3M32BTGhoJm3Ql53qRIWFTtU5IgXhNEQL4NUfJ2bdH4oGJQcC+j0GTEvJdcE/djajoKMDbs+quXKISz3a+RIzIuk75c1sdu/ngkz/JQcWiSEi3NJBn1F8du3thSWsjn0EOWM/qtVcxprxyS1W/KG8815H3OabtGKzx5dwuXXlltmY7zXPMljQDQU2+4FwF8JIUHw/Dq3TAT4HDXlHjHkspPfFdhqt7SFPTdtMHh8kQZtj2v9F54xMG56bvgLK3FnCaPJisGG4sLO2Ff0bHMR4gbtWCzKnLPOsmTU2jiM445DKSgE8VLNOmyMFaZRodgL1kEY6faU+U/O6Xxvhs8fadeZtDHOPju99BMFSmBFRtUHyrdou6Vycm8m3yO386tueJr8bthevKP+bW5X+Kx58Ponk46+2K28bMHdOHReSBbUoXKNB/fgRYREF0oYUOyxS7N3PwXaNArkA0v0hLhiJSEy+RrpMly03QoSdC8dE6Nl/T2jkdsS6VrWLONeJDQqs48alE9mRlDPCkgptn3AWXcocDQDB+ERZqwr2qzgmGbHzSva/nkaSVH7Aatp0mnP+5k3P6PtLdj3fRRkxSvnzBM030cDNFvjo2cKbFxsfLpPDm92LM07G2M4VjmPTmMXJOiTriyhapo4uoZTqSxJpIqUyfLiHV57tzWXH05+KWuovx0lG/HvPh4tPppNeVZ4lqdv1bxX7N7UksMKrzT9ZXbkGRtIR1wdi0Ug=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(41300700001)(66556008)(66946007)(4326008)(8676002)(66476007)(31696002)(2906002)(316002)(6666004)(110136005)(6636002)(54906003)(36756003)(38100700002)(31686004)(5660300002)(186003)(53546011)(6506007)(6486002)(8936002)(478600001)(2616005)(86362001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXFGakc1M0pDRDFGelFzMldNQUowUWNGMktnNXFmOUkxY1RDREZPTGdUNHlT?=
 =?utf-8?B?RUljdDRTT3BvUVJub3BPZHFjZ2M2bmI5T2paamFReHlKRDJBMWZvU2grRk5q?=
 =?utf-8?B?cDdSZi83TFBBUHZqSTRTUXFLU3VXZGFiYVB1QUo4TktCcCtNWlFWUk96cnJm?=
 =?utf-8?B?NUthTHQvTWJjMitWTzhTODBlcUQzVlArcm15eHFGR0NROTdmVGhISUhWcHM2?=
 =?utf-8?B?RWg4VjVnSHdHNXV6NjdDWWwvTmFzc2drL1pJeVZjOUFDUklZNjcyNnlzZGVl?=
 =?utf-8?B?em5jNEQ3SVdHUG9EZENxcndPOEYyc2dRRUhBYzNlcm5sRXpidGRrNHpiOVh4?=
 =?utf-8?B?YXA1Nmt1blZZT2lTWU13SC9aMFloRUc4YWViLzFNUUh0Qm5aakpwd2pET0Uw?=
 =?utf-8?B?TkdpdDF6a0w0YkNJVlpXS29xMXhyZUQ2dnBJNnNWcFRCWVVVcHlzUGI4MnNp?=
 =?utf-8?B?SWtoUXAyQlhKOENuelA4LzVQWEFENzhTKy94SDI3ZmovbDZ2by9wK3J2Y3hk?=
 =?utf-8?B?RFVENnRlZmNma2NMS1UyeERSWHI4NUR6ZEpwZ2hnUFQ5ZlZERVFRMkFwWDlI?=
 =?utf-8?B?d2JjWkIzTmtkSVZYUFhWaHFUb09ldkNVOUlDcTFwbTJVem9Qd1dlRmFIMHR3?=
 =?utf-8?B?dnVjL2hnNWovTlVzRTFHS2ZiOTF6Q1MxSVQzajZqVlZJdVhURnBtdXFLSm1N?=
 =?utf-8?B?Y0JCdHJ5Tnh6eFpDazNMY2FyM3pDb01qcklZcDBwNzRTelF5R1RwMVFkOWQx?=
 =?utf-8?B?ZG5qWkFPeHJ4RTh0N2tYN29QQTZuVHhXa0NqQUVHcG9aSnJzRWV3bjl4MlBu?=
 =?utf-8?B?L0ErWTFvUERkbjRrT3cyc0FjQUtGMGROb1ljV2JOS0hhcHkrMWlpdFU5cWt6?=
 =?utf-8?B?OC92cWtXaWw0cFl3cDJvTWxmc3RRNjE3RTZVYmlnK0UvU0J0NzAzSkNkaW1t?=
 =?utf-8?B?RHFCdmdBVmlITVAwMng4ektrTnlNYmVCdzJXdGlvSC96aC9aSk9TMzR2NDgx?=
 =?utf-8?B?TE1RdlhSTnhSdFZOcnNVejkra0tScGREbjIwY21JZzlOaXhOZmd4K3kyQ3hj?=
 =?utf-8?B?R1JLQ2wrNFRRV2tLR3ZZZU9VSjBTaHBubktsMmhlUThnSlFudVE2OWdQWnVN?=
 =?utf-8?B?Zi8wS3Q2T3Q1L3lPZFhEM1YwNlBkMndqdlV0QWpvVlY0cy9sd3R0dVVEVzlF?=
 =?utf-8?B?Zzg5YVJDdjR1cGIxYVkzSlZ0bTFMNjFiYzgzb2lTZ1JFbGFDV0JIdkJVZmJq?=
 =?utf-8?B?dCtmY2pCTllTRkU2anFtZ3JMbmthVFRTemVEVHpFVWlVNDF4c0k1VERUT1hP?=
 =?utf-8?B?NnRnV0szZDRFVXNFNzVmcTRjbElvenV4Z2k5WkNPNWZtMFlXOXpSbUU3VmJn?=
 =?utf-8?B?WG1ha1c5SGZzL3RUUTFmdEw3bnN5T203eG44WGM0cFFaYzI4RzNxbytkV2hp?=
 =?utf-8?B?L2szQVFyU2xqM01GbmtSLzA0dUw4dVhrbjVxRWdSazhWTHB3eWFKOWFHQ2xK?=
 =?utf-8?B?V2FaaEZzVGN5NFlvT3hiUEhkZERJK0w3UmpZSWpIbTgxbk9FaDdWUW1Sc1Jz?=
 =?utf-8?B?L093ejdVRTYvbDhCZFBtWWFjNW9OVG15SGZ0UEVEMUpVZDVwa0xtenZNWnFz?=
 =?utf-8?B?M1pubE01N3pyVjlpa0k1ZzhOc2hLdy9sd29CTFM4eGk2QTZzeHl3eXFWdG82?=
 =?utf-8?B?TWNnZ0VsL0VmK3NWdE1YRElrTVF4RjZNTG5hTkZBOHRwcjBkMHFOdzVEZ2pB?=
 =?utf-8?B?QnUvTGszbHhoQzJqTTZTSHBEUmxheDVWeHRCUERSdmhVYmJDNkF1cVBRNlZv?=
 =?utf-8?B?emFYUzNlOHB1MTNkdllFb1VtUnRneURmQ2xQYlc3anpLQWVhaXhZVDNSR2hr?=
 =?utf-8?B?TTR3NFg4Z25KYWZnTUFhbFpjcXphM1dWTkNyRGJlTGNZSllvMmFESkdYQVZG?=
 =?utf-8?B?bERBazEvaGsvMjZFQlBmd0FtZk9XT1IvMGcvNGxtWVBxelNIV21Fd09UZDFY?=
 =?utf-8?B?bThPKzREb3FSbzJCR2R2QkcyaUo2aDJLakQydG9GL0ZweXRacCt4RlZHWFNt?=
 =?utf-8?B?ZEZCaU1PSTFtbVNjTDV2ZDZOWnNwSDgzTjhnT01XSmY1MHpJb3I2dVFERHJW?=
 =?utf-8?B?Vkt0ajJCQk85dy9YTXZGblF2NnNtTXNVRWY0d0ZMR2F2alBqTGxBLzcxVURj?=
 =?utf-8?Q?HWrv/S2hbkE2C99bGO4kjU4=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2d0be0-be59-4ab5-3e93-08da54c38f3c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 02:53:32.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKE6fQmiT4XZ7hKBlJATy+OtVBfUaBrVhnVCHZO7UVMB+OQGDj7htURRsL7nlIJbwRVJkfFRzRGnk3uJNNNONQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2225
X-Proofpoint-GUID: 1NtD1JiiakNi2Gq75Es9f3Supd-2pv3I
X-Proofpoint-ORIG-GUID: 1NtD1JiiakNi2Gq75Es9f3Supd-2pv3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_10,2022-06-22_03,2022-06-22_01
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

On 6/22/22 9:26 PM, John Fastabend wrote:   
> Martin KaFai Lau wrote:
>> On Tue, Jun 21, 2022 at 10:49:46PM -0700, John Fastabend wrote:
>>> Martin KaFai Lau wrote:
>>>> On Tue, Jun 21, 2022 at 12:17:54PM -0700, John Fastabend wrote:
>>>>>> Hashmap Control
>>>>>> ===============
>>>>>>         num keys: 10
>>>>>> hashmap (control) sequential    get:  hits throughput: 20.900 ± 0.334 M ops/s, hits latency: 47.847 ns/op, important_hits throughput: 20.900 ± 0.334 M ops/s
>>>>>>
>>>>>>         num keys: 1000
>>>>>> hashmap (control) sequential    get:  hits throughput: 13.758 ± 0.219 M ops/s, hits latency: 72.683 ns/op, important_hits throughput: 13.758 ± 0.219 M ops/s
>>>>>>
>>>>>>         num keys: 10000
>>>>>> hashmap (control) sequential    get:  hits throughput: 6.995 ± 0.034 M ops/s, hits latency: 142.959 ns/op, important_hits throughput: 6.995 ± 0.034 M ops/s
>>>>>>
>>>>>>         num keys: 100000
>>>>>> hashmap (control) sequential    get:  hits throughput: 4.452 ± 0.371 M ops/s, hits latency: 224.635 ns/op, important_hits throughput: 4.452 ± 0.371 M ops/s
>>>>>>
>>>>>>         num keys: 4194304
>>>>>> hashmap (control) sequential    get:  hits throughput: 3.043 ± 0.033 M ops/s, hits latency: 328.587 ns/op, important_hits throughput: 3.043 ± 0.033 M ops/s
>>>>>>
>>>>>
>>>>> Why is the hashmap lookup not constant with the number of keys? It looks
>>>>> like its prepopulated without collisions so I wouldn't expect any
>>>>> extra ops on the lookup side after looking at the code quickly.
>>>> It may be due to the cpu-cache misses as the map grows.
>>>
>>> Maybe but, values are just ints so even 1k * 4B = 4kB should be
>>> inside an otherwise unused server class system. Would be more
>>> believable (to me at least) if the drop off happened at 100k or
>>> more.
>> It is not only value (and key) size.  There is overhead.
>> htab_elem alone is 48bytes.  key and value need to 8bytes align also.
>>
> 
> Right late night math didn't add up. Now I'm wondering if we can make
> hashmap behave much better, that drop off is looking really ugly.
> 
>> From a random machine:
>> lscpu -C
>> NAME ONE-SIZE ALL-SIZE WAYS TYPE        LEVEL  SETS PHY-LINE COHERENCY-SIZE
>> L1d       32K     576K    8 Data            1    64        1             64
>> L1i       32K     576K    8 Instruction     1    64        1             64
>> L2         1M      18M   16 Unified         2  1024        1             64
>> L3      24.8M    24.8M   11 Unified         3 36864        1             64
> 
> Could you do a couple more data point then, num keys=100,200,400? I would
> expect those to fit in the cache and be same as 10 by the cache theory. I
> could try as well but looking like Friday before I have a spare moment.
> 
> Thanks,
> John

Here's a benchmark run with those num_keys.

Hashmap Control
===============
        num keys: 10
hashmap (control) sequential    get:  hits throughput: 23.072 ± 0.208 M ops/s, hits latency: 43.343 ns/op, important_hits throughput: 23.072 ± 0.208 M ops/s

        num keys: 100
hashmap (control) sequential    get:  hits throughput: 17.967 ± 0.236 M ops/s, hits latency: 55.659 ns/op, important_hits throughput: 17.967 ± 0.236 M ops/s

        num keys: 200
hashmap (control) sequential    get:  hits throughput: 17.812 ± 0.428 M ops/s, hits latency: 56.143 ns/op, important_hits throughput: 17.812 ± 0.428 M ops/s

        num keys: 300
hashmap (control) sequential    get:  hits throughput: 17.070 ± 0.293 M ops/s, hits latency: 58.582 ns/op, important_hits throughput: 17.070 ± 0.293 M ops/s

        num keys: 400
hashmap (control) sequential    get:  hits throughput: 17.667 ± 0.316 M ops/s, hits latency: 56.604 ns/op, important_hits throughput: 17.667 ± 0.316 M ops/s

        num keys: 500
hashmap (control) sequential    get:  hits throughput: 17.010 ± 0.409 M ops/s, hits latency: 58.789 ns/op, important_hits throughput: 17.010 ± 0.409 M ops/s

        num keys: 1000
hashmap (control) sequential    get:  hits throughput: 14.330 ± 0.172 M ops/s, hits latency: 69.784 ns/op, important_hits throughput: 14.330 ± 0.172 M ops/s

        num keys: 10000
hashmap (control) sequential    get:  hits throughput: 6.047 ± 0.024 M ops/s, hits latency: 165.380 ns/op, important_hits throughput: 6.047 ± 0.024 M ops/s

        num keys: 100000
hashmap (control) sequential    get:  hits throughput: 4.472 ± 0.163 M ops/s, hits latency: 223.630 ns/op, important_hits throughput: 4.472 ± 0.163 M ops/s

        num keys: 4194304
hashmap (control) sequential    get:  hits throughput: 2.785 ± 0.024 M ops/s, hits latency: 359.066 ns/op, important_hits throughput: 2.785 ± 0.024 M ops/s
