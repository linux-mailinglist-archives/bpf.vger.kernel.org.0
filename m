Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9F258395E
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 09:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiG1HTQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 03:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiG1HTO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 03:19:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6706E201AA
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 00:19:12 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26S3UOd1027665;
        Thu, 28 Jul 2022 00:18:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=zoOq8GEBfRZBGZ5nPAjBvyk7Ky1hcmDufAy12Ea5DXY=;
 b=KQldtqG5Z88GEvh6+vuriIFfbS5OPW+ihX3UEE0oLmA10DKlVZgP2qKbyFPmcIA7z0s+
 72EphjRcghoH49u45oaZkL6RIZp3kRKkHXezuzFl3jxZMcMSMbRwteBblhGO6qqqlbkO
 fNn16ymZdQMfC9LTZBqdVI7DaaTdegexliU= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hkjkmru1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 00:18:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5mJBXMvz2YyVDsf591G6B3Y1vrNQpEMq7o9yeWSz3GMvxAC7lSMqP1GsgNO4Ggrtd8KTpvoBj/EG5BzdVb+YWnasut2wMR/AP9e09SD8q0cgkBur4ash4SxbSaIE+C8pnYTuRPidtxuhNf1wZCwErIRa5g8776pUA3wko+PGeRdIelQJZkWbQRsFvOy6kTRecwCxunRXhyiHECY1EH4vlLpEHDTnrc1Sg5NvMIo0uoLuUXs+WwTFQgfV05YWmaI1BPoKMQCxt9VP1H/3dm2bxHdqV4nXaBNxSSSwkz+AYz5OHnWCEYu5F6WjUXhn7rzD5QnEriAIuZtFBhaWQ8iNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoOq8GEBfRZBGZ5nPAjBvyk7Ky1hcmDufAy12Ea5DXY=;
 b=ZA3wKxajGCqx/Tyj5snOHMvuI1FtkGamPptUMtmkKBtqtvpQKdO3so8/FcrId2u5/kbRQ5i57RZRvSx+3FfgFcBJcQaNLYCZBcKMR9pLF+nDIZqBYudpvaMdJu0tvz3ocX67JqmKYAS+Q1XoIMd8UDRrdgQ66Tju8Xaig0QEixA5TnyNJgRbf9dzv76nMyVgajLrM1OxltTUzLTUnOjTjOnHcKOv0vkkQgvHpAb5/5YUzHnX1SCd5SPCEmvHkdJ9HLiQRZ5gWAJzW1MC80YJmCWgtANIxiQDLYkMJ1z+0FV3s5P0GzjGa4d5JXbcksIBh8vM+nHtHrNfUjgFxGStDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1804.namprd15.prod.outlook.com (2603:10b6:4:58::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.25; Thu, 28 Jul 2022 07:18:51 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 07:18:51 +0000
Message-ID: <be9fa91f-820e-27d0-f66b-9c2e1164681c@fb.com>
Date:   Thu, 28 Jul 2022 00:18:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next 11/11] selftests/bpf: Add rbtree map tests
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-12-davemarchevsky@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220722183438.3319790-12-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 053a55da-a22d-4eb1-b409-08da70696c09
X-MS-TrafficTypeDiagnostic: DM5PR15MB1804:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WE7uX2+7+jqBRMbIy9UIVOmIsgDTGQ4Gv55HwOR6fqaTAJn7RCVNbIxiSfp1tGlnSZjHgeWk2OVYY3CrN36QHPtuMOIUwkPDYaZywSm4b1q+S5hDOkK3B5sOKDMNEyoDuvh/ZSk81ah2k/xqFDStztAIRfXDAmhRnhOD4iMhxAVUL4xdpW33X6rtAixOVNBXp79/FJoh2cq6lNVWjOk4VzW7s3IViFMazjYeXIi+B8lVL+q7OXGB9N0tm5sJ41QIQmFKzlPiIY28lsL1ZHk5rB0SFeAmeMvhO0BZP1CAZtckYjLDNOJe1vNLu5c7b1LpsiL+u1mgVO0d2OrWiMIUBDirvBIOfn68cH/oJOmvJOV2q8E8as4CeFBldVwwS5awK+tyfcej85NcXTPWzwGOp/0J253FlLjNduXKXQPZu19r0WQJWUOYIzRldYWkrVOwCgxOCvrPxdTtg7SfHSMoKbscuV+KvcVakCKeUB8j+8rEgU56za5Gmlrxm2YisHp8Dqu1pYg1igr8rgECB54ED9YJj38svbKRWS1IXcz9l1RJb863OlKpvK+g+gy47BufqJLyfUjGtSBjImZdJek2XM/4uD2k6FoXR0xn7Pqpq52frbMKNnQ4b+EkdMIdpVk9+C9fO3e5fNOsW1pxur+JJGFYEPy9/nFdPB6RoU/3F5JvmYK2bhIEhMi+4rvJu4gMGpHVDJuU4N2ZsmNovCrKYPcj0qnNbB53kKOa8KIzUVwAEyG1rzb/idL7AmKZnPa84pWp+2xEo7Sj0tKlzTPNjhOvrf6EM7Fe7g56DaBgXFCiZQN/dIp7gvpq4+HlWf04MVGA8CiElefbo9V7YaO+EQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(53546011)(8936002)(8676002)(4326008)(66556008)(66476007)(36756003)(66946007)(5660300002)(2906002)(2616005)(38100700002)(6486002)(186003)(83380400001)(41300700001)(86362001)(31696002)(6506007)(6512007)(54906003)(478600001)(31686004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHZaWlVDMFRTeXB1NG44c1VnSjZPOURJOGpldUQ1VzF3VzdraGNtZFQ1Kyt3?=
 =?utf-8?B?ZHFOOHBCRUZjV2ZlNWxaNFdLcWZhdjgwL0VUMEpDK0Z3bFN2MnpybGdMcFIw?=
 =?utf-8?B?T1NOVTcxWjRicGtscldtbW9OZlA2QXNZS3l2SUppU2hLRkVmQld3V2N0YndV?=
 =?utf-8?B?UUZNaTVCYTN4QmtKbFE0RDgzQXJxb0pqdzJlUGlySlBNRGF3aVhnMnU1eDlj?=
 =?utf-8?B?c1hJVHN5SEFJcjlBMEZVYWhsbU4razRlVE9DeW5wYm5mVE9OWE5qbUJ0bHV4?=
 =?utf-8?B?VDNBbmJxdVh1VGFsV0lEV01LRlFzblhLWnlDR3dUYjMxdDBXRnJuRDVuc0Zx?=
 =?utf-8?B?Ky9zcWd4QzlBc25adm81Z1lVWWtGazJPUVkwMnhwTk9rMm9jRW1ZTzhZVzg2?=
 =?utf-8?B?aS80UDZJOGUrTXFZeEJKczlVMXBlbDdKN2FUdFdrN0JNNmgyRlNqUHUyaWMy?=
 =?utf-8?B?bjQxVktYcWF6eVUwTlZ4YTJESGIrSzdrNjczdGhlSEY4NGdPSVkrSjA5a1Zp?=
 =?utf-8?B?Tkc0ZG1qNlU5VVRZVTBxVCtEOXVyWXpBaTV2WWNqUysvdEt4WW1KRHM5OUJM?=
 =?utf-8?B?YVI5cStoNjlNcUozaDhCNURiZms2RXlkeWhOWDZqaXoycHNJK1ZuZ3Zqa2Zz?=
 =?utf-8?B?dWo2NzBlVm5yOW83QWgySUk2T3BnMHd5STNQMm1FMHZzaGNUMDh4dUkzUEV1?=
 =?utf-8?B?YU5XMzRKL0hqSXpRQnppZEprVzdQdHcrc28xUk9pbHBjQUlRNUl6MjViNG41?=
 =?utf-8?B?dGVQRU9jSGs0MW5FT3NyR1RPOFlvS1N2K3RTSEVXS0JDUmNpbHRkYWNJdng4?=
 =?utf-8?B?SFprQ2tQSE0xVndaT3RMb0lsWHBoNjZUUHdLcU90MklUSTRyTkluWE5ZZU9R?=
 =?utf-8?B?U2RldjBvQXgxUVo0N3hBR21IRHlEUDBCMVBXcWR1d05SRG5mYTJ4VlRSZGlh?=
 =?utf-8?B?aUprY0N0RENiZWJ2d0cxMFBIUHh3em9aclB1THk3SXA0aU9vb0JKclR5WTRp?=
 =?utf-8?B?VXFlNU5WY2ZqRkRLT0Vxcm9HVmxGRFBpTWh2ZjRDclZ5Q0dFRHpxMDlXSzNh?=
 =?utf-8?B?MGRrZ0RIZGRQY1F1TlFLdXVWZ2V4Sm5rZUt6NGJDRkxpZmQ5dWdnZUM5MjNt?=
 =?utf-8?B?RmZ0Z1lHY3NnemExMHdscllYKzhyY01INWhTcDJ2RENBeWswUzB6T1VYaWVl?=
 =?utf-8?B?Q2g5NEZBKzh5RVZQMzZnV0lMaU9aRFMxRmo3eHJvaW1ITUZZVmpSOVRjeHJ2?=
 =?utf-8?B?UEVuRVdwZWMzQ1I3ZncyNnc2eW1Sdkw0REN6MlNsLzNVNmg5ZUorbkhsNzY2?=
 =?utf-8?B?WGlOTDlGNkFIZ0dCNzlHOGptcEp2eDU4N1gxUTdZam8xS1RFU29menpMdFNJ?=
 =?utf-8?B?cXkvUmVkT1RBT01FMndJb0ZKZGxnRzludjJMVm1hV0xnQURmbTNXd0dBZDc5?=
 =?utf-8?B?eXdLNVpiUXNGTVhIc0RwaFYvaGpqTnF5S2ZzbXRQUzdTZGVIZWltWVZmbC8x?=
 =?utf-8?B?eHRLY05aSlFQTWR6Nm9oVmxmUjBPSUxYZUFpaGlaMDRkQ3ZMcUlIdmNjclhI?=
 =?utf-8?B?KzRPcE40eWZUcGdvb3hWaHBWbmFia2RpMWJZQllaMVROdlpHKyt6Mms0Tmky?=
 =?utf-8?B?enBONnM3RmduUVAxbEJHTzlmYm5ySFZCNFdnRldhdkt1Q1JPNENVeWVqSUZp?=
 =?utf-8?B?dUl4eXhtK2NwZUYzdDA5cHVGdkg5dkFoeUJIdnJIKzRFQk8xbVZtbjJjRWdC?=
 =?utf-8?B?Rmo4NGhHc0Q0cjlaM28wK2EyUW00UUZHdENmOEltb2MxRmJPNHVPWk4rR0lr?=
 =?utf-8?B?c0RLVEcwV09ZaW1vdy8rd2VMNVJFTEp2bGZaQlIrMVd1a3U3bks0WnZpejJi?=
 =?utf-8?B?SjBwQmIybnhOc1BwVTdIL1k1M1kxZU5NSWY5VXFLL0FIRHk1bTZrMXNMUlNL?=
 =?utf-8?B?VXhxK2l0dHM5dGJEKzF5aEZILzd4M3MyODVRdmJENXFPSXNSei9wS285aTRH?=
 =?utf-8?B?VmlLdGRIdXB2c3NkRVBGb0NuYy9wTkw0RGhCOHhtNkY3MGRRWmRja1Q5SFRK?=
 =?utf-8?B?SElkalJEZy9idEg4NWltdkVYd1J6Y1BoWFY0SVpzWFhpWEt3SEt2Um1jRHpP?=
 =?utf-8?B?MkdxWStPNXRybDh4dGtRM2tPNjU3ZFVUeUNHK2I1NmVDUXl0TjB0LzNraGRG?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 053a55da-a22d-4eb1-b409-08da70696c09
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 07:18:51.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGl7RRV5kjulX5T9ANuyNqYsg794VRp/imRKCzH2NUGjrUS2PU6IEjbuM6vC5DWE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1804
X-Proofpoint-GUID: IHTb_7rZh0ATxi2xZh7jMQrBE7iLYUlk
X-Proofpoint-ORIG-GUID: IHTb_7rZh0ATxi2xZh7jMQrBE7iLYUlk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_01,2022-07-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/22/22 11:34 AM, Dave Marchevsky wrote:
> Add tests demonstrating happy path of rbtree map usage as well as
> exercising numerous failure paths and conditions. Structure of failing
> test runner is based on dynptr tests.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   .../selftests/bpf/prog_tests/rbtree_map.c     | 164 ++++++++++++
>   .../testing/selftests/bpf/progs/rbtree_map.c  | 111 ++++++++
>   .../selftests/bpf/progs/rbtree_map_fail.c     | 236 ++++++++++++++++++
>   .../bpf/progs/rbtree_map_load_fail.c          |  24 ++
>   4 files changed, 535 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/rbtree_map.c
>   create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map.c
>   create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map_fail.c
>   create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map_load_fail.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/rbtree_map.c b/tools/testing/selftests/bpf/prog_tests/rbtree_map.c
> new file mode 100644
> index 000000000000..17cadcd05ee4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rbtree_map.c
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include <sys/syscall.h>
> +#include <test_progs.h>
> +#include "rbtree_map.skel.h"
> +#include "rbtree_map_fail.skel.h"
> +#include "rbtree_map_load_fail.skel.h"
> +
> +static size_t log_buf_sz = 1048576; /* 1 MB */
> +static char obj_log_buf[1048576];
> +
> +static struct {
> +	const char *prog_name;
> +	const char *expected_err_msg;
> +} rbtree_prog_load_fail_tests[] = {
> +	{"rb_node__field_store", "only read is supported"},
> +	{"rb_node__alloc_no_add", "Unreleased reference id=2 alloc_insn=3"},
> +	{"rb_node__two_alloc_one_add", "Unreleased reference id=2 alloc_insn=3"},
> +	{"rb_node__remove_no_free", "Unreleased reference id=5 alloc_insn=28"},
> +	{"rb_tree__add_wrong_type", "rbtree: R2 is of type task_struct but node_data is expected"},
> +	{"rb_tree__conditional_release_helper_usage",
> +		"R2 type=ptr_cond_rel_ expected=ptr_"},
> +};
> +
> +void test_rbtree_map_load_fail(void)
> +{
> +	struct rbtree_map_load_fail *skel;
> +
> +	skel = rbtree_map_load_fail__open_and_load();
> +	if (!ASSERT_ERR_PTR(skel, "rbtree_map_load_fail__open_and_load"))
> +		rbtree_map_load_fail__destroy(skel);
> +}
> +
> +static void verify_fail(const char *prog_name, const char *expected_err_msg)
> +{
> +	LIBBPF_OPTS(bpf_object_open_opts, opts);
> +	struct rbtree_map_fail *skel;
> +	struct bpf_program *prog;
> +	int err;
> +
> +	opts.kernel_log_buf = obj_log_buf;
> +	opts.kernel_log_size = log_buf_sz;
> +	opts.kernel_log_level = 1;
> +
> +	skel = rbtree_map_fail__open_opts(&opts);
> +	if (!ASSERT_OK_PTR(skel, "rbtree_map_fail__open_opts"))
> +		goto cleanup;
> +
> +	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
> +	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> +		goto cleanup;
> +
> +	bpf_program__set_autoload(prog, true);
> +	err = rbtree_map_fail__load(skel);
> +	if (!ASSERT_ERR(err, "unexpected load success"))
> +		goto cleanup;
> +
> +	if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err_msg")) {
> +		fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
> +		fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
> +	}
> +
> +cleanup:
> +	rbtree_map_fail__destroy(skel);
> +}
> +
> +void test_rbtree_map_alloc_node__size_too_small(void)
> +{
> +	struct rbtree_map_fail *skel;
> +	struct bpf_program *prog;
> +	struct bpf_link *link;
> +	int err;
> +
> +	skel = rbtree_map_fail__open();
> +	if (!ASSERT_OK_PTR(skel, "rbtree_map_fail__open"))
> +		goto cleanup;
> +
> +	prog = skel->progs.alloc_node__size_too_small;
> +	bpf_program__set_autoload(prog, true);
> +
> +	err = rbtree_map_fail__load(skel);
> +	if (!ASSERT_OK(err, "unexpected load fail"))
> +		goto cleanup;
> +
> +	link = bpf_program__attach(skel->progs.alloc_node__size_too_small);
> +	if (!ASSERT_OK_PTR(link, "link"))
> +		goto cleanup;
> +
> +	syscall(SYS_getpgid);
> +
> +	ASSERT_EQ(skel->bss->size_too_small__alloc_fail, 1, "alloc_fail");
> +
> +	bpf_link__destroy(link);
> +cleanup:
> +	rbtree_map_fail__destroy(skel);
> +}
> +
> +void test_rbtree_map_add_node__no_lock(void)
> +{
> +	struct rbtree_map_fail *skel;
> +	struct bpf_program *prog;
> +	struct bpf_link *link;
> +	int err;
> +
> +	skel = rbtree_map_fail__open();
> +	if (!ASSERT_OK_PTR(skel, "rbtree_map_fail__open"))
> +		goto cleanup;
> +
> +	prog = skel->progs.add_node__no_lock;
> +	bpf_program__set_autoload(prog, true);
> +
> +	err = rbtree_map_fail__load(skel);
> +	if (!ASSERT_OK(err, "unexpected load fail"))
> +		goto cleanup;
> +
> +	link = bpf_program__attach(skel->progs.add_node__no_lock);
> +	if (!ASSERT_OK_PTR(link, "link"))
> +		goto cleanup;
> +
> +	syscall(SYS_getpgid);
> +
> +	ASSERT_EQ(skel->bss->no_lock_add__fail, 1, "alloc_fail");
> +
> +	bpf_link__destroy(link);
> +cleanup:
> +	rbtree_map_fail__destroy(skel);
> +}
> +
> +void test_rbtree_map_prog_load_fail(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(rbtree_prog_load_fail_tests); i++) {
> +		if (!test__start_subtest(rbtree_prog_load_fail_tests[i].prog_name))
> +			continue;
> +
> +		verify_fail(rbtree_prog_load_fail_tests[i].prog_name,
> +			    rbtree_prog_load_fail_tests[i].expected_err_msg);
> +	}
> +}
> +
> +void test_rbtree_map(void)
> +{
> +	struct rbtree_map *skel;
> +	struct bpf_link *link;
> +
> +	skel = rbtree_map__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "rbtree_map__open_and_load"))
> +		goto cleanup;
> +
> +	link = bpf_program__attach(skel->progs.check_rbtree);
> +	if (!ASSERT_OK_PTR(link, "link"))
> +		goto cleanup;
> +
> +	for (int i = 0; i < 100; i++)
> +		syscall(SYS_getpgid);
> +
> +	ASSERT_EQ(skel->bss->calls, 100, "calls_equal");
> +
> +	bpf_link__destroy(link);
> +cleanup:
> +	rbtree_map__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/rbtree_map.c b/tools/testing/selftests/bpf/progs/rbtree_map.c
> new file mode 100644
> index 000000000000..0cd467838f6e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/rbtree_map.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +struct node_data {
> +	struct rb_node node;
> +	__u32 one;
> +	__u32 two;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_RBTREE);
> +	__type(value, struct node_data);
> +} rbtree SEC(".maps");
> +
> +long calls;
> +
> +static bool less(struct rb_node *a, const struct rb_node *b)
> +{
> +	struct node_data *node_a;
> +	struct node_data *node_b;
> +
> +	node_a = container_of(a, struct node_data, node);
> +	node_b = container_of(b, struct node_data, node);
> +
> +	return node_a->one < node_b->one;
> +}
> +
> +// Key = node_datq
> +static int cmp(const void *key, const struct rb_node *b)
> +{
> +	struct node_data *node_a;
> +	struct node_data *node_b;
> +
> +	node_a = container_of(key, struct node_data, node);
> +	node_b = container_of(b, struct node_data, node);
> +
> +	return node_b->one - node_a->one;
> +}
> +
> +// Key = just node_data.one
> +static int cmp2(const void *key, const struct rb_node *b)
> +{
> +	__u32 one;
> +	struct node_data *node_b;
> +
> +	one = *(__u32 *)key;
> +	node_b = container_of(b, struct node_data, node);
> +
> +	return node_b->one - one;
> +}
> +
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> +int check_rbtree(void *ctx)
> +{
> +	struct node_data *node, *found, *ret;
> +	struct node_data popped;
> +	struct node_data search;
> +	__u32 search2;
> +
> +	node = bpf_rbtree_alloc_node(&rbtree, sizeof(struct node_data));

If I understand correctly, bpf_rtbree_alloc_node() may cause reschedule
inside the function. So, the program should be sleepable, right?

> +	if (!node)
> +		return 0;
> +
> +	node->one = calls;
> +	node->two = 6;
> +	bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
> +
> +	ret = (struct node_data *)bpf_rbtree_add(&rbtree, node, less);
> +	if (!ret) {
> +		bpf_rbtree_free_node(&rbtree, node);
> +		goto unlock_ret;
> +	}
> +
> +	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
> +
> +	bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
> +
> +	search.one = calls;
> +	found = (struct node_data *)bpf_rbtree_find(&rbtree, &search, cmp);
> +	if (!found)
> +		goto unlock_ret;
> +
> +	int node_ct = 0;
> +	struct node_data *iter = (struct node_data *)bpf_rbtree_first(&rbtree);
> +
> +	while (iter) {
> +		node_ct++;
> +		iter = (struct node_data *)bpf_rbtree_next(&rbtree, iter);
> +	}
> +
> +	ret = (struct node_data *)bpf_rbtree_remove(&rbtree, found);
> +	if (!ret)
> +		goto unlock_ret;
> +
> +	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
> +
> +	bpf_rbtree_free_node(&rbtree, ret);
> +
> +	__sync_fetch_and_add(&calls, 1);
> +	return 0;
> +
> +unlock_ret:
> +	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
> +	return 0;
> +}
> +
[...]
