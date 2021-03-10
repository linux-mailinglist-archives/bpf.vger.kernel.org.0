Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866FF3333EC
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 04:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCJDoK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Mar 2021 22:44:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64378 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230516AbhCJDoA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Mar 2021 22:44:00 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12A3XGUI016594;
        Tue, 9 Mar 2021 19:43:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xPR1gNEDquSquiRl3OjQ8/6YEngmrOk4EgpSuMst97Q=;
 b=MrLOLZzyo23T113IXETTCjKmfbZlLEWufA7VaqNoHRtcuB0Q2fhfktIpulyiGFRMIDh7
 +ZHZJwxchtoyLPTtNOhtcsMTFUdfdolKfAeWwpUoEN1S9JD5yFYTZ7r9PKa9Qsk/Hjw6
 jXV5v2AT2m6CqvwsJ98QDDhMk6mNj4H8mQs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 376dq2js6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Mar 2021 19:43:47 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 9 Mar 2021 19:43:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=od8yjD/8yO/5lNtYRto+BXYqT8ZKMRQJKKaaba3BBXzhXJ8ySVtUW+v4OfS/+pq5U2TdXq3+6Tolx1I6T5LPP5iVnVZPmFQp7lyUGHuljYCIOd7p6Z+0SvY1/uUUJ1MrXYsU9+cD1jjTa1PukINXe2GyeY7hOAmlw/DtAfQM0Rn600caH7pDJVjdTqSuPGWxYjKCSpcJrkQZs5iC5fYq3hHPh+ca5bepIYMT6J1eUXF+nhmEqiEzN2YhVeFPzGiRSBdCwTlJ2kWGJfhb7vywOWEjHrY+uxfY3gFX3SA5qDJXbMcsPpZ8qE2x/aOQmX7ogM5kO+woAw1whYjuGsWfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPR1gNEDquSquiRl3OjQ8/6YEngmrOk4EgpSuMst97Q=;
 b=jf7kzjQMEAmt5Zz17pyTa2L6umU0fa5ySM1Vr+Im6l0fKQpnoac3SqGyCFTkatu6CdylMo5cqRh1leKI6SYMUtZryxB0TgBm+KNg11C68x2b0e+I8jLA3V0OQe+fkKHF5WTfKa8ou5RVdsbXgKiAbRGnav5wET6QfqO8m8BLSsgLBbEY7HFR0O+IqhQK3J75LBGShSVwoBF5kpSvmIVHRrqWQl/rTzL3fgQgW3XYC0KgQWTqE2/KwVxsUdC5w3pyUY5j+1RE+nbttChTiswc1buwsPR+MV5TMYSs0Fkl/k7mcJ9G9zafAdVkjYJj+piM+t55VLoINWlLj5jJmLIm0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4223.namprd15.prod.outlook.com (2603:10b6:806:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Wed, 10 Mar
 2021 03:43:45 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.039; Wed, 10 Mar 2021
 03:43:45 +0000
Subject: Re: [BUG] One-liner array initialization with two pointers in BPF
 results in NULLs
To:     Florent Revest <revest@chromium.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kpsingh@kernel.org>, <jackmanb@chromium.org>,
        <linux-kernel@vger.kernel.org>
References: <20210310015455.1095207-1-revest@chromium.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f5cfb3d0-fab4-ee07-70de-ad5589db1244@fb.com>
Date:   Tue, 9 Mar 2021 19:43:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210310015455.1095207-1-revest@chromium.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:3683]
X-ClientProxiedBy: MWHPR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:320:31::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1111] (2620:10d:c090:400::5:3683) by MWHPR18CA0029.namprd18.prod.outlook.com (2603:10b6:320:31::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 03:43:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67be21de-c728-4c44-ae8b-08d8e376b4e7
X-MS-TrafficTypeDiagnostic: SN7PR15MB4223:
X-Microsoft-Antispam-PRVS: <SN7PR15MB42238926C3103140922F2119D3919@SN7PR15MB4223.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yn2lawvpal/g5QgSWVlu7UW5RPqPclyaDnWqm/FfU0Aldk6GNKld0b9dfR/U63SXRAZcgPN5BKXsuhEF1wz/dtrRk/Q6B0fr9gyyvpM0o2o0nYgNoaA2nsWsBEbl6LZuBE2hjS/T0LPH9yUWSSDEfpTudCf9pe+wuQc43mseSDbPOE6MK3HjW6P1XlpPExUacdCbpH9sFQ/pXYuQ4aWzAFTaKNWbcktIEi1eswoZAHdaaSR5GNIxbRW+R17a7SJ4dkEqAjxLwBUjPqB8plQwQqZo/PMN1Lr2oq8bxxAL8P1GJx1eKwYEj7IZXne/Hb5syoFw0ToTTmPxb90HffqSncim3HiZ0/zmM52CEnS7j6z9WYz+C4tpowU/paiX9R/4Km8WB70G5eW1JJcAQjurnxcXkNK5u4JQXrtIPSqjR63cUC4UDqT3/00R5YfwM0K2aBo1P+P5sMhFzXlceiFEdt4bvC4jzQ8bYKv3VecTY6PDa250DlXd6X9123rYQQUBCB0BYJIu9FvqIMw9yBdUjaISpWgVZRyIBLm3HgvUVk2DOvyk8VDaUcfysSCXiAjJ/A8GTU0X93fj5MIssUlnOob5aqAdA+jwOBpJmw8HOtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(366004)(136003)(376002)(53546011)(66476007)(83380400001)(31686004)(66556008)(186003)(478600001)(16526019)(5660300002)(52116002)(2906002)(2616005)(8676002)(6486002)(4326008)(8936002)(316002)(31696002)(66946007)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b2JtbjU1ejFuU0lVZFFFREVQKytuY0VtQ2RlQ2lzRGNpV0R2L1JKY3Z2d2x2?=
 =?utf-8?B?ZEdnVGVNdXlNQUpSK3lqTU5tK3k1bVpZSzJjL3R5ZXNrVWNzSHB5dmVieWlL?=
 =?utf-8?B?WDB5MDR2dmk2b05RRzl3bVYydHVEM1BXekljTEsrUEcwQjRVRHJDalMrSjhB?=
 =?utf-8?B?V0pWd0xkYzBKU1hSalVLam54Nmp6OHU3c2lFeE1wbENQeFpFZ3VGS0ZkeVo3?=
 =?utf-8?B?MXVZUWFEN0ZZbUhwY2VJNHNEdE9pS2wzZGhPcjBwTHlxazdkOUJTSURUKy8x?=
 =?utf-8?B?REFWS2g4RlRjNlRqWmJJQzkyUStkamxtbUhCckxaZURrdnpnR2Y3TU1HY1Qr?=
 =?utf-8?B?cnFEZlhpcmRpNVMwYmlEdmFXZnNQZ0FVZ1VoUTNlb3d5c25hTUdsMkVtb1ZI?=
 =?utf-8?B?T09XZS80dTJrSHdONkRSOWs0ck9QMUZOUW1ycGQ2TG5KbUM3Z3pDRnBCU2Uv?=
 =?utf-8?B?OC9LaVJPejZSeUUzd1FiWDZaT0tPcE5Ia05aOCtidm9ZazhBN21jQkRUN1lZ?=
 =?utf-8?B?dVFWTmJoTjArdm9xUlNKTmhaNkd3aWtrY2dmYnA1cDIza1dPWHhlclFnNkhv?=
 =?utf-8?B?RCs2N01hcTJOK25xRnF2OE5XMWo1ZHVCM0JXRHV5M3FSNUN3cUt0bHd2YnFn?=
 =?utf-8?B?ZWNYRW15cGliQkhaelp0VTNjWjE1VDQ5MlBnN0lqUk9iQUJmSzRsUEVtb3Ns?=
 =?utf-8?B?WVUzYnpMdHlTTU9Jb1BTVkxzSzg2UzU1d2Z2SWpLOXVJOXlSdTdnY2NycEhX?=
 =?utf-8?B?QjhkZmtCK09HcFBQMGhnRVdyT2hJY2ljMm1SM1FqQjE2TytRT0JsdmVKWHpH?=
 =?utf-8?B?REhxZ1g3c08vaGIrZDNnakJVenFmSnQ2QjFGME40djBDUDRKRjQyKzR4SU82?=
 =?utf-8?B?Umc4dGE4eDA5MGJBVWdKbnFFY3NTQk5zZ3RaS2RyTWw0RzlleCt6UFVrdEtS?=
 =?utf-8?B?Q0VpblUxSmhyM05GTXF2MmdId1pxZVJteWZ2VG9RVjJwVDFIaWE5V0NsMWlH?=
 =?utf-8?B?WXZySjN0S3FRenNhVitGZ1pORWF6NnEzRTlybzVBbUFkZmlkKzYyT2JiY21p?=
 =?utf-8?B?ZUZLRko2YVo2NzZ0RUFOR1J1emZaMWlYTjVSQzhPTUhpV2pnbnVwTCsyY1Jk?=
 =?utf-8?B?eEZodUNXL2FUdFVYUjZGbVp1aUZLN3VkRlFSUUcwNVpSemFhSFppaUZRSCtQ?=
 =?utf-8?B?eFhDTUxCWjczMERCMEFIQnRSblNQTG5YRjR1R1dCeThDN1Rmb2U1TVBkeDhh?=
 =?utf-8?B?Ym5JZzlETEZDdTZhOWs1WWw5NitmL1BGSkVhMTRwMm1Gb01FbFdPU2ZWcE5D?=
 =?utf-8?B?S29QbnUzazZycHdaUkRFNjJrKzdRK0d0VWhvai9lZzFGbEFXUTVCRWFwNDh2?=
 =?utf-8?B?SjJLSUQ3RkRYa1FLZGh2RGx3N1ZjamZqMktlVXRESnkyV2J2a3h3V3ZDemFp?=
 =?utf-8?B?SGRGWi82ZkxQelBTM1pWRkx1dDlZVndERTE1VjZzWTEwaUI2dGk2WkZQdllE?=
 =?utf-8?B?a2JkNVBvckRiRjloM3JEMk5KemlMVFhucFVTTEYrUXA4VjA3dHBQMjFSZGJQ?=
 =?utf-8?B?OW0ycUpRamluSlp5ZUlBSGRhRWlySHU1L2srM2xHWVludURnZEhIM2R1Tjl4?=
 =?utf-8?B?R2JBMWNaTWhyTG45VWFpd1F3c3dBekNiTU9PRGhtQTVzeExocUUzSmtuT3Jx?=
 =?utf-8?B?RFNEL00reTBTbEFSbkZwN2kxWlE5SmZVR3A3RnB6a0ZwRU1aSVQ5V2tMN1pn?=
 =?utf-8?B?Uy9hWmpqRUZId3NoL1NPVkUrK0d5UlZUeXRsdERnWjdRN01uODFaM2JFRGdQ?=
 =?utf-8?B?eDVHczQydjloQ09hMkZsUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67be21de-c728-4c44-ae8b-08d8e376b4e7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 03:43:45.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKWEbsm60PM4FoVHbk7Xvw46vk0uU1VGms1TYXTkrulPl8aSh70S5uf9b+/n03QR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4223
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_03:2021-03-09,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103100016
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/9/21 5:54 PM, Florent Revest wrote:
> I noticed that initializing an array of pointers using this syntax:
> __u64 array[] = { (__u64)&var1, (__u64)&var2 };
> (which is a fairly common operation with macros such as BPF_SEQ_PRINTF)
> always results in array[0] and array[1] being NULL.
> 
> Interestingly, if the array is only initialized with one pointer, ex:
> __u64 array[] = { (__u64)&var1 };
> Then array[0] will not be NULL.
> 
> Or if the array is initialized field by field, ex:
> __u64 array[2];
> array[0] = (__u64)&var1;
> array[1] = (__u64)&var2;
> Then array[0] and array[1] will not be NULL either.
> 
> I'm assuming that this should have something to do with relocations
> and might be a bug in clang or in libbpf but because I don't know much
> about these, I thought that reporting could be a good first step. :)

