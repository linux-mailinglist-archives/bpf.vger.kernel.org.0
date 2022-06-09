Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BC7544EFC
	for <lists+bpf@lfdr.de>; Thu,  9 Jun 2022 16:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbiFIO1q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jun 2022 10:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiFIO1p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 10:27:45 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A87E12B013
        for <bpf@vger.kernel.org>; Thu,  9 Jun 2022 07:27:43 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 258NnntZ004642;
        Thu, 9 Jun 2022 07:27:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xYVvSVPUaS6cbmij86JSUbGxvupvD2PVuhfWEzSBTeY=;
 b=EdKtUfu5wXjL8m9lRmfxAxVbI5vEPGDiypBwVJLZ7tEApSAaL+yFk88lDz2s5K84kLvH
 fg6AZxikZ+Zyrw4lmIZWLBSLjlxoE7R88HDHlseUxi14dP2LdNaIuLU5F1ZbYLKikvMd
 ge1KIkY6Fmdmjs87qWGDvvNA9kfrxpnjlrQ= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gjr0jgrus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 07:27:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyyjlVf++LJ+5+J04KkGKUWhmXzdTFWj9pkk8UkzeDwq487y3I6e6Q+mIemGmeW8XgbKduu8an4ao3Kjkixxr0YJ+QA7icc1WHnheNNYH29biuwTOArwpahhIIzlwXWy13YP0TK+c23CMfRd/ukf1KaG8d69fGVr7RpdOLrl4QI4fOOt1dFRsFHx6/jIp46wDZTlzlU1vJWjHVj1q1kPvpGn9pYEgF1pT4lOCPERxfnWpfJb2gyjPrxPBXeIS9Q/qBfreS+o9rKCO7vB5Fdlo99oFxPEV0NU/gULpeZJirO7dYW4GbYcoGpk+ft+1KzKv+0SvcgAWxFP82vhjiWOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYVvSVPUaS6cbmij86JSUbGxvupvD2PVuhfWEzSBTeY=;
 b=J5i32YDLKIOM6n/xAWY2cN4gAnwMpKFg9Oq3yfpVUaiU6LNin48xjAT1ibK5UoF0TLkR0dX4XQUZufw2rT6jY2FNhW9ajjVDGvO1xnUeG2BewbR72LfmN4sv93RhqFQd/pv+HriuadvnWlgWB54ADIySnJQGxB06PkO0KufwmR8NKWzSesbDWLFrvgpBmE3UowsHwjkEI62tJCmxnEqeK/Igr2raXlatZOv+qE5zJ2/bli6FM7k6mZociod9RAl4cin3t9pqsuQ9nCISazZc2ofS5Fo8Gk1ROzY8LsJI5ztVM7GMrV9n/km7oCg7FkD7IvmGJ8g9ezSFoJRDpC+txg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BN6PR15MB1570.namprd15.prod.outlook.com (2603:10b6:404:c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 14:27:26 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb%9]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 14:27:26 +0000
Message-ID: <79b4e95c-437d-45c5-c7a8-c077f692c18a@fb.com>
Date:   Thu, 9 Jun 2022 10:27:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v5 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
Content-Language: en-US
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20220604222006.3006708-1-davemarchevsky@fb.com>
 <20220608230226.jywist5cdgu3ntss@kafai-mbp>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220608230226.jywist5cdgu3ntss@kafai-mbp>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MN2PR18CA0014.namprd18.prod.outlook.com
 (2603:10b6:208:23c::19) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3304d16-84b4-401d-a492-08da4a242cd0
