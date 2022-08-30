Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8614D5A6884
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 18:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiH3QhX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 12:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiH3QhW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 12:37:22 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F32AB6D60
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 09:37:20 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UApNoA031370;
        Tue, 30 Aug 2022 09:37:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GOZZJTGzJzxL78HlqB+q1DNsVZZBX92YX1RQMMElhKg=;
 b=XfJEO95wLkl7IIW8fyxuit8CroQi3HZbbN65KIGZ0/0jQ+9HUCM4yfFS2p0Xm2JwFtB+
 S9n/gzqa9+60JnGeUgXt/0czWsefB0zg0C7fY6x3nVUcFp0WJwg2lNc5Jl4lplONq7Ya
 oHJjYpwgAfDf0VGwwjGc75d5A1ImlnmtWSQ= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9h5dja9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 09:37:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkITmhGPdXFFXjIBN85+UN/DOt+SfqYOzXEdBXVhxhPq66A7b6fp3U9VrSgcrqutItkQFGI31MIqj5ZQpHg4i4gtbsGK/CaiFWskuLYPvH0nqB/M9yh0xhLCu9fgXcKWMSAd83BxJNT2uGFZsGy6TO5Kn+eul4Dy991ZT4iqOOt/Y1sv1+9yktEIcKgd+1nnzdDG9a2UdHu8HjANV7TP3PJuPzPrYD2urjTYL0+mWFgc81hEP0Yp6wWL/90RsPeHxUJHXMCWegFX17WWNwAtxwTVCXGtZ+5EZRj7D8oy7piSmi0VcIMJ5wnnEPXAKOZNLD8u/q2zGq8JCnQWMzb0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOZZJTGzJzxL78HlqB+q1DNsVZZBX92YX1RQMMElhKg=;
 b=lCdhF+tAXVZaXkrh3e0hZEAnWm2aq+y9dt1Y9OEPyYxXpKbYhp3/FGsYbcJhpOvZ/D1PNlX1DDGVAm8j4IvO7BVSJeG8cgM/MfH6oaQKOx4SXHKVj0AIlKbFN+Q01DXb/7ze/D5p5Nl3UMNTdna07B+nXv/qrU2iqih+ZTTO9IZDRhRbZ/b452zO4tZKrz5pGPkd8lVTTxavYtdK3QP0qj66unfATaMlAHzfk7Xf8oUC7V0RmkEdE3GYkiyyj4rYRWh1F7BTtVzSVxomWrK2v21+Ffa77443ytBppY7y1ePp1jjRv4BWU5IRXQwKiwOZmUyZ4AUvfeiIQdwONuCQbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN6PR15MB1139.namprd15.prod.outlook.com (2603:10b6:404:eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Tue, 30 Aug
 2022 16:36:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 16:36:59 +0000
Message-ID: <cb069722-089d-1c6e-66c2-478dad1da870@fb.com>
Date:   Tue, 30 Aug 2022 09:36:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v3 6/7] selftests/bpf: Add struct argument tests
 with fentry/fexit programs.
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com
References: <20220828025438.142798-1-yhs@fb.com>
 <20220828025509.145209-1-yhs@fb.com>
 <7cf3de93-ae20-3d76-20d9-67242a65408b@iogearbox.net>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <7cf3de93-ae20-3d76-20d9-67242a65408b@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e517934-89af-4648-1298-08da8aa5dc0a
