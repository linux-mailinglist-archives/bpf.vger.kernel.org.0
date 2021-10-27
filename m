Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9690343C0CA
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 05:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbhJ0Dhg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 23:37:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44526 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230522AbhJ0Dhf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Oct 2021 23:37:35 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QN0wAK030529;
        Tue, 26 Oct 2021 20:35:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lIJVB8uY1hMnYy5uom2rluWzp4A9oIhgZzreMp+rAoI=;
 b=Ze7tsbs5SOX2p3NZAyBlbu/VLQnFLz0RqTfycxLK8tH2gWNxLazgp1eQKxcIIbasQ0sy
 zd4AvY95Z2ZaFwp6y/2o04CQnoxR3wlk8+OqHlUvIZ+yAzuo4vtAYvgFn1oGwsaGOve3
 FQeY1RKz8yMem7G9IVhaFUseC4oRjeqaKfI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bxkx5mtua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Oct 2021 20:35:10 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 26 Oct 2021 20:35:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUP2rPm55H5HXUjit5kYt5RoezawkqG8iFiA7bg92AniOC1g2KuwXRrH8EunKx4H3jHRXraRvYaUhzE3AxCyq6lztrEJHAGM2rw5XmkXnUpCfJuWRv2S+biWA50us3JHUmEBFB7L80OrJksmMBD5FYY+C/5apBUqh+PIfqDy0zau+QwDiSVxCS3mnGvpnRySAnV2/+OllBRyRnipjP9qfikNEkJ5Fa7wKAIrLaLjmaXSmqGkum7anJUGv3KcgHJ1zqSXnw5j1xFQYOhBanqzLF6DmjyEzOEjtnfPlNtxM1YGPVXzxqXnKNxk3VglaJQIo3svJ6lYHHPLU0Is5h+T/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIJVB8uY1hMnYy5uom2rluWzp4A9oIhgZzreMp+rAoI=;
 b=VwvK/9SLWU8cHcLyR743xvLusVln7qXAdcez9W8EmQhp0pABPCb2eQ54AbjCUn8bVQ+YVAO0iKlzxRlBXHnjQb2raDMbJ8Qtsa8QYlLbEQvFpo3R64RyK0c0MWBBdFisyM4lObkDiKpy7i2Mj2gJvdwGs+9cJoRTlE8ySQMF5zgXSqPh60hc+DB1cghaXgmhhabQER2BHwgoCiKkpgnwZwViWeY70BvRdZ5KhmjUP6Rlqgg3HhSDfh5GH0/NIHOy6pGjkvmXGgovyQFKmVBGvtagW5lGoyb8RojS+5J2f9y3p0ECiTq0gvG7MfNOFsfieibKEZyW20ADLXPuxf/2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from MW3PR15MB3980.namprd15.prod.outlook.com (2603:10b6:303:48::23)
 by MWHPR15MB1597.namprd15.prod.outlook.com (2603:10b6:300:bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 03:35:07 +0000
Received: from MW3PR15MB3980.namprd15.prod.outlook.com
 ([fe80::517a:2932:62df:1075]) by MW3PR15MB3980.namprd15.prod.outlook.com
 ([fe80::517a:2932:62df:1075%3]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 03:35:07 +0000
Subject: Re: [PATCH v5 bpf-next 3/5] selftests/bpf: Add bloom filter map test
 cases
To:     Joanne Koong <joannekoong@fb.com>, <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, <andrii@kernel.org>
References: <20211022220249.2040337-1-joannekoong@fb.com>
 <20211022220249.2040337-4-joannekoong@fb.com>
From:   Andrii Nakryiko <andriin@fb.com>
Message-ID: <003cb6df-a076-16ef-832a-dbb140a063a1@fb.com>
Date:   Tue, 26 Oct 2021 20:35:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211022220249.2040337-4-joannekoong@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR04CA0388.namprd04.prod.outlook.com
 (2603:10b6:303:81::33) To MW3PR15MB3980.namprd15.prod.outlook.com
 (2603:10b6:303:48::23)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:2103:b2:4e6a:72dd:1ddf] (2620:10d:c090:400::5:8f40) by MW4PR04CA0388.namprd04.prod.outlook.com (2603:10b6:303:81::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 03:35:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5696c05b-9afd-4814-d5cb-08d998fac5a7
X-MS-TrafficTypeDiagnostic: MWHPR15MB1597:
X-Microsoft-Antispam-PRVS: <MWHPR15MB1597D481A52160EE07E32BC4C6859@MWHPR15MB1597.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isNCtwM2d1Cg4MkgEpDBOU56+b0cWl0FdJ1Lk2mAU9emfE6DpvLD5mi2ImFDyGmdiEPXzIIigvkbAdd/0UzZ3EV2UQq7JLQBPfnS/+2XxOyMAB+4567S51XxhoI4cH4PG7A+JE4zeEBJa/YTIS/zumRi5h6JmNg/+hD7IlX8T6m8t06hunsdlnK5BItkCrjHYgx5zIewUOsosC/79T+vwxefrCF6/WOgchW3mxmumE73LnJQB+MDkRg2dx386J3UgfTDXR/bC7kk8ndt8oqmUU4FRsmpMLvFjNFCPcGQp2N+jzDL6IZ/hv33MGxBImgmPcEzoChXq+YefmYMEAqCvJPRjjeG/SgUBA7JT3+MVmd6kIJku7PJoPGc19yHz3d+wQO1Wy/s8325B2+lITIBTgZcRsIg/GDmJWShDD48RIJeILmtJKGDqY6GX5F2ANINY8OYYTLqaXv5jZetdHAAzHAe3GDk+2IKe6pCivJ7fuR3ZTRorK8f67BHgYmWbAcoK/lYXeyOHvTHF88zexlIuV7JqSejiMsq4/sf1S1cgLcGLryEg8l/7SGH4ZWgHGjHT1nIkKzXB7pGjhyUApSDoh16K5hk6eltDyeuYjyUFgmHRBM1AySeIMNt2DecCCsfgktkFG993OXtyhPNoTLlG6x3oOS5es4Wv3FCAxgAdlp441q95bVMibiJmqGO7PNRM09CAShJQRh0kPmCriNg/iI//6AzhsF+wtVwZPlLunw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3980.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66476007)(31696002)(36756003)(53546011)(8676002)(66556008)(38100700002)(508600001)(186003)(2616005)(4326008)(6486002)(5660300002)(8936002)(316002)(2906002)(83380400001)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OExXb01xellsM1ZMMzEwZ2lzMi9wZmlCRTh2OWdicHBWUnFGUUk2M1Zid0l3?=
 =?utf-8?B?Q3NuZXpCSm4rTWQ2MVRSL01nM1lONkc0dk9jNkRSejhHOEZxVFFiZWVSTUdL?=
 =?utf-8?B?R0RVSDBKQVNoT3hYR3EwR2tMRk5HeE8vcUtieU1OZ0JIb1FrNnBVNzNPUkx4?=
 =?utf-8?B?aHpTSjk4Tkx1TUl1VnpwSWhjOHNSaFd2aHV1N1NMeFlzT3lVQ0xjenBza3Qr?=
 =?utf-8?B?ZElKZGllVmgxUkh6WW5Fb3ZnQit5TGl4Z3ZNRmg4bzdxRGwvMitTbms5RTd6?=
 =?utf-8?B?dHh2NWVtTmRGVXV1ZkN4enJseitUS1BZTXlENXBVTE1MRmd1NUlYZ2VCTlY2?=
 =?utf-8?B?VmRkRGtMZUF4eVJjZWFSc0Njd0xrZ0pRdEJEU0E5bTEvcyt5aEN1NTZJYis2?=
 =?utf-8?B?SG9uSGVMVitBK2RSRGdMVmU1cDlCdXJmMi9naHBZMzVZMDNBZWI4Y2pkK1NY?=
 =?utf-8?B?TjR2NGdlR2NKYmsybTl4TEJaV3ByM3c0Q05XbGxPdjRDNU1EQUswV2hXY2lY?=
 =?utf-8?B?OXhHcjVYalhrNkRpOEc2VjM0NVF4R095SFlvVG0xZGhISW9lN3NoTGRyOUF5?=
 =?utf-8?B?Sld2NkF0VjBBcEhmUG1FSUdRZ0ZDSVlCcGNJTGJjWEM2T3NRRmhUVHp5SDVV?=
 =?utf-8?B?SXdEZnBDUktjWWc0WnpNOUJENkFnZUFnandEbjI3M0RGZzFqVnJqK1pieDFI?=
 =?utf-8?B?dE5BbFpOUDloSU5EZ1FoeXl2enN5NVhNWHpnVHpoWXJBMHh1NXhoS1RGcjRq?=
 =?utf-8?B?bjNGWEphZXBoWHlnREJHR1lpbjNZSjNjV2hJK29nR3ovZ3ViNGJ1RjJUQ1Z4?=
 =?utf-8?B?Y0o4YUo2R000a2FyeUdNWmhqQnZscGE3VlNKdnl6ZFphM1piM0sxbHBibWpn?=
 =?utf-8?B?SU1zRG9aQ1Y4MnduMDdkK1FmQXkrcnhUVVFnbXJLa0l6czFpZUJTT2ZtMEQ4?=
 =?utf-8?B?T05LTzBIbjJzaWhvTFZwZjZQcmNweTVHME9xeVhHQmFWQ0xmTzczcXNJcmNv?=
 =?utf-8?B?MWZGdjliUlhWVk96ckUvQlZLNmVWT0RZUXVQTkZZN0V0aHZtUmN3aTRyN3RR?=
 =?utf-8?B?RFRmMmwweC9haStMVjZxWWZXU1g3SDlwTSt4TENpZlNoM28zVFJwOFh5SzdK?=
 =?utf-8?B?a0hwWDNiT0hoZ21VZ1g1ZzhtMU51Skk4dHBEbTdTRnpBci9EMTRod3hJVGlH?=
 =?utf-8?B?SUlYQ1Y0R0tLbXQvb3l1dGg5QVpnUVJqckkra1kvMjdaeWdVQSs2Qk1KODB6?=
 =?utf-8?B?am5laEdCbTVyM1dEcFVSKythM1hHQ0FraXc1RVFJWHROdGxFc0ZyYnRBczdN?=
 =?utf-8?B?d2RqUUg4Q21KNkVYTWg5cS9kYjF0dzk0UmdJWXo2WWh1cUxZa3lMaVRwR3ha?=
 =?utf-8?B?d3UwUTE5djJjY2JmS0RMeUJCaFBpaTNLc09UZDhaTDRMTzNYSWJMQmVBRklT?=
 =?utf-8?B?TTZoRFJFRWpYaGNMKzFyMW92Y3ptdzNjSzdoWld6ZlBDNnp2M2RFekZ5ZEE5?=
 =?utf-8?B?TDVhRjF6SFBKWUZVWUh2NWFIb0U3MEZDcllHeGJrR0NkRHJVTUtKZmlpY2VU?=
 =?utf-8?B?RW5XOTZlVzlCZmhTdGNBYWNERldZS0VIZU5YczBjRWg2a2d6Ti84dmJZcldk?=
 =?utf-8?B?ZjY5QlE4c0VYQnZUc1ozWE9HODBkbjdsSU1PUTRiMDd2ekhEZlhubkl4dEk2?=
 =?utf-8?B?ZFRyTzFjWVNzcjJuQmpTNEJlYldONHl3Q1BUcEUrYjdsTVJNODJLK0Vpc2xL?=
 =?utf-8?B?aDQ5eHpJOGdYRWdpa1JRWUxvNll4RUg3K2RHeW9tUlJxTzgyU2JzK0k3Y0FJ?=
 =?utf-8?B?WjdDdzlBT1UrMmhvZ0djTEVVRURHMHZrSjQ1YXBBSDhJajVYK2M3UnQxWWVJ?=
 =?utf-8?B?VDhyQXdoclNaZERJcmkxVkpTUmtidGdPVThvVjZ5YkVHOXorQVgvUzViY0JC?=
 =?utf-8?B?cUl5TngrUitxcWk0NVRtNFcvTlplRXFDeFg2UWpXSFdpQzViWnBVa0Z6LytO?=
 =?utf-8?B?UXppN2M1OGxVY0VvQmZLMW1sVTJma21HdzQ4aWlNRklJbXdDNzltejYxbkZO?=
 =?utf-8?B?R2VSeVhmQ05EOHRrWXI4aU0zS2pZWjdmRFNscTlqQzA4SWVmRXFmd0hmck9n?=
 =?utf-8?Q?7PWKnPr/J5OLovbhM0sbkFPWH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5696c05b-9afd-4814-d5cb-08d998fac5a7
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3980.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 03:35:07.6565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7+bwPw1kVievl+0NE9PlaKqVi+LIJRDtQnW//1t3gIH6aZLA7QskfXTR4KgtUQr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1597
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 5u96vzTnNFUtuqOiPA0U5gp2iGQqfr3j
X-Proofpoint-GUID: 5u96vzTnNFUtuqOiPA0U5gp2iGQqfr3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270018
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 10/22/21 3:02 PM, Joanne Koong wrote:
> This patch adds test cases for bpf bloom filter maps. They include tests
> checking against invalid operations by userspace, tests for using the
> bloom filter map as an inner map, and a bpf program that queries the
> bloom filter map for values added by a userspace program.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---
>   .../bpf/prog_tests/bloom_filter_map.c         | 204 ++++++++++++++++++
>   .../selftests/bpf/progs/bloom_filter_map.c    |  82 +++++++
>   2 files changed, 286 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
>   create mode 100644 tools/testing/selftests/bpf/progs/bloom_filter_map.c
>

[...]


> diff --git a/tools/testing/selftests/bpf/progs/bloom_filter_map.c b/tools/testing/selftests/bpf/progs/bloom_filter_map.c
> new file mode 100644
> index 000000000000..7f72102ea6a7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bloom_filter_map.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct bpf_map;
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1000);
> +	__type(key, __u32);
> +	__type(value, __u32);
> +} map_random_data SEC(".maps");
> +
> +struct map_bloom_type {
> +	__uint(type, BPF_MAP_TYPE_BLOOM_FILTER);
> +	__uint(value_size, sizeof(__u32));


you should be able to use __type(value, __u32); no? let's do that to 
confirm that kernel accepts it (please check that there are no warnings 
from libbpf about retrying without BTF)


> +	__uint(max_entries, 10000);
> +	__uint(map_extra, 5);
> +} map_bloom SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> +	__uint(max_entries, 1);
> +	__uint(key_size, sizeof(int));
> +	__uint(value_size, sizeof(int));


this should also work with __type(key, int) and __type(value, int), 
we've added logic to libbpf recently that takes care of this (see a big 
switch inside bpf_object__create_map()).


> +	__array(values, struct map_bloom_type);
> +} outer_map SEC(".maps");
> +


[...]

