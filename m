Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F5662E990
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 00:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiKQX2L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 18:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbiKQX2J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 18:28:09 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98796266C
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 15:28:08 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHMbIhY028549;
        Thu, 17 Nov 2022 15:27:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=xSws7b3/kWsm/Ztrw9Iz1mHE6S+LiVoSAXWzvKGbQ+c=;
 b=T1CRl8VGYeXEPV4gmJUgVhUBqUtBOb0MjiFNqSNeg+ctIKfx2/8EXSY6attI8nS7xACZ
 fv04WeFj0+Ith4K/VZy0F5dQ1KAJ8haqRBMY/tL05WZ41gWRYpXgRs+RNkG0mYX7pAeT
 /LU/KMtioezfJwVlgXePiT41RZDwqNfZObcXAZKyQBTEJaWwOoaK4/+6vMwM8/QkY30O
 5V1h5DkMS0tHC5/M0ONjjQ+TvY9+4HBjVbX1Nj5vJTHeY8s6uzr3pbUO1OSNtQM4Hqdb
 bMYx/XH1ULbD/UyNN+3Hx1csfgU7pcP7DIeEPm1g4MgOyXL5WdQKtOvAQmzL2Xs1aagO lw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kwwwf0b4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 15:27:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbTDct+FSgwH98Xl+m47o2/pFB6YnpbBb0B5xDuqvRq/lICtOkD2YRhiUknqLbisGH7gTWpF3fEvaMiNmqLlTy8L4YPzb9GjTuvmV6TuiLIC4ZUL9kvPZf5u73Ux7RWVaAYV/b+eojHnbfAiQEancCShRzRZ3w9RpLOlm33ZJ8tlu4ReUhsUm9ETO+wjWhJt4qlzCaiI8wIWQG7d25WC4FVt/kRVFk37Vy3pdwpuvq2zg/LHUxc0zscZM7PG9yIq6AZ6+8FE5D5Fduj0r9e0h8BpLGL/R1pTnzUaF5a+JJdY7//nQ8KZZ4ojQetWCfxmVvnY77e3fZZy5W+0OkdnTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSws7b3/kWsm/Ztrw9Iz1mHE6S+LiVoSAXWzvKGbQ+c=;
 b=EOlnATCq22hIl/ZZ69j1/Gl/DlVh/dJR6HoQHvS922DLH9CX8LUg0Z1bZQ+BJUq9N9yoOgcx2IBLqDYAZpvR4PBGUO8vuGMiPRtuVI8dOjgqD8D9D7FX6M6f2fscBkp5slOBi1ynqDv2wB6jIXe3qqip4eHcJnLR1d7damufomS2gdiqrQE/tbEsoYnhEcDnJXPW46gBp37mrUdQfYjWhnVv/7+2asnvHgzobF0J8UyuaqbXy/KxBr/quNUM1SRBXe9V6mpI8UqFLbqmSXSJd/gmyoRRwT/i6bkGA9ECHtYeCP2ySrFqI/vAcVAv4rVBR4YmrFGfUa/Y1YRMrn2hGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM5PR15MB1243.namprd15.prod.outlook.com (2603:10b6:3:b3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.16; Thu, 17 Nov 2022 23:27:52 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::fc34:c193:75d9:101c]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::fc34:c193:75d9:101c%4]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 23:27:52 +0000