X-MS-TrafficTypeDiagnostic: BN6PR15MB1139:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N9vFiD3L0n4MGJpGdSjSvdZd3g8EKxAVneIIN45Iep3iJ5an4vPpJCe+ZIiQQ4dGFNfK25i4dw2u9I0Ewz45fAjEr60Mb/0O3fYG8At3kICT69PL5mP83AgzqhmrP1vd4ftmVFfmr5E0qdHNCmGTlDCpPgDlMKknPAHrAWc/olyVCDG0vWTPFBtuTZKrk9hE0J5nJLF6qzUo7BHJ6yoMm8LTe3GGHn0Mwinj/nMmsv7LfdZZdRIrIA9mAJ3WJV9kuwdyMNC7/glDJD10R02eghVOWMKJ2yP0Z1otyyWRiohnLeCCmR9PdZ3iA+g96eHbu0oy27zzbStXSMYKLU3dzvEx5JYTEFRV5kDlrs58ajXKPHrdxOfIYAQ7xvrnC6wLNALGPo9XJyuVCoqszV9EnPgu2s5iGToZ1J68qNgtmEZLqgguY+Lw3W7uFUh+uqyOSgrQ+kfedywg3sg5p7blPELtxCHeyXz5VBy8CTkOiYLjvFqcq30fb4ccF3OrzO9TiJbnIKaCzTXhOcnofq72dgAk2lciUOaEeQOjF8ao1VSrzJETTKqw0HdqIZFj6JvuE5gNu/b05Hgbv3KupbToeR3j+R824J9nysbqZYIGgUaMJJjJ3E3xnGd12OtCOpGKS0Mgcdd2c1P/Rf+7YqlY1jvIn5aqFHmVRrV1gugYdY0Mi939z3NsjNJ7hsfEznZGbGK+WLjLmFP4xWZ2Kbe5ZYxSzfbIhyCdhFRVK35PYmyFLMp5vKoycT2N1KTu/sg4hdGj0Vp7houAw0G1vwpSs9eFBv1fkeYDTACqFhe9hIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(8676002)(31686004)(86362001)(66946007)(6486002)(54906003)(186003)(478600001)(31696002)(66556008)(316002)(4326008)(2616005)(36756003)(66476007)(6666004)(6512007)(2906002)(5660300002)(41300700001)(8936002)(53546011)(38100700002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEpvY3Z2dXJqUld0MkVPWlovalFnVXdJejZPQ3JpTXhyRDJNVVM4S1BTMjQ1?=
 =?utf-8?B?Zmp0cjVPU1UwaHVvaUJiTTZoYUx1bmdjK1pWSWtQYW4zVlA2ckZUZ0orMElG?=
 =?utf-8?B?VloxK3M2dFp2UkFETVkxL3FzS0hJcElUS1Y5MFNzQ1F2K2xqUWtVczZ5V3Zh?=
 =?utf-8?B?dHhCZ05Hb0g3MnJIWlJuWU9PbEhSalhTNVBFRWVWTUwxaFl5RTIwOCtuQ0hI?=
 =?utf-8?B?WUR1MVUrdzNmN2FKaXFtM3RKMDlRWTRBdW9xVW1GMG0xdXNGc0JmRTNJbWND?=
 =?utf-8?B?YW9NV3VVQzR1OGxFWG1td1RyOG80blpVK2xURU9tV1ZVbjVJZ1NKN0lqemRE?=
 =?utf-8?B?QlJla0lVdlFVcHRNWC9QWjI5WmQwVmRINy9QdVlvMUtvY1dFaHJMb3FUdWtN?=
 =?utf-8?B?Z1JDTGovd0RPSUpWNWlmTDZYSDR5QXFlamRBN3p6VVV6SUl0UzU2elN3dEhx?=
 =?utf-8?B?ZENuVTN4dE1aZytKUENJYWh0ZVlmSVcvOU1ja245K2tYQVR3RVdIdzBBRDhw?=
 =?utf-8?B?dUd0ZXlremV3dU5vVHY2SDZlTjczeXFCY2lpS2VLVFBiaWorZGlUT3RDSXNi?=
 =?utf-8?B?eUFmNkM2RE4yUnd6QmZQQkp2ZFA5dTVTV2QyNnVPUUFlY09sWGVobWtxSE14?=
 =?utf-8?B?bEJxZURIeW13ck5xMzdRK05iN2hrb1RHQmdieDFlWGRVbC90MHJYWFQrZ2h6?=
 =?utf-8?B?alRwbFlOQWJ6bVVBcFhCcUl3RGVnMGRKQXhneGV1QTMyU3ZLQkluOHI3L1Jz?=
 =?utf-8?B?Qzh5cHY0RW1nMnlBclVBUm9OdFR0UDNYc09FY3VycTZJeVdWWWhEZnNUVG44?=
 =?utf-8?B?YlErY3A2NFUzMm1Qak8xSTJzUGEzcXQ4UTRIUlJ1bHh6OHFpQTdBZW9CaUxw?=
 =?utf-8?B?T1JXc2tscFVRWmNObXMzNE1VMDlJcCtNOTVMUyszakxJNmFPcEQ5Zy9MVGpV?=
 =?utf-8?B?Z2xaV0xVY1FTTDJ2Y01hQWJnS2x6MFJJY01nTFJmSjg0NVp1THJHOVhlRDJ2?=
 =?utf-8?B?NGxaeHY4Z1hLWmkrU3N5Z056aFBsN053dWtiSFdSQmMvZ0REZzZVZWFPVHhC?=
 =?utf-8?B?QkFIQnZ1ZElHZkxzbmRJNVpTdUxRME83QlZkd2gyNlNrcEdzaVc1MGVRaXNF?=
 =?utf-8?B?RmlmZjhZdzY5MTFCUXh2NFVOUmYvaktzbTZERWtrMDdrTEJ5eWRXbXFuR1Bn?=
 =?utf-8?B?bVVWRXRsSUNBUzRuZTREUmUxd2l5eCtIbWFLSGh2Mk9mdlpQZDVpamRrZEhs?=
 =?utf-8?B?bzZ2bk9CNE1naEhlRUR0Ynh6dFhOWmg1REhtUG1GVzkxdDIzTUxQN1ZvL2Mv?=
 =?utf-8?B?VHhBaWJRUit6eVlWbUozUG1rU0FnbDI1MHVsa0dWRUp0ZS9yOUowSlI2Z29C?=
 =?utf-8?B?Y1hSRmZyMnU3QUtqTkYrUWpneU5OR1lreS9hNEtqdEdVTVhSQjhyamwrbWds?=
 =?utf-8?B?d2hwbmJZdVVkclNFTTRJd0lJT2kzYkcrRktUOUxrRXBQVlg2QkhKL1dQY1Rj?=
 =?utf-8?B?VXBXWlNYY25VWFNlRWJ3MEY2TWxsaU5GakJPU1hxMjJGRFJydG1FMVphZVZ3?=
 =?utf-8?B?NitTeHovTHJsT1NwWmVIajJsTGxqYVMyM1FuUXJIcFI5WG1vOVgwZkNOQXBu?=
 =?utf-8?B?dVg5WmM5T1ZOWGRIdFlZOHhSeTMvcitITjJmRllzR1czRytka2lYMGJ5M2lj?=
 =?utf-8?B?S0liSEdudVlBOEFLdkJNeHBVcjdheGhVaVZYVXF6NytkOTZGZ2FDMCs5UkRE?=
 =?utf-8?B?dE1YMXJOVFBmTXpNZUFYV1B5MGx3eGlkam9oVkhJN0IwTlY2b3RUeW83aUZt?=
 =?utf-8?B?TlVBR1hPdnJZMXBab3ltaFJhaVZad2F0cjhiT1M4aC9hZ1pjc0Nld0xQQzN4?=
 =?utf-8?B?cFpwcUNCZVoxOUI0d1JRNngyYWtYVW9TR2h5d3RlcC9VWHVqdEVVak41cDg5?=
 =?utf-8?B?aFkyWjdwK1ZncldaU01WVEVSMzBBSURYMktWUDhBUHpRaG0rYmhJNWEyV2V2?=
 =?utf-8?B?WHJLbUZZakoyTUV3K2s1UVNvWFQvZitYUWU4NWxmWC8zcitzTjd0NTZLSjhV?=
 =?utf-8?B?NVcrNGduV1hwQkpsNE1CN2pVdEIrZk1xRllPZlVrN1VENHVvRFJNZzdyRUVX?=
 =?utf-8?B?TGM0RWFvLzlkM0VJM3dlNDQ0ZjJzYXp0UEs0eUF1dlowU0duNm5IUXZwMUd5?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e517934-89af-4648-1298-08da8aa5dc0a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 16:36:59.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6Y15oFpmUcfzMinrSjXINKlY6rqQm5A06/i2060OKewWIDVC7be/br8+nMOumkQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1139
X-Proofpoint-GUID: mMnF7Dmo7zIWKXKKa2Wvzh46VbVH9MKS
X-Proofpoint-ORIG-GUID: mMnF7Dmo7zIWKXKKa2Wvzh46VbVH9MKS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/29/22 3:12 PM, Daniel Borkmann wrote:
> On 8/28/22 4:55 AM, Yonghong Song wrote:
>> Add various struct argument tests with fentry/fexit programs.
>> Also add one test with a kernel func which does not have any
>> argument to test BPF_PROG2 macro in such situation.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  48 ++++++++
>>   .../selftests/bpf/prog_tests/tracing_struct.c |  63 ++++++++++
>>   .../selftests/bpf/progs/tracing_struct.c      | 114 ++++++++++++++++++
>>   3 files changed, 225 insertions(+)
>>   create mode 100644 
>> tools/testing/selftests/bpf/prog_tests/tracing_struct.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct.c
>>
> 
> For s390x these tests need to be deny-listed due to missing trampoline 
> support..
> 
>    All error logs:
>    test_fentry:PASS:tracing_struct__open_and_load 0 nsec
>    libbpf: prog 'test_struct_arg_1': failed to attach: ERROR: 
> strerror_r(-524)=22
>    libbpf: prog 'test_struct_arg_1': failed to auto-attach: -524
>    test_fentry:FAIL:tracing_struct__attach unexpected error: -524 (errno 
> 524)
>    #209     tracing_struct:FAIL
>    Summary: 189/972 PASSED, 27 SKIPPED, 1 FAILED

Thanks. will add the test to deny list.

> 
> However, looks like the no_alu32 ones on x86 fail:
> 
>    [...]
>    #207     trace_printk:OK
>    #208     trace_vprintk:OK
>    test_fentry:PASS:tracing_struct__open_and_load 0 nsec
>    test_fentry:PASS:tracing_struct__attach 0 nsec
>    trigger_module_test_read:PASS:testmod_file_open 0 nsec
>    test_fentry:PASS:trigger_read 0 nsec
>    test_fentry:PASS:t1:a.a 0 nsec
>    test_fentry:PASS:t1:a.b 0 nsec
>    test_fentry:PASS:t1:b 0 nsec
>    test_fentry:PASS:t1:c 0 nsec
>    test_fentry:PASS:t1 nregs 0 nsec
>    test_fentry:PASS:t1 reg0 0 nsec
>    test_fentry:PASS:t1 reg1 0 nsec
>    test_fentry:FAIL:t1 reg2 unexpected t1 reg2: actual 
> 7327499336969879553 != expected 1
>    test_fentry:PASS:t1 reg3 0 nsec
>    test_fentry:PASS:t1 ret 0 nsec
>    test_fentry:PASS:t2:a 0 nsec
>    test_fentry:PASS:t2:b.a 0 nsec
>    test_fentry:PASS:t2:b.b 0 nsec
>    test_fentry:PASS:t2:c 0 nsec
>    test_fentry:PASS:t2 ret 0 nsec
>    test_fentry:PASS:t3:a 0 nsec
>    test_fentry:PASS:t3:b 0 nsec
>    test_fentry:PASS:t3:c.a 0 nsec
>    test_fentry:PASS:t3:c.b 0 nsec
>    test_fentry:PASS:t3 ret 0 nsec
>    test_fentry:PASS:t4:a.a 0 nsec
>    test_fentry:PASS:t4:b 0 nsec
>    test_fentry:PASS:t4:c 0 nsec
>    test_fentry:PASS:t4:d 0 nsec
>    test_fentry:PASS:t4:e.a 0 nsec
>    test_fentry:PASS:t4:e.b 0 nsec
>    test_fentry:PASS:t4 ret 0 nsec
>    test_fentry:PASS:t5 ret 0 nsec
>    #209     tracing_struct:FAIL
>    #210     trampoline_count:OK
>    [...]

Thanks for the headsup. Will check.
