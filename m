Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2157E52F6ED
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 02:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352827AbiEUAin (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 20:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354305AbiEUAii (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 20:38:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC051ACF8A
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 17:38:35 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KMsGOu016875;
        Fri, 20 May 2022 17:37:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lfv02LBCG+NG+1Q3qlovBZ2SDLib03WShIQjfMIwqw4=;
 b=GQIIR2vUcSmbNIcxyEEMMtrhEc1dTcYC7vUsVPP0K7/yTZElD0+cfGHU222no952RnIS
 dj//gUrk7YG4uHBmKq1RvAhiNAJE2qBV+wIKmZCq3wBQkWbbGn2raN1OIz0+l7ycC7AG
 cCuCDnWhXyJxXTuzG19mWuYep1DDQT0EVDM= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g5pj53ssa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 17:37:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmlAYhzuz+3sxB9Kheelg5/GkDOyc7H7kIDhtx0ciaOzB+bgJjbX4gs/xCsfzBE4KjIlo14aJYNGUQYGs4qt2spKXbNGw8O3IWL0K0dy88C6KVovuO8yztE3DM1ABBJ4sQOEUPqUkRvlB6rTYnJ4dKb5P2c2tKQIUXpn+4XAS8HRQ+ej8Be+HRsDZ7RgJSYna1idoHLcQg1LpTn8uyHKvMkRBEdq0XK5CEbzcz5uvNv8ubT1kOQJ1FUKHhphNn1CX+d6eMs8OZSYUJemhefpmNM45ifs6BZ1rwOPp0II6rmw/oqEcAapCFEi5CkQaUHFN+tc5IbQIXCZHs9+rOHsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfv02LBCG+NG+1Q3qlovBZ2SDLib03WShIQjfMIwqw4=;
 b=mWp1Kw2WcbkKG6N3ruNp7aZxffSyB2Xbg7P/Ru3ZqfEVnY8FZK9fHAbQ141PBDj1fpWU0zrWWcW9C5U3eguegusiz8gfG/6V3hP/Dy1q/ieBvqL8vOFsyaXUfLJxsNljjTptjgR0D5Mx/R833duj5B8Y1C3aM6hqsJpx05C+RUemC7VZLHXL/aZ4cMxVgbVe1rNz1yWHRV+bnnNfR4XnCkL1WL9R48SqaWoSB63rqNcDXjVFOtBEaUzS8tqTGSRyINJa7nhClUNKbr6vzndVFVj6swzKdcmyWseAd4lfWGiqAiO5QsdBUoVofiAUAgDq/L7dmmcdutmIEdaDfLSTvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB3417.namprd15.prod.outlook.com (2603:10b6:5:170::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Sat, 21 May
 2022 00:37:54 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb%8]) with mapi id 15.20.5273.017; Sat, 21 May 2022
 00:37:54 +0000
Message-ID: <546b5c2d-6b77-4502-6326-2758cf544f24@fb.com>
Date:   Fri, 20 May 2022 20:37:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>
References: <20220518035131.725193-1-davemarchevsky@fb.com>
 <CAADnVQ+eDH5mAdb4Nobf1Np3myhxBprgB-jOHLsJKMJ0KBK7Nw@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <CAADnVQ+eDH5mAdb4Nobf1Np3myhxBprgB-jOHLsJKMJ0KBK7Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::8) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 957b080e-6486-4021-c825-08da3ac224f3
