Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379AA413D81
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 00:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbhIUW0J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 18:26:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13870 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229804AbhIUW0J (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 18:26:09 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLHCsZ005963
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 15:24:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=nRMmrxN9z/gY/H6NQCycS5MAEq2jesbzr3MESEVAZa8=;
 b=rjURsf8ZYLKSGR6ZeLB1bdB8MrILdAudPx62ScL4WKFncRvmZQlY5OSw/6Mshi7r+R1h
 AvXS2iwhVR3LDjyC+wsR61GfTxOPMqUlGYOwj7e3nYeihbUHBGrqzDuNl+AnTd4MrzJp
 W26Ctr5JKxIA8beQx02MmKUGZK2h3BRWtv8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q61gdgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 15:24:39 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 15:24:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmthTzOc1VXJ4jshxMm97iwGRbhuzWBog9xu3QDiqoe93nyqXZ3tKiBkuVuFTQ2pvVMZ/gsUA9UfyFTIKo4BX2Kurs/9OD/JOYO5IKGFlngT1qZEsBUW/fE/1kK1ZqJbU5qszPx2VvxT1W0umtFK45ebJNVPWzLFuaW07TLJ3Ok+ZlLyaV7HhpyQ/E2iw7t/Bw60pEa7K+y/ZBg0sA0mV6DK9CWaIwXPqXvdxkXka7Zo2GuHQ2OPCtJZn9oQPglV6I4fNcfOj9hMljqpyGHaokogLic0VBtXYCrRcjT/xc1JsMKBewFaq2gJ/FkcTuBBeaFR4oFXAtgOeqPMR8Ik5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nRMmrxN9z/gY/H6NQCycS5MAEq2jesbzr3MESEVAZa8=;
 b=W6FJovY6zJBsobEpBWHPSCU/+hH+llekDG1KnV9r8ZwVhlstQz8tonsh1BMuWJrQlpkPqiDu506E7G20koqoj1435hTH7hx+Qr6GOTO4TGDZQC2HqLqT+FhlKjTwIbfLqiGZkOh2YrMOkNJzGlTuymBwXUiBjsnS6a9C7SXwtw9xJKdo0E5gc9OXWHULa4l6Zo++INyMstqDGxkz2QPJWujMl3QHkVL3RjUfB32R0TdvB25HNqFYw7hdScCQSBXi3OcJsVdxm6fqeb7djeYOGjyJGk/pl++NF/0dI4dlLt3/4gLM69YL8WTZzgi05fvdO6eTC/0Lq28WkvKyTTAb3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SA0PR15MB4031.namprd15.prod.outlook.com (2603:10b6:806:84::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 22:24:38 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe%9]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 22:24:37 +0000
Message-ID: <9d26bf60-6a74-f994-d199-1babcd4b1943@fb.com>
Date:   Tue, 21 Sep 2021 15:24:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v3 bpf-next 2/5] libbpf: Allow the number of hashes in
 bloom filter maps to be configurable