X-MS-TrafficTypeDiagnostic: BN6PR15MB1570:EE_
X-Microsoft-Antispam-PRVS: <BN6PR15MB1570C0530664CCFF8FAE2675A0A79@BN6PR15MB1570.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpZQRwhtd/HKcLLtSxY/OMTTswcCux6w2pzjhiiLsbLWehmgDkW9ikUeCswN318U/z/wqRh6aaXG4MMsozLR+QWygZAAInhbyLYYGpjqaK9SRt51vLC+/4CS6Q/UtNNCpmLmXn7yYBPBH5Cu+HIi5Ju62CfYsQzpPRr+rmSx2noMmUWygHnLLlzZTk8CsyZx5X4sCNdd5MS0Pcmg+y6qFcrobt8CnUtsE5C+fS6dztEx99B9i+4VpuBZ134SbHbpFsY0ETIXvM54ZrHiO7fw1ZRIxP6mUxjlgsq2i7LuRnapQud2yErbiiNqpghWMpYQsSWKqDvfezoWwgA5vkW4EVxF//xfYFXRA4rNxvG4LINnxbWUSFDsPRo88d9GtVELzMbfFsJNeeaXUoRgx98cEmgDXUzDtDGwtj5OrdtbAw4j/UwZCcmL86kUX/H5QiR/IqlM6IJsHnbj/GmATiMqC2D3NgFfQ22chXpqD5DXAwERsaHgl8xEJ5Mi/IXSBi5zRggmWFl4kqWI7TtCUfAopVsY13PHhEjWTV8tKscIRdcM6Kdh3c3LQqEdsJKPo7eQF3G+b7hNjTQDCUgd8HlB/uuKJQW2L8vI6dcKaHdTu2WrsvHq5py4umoTirpNZpbddgllgT6LbUa8IP7xGr+61E4u3wm74gSTsqQIArKsjvSUfDpAvLMG27RRUgz+5df6OYrBtgZNWl65expQX6Q6Z7U3MvlJyWA9C3MiVVe6GuVtadqsToGRYxP4j6IG9xeCdawMGJzgQVAPg9qN9aKl2mh3kWrtAOafmHD64zKg3ugKkdfnIKKhxJvzrgYj7kAOStkrENoVM6SZD/Cf5fUQSssbU+ehyQ93DZvIc4Ne624=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6666004)(6636002)(6862004)(54906003)(37006003)(38100700002)(508600001)(8936002)(6486002)(30864003)(36756003)(4326008)(966005)(66556008)(6506007)(316002)(8676002)(66946007)(186003)(86362001)(31696002)(66476007)(83380400001)(6512007)(31686004)(2906002)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2wyRGRoNjE0c0dHYVREek0vQzlvbUZyMHVaenFjQ1hhdkh6QUVnVVNZbU9C?=
 =?utf-8?B?UGh4RnN4UnNncEZqNC9PSlczU0U0VkVLWjJkNEVWMDJEREVNVTY0Y0xrUkJC?=
 =?utf-8?B?ejZRRjNOelVyVHJtRDdkSjZlbWp0ZmZXaHpnUHppWFFydjh6UVpHbS9Rc3F2?=
 =?utf-8?B?RHlybnBNdTZzTXFYV1NhSkN0WFBHSW5BK1Ztb2N4YXpYUHJ0UXJlTTd5TEFq?=
 =?utf-8?B?WitYV3NzMnFITXpHL2w1aGVqeWFPcjh3YVpHOVNUQ1RXS0xvTWpXWGNuZ2p4?=
 =?utf-8?B?R1kxVWw4eVR1bW5BN0kvT0tGRzd0cVFCd01jUHAvUlhOR1VhQllqc3hUdk01?=
 =?utf-8?B?bmxHVjBrNDR0NVM2MDZDcUlxYnpBZUM0UUdmbTlhaFYwZHh4RlVGcEd0M3NB?=
 =?utf-8?B?Y0lnMlpPNEJzaTBYL0tkVklxYmdFK2lKWXlvR1duUURFUjc2eWI5VURnd2F6?=
 =?utf-8?B?QjNERzduUVQ4dWhLb0duN0Vta3FkaFFubkthRjc0Z1JrYU9Hc2xFaWtleWYr?=
 =?utf-8?B?QW5iSkdmcUlpRktWa3FLVFBaN2xJRC9LbWNtRUVneFluRG5jMWZQMnp5MlFt?=
 =?utf-8?B?bDUvY0ZaT2RzcDJLT3ZkcWR3S2twd0J6aVo2NWZhay8wdFQwN0ZBV1dUQ0Nl?=
 =?utf-8?B?UVNRcUpJSVlDWEVjNzc5dFZqZGZoVW1zUHpIZ0lGMTYyQjVJek5NUjZoWmJC?=
 =?utf-8?B?NWtnN3dCTTkwVDVDNzErZnlEZUV1S3UwUVc0RERsNE0zZ0c2VkhQSytaUDRE?=
 =?utf-8?B?RDRzcTBUQktHR2dSQXpHblpMZFM3Q1pNQmlITzY3UWdQL2dpeGtZU3lscGZ6?=
 =?utf-8?B?Rmg0OEpqMXMyalQ0c3Z0THp2N0hZQjVIQ3BtUkhCR3VvV1hsekIzWkd6aEUx?=
 =?utf-8?B?MHBvQlZzMkFEdFdocE9jcHdCbnhkYkZybWYvS3J1VGtBYW8xQlRJVGRvWW8z?=
 =?utf-8?B?bXd0QXlSbkFkODBYUTBjaFcrUmRUY1pCcDJkYTV0OFF4cUNKTWRsMzNia1g2?=
 =?utf-8?B?aDZJRDVxUnUxOW93WGIzZWxaK0FiWTM4ekdPMmZLdUc1NE4vNlp3cUxud2cw?=
 =?utf-8?B?ck1pbVdNL2d2by9mc0hCMytJQjlYOHQ1d1Bnckw0MFQrbFdUaXVCZ0xWeE5k?=
 =?utf-8?B?S05LMGtsOFJKQnA5ZmlTM21JaEQ1eUc1N3VZUzY4Wi9QKzVpUEVTV0NIdk5m?=
 =?utf-8?B?SVhocWsvdnh6QjZUTGM5NUduM3VzV0RWbnVOWWJHWHUyaXhUN0RtZzdTMUNV?=
 =?utf-8?B?NUZYSFhQY3dZdWVDQkNSclIrMW5URmRueVUvdjRvRVhselZIb1pmMyswV0Qr?=
 =?utf-8?B?ZEpRYVJDN29iRCt5dVdIZnZLaW1CSlpQdkVaZzA0cWZVWDlGdVBVck1VMkY5?=
 =?utf-8?B?bXM1ZnBCODk2UGNlME84UjQ4dUJGd0F6SjN4SzY3ZEZxSThVUHJ1anJHSXBW?=
 =?utf-8?B?MXZTd0UzVkR0SWJlM3U1SWpTVjRCZnVPbWNQRUk5aFh5QW1oNnJmRGl4VHhn?=
 =?utf-8?B?SlNBNG1ncEtydEc4VHN2U0REOGRyRG9FRzc5QkxUMDlYKzY0cjRiR25QV3ZR?=
 =?utf-8?B?UnFWejlYSVNMTVhHK2NGV0Z3dEJac2o4cWhFKzhYMnVVd2wyUkpjcnhlNkZI?=
 =?utf-8?B?N3gxSG9uNWNRZFByTEF1dmh5cTR1S2VDd25YQjFNQmRTRXFTempwdWo0MDNC?=
 =?utf-8?B?SXM0dm5uaDczdEEycnlBU05sRnE0dEFLMnNaZU5xSVpqRW5wMmYzc2UzVWVy?=
 =?utf-8?B?RXl0QUlKM0ZKeUppWnNZT1E4eVo0SDBOYXlMc25ncERnQ01rTVhUZXZySzcw?=
 =?utf-8?B?Y0pGblVyUkMrZU0xeFJLaWdNdVEvczBLdXJHZm9wRjNLTDNrZGRMUzJ2NEJ4?=
 =?utf-8?B?ak56a21kWTVxeml0RytVeHJ3NER3Y3VoL1FFaEtYNDl3Y0NNaDlRU0RPd0lD?=
 =?utf-8?B?YUE5ZnY5YUJ4WjhybFp3MllnbnRyRXhkZ3JwaTE5WmVtK2pIQU1OTmJJeDVP?=
 =?utf-8?B?THRDU2VzenJOTGFEZUlEMWlGS0w2c0RSS1Q1YXdTcVY0UElaV0dFNUlxQXRn?=
 =?utf-8?B?dE0zNiswM0xUYm5uOXhwcC9peEdkMmNSSjE2Q2RwUkN4Ty82SVZqRXpKMDRu?=
 =?utf-8?B?RUlQaEJDVUZ2Z29yQWZVZkxFRnlCdTlOUzZtRzE0Tm5pZFRhZ1Q4eEpOL1Vp?=
 =?utf-8?B?OU01RkZpZWhIaHY5QlJlbGY3U1JNZUhMeTZQMUVMczJjaFJqQ0F0eVNhandz?=
 =?utf-8?B?cGpsa082aWJoRTJ3b1pPU3QrVUlTZmFaaEJrbjRNSmlUMHVFcUxaL0JUdllh?=
 =?utf-8?B?UEdRVnR6UVg5OUFjZXNvQXIrUVhvRFlDdWpjR05kdU1yMUtMbTZxUmVHNkZy?=
 =?utf-8?Q?VtYSyRNjMsNiNNOnsA4dAAPN+T/QNQkDajseT?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3304d16-84b4-401d-a492-08da4a242cd0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:27:25.9214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFZB9PI8Mfbpd/ekNC6/ym1ZgzwLHpQpYQOZuS8qt2hPlGmsG49tcfTALM9Tpmp4qIFAqeKsXD3/XTT56kQ3BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1570
