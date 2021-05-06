Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C73374F28
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 08:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhEFGJ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 May 2021 02:09:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6560 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229560AbhEFGJ5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 May 2021 02:09:57 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14664Uqv013843;
        Wed, 5 May 2021 23:08:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Pw9F49M+Nkg/eGx/DCx5HO8r/F1V8Qic+f2cUrflKkY=;
 b=fc3u8+uZdts4a8uhBDkOnjVfVp+7augLpk05cJqrGTUeu2o1AI+L+9auyT5gahlLxutz
 04dG9MH1afhyOx5dijifXgnChcZU7mMVoss4k8Bh71XpSAU0dtT47uiQ+wIFWRzyGlWN
 axO8rEgz7/qi38yZFHq6P1yxPNJmim8IwTo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38bedr0482-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 May 2021 23:08:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 23:08:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBGgNSA86M0cCbxZR5VzrY34vma5bTmS3lOaAe5Gb6CbV5u94RzUxi1cbjOudJM/ZnfY89r+e9y9jFfIJscdJgZ+gIK3J3KANXCqV3yxzALgTBn+2ihDybcL85HY9eKX0kei1Ud0UOnlZEX7dQEIVAhfbNf/2iXaMJny52s8eu6YMsm2QJq8NTTKXtAUBnfRjAYBxcd6QY6nIQVb0WwsVAWRQzezYXLWykf0eOM4KqVyxTJfhWnId1EozULxDEc6l7da6vADOtXWaZfBr0Jp/ALmaXElaNuiw/yzKaBbOqZuzNZ614saw2XvmiVk9Ld61z/S8BzkZLAcJ+IxPTk40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw9F49M+Nkg/eGx/DCx5HO8r/F1V8Qic+f2cUrflKkY=;
 b=KF5W283zTXTyt0wQrg5rwbJQYha42fNEpENuqQKQz++9oBVX11F6v/4F8yHrOFraHEMeZbvllx4ye41QCJuA6ImZwHG8w8Ic4LtzJAwWSU7H4Gf91uEfPHyS6BjdoSt2NR4JKSTsCx/15kukZ2KYjezDytr8c0vn+Z4wEtCMlmNrPkr8n0pMi74bvxdRC3MhEMZXMnxcClyA39xAkfAke5SRT2qWVQ6KSO0W6WABSUG4e/9xHfS4fY5B8TXf+EGvR22UNtaYKqV/aQ0VVOqlJy8YcoyWFlv8FbbDir6sC2nRKM7Rm20cDudiiqqjepA5TV2ApV/ReSkVJmjy0OlTJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: iogearbox.net; dkim=none (message not signed)
 header.d=none;iogearbox.net; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4903.namprd15.prod.outlook.com (2603:10b6:806:1d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Thu, 6 May
 2021 06:08:43 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.4087.044; Thu, 6 May 2021
 06:08:43 +0000
Subject: Re: [PATCH v6 bpf-next 3/3] add bpf_lookup_and_delete_elem tests
To:     Denis Salopek <denis.salopek@sartura.hr>, <bpf@vger.kernel.org>
CC:     Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20210505094028.22079-1-denis.salopek@sartura.hr>
 <20210505094028.22079-3-denis.salopek@sartura.hr>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <132c64d9-50c1-f7b7-caf9-3688b65c748a@fb.com>
Date:   Wed, 5 May 2021 23:08:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <20210505094028.22079-3-denis.salopek@sartura.hr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:ea17]
X-ClientProxiedBy: MWHPR2001CA0020.namprd20.prod.outlook.com
 (2603:10b6:301:15::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::13e3] (2620:10d:c090:400::5:ea17) by MWHPR2001CA0020.namprd20.prod.outlook.com (2603:10b6:301:15::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 06:08:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 725ad7e3-8e19-427a-980f-08d9105566e3
X-MS-TrafficTypeDiagnostic: SA1PR15MB4903:
X-Microsoft-Antispam-PRVS: <SA1PR15MB49033303A1A613C08F7E7479D3589@SA1PR15MB4903.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: we7EQ7yhWQSPXVY9MkgxyKa4wtMLdbDJ/pBNX1VR0So3Tfth8SqMF6FqF+sX8cchMnG2O+ZcbSdw+mQAE5D+TqK7NWqDoMa+b/BrzYCECPs/Map7KORAme8NDDU99z6fpjkPtq0x1kqFlxOUlfa/tn6Kph4piCQZMhfN/kdC6RVBYUGLtglacduNnuvTiok/zZGRK1lb2TcUiMLtq6IzV/CNvFt+i3b7WPe8Anf7Ix8NKZOT7BoAVAL0TeC+7L+4ymfQY40xqJMflGNy4Xnpv3AwzzAXaWUJFOR+HAhX5YFBaSJyXfIyHdOoeU9FdrP5Hii16kuPV5pZGTuVBzX6dpctXP3Yy2uvBlczlDXDP+tMn127pUEB/ainuzSCofj1NrGVbPeGvSLex24MSmBFxyG2UNjGGQkxk6H5gEXuTYrpVcuAxLI8l1gjpYkIL0zACwYDQVVlc/38OMO3NogXoH6j5IsY4lpNph/MOQTXmfRUcLzhGYXU4Q+k3BOJ96kLnfFVTaSH9F4aufJ0qdF3nILO0tuBeEAsotUfGhtSxWHyFkTDGmPGdOPAcFzc317xkTMX2Zm2zDjF+sMqS39fUWtVEXdq6EHtYVLoi3wA/BCpUldSSH+D4fNYbX61x8gaIk8p0o2nCs41kugECtJlPrXIY2Q4HyRGk5I5Sw9vn+LI6kSH4QJIcQSowEjJLnvkypnMIAvhH1EADS+R7PQ/wPzCoj38RB2ww445Pw5SEapIcym3XGjHKf4Ge//ZaSb5Vvr5BRsqp39QxED4vv9HvbO8kvnBaWssCeeL3Kx58J0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(2616005)(478600001)(38100700002)(83380400001)(966005)(66476007)(316002)(31696002)(53546011)(36756003)(6666004)(52116002)(31686004)(66946007)(2906002)(66556008)(16526019)(5660300002)(8676002)(54906003)(6486002)(86362001)(186003)(4326008)(8936002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eFQwRmt5bTVWSU9FM0tLSXk4VnVlTGQ1cjVoSHRxdlFGZVpYeTFwaDh4eTlX?=
 =?utf-8?B?RDQvQTJ5M2FYN3AzMzZUeUJLSnFSb3lVOEVWUE5ESXR1Sjk4dUE4c3gzYkl6?=
 =?utf-8?B?c2thZXBBOENVaGxGNGJuVzZNTmcyOU9TeHhEN0hDV2VqTVRwOWI1bTdlQ2xD?=
 =?utf-8?B?dnhSbThlV1EvZEpzWFJYTjc2NEhlTEc5dERHVXlwNWNJVmFUNU9tMkRWYzNn?=
 =?utf-8?B?TkNDR0tGWDNFZGFRZFFudFRiQ2YxcUJXeUJ2bHo4UVhQbFhOajZSRGY5dHVl?=
 =?utf-8?B?SjJqY01jWmF0M1hCNjdvN3lUL05SS3Rpckt0NS9XVzZpMlRTTm90RnFJUjVV?=
 =?utf-8?B?Q1lYbWxzUW5JbWZNaUZ2UEpZa3JjN0hzbmJYMEZlcnFPWVBYYWExZk5QUzBG?=
 =?utf-8?B?VU4wNm10R2prbTRjMEZKY0JkN0NsK091NEV6bWRoOGJpZUsxa1FDL0Z5aHAr?=
 =?utf-8?B?VWsyckxyY3orWjZWNWZGWXUvdW9MNy9FcDB2d0o1ZnhFVDVEVUpxSzY3dGtI?=
 =?utf-8?B?ZkZjTFEzd2lZbmN6aWNJaU13UkdnTVlpQ0txVEtiRzZoenhrYjhHTE8xOU5F?=
 =?utf-8?B?UGlKUXJUWENzV3BYTCt0aEFwOTdEV0pDZk9hYk8vOWhKc3dBRmdFNnhlellw?=
 =?utf-8?B?WVp5cnRaUGlFSXdaWS9JRU01cWI0TFJqWkhrbFQ0OUxwZnhhM0lPQktlRU8y?=
 =?utf-8?B?aTVHektYcUl6YmxtR0lxOExYa0ZNejlDcGx5WDZjQ05razhFbVdqZHVJcEQ0?=
 =?utf-8?B?NzhsTVB3SThsL2Y4SlBiR3QxTVhoOFl5MmFsZmFXbHRmZ2JhQXl5c0psbzRN?=
 =?utf-8?B?OTJONVlvSXZEZmtzSm4zM3Vpd2duRmFIWE1PN0dCU2I4SzFXWTc2dUJmWDFx?=
 =?utf-8?B?RUltLzVHQ3lqbWd4bm9hZSszWjl5QWxZd3QxKytoUmExYlEybkhBYkVDS0kx?=
 =?utf-8?B?ZVY3NlZoenJKVFVlbkl6aG91dGNmd0xDdXpHMC9kL0xSUXdIRk9RYUZRQlhr?=
 =?utf-8?B?b3FxcjdrWEQ3T0tiMDBZYm5Mb3VMK0ZYcW5IM09ORHowcVU1RjArUGI5cDc1?=
 =?utf-8?B?Y3EzWm1JTlZvajNBSllYQ3EzS3hXK2FzS2R2aGE5Y3k0VVZiU1pQbThxbVU5?=
 =?utf-8?B?K1ViSzY0NUVIY2kxeWtoc0krUk9aOFowaDVBL0FRYmF1VjJGbCtNN05iV0lQ?=
 =?utf-8?B?czFJVVJnNFlXc1A3QkptUVV5OE5tQ0x2SGR4YnhIN1NEOHExbU95NGUvUkVS?=
 =?utf-8?B?bmpickoyWDZuR1EweDVTM29qZWQzOHlPMS9HZDV6Sm13WUdCOWREd2RUK2dP?=
 =?utf-8?B?VnZlUjhzMi9oTTJTOUc3UCtxcS9lWTQwOW9TZ0ZhMG9HWFZSTHlWeTd5ZVd4?=
 =?utf-8?B?NTVKNU9qQktBUXJGZGhmYWloak91dWJoNUJIU2xRbktEclo5aFNiQmRTcU93?=
 =?utf-8?B?dnEwNTNYTGE3Y1VIU0Mwc1pvVHBodFVSWlF3dzFMRkZoV01jZTF1bG82L0JY?=
 =?utf-8?B?UytsTjArWW9xYVZhSjBlZDFaVEI5WW5CT3ExNWxTMC9TNzF6YTE3V2VhTzV2?=
 =?utf-8?B?enVadDd0SkNQK2dtaXpQWVMzMUtTUHRhK3NPYUg4U1pFdG5GOWtSVm5OMnpC?=
 =?utf-8?B?UHRIME1yZXN0QUkvVlZYQit4M2NuZWN2U0tBR1pDbmFCLzNldFlzR0hCM0hF?=
 =?utf-8?B?Vnp6djNpS3BPMWtiSHRsbWpBMkVqMWxuaGlUVXBIUHZPT21tT3ZQbUpqekh2?=
 =?utf-8?B?ODBsdHNIeGNyeEx5ZFlmSnk3bE53ejNScDVBbDBrM2hXbklEeVY0SEJMY0Fm?=
 =?utf-8?B?eFFBZ0Y3Tlk0RmtwNHU0UT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 725ad7e3-8e19-427a-980f-08d9105566e3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 06:08:43.5191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+CiFRiivgfT2g8wlHKTZTxZFoowH7BIy5IaFeiYRZK0sFdZ6/QehPHQbzC1kDzN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4903
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: YlhFJyX-3vwFvjWTWuCTf-w2Oi87s5gk
X-Proofpoint-GUID: YlhFJyX-3vwFvjWTWuCTf-w2Oi87s5gk
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_05:2021-05-05,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060041
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/5/21 2:40 AM, Denis Salopek wrote:
> Add bpf selftests and extend existing ones for a new function
> bpf_lookup_and_delete_elem() for (percpu) hash and (percpu) LRU hash map
> types.
> In test_lru_map and test_maps we add an element, lookup_and_delete it,
> then check whether it's deleted.
> The newly added lookup_and_delete prog tests practically do the same
> thing but additionally use a BPF program to change the value of the
> element for LRU maps.
> 
> Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
> Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>

Ack with a few nits below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
> v5: Use more appropriate macros. Better check for changed value.
> v6: Remove PERCPU macros, add ASSERT_GE macro to test_progs.h, remove
> leftover code.
> ---

Again put this right before "diff --git ..." or
in the cover letter.

>   .../bpf/prog_tests/lookup_and_delete.c        | 288 ++++++++++++++++++
>   .../bpf/progs/test_lookup_and_delete.c        |  26 ++
>   tools/testing/selftests/bpf/test_lru_map.c    |   8 +
>   tools/testing/selftests/bpf/test_maps.c       |  17 ++
>   tools/testing/selftests/bpf/test_progs.h      |  11 +
>   5 files changed, 350 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
> new file mode 100644
> index 000000000000..b36befd37384
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
> @@ -0,0 +1,288 @@
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
> +	__u64 key, value[nr_cpus];
> +	int i, err;
> +
> +	for (i = 0; i < nr_cpus; i++)
> +		value[i] = START_VALUE;
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

Maybe just use ASSERT_OK_PTR? You used it in below function
test_lookup_and_delete_hash().

> +
> +	err = bpf_map__set_type(skel->maps.hash_map, map_type);
> +	if (!ASSERT_OK(err, "bpf_map__set_type"))
> +		goto cleanup;
> +
> +	err = bpf_map__set_max_entries(skel->maps.hash_map, MAX_ENTRIES);
> +	if (!ASSERT_OK(err, "bpf_map__set_max_entries"))
> +		goto cleanup;
> +
> +	err = test_lookup_and_delete__load(skel);
> +	if (!ASSERT_OK(err, "test_lookup_and_delete__load"))
> +		goto cleanup;
> +
> +	*map_fd = bpf_map__fd(skel->maps.hash_map);
> +	if (!ASSERT_GE(*map_fd, 0, "bpf_map__fd"))
> +		goto cleanup;
> +
> +	return skel;
> +
> +cleanup:
> +	test_lookup_and_delete__destroy(skel);
> +	return NULL;
> +}
[...]
>   	/* BPF_NOEXIST means add new element if it doesn't exist. */
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index dda52cb649dc..cae012e56d53 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -210,6 +210,17 @@ extern int test__join_cgroup(const char *path);
>   	___ok;								\
>   })
>   
> +#define ASSERT_GE(actual, expected, name) ({				\
> +	static int duration = 0;					\
> +	typeof(actual) ___act = (actual);				\
> +	typeof(expected) ___exp = (expected);				\
> +	bool ___ok = ___act >= ___exp;					\
> +	CHECK(!___ok, (name),						\
> +	      "unexpected %s: actual %lld < expected %lld\n",		\
> +	      (name), (long long)(___act), (long long)(___exp));	\
> +	___ok;								\
> +})

Andrii just added a definition ASSERT_GE in
   7a2fa70aaffc   selftests/bpf: Add remaining ASSERT_xxx() variants
   https://lore.kernel.org/bpf/20210426192949.416837-2-andrii@kernel.org

so there is no need to add ASSERT_GE any more.

> +
>   #define ASSERT_STREQ(actual, expected, name) ({				\
>   	static int duration = 0;					\
>   	const char *___act = actual;					\
> 
