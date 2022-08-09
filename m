Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A4F58DB88
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 18:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244885AbiHIQBw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 12:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244891AbiHIQBv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 12:01:51 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB4B1EC5B
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 09:01:49 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279EcSD3028625;
        Tue, 9 Aug 2022 09:01:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=RPGfEpuH16HGVSMSOYIPu9WMsC+QyFJ61eekRdPCbUE=;
 b=awKJrk3gWdKRGOVX+54Y7U6phsDte1rXF1Gag4DxnZK2wZOc/DcCvi4Q9rZnkXiiy5B1
 ELarPLGG6MO1F0XLs4Dz7PalErRKj0J6RyFGIUY7nDPCl8BYtVk/KRx8S7Y6sXCz+rWi
 IKdeb0DK/TEyMcEy0jLIPiANzGoRqn2ZxPM= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hufk844mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 09:01:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxxvnmQo/mZV4E62OYOCo5ip3KbaJodaK1nwbyG8R7ejk24YsUAR+4GYO6FsESKtGBl0RMkC6uus5dCUqZVUs5IvUQNkmX9yrY59K0iahhGVsydxmkzm+gvPOpLW6nQGZRAQNOwngK8gKNyrLK57SV81+pPKXy/NmkEuqeh1X/VCRIZEt22pk77R4uwrYGLL5Ni0nzf2r6ixq+7Ah2mCB/IOsbktebcKsUiNPeIICTlwNUAeOHD9SWK3uzEA6lEfHrgh7sef9J8Iqve6S++GCllQ3LdvnZogG2G8CS81/Anpq0sVqOE+L2NIx6VSQF/zE9NWXFRIf47EtEq5MHdCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPGfEpuH16HGVSMSOYIPu9WMsC+QyFJ61eekRdPCbUE=;
 b=Oi0MAMIorQwu5FwdBP64rWnwjgT92+TntFIK5hQtseKOttwQQNwmgl4xBrhmqhiAAqO9YyqZcRZHe+voYCHe3eQZH4rhCRyKaTh0vlh+6S78UPoozg+IpMnsNp8HF66UfSLTbiHK1+48XdI7cxihYPW2DoyqEez9fkPjuEX+1gct7zBvXHMrsFB3RmevWKocM9GqFd9BScCWVSQi5EoHLk+RnK3KAdFU+Jit4u/ggjtphoTMeXBLKfT50DKBPyujw9E1+5owFF5n1g8FZmHSCD8RfJ08kJORjcFkVok0LT0VseOX0xu3AX9/laEMZav+A3WpA3rRvp/b7Rm0o8BfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB5250.namprd15.prod.outlook.com (2603:10b6:303:169::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 16:01:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 16:01:32 +0000
Message-ID: <47cc7999-bfff-bd34-6c46-6ff5cd09f8e1@fb.com>
Date:   Tue, 9 Aug 2022 09:01:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf v2 3/3] selftests/bpf: Add test for prealloc_lru_pop
 bug
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20220809140615.21231-1-memxor@gmail.com>
 <20220809140615.21231-4-memxor@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220809140615.21231-4-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 775a57c9-93d3-47af-a612-08da7a206d88
