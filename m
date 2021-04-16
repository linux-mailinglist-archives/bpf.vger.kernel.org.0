Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3BD362709
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 19:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243331AbhDPRk1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Apr 2021 13:40:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35341 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242890AbhDPRk0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Apr 2021 13:40:26 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GHX72L005118;
        Fri, 16 Apr 2021 10:39:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=mRRu5BPPJ3A4R4kx4iKO6C3nYSDzdQBwm8iGfxfR9gw=;
 b=FNl6Kx4n5pmi5YC5JVW9UpQWymL3aY7UxDrWEbTZJtrh5v/wg8fxJaHZJUdPdbKtzdPA
 5+an/+XpTExNlt9YIoWOWZKEq8U7PVS8V69uYCuxHjjc5DdXldrzZN7eK/9va2gkIjlp
 6n2cz3n9TBJI8GeNB5Nl+gQ02N595kogVr0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37y7tfjhpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Apr 2021 10:39:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 10:39:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pli7j0QlIlKxbqeq7b3d5emLZLgPaC2g0wrylQvGus6yaE+FUFvYEMgda2iTET49JIExrbBVIcPASWmzsVDq/TxdhlqZHMSeTU7JpMydfVxf2uyNY+BEANubYDKhLv1uIFzq6SzYGSUBQP38GfMuFPNTq+YNNurfppTzSXdoGGDmo7bJqH+g9UxM5s9So6fJjEGWgXkqRyhWfSCmoxBpJuU2vnc8DcLTBav8Z9hO56c+8MRWskde6MJ+iyRUQaudfkT47eXNZIc80JDBWItfiomCpCWMGx71SXZcrqhrfDOKCcO+iB1n1VCYNB9zVbYVm7Pbmw5zY+9ENwlEIOmDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRRu5BPPJ3A4R4kx4iKO6C3nYSDzdQBwm8iGfxfR9gw=;
 b=ZQCZf1n7Lb4kvKchFSTgqC/AIPJhuMSgrYxLBg4Eu6l6EOYNstPuvfGj/L6oUE5cS7b97VwOXnI4F0gEkAel8YdQCQvD39MfQF0SOaaI3iL+DKV/5DM5lAnsyzm3s34Rq5SKzzkh0CdEcLhmm2QupDILP46h2cSkYVHevnD+FZqT45ZinIDXFfhGqKEX9QDwdfqARRlCZcNCT4nJxHgqJ85UaJAkpgTt37vcEXhDotL6uf0TTcfDgkQZCQ7chV/J5IZXFC24hJPFiz2PsmbBxvijnfSl6I+LwnuP43Cim0yg6Az8gLSxIGpnlV9CPOsw+TE357oA9RnkZIy41JzRIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: iogearbox.net; dkim=none (message not signed)
 header.d=none;iogearbox.net; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4338.namprd15.prod.outlook.com (2603:10b6:806:1ad::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 17:39:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.038; Fri, 16 Apr 2021
 17:39:46 +0000
Subject: Re: [PATCH v5 bpf-next 3/3] selftests/bpf: add
 bpf_lookup_and_delete_elem tests
To:     Denis Salopek <denis.salopek@sartura.hr>, <bpf@vger.kernel.org>
CC:     Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20210416095814.2771-1-denis.salopek@sartura.hr>
 <20210416095814.2771-3-denis.salopek@sartura.hr>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <2bc3249f-2d84-5136-9138-cff882d4001f@fb.com>
Date:   Fri, 16 Apr 2021 10:39:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <20210416095814.2771-3-denis.salopek@sartura.hr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:7e08]
X-ClientProxiedBy: MW4PR04CA0048.namprd04.prod.outlook.com
 (2603:10b6:303:6a::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::112e] (2620:10d:c090:400::5:7e08) by MW4PR04CA0048.namprd04.prod.outlook.com (2603:10b6:303:6a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19 via Frontend Transport; Fri, 16 Apr 2021 17:39:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdc35851-6864-4579-e6d4-08d900fea036
X-MS-TrafficTypeDiagnostic: SA1PR15MB4338:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4338568C186D587DDCF0869ED34C9@SA1PR15MB4338.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1zyVRyDgTMCDFndK9UBvbydrBiuO+wxKT9fBbt6F1RMm5rkSliPCHB7M0W3zcpMNeNq9OKxx4GaDd7IciGnjL/CDYDynvgenD860S9Wh3/8gcz5aCEI5f4n1sPbEkEwcX0Otv09ms5RF2QsYapqkDTFnlbSyt8B0iT6ymTGmVcXVTdvYReCu2qv9bHSWGt8xmWOB1poNadpn/QoI6/ex4zccUPrWppilOw4xTZ/NHX8SMYgRJmTAmPaHyiFj/LQIUvzok3SkohstoPlnl7aU/3qGB1HRYa0BySbLvGmGSUdbYQ7pUW+DuQQQ0V4pa3dLmGqomswackqPb99zhAmzAbd70ObQmpsk02ORXdEKqtkLDT/wN35k4be9ERfwA7T4ywLwdWYpSaFYOjnHhDhFdZy1VWbm0g9ompu6vH8oaAgS+REGDTGXIYPsfTOALXmjZJeWXLM6lyHslvla4CebIUd78LQGhX7TiP/Lnkhwnnw80U0TQF6LLWSOok+ZovwxDV3Rdrp5fqW5Ur0teO92xyi6XDvvyE9GsuRaX7/yGTP0DvqmUw1peAgrSOgmjvoyDOgN07h88XB6Ia5pM16iHNaDq8u1auLxk9d2oY8vYR0+4J3YONnSprmjUkcWom8+VPV1ZiBAFUsfpD2vAN4ig8kgBmbcVmcuZM2IQ2Gb89vL7J7qReynGxOskx3FFT1WRqOQHwawdQkNtxlVflkiuHAGkPycH+oWTd0CdLjosHKY34e3L4a3+2wrc9jP859XtT0bJ2wPCQL9jmPbNpGaBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(346002)(376002)(396003)(6666004)(316002)(2616005)(54906003)(38100700002)(6486002)(66946007)(66556008)(16526019)(4326008)(478600001)(52116002)(31696002)(30864003)(53546011)(36756003)(966005)(66476007)(83380400001)(86362001)(186003)(2906002)(5660300002)(8936002)(31686004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S2N0OVN3NkJ2TDNuWnhSS1dDZHVqb0Y2NjRLUkF0SmRGMzBLUFMvNnNKaGRo?=
 =?utf-8?B?TkdybXJ3eGhJdFloUHNteUF6K0VkRFluZ29wSXhhajZFS1FwQ3krczZiQUNn?=
 =?utf-8?B?Q2o0Ly9JSFFwMVdXTEwwMGZpRGNiQW93c1RqZGN6NDJUR2pyb0dETTVpWWgz?=
 =?utf-8?B?R3VFdVBWbjFGQlpINDdtY1ZNYlVHeDloUVVhOCtDNU9jenN3UGRTSTRCRWhy?=
 =?utf-8?B?UGtEZitySjVqSC9KS2daWFAzWVJ4SU9BektnSTNxemFvcnR6QVRhSk9CZDJD?=
 =?utf-8?B?ZjFNUFptVC9xYzMzcTFXSGZvdGk1YjYydW1HdGloQUx0ZDM2VEpHSzZsRFhj?=
 =?utf-8?B?b05Ed2dqbklJZDd4aUY2Qy9QMGY1OExUdkVFdStWU3IrVGsyTTV0QWFtQXdm?=
 =?utf-8?B?VHZHSkR2eXZ4ZkZxbk1RUHFOb3hERWtpbkhHUVEzZjJnMjZveHJoS2tHdzdT?=
 =?utf-8?B?QmNVR0FodkkvVFd1ZWQ4dFQ5ZS9QU083ZEt5Q2pJajVIWGhFSEFpdWEra3dW?=
 =?utf-8?B?RmJSTHlxOVI4a0g3Z0M0Z2I5QVZoS1NBTGU5bUpWbjBndGg0MlpycWlOSTRT?=
 =?utf-8?B?MDhOQkVqTE9hZjFqUElnekIzODhSUTI4RFNUV0ZpK0wyQW9UbGhoZ2tyWDRp?=
 =?utf-8?B?bVJ4U21KTlNXQVFma3B3OHZPZ3RQbzk4QkMvcFYyTi9OUExvOGN0b0ZMN2Zu?=
 =?utf-8?B?cEZ5YlV5Rm4vbkZRaVNXN2FQYzRJdzJlS0NOODJwMTEvdWM1b1BsQ2c3L0Mv?=
 =?utf-8?B?YWhTL2lySFlFT0YzK3NZWGM4MGF2SUFudmVMbW1sUjZHeUlIVDR4ZUhsMEdB?=
 =?utf-8?B?Y3Bkb09oMWhBS0JUZ3VSc3pQSGtHdFhuNWxrVGFKaWRObXRvQm5RUjRoUG1Z?=
 =?utf-8?B?L3RkUHFZRGJWbU9KU1lDbGQ5SHV3cTZlOERlamo4UTA1TDNPcHBhR1A4M3Bk?=
 =?utf-8?B?UGxmM2hHQlVUeERaZkJ1VTF3QUt5d0xMUXdEc29pOXNZRkM3dkpHUklBcVJv?=
 =?utf-8?B?cHRvdTBkbnU5bkFaQ1hxZjYrQWx3OXVQZS9EdGpTYkZQanljYmNSOXlDN1p4?=
 =?utf-8?B?TzVLWWh4dUo4dWRZT3NaRXVMd1QyN3RoMU9nRlNHN2I4MEx1T3puTnpOMVgr?=
 =?utf-8?B?My9sZnMxb1k3NGo3U29jVVMrWUxrN0lyZ05YMXJPYkJmbjRBOGZlQjlPTHhp?=
 =?utf-8?B?V0lkK2g5cCtuaFJhL0ZyYjFPM29KQmhVNlBkYkJ6L3dJaUZOeC82RkFqOHB2?=
 =?utf-8?B?bXNWWllwb0hyTDFPU1JjK0FmczNjQmlwNDZqNjgrc1Z4R0hkVXhaSHorVWVo?=
 =?utf-8?B?ZVM4Z0hiNlRhZjVEeTFpK2tJZmxvZjRHNDIzUXdFRmtySVdlNXJ2Skw3Yk94?=
 =?utf-8?B?aGlpeWs5RTFNMjNidWZFSlhQS0ZNS0VTZ2gwS1EzTVdBRHJpMnhVRmhUMGth?=
 =?utf-8?B?WUsrN3I1eHNhbSs1a3BwRXBhVHdUZnhBbUVvekhNUm1PNUlmd3g2cFJ0c0la?=
 =?utf-8?B?ZUw4QkJtMjBuKzF4LzNRU202dHRHamtkVENoK240L2lzaENFN0Q1aW0wZXpN?=
 =?utf-8?B?Z2NJbEdGemJ3c1FiM0hqb3dUMktiWm8zdkZDR0UvQWRLWk5VRGhQb245ZXcw?=
 =?utf-8?B?aXhvdm51OEhqdWh4aEwrMGlFb0RsbHNwMlViaWczYjd5Qml4MytrYkg5a204?=
 =?utf-8?B?N3FheEg0eVA1V1lMMEFKSmhwMVFHNkl4ejZ1d3N3enJUNmluRFdVV2o2OEZs?=
 =?utf-8?B?Q1JmdEwxN08yWjFDNlVFbUhmblNYb3FXUUFiQktBL3RmM05sb0ViV2VUU1Yv?=
 =?utf-8?Q?ky/84+Bc7UhBn7gyhYx0HBeiYjxU/8bfa5u7M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc35851-6864-4579-e6d4-08d900fea036
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 17:39:46.0740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sEc4IcCxrGEIUJcykn0CxyxDpudtlLJ7BMJlBX8xQSkGMsdt6SO3kG2D0vr1oLe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4338
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 0x2Ga-XjaI_RL44RIgtndIzcsDJWsJyv
X-Proofpoint-ORIG-GUID: 0x2Ga-XjaI_RL44RIgtndIzcsDJWsJyv
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/16/21 2:58 AM, Denis Salopek wrote:
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
> ---
> v5: Use more appropriate macros. Better check for changed value.
> ---
>   .../bpf/prog_tests/lookup_and_delete.c        | 292 ++++++++++++++++++
>   .../bpf/progs/test_lookup_and_delete.c        |  26 ++
>   tools/testing/selftests/bpf/test_lru_map.c    |   8 +
>   tools/testing/selftests/bpf/test_maps.c       |  19 +-
>   4 files changed, 344 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
> new file mode 100644
> index 000000000000..fb46d9082e98
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
> @@ -0,0 +1,292 @@
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

There is an ongoing effort to remove bpf_percpu() macro and recommend to
use explicit percpu encoding, see:
https://lore.kernel.org/bpf/20210415174619.51229-3-pctammela@mojatatu.com/T/#u
I would suggest to make a change in the next revision to avoid
possibly another round of change of either this patch set or the percpu
patch set. The same for above BPF_DECLARE_PERCPU.

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
> +		goto cleanup;
> +
> +	err = bpf_map__set_max_entries(skel->maps.hash_map, 2);

Maybe change 2 to MAX_ENTRIES.

> +	if (!ASSERT_OK(err, "bpf_map__set_max_entries"))
> +		goto cleanup;
> +
> +	err = test_lookup_and_delete__load(skel);
> +	if (!ASSERT_OK(err, "test_lookup_and_delete__load"))
> +		goto cleanup;
> +
> +	*map_fd = bpf_map__fd(skel->maps.hash_map);
> +	if (!ASSERT_LT(0, *map_fd, "bpf_map__fd"))

Theoretically *map_fd = 0 should be fine too and I don't think kernel
checks map_fd value in this case. Also comparison "0 < *map_fd" is kind
of anti-pattern. Could you add an ASSERT_GE
to test_progs.h, using
	!ASSERT_GE(*map_fd, 0, "bpf_map__fd")

> +		goto cleanup;
> +
> +	return skel;
> +
> +cleanup:
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
> +	if (!ASSERT_ERR(err, "bpf_map_lookup_elem"))
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

change here.

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
> +		val = bpf_percpu(value, i);

here.

> +
> +		/* Fetched value should match the initially set value. */
> +		if (CHECK(val != START_VALUE, "map value",
> +			  "unexpected for cpu %d: %lld\n", i, val))
> +			goto cleanup;
> +	}
> +
> +	/* Check that the entry is non existent. */
> +	err = bpf_map_lookup_elem(map_fd, &key, value);
> +	if (!ASSERT_ERR(err, "bpf_map_lookup_elem"))
> +		goto cleanup;
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
> +	if (!ASSERT_ERR(err, "bpf_map_lookup_elem"))
> +		goto cleanup;
> +
> +	key = 1;
> +	err = bpf_map_lookup_elem(map_fd, &key, &value);
> +	if (!ASSERT_ERR(err, "bpf_map_lookup_elem"))
> +		goto cleanup;
> +
> +cleanup:
> +	test_lookup_and_delete__destroy(skel);
> +}
> +
> +static void test_lookup_and_delete_lru_percpu_hash(void)
> +{
> +	struct test_lookup_and_delete *skel;
> +	BPF_DECLARE_PERCPU(__u64, value);

here.

> +	int map_fd, err, i, cpucnt = 0;
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
> +	/* Insert new element at key=3, should reuse LRU element 1. */
> +	key = 3;
> +	err = trigger_tp(skel, key, NEW_VALUE);
> +	if (!ASSERT_OK(err, "trigger_tp"))
> +		goto cleanup;
> +
> +	/* Clean value. */
> +	for (i = 0; i < nr_cpus; i++)
> +		bpf_percpu(value, i) = 0;

here.

> +
> +	/* Lookup and delete element 3. */
> +	err = bpf_map_lookup_and_delete_elem(map_fd, &key, value);
> +	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem")) {
> +		CHECK(1 == 0, "errno = ", "%d\n", errno);

The condition is "1 == 0"? What is the purpose here?

> +		goto cleanup;
> +	}
> +
> +	/* Check if only one CPU has set the value. */
> +	for (i = 0; i < nr_cpus; i++) {
> +		val = bpf_percpu(value, i);

here.

> +		if (val) {
> +			if (CHECK(val != NEW_VALUE, "map value",
> +				  "unexpected for cpu %d: %lld\n", i, val))
> +				goto cleanup;
> +			cpucnt++;
> +		}
> +	}
> +	if (CHECK(cpucnt != 1, "map value", "set for %d CPUs instead of 1!\n",
> +		  cpucnt))
> +		goto cleanup;
> +
> +	/* Check that entries 3 and 1 are non existent. */
> +	err = bpf_map_lookup_elem(map_fd, &key, &value);
> +	if (!ASSERT_ERR(err, "bpf_map_lookup_elem"))
> +		goto cleanup;
> +
> +	key = 1;
> +	err = bpf_map_lookup_elem(map_fd, &key, &value);
> +	if (!ASSERT_ERR(err, "bpf_map_lookup_elem"))
> +		goto cleanup;
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
> index 6a5349f9eb14..7e9049fa3edf 100644
> --- a/tools/testing/selftests/bpf/test_lru_map.c
> +++ b/tools/testing/selftests/bpf/test_lru_map.c
> @@ -231,6 +231,14 @@ static void test_lru_sanity0(int map_type, int map_flags)
>   	assert(bpf_map_lookup_elem(lru_map_fd, &key, value) == -1 &&
>   	       errno == ENOENT);
>   
> +	/* lookup elem key=1 and delete it, then check it doesn't exist */
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

there is no need to move this line below, right?

>   	assert(bpf_map_update_elem(fd, &key, value, BPF_ANY) == 0);
> +
> +	/* Lookup and delete elem key=1 and check value. */
> +	assert(bpf_map_lookup_and_delete_elem(fd, &key, value) == 0 &&
> +	       bpf_percpu(value, 0) == 100);

bpf_percpu here.

> +
> +	for (i = 0; i < nr_cpus; i++)
> +		bpf_percpu(value, i) = i + 100;

bpf_percpu here.

> +
> +	/* Insert key=1 element which should not exist. */
> +	assert(!(expected_key_mask & key));
> +	assert(bpf_map_update_elem(fd, &key, value, BPF_NOEXIST) == 0);
>   	expected_key_mask |= key;
>   
>   	/* BPF_NOEXIST means add new element if it doesn't exist. */
> 
