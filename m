Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590C84E7DDA
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 01:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiCYTnh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 15:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiCYTnZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 15:43:25 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352353E3F25;
        Fri, 25 Mar 2022 12:16:49 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22PJ7gV2010494;
        Fri, 25 Mar 2022 12:16:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qAvqffvtGnWU9AV6nsDUhuJRZepit5OySr5jE6XAmXM=;
 b=BhsuXivFNnS+V0sdvKTb03R7lfdDg6ZBe48PVa6YlmAio4Lyr8+Z0axE808uNsmvzGjK
 C0pNiwJJEuTFqGkm3xgugDFUy4XCg1yqOH0NbiLSQCq9fq1Ex+MLqWZZzz44LobrHhYC
 ls9bFqUkt3X9VOk/l7NpqxVOuonEUO2+dxU= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f1km4023m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 12:16:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTT8zCKxD+sZlYQoc703xmnJIi5vbk9OSYFXYqx9zusq1mRJYRc6YtElvyGSkjPwaN0mESdxssPAa8bFU09PUxvDwrzJuM16eszrpcrWKd78+RMj+LqRMO0cIFJV67ysUFqn5crXSygwWcISQSEsDaEHhz5TkDbXIFL+WUjH1VXthl76mty3KxdY0Xu4jqs5qcmoCoVgvw1FTlb1zGVLTvBK/Dmn/5jQHX5gAVwo7DBcn3zTA3NifTqisM2W9U0FqKeAHVb/tYOJ+b/5HuQj5Zf9X0Qmp+4Sxn2FmRfCknzeewrXyEIWxkIhJQenZFrGOcDYAEBvBDewP0GLjN131w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAvqffvtGnWU9AV6nsDUhuJRZepit5OySr5jE6XAmXM=;
 b=LZrJEu85EYrp2NzgHZy9eU+Hp6IK4XLBVwTXnCN14WZt1C1yjPzs9ItV+n1923qRshOzOC4+/ghAGgkU7/hwsvwqPWhZ7k5eiF7w7qAMD3yYBcuSvTL/ynPPpmhLBE8V0CeUFpOJVI1bjD3fbE7393yZAkfru/ehLfHxKbpU251kOHdO2GHgmWrPQClVq0VsynAotXiY2ZBulu7zr0Lz4DeSDGUwFqZ+rFaYaoHWKa5nYMypwhkbxTIqygEMvcRhrs1ToVlP9Yj1UfuCqSjI/iG0umsCmac9iMX7YAhyrZiUuBwvjq0DQXJQ9QXLJkI5UfFUAllsBqDNha4SGpARgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB3080.namprd15.prod.outlook.com (2603:10b6:a03:ff::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 19:16:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2%7]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 19:16:31 +0000