X-Proofpoint-ORIG-GUID: f9Q5Z-vkWs9eACU--dhxex1YUl4-EjNU
X-Proofpoint-GUID: f9Q5Z-vkWs9eACU--dhxex1YUl4-EjNU
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_11,2022-06-09_01,2022-02-23_01
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/8/22 7:02 PM, Martin KaFai Lau wrote:   
> On Sat, Jun 04, 2022 at 03:20:06PM -0700, Dave Marchevsky wrote:
>> Add a benchmarks to demonstrate the performance cliff for local_storage
>> get as the number of local_storage maps increases beyond current
>> local_storage implementation's cache size.
> Thanks for working on this.  Have some high level comments and questions.
> 
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
> Note that the key size of the hashmap in the socket use case could make
> a different also.  It usually uses the four tuples(src/dst ip6/port).
> Not necessarily something need to be configurable now but would be
> nice thing to do later.
> 

IIRC I tried varying the key / val sizes and while there was a difference
it was not nearly as big as varying 'number of keys actually fetched'. Will
confirm.

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
>> hashmap (control) sequential    get:  hits throughput: 33.748 ± 0.700 M ops/s, hits latency: 29.631 ns/op, important_hits throughput: 33.748 ± 0.700 M ops/s
>>
>>         num keys: 1000
>> hashmap (control) sequential    get:  hits throughput: 29.997 ± 0.953 M ops/s, hits latency: 33.337 ns/op, important_hits throughput: 29.997 ± 0.953 M ops/s
>>
>>         num keys: 10000
>> hashmap (control) sequential    get:  hits throughput: 22.828 ± 1.114 M ops/s, hits latency: 43.805 ns/op, important_hits throughput: 22.828 ± 1.114 M ops/s
>>
>>         num keys: 100000
>> hashmap (control) sequential    get:  hits throughput: 17.595 ± 0.225 M ops/s, hits latency: 56.834 ns/op, important_hits throughput: 17.595 ± 0.225 M ops/s
>>
>>         num keys: 4194304
>> hashmap (control) sequential    get:  hits throughput: 7.098 ± 0.757 M ops/s, hits latency: 140.878 ns/op, important_hits throughput: 7.098 ± 0.757 M ops/s
>>
>> Local Storage
>> =============
>>         num_maps: 1
>> local_storage cache sequential  get:  hits throughput: 47.298 ± 0.180 M ops/s, hits latency: 21.142 ns/op, important_hits throughput: 47.298 ± 0.180 M ops/s
>> local_storage cache interleaved get:  hits throughput: 55.277 ± 0.888 M ops/s, hits latency: 18.091 ns/op, important_hits throughput: 55.277 ± 0.888 M ops/s
>>
>>         num_maps: 10
>> local_storage cache sequential  get:  hits throughput: 40.240 ± 0.802 M ops/s, hits latency: 24.851 ns/op, important_hits throughput: 4.024 ± 0.080 M ops/s
>> local_storage cache interleaved get:  hits throughput: 48.701 ± 0.722 M ops/s, hits latency: 20.533 ns/op, important_hits throughput: 17.393 ± 0.258 M ops/s
> iiuc, important_hits is only useful for the 'interleaved get' test?
> 
> and the important_hits is always a certain fraction of the total get.
> For num_maps:10 here, 4 extra for every 10 get,
> so 4/14 ~ 28% of the total get?
>