X-MS-TrafficTypeDiagnostic: MW4PR15MB5250:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +c98Vs3SHZh050HIQLht8whOjAWn4MCrJAX7/wvVt+pkcMcoA7OMjRdlMbKDq4AZZBatIaKDcN1obYaUyHbbCw6j8wzbAth/g1nwLNVRTksZ3Fdez7FNe0giaOi07ClRdD8xS12qfjINAWPMpmmsnTXIZsqMxXG/77xbFM8FIQJopLwWveSOOIdND1JvLMA2z7ndQ5z8fsAJwbaVfXVJD62poW6CWRl63uCVZKEocXshg+R2XoJtnbnwboP5UQJQRRybJy23RfTLUjfnqlxf8UpzCGPOsr9dkFbPfT9fY7rhyArofMm6BfaV8XGLxC0qVzan5wP7KUC284aLy9ycJGUzGUoGRgtyLhSD3/miUtmQ6wLQJSx8kzKMpZVCRNlvcXP3xm1r7r5KzgK54cW/2QlLfJdqLCs/MlBEVRYP+oiiXXm+AfS5z+nirL4e6YOGkaxRtNrvJdqFEes2moSY+GUYrE9n2h2r7Xlztx1NafwOSFe93m4BRm/gsn/3H6HTIkkWNsf3eYylASd8W5aJhQDcpHqooXdAemN3XdRDhWwrZriaio2916r0r9UYRF0/pHWCpjo24oUzfEdgn5WnwjXpLkCXCejkarXN/rWogslmpRtckLV+wkIbkmfYmpye6FoErJLpyK7mcfzArFaR06ayPK/oOYRUr31cpPhlORNMzqFCedRw21J1bB/7rBEvFier/js68vXk1CXYxgCBgVkADpBLjgRK6o3YpBFeRHfszqWnBqOtm/yEUiANGj5IXlJh0HNbcBwf+fWYUp+S/qWVD0Cl5uJ09lnSAYC7tFAYqR31Afo+7nvUgb02ALQio4SZVEtBdJ5xGGk4mpELjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(8676002)(66476007)(66556008)(5660300002)(66946007)(4326008)(316002)(8936002)(2906002)(54906003)(38100700002)(36756003)(86362001)(31696002)(478600001)(6486002)(6506007)(6512007)(6666004)(41300700001)(2616005)(83380400001)(53546011)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDlUSzF5cHVpZWErVlBWWXMxQk9lK0hTaEZrb1htdVp2MGU0SE8rOTNHcDM0?=
 =?utf-8?B?UHM4ZEdiMURnZzhHT2ovRy9IL0dDTzZuNTYrYTJ5TzdRVVRXUVIxYng5R3Jz?=
 =?utf-8?B?NnRwU2ZEd00yQ3c4Lytub1JTKzFkdmxpOHNmekxyTG1JSDNmVjJHZStnM01N?=
 =?utf-8?B?UlJqK3lTeXZ3eGVxdUt3S2pDamtzUGlndGhON28xVWwyY3VuOW1LcGcrU0xX?=
 =?utf-8?B?KzVEbDdzY2laR1NwdUVUMUhRcy95SlhQTG9XSndkVm5Vb3g2Z3FITmpBdnFu?=
 =?utf-8?B?VER2WUxaSDVQdkxaa1lrRWNyQTMzNDBDVGJwNW0vSTlDNGYvR3d3bFUxNXZN?=
 =?utf-8?B?MUM4andDd1dIb0cvcHdGTjVTUk5FYnFzNlhaZm1mL0RlWEd0dHFYQ3NZekZS?=
 =?utf-8?B?TUVKSC9Eakp3T3h2WEtZM3g3TUUwQzZOV2lGOW9wSE9wMTgxUUVUUnYwY0tH?=
 =?utf-8?B?bzhPQzlNbkNSdVZFVWxERStxR3ZHak1ORytYdGZQRWl1VWZZQWc4elZYL0l2?=
 =?utf-8?B?NUtQWjlSVDNmeUpFTWhBU1RhWFhYL0JLZW1uM3BCSHVIWkhiWU0zd0FQUlNt?=
 =?utf-8?B?Rm1ReHZTSWs2OHhwSVhPU1RmUTh5RXpmdXhJTC9MTzFqQXdYZGxHK1BkM01r?=
 =?utf-8?B?blNiMCtVOUFveE9DWldaajA1L3p0WmdjOCthbk1CUGR3SE8wOTVha3hOY2ln?=
 =?utf-8?B?SUtQQmZCNEIxNE5pUnJ0OHFWZVp6STZiTGo2NWNjMkJpYVdmUlpyYlZmZzFC?=
 =?utf-8?B?c2x0N09mczJod091dVdhWmtQbUxlTkdqN0o1cHNkSzdiYVdkUTJpS0dsZHdE?=
 =?utf-8?B?QjJ6RGtaREM3OWg2MDNNRUZ3SjFHVjZqZ21lNXZNR1VSM1JwYnVscnN0eXdi?=
 =?utf-8?B?b0Q2TGprUnByREZFdTU0K2FBSHJvQ2RSWUN1SHhOL1NoWHdzb3c4WWFua0s1?=
 =?utf-8?B?VTAreXJvb0F2RStnbitTS0pkTHlVV1E2R2tqaWxxSHZRSGJxb2RtWGZGd2FZ?=
 =?utf-8?B?UUVEbDVYbjRkaEthc2FBQnQ1VEF3MDFtQ3l4T05MM2YxWk5wdXlvdEFvTTNo?=
 =?utf-8?B?RmcvWVJPd05xY1ZXeENTOU5keWptRlhDZ0hZbmZMWjlSMmFpTTBNbFRybWpk?=
 =?utf-8?B?L2lPcUNIRys3Q1o5aGVCR2NzMGxIRUtMU2JvK29rY2pkUm03U3RLL1p1RGw1?=
 =?utf-8?B?VVhmZk5GS09mVi9YQ0FKR0xVVytRR2FPdWxVc2NzaGRCenVpU2tYMFdLWW9X?=
 =?utf-8?B?ak9uS0UyQlQ5NGdqMjZwZlNVMmQ4aFF1b3cwaUJzU3htZ3B2TzN4cHZzakxO?=
 =?utf-8?B?d3FmY1B0WjhDQlJPaG5COXVLcTBQeitrZksvWGFpeHEyZk9ZSG5EYnlTRlNy?=
 =?utf-8?B?UytheFB6SDcrd3FFTDhkUndCRnoxR3ZseEJ2eWJydVF5T0VqN0RtL1hoeWF2?=
 =?utf-8?B?RUMwRDA4MEJEQ2xya0NhOHkwZHJLQXVNTU9mV1NVLytWd2RuVGRLY3ZZY08x?=
 =?utf-8?B?ank0VE9QNEgxMStKQUZWRmxaenZKbFhzbnFVdzFSRGlIVGNCY3o0cjlzUXFF?=
 =?utf-8?B?N2EyeVFUSDBPQm5qcElxN1dTTVduMk84VjhXWVlaK0pCVEtPQkU2SXoveXVH?=
 =?utf-8?B?cmV4VVZmUHo3bTlsM2UyRnNDeVE2R0k5aXUyWDlrOFBjS2RSaDQxSy9PTkth?=
 =?utf-8?B?ZE5vRjNTNjJ5UUkxZHZGa1BhZnBuVUVCZlJwOTdaSDJmUXZRcG1BSEx1Mlo1?=
 =?utf-8?B?L2N3V1RLR0FPWjNCZ1Z3OWhGZWJPNmhnanhWQTViSFFWbUN5T29EV05Hbmdl?=
 =?utf-8?B?eG9VU3M3RW15MEFMakw1dUdpRGVqUEludEE1bUlYcTFETlZBajYxVVNWdDhy?=
 =?utf-8?B?eGNNdFZUTUR1OUpRTGVLdHlDVENSR2pzdmxqb3lTaTRHZTZvT3QzdWpZeUFw?=
 =?utf-8?B?ejQxbWdiNm9kZDNrVFBQWUlFNjk2eWR5UmYrUTBhTmR3L01YMk9VZ1BKalVo?=
 =?utf-8?B?WlZJOWtOczlBYU5EdC8yUzBXc3JlRmtkOEE0Z2pETHBxcU42c1QyRHpydWRC?=
 =?utf-8?B?R0JuUXZVZG1nZ0VQMVpYY0RkUWdZNmFGbGQwZ201Ujh6bzlYUzM2QjFkcHJl?=
 =?utf-8?B?WlNvcE5ZLzFtVzRLNm9oSUpxQklRZlVJa1Btdm5yd1dnL2U1MHpEWk9yaFox?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775a57c9-93d3-47af-a612-08da7a206d88
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 16:01:32.2966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8G06ld7GzQs0qU2sjfKEoQmopgWLc42ayz8UddMN6BMNRIvlan6dPquPZnK0lyIP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5250
X-Proofpoint-GUID: Zdxfa8coqu6TTnCzUQn8iGkE7naj4Ta-
X-Proofpoint-ORIG-GUID: Zdxfa8coqu6TTnCzUQn8iGkE7naj4Ta-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/9/22 7:06 AM, Kumar Kartikeya Dwivedi wrote:
> Add a regression test to check against invalid check_and_init_map_value
> call inside prealloc_lru_pop.
> 
> To actually observe a kind of problem this can cause, set debug to 1
> when running the test locally without the fix. Then, just observe the
> refcount which keeps increasing on each run of the test. With timers or
> spin locks, it would cause unpredictable results when racing.
> 
> ...
> 
> bash-5.1# ./test_progs -t lru_bug
>        test_progs-192     [000] d..21   354.838821: bpf_trace_printk: ref: 4
>        test_progs-192     [000] d..21   354.842824: bpf_trace_printk: ref: 5
> bash-5.1# ./test_progs -t lru_bug
>        test_progs-193     [000] d..21   356.722813: bpf_trace_printk: ref: 5
>        test_progs-193     [000] d..21   356.727071: bpf_trace_printk: ref: 6
> 
> ... and so on.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Ack with a minor nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   .../selftests/bpf/prog_tests/lru_bug.c        | 19 ++++++
>   tools/testing/selftests/bpf/progs/lru_bug.c   | 67 +++++++++++++++++++
>   2 files changed, 86 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/lru_bug.c
>   create mode 100644 tools/testing/selftests/bpf/progs/lru_bug.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/lru_bug.c b/tools/testing/selftests/bpf/prog_tests/lru_bug.c
> new file mode 100644
> index 000000000000..3bcb5bc62d5a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lru_bug.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +
> +#include "lru_bug.skel.h"
> +
> +void serial_test_lru_bug(void)
> +{
> +	struct lru_bug *skel;
> +	int ret;
> +
> +	skel = lru_bug__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "lru_bug__open_and_load"))
> +		return;
> +	ret = lru_bug__attach(skel);
> +	if (!ASSERT_OK(ret, "lru_bug__attach"))
> +		return;

If not ASSERT_OK, should go to lru_bug__destroy(skel).

> +	usleep(1);
> +	ASSERT_OK(skel->data->result, "prealloc_lru_pop doesn't call check_and_init_map_value");

Missing
	lru_bug__destroy(skel);
.

> +}
[...]