Message-ID: <9cdf860d-8370-95b5-1688-af03265cc874@fb.com>
Date:   Fri, 25 Mar 2022 12:16:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC bpf-next 0/2] Mmapable task local storage.
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220324234123.1608337-1-haoluo@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220324234123.1608337-1-haoluo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:303:b9::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a678a68-66ba-404d-f065-08da0e93f85e
X-MS-TrafficTypeDiagnostic: BYAPR15MB3080:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB308095948098A9A657342AD6D31A9@BYAPR15MB3080.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wiDmYoj6porna1s+DjV6aKN7yXXsSZT9NPQmR3r2L+Wu/y6pe6G8W3j1taqUGXWMAQ1ucR/T60I1Zt6BLYIy9DrU+YJxGfgmwb+fgmx/yAM75sONUxm5esTYEuQmlvEswowqUMiLG+M4089nb/vhpDZLYp6K5UZLrsIX0RzZV3JuA5SvjJzcqtp/6lwC90CcfKW7BjlAEhAjQi+/3RKt1UfGRBeCHyctAPiXFEMw31P0TkhbXEfx50agQvkD8Jbh1ggADTZHX4828R1Jd0Usu2oULeILj7dQXiUEEQUZU8JVUwUhWLPt4HvC/BD9B0izw3MEGnDaD8Vtj7l7pj1ECAOyAADaPjiTZHdWpjSok3d3voYYV10Fu1Tmp3nNu5xOBQAe6CIGFk+7NlKodR6RpU37gwa8KjqFr+lyk0rIhOkh/ECgPmqtpA42CMx1LvBmjErkUYTGBhV5gzOCw3jbf2bMEjTpVZL/VMnBldfBMzVVZB6/Tt6BluIT2PxGJ/fOXlTWuf+duJMkLFpyx3yRrbObqchdMeQRIA6sT5JG/acr1/LwUTrOQyLw2fFm31dOHdRaQRyVvg1xmbVm/RVWiOSLmWRRc2BB8TYSi++xE7R6hcW3Fg2as0Ll996Yvh9Ry8kDXaHUkiuXBqgPvWYb9T4OQSfXGoXlXMw0Itva5qljaQADQ/R3evehcgjdtPpZkY0/yLTdDxf9/pTqbRQwJyiM5NIsvmghnu6xUKJuDsg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(31696002)(66946007)(2906002)(31686004)(508600001)(186003)(36756003)(6506007)(53546011)(52116002)(83380400001)(6486002)(38100700002)(8676002)(86362001)(4326008)(66476007)(8936002)(5660300002)(6512007)(316002)(54906003)(66556008)(110136005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmZ2M3ROSUhsUUF4TjV4d09sQUFZRWJ5d3ZLVFVtK2FkbVIwWk13RkQ1ZHNO?=
 =?utf-8?B?NDk2Z2I2SXJFQU9TdmdLc1lnTytHNHZuY3hmekZPcnQvc3lFdnVVV1pRRTFZ?=
 =?utf-8?B?NzVLMGplNDlEQ3IxNys2Tm5YelVhVERIUEI0NUR2bXdOOUxMS3BpUFd1Zjdq?=
 =?utf-8?B?dS8rb2l0VjA4RVhpbk8vUGxaRUE3Y0hIdG82YTQ3aHd6M1IrTldEVmZFWXdN?=
 =?utf-8?B?RVJZZU9KWTA2bmpQdjZ2SVNJN2FlUDY2ZThHNmtxT3FYV3NyQ0VxSlBrOXZ6?=
 =?utf-8?B?MEhrMlNBWjdZQy9EdDFWWnFRa3lRK1lmaFc0dmE3UEZTMTlzYmJGL3g0bmh5?=
 =?utf-8?B?QUVIV21UV2NQTmVrbFdnbDJsNnBySFdJMklPL3hyRFhxUDB2eWFzbUUzcDAx?=
 =?utf-8?B?SGFGZXU1emhCNHhPLzdrU3Y0eUpJS3diT3dDdDRvOHZlaGJTaGJRQkdmZm5I?=
 =?utf-8?B?U0dza3VZN2U3aWVKQVJTV0NnUmFra2RRQTlpQjFxa2IwakFwSERYSXFXNTJx?=
 =?utf-8?B?YktWK3p2bXA4elh5eExBTmFXY3Fsb0VLemd6QWNRcDJPQlN1dnl0THpqMjB0?=
 =?utf-8?B?YlV3T2FrTWFLRFduWDZiclExKzQrb1BPeTN2Q3ZvZnZiOTFFWFhZVDhCTGNZ?=
 =?utf-8?B?R1Z0WFJuSFRUTC95cHhMWlZDRDh4eVovWUE4UXcvV2E2ZWxRM3BCemgyM1Ry?=
 =?utf-8?B?RFJ6VTZnWFd6RUVkdmtiOERka0N2RFNtenpHc0czMWtvY0FxYzB3MjZkdUFN?=
 =?utf-8?B?T0hPV1h2bzdGL0ZXKy9mUzNMRnFjV3dmdmtzdmdtZFQvTklHQkcxNFRZV2Fa?=
 =?utf-8?B?dEoxaENiVjR0OXF3RU5uZFB2ZmlMSGhBYVR2ZjNxTGF1TnNTSGVVQzZFamZO?=
 =?utf-8?B?L2kvSGRJQjRBOGhwNytqeHcxOTg5eFFUd2dmdXRTWFhHMXAxdnJmT2J6eE5T?=
 =?utf-8?B?WkswUFJSakNkdVZVbTNSQ1pqYW9NcUt2ZzkrRHZGSTBUeUNueHNtY0FXbjVP?=
 =?utf-8?B?UUxORi9ORUVYRW93dHloVVZyb09PaVZQZUJYNkovZVhmbWo0Q1Y2U1hoU1Ns?=
 =?utf-8?B?MmhZVHYxN080ayt5NzFIUS82NE50T3l5NzVXNUdkMjBvUko3TWlZODJkM0cx?=
 =?utf-8?B?d3VMaVBEZEZhc1RkdzJiMGVaK1ZLeW5aZUJSdTNoQ0dGUDhPMzIrNlR4K3I5?=
 =?utf-8?B?Mi92VGFvWHNqeTM5Vmx6eEJhOXFHNFBlMGpaYkxDVjJIZ1Z1MEc3ZExEekdw?=
 =?utf-8?B?T2NsYkN4L210cEpwcnpJL1Q0U21PajhVbXZxb0hGYlljNVJBOFhyMDc2NUk1?=
 =?utf-8?B?RHdIMXNRZzQwbmgwWFp1QWNveS9HTUtuSmM3Wnp4OXNwZWRkN01YQ3RrcUts?=
 =?utf-8?B?dUpmWmZjUGFiMUIzNjBLTDBxQm0wZUZENWdVaFVrdlJRYnBtb2llc0lndnND?=
 =?utf-8?B?MnBrTmI2eFBEdXJnZ2NhNWF0cU9OZVpwRGNKVVdHVHhVeVBMZXdzdWNPanEr?=
 =?utf-8?B?bGZtRGN1VDNNTnp6V3ROU0VhTFN4VDQzYWNnQ0NKUDEzTGV1SU4zbzhVZ3Aw?=
 =?utf-8?B?MVBNQmwvRjYycWw5TzhiRlNlMEVseDhYa2JaaWNkWlg0YjU4T3RJRXhGN1pu?=
 =?utf-8?B?RWswWGlUL2R1MHBvZlA0bE5TNVBtbkNlVjNqbGFZMzFiQ0orL2IzVFd4Ni9N?=
 =?utf-8?B?am5uWmVWS2d5aDZKQnBhZDlMeXcxaVhqTlU5anlHRDB4M0JINmVKSHVVb1VS?=
 =?utf-8?B?V25Kb0hxYXVvRWlZN2YyU3dMdU03VGRrQUY3aGlIY2o3YVpPQWRmM0hWTHlW?=
 =?utf-8?B?aGNvYkJla3FpVjllYVlBK0kwdzlCMGhIdDV2Sk5UcTBEU1NtWTA3N2pCV01U?=
 =?utf-8?B?eWxsTWllRTJJTEFyM2V1NWJwZjBkN3lSdTNhNWNjZEMwWm4yWGlQYjVTeUJP?=
 =?utf-8?B?TmJ2ZmRZM3NlZVY5R2NGc09Kb05zS0VaWWZCanVnTm0ydmxxYmZucklQdXRI?=
 =?utf-8?B?c3M2bTdMdW5nPT0=?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a678a68-66ba-404d-f065-08da0e93f85e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 19:16:31.7393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDcRNy3Zcg1XduGEnFYZJn78nswUVOLFDxlBFBGeyA/wrsmoCd9/wNfE2zmcqwAM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3080
X-Proofpoint-GUID: -P_-_O-_OMKTHAwxQ2qA-oXHHxcCQb__
X-Proofpoint-ORIG-GUID: -P_-_O-_OMKTHAwxQ2qA-oXHHxcCQb__
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_06,2022-03-24_01,2022-02-23_01
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



On 3/24/22 4:41 PM, Hao Luo wrote:
> Some map types support mmap operation, which allows userspace to
> communicate with BPF programs directly. Currently only arraymap
> and ringbuf have mmap implemented.
> 
> However, in some use cases, when multiple program instances can
> run concurrently, global mmapable memory can cause race. In that
> case, userspace needs to provide necessary synchronizations to
> coordinate the usage of mapped global data. This can be a source
> of bottleneck.

I can see your use case here. Each calling process can get the
corresponding bpf program task local storage data through
mmap interface. As you mentioned, there is a tradeoff
between more memory vs. non-global synchronization.

I am thinking that another bpf_iter approach can retrieve
the similar result. We could implement a bpf_iter
for task local storage map, optionally it can provide
a tid to retrieve the data for that particular tid.
This way, user space needs an explicit syscall, but
does not need to allocate more memory than necessary.

WDYT?

> 
> It would be great to have a mmapable local storage in that case.
> This patch adds that.
> 
> Mmap isn't BPF syscall, so unpriv users can also use it to
> interact with maps.
> 
> Currently the only way of allocating mmapable map area is using
> vmalloc() and it's only used at map allocation time. Vmalloc()
> may sleep, therefore it's not suitable for maps that may allocate
> memory in an atomic context such as local storage. Local storage
> uses kmalloc() with GFP_ATOMIC, which doesn't sleep. This patch
> uses kmalloc() with GFP_ATOMIC as well for mmapable map area.
> 
> Allocating mmapable memory has requirment on page alignment. So we
> have to deliberately allocate more memory than necessary to obtain
> an address that has sdata->data aligned at page boundary. The
> calculations for mmapable allocation size, and the actual
> allocation/deallocation are packaged in three functions:
> 
>   - bpf_map_mmapable_alloc_size()
>   - bpf_map_mmapable_kzalloc()
>   - bpf_map_mmapable_kfree()
> 
> BPF local storage uses them to provide generic mmap API:
> 
>   - bpf_local_storage_mmap()
> 
> And task local storage adds the mmap callback:
> 
>   - task_storage_map_mmap()
> 
> When application calls mmap on a task local storage, it gets its
> own local storage.
> 
> Overall, mmapable local storage trades off memory with flexibility
> and efficiency. It brings memory fragmentation but can make programs
> stateless. Therefore useful in some cases.
> 
> Hao Luo (2):
>    bpf: Mmapable local storage.
>    selftests/bpf: Test mmapable task local storage.
> 
>   include/linux/bpf.h                           |  4 +
>   include/linux/bpf_local_storage.h             |  5 +-
>   kernel/bpf/bpf_local_storage.c                | 73 +++++++++++++++++--
>   kernel/bpf/bpf_task_storage.c                 | 40 ++++++++++
>   kernel/bpf/syscall.c                          | 67 +++++++++++++++++
>   .../bpf/prog_tests/task_local_storage.c       | 38 ++++++++++
>   .../bpf/progs/task_local_storage_mmapable.c   | 38 ++++++++++
>   7 files changed, 257 insertions(+), 8 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/task_local_storage_mmapable.c
> 