I think important_hits is meaningful for both sequential and interleaved
benchmarks - but only when seeking to optimize the performance of a particular
map, perhaps at the expense of others, vs all maps in general.

Presumably if the performance of a particular map is more important than others
it's also being used significantly more often, hence interleaved benchmark.

I expect that future work here will improve cliff performance in general, which
will be visible from sequential benchmark, while hopefully also further
improving important_hits in interleaved case where it's 4/14 of all gets.

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
>> Hashmap Control
>> ===============
>>         num keys: 10
>> hashmap (control) sequential    get:  hits throughput: 54.288 ± 0.655 M ops/s, hits latency: 18.420 ns/op, important_hits throughput: 54.288 ± 0.655 M ops/s
>>
>>         num keys: 1000
>> hashmap (control) sequential    get:  hits throughput: 52.913 ± 0.519 M ops/s, hits latency: 18.899 ns/op, important_hits throughput: 52.913 ± 0.519 M ops/s
>>
>>         num keys: 10000
>> hashmap (control) sequential    get:  hits throughput: 53.480 ± 1.235 M ops/s, hits latency: 18.699 ns/op, important_hits throughput: 53.480 ± 1.235 M ops/s
>>
>>         num keys: 100000
>> hashmap (control) sequential    get:  hits throughput: 54.982 ± 1.902 M ops/s, hits latency: 18.188 ns/op, important_hits throughput: 54.982 ± 1.902 M ops/s
>>
>>         num keys: 4194304
>> hashmap (control) sequential    get:  hits throughput: 50.858 ± 0.707 M ops/s, hits latency: 19.662 ns/op, important_hits throughput: 50.858 ± 0.707 M ops/s
>>
>> Local Storage
>> =============
>>         num_maps: 1
>> local_storage cache sequential  get:  hits throughput: 110.990 ± 4.828 M ops/s, hits latency: 9.010 ns/op, important_hits throughput: 110.990 ± 4.828 M ops/s
>> local_storage cache interleaved get:  hits throughput: 161.057 ± 4.090 M ops/s, hits latency: 6.209 ns/op, important_hits throughput: 161.057 ± 4.090 M ops/s
>>
>>         num_maps: 10
>> local_storage cache sequential  get:  hits throughput: 112.930 ± 1.079 M ops/s, hits latency: 8.855 ns/op, important_hits throughput: 11.293 ± 0.108 M ops/s
>> local_storage cache interleaved get:  hits throughput: 115.841 ± 2.088 M ops/s, hits latency: 8.633 ns/op, important_hits throughput: 41.372 ± 0.746 M ops/s
>>
>>         num_maps: 16
>> local_storage cache sequential  get:  hits throughput: 115.653 ± 0.416 M ops/s, hits latency: 8.647 ns/op, important_hits throughput: 7.228 ± 0.026 M ops/s
>> local_storage cache interleaved get:  hits throughput: 138.717 ± 1.649 M ops/s, hits latency: 7.209 ns/op, important_hits throughput: 44.137 ± 0.525 M ops/s
>>
>>         num_maps: 17
>> local_storage cache sequential  get:  hits throughput: 112.020 ± 1.649 M ops/s, hits latency: 8.927 ns/op, important_hits throughput: 6.598 ± 0.097 M ops/s
>> local_storage cache interleaved get:  hits throughput: 128.089 ± 1.960 M ops/s, hits latency: 7.807 ns/op, important_hits throughput: 38.995 ± 0.597 M ops/s
>>
>>         num_maps: 24
>> local_storage cache sequential  get:  hits throughput: 92.447 ± 5.170 M ops/s, hits latency: 10.817 ns/op, important_hits throughput: 3.855 ± 0.216 M ops/s
>> local_storage cache interleaved get:  hits throughput: 128.844 ± 2.808 M ops/s, hits latency: 7.761 ns/op, important_hits throughput: 36.245 ± 0.790 M ops/s
>>
>>         num_maps: 32
>> local_storage cache sequential  get:  hits throughput: 102.042 ± 1.462 M ops/s, hits latency: 9.800 ns/op, important_hits throughput: 3.194 ± 0.046 M ops/s
>> local_storage cache interleaved get:  hits throughput: 126.577 ± 1.818 M ops/s, hits latency: 7.900 ns/op, important_hits throughput: 35.332 ± 0.507 M ops/s
>>
>>         num_maps: 100
>> local_storage cache sequential  get:  hits throughput: 111.327 ± 1.401 M ops/s, hits latency: 8.983 ns/op, important_hits throughput: 1.113 ± 0.014 M ops/s
>> local_storage cache interleaved get:  hits throughput: 131.327 ± 1.339 M ops/s, hits latency: 7.615 ns/op, important_hits throughput: 34.302 ± 0.350 M ops/s
>>
>>         num_maps: 1000
>> local_storage cache sequential  get:  hits throughput: 101.978 ± 0.563 M ops/s, hits latency: 9.806 ns/op, important_hits throughput: 0.102 ± 0.001 M ops/s
>> local_storage cache interleaved get:  hits throughput: 141.084 ± 1.098 M ops/s, hits latency: 7.088 ns/op, important_hits throughput: 35.430 ± 0.276 M ops/s
>>
>> Adjusting for overhead, latency numbers for "hashmap control" and
>> "sequential get" are:
>>
>> hashmap_control_1k:   ~14.4ns
>> hashmap_control_10k:  ~25.1ns
>> hashmap_control_100k: ~38.6ns
>> sequential_get_1:     ~12.1ns
>> sequential_get_10:    ~16.0ns
>> sequential_get_16:    ~13.8ns
>> sequential_get_17:    ~16.8ns
>> sequential_get_24:    ~40.9ns
>> sequential_get_32:    ~65.2ns
>> sequential_get_100:   ~148.2ns
>> sequential_get_1000:  ~2204ns
>>
>> Clearly demonstrating a cliff.
>>
>> In the discussion for v1 of this patchset, Alexei noted that
>> local_storage was 2.5x faster than a large hashmap [1]. The benchmark
>> results confirm that this is still the case: a long-running BPF
>> application putting some pid-specific info into a hashmap for each pid
>> it sees will probably see on the order of 10-100k pids. Bench numbers
>> for hashmaps of this size are ~2.5x slower than sequential_get_16, but
>> as the number of local_storage maps grows past local_storage cache size
>> performance advantage reverses.
> iiuc, the test on the local_storage get is done on the same task ?
> 