Message-ID: <e3b2d51e-22ae-b6b3-b618-b410dbdf89ce@meta.com>
Date:   Thu, 17 Nov 2022 18:27:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v9 22/23] selftests/bpf: Add BPF linked list API
 tests
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221117225510.1676785-1-memxor@gmail.com>
 <20221117225510.1676785-23-memxor@gmail.com>
 <CAADnVQKHibbQUNkwvd0g3YDK8n7k6g21=_TFd1=ccRFYJWrsOA@mail.gmail.com>
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <CAADnVQKHibbQUNkwvd0g3YDK8n7k6g21=_TFd1=ccRFYJWrsOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0107.namprd02.prod.outlook.com
 (2603:10b6:208:51::48) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|DM5PR15MB1243:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e251a1-54d2-48c1-9879-08dac8f358ef
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vB1PlyJWdodZ5tidVacPlAq+P/PwzY5P8tnmsNFVBzcwY9m6EF1EXH1then11wsWDbE08nZNuKR0rDwMvvhXLTY8KuyY3UpEHA+1Jt7sGJQzkghz3305auZVxWmiwN3TF2SzPGP2+zO3Stxo6jtA9xLv32vc8/Tog8zp6q1ZoJb8w77SHH2oAfc5R+yzvP48aySFaKUvEzpJgUXBYGgNELU4a12pNVIsnUAREwOvP6bMULbYMx61ST2qjaIDZI3pBj+/EpsSElS307VSJQcHxfkDx3mnJ7ZkzooWa5GCZSt3sMJzNiaoUvUNurjS+mKsTD6o8M/0vsSBqBLpNm20Piu9E9gOZAYS8gK+3CZF+5K739/g2eoXsvV1kZ4rOb08Ni7CwPQvKZWLpp6nQwidUrA9sd7TewWpRB6ljoRpKzHwBPa6kmBdRNFp/wAU1X5mjY1LMawONzY46m5+iBxjS25QdR1XHPnQmW+8VmE81KkYW1mMPDmpi4e9Mlmp18eqqukkz8xD/LLxJzI4gGxiN+PfltKmhgsQsYH/Er1NhBXdKn+pak/1fSSzdI4qac2khWWjDDb7j8oCosivjN7GMrpK8SB1aHaC0DPb+WBPV84GIk3ExM01PjPbaXnVlWh/M41tEaJbQmJvt3edpWyvDoDPRk2Gk6I9Gy1dZqWPPWgPj06AtAxeP3H2HZCuVwhtnyRc4pLxSwIhWsNSelJL5KS1Ih1fHREPl8UPWXhbw8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(31686004)(2906002)(83380400001)(36756003)(41300700001)(2616005)(8936002)(86362001)(31696002)(38100700002)(6512007)(6506007)(53546011)(54906003)(110136005)(186003)(5660300002)(8676002)(66476007)(4326008)(66946007)(66556008)(316002)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3hIODVHR1RsdnpwU3BGaWZyR3RYdkV6TWNGYVdBQm81TEhOVzZIV2U1Nmsz?=
 =?utf-8?B?Q24rR2p2cVpQQTArcTFzcnNvdHF6WGo0cmNxMFFobnY3eFl2cStyV2kxZ0d3?=
 =?utf-8?B?dlpHTS9DUVhQWjBkYkppekRNZjlNQjJjZU5TL0xPZjh6MSt1eUNxODYrM1pq?=
 =?utf-8?B?OXNucGFGMTNQUnY4dTZuQjMyMmxEUEM5ZkhsV3g3bVlUbGlxQXJVSVo5WTUv?=
 =?utf-8?B?Q3laZ1JoWEg0SEFEVEYvcmxhQmtSQmdoK1RnN1MyVFRwMXFBcDJuckx5Ykhh?=
 =?utf-8?B?N0pZWnBPOENtTFVvN2xnU0RtSXA3ZzN6c0UyWXpEQzh0TXVWdk53YlREZ0ZP?=
 =?utf-8?B?Q01XTkNmb1RjRkJaWHd4cENVNTE0c1FpSzFvZUZuYno0TXRxUUhsTnhMa3FW?=
 =?utf-8?B?K2gvQnJMU3hJRFh3QUhNa0hnMTlFSW1oVHNXVzUwRFVZSTJvMC9pUkVhcEFC?=
 =?utf-8?B?WURZWW9wMS9qOTZ3b1NnQTFpSFE2VmgxSjFvTFVCSHpEVmdSVjBGMFNEZzhX?=
 =?utf-8?B?L25wODNQVTlIaTBhaVNBTnBWY09tb2cydWpyNE14TEUva2o3emRIODRJTk9K?=
 =?utf-8?B?MC9NQXB6VTRWMHpKbGVDRU5jdHFONVd2c3IrcGExYmxmcTROcHhaclRrMUUy?=
 =?utf-8?B?RXViQXpsN08xSExIcHN4aFBKKzdtUVRpcjFaaDY4azc4MWJkTll3NFl5U0Y5?=
 =?utf-8?B?SnVNSFF6ODcwTW5aN1pWY2lpMUxuM1V2VUtsWEMyamorOWRpcnpVTUJ3M1ox?=
 =?utf-8?B?R1ZGTUhQTEN0M2ZrV0FIYU1oQTEvdXR1cGV3bFhlaHM5SXU0M1F5V2doOE1Q?=
 =?utf-8?B?dzdKeXhaSjBRbnpQVFp4SUVSTmdvZVYya05TbS8yaFFEa2ZmYy9YTUJmOWVW?=
 =?utf-8?B?emZVR29YY1I4YWJjS2s5bnFnK1ZWOEdrMjRtVWN2bkxqWWNaRXhSM2lqUzkx?=
 =?utf-8?B?UjhBMWFuTnZWVnNGSG1DY0ZRVDkydUw4ZnZCM1RENnkyMHQ3dDJUVHFzZGg1?=
 =?utf-8?B?ZDFKaGMrZElPQndldzl5VVdCTzB3NEtrSkJISVZVdGRJbFlaNnN1eWpyODdG?=
 =?utf-8?B?VnJNL1lLN0Y2OVVBMDBaWVQvaUlNQkMrOWQvYlF2elIwYW94MnhYZmxLMGtL?=
 =?utf-8?B?Y1lBZFJHQkI0ZVh1a3kra21pYmxWdEdCWEpudElHa25QM1RSazR3UlI2cVVE?=
 =?utf-8?B?cVNWK0xtOTNkS1Bnbyt2T1hpYXExOENvb01YVDlFRnkza2t2ZnBpTE53Si9Z?=
 =?utf-8?B?VXF0eWtMVHk3OThQQjB2NWZGdXp4TlQrc001QzBOMi9QbERtMlZEa2M2bWxG?=
 =?utf-8?B?YnRaL2pJdlpsYlJTWEE4anR5VU1ueVl0NFV3eHJmSy9XUFVWR3FOZjZXUlU4?=
 =?utf-8?B?aU52Z0FoUUtVOXR6TWV4UTJ4dDZSSEFEbUppUllZeGU3SkxjOXI1R2drL3VR?=
 =?utf-8?B?TE5ZaHFnVkdDT2M2eW1SbHg1alVRSXN2N1R5YUpiRmozSDAvdlBEbEx2Q1li?=
 =?utf-8?B?eU5qQTZ1ZW9sclRjYTUycXRNdTZMbXlYaFFUVHdHSk45b2xmTDEzRkZjWDJN?=
 =?utf-8?B?d0IvUjl6THc3TjZUbXlwdTZxNXBzTWNMVlhwK1JwQTdNVE1jczd0eDA5VGh2?=
 =?utf-8?B?T0p2S0hWL29TZktKUXRhT2IvK1EydVlLK0hHNXg1RTVaTzZacERhaFFSNDg2?=
 =?utf-8?B?Q2hJR1ZBOVZIaGRrb043aFBiMFIyVzFpb000M28zODZUZ0h1T0FFMGF0dHVi?=
 =?utf-8?B?VUxScUI0cXdFYkxXczZKMms5d2FNaFJaTXlqZ1RqYjNBdXN2Q2wrTjFJK1Bs?=
 =?utf-8?B?YVlhWk5wLzFGcHBCMW9jTWVTMll2bzE0NHVpOEV1NkhrN05yTGMvdmxlY0d0?=
 =?utf-8?B?akJtUHp4OTZXRDJXcEpzNWx5WEo5cVBmUlVpUWFUZGFrVDRZbERnNTNMZHdK?=
 =?utf-8?B?RGo2VTZBaWZCVThwei91SWN0czZJRGtseVBYVytGbTdPeTJuYVdlN3g0NGFr?=
 =?utf-8?B?bEVQNUxkTzdtN2taWm5ySEQrOHZ5eHc3Z1oyTE84OENmMW9aK0tvV3p6U2RZ?=
 =?utf-8?B?Z2hrOURHSVlWYWV2TGEySmI4RVExREZtbVJYM0JyY3VXZlJTZkhxbnVtbnhX?=
 =?utf-8?B?SWFwUkVUSDRUOWd6anhGWHVvNkRtREhxRFdiMWhka0J6YmdqS3lzbmNvMGFi?=
 =?utf-8?Q?soVRo/FJTpIYeyNwZOJ87bo=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e251a1-54d2-48c1-9879-08dac8f358ef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 23:27:52.2301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHe1UvSFBd3ZCZJJDCOLgWZY8eVdEm8LHcvf+YNlmSDzD9T5rnaxQLU3N0m4H5lnVlxaPZpoUMKeYtRQRj5wKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1243
