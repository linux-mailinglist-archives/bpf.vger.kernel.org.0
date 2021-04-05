Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CA8353B65
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 06:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhDEEsD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Apr 2021 00:48:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1122 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229867AbhDEEsC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 5 Apr 2021 00:48:02 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1354j4aR002292;
        Sun, 4 Apr 2021 21:47:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dm9C75OtZqN5XZVlNDIwxnjzlofWUIZX13bk1Pm3zEI=;
 b=aaI7hzhvQEQmaP2m2SBV19uXVHHPoyCmOOJdteZTisBLb7v2mAJYkMopdNXI6TP+G0TI
 EKxikHkIFMOxW4oFfmlwmw3HhVW6ao54pcpetHdIBGiuaTHR3UE4R2q380+xWtCuR7kM
 UeVwiJihxEEJ8T8SJpwpLXb8HsOb8iAPEwo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37qttrr6hb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 04 Apr 2021 21:47:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 4 Apr 2021 21:47:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cltevSL9L38lgVYyE5pkgWMZWy6ZJ90oBCeoDkb0LI3xx1oKtk5oob4qFLMIx5fOb6EjOitJRR3w5+UtuQeNUWjLCKbNDFplfL35sR7EF8OSL4K4jrbDXCY9ZbmMiXI6FBjYapnf5pYNVn1WNVlISgmLbYxK5ZPCgvO2RvbmqdoaaYmQEfws/utdTNxHgGSjvkvzoBr7xY59+NWpNQpcaNvUHQCOP+aQynvtoLx8+JUfX5N6dcjv1WnAHuDugDXiW3WaWfQHtrx3vTG9eXMUKFCevb9ltMm1VQ9enL7R0gRlDdd2U91kygJf3Ir1rvY10NBu+S9dFgzO4/+3xy3qig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm9C75OtZqN5XZVlNDIwxnjzlofWUIZX13bk1Pm3zEI=;
 b=MV2yAvUb6PVMoS4yKh9E3b6YsgjXIZM4Ua/UCrmXDA7azrslNtC+jvJKPVCyscWnI9k4pZ39pdm2IjOqAgGCDqBN8FqMb7gYiB3EqZxhN6y8F/v9b9LXpPA4uuKDMwtHAUreUzQ70z/iibXA8YYXIkLPrE8FUpvGeYBeIFLePAVTb3BECAAERmWxN6igrRmUYwAfHB7GuSMNxIKzxfO0XOcRDprPaOskNmR7gj24wuxlOhIPxa7vAEtQCNDlIj4R9YjvUbvvXeO0SUzBzfLDCyQtEnv/lxCuU/Neb9azXHZ84Guob4sH+ak+4u7NDFkDQJxA8W9N3oyc9QENYwQySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4740.namprd15.prod.outlook.com (2603:10b6:806:19f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Mon, 5 Apr
 2021 04:47:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 04:47:33 +0000
Subject: Re: [PATCH v4 bpf-next] bpf: add lookup_and_delete_elem support to
 hashtab
To:     Denis Salopek <denis.salopek@sartura.hr>, <bpf@vger.kernel.org>
CC:     <juraj.vijtiuk@sartura.hr>, <luka.oreskovic@sartura.hr>,
        <luka.perkov@sartura.hr>, <daniel@iogearbox.net>,
        <andrii.nakryiko@gmail.com>
References: <YGHOxEIA/k5vG/s5@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <ce69af50-3667-c52d-1f1a-b924bbe0fc58@fb.com>
Date:   Sun, 4 Apr 2021 21:47:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <YGHOxEIA/k5vG/s5@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ed0c]
X-ClientProxiedBy: MWHPR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:300:116::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1149] (2620:10d:c090:400::5:ed0c) by MWHPR07CA0005.namprd07.prod.outlook.com (2603:10b6:300:116::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Mon, 5 Apr 2021 04:47:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2d5c72b-8e20-43a9-68fc-08d8f7eded59
X-MS-TrafficTypeDiagnostic: SA1PR15MB4740:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4740F1E23B4899A97DE7AF7CD3779@SA1PR15MB4740.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iR1zynN+2/8A+kQLzQROsthfzkGHuj4jYoXMmYfaB4y7mN7aXDU0nPtf8RLyDF+akzYMXtf571C6/stObB/MKZR0rf+iCI29732492IGPnrDBAmvhq2EXvk+RKSWvmR/0ntGGQTN0X18oCcLesbb4uQwvPz1xJJ25tCvFECENtjkDJrLxe6xMcqot2rVENXx1sxIEvJnpbhiLMyOFG4CoM6NVpFOsVhvxCFu4oM6mJDO8d1aaqdaK/nSRtmF2xGuEOPTlV7fyRD8sZ8xwb0Q/7LDoPe/CZITCTB58i/UX6xopBubBmPZ4EWhyrYQherHlZKByV5laTNlPCPNrD+lhm3BGV4hazRnYt85aWyYbJocO/q4BaVhRPAVW3W2iZFSB5yYe2SpoSI9hF61ZkRYkUdArSDJLLNwYI8KOjUVxkUPcJ0+q027Y/3EAOU0ZN85/wkAsO9BOKo/Rea0AhLDuQGZ1tr2FEWCjSIKYvp5jhaCU2ab68xDtV+zZlQHmKQChuU6X6Ne+KGLW5F2l99uTyXa9yad8AsXS591Xkcp2sXyCYB5xNpgcJLyJBpzVJXsKwN28HcAy8l/loIB/WIj8mOeygSsxCnpgPzLVanOvKBPH/eAtkrmYvIDugIFHAVYUJn+pZp3g/FMdPSOtqj2rhT266Pqmtj5zczpB6nhfnBAL9dslrnUtb8x9LNZDL79szXG62SRhDNnxLd/fd5C/Iwchxk7cnLP/bYgujhGLr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(376002)(366004)(136003)(2906002)(86362001)(6486002)(16526019)(66556008)(8936002)(66946007)(31686004)(52116002)(83380400001)(66476007)(53546011)(31696002)(316002)(38100700001)(36756003)(2616005)(30864003)(5660300002)(4326008)(8676002)(478600001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WVQ4SzduWTZJa1BHY2dPaXpvWWRvK3dVOEk3OENBS3pCZzNNN1diQmhCL2Iz?=
 =?utf-8?B?Q2JNd09zc0lnWlNydTh3TitPL3dJREthYXpMZno3STg2MjJCOTYrNXd0M0ZI?=
 =?utf-8?B?Z3JaVS8vUTRnNzFpVVA3K0FUNzhkZE9pSXhOYnh3SnNjUzRuVTZibDRWNjBO?=
 =?utf-8?B?QVRaMEhhaWIyMk9wTUYwakVzWHc0WE5ieTBhK0wyQVM2ckkyT3lScWVPM1RC?=
 =?utf-8?B?N0pyVWNISm40K2lHVTRnemdTUWx4ckNmQWtwYjFTd2RzYTdRZUZmZW45MkJJ?=
 =?utf-8?B?dStvbWxvT21EaGZGYnk3OGYzNHVlZk9VcDBXNnNjakxjNXpEOVZQS2RJdVpL?=
 =?utf-8?B?MXRJRk9PeHNKMGZtY0VaK0FWemZuWXR6cmlwZUFqazQ4WWlHazkrSnlxMWRS?=
 =?utf-8?B?ZE1VS0FEVEFncGs5eTNLaGdiTFd1OHN1M3JpSmdvYm00d1ExUVpqYVZubGp2?=
 =?utf-8?B?SlpEc2wxeWxoRXRXRkVpSDhnc010aTdBK0s2WmlqclVhT2t6UWlNWkJBbStm?=
 =?utf-8?B?ck9WTlVISDFPQkhBTHRhM1VEejlQUFpkcExvZk1PRHlOOE5yb1B1eW9DcnlS?=
 =?utf-8?B?dytQemIvZkp2aWJ3L1hmbFRabU5PVVBqWmM1c0puMkdzVzRJUTAwL3JpcmJV?=
 =?utf-8?B?MFJ2K2EyREpEUEFTc1dhUVVJTHdHZTRUSnZxVnliOWtaclQxZFpoNnZodU82?=
 =?utf-8?B?ckdEVHF1K05KaFhZUnc0a3lPbWlRWE83MGdsY0ZpRWhua1lsMTA2NXkrbTdL?=
 =?utf-8?B?VTVlWDlaYlZqMFVQcFVNbDhFSGx3aVlkQjZZYlpQRnQ4ZE9YSEFxQWo4QlQ2?=
 =?utf-8?B?aE15Ync1aHh4Y1YwajY1RndNY1lHaUlON1p5N0U3eUtOVmVNN3d6dXFhN0pi?=
 =?utf-8?B?YzczcW5yNW1ubjcwSGd2K1Q5MW9VeU9FK3pHYTBmQ0JBNFNpUzk5Vk5aK3dS?=
 =?utf-8?B?WU1Ydm9UaFJZeUFSamZ0eVN6S0U1VDR4Z3JxR0JSU045WHptczUyYmkzUjRM?=
 =?utf-8?B?a1BscUJKVWVwTVZYRFpwL0dvTTQvNml4Z2JuRDBHckZOYlNGanBESEZyYTZU?=
 =?utf-8?B?MlRvOGRoMmRIQ1R3S2RGL2l0b0dIZWhVSTZsNExqeDRwbHdheU5Obko1VVRN?=
 =?utf-8?B?cXZsU1BDK2RFQmk1UUlQQXczNEpITkpqb1k4c3dZdzJwS2NYc1IrMTlOdHdI?=
 =?utf-8?B?Q2VrcVVmTmtPWGZOelJUM1czOENIbENoTXV3L0RtdDVpU3hyNmgxN3NUOG1I?=
 =?utf-8?B?aWdiRkJUYmhrUHRuY0t3dS8rYzJvVktKVWNaRHBubVUwQVFjMWgxMm0xSlo0?=
 =?utf-8?B?bFpKekJmdlg0enBSUjNWOVh0ZzREa01vbWt1SDlsLzZvTnpKY3JTektMRkNi?=
 =?utf-8?B?cDRDdTcyZ1JVZlpMeWNLSHg0Ukl5YXd2N3hLdEVEUDVxSU45U3R0UGM4OHlS?=
 =?utf-8?B?aDJtdUF0Z25YaUNyN0o0bHl2L1VXNmVrS2VkZVdmbU5Db3J2a1FLeU5OTmFk?=
 =?utf-8?B?UkJNYWJaQW9aTGRIRmpsd09sMUdjQ0J3RitFeE1iRWJpSU9xV0lBWiswMkRt?=
 =?utf-8?B?ZkRFcm1qTW5YUksySVBSMHhJZWQ3MlVhalg3OUd2dldET1l0NGdxWDVtUDdy?=
 =?utf-8?B?ZUU0NTBZUndlanlCbDJWTVFJblBmMDhaODEyTllXZlBJWWJWR1RLRnhUbkht?=
 =?utf-8?B?M1VGSUR0MUhQZkMwdzA0WVlGK2JjREVpaVlyWHNZbkwrZy94Tk9UZFFLZG8r?=
 =?utf-8?B?WHd2bzBWWlBGc1FzanRTK3lRaERaSWFIamk2NWpxQ280bmhIazREOFZ4aXky?=
 =?utf-8?Q?H8RJLlk0312Zz2ijzOZ0a1RHqs1/8qRvsmqnE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d5c72b-8e20-43a9-68fc-08d8f7eded59
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 04:47:33.6823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yp+3ARPD4VqDJhhTY/3/IfVyDKmVAiRfN7uAevPKu4tiP7GF+u0izMaAPyQe/lln
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4740
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: hSa4bxAGnLs5v9KN3Tq0uYU1jcOI0cbC
X-Proofpoint-ORIG-GUID: hSa4bxAGnLs5v9KN3Tq0uYU1jcOI0cbC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-05_02:2021-04-01,2021-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/29/21 5:57 AM, Denis Salopek wrote:
> Extend the existing bpf_map_lookup_and_delete_elem() functionality to
> hashtab maps, in addition to stacks and queues.
> Add bpf_map_lookup_and_delete_elem_flags() libbpf API in order to use
> the BPF_F_LOCK flag.
> Create a new hashtab bpf_map_ops function that does lookup and deletion
> of the element under the same bucket lock and add the created map_ops to
> bpf.h.
> Add the appropriate test cases to 'maps' and 'lru_map' selftests
> accompanied with new test_progs.
> 
> Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
> Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
> ---
> v2: Add functionality for LRU/per-CPU, add test_progs tests.
> v3: Add bpf_map_lookup_and_delete_elem_flags() and enable BPF_F_LOCK
> flag, change CHECKs to ASSERT_OKs, initialize variables to 0.
> v4: Fix the return value for unsupported map types.
> ---
>   include/linux/bpf.h                           |   2 +
>   kernel/bpf/hashtab.c                          |  97 ++++++
>   kernel/bpf/syscall.c                          |  27 +-
>   tools/lib/bpf/bpf.c                           |  13 +
>   tools/lib/bpf/bpf.h                           |   2 +
>   tools/lib/bpf/libbpf.map                      |   1 +
>   .../bpf/prog_tests/lookup_and_delete.c        | 279 ++++++++++++++++++
>   .../bpf/progs/test_lookup_and_delete.c        |  26 ++
>   tools/testing/selftests/bpf/test_lru_map.c    |   8 +
>   tools/testing/selftests/bpf/test_maps.c       |  19 +-
>   10 files changed, 469 insertions(+), 5 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_and_delete.c

Since another revision is needed, could you break the patch to several 
commits which will make it easy to review?
Patch 1: kernel + uapi header:
    include/linux/bpf.h
    kernel/bpf/hashtab.c
    kernel/bpf/syscall.c
    include/uapi/linux/bpf.h and tools/include/uapi/linux/bpf.h (see below)
Patch 2: libbpf change
    tools/lib/bpf/bpf.{c,h}, libbpf.map
Patch 3: selftests/bpf change
    tools/testing/selftests/bpf/...

> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 9fdd839b418c..8af4bd7c7229 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -68,6 +68,8 @@ struct bpf_map_ops {
>   	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
>   	int (*map_lookup_batch)(struct bpf_map *map, const union bpf_attr *attr,
>   				union bpf_attr __user *uattr);
> +	int (*map_lookup_and_delete_elem)(struct bpf_map *map, void *key,
> +					  void *value, u64 flags);
>   	int (*map_lookup_and_delete_batch)(struct bpf_map *map,
>   					   const union bpf_attr *attr,
>   					   union bpf_attr __user *uattr);
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index d7ebb12ffffc..0d2085ce9a38 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1401,6 +1401,99 @@ static void htab_map_seq_show_elem(struct bpf_map *map, void *key,
>   	rcu_read_unlock();
>   }
>   
> +static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
> +					     void *value, bool is_lru_map,
> +					     bool is_percpu, u64 flags)
> +{
> +	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> +	u32 hash, key_size, value_size;
> +	struct hlist_nulls_head *head;
> +	int cpu, off = 0, ret;
> +	struct htab_elem *l;
> +	unsigned long bflags;
> +	void __percpu *pptr;
> +	struct bucket *b;
> +
> +	if ((flags & ~BPF_F_LOCK) ||
> +	    ((flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
> +		return -EINVAL;
> +
> +	key_size = map->key_size;
> +	value_size = round_up(map->value_size, 8);

This value_size is actually a round_up size, so maybe
rename it as "roundup_size". Also, I see it is only
used in is_percpu case. It would be good if it can be
moved inside is_percpu branch.

> +
> +	hash = htab_map_hash(key, key_size, htab->hashrnd);
> +	b = __select_bucket(htab, hash);
> +	head = &b->head;
> +
> +	ret = htab_lock_bucket(htab, b, hash, &bflags);
> +	if (ret)
> +		return ret;
> +
> +	l = lookup_elem_raw(head, hash, key, key_size);
> +	if (l) {
> +		if (is_percpu) {
> +			pptr = htab_elem_get_ptr(l, key_size);
> +			for_each_possible_cpu(cpu) {
> +				bpf_long_memcpy(value + off,
> +						per_cpu_ptr(pptr, cpu),
> +						value_size);
> +				off += value_size;
> +			}
> +		} else {
> +			if (flags & BPF_F_LOCK)
> +				copy_map_value_locked(map, value, l->key +
> +						      round_up(key_size, 8),
> +						      true);
> +			else
> +				copy_map_value(map, value, l->key +
> +					       round_up(key_size, 8));
> +			check_and_init_map_lock(map, value);
> +		}
> +
> +		hlist_nulls_del_rcu(&l->hash_node);
> +		if (!is_lru_map)
> +			free_htab_elem(htab, l);
> +	} else
> +		ret = -ENOENT;
> +
> +	htab_unlock_bucket(htab, b, hash, bflags);
> +
> +	if (is_lru_map && l)
> +		bpf_lru_push_free(&htab->lru, &l->lru_node);
> +
> +	return ret;
> +}
> +
> +static int htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
> +					   void *value, u64 flags)
> +{
> +	return __htab_map_lookup_and_delete_elem(map, key, value, false, false,
> +						 flags);
> +}
> +
> +static int htab_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
> +						  void *key, void *value,
> +						  u64 flags)
> +{
> +	return __htab_map_lookup_and_delete_elem(map, key, value, false, true,
> +						 flags);
> +}
> +
> +static int htab_lru_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
> +					       void *value, u64 flags)
> +{
> +	return __htab_map_lookup_and_delete_elem(map, key, value, true, false,
> +						 flags);
> +}
> +
> +static int htab_lru_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
> +						      void *key, void *value,
> +						      u64 flags)
> +{
> +	return __htab_map_lookup_and_delete_elem(map, key, value, true, true,
> +						 flags);
> +}
> +
>   static int
>   __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>   				   const union bpf_attr *attr,
> @@ -1934,6 +2027,7 @@ const struct bpf_map_ops htab_map_ops = {
>   	.map_free = htab_map_free,
>   	.map_get_next_key = htab_map_get_next_key,
>   	.map_lookup_elem = htab_map_lookup_elem,
> +	.map_lookup_and_delete_elem = htab_map_lookup_and_delete_elem,
>   	.map_update_elem = htab_map_update_elem,
>   	.map_delete_elem = htab_map_delete_elem,
>   	.map_gen_lookup = htab_map_gen_lookup,
> @@ -1954,6 +2048,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
>   	.map_free = htab_map_free,
>   	.map_get_next_key = htab_map_get_next_key,
>   	.map_lookup_elem = htab_lru_map_lookup_elem,
> +	.map_lookup_and_delete_elem = htab_lru_map_lookup_and_delete_elem,
>   	.map_lookup_elem_sys_only = htab_lru_map_lookup_elem_sys,
>   	.map_update_elem = htab_lru_map_update_elem,
>   	.map_delete_elem = htab_lru_map_delete_elem,
> @@ -2077,6 +2172,7 @@ const struct bpf_map_ops htab_percpu_map_ops = {
>   	.map_free = htab_map_free,
>   	.map_get_next_key = htab_map_get_next_key,
>   	.map_lookup_elem = htab_percpu_map_lookup_elem,
> +	.map_lookup_and_delete_elem = htab_percpu_map_lookup_and_delete_elem,
>   	.map_update_elem = htab_percpu_map_update_elem,
>   	.map_delete_elem = htab_map_delete_elem,
>   	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
> @@ -2096,6 +2192,7 @@ const struct bpf_map_ops htab_lru_percpu_map_ops = {
>   	.map_free = htab_map_free,
>   	.map_get_next_key = htab_map_get_next_key,
>   	.map_lookup_elem = htab_lru_percpu_map_lookup_elem,
> +	.map_lookup_and_delete_elem = htab_lru_percpu_map_lookup_and_delete_elem,
>   	.map_update_elem = htab_lru_percpu_map_update_elem,
>   	.map_delete_elem = htab_lru_map_delete_elem,
>   	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 9603de81811a..e3851bafb603 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1468,7 +1468,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
>   	return err;
>   }
>   
> -#define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD value
> +#define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD flags
>   
>   static int map_lookup_and_delete_elem(union bpf_attr *attr)
>   {
> @@ -1484,6 +1484,9 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>   	if (CHECK_ATTR(BPF_MAP_LOOKUP_AND_DELETE_ELEM))
>   		return -EINVAL;
>   
> +	if (attr->flags & ~BPF_F_LOCK)
> +		return -EINVAL; > +
>   	f = fdget(ufd);
>   	map = __bpf_map_get(f);
>   	if (IS_ERR(map))
> @@ -1494,24 +1497,40 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>   		goto err_put;
>   	}

Previously, for QUEUE and STACK map, flags are not allowed, and libbpf
sets it as 0. Let us enforce attr->flags with 0 here for QUEUE and STACK.

>   
> +	if ((attr->flags & BPF_F_LOCK) &&
> +	    !map_value_has_spin_lock(map)) {
> +		err = -EINVAL;
> +		goto err_put;
> +	}
> +
>   	key = __bpf_copy_key(ukey, map->key_size);
>   	if (IS_ERR(key)) {
>   		err = PTR_ERR(key);
>   		goto err_put;
>   	}
>   
> -	value_size = map->value_size;
> +	value_size = bpf_map_value_size(map);
>   
>   	err = -ENOMEM;
>   	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
>   	if (!value)
>   		goto free_key;
>   
> +	err = -ENOTSUPP;
>   	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
>   	    map->map_type == BPF_MAP_TYPE_STACK) {
>   		err = map->ops->map_pop_elem(map, value);
> -	} else {
> -		err = -ENOTSUPP;
> +	} else if (map->map_type == BPF_MAP_TYPE_HASH ||
> +		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
> +		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
> +		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {

Since we added four new map support for lookup_and_delete, we should
update documentation in uapi bpf.h.

Currently, it is:

  * BPF_MAP_LOOKUP_AND_DELETE_ELEM
  *      Description
  *              Look up an element with the given *key* in the map 
referred to
  *              by the file descriptor *fd*, and if found, delete the 
element.
  *
  *              The **BPF_MAP_TYPE_QUEUE** and **BPF_MAP_TYPE_STACK** 
map types
  *              implement this command as a "pop" operation, deleting 
the top
  *              element rather than one corresponding to *key*.
  *              The *key* and *key_len* parameters should be zeroed when
  *              issuing this operation for these map types.
  *
  *              This command is only valid for the following map types:
  *              * **BPF_MAP_TYPE_QUEUE**
  *              * **BPF_MAP_TYPE_STACK**
  *
  *      Return
  *              Returns zero on success. On error, -1 is returned and 
*errno*
  *              is set appropriately.

Please remember to sync updated linux/include/uapi/linux/bpf.h to
linux/tools/include/uapi/linux/bpf.h.

> +		if (!bpf_map_is_dev_bound(map)) {
> +			bpf_disable_instrumentation();
> +			rcu_read_lock();
> +			err = map->ops->map_lookup_and_delete_elem(map, key, value, attr->flags);
> +			rcu_read_unlock();
> +			bpf_enable_instrumentation();
> +		}
>   	}
>   
>   	if (err)
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index bba48ff4c5c0..b7c2cc12034c 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -458,6 +458,19 @@ int bpf_map_lookup_and_delete_elem(int fd, const void *key, void *value)
>   	return sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
>   }
>   
> +int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key, void *value, __u64 flags)
> +{
> +	union bpf_attr attr;
> +
> +	memset(&attr, 0, sizeof(attr));
> +	attr.map_fd = fd;
> +	attr.key = ptr_to_u64(key);
> +	attr.value = ptr_to_u64(value);
> +	attr.flags = flags;
> +
> +	return sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
> +}

This looks okay to me. It mimics bpf_map_lookup_elem_flags().
Andrii, could you take a look as well?

> +
>   int bpf_map_delete_elem(int fd, const void *key)
>   {
>   	union bpf_attr attr;
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 875dde20d56e..4f758f8f50cd 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -124,6 +124,8 @@ LIBBPF_API int bpf_map_lookup_elem_flags(int fd, const void *key, void *value,
>   					 __u64 flags);
>   LIBBPF_API int bpf_map_lookup_and_delete_elem(int fd, const void *key,
>   					      void *value);
> +LIBBPF_API int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key,
> +						    void *value, __u64 flags);
>   LIBBPF_API int bpf_map_delete_elem(int fd, const void *key);
>   LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
>   LIBBPF_API int bpf_map_freeze(int fd);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index f5990f7208ce..589dde8311e1 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -132,6 +132,7 @@ LIBBPF_0.0.2 {
>   		bpf_probe_prog_type;
>   		bpf_map__resize;
>   		bpf_map_lookup_elem_flags;
> +		bpf_map_lookup_and_delete_elem_flags;
>   		bpf_object__btf;
>   		bpf_object__find_map_fd_by_name;
>   		bpf_get_link_xdp_id;

Please don't put it in 0.0.2. Put it in the latest version which is 0.4.0.

> diff --git a/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
> new file mode 100644
> index 000000000000..8ace0e4a2349
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
> @@ -0,0 +1,279 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <test_progs.h>
> +#include "test_lookup_and_delete.skel.h"
> +
> +#define START_VALUE 1234
> +#define NEW_VALUE 4321
> +#define MAX_ENTRIES 2
> +
> +static int duration;
> +static int nr_cpus;
> +
> +static int fill_values(int map_fd)
> +{
> +	__u64 key, value = START_VALUE;
> +	int err;
> +
> +	for (key = 1; key < MAX_ENTRIES + 1; key++) {
> +		err = bpf_map_update_elem(map_fd, &key, &value, BPF_NOEXIST);
> +		if (!ASSERT_OK(err, "bpf_map_update_elem"))
> +			return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fill_values_percpu(int map_fd)
> +{
> +	BPF_DECLARE_PERCPU(__u64, value);
> +	int i, err;
> +	u64 key;
> +
> +	for (i = 0; i < nr_cpus; i++)
> +		bpf_percpu(value, i) = START_VALUE;
> +
> +	for (key = 1; key < MAX_ENTRIES + 1; key++) {
> +		err = bpf_map_update_elem(map_fd, &key, value, BPF_NOEXIST);
> +		if (!ASSERT_OK(err, "bpf_map_update_elem"))
> +			return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct test_lookup_and_delete *setup_prog(enum bpf_map_type map_type,
> +						 int *map_fd)
> +{
> +	struct test_lookup_and_delete *skel;
> +	int err;
> +
> +	skel = test_lookup_and_delete__open();
> +	if (!ASSERT_OK(!skel, "test_lookup_and_delete__open"))
> +		return NULL;
> +
> +	err = bpf_map__set_type(skel->maps.hash_map, map_type);
> +	if (!ASSERT_OK(err, "bpf_map__set_type"))
> +		goto error;

Maybe change "error" to "cleanup"? The "cleanup" is
used in other places.

> +
> +	err = test_lookup_and_delete__load(skel);
> +	if (!ASSERT_OK(err, "test_lookup_and_delete__load"))
> +		goto error;
> +
> +	*map_fd = bpf_map__fd(skel->maps.hash_map);
> +	if (CHECK(*map_fd < 0, "bpf_map__fd", "failed\n"))
> +		goto error;

A new ASSERT variant ASSERT_LT was added recently.
Maybe you can use it?

> +
> +	return skel;
> +
> +error:
> +	test_lookup_and_delete__destroy(skel);
> +	return NULL;
> +}
> +
> +/* Triggers BPF program that updates map with given key and value */
> +static int trigger_tp(struct test_lookup_and_delete *skel, __u64 key,
> +		      __u64 value)
> +{
> +	int err;
> +
> +	skel->bss->set_pid = getpid();
> +	skel->bss->set_key = key;
> +	skel->bss->set_value = value;
> +
> +	err = test_lookup_and_delete__attach(skel);
> +	if (!ASSERT_OK(err, "test_lookup_and_delete__attach"))
> +		return -1;
> +
> +	syscall(__NR_getpgid);
> +
> +	test_lookup_and_delete__detach(skel);
> +
> +	return 0;
> +}
> +
> +static void test_lookup_and_delete_hash(void)
> +{
> +	struct test_lookup_and_delete *skel;
> +	__u64 key, value;
> +	int map_fd, err;
> +
> +	/* Setup program and fill the map. */
> +	skel = setup_prog(BPF_MAP_TYPE_HASH, &map_fd);
> +	if (!ASSERT_OK_PTR(skel, "setup_prog"))
> +		return;
> +
> +	err = fill_values(map_fd);
> +	if (!ASSERT_OK(err, "fill_values"))
> +		goto cleanup;
> +
> +	/* Lookup and delete element. */
> +	key = 1;
> +	err = bpf_map_lookup_and_delete_elem(map_fd, &key, &value);
> +	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem"))
> +		goto cleanup;
> +
> +	/* Fetched value should match the initially set value. */
> +	if (CHECK(value != START_VALUE, "bpf_map_lookup_and_delete_elem",
> +		  "unexpected value=%lld\n", value))
> +		goto cleanup;
> +
> +	/* Check that the entry is non existent. */
> +	err = bpf_map_lookup_elem(map_fd, &key, &value);
> +	if (!ASSERT_OK(!err, "bpf_map_lookup_elem"))

There is a macro ASSERT_ERR, maybe that is better?

> +		goto cleanup;
> +
> +cleanup:
> +	test_lookup_and_delete__destroy(skel);
> +}
> +
> +static void test_lookup_and_delete_percpu_hash(void)
> +{
> +	struct test_lookup_and_delete *skel;
> +	BPF_DECLARE_PERCPU(__u64, value);
> +	int map_fd, err, i;
> +	__u64 key, val;
> +
> +	/* Setup program and fill the map. */
> +	skel = setup_prog(BPF_MAP_TYPE_PERCPU_HASH, &map_fd);
> +	if (!ASSERT_OK_PTR(skel, "setup_prog"))
> +		return;
> +
> +	err = fill_values_percpu(map_fd);
> +	if (!ASSERT_OK(err, "fill_values_percpu"))
> +		goto cleanup;
> +
> +	/* Lookup and delete element. */
> +	key = 1;
> +	err = bpf_map_lookup_and_delete_elem(map_fd, &key, value);
> +	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem"))
> +		goto cleanup;
> +
> +	for (i = 0; i < nr_cpus; i++) {
> +		if (bpf_percpu(value, i))
> +			val = bpf_percpu(value, i);

Maybe do the below inside the loop?
	val = bpf_percpu(value, i);
	if (CHECK(val && val != START_VALUE, ...)

> +	}
> +
> +	/* Fetched value should match the initially set value. */
> +	if (CHECK(val != START_VALUE, "bpf_map_lookup_and_delete_elem",
> +		  "unexpected value=%lld\n", val))
> +		goto cleanup;

See the above, do this CHECK inside the loop?

> +
> +	/* Check that the entry is non existent. */
> +	err = bpf_map_lookup_elem(map_fd, &key, value);
> +	if (!ASSERT_OK(!err, "bpf_map_lookup_elem"))
> +		goto cleanup;

ASSERT_ERR?

> +
> +cleanup:
> +	test_lookup_and_delete__destroy(skel);
> +}
> +
> +static void test_lookup_and_delete_lru_hash(void)
> +{
> +	struct test_lookup_and_delete *skel;
> +	__u64 key, value;
> +	int map_fd, err;
> +
> +	/* Setup program and fill the LRU map. */
> +	skel = setup_prog(BPF_MAP_TYPE_LRU_HASH, &map_fd);
> +	if (!ASSERT_OK_PTR(skel, "setup_prog"))
> +		return;
> +
> +	err = fill_values(map_fd);
> +	if (!ASSERT_OK(err, "fill_values"))
> +		goto cleanup;
> +
> +	/* Insert new element at key=3, should reuse LRU element. */
> +	key = 3;
> +	err = trigger_tp(skel, key, NEW_VALUE);
> +	if (!ASSERT_OK(err, "trigger_tp"))
> +		goto cleanup;
> +
> +	/* Lookup and delete element 3. */
> +	err = bpf_map_lookup_and_delete_elem(map_fd, &key, &value);
> +	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem"))
> +		goto cleanup;
> +
> +	/* Value should match the new value. */
> +	if (CHECK(value != NEW_VALUE, "bpf_map_lookup_and_delete_elem",
> +		  "unexpected value=%lld\n", value))
> +		goto cleanup;
> +
> +	/* Check that entries 3 and 1 are non existent. */
> +	err = bpf_map_lookup_elem(map_fd, &key, &value);
> +	if (!ASSERT_OK(!err, "bpf_map_lookup_elem"))
> +		goto cleanup;

ASSERT_ERR?

> +
> +	key = 1;
> +	err = bpf_map_lookup_elem(map_fd, &key, &value);
> +	if (!ASSERT_OK(!err, "bpf_map_lookup_elem"))
> +		goto cleanup;

ASSERT_ERR?

> +
> +cleanup:
> +	test_lookup_and_delete__destroy(skel);
> +}
> +
> +static void test_lookup_and_delete_lru_percpu_hash(void)
> +{
> +	struct test_lookup_and_delete *skel;
> +	BPF_DECLARE_PERCPU(__u64, value);
> +	int map_fd, err, i;
> +	__u64 key, val;
> +
> +	/* Setup program and fill the LRU map. */
> +	skel = setup_prog(BPF_MAP_TYPE_LRU_PERCPU_HASH, &map_fd);
> +	if (!ASSERT_OK_PTR(skel, "setup_prog"))
> +		return;
> +
> +	err = fill_values_percpu(map_fd);
> +	if (!ASSERT_OK(err, "fill_values_percpu"))
> +		goto cleanup;
> +
> +	/* Insert new element at key=3, should reuse LRU element. */
> +	key = 3;
> +	err = trigger_tp(skel, key, NEW_VALUE);
> +	if (!ASSERT_OK(err, "trigger_tp"))
> +		goto cleanup;
> +
> +	/* Lookup and delete element 3. */
> +	err = bpf_map_lookup_and_delete_elem(map_fd, &key, &value);
> +	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem"))
> +		goto cleanup;
> +
> +	for (i = 0; i < nr_cpus; i++) {
> +		if (bpf_percpu(value, i))
> +			val = bpf_percpu(value, i);

See previous bpf_percpu comments...

> +	}
> +
> +	/* Value should match the new value. */
> +	if (CHECK(val != NEW_VALUE, "bpf_map_lookup_and_delete_elem",
> +		  "unexpected value=%lld\n", val))
> +		goto cleanup;
> +
> +	/* Check that entries 3 and 1 are non existent. */
> +	err = bpf_map_lookup_elem(map_fd, &key, &value);
> +	if (!ASSERT_OK(!err, "bpf_map_lookup_elem"))
> +		goto cleanup;

ASSERT_ERR?

> +
> +	key = 1;
> +	err = bpf_map_lookup_elem(map_fd, &key, &value);
> +	if (!ASSERT_OK(!err, "bpf_map_lookup_elem"))
> +		goto cleanup;

ASSERT_ERR?

> +
> +cleanup:
> +	test_lookup_and_delete__destroy(skel);
> +}
> +
> +void test_lookup_and_delete(void)
> +{
> +	nr_cpus = bpf_num_possible_cpus();
> +
> +	if (test__start_subtest("lookup_and_delete"))
> +		test_lookup_and_delete_hash();
> +	if (test__start_subtest("lookup_and_delete_percpu"))
> +		test_lookup_and_delete_percpu_hash();
> +	if (test__start_subtest("lookup_and_delete_lru"))
> +		test_lookup_and_delete_lru_hash();
> +	if (test__start_subtest("lookup_and_delete_lru_percpu"))
> +		test_lookup_and_delete_lru_percpu_hash();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c b/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
> new file mode 100644
> index 000000000000..3a193f42c7e7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +__u32 set_pid = 0;
> +__u64 set_key = 0;
> +__u64 set_value = 0;
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 2);
> +	__type(key, __u64);
> +	__type(value, __u64);
> +} hash_map SEC(".maps");
> +
> +SEC("tp/syscalls/sys_enter_getpgid")
> +int bpf_lookup_and_delete_test(const void *ctx)
> +{
> +	if (set_pid == bpf_get_current_pid_tgid() >> 32)
> +		bpf_map_update_elem(&hash_map, &set_key, &set_value, BPF_NOEXIST);
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
> index 6a5349f9eb14..f33fb6de76bc 100644
> --- a/tools/testing/selftests/bpf/test_lru_map.c
> +++ b/tools/testing/selftests/bpf/test_lru_map.c
> @@ -231,6 +231,14 @@ static void test_lru_sanity0(int map_type, int map_flags)
>   	assert(bpf_map_lookup_elem(lru_map_fd, &key, value) == -1 &&
>   	       errno == ENOENT);
>   
> +	/* lookup elem key=3 and delete it, than check it doesn't exist */
> +	key = 1;
> +	assert(!bpf_map_lookup_and_delete_elem(lru_map_fd, &key, &value));
> +	assert(value[0] == 1234);
> +
> +	/* remove the same element from the expected map */
> +	assert(!bpf_map_delete_elem(expected_map_fd, &key));
> +
>   	assert(map_equal(lru_map_fd, expected_map_fd));
>   
>   	close(expected_map_fd);
> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> index 51adc42b2b40..dbd5f95e8bde 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -65,6 +65,13 @@ static void test_hashmap(unsigned int task, void *data)
>   	assert(bpf_map_lookup_elem(fd, &key, &value) == 0 && value == 1234);
>   
>   	key = 2;
> +	value = 1234;
> +	/* Insert key=2 element. */
> +	assert(bpf_map_update_elem(fd, &key, &value, BPF_ANY) == 0);
> +
> +	/* Check that key=2 matches the value and delete it */
> +	assert(bpf_map_lookup_and_delete_elem(fd, &key, &value) == 0 && value == 1234);
> +
>   	/* Check that key=2 is not found. */
>   	assert(bpf_map_lookup_elem(fd, &key, &value) == -1 && errno == ENOENT);
>   
> @@ -164,8 +171,18 @@ static void test_hashmap_percpu(unsigned int task, void *data)
>   
>   	key = 1;
>   	/* Insert key=1 element. */
> -	assert(!(expected_key_mask & key));
>   	assert(bpf_map_update_elem(fd, &key, value, BPF_ANY) == 0);
> +
> +	/* Lookup and delete elem key=1 and check value. */
> +	assert(bpf_map_lookup_and_delete_elem(fd, &key, value) == 0 &&
> +	       bpf_percpu(value, 0) == 100);
> +
> +	for (i = 0; i < nr_cpus; i++)
> +		bpf_percpu(value, i) = i + 100;
> +
> +	/* Insert key=1 element which should not exist. */
> +	assert(!(expected_key_mask & key));
> +	assert(bpf_map_update_elem(fd, &key, value, BPF_NOEXIST) == 0);
>   	expected_key_mask |= key;
>   
>   	/* BPF_NOEXIST means add new element if it doesn't exist. */
> 