Yes, the task of the userspace runner process.

>>
>> When running the benchmarks it may be necessary to bump 'open files'
>> ulimit for a successful run.
>>
>>   [0]: https://lore.kernel.org/all/20220420002143.1096548-1-davemarchevsky@fb.com
>>   [1]: https://lore.kernel.org/bpf/20220511173305.ftldpn23m4ski3d3@MBP-98dd607d3435.dhcp.thefacebook.com/
>>
> 
> [ ... ]
> 
>> +static int do_lookup(unsigned int elem, struct loop_ctx *lctx)
>> +{
>> +	void *map, *inner_map;
>> +	int idx = 0;
>> +
>> +	if (use_hashmap)
>> +		map = &array_of_hash_maps;
>> +	else
>> +		map = &array_of_local_storage_maps;
>> +
>> +	inner_map = bpf_map_lookup_elem(map, &elem);
>> +	if (!inner_map)
>> +		return -1;
>> +
>> +	if (use_hashmap) {
>> +		idx = bpf_get_prandom_u32() % hashmap_num_keys;
>> +		bpf_map_lookup_elem(inner_map, &idx);
> Is the hashmap populated ?
> 

Nope. Do you expect this to make a difference? Will try when confirming key / 
val size above. 

>> +	} else {
>> +		bpf_task_storage_get(inner_map, lctx->task, &idx,
>> +				     BPF_LOCAL_STORAGE_GET_F_CREATE);
>> +	}
>> +
>> +	lctx->loop_hits++;
>> +	if (!elem)
>> +		lctx->loop_important_hits++;
>> +	return 0;
>> +}
>> +
>> +static long loop(u32 index, void *ctx)
>> +{
>> +	struct loop_ctx *lctx = (struct loop_ctx *)ctx;
>> +	unsigned int map_idx = index % num_maps;
>> +
>> +	do_lookup(map_idx, lctx);
>> +	if (interleave && map_idx % 3 == 0)
>> +		do_lookup(0, lctx);
>> +	return 0;
>> +}
>> +
>> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
>> +int get_local(void *ctx)
>> +{
>> +	struct loop_ctx lctx;
>> +
>> +	lctx.task = bpf_get_current_task_btf();
>> +	lctx.loop_hits = 0;
>> +	lctx.loop_important_hits = 0;
>> +	bpf_loop(10000, &loop, &lctx, 0);
>> +	__sync_add_and_fetch(&hits, lctx.loop_hits);
>> +	__sync_add_and_fetch(&important_hits, lctx.loop_important_hits);
>> +	return 0;
>> +}
>> +
>> +char _license[] SEC("license") = "GPL";
>> -- 
>> 2.30.2
>>
