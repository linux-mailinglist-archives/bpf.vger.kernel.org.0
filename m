Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A47B5A30F4
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 23:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiHZVYb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 17:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiHZVY3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 17:24:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05201BA9DF
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 14:24:24 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QKYkg9029636;
        Fri, 26 Aug 2022 14:24:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Q11DmB8xxUkKhcZhEjM+JfnskUwB4yXjnVvoDkUmTpU=;
 b=ckVyH8gCwhl1G29xPDroNroN6B+mzvWJLpooHL37Ng4GCKbVirWHDAhm6iMKObD4v79V
 aoBt34tWDjP542rwvAKXeMt3kXdVQAjUCehoHtOUPymlQgA6FpM8sfxd7wXnkxz6/Txg
 aj+VO7Cw3QtZ6z4tkbkL/wVxXi1NdjblYyQ= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j75b5r9dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 14:24:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0k5/R4/eWFUwO3Ak/XTU/4TNIy1q6E1JAzo2LpmzuXO66UVCCtMx1qFexaRaJ0niMKKq91phfw0uiUhfJpoxtPZUM3/3bPrDkApm9oUoEsR7fp8pEA+umHj4AxzGBvh3gkpZ+zTCkpf9A91Ut9kbLycb9nHoKhP1Jm++I73nj/BYf4If6UxJlHMmIxxhrU4+5qY1Ew7ppr4j/hTxwKgQ544z2YDLiOsNvv/ycyexUqe/vQp2Ytr2aFxdzQsOSXYxcUYjnrHT37YHUG+i3825MEjg5oDd9MZlLZvAWgGOyR8jh6PGNuPWYyk3K3YRO0lOk1eP0Wa+ftjJ3VvEHerZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q11DmB8xxUkKhcZhEjM+JfnskUwB4yXjnVvoDkUmTpU=;
 b=Asa8HR9jweRUNl3ykUITvtRstw6ejR1aZF/ca6ncw2Ai6Po4k+4/a/JiZGtMngdihIPAudjvAjWDlXFk2kMXib1KsPZXv8qqIC0DuDnI4v1XvER89FvJTQtvC4zromyPuCN9wE1MTGKGj5Ewg0hGn8R0ukSxbFgvwTMPkNv9nYjL+DjAXZImyijqXdl5aL09kiOLFjQorRgUinhiCS8+JlLQy4oNr1vdy+TfL/1dhAOOVyzQ0Ou+8VpKtGDy7ZulPKaO1ht6B76n/X6wMDBfUfLZOAZ0jQbC4WPJ7Eu/6WKECGX9QhDakoXcWWL1ELq1hrSMxXdkMMh6kSL564v23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by BYAPR15MB2486.namprd15.prod.outlook.com (2603:10b6:a02:84::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 21:24:03 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3%7]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 21:24:03 +0000
