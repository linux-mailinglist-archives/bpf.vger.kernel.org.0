Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E90A440544
	for <lists+bpf@lfdr.de>; Sat, 30 Oct 2021 00:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhJ2WHP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 18:07:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61068 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230325AbhJ2WHN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Oct 2021 18:07:13 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19TLXANx010595;
        Fri, 29 Oct 2021 15:04:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hAnkR1C2HrcQz1zri9po7o8Fkpf92nsxWfWwznjSopo=;
 b=AhDd75eysm3IrghjuucCQML9F+DQmueT+Bl8r8fNE5FVNM//BVFvKhvupWzaDphiYz8N
 2S6Iy0Vj1bbY+hnvJXYhmAGIV82daMe/YXiZMSi9DhYsLa/mH6MYwWtgbsIDoTTsOPhg
 gUYsys+B5QN7UKqytkXXfcRtW3rMdj5rerk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3c0b757kcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Oct 2021 15:04:31 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 15:04:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2r22EDzXYKzR5lT1Mf6DeJDl/N5Uc657iGAvGWGJ5rWmuQJtkJ0pa18faE8B0YbEn13KT3MxTMXMkIw7h+1LQtMtoWO5bfa1l0AYXSiG6aGVhUlccTQ7cGFyizzm1Bar4+YRJsPD2ZbVUR0Wl5jEA0PW/LjaIk4AbyP8uuXHP0Y9tLeiDI+ZGvYNvRx1tcoR01GfKvGCyG0G0WvoOiReU6GI7oCF+oVUZmfKuq0nQu68bcpLzICVOtQbBjPvQZOCtLyq7saPRH875qNi74Sas+U6vhDNEmsPIooPtZ3qBsxHzVkJt9WUuKH376iyP4l2jEffY5UXd5F5uvNtDMFNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAnkR1C2HrcQz1zri9po7o8Fkpf92nsxWfWwznjSopo=;
 b=K7lHgEhohqKZr4nHKxbkdgbwVSTUl4VjYRnttKHXKQpM6MtI1/3VQ8EwoWAtvrf93JHVTOkP9gE4K8UNhPiY6rGrO05okDnr8kxO6MBcSzetT42jpHV5Rc7uVE4mBzWsuGhIIxCS9tPyzKG2OZE6HLW6ZooJ6DEZ2hW8uZtHdyMhTjcIG9So4+qOM7RC0ThLpf72wzCzEvMpyZctXSdAo7ucZ3HZ5DzutZTIvQgo1AfUa20GW7Ft+xrzHsUlsc7Q/thw6Wk7czOMltcg7XhbBVbf04eIx8QAhj9lxztRKEG1pwTbchooi47azhF89Jhoha78S2Z1cOZi0hb5zX8ILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3933.namprd15.prod.outlook.com (2603:10b6:806:83::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 22:04:30 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4628.023; Fri, 29 Oct 2021
 22:04:30 +0000
Message-ID: <d2de3cf7-7f0f-dbdc-63e3-c91478b16ae7@fb.com>
Date:   Fri, 29 Oct 2021 15:04:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add bloom map success test
 for userspace calls
Content-Language: en-US
To:     Joanne Koong <joannekoong@fb.com>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>
References: <20211029170126.4189338-1-joannekoong@fb.com>
 <20211029170126.4189338-4-joannekoong@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211029170126.4189338-4-joannekoong@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:303:6a::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c1::17cb] (2620:10d:c090:400::5:47d6) by MW4PR04CA0038.namprd04.prod.outlook.com (2603:10b6:303:6a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 22:04:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cda2f68-bbfa-4242-f6cf-08d99b2814c4
X-MS-TrafficTypeDiagnostic: SA0PR15MB3933:
X-Microsoft-Antispam-PRVS: <SA0PR15MB39337BC06C89A34450004AD1D3879@SA0PR15MB3933.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zqNqHdizZVeGtqB8HowSMnBT36VPNyIjhKB1gtmRaR5jhqBLxSvx/mz7LtsCiJTdHQC7ZiFdxfz4CzDQM6S8i1JmGx/QEpYzAiJvDdOgXDdiUGstyH7pkYl9nhhuSR5Tr9xlPabwid2WLyxldakIhawzc43wDeQvczwM6yHitZjTkKNPpf/R0DCQiIDbiKfFrUbT5TZ3l9a6uKHxh/ADvOJ3vZx/Ia3hL49xaqLlaDL/mDirVopvPPB/MvzvAGuCX1d+bZgqrQu5S4sLlJus/ya6x6xcTIQ6sbn6mhlZqrNxjS9xb4Prx4hA7agagSb0S7Kow17V0DvR/Erkfj4w9JfIOR26y/Q3T/udxWX/PfjY9JIgV9mMwLfLDbB/RPI0+UVk1xjHm3BPgpj2vafzVSiOUECWI9V7x4dVNEJMkR14e5Ef2ch46jecBp56Ai4UYwdK1YNz+YpdQIcT5ANhqk4bHKiPz1vEVwsQJeDcxNgYT5E+Rs4vpvQiphWQMIqliJTYYUPdLUT4D/QKS+51LfOKjpKWrqlxZMCeGjxy3mGFXz1wZf4ZgREAAw1J+kdUbu1bLSqK+w9R0uWN9mh+ucO8zfxf41UDWo6gCTxDYF80XTSIX49pGToGzZfbEZzKv/pH+bE6U4Rhm1c5VSFCYDN5Mdv0xlEXWcIDiIpi7iyPM/BnCNwEs2zmSficyXKvJojxboRIPQhTYP62R7GDuv+MHBObDrJf4kIVFJk/6ss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(2616005)(36756003)(66946007)(52116002)(66556008)(66476007)(53546011)(8676002)(508600001)(8936002)(5660300002)(83380400001)(2906002)(6486002)(31696002)(4326008)(31686004)(186003)(316002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzNydWthTVozbEtBelpWTFRtemVKYTVaUmVLdWk0SjM1Ym9YYkZ5ZkhFNGx3?=
 =?utf-8?B?bEJzMnkrNE42cno2UzFUQWlTMWNDdytKcURVY09xSGxacUFvMXlOamZsWTB2?=
 =?utf-8?B?Nk8rY3h5Q25YOUNlcEYzdWZ1R0dFMDdyNDRaQm1VbVNqaSs3LytnNXpXdWJW?=
 =?utf-8?B?WElIMjB2NDgvTWExT2VhUGtKUGxuY0oxaFpUNWExM2laUXNZWFcyYUgwUHBw?=
 =?utf-8?B?cG5jclJTNDArQUNMaEZPTGQrd3dURC90K2prV1VBbmx2QU16UEo3WGZWT3VW?=
 =?utf-8?B?Rm1ENitFOUVEb1owcDJBY0ZLQmRiMThrVThwN3lqWW9Fams3QzlsVnJCWFA5?=
 =?utf-8?B?Sm9JNlhRcXZFZ20vRzdvOXgrb1dWODFLb1VyUXpIYTdVT0RweWF6bEg0NVlp?=
 =?utf-8?B?VzJlb0V5VEJpSjZSRzFjY3F5SFJJTUo4OS91M1FDWWxMMEpCaUVDZlpzSzI5?=
 =?utf-8?B?TE8xUVhtWXJxSy93OFRwdVhXdlB2cEZHdDZiYmdkcmk0SnNWU0dkZWcrUyta?=
 =?utf-8?B?M2lwclNYUUhNb0p1M3dYU3NDRm9VMG1SQ0Q0bmRISEQrQzRaN242Q09uMjg5?=
 =?utf-8?B?UkxMTHVETVVqSWhHbytHbW1rRWIzNHNpM1Vic2tSUDR2VzFSeHZvUjdaUlN4?=
 =?utf-8?B?MWEyaGZrWU92YTc2dlVJZXBUTXBmenJHMEc0M0plK21kRnY5WmlUbnF5eWtw?=
 =?utf-8?B?cmpyVFFiemxuOHJ5MitKdjlaOEZnRUtEN1ovcWN3UjJRbWRwZkpEMit3eVFw?=
 =?utf-8?B?ZDBmME9sWm9EWnFtOGN6Nnc5VVF4eGZGMmVaZ01JWG9FWlY4RW0zMGJDZmNF?=
 =?utf-8?B?Zk1oUHhzb2ZXbCtHT0dxRElQckVZNVV4QUl4dDNPZHFGcUZublpud3lSTWJ2?=
 =?utf-8?B?dnYyMks3bFk4WTFHa0FnZit2NGhUVk9IM1R5NTE3OFI4VS9neXJkQjRHcG5U?=
 =?utf-8?B?RDJpUHFmY3IrOEFnT2lvdW5mUTlRWXJyQ2lMaExFLzFNbDhpTDJiTjQ5ZVps?=
 =?utf-8?B?OXNTVDRzNWJZZitFam9SN0JuNWlNek9UditZSFlZUUtYTytKRGtYWjJUY05H?=
 =?utf-8?B?eWtaWG1vMEtPR256d3BPTDl5SmZ4bEQrWnA2VVVhR3dmcXE5ZDRwcE1Wdk4x?=
 =?utf-8?B?ajJUSzdqMzlzYnAzTy9kUkwyUXBuYkE2TlhNa3dkbS8wbmhuZTFLLzdaN0ZN?=
 =?utf-8?B?MzJJa2k4ZndLY3MzYUlCTitzMzZwSDMydlI1NG5tdkJNcmd3Q2ppY1d1QWlz?=
 =?utf-8?B?UVIrSDBoSjEyOXRqTm01NjR4cGJlV1R5MkJaaUkwMHFEWlhWczZjRDhlbFJZ?=
 =?utf-8?B?M0NPRzlQVlMzWDVuMnYwR2RxMFBLS3hFNlZHS3JzSm05Vzg3RS8xQVRrWnMv?=
 =?utf-8?B?Sk1nU29pQnhJRmE5WWg5NVlGM056eURCOUJwMHNpendOaXh5WnZmejU0bWxM?=
 =?utf-8?B?QWVYM1lvVFVIanFKMWx5aTRjK2N5WEhyRTBZcGtmbTZ2RUhtVitxeTZxeE43?=
 =?utf-8?B?aE1XbjhleWZBb1NlVjJzSWJTZG0yU3V2N1ZkWWFaaVRuV2ZnNW1xU1RhSWlo?=
 =?utf-8?B?bmtyZUg2NTRiYzg1MFYxazBSdWRMMXNjVE9uRnRmY2I2N1gxZFVmQS8vTXRD?=
 =?utf-8?B?SjdKdWROVTl6MXNqWDZmRWM1WFVmajlHTU0wRlpTSm5WZjByMjdUbnJNRy9I?=
 =?utf-8?B?K2R3d1pBUCtwNGw0UUp5UnpQcXVsd25DZjRWVVNtVHQ3a05CcERhNmpZTEhm?=
 =?utf-8?B?V1B0TmlBQVptV3dtQkZnK29NTW1ZeHVGeG84UW93QUhqVDZ5R0p5d0xFUkNi?=
 =?utf-8?B?R0Q1OFFDUytDSDFlUTIxc2FPTG9nT0txSGxoSlRHQlk3ZDgvVzhYcU1DVGJB?=
 =?utf-8?B?N3o4SjI5TDVzK2w4TEludzExcmZ6U1BnVko4TTdxMERrTFZ2OFdDdkR5NVJr?=
 =?utf-8?B?ZlVQTmMxTDdXd0tibTRZMVNyOXAveU1tWnFBaUhjanN2MXE5R2RYQjhvSDhT?=
 =?utf-8?B?cTVDZUJXWGUwNko0ZG1NcmkyVDdsSS9LcDdsdmxaVExYNTFIWld1cElncUhT?=
 =?utf-8?B?eFNqTStWaUhqRXhCc1JlZitkOEgvTlJxYTVHb2RmU0oyWWJBVDk3N3VUNGtJ?=
 =?utf-8?B?UkRIQlhoR3NyWENRajBodkRzNE85WFhhV25HSGx5VktqTElrRks5U0VOQWFl?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cda2f68-bbfa-4242-f6cf-08d99b2814c4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 22:04:30.0444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JK8mUJMuAc1XuqnYMEibLaFglfGA9V4PCw+URMDjU+h/xRXrpqzhiEIJ5YB3h7L3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3933
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: epnwTEU7-IjjopzPft-3gnVgd8Vg9UNe
X-Proofpoint-ORIG-GUID: epnwTEU7-IjjopzPft-3gnVgd8Vg9UNe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_06,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/29/21 10:01 AM, Joanne Koong wrote:
> This patch has two changes:
> 1) Adds a new function "test_success_cases" to test
> successfully creating + adding + looking up a value
> in a bloom filter map from the userspace side.
> 
> 2) Use bpf_create_map instead of bpf_create_map_xattr in
> the "test_fail_cases" to make the code look cleaner.
> 
> Signed-off-by: Joanne Koong <joannekoong@fb.com>