X-Proofpoint-ORIG-GUID: TMLSGewBkNvKtumrW7R5_i9YUp7edM52
X-Proofpoint-GUID: TMLSGewBkNvKtumrW7R5_i9YUp7edM52
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/17/22 6:05 PM, Alexei Starovoitov wrote:
> On Thu, Nov 17, 2022 at 2:56 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>>
>> Include various tests covering the success and failure cases. Also, run
>> the success cases at runtime to verify correctness of linked list
>> manipulation routines, in addition to ensuring successful verification.
>>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---

[...]

>> diff --git a/tools/testing/selftests/bpf/progs/linked_list.h b/tools/testing/selftests/bpf/progs/linked_list.h
>> new file mode 100644
>> index 000000000000..8db80ed64db1
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/linked_list.h
>> @@ -0,0 +1,56 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#ifndef LINKED_LIST_H
>> +#define LINKED_LIST_H
>> +
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_experimental.h"
>> +
>> +struct bar {
>> +       struct bpf_list_node node;
>> +       int data;
>> +};
>> +
>> +struct foo {
>> +       struct bpf_list_node node;
>> +       struct bpf_list_head head __contains(bar, node);
>> +       struct bpf_spin_lock lock;
>> +       int data;
>> +       struct bpf_list_node node2;
>> +};
>> +
>> +struct map_value {
>> +       struct bpf_spin_lock lock;
>> +       int data;
>> +       struct bpf_list_head head __contains(foo, node);
>> +};
>> +
>> +struct array_map {
>> +       __uint(type, BPF_MAP_TYPE_ARRAY);
>> +       __type(key, int);
>> +       __type(value, struct map_value);
>> +       __uint(max_entries, 1);
>> +};
>> +
>> +struct array_map array_map SEC(".maps");
>> +struct array_map inner_map SEC(".maps");
>> +
>> +struct {
>> +       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
>> +       __uint(max_entries, 1);
>> +       __type(key, int);
>> +       __type(value, int);
>> +       __array(values, struct array_map);
>> +} map_of_maps SEC(".maps") = {
>> +       .values = {
>> +               [0] = &inner_map,
>> +       },
>> +};
>> +
>> +#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
>> +
>> +private(A) struct bpf_spin_lock glock;
>> +private(A) struct bpf_list_head ghead __contains(foo, node);
>> +private(B) struct bpf_spin_lock glock2;
> 
> The latest llvm crashes with a bug here:
> 
> fatal error: error in backend: unable to write nop sequence of 4 bytes
> 
> Please see BPF CI.
> 
> So far I wasn't able to find a manual workaround :(
> Please give it a shot too.
> 
> Or disable the test for this case for now?

I noticed this in an earlier version of the series.
Will be submitting a fix to LLVM upstream today.

Until that's settled, reverting commit 463da422f019 ("MC: make section classification a bit more thorough")
in LLVM will fix the issue.