Message-ID: <6a783eea-dd72-eb8c-7ce4-8dfb06bb1fa7@fb.com>
Date:   Fri, 26 Aug 2022 14:24:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v7 4/5] selftests/bpf: Test parameterized task
 BPF iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220826003712.2810158-1-kuifeng@fb.com>
 <20220826003712.2810158-5-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220826003712.2810158-5-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::12) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6ade350-e736-4bef-e4de-08da87a94cd2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2486:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npSbpDfisG2+7Kywo7hgZcld2+N5H0pN/S9ge4AHsFQtmj9CNFrtU1584wyJD6cWo3tYQ16TSsHozYbOtMK/75WClEV4XixGj/PsiIcBlTrWS+0qRxLZxDY30c8atwa2tMsIbZfL+xcbrzqdxLVL8ihrr9ShxeKaFxjnGNV4PR9sEuWjqMPVU/B80ZgSwdRAn0qEKx4ATmWPbHCiRbXYf6yFlqSK7IczHmNLnr0W21Shiyb+XIdUmO0NdR7l2HoA8jQb40WoxjJ+pbucxg+e43raYcixLKLq6zVVqbH5w11RrNLQMiAK8A/0VgKl0uTZ3alwk56pFjfXSmOnSWz/ln751TsQN4gdpmS/O8vUdqMEAWt0xR7mv8VJxIjN3YEq+HpeB4wB7ncQIGxYQzP+CAIy/qKa7WRkz7iJYRFMrw/T7eKvmBOn5qrMnXK5DQUArp+tidBmsD/1+5f1aRhMnS1juWLQQyd09mJPhoPuTxBPPSVi0TwqBrszlK05NepWxgJMXebZqtqMfoYEgrIT/xocxK5Y/F41BJSU3WyXkIqDj70ZneOrW5lzPA236Y34CDAiT6oAuHaddlJXijQDk17S3+VWTTfdds5XCarZu+lP5fwE/CuPdLFw0B1PAaLZfQoCvo2UoF8timjcdahdU6oYF1vQcdpJfvDEHjSr5COzj+vt0oz6TWOZuii1PGjMjNenllody081h2KjFzHe3O0/7JvvfSSswzqn38B2wBUjnb9RkgsLbElQeJsyHoXHncfxdL8UdL3ENPC89gEDi1h7LBHxiM+AQLD7oc/UwWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(186003)(6636002)(53546011)(2906002)(86362001)(6506007)(36756003)(31686004)(6512007)(316002)(5660300002)(66946007)(6486002)(4744005)(478600001)(2616005)(66476007)(66556008)(41300700001)(83380400001)(8676002)(31696002)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NExjdzV4b3NFM1RzRnhLNVdRL1JLcmNIYXQwUmUyTmFlNjljT2pPcFBaTjRT?=
 =?utf-8?B?Q1oyYlJWZkpQUzZIL2g5d3QxblgrRnB2WGhRNHlhUnZKYUlQZmpLNS9YU1R2?=
 =?utf-8?B?UzhKdjJQOFBwdXhFVVVJMDhJYldMLzdsRjFOZEZyRnRpWm1zUG5DWGIzM0xO?=
 =?utf-8?B?OWsrVHVqVkJkQWcxTkFPMXN6cUoyL0QrWVlMN1R0K1NwSEFueFNXMkxJMTBC?=
 =?utf-8?B?R1pDamthN2JKYkNqQVNyTFEvY3JvWmdZeTJJUjdrc2d4T04xTTRrR3FpNUdx?=
 =?utf-8?B?QXBhdm9TaUorMkZhenhZSUtQNFowQXVFelJzcWpHZ3M4NkowTHp0VlFjRFQ3?=
 =?utf-8?B?dEZzTDdzSHIxUERKck9COTRJVWRkbXBJekJydnR1WFowMkFQZlR2YXBsQnpk?=
 =?utf-8?B?K29wYml2YUNuRUw0UUxrSVJENEJVM0xIc2tYdUpqZWkxd04xNXo1Z29RNDVD?=
 =?utf-8?B?WTcyeVMrOEd2MTMxa000dEkrUVdGdW1WcFBoeFl3bVNOaFV0ZkFYTk5ybm1U?=
 =?utf-8?B?a3hITktqbEJ2RkVsSnZMbGZMMVdxcXh4c3ZyZmtndlBGbFhxYkhvYU9zMkox?=
 =?utf-8?B?aTNmbnVmUW1vMVNybERjSE1rd0lPL0V2WVE3aEZlZTBMM3o5dTFJbndzdXB1?=
 =?utf-8?B?TXdZQ1MxTlV1NWxqUUZiZWUwZjFtMDV5VXJkcVhrMDMySi9ySUVtRHBJTmdv?=
 =?utf-8?B?eUxWVXg0TlZ1MmFuYUFzMVJVRXFOak8wa2VLMnkwazhpN0drb2paeXRQd2Vo?=
 =?utf-8?B?akNiR0VTazFuSWF0eHF4L0U3TDcxZDdZN25seHlhS2x3ZDFONENkV1pjYTdL?=
 =?utf-8?B?K3dYQ0VyM3BEUmtrNllLaFgwRllJYk1SMlNYMW0xWHRVVVdRdXVjRExMWXNz?=
 =?utf-8?B?YWkrZlZoeXpkUzdSL1RoMjYzMG1Wa3g4RmVDamhuREhHZmVoeDhlZGRqYWo1?=
 =?utf-8?B?Q1J3bmdGLy90VnBIVWRjd3lic3A3YzFhT3BGNG4yWWlXaUk5YldYbDRUTWFn?=
 =?utf-8?B?aU94bzJKb2N1bkxVZXZnSTJON3FMUUZqeWROYWtwWVlRWlNicXlMNVQ0SElN?=
 =?utf-8?B?YlAwUGs2T3FYWDdBVVpydjBGUVF6MDJ0aTRtT3VwUmlJcERQd1ZSNTRSUlFl?=
 =?utf-8?B?ai9GQnIyaWhoMERCbktaZ0pKVTVzZWFYc1l1aWdtb3ZQUkI3ZWttc2hTUFFG?=
 =?utf-8?B?RWgrVjk3M3hqUjI3SzV2Vi91T1pOR0dLSmVRaXJ3N1JyenlXMkZubGRwSjZI?=
 =?utf-8?B?aCtmWWlaWVF4T29RUWV2am5uSXo2Q0U4Q3k1Q3kyL2VFejVIRmI5SUJYVWNW?=
 =?utf-8?B?RURZSms1aGUwcEoyNXhpb2tQQy9YN2pMRnJ3c3h6aGJscXVlUmNmNmN1RzlO?=
 =?utf-8?B?eU8zcW9WTEJpMHVyRTNHZ1pJblJlUEYyT0JvcVVtTUdBVW44SFVmRWdwdWdH?=
 =?utf-8?B?eGNZUTJzNityRFFnNXpyWTRhSEVmem5abld6TllvWjlwTjNWSzhvWFN4TUdG?=
 =?utf-8?B?WXBhcy9waDBaOW1RajNKSldiTjRGRFVYazF5RlFnWHU5YmpYZTFwcks5VUdv?=
 =?utf-8?B?V1llU09Tb2ZreGR3WVZrSGpUTVkwTEx2MzMzSWZaaHNYUE54STZ6ZGlJRUht?=
 =?utf-8?B?NzJQbXNZUXEvZnF3NThrUjBBc3U5V3ZuMW9HcVRHMENWMUZjeHFJdGZEQkZv?=
 =?utf-8?B?WEV0VXNoelFITHphS3loRXlyZC9jb1NRSWloN2lCeE1IMy84bFRKUUYxQlQ5?=
 =?utf-8?B?THhQSlVoNmtxNmlOQ2dxN1ViNkRHeDhwdHZQUDM1c0IzK1VhZldsVGNBT3Vq?=
 =?utf-8?B?MzhPME9ndDVqOE4yajg3Tit5UE9nMDlheTY0alYrcm9UVHFpRk9KSkluRzYy?=
 =?utf-8?B?T1d6RitldUREZWRwQjVkZHFYS3B2V3IvTER4Zk16RXdDZ2l6TW9LZlFYdm1Z?=
 =?utf-8?B?THVDeXVabG93RTA0a0lYTis5ZnkxdUJURXZkRUsyNGU2bTd0SXBpbzBDNnFL?=
 =?utf-8?B?UDVSU2wzTDMvTm56UUc5WXF4V1Q2Q1BRbUJxaTlZSVRYWURkdi9KeWlvZ09l?=
 =?utf-8?B?SlNRMHNpbzU3Q1lneWF3MlFzUk9vS2hjWHJHWDFPeDVWQURBekptMER0cCsw?=
 =?utf-8?B?a1hrU0xud1lxSHZzeTNaVDBNVkNXRTJ0ZXFvbStWZjhVa3VjSVpkL1FCMVUw?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ade350-e736-4bef-e4de-08da87a94cd2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 21:24:03.7271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /T5SV4B5DNaKk/wfyh7wIZRWgQHI6Apprj+2S+lXddRz4b2o6s11IhQdHwRffa/P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2486
X-Proofpoint-GUID: XLdAtkED0iYbcqsq9cAh4sPHSbB7FAmQ
X-Proofpoint-ORIG-GUID: XLdAtkED0iYbcqsq9cAh4sPHSbB7FAmQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_12,2022-08-25_01,2022-06-22_01
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



On 8/25/22 5:37 PM, Kui-Feng Lee wrote:
> Test iterators of vma, files, and tasks of tasks.

'tasks of tasks' is confusing.
I guess you mean:
   Test iterators of (1). vma, files and tasks of a process,
   (2). vma, files of a task, and (3). a single task.
?

> 
> Ensure the API works appropriately to visit all tasks,
> tasks in a process, or a particular task.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>   .../selftests/bpf/prog_tests/bpf_iter.c       | 282 ++++++++++++++++--
>   .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
>   .../selftests/bpf/progs/bpf_iter_task.c       |   9 +
>   .../selftests/bpf/progs/bpf_iter_task_file.c  |   9 +-
>   .../selftests/bpf/progs/bpf_iter_task_vma.c   |   7 +-
>   .../selftests/bpf/progs/bpf_iter_vma_offset.c |  37 +++
>   6 files changed, 322 insertions(+), 24 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c
> 
[...]
