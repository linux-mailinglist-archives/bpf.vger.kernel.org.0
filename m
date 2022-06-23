Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA265557113
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 04:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbiFWCcC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 22:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiFWCcA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 22:32:00 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6710E427C3
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 19:31:57 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25N0wZrQ028476;
        Wed, 22 Jun 2022 19:31:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Wp8Elj9h+9zJO3MdKkbW+UM4MMxmkLXbKQJ7g76atFk=;
 b=SdmQT9K8xHDGm8Io6HNt9Kh929wk/60naE3uB1URH9Z8mt3roSrTqkzfNomLWLTyhFeT
 m54OHSxBC+s9S/7fhPYod0p0ixV3obpx13LaB5Mqx7YzHhdBQIXhHK6YcWVgW7UN+vWL
 of3FtVpPlpzyAZ/owGxrwIiWDAbln8aMsSA= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gukcgj0eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 19:31:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sm26caWZV3E8CRRysYOnI7AmnKkXqKcwL5OSQRxExRWHOz3eT4M7QPhs70uYYRa1xJ5/x6Tq6J9+XjMLm9eC67RwZ3/JSSEechP0MhiCHJh9BgFtMA4NCfrl5UjtPoF9FNNeubiktYBlVHC4TbIYMFbQjPGl1Xq6/BLiOEc69p0HYie2ZjDPIzEQ5puLexTvTOy93TB1XljtCtG4vgQIG80JmdMot8DkoJTa744tfW4sJAguPswrjgNaTbS/9SCUFwjSdGOWpwa/x4Md/F0LfeoVv+LY/Cs4D0lLKvIDZ8k8xyq3+lSUpkhJaaP9M8U6iAsfMfBUr4hfHR9yjn8SdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wp8Elj9h+9zJO3MdKkbW+UM4MMxmkLXbKQJ7g76atFk=;
 b=mghE4icnEZW07CHFM1VWauVU4pZxlGsFVxd5Pv1lAmsPaAxOOGvGq29onkVCDXuKUOg/WGqs9HAokdUVKhauE2WBijBe2tilupNBcO0n8s+W5unwobkOwKQY1Wmr/l34avuInNX4JKD8Sm6hs6c7d2rQEQTdlR6nnJZr8ppXaKq/dz7OgDXpjXOd379ajc03XgaudiocwG+CyPpTA2GcR7MgsIedaaWRx12+8Tt7MgFtcucbgYvuRgjTNlm7GfjHFuOJJnoY/F6R/IOS+TQW/G4PuV0+KU6mI3pp+lPzx/CJ4OQEkwNAqRCKfmp8rKraIBeQdEykSMClDhIIm/HCoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by MW4PR15MB4714.namprd15.prod.outlook.com (2603:10b6:303:10b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 23 Jun
 2022 02:31:40 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::2197:2f04:3527:d764]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::2197:2f04:3527:d764%8]) with mapi id 15.20.5373.015; Thu, 23 Jun 2022
 02:31:40 +0000
Message-ID: <6d8e08a5-7fd1-8b0d-4333-1287dd880c4e@fb.com>
Date:   Wed, 22 Jun 2022 22:31:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v6 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
Content-Language: en-US
To:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>
References: <20220620222554.270578-1-davemarchevsky@fb.com>
 <62b21962dc64_1627420844@john.notmuch>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <62b21962dc64_1627420844@john.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0396.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::11) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1e8a8dd-8869-4e41-85c5-08da54c0810b