Thanks for reporting. What you guess is correct, this is due to 
relocations :-(

The compiler notoriously tend to put complex initial values into
rodata section. For example, for
    __u64 array[] = { (__u64)&var1, (__u64)&var2 };
the compiler will put
    { (__u64)&var1, (__u64)&var2 }
into rodata section.

But &var1 and &var2 themselves need relocation since they are
address of static variables which will sit inside .data section.

So in the elf file, you will see the following relocations:

RELOCATION RECORDS FOR [.rodata]:
OFFSET           TYPE                     VALUE
0000000000000018 R_BPF_64_64              .data
0000000000000020 R_BPF_64_64              .data

Currently, libbpf does not handle relocation inside .rodata
section, so they content remains 0.

That is why you see the issue with pointer as NULL.

With array size of 1, compiler does not bother to put it into
rodata section.

I *guess* that it works in the macro due to some kind of heuristics,
e.g., nested blocks, etc, and llvm did not promote the array init value
to rodata. I will double check whether llvm can complete prevent
such transformation.

Maybe in the future libbpf is able to handle relocations for
rodata section too. But for the time being, please just consider to use 
either macro, or the explicit array assignment.

Thanks for the reproducer!

> 
> I attached below a repro with a dummy selftest that I expect should pass
> but fails to pass with the latest clang and bpf-next. Hopefully, the
> logic should be simple: I try to print two strings from pointers in an
> array using bpf_seq_printf but depending on how the array is initialized
> the helper either receives the string pointers or NULL pointers:
> 
> test_bug:FAIL:read unexpected read: actual 'str1= str2= str1=STR1
> str2=STR2 ' != expected 'str1=STR1 str2=STR2 str1=STR1 str2=STR2 '
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>   tools/testing/selftests/bpf/prog_tests/bug.c | 41 +++++++++++++++++++
>   tools/testing/selftests/bpf/progs/test_bug.c | 43 ++++++++++++++++++++
>   2 files changed, 84 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/bug.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_bug.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bug.c b/tools/testing/selftests/bpf/prog_tests/bug.c
> new file mode 100644
> index 000000000000..4b0fafd936b7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bug.c
> @@ -0,0 +1,41 @@
> +#include <test_progs.h>
> +#include "test_bug.skel.h"
> +
> +static int duration;
> +
> +void test_bug(void)
> +{
> +	struct test_bug *skel;
> +	struct bpf_link *link;
> +	char buf[64] = {};
> +	int iter_fd, len;
> +
> +	skel = test_bug__open_and_load();
> +	if (CHECK(!skel, "test_bug__open_and_load",
> +		  "skeleton open_and_load failed\n"))
> +		goto destroy;
> +
> +	link = bpf_program__attach_iter(skel->progs.bug, NULL);
> +	if (CHECK(IS_ERR(link), "attach_iter", "attach_iter failed\n"))
> +		goto destroy;
> +
> +	iter_fd = bpf_iter_create(bpf_link__fd(link));
> +	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
> +		goto free_link;
> +
> +	len = read(iter_fd, buf, sizeof(buf));
> +	CHECK(len < 0, "read", "read failed: %s\n", strerror(errno));
> +	// BUG: We expect the strings to be printed in both cases but only the
> +	// second case works.
> +	// actual 'str1= str2= str1=STR1 str2=STR2 '
> +	// != expected 'str1=STR1 str2=STR2 str1=STR1 str2=STR2 '
> +	ASSERT_STREQ(buf, "str1=STR1 str2=STR2 str1=STR1 str2=STR2 ", "read");
> +
> +	close(iter_fd);
> +
> +free_link:
> +	bpf_link__destroy(link);
> +destroy:
> +	test_bug__destroy(skel);
> +}
> +
> diff --git a/tools/testing/selftests/bpf/progs/test_bug.c b/tools/testing/selftests/bpf/progs/test_bug.c
> new file mode 100644
> index 000000000000..c41e69483785
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_bug.c
> @@ -0,0 +1,43 @@
> +#include "bpf_iter.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("iter/task")
> +int bug(struct bpf_iter__task *ctx)
> +{
> +	struct seq_file *seq = ctx->meta->seq;
> +
> +	/* We want to print two strings */
> +	static const char fmt[] = "str1=%s str2=%s ";
> +	static char str1[] = "STR1";
> +	static char str2[] = "STR2";
> +
> +	/*
> +	 * Because bpf_seq_printf takes parameters to its format specifiers in
> +	 * an array, we need to stuff pointers to str1 and str2 in a u64 array.
> +	 */
> +
> +	/* First, we try a one-liner array initialization. Note that this is
> +	 * what the BPF_SEQ_PRINTF macro does under the hood. */
> +	__u64 param_not_working[] = { (__u64)str1, (__u64)str2 };
> +	/* But we also try a field by field initialization of the array. We
> +	 * would expect the arrays and the behavior to be exactly the same. */
> +	__u64 param_working[2];
> +	param_working[0] = (__u64)str1;
> +	param_working[1] = (__u64)str2;
> +
> +	/* For convenience, only print once */
> +	if (ctx->meta->seq_num != 0)
> +		return 0;
> +
> +	/* Using the one-liner array of params, it does not print the strings */
> +	bpf_seq_printf(seq, fmt, sizeof(fmt),
> +		       param_not_working, sizeof(param_not_working));
> +	/* Using the field-by-field array of params, it prints the strings */
> +	bpf_seq_printf(seq, fmt, sizeof(fmt),
> +		       param_working, sizeof(param_working));
> +
> +	return 0;
> +}
> 