LGTM with one minor comment below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   .../bpf/prog_tests/bloom_filter_map.c         | 53 ++++++++++++-------
>   1 file changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
> index 9aa3fbed918b..dbc0035e43e5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
> @@ -7,44 +7,32 @@
>   
>   static void test_fail_cases(void)
>   {
> -	struct bpf_create_map_attr xattr = {
> -		.name = "bloom_filter_map",
> -		.map_type = BPF_MAP_TYPE_BLOOM_FILTER,
> -		.max_entries = 100,
> -		.value_size = 11,
> -	};
>   	__u32 value;
>   	int fd, err;
>   
>   	/* Invalid key size */
> -	xattr.key_size = 4;
> -	fd = bpf_create_map_xattr(&xattr);
> +	fd = bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 4, sizeof(value), 100, 0);
>   	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid key size"))
>   		close(fd);
> -	xattr.key_size = 0;
>   
>   	/* Invalid value size */
> -	xattr.value_size = 0;
> -	fd = bpf_create_map_xattr(&xattr);
> +	fd = bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, 0, 100, 0);
>   	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid value size 0"))
>   		close(fd);
> -	xattr.value_size = 11;
>   
>   	/* Invalid max entries size */
> -	xattr.max_entries = 0;
> -	fd = bpf_create_map_xattr(&xattr);
> -	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid max entries size"))
> +	fd = bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, sizeof(value), 0, 0);
> +	if (!ASSERT_LT(fd, 0,
> +		       "bpf_create_map bloom filter invalid max entries size"))

It is OK to have "bpf_create_map ..." in the same line as ASSERT_LT
for better readability and consistent with other ASSERT_LT. It is over 
80 but less than 100 char's per line.

>   		close(fd);
> -	xattr.max_entries = 100;
>   
>   	/* Bloom filter maps do not support BPF_F_NO_PREALLOC */
> -	xattr.map_flags = BPF_F_NO_PREALLOC;
> -	fd = bpf_create_map_xattr(&xattr);
> +	fd = bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, sizeof(value), 100,
> +			    BPF_F_NO_PREALLOC);
>   	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid flags"))
>   		close(fd);
> -	xattr.map_flags = 0;
>   
> -	fd = bpf_create_map_xattr(&xattr);
> +	fd = bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, sizeof(value), 100, 0);
>   	if (!ASSERT_GE(fd, 0, "bpf_create_map bloom filter"))
>   		return;
>   
> @@ -67,6 +55,30 @@ static void test_fail_cases(void)
>   	close(fd);
>   }
[...]