X-MS-TrafficTypeDiagnostic: MW4PR15MB4714:EE_
X-Microsoft-Antispam-PRVS: <MW4PR15MB47147EA106E9219ECAA1206EA0B59@MW4PR15MB4714.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CqF4aXirKOjD5saRnUc3t4mCvLyfGrN84LJKVykoIeKw9a9og9lOAUu/SXPkfcXS6G+RZWETTaavA9ZylUHVys3GT/fBj0+pCgeNNAdg/BQELyWNbvcjNFGxMPo8NEJjo6Q1enNZ1u8f65vztTC95fE5jUJzIXpMtBmr7KTo8Th5+mapPqYMins417RYIxWthidRMgmvDIUPkgFKpSA0QPPOQVRPbq15NRFJa4HDQWqty2luHrNj3jw+PwRvIbwuKuhrCCnpzeGJrbmKYpR0litOzrb2nhZHxZVPolsq4dPMk6JNkdbetULV19p00yq6Wy7IkmUWK/FAAoyriZBJxQt3T6y4kpay8cbJk39iQI79+dOj/M5DYOof630pJ96uUXO8Hb5r3v3IaZuA4RNH+n9Eh5fl1ZpGNRaV67Ob/AqKTseZuFDnsMYRh5lG9rYKcXNbM7vXLI6KO05nWrOoULOvTEafGqelepauvsHdHUBXtZuv/w7osibHCC2vlsLUpZxYN8kOLMuvNhUQXV758TTAe5WsGNUtmT/M2+AdfWlXR3IvJ1N+jRmLsID9S+D/CRRcxKK9AOKwGaTNW0+oNnPDjdKDwQBvn/WXrfbIv6pCX91wjnBmZUSI6MHsVmM53l6mrQoDj24A2cHk4mhxwTd7VFyFSoYqTZsYTodg5EZtFv2FCZ/MCYUNHnwSRL9ZWTn9sdsJs/+UnrlgUOzx8ZuccdFkQsc8X0vrdT2vAjkW21aOEnkTOux2rDlf0WcUu9W2DI2qpTLhWajk/MrOkXi0c15/yAhc2DUvWeA5yvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(316002)(6506007)(6512007)(2906002)(53546011)(6666004)(41300700001)(6486002)(31686004)(36756003)(54906003)(478600001)(2616005)(4326008)(66476007)(66556008)(66946007)(8676002)(86362001)(31696002)(83380400001)(5660300002)(8936002)(38100700002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWNOckJBU3RnNFFPNXBwaXo1YTN4cDBTMnZSLzJCc0tMbk5QZnpiQTJ2dWIr?=
 =?utf-8?B?ZEdQUDVZSWhWSlhLQnFZcS9jSDFIbFNac1pHTHIvSHhBeE5lZWE3amVkVWNH?=
 =?utf-8?B?YlYvSk5wUEJ5ZC9FMjJvYXJQV1hqQ1lXdWdwaDFuWURjYnFYZkc2dWxTcmVm?=
 =?utf-8?B?WENhYkhIclRYeXFNb0MxS2U4MThORUxSaExUWEdwMjVpR3NRVlJUc2lUdDY3?=
 =?utf-8?B?aHBhZ1k4MmZCMkJqQytaeEFEdmZTVlY4aEp4SWR4dHBHclZCdkhGQ0doT3BV?=
 =?utf-8?B?Sy90MFF0QUYwdlpCeEFhd2haWEozWEt2ektFSlJ4L3dxN1ErN1BYa1BZQ2lM?=
 =?utf-8?B?U2VWN05KLzVqMUFFOW9zQ1ppZm5menhYNnZHMFc2OEJBbUpiSGxzT3ozeHlM?=
 =?utf-8?B?M3d6TXZ2RzdXU1FQbmppWUdLYkdCc2czV05aczd3blhlQ2VlWkovUkdBZ2lT?=
 =?utf-8?B?bm5qemw1aW1xNlNSdXUvNU9pTnM0SG1TdGZHU2tNNDIxem1TWlhKNkVWRHlD?=
 =?utf-8?B?R0tUWVlSZWozNXFaUGNBWnZPalVxYTU5Y3JyUW5aK0grTXdhUU9aTFgyWllz?=
 =?utf-8?B?amxHdU1GT2F2UWhxajNUOXJESDV2TjBjUkpDV3JvZmJtNzUzQmQ0Y3VqVVlG?=
 =?utf-8?B?YWJMWDltZnN0MlZEd3BGNU5aTG42MkNwbGFxZHZ5L2JsVklxdHNyMmJESjdp?=
 =?utf-8?B?c293WHkxQ1JuQUhYTzRGd2IwM1l5dThrOEZCczFpa0NOejZXS3hnWXJtT3BB?=
 =?utf-8?B?L2FoZTYxU1NZa1dtTDVVcVhkZTZBTUMxbDBvQUhPOUVTVFpRSEoxOC9QOXhp?=
 =?utf-8?B?WFV0bXJWSWhFNEhNelZGbi90QmZOZitpbDA2TVN2MmdkRWNVTzVrTU5KMlQv?=
 =?utf-8?B?aEJVQUp0SFlQWnh0cG1kMk5RblBHUkp0VkhJUTZuMmk3MjhuVkZvNmVKUEM3?=
 =?utf-8?B?TVM4WEFWNEJ6NWJ0QnkvTWE5K3FhdWJDN214VGJHQ01LVlh5aHpXN2VIR25z?=
 =?utf-8?B?cmlCaWxZUjBBb2duQ0dkYzNpNmxQdlN1ZDdnWVg3QkZNM08wVUJTVkQzckNJ?=
 =?utf-8?B?b0k5ZCtYQWpuMFZoTStURWpDM0tHQUtyZ3AvU0dIbUpXN3dPTHNuV0ZaMFBM?=
 =?utf-8?B?U1V4WGlMVVo5NlhRQzJtQmVHS3lBeTlJako1VW5PK1hvYTA4ZkFIdnhQM3dM?=
 =?utf-8?B?MTh3Zk5KTjltb3RvUFp5WkJkNVVUVEtLYm9oZDlYdnNpbVRVVTZmRnFIV0lP?=
 =?utf-8?B?SlJhc21vTDcrbko4TlAzSS9GdUM2MWdGVlpycUxWTjdzdHNXTW9aQnRwc1Vo?=
 =?utf-8?B?d1dBZEpjcXVzVkQ2eXZkbHdMMXFpbStsSDFPdkVyRUE1cHV4ekRsN1BkZ3Jp?=
 =?utf-8?B?RFVlMzlaZGJnR2dkRDBjWU5hSTVSYzNzaTF0bkdWaDFhajIyaHp5Q0I4dmll?=
 =?utf-8?B?MEt1ZjlaekpFUS94UG1DNENQamgrZ2tQa1p6Y2hOYWVyb0pZd3VjU1F3RERq?=
 =?utf-8?B?Wmp2OTFsMkpHTWZKakRwRStQZTd3U1A5VzlQNFl0c3dBbG1Wb3RJdWRycEY2?=
 =?utf-8?B?Zzloa3ZyaGRQdUZXZ0xEd0RtNTRsc2FRUWV3NkxtajllT1NObE1NeW1oVXQ2?=
 =?utf-8?B?eXJWcXl0L21XNFJ3WEJ3RlhSQ01Kd0tUaXNEN2xGUWpCd05DY1pGS2N6V2tn?=
 =?utf-8?B?YmpNYzBRazgvSFhJYTRZK0Rnb3QybkxIN2RSQ0h4eElxb29lZnltZlcycjEr?=
 =?utf-8?B?TTRjTTZ1cVN6cjZJUFZkL1RUK0ZlTmFpT1VGYzM0bVRyTnlLa09IY05WT2Uw?=
 =?utf-8?B?STVpRW9NY3BvV1pQcXgyc2FyeDRJU3JjcGZpcG43OTIyZ2o2cTV2dE5aclVq?=
 =?utf-8?B?K2JTa2V2MW9ydXRVTDY4QS9SUGhyWm1uaGpkY2ZDd2FqQUR6MDFETGcvTkgr?=
 =?utf-8?B?ditDTWpMTlNuZ0NFQnErYmJnT3lja2hSUnp2SXRFU2lZVVJhekp3Y2ZqVStK?=
 =?utf-8?B?eWdxUE10UkdVdGNlZG9xMEFVQWpTRXM0TzZaQ0x0ZTI3WFB1QXBkRERoM1BE?=
 =?utf-8?B?STJPa3BjUUY3VzJ1RTBDUVdjOVVSSkM2cFFCbXdaandPbzVwSUpGY2xCMy9j?=
 =?utf-8?B?ckdGR0tKcTZ5RnI1SFBFTFQ0Y3IwdlBhTngrYmwvbStabzVjeWZRVy9JQm1H?=
 =?utf-8?Q?JcheTXlYybWBCK8ALrV0WRk=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e8a8dd-8869-4e41-85c5-08da54c0810b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 02:31:40.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNLhy5A4MooZxNc+X2ZWL7w32+zFMt7mZcoMlhq3RNr6Bs2JG6arTw40ZnY/WKho/KC2eMmZsYu+3NKupvOP/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4714
X-Proofpoint-GUID: BPNDv5ccqqTijwJJIZ9apvZ9eUuV_tWw
X-Proofpoint-ORIG-GUID: BPNDv5ccqqTijwJJIZ9apvZ9eUuV_tWw
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

On 6/21/22 3:17 PM, John Fastabend wrote:   
> Dave Marchevsky wrote:
>> Add a benchmarks to demonstrate the performance cliff for local_storage
>> get as the number of local_storage maps increases beyond current
>> local_storage implementation's cache size.
>>
>> "sequential get" and "interleaved get" benchmarks are added, both of
>> which do many bpf_task_storage_get calls on sets of task local_storage
>> maps of various counts, while considering a single specific map to be
>> 'important' and counting task_storage_gets to the important map
>> separately in addition to normal 'hits' count of all gets. Goal here is
>> to mimic scenario where a particular program using one map - the
>> important one - is running on a system where many other local_storage
>> maps exist and are accessed often.
>>
>> While "sequential get" benchmark does bpf_task_storage_get for map 0, 1,
>> ..., {9, 99, 999} in order, "interleaved" benchmark interleaves 4
>> bpf_task_storage_gets for the important map for every 10 map gets. This
>> is meant to highlight performance differences when important map is
>> accessed far more frequently than non-important maps.
>>
>> A "hashmap control" benchmark is also included for easy comparison of
>> standard bpf hashmap lookup vs local_storage get. The benchmark is
>> similar to "sequential get", but creates and uses BPF_MAP_TYPE_HASH
>> instead of local storage. Only one inner map is created - a hashmap
>> meant to hold tid -> data mapping for all tasks. Size of the hashmap is
>> hardcoded to my system's PID_MAX_LIMIT (4,194,304). The number of these
>> keys which are actually fetched as part of the benchmark is
>> configurable.
>>
>> Addition of this benchmark is inspired by conversation with Alexei in a
>> previous patchset's thread [0], which highlighted the need for such a
>> benchmark to motivate and validate improvements to local_storage
>> implementation. My approach in that series focused on improving
>> performance for explicitly-marked 'important' maps and was rejected
>> with feedback to make more generally-applicable improvements while
>> avoiding explicitly marking maps as important. Thus the benchmark
>> reports both general and important-map-focused metrics, so effect of
>> future work on both is clear.
>>
>> Regarding the benchmark results. On a powerful system (Skylake, 20
>> cores, 256gb ram):
>>
>> Hashmap Control
>> ===============
>>         num keys: 10
>> hashmap (control) sequential    get:  hits throughput: 20.900 ± 0.334 M ops/s, hits latency: 47.847 ns/op, important_hits throughput: 20.900 ± 0.334 M ops/s
>>
>>         num keys: 1000
>> hashmap (control) sequential    get:  hits throughput: 13.758 ± 0.219 M ops/s, hits latency: 72.683 ns/op, important_hits throughput: 13.758 ± 0.219 M ops/s
>>
>>         num keys: 10000
>> hashmap (control) sequential    get:  hits throughput: 6.995 ± 0.034 M ops/s, hits latency: 142.959 ns/op, important_hits throughput: 6.995 ± 0.034 M ops/s
>>
>>         num keys: 100000
>> hashmap (control) sequential    get:  hits throughput: 4.452 ± 0.371 M ops/s, hits latency: 224.635 ns/op, important_hits throughput: 4.452 ± 0.371 M ops/s
>>
>>         num keys: 4194304
>> hashmap (control) sequential    get:  hits throughput: 3.043 ± 0.033 M ops/s, hits latency: 328.587 ns/op, important_hits throughput: 3.043 ± 0.033 M ops/s
>>
> 
> Why is the hashmap lookup not constant with the number of keys? It looks
> like its prepopulated without collisions so I wouldn't expect any
> extra ops on the lookup side after looking at the code quickly.
> 
> 
>> Local Storage
>> =============
>>         num_maps: 1
>> local_storage cache sequential  get:  hits throughput: 47.298 ± 0.180 M ops/s, hits latency: 21.142 ns/op, important_hits throughput: 47.298 ± 0.180 M ops/s
>> local_storage cache interleaved get:  hits throughput: 55.277 ± 0.888 M ops/s, hits latency: 18.091 ns/op, important_hits throughput: 55.277 ± 0.888 M ops/s
>>
>>         num_maps: 10
>> local_storage cache sequential  get:  hits throughput: 40.240 ± 0.802 M ops/s, hits latency: 24.851 ns/op, important_hits throughput: 4.024 ± 0.080 M ops/s
>> local_storage cache interleaved get:  hits throughput: 48.701 ± 0.722 M ops/s, hits latency: 20.533 ns/op, important_hits throughput: 17.393 ± 0.258 M ops/s
>>
>>         num_maps: 16
>> local_storage cache sequential  get:  hits throughput: 44.515 ± 0.708 M ops/s, hits latency: 22.464 ns/op, important_hits throughput: 2.782 ± 0.044 M ops/s
>> local_storage cache interleaved get:  hits throughput: 49.553 ± 2.260 M ops/s, hits latency: 20.181 ns/op, important_hits throughput: 15.767 ± 0.719 M ops/s
>>
>>         num_maps: 17
>> local_storage cache sequential  get:  hits throughput: 38.778 ± 0.302 M ops/s, hits latency: 25.788 ns/op, important_hits throughput: 2.284 ± 0.018 M ops/s
>> local_storage cache interleaved get:  hits throughput: 43.848 ± 1.023 M ops/s, hits latency: 22.806 ns/op, important_hits throughput: 13.349 ± 0.311 M ops/s
>>
>>         num_maps: 24
>> local_storage cache sequential  get:  hits throughput: 19.317 ± 0.568 M ops/s, hits latency: 51.769 ns/op, important_hits throughput: 0.806 ± 0.024 M ops/s
>> local_storage cache interleaved get:  hits throughput: 24.397 ± 0.272 M ops/s, hits latency: 40.989 ns/op, important_hits throughput: 6.863 ± 0.077 M ops/s
>>
>>         num_maps: 32
>> local_storage cache sequential  get:  hits throughput: 13.333 ± 0.135 M ops/s, hits latency: 75.000 ns/op, important_hits throughput: 0.417 ± 0.004 M ops/s
>> local_storage cache interleaved get:  hits throughput: 16.898 ± 0.383 M ops/s, hits latency: 59.178 ns/op, important_hits throughput: 4.717 ± 0.107 M ops/s
>>
>>         num_maps: 100
>> local_storage cache sequential  get:  hits throughput: 6.360 ± 0.107 M ops/s, hits latency: 157.233 ns/op, important_hits throughput: 0.064 ± 0.001 M ops/s
>> local_storage cache interleaved get:  hits throughput: 7.303 ± 0.362 M ops/s, hits latency: 136.930 ns/op, important_hits throughput: 1.907 ± 0.094 M ops/s
>>
>>         num_maps: 1000
>> local_storage cache sequential  get:  hits throughput: 0.452 ± 0.010 M ops/s, hits latency: 2214.022 ns/op, important_hits throughput: 0.000 ± 0.000 M ops/s
>> local_storage cache interleaved get:  hits throughput: 0.542 ± 0.007 M ops/s, hits latency: 1843.341 ns/op, important_hits throughput: 0.136 ± 0.002 M ops/s
>>
>> Looking at the "sequential get" results, it's clear that as the
>> number of task local_storage maps grows beyond the current cache size
>> (16), there's a significant reduction in hits throughput. Note that
>> current local_storage implementation assigns a cache_idx to maps as they
>> are created. Since "sequential get" is creating maps 0..n in order and
>> then doing bpf_task_storage_get calls in the same order, the benchmark
>> is effectively ensuring that a map will not be in cache when the program
>> tries to access it.
>>
>> For "interleaved get" results, important-map hits throughput is greatly
>> increased as the important map is more likely to be in cache by virtue
>> of being accessed far more frequently. Throughput still reduces as #
>> maps increases, though.
>>
>> To get a sense of the overhead of the benchmark program, I
>> commented out bpf_task_storage_get/bpf_map_lookup_elem in
>> local_storage_bench.c and ran the benchmark on the same host as the
>> 'real' run. Results:
> 
> Also just checking the hash overhead was taken including the
> urandom so we can pull that out of the cost.
> 
> [...]
> 

Yep, confirmed.