Content-Language: en-US
To:     <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>
References: <20210921210225.4095056-1-joannekoong@fb.com>
 <20210921210225.4095056-3-joannekoong@fb.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <20210921210225.4095056-3-joannekoong@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR15CA0043.namprd15.prod.outlook.com
 (2603:10b6:300:ad::29) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c8::14e1] (2620:10d:c090:400::5:14a) by MWHPR15CA0043.namprd15.prod.outlook.com (2603:10b6:300:ad::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 22:24:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5b70036-2324-4b64-80ee-08d97d4e98c8
X-MS-TrafficTypeDiagnostic: SA0PR15MB4031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB4031BCF155672366B7CE6A66D2A19@SA0PR15MB4031.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRYAnh7iBk9Lj8KxlU7kSVMFc1X8Un3Ha71/+QkOzP82+LG0VpZ5nbeVw4zXQAUo+8jGiYaT/xs2PDm59orhjDuZj2MiFfIa2nklSM+nMr82GY/g/3PDF8j2QlrGiCVwyLtBI5RVdTF7Noj47k8zXw+60+1g6KnbO26yHcsiCZYT2AwqE9PgyxktTx4B4GGGGg5TbbULr4+1xih4N9+HXeff9/VrgZg4vyGudpj2HR1u9G9xYgAb/nUau99m6xScOuHM3gS0IRjiGNP+HqO7A2JIuyL9PXxrZ3Knd8ozUFPndd9Ux5nTGpz93PFlUK7tH6gIgTIr8j+Yt4x3KsbqcSDvelsTh5QUYOcknaPxJ3J0iins+9q8WLFRdvKxp/lwa5EyzQS3btClfQ1Xv8suSr5Qh0k9IjasOgF9V6yKyT6RZnGzEhfs0ESo6nMaXg/AFgF8IuJ63IsOGUygdsDpZxo/gjrAVcfhwYLNWpjnm469G0cQmhhQmsVaWStinnYER/E0vMA8L6r45rXmrsd7jaib3Tj9ftMgVcyIpq3X0HcL90luGqwPGg5c2WsZk85w4W6J7Tbopxgw3hg8lgbl69Bxcy0NzFhpavdni4O8KUPtEA1KTO00CnlYnMIvd7ugXWgiw28q7IZ3OECSI937Qbo6qrl4A1Jc1edoXMzTe6bxl+e3XYjORX8TQXO4vC5h9qpz1zincHPllG6YJN7Hb29mw4WDNFlKEXW0YtuJit4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(31686004)(66556008)(186003)(66946007)(6486002)(4326008)(53546011)(66476007)(6916009)(2616005)(83380400001)(86362001)(8676002)(2906002)(508600001)(5660300002)(316002)(8936002)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vkk1RHNHVC8yRmZSNm0zeXNRTk5WcldTOTRISWZyU3FjWVFLNkFGdmJISjdL?=
 =?utf-8?B?YXh4RFFLZ2dzVTJkbW5wZFFhREgzdHdqd2hKbXoxeVI5dHphaTRJckhaVjR1?=
 =?utf-8?B?b3ZPT04yVmdsdG00eGZmcHBSZEMwYlpydTRaVEpQaXFnQWJGdDZKN3hTRUFv?=
 =?utf-8?B?LzBkSWwxam9vRytFblRCYy9KM3RudVQvQWVVeWlmQTUxdHRLWmhsR0FXNHJX?=
 =?utf-8?B?RlZBSFVOcjZDYnBsU2RkQWNvZGJaM0JIMVJsaGpjZWlYWk9WN09HVi92RWt0?=
 =?utf-8?B?Mi95b2EvNkY0bzJEQlF3d1o2R28vQ0Z6bEo4bTJOc0Z4RFRwQXdOcUhQdzRC?=
 =?utf-8?B?cm5iUW16U0x0NTRyTFJVZ0NROTNkWWVhcTIzOGpKN3RibzUzWDZaU2ZvZElM?=
 =?utf-8?B?S2Fka1MzcXdWZU55SHNRcUJTdFkxRG5QcUJLYXlkT1FwTWdYb0FXbE1HUmZ4?=
 =?utf-8?B?aExnbnBYS29US2tkZXVPS0FEc2JDRjhyRk9sQ1hMVU5IemVyUlRPaVNrekxQ?=
 =?utf-8?B?NjhJbDc4K0ZYMTN0V05rSlJxVGY1OEloVUNDelB6ekxKU3N1eGpzS2Y1NkZ1?=
 =?utf-8?B?RXBETU8xOVJnSDNXNTFVRnJuUmJQR25ZalBqNkFQMFQ3WU1JdFZjU2Yram1W?=
 =?utf-8?B?WS9hOERIaFlFQnJjbW1XNVpHbVp6REozWmwrbGtzM0MwNkd0eGlxU1liZU1O?=
 =?utf-8?B?U1ZoUmtudld1eG1CZFBwckVVUGd0c3JWMWNkTDZad1Y0YW5sb0RHQUlaa2or?=
 =?utf-8?B?SlUxK3VlUnJCNE1OVXgvQ3QzODBYM2VWcE53TmM0Q2VnNkdRZTM2cXBhaDdj?=
 =?utf-8?B?Rm5ObVkzNElLVUtucU9zVVkyMU9TK2w5dXNuMkppSUp1V0JVcVNxNUpzMENk?=
 =?utf-8?B?ekJqWWN5bC95UGQ2czNvZ2xpVmhVN3c5cThiN3BRUkdVaVJ2KzlOMlJUVVdD?=
 =?utf-8?B?UkxiUmpSWmlRQW9qWTFManAySlh2SEp4YjJHNUtQSHlWSjVvNzNtTXBjWWZv?=
 =?utf-8?B?aHlBMnhCNmdtcFBMcGFXQy9oSzVqMDQrUnpsYy9MWkU3dERVYThaT3hqelFp?=
 =?utf-8?B?SUFETzZVVHduY2grRnN3bFA3UjBiYzREVS9KbHB4WkNqSko3WU1kdHN0T3NP?=
 =?utf-8?B?OWhUVngxbkdPZk5vQitqaDJGR3dDMEZ4VzNON3J0WDRjUTQwOEhRWmRuSkVr?=
 =?utf-8?B?WWdJRmlJM0I0alhySzNtL2pHRjM0aklFRVBOQTNWU3NORnFucGhTM3dnWkhZ?=
 =?utf-8?B?WlFhRE51cUlzTFpwd3dBSDdwSFFZZWlncTFTOEg1d1VzUWtZOGMwT25KQk1J?=
 =?utf-8?B?MlJ4ZFZNN1FrNXBCcGFhN3JVVEhIbVVPbTNNYnNKT1FwbmtFWmlWdHZIaG04?=
 =?utf-8?B?M3lSQ2hndVJmSFNqTTNLbk5pR3FSNU8zSWpkRGtpNURLUCtKd0JvcndaSVNP?=
 =?utf-8?B?ejk4VW5rM0UraVJlS2UxaTJtM3lybXF2UUl3dytWMlJzOEtaSnkzby9mUzFO?=
 =?utf-8?B?NWphWXZFeDBIMHhWSlpQOHBNTGVjWnVpMEtxRGZMY3BJMHhSUkR2bUd0YTdN?=
 =?utf-8?B?ME9PT2FwSlBCUzBDbGZBSWMxSGFhWTk2TkF3MU1Ud1lFMldZd2J0cUxxblYy?=
 =?utf-8?B?TTdWeUxZeElVR2lFaUJOWDhQcWNqeUtXbEVlUloxOVczaFlhMTZJRGxmanZT?=
 =?utf-8?B?aFRCUGVNbzJ2NmRlaWVZM1JyNytNTHVUYTNOVnhWcmw1N296RlJRYmxMZGNz?=
 =?utf-8?B?cFFDZUNXQ2ZZSWJhM251UzJrRmhqTGFVUENFR2RPSmtOell2S2l3cGQ1ZWpz?=
 =?utf-8?B?Q3ZhQnMxSXlMbGJEZEpBUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b70036-2324-4b64-80ee-08d97d4e98c8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 22:24:37.5256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQnRiesnEtyK831kB8P0DPepiccsvMrq5nuiBI+EY/a+awQbmeNxo44nBVyHHy1WnIATUqPhvKDzc5DWdpDaJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4031
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 82Hng7zLJo-_EWpnuQX3MAlEIqY3K43v
X-Proofpoint-GUID: 82Hng7zLJo-_EWpnuQX3MAlEIqY3K43v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109210133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 9/21/21 2:02 PM, Joanne Koong wrote:
> This patch adds the libbpf infrastructure that will allow the user to
> specify a configurable number of hash functions to use for the bloom
> filter map.
>
> Please note that this patch does not enforce that a pinned bloom filter
> map may only be reused if the number of hash functions is the same. If
> they are not the same, the number of hash functions used will be the one
> that was set for the pinned map.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---
>   include/uapi/linux/bpf.h        |  5 ++++-
>   tools/include/uapi/linux/bpf.h  |  5 ++++-
>   tools/lib/bpf/bpf.c             |  2 ++
>   tools/lib/bpf/bpf.h             |  1 +
>   tools/lib/bpf/libbpf.c          | 32 +++++++++++++++++++++++++++-----
>   tools/lib/bpf/libbpf.h          |  2 ++
>   tools/lib/bpf/libbpf.map        |  1 +
>   tools/lib/bpf/libbpf_internal.h |  4 +++-
>   8 files changed, 44 insertions(+), 8 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index fec9fcfe0629..2e3048488feb 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1262,7 +1262,10 @@ union bpf_attr {
>   		__u32	map_flags;	/* BPF_MAP_CREATE related
>   					 * flags defined above.
>   					 */
> -		__u32	inner_map_fd;	/* fd pointing to the inner map */
> +		union {
> +			__u32	inner_map_fd;	/* fd pointing to the inner map */
> +			__u32	nr_hash_funcs;  /* or number of hash functions */
> +		};
>   		__u32	numa_node;	/* numa node (effective only if
>   					 * BPF_F_NUMA_NODE is set).
>   					 */
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index fec9fcfe0629..2e3048488feb 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1262,7 +1262,10 @@ union bpf_attr {
>   		__u32	map_flags;	/* BPF_MAP_CREATE related
>   					 * flags defined above.
>   					 */
> -		__u32	inner_map_fd;	/* fd pointing to the inner map */
> +		union {
> +			__u32	inner_map_fd;	/* fd pointing to the inner map */
> +			__u32	nr_hash_funcs;  /* or number of hash functions */
> +		};
>   		__u32	numa_node;	/* numa node (effective only if
>   					 * BPF_F_NUMA_NODE is set).
>   					 */
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 2401fad090c5..8a9dd4f6d6c8 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -100,6 +100,8 @@ int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
>   	if (attr.map_type == BPF_MAP_TYPE_STRUCT_OPS)
>   		attr.btf_vmlinux_value_type_id =
>   			create_attr->btf_vmlinux_value_type_id;
> +	else if (attr.map_type == BPF_MAP_TYPE_BLOOM_FILTER)
> +		attr.nr_hash_funcs = create_attr->nr_hash_funcs;
>   	else
>   		attr.inner_map_fd = create_attr->inner_map_fd;
>   
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 6fffb3cdf39b..1194b6f01572 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -49,6 +49,7 @@ struct bpf_create_map_attr {
>   	union {
>   		__u32 inner_map_fd;
>   		__u32 btf_vmlinux_value_type_id;
> +		__u32 nr_hash_funcs;
>   	};
>   };
>   
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index da65a1666a5e..e51e68a07aaf 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -378,6 +378,7 @@ struct bpf_map {
>   	char *pin_path;
>   	bool pinned;
>   	bool reused;
> +	__u32 nr_hash_funcs;
>   };
>   
>   enum extern_type {
> @@ -1291,6 +1292,11 @@ static bool bpf_map_type__is_map_in_map(enum bpf_map_type type)
>   	return false;
>   }
>   
> +static inline bool bpf_map__is_bloom_filter(const struct bpf_map *map)
> +{
> +	return map->def.type == BPF_MAP_TYPE_BLOOM_FILTER;
> +}
> +
>   int bpf_object__section_size(const struct bpf_object *obj, const char *name,
>   			     __u32 *size)
>   {
> @@ -2238,6 +2244,10 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
>   			}
>   			map_def->pinning = val;
>   			map_def->parts |= MAP_DEF_PINNING;
> +		} else if (strcmp(name, "nr_hash_funcs") == 0) {
> +			if (!get_map_field_int(map_name, btf, m, &map_def->nr_hash_funcs))
> +				return -EINVAL;
> +			map_def->parts |= MAP_DEF_NR_HASH_FUNCS;
>   		} else {
>   			if (strict) {
>   				pr_warn("map '%s': unknown field '%s'.\n", map_name, name);
> @@ -2266,6 +2276,7 @@ static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def
>   	map->numa_node = def->numa_node;
>   	map->btf_key_type_id = def->key_type_id;
>   	map->btf_value_type_id = def->value_type_id;
> +	map->nr_hash_funcs = def->nr_hash_funcs;
>   
>   	if (def->parts & MAP_DEF_MAP_TYPE)
>   		pr_debug("map '%s': found type = %u.\n", map->name, def->map_type);
> @@ -2290,6 +2301,8 @@ static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def
>   		pr_debug("map '%s': found pinning = %u.\n", map->name, def->pinning);
>   	if (def->parts & MAP_DEF_NUMA_NODE)
>   		pr_debug("map '%s': found numa_node = %u.\n", map->name, def->numa_node);
> +	if (def->parts & MAP_DEF_NR_HASH_FUNCS)
> +		pr_debug("map '%s': found nr_hash_funcs = %u.\n", map->name, def->nr_hash_funcs);
>   
>   	if (def->parts & MAP_DEF_INNER_MAP)
>   		pr_debug("map '%s': found inner map definition.\n", map->name);
> @@ -4616,10 +4629,6 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>   		create_attr.max_entries = def->max_entries;
>   	}
>   
> -	if (bpf_map__is_struct_ops(map))
> -		create_attr.btf_vmlinux_value_type_id =
> -			map->btf_vmlinux_value_type_id;
> -
>   	create_attr.btf_fd = 0;
>   	create_attr.btf_key_type_id = 0;
>   	create_attr.btf_value_type_id = 0;
> @@ -4629,7 +4638,12 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>   		create_attr.btf_value_type_id = map->btf_value_type_id;
>   	}
>   
> -	if (bpf_map_type__is_map_in_map(def->type)) {
> +	if (bpf_map__is_struct_ops(map)) {
> +		create_attr.btf_vmlinux_value_type_id =
> +			map->btf_vmlinux_value_type_id;
> +	} else if (bpf_map__is_bloom_filter(map)) {
> +		create_attr.nr_hash_funcs = map->nr_hash_funcs;
> +	} else if (bpf_map_type__is_map_in_map(def->type)) {
>   		if (map->inner_map) {
>   			err = bpf_object__create_map(obj, map->inner_map, true);
>   			if (err) {
> @@ -8610,6 +8624,14 @@ int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
>   	return 0;
>   }
>   
> +int bpf_map__set_nr_hash_funcs(struct bpf_map *map, __u32 nr_hash_funcs)
> +{
> +	if (map->fd >= 0)
> +		return libbpf_err(-EBUSY);
> +	map->nr_hash_funcs = nr_hash_funcs;
> +	return 0;
> +}
> +
>   __u32 bpf_map__btf_key_type_id(const struct bpf_map *map)
>   {
>   	return map ? map->btf_key_type_id : 0;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index d0bedd673273..5c441744f766 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -550,6 +550,8 @@ LIBBPF_API __u32 bpf_map__btf_value_type_id(const struct bpf_map *map);
>   /* get/set map if_index */
>   LIBBPF_API __u32 bpf_map__ifindex(const struct bpf_map *map);
>   LIBBPF_API int bpf_map__set_ifindex(struct bpf_map *map, __u32 ifindex);
> +/* set nr_hash_funcs */
> +LIBBPF_API int bpf_map__set_nr_hash_funcs(struct bpf_map *map, __u32 nr_hash_funcs);
>   
>   typedef void (*bpf_map_clear_priv_t)(struct bpf_map *, void *);
>   LIBBPF_API int bpf_map__set_priv(struct bpf_map *map, void *priv,
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 9e649cf9e771..ee0e1e7648f4 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -385,6 +385,7 @@ LIBBPF_0.5.0 {
>   		btf__load_vmlinux_btf;
>   		btf_dump__dump_type_data;
>   		libbpf_set_strict_mode;
> +		bpf_map__set_nr_hash_funcs;
>   } LIBBPF_0.4.0;
>   
>   LIBBPF_0.6.0 {
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index ceb0c98979bc..95dbbeba231f 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -186,8 +186,9 @@ enum map_def_parts {
>   	MAP_DEF_NUMA_NODE	= 0x080,
>   	MAP_DEF_PINNING		= 0x100,
>   	MAP_DEF_INNER_MAP	= 0x200,
> +	MAP_DEF_NR_HASH_FUNCS	= 0x400,
>   
> -	MAP_DEF_ALL		= 0x3ff, /* combination of all above */
> +	MAP_DEF_ALL		= 0x7ff, /* combination of all above */
>   };
>   
>   struct btf_map_def {
> @@ -201,6 +202,7 @@ struct btf_map_def {
>   	__u32 map_flags;
>   	__u32 numa_node;
>   	__u32 pinning;
> +	__u32 nr_hash_funcs;
>   };
>   

I just realized that Andrii's comment on v1 stated that btf_map_def is 
fixed indefinitely.

This implies that for bloom filter maps where the number of hash 
functions needs to be set,
we will not be able to use the BTF-defined format and will instead need 
to use the older
map definition that uses bpf_map_def. Is my understanding of this 
correct? If so, I will go
ahead and fix this for v4.

>   int parse_btf_map_def(const char *map_name, struct btf *btf,