X-MS-TrafficTypeDiagnostic: DM6PR15MB3417:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB341798C864E572682C1E50E4A0D29@DM6PR15MB3417.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0KLQzp793PH3f/fwBKH3zSgOVwZ4qOsFcPK38+he8E+0hezhg2VbFLxVcjtprvPY4r1t/+EjTSyBSMPbs8HAbVEeNT5Oy5lXuf33W3ypR5d3T10U2p1MEW03f9hmhTsp1LOD0unZqNSl3x5UgIK6TAe1d/nBOpfj4/tHxRRfZyYAQgV6V2OuXiPE/63KQevhQhBnni71aWxIAepCWnzs2p7yYfdnj2bxOr1OU5rOD83TlzFW+zQPD/SrxMLnCin2KKW+bJar9JBnoB+ahl6kGqylqXenP7TrT+gRQmyR/LBpKFyMedfBeYjdKO0ee1N7UriYIyqvm496ZXNSiq4V2oFDcBzmvGC6KOPO8amdN3E1LLILSxjtqS/nqSX3GOD769Z86W4vikorbdtIc7gv8+EJrJz1zPVYp2UYGCA88ZkGTL7aEx4uYXU0x8gbmcXBuu2RHuF2eieIieGHa316+1EFkNnkBqnYzhegxDit62ON3hsJsVQ7vHq1vQqBXYgb8Vqe155IITmsc4evM7sM3ZwXcEggH5bmBYmxNrDTe7JdFvdxHIK5EVJW0eVqrUXdBj49JsJcVSyiIpFcrIXU39r1M4rx1pPnQD6e+mv4AddafchIaf9bUd0zh2tw/SJ0KOWG8bVZYUzs+U6tay4vw42Qf4KAsvibGlUn+uwoT4cbVq9eD8e2g5G36F0EJG/BNiay571kEzTovJr0qbfjSS54pA9yC5KNcSaOAjz+mYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(53546011)(6916009)(6512007)(316002)(6506007)(66476007)(54906003)(66556008)(8676002)(4326008)(38100700002)(8936002)(66946007)(508600001)(86362001)(6486002)(31696002)(2616005)(83380400001)(2906002)(31686004)(186003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1E2RDdpTzJvOExTaklVM0RoUmh4b21UaUY2MnRVOFFtWkNsN05BU0dyMVlj?=
 =?utf-8?B?MW53dCtvWHJoVURkMWJaWmpPMzUyaFU0N1VPRnJpRHdlUXgzNzdaVXVFRmg2?=
 =?utf-8?B?Zm9nVzJqZVRVdWE1OEs2UlA4TUN0YVNKOXZrcWV5bEoyNmJmQ2FTdUtYZ1Ft?=
 =?utf-8?B?SG9KUjNmYzl0NlNHQmNFNnZiNGFMbjlUT0Z2dmJsd2lHV0xDUXNkV3FZK01u?=
 =?utf-8?B?dGFBeXFaWFU4UFRCN3NQaUdxZHdtdlBxZEdxZU41amQ2Nm8zVE5uQ09iR3I1?=
 =?utf-8?B?YkJPeUFnNGp6SFloeE9kL3F5dGR6bXNwb1BTYXZCMHlLNGpxcjNUYXRLL2d4?=
 =?utf-8?B?RGVJbkhpbGF1MGs3dkRWaXRabDdUbTZTcktiZWI3UWZOZGEyY1lJREJlMllM?=
 =?utf-8?B?bkoyVGNlYjBodFhjd2RTZ0JrWkpLSHI5ZUg4Mmp6OXd5eUo4cExsd2NyMjB3?=
 =?utf-8?B?NWFYT3BSVmtkbkROeWVSekJUeWRUT0VDSlU5eHpzUlZrQ2kzdDFQSERNR0pT?=
 =?utf-8?B?Rkp2ZG02dTRWb0VRaDNiRkcwOFoxQ0w4N2h3QjNlV1ZoNG55YUl3RnJic3RM?=
 =?utf-8?B?eVljSjlwRy9PT083VnJpK21hSjZEdW14dnNJc3NMMzNicStVT0wvS25UWTJu?=
 =?utf-8?B?T0pycDRPeGlrd2RMbUtYcjVncit5SWtTWmRqemhsbWlINGFXd0xab3hQTEZK?=
 =?utf-8?B?M3Q2elZtZFNJc2kxYUlRcy9uUzhMNWRsdjlwUm9UUkpQOVBnS2ljT0N6dGN6?=
 =?utf-8?B?eGQ3UlNSODcxb0tCZ3lIYkxFZURTbjVDTCtNNGwxZGxDTFhWOHZ3eG1XdGtP?=
 =?utf-8?B?V1Z0Q3JmbFZGSzZ0U0tqTy9NRm5BQjNqN25lSEkzNTkvR29XajkxMWhOWit3?=
 =?utf-8?B?SnJVaVdoczFoTk9tcXo4aFdLZ1FSSFF4ZldvazRhUWpxUUJ3aXFkdlovbWwy?=
 =?utf-8?B?UEJxbVgreVoreEVtVTYrVEZlRE0yS2ZkTWNTemN1RHQ1RTZ2MGFWZzhQcHUv?=
 =?utf-8?B?OWREWEZZR2d4VTRjd0RTaVRoSWpSRjhHSlRWMDVtWDNwemxuS0RLQXpjbVd6?=
 =?utf-8?B?TjNQUjhQa0UvbDAvTnNKUkRGNC9iOGNQcUcvUG1ZelZVYjAyQllyVFluVXYr?=
 =?utf-8?B?cnR4SGdtS2pwTHJpS000VGlldDhLRW1IUDJSc1dyNEtNYjFwVkJrdkdDQjZW?=
 =?utf-8?B?SUgraVlpdC93d3h5aTF1eloxYytDVHdHTitEOHFLTG4ra243RmdnT1pNYXFP?=
 =?utf-8?B?OVc5VXFGNWlDaDRjcVZOeWJUMUw4cURmdFVGdjQ1SHVaSVNnbHlxSUEwTzRY?=
 =?utf-8?B?bHh0N29aRzlMbzFBTjFiY05wRnlyejZ2NkNCbUJBekwyRW4zTytvZGwwNk81?=
 =?utf-8?B?YWNKajcvZXBncTNTanZ2TzVQamFiTHBraXhtUTRoRWZBYUM3akZWRWloQXIx?=
 =?utf-8?B?Wkx1Q280enNDSzRNcS9oQXlIQWFIdTdzNmJpQkF3VWJ2VFdPQXdpRWVDWDdt?=
 =?utf-8?B?M3VUeng1aWxRMDlKc1VjMWtEQmRXUFBCank4YXJqRmorZzVpSEFIZk5iYzZE?=
 =?utf-8?B?RG1xTWUvZEd6UGRMRzY0WmgwdzdFdkQ2K2gvTjh5QXFyeWZDdVBTYUJweWhy?=
 =?utf-8?B?d1VkQTNyaG56SDRKcERqNS8rY25QK2pmUkgwUW81bStIRHcyelhaSDFDTGlX?=
 =?utf-8?B?SlE0dGt1Ny9GckQxdHovcm14T0Z6d1dXMXJiczR5VjdrRzQ3UXBaRzQrUHBh?=
 =?utf-8?B?RFFUVktISnQ5bEdpK0pWN2xRSU5oZFp0NFZHQkRzempZVG5SRXQ2SXVrM1gz?=
 =?utf-8?B?QTduMG9EU1dOUWJ5NTdNRmtieE1wbXptbVFaMGd5ZVVweDR2WnB1WkRHMUxP?=
 =?utf-8?B?SlNrMjFSVFlRNzZMWm9tQ1hjbGlXeTB0ZW5nSzAybCtXRWl3Si9Ec1dES3ZU?=
 =?utf-8?B?ZUd4YXBPNG5aeGRyUWNoZ2txcHRJNHRST2srVXFiRmcyZFNqdEZycXJ1SlY1?=
 =?utf-8?B?dXhOT3QvaTFaSFJwRWJDM1ArMmJLSVdqTUZKN0hmOEJ5QzJxM0MzWENQNVYr?=
 =?utf-8?B?ZjdzcWozejBKaVdFamR4cGNMaU81MUZyZG1EMXFGWk9KdzdXL0J2czJ0Wm5p?=
 =?utf-8?B?cUlvc21EQzU3a2RzeWtlYU5SNUo3YXJkVkQzUEVHUWp0bmVaU1R0TlEzZFJp?=
 =?utf-8?B?R0Rla3hCMXE1WWFEWTltZks3UWJUNzg0RTVXT3Rjc0VUbnJBOGYrM1JrMG5m?=
 =?utf-8?B?YnVObzJ5K0Q2SFYxdERXU2I0VXpyZy95NG8vcGhRRThWZ0tNRnoyRytEcEdo?=
 =?utf-8?B?bElrSjFxcWdjNEk4d2tJbGl1bFQ1SEQ3YjNyTER2S0I1RlN2ZHhjRk9NWTMy?=
 =?utf-8?Q?vcV54OB1qfs2p6FC1vSXgsnIniLKJaNvlx5ut?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957b080e-6486-4021-c825-08da3ac224f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2022 00:37:54.6243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgBPSnJiIPVFYJVhG53hpCr1T7Ed/Sc2PDtGNygKJbupwFto/T5uDqIWyBaOamsEP3iEH4BfII60TwVyB79PBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3417
X-Proofpoint-GUID: jFjXi_JygyxIHRAJG15qc3jBcnfZt4NM
X-Proofpoint-ORIG-GUID: jFjXi_JygyxIHRAJG15qc3jBcnfZt4NM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_08,2022-05-20_02,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/20/22 7:46 PM, Alexei Starovoitov wrote:   
> On Tue, May 17, 2022 at 8:51 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>> maps increases, though.
>>
>> Note that the test programs need to split task_storage_get calls across
>> multiple programs to work around the verifier's MAX_USED_MAPS
>> limitations.
> ...
>> +++ b/tools/testing/selftests/bpf/progs/local_storage_bench.h
>> @@ -0,0 +1,69 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
>> +
>> +struct {
>> +       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
>> +       __uint(max_entries, 1000);
>> +       __type(key, int);
>> +       __type(value, int);
>> +} array_of_maps SEC(".maps");
>> +
>> +long important_hits;
>> +long hits;
>> +
>> +#ifdef LOOKUP_HASHMAP
>> +static int do_lookup(unsigned int elem, struct task_struct *task /* unused */)
>> +{
>> +       void *map;
>> +       int zero = 0;
>> +
>> +       map = bpf_map_lookup_elem(&array_of_maps, &elem);
>> +       if (!map)
>> +               return -1;
>> +
>> +       bpf_map_lookup_elem(map, &zero);
>> +       __sync_add_and_fetch(&hits, 1);
>> +       if (!elem)
>> +               __sync_add_and_fetch(&important_hits, 1);
>> +       return 0;
>> +}
> 
> This prog accesses only two maps: array_of_maps and global data
> (hidden array map).
> 
> Where do you see it's reaching MAX_USED_MAPS limit ?

You're right, that's a holdover from v1.

Will fix and send v3 w/ new benchmark results.
