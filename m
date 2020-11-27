Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED2B2C60AF
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 08:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388966AbgK0H4p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 02:56:45 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9928 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388928AbgK0H4o (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Nov 2020 02:56:44 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AR7pdWd003973;
        Thu, 26 Nov 2020 23:56:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3DoH7ISfzxfzLmXh2YFRkReX7AKUmquRoBvNcoyT8Qk=;
 b=SV5O7EBr5c8QZDswm+t6lz5OsrhCy5NupWxHyOhrQ6qUEWL+wQ/936vJP8sVwv+rCQnD
 8Ix5025QIxdlNMAVkVAZxzOO8hJc50qXT4exJH/+8g2WUNVi+36QPW0rAWf1GybiGhRf
 koXCIGcbG92ipG1EffuE5dlBI7HtLH9vmRo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 352s3n0s0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 Nov 2020 23:56:28 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 26 Nov 2020 23:56:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6dk6dY1cXc/p4TgIN/mI1pm0tWiAl+4oND3dJ2M9Qt/hdlMgvKIJxdSuXV7bZnxyXUdHgxnuV3l/UiLCeA5MZ2mRVCaxPL4glbpE0MsNvo0EvTOGbx91TSyCD1pMxpZZzbtNNL4GKVCBHeuH1I1i9anXU6suu9R4XM9XHdIhsyK2IYqQveWrqaAENRNsQ7nTFlhpmlEopF5588Gi8fdhr5zLuBqgbgb6V3EWuh9O5eAoXIFB4i/h1I5h2ButQyR6Fd8FS6FEFQZlH4lDe8MthNEBkvknQezZrx6LoMxpp+7Izi2J79W8dipCu1/f0RzYLjKqurCENLgSyDtuG3aaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DoH7ISfzxfzLmXh2YFRkReX7AKUmquRoBvNcoyT8Qk=;
 b=IQAzBIwFqxh2HC+O5cOYZ8utUFCzFtC+t46KGTVpa6VggNaT7QngvdV52z2q9clO8sNwGlN3LEhTZk/JPInu5CPMVaq7z5CKE/EX/+Dr8lwwadfYaVFIQ7DK3RnJpRFEIkGoll5YejKkUPsCSV/tRBctTF9s8Qt8DVDodcp+s2JqAMLYAtZLlUzmV1tf6PXXQNzYX9vIM4SRFxQKXwIgnPUXZ+CiTDSg3Ofw67uW65KSMDtShau9x83roJocrOskbNGF1r5rusgUNyWPyvBqgt7aii0jy9Lwhf2WsAhrpPIFGLekJP9s5YfrUEsslIZznK9QdcyyQ81vmMrWPYhp4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DoH7ISfzxfzLmXh2YFRkReX7AKUmquRoBvNcoyT8Qk=;
 b=QsK7Oy3Wu+rPLRcbJsPhxeki9G4XZj5/nNplA9doP6X8JTwu0Dx0dt+/eGnNqjnSaQonWkBDVRsFwINUhzCgrFGYSThN0oMo6nklBdKYM5WWtPP1StsqEFxLHKgTmvqZ+OfIvpzlCXjXX27ZV5jznFhbPTyD0AogD2GmgLTxK9A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3511.namprd15.prod.outlook.com (2603:10b6:a03:10e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Fri, 27 Nov
 2020 07:56:25 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 07:56:25 +0000
Subject: Re: [PATCH bpf-next 2/2] bpf: Add a selftest for the tracing
 bpf_get_socket_cookie
To:     Florent Revest <revest@chromium.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kpsingh@chromium.org>, <revest@google.com>,
        <linux-kernel@vger.kernel.org>
References: <20201126170212.1749137-1-revest@google.com>
 <20201126170212.1749137-2-revest@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8b0529f0-5f1e-b403-2772-7a56c44a3a55@fb.com>
Date:   Thu, 26 Nov 2020 23:56:23 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <20201126170212.1749137-2-revest@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:7e72]
X-ClientProxiedBy: MWHPR1701CA0016.namprd17.prod.outlook.com
 (2603:10b6:301:14::26) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1008] (2620:10d:c090:400::5:7e72) by MWHPR1701CA0016.namprd17.prod.outlook.com (2603:10b6:301:14::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 07:56:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ab188ac-4c2d-42af-7ee9-08d892a9f073
X-MS-TrafficTypeDiagnostic: BYAPR15MB3511:
X-Microsoft-Antispam-PRVS: <BYAPR15MB351181944539A719FEC33EDBD3F80@BYAPR15MB3511.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjQykDDkHQlR2TATz3zAcMKKZNEa+6YEzVvwEkdDI53K6dfqax3DH+rumtVrNjXkTYxWBuRbFNqODKiBJwtVu7BGHKlv3PNLbSyBB9HP6FlaGIfk5WgSb67OckQHPt/jx2TkJEhoN+UMfuKeAp67eF0Pbk/T3MaB/b8tqxXTwOCRzF1PYCGJETa+Hcm+IsWRV9D3M62uKHUeV9+JqFbZrecZVC1uJtFteuuZ0KecJpTVCEF9OKylhniHJUz/eN50yp4iTXHKX1MajNqclsZQ8MrKaneWgHrKPuQlW71of9s/znJ4dlRj+jz/yOfl9z0NuoPMeOWIEtTma3FN0ZJCfRh/9O1i3i0oiI1JqtN2hPy0ToX8vbBUmK9NGY6ZJH0/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(346002)(396003)(31686004)(2616005)(6486002)(2906002)(316002)(186003)(52116002)(53546011)(8936002)(4326008)(478600001)(16526019)(8676002)(86362001)(66476007)(66946007)(83380400001)(5660300002)(31696002)(36756003)(66556008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R1BxZzc4eXVqU21ZSGd2bFliVU5HdStLYXcyVG5xbGY0eDhpRGtXelpyMEZr?=
 =?utf-8?B?clI5UWUvSU1uV3pRWkVmQkNRV0FVQlhrcjRCQ2dNdE9VKzNoZENiNW5PLytw?=
 =?utf-8?B?dkdDcEJhZnVEMGwxRnl2ZVNtVE9qRGVMelgrT0h6NmlxbjBRMWlLMlRvRm50?=
 =?utf-8?B?NU1BTUIwbWpKdXJzRFV4ZWs0eUdWcUFiTXRmSVNhb1NGenN6UnFXWGVMLzdr?=
 =?utf-8?B?d0hienNqNWpVSXVIN3QwV1M0d3M1T0RILy83NzBCNGNnL1o2LzEzY3VwSjZj?=
 =?utf-8?B?RjUrTkhvNFZUNjdZOTViVlFFRXhiUmE5cGVTM01kdTd2OGZ3Z2xjdzdNQW5z?=
 =?utf-8?B?K2FmQ0xTQUtqWCtiVG1qWHVrcjN1MmR1SkpFRVJjSUVUWEszWWxKY1FQaUJX?=
 =?utf-8?B?Sk1xck04MkdVSkN4SmJEdDE5Z3BnOVZXQmJQWkx5VWVXU2pUVUVwc1crSU0x?=
 =?utf-8?B?QXlhZjg2d3FWdUcwM3c5c0JZWUZLTXJsZ3NPM1A1R2ZQNTJGQjdNaS83bU01?=
 =?utf-8?B?dUZQSlFpTzBZNVdyMWRXNVpqRjJSUHVKMEoxdXgrb0d0dDM4QjlkNVBXQ1B2?=
 =?utf-8?B?QTBvSjB6UUlKdm1KQjlqVGlXSk1ITms5WUlCWkxCeHJoT3UwUndYRFFSc1VL?=
 =?utf-8?B?TU0zUGRndU1lRDNvNFppODI4YVVmWHJESXdVRTcrSU4vYXp3SENRejd3MUl2?=
 =?utf-8?B?NFh2M3VkN092TlAvQ2hndlJCMWFvQURLVHllMTJoU1hVS2R1TzR6ZS9nL1Bu?=
 =?utf-8?B?ZFVYQzJsUzFzUGF2V0diMUpuQWFFR1B0Z1VEd3RSSk5TZVpFVm55d01DL2wx?=
 =?utf-8?B?SFBWWVloUEZmUmsxRmtIVWFBc3piMk1LZ1hyMXQ5V0xQRms3VWFuQm5ZU25L?=
 =?utf-8?B?Tm1OOWRmODdDZ09jWEpYeVFMbmt0R3J1RGpVY0RsRkpQNWgvV1FoR1ozNzND?=
 =?utf-8?B?Z2NKbWh4eTRWdzRKYWtiNjI1dWNQbDhDcklVWVlvMVVoNUFDamxPcldoeUZy?=
 =?utf-8?B?NTJKcW5pQ2JidVdRS092NXo3ajducTl1OFg0NnRsZUlHU1JXcnlBZjIwaEFT?=
 =?utf-8?B?S0cwaGRSaUtyeFhFdlcwdVRxaWFkQ3h1WW5seVB3TjFDd1NON1ExM0tlTlBC?=
 =?utf-8?B?eERtVFNOTXVTMTQ0Vm5PWlBDaGt1Yk83dEt2U1RybkJRKzBDWDY1a0VSZmY1?=
 =?utf-8?B?ZjRXNWc5cXJ6cUl5QWk2UlVRTm90T2oxaUpNZTIzdWRkUnA1RTRadmJPcVJr?=
 =?utf-8?B?UCt1bWo3UktaN0VNMXA3MVZUR0R0OXZ4Smx5Z25Fa2RhdFoxeXZheTVmbHFR?=
 =?utf-8?B?UWg0V0Y1aEVDNDhzWitMbHY0TW8wVTdVWnY2UHliVFBMWXpqampKQkMzZjVx?=
 =?utf-8?B?ZWpvbm1IQ2Mwb3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab188ac-4c2d-42af-7ee9-08d892a9f073
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 07:56:25.5833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfBNkZyIIEdGjdmbRGD4IPaN5QbLC0QA+lzbHBpOyoZPnsnGRmni9UMwcXrs7YAO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3511
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_04:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011270047
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/26/20 9:02 AM, Florent Revest wrote:
> This builds up on the existing socket cookie test which checks whether
> the bpf_get_socket_cookie helpers provide the same value in
> cgroup/connect6 and sockops programs for a socket created by the
> userspace part of the test.
> 
> Adding a tracing program to the existing objects requires a different
> attachment strategy and different headers.
> 
> Signed-off-by: Florent Revest <revest@google.com>
> ---
>   .../selftests/bpf/progs/socket_cookie_prog.c  | 41 ++++++++++++++++---
>   .../selftests/bpf/test_socket_cookie.c        | 18 +++++---

Do you think it is possible to migrate test_socket_cookie.c to
selftests/bpf/prog_tests so it can be part of test_progs so
it will be regularly exercised?

>   2 files changed, 49 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/socket_cookie_prog.c b/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
> index 0cb5656a22b0..a11026aeaaf1 100644
> --- a/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
> +++ b/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
> @@ -1,11 +1,13 @@
>   // SPDX-License-Identifier: GPL-2.0
>   // Copyright (c) 2018 Facebook
>   
[...]
> diff --git a/tools/testing/selftests/bpf/test_socket_cookie.c b/tools/testing/selftests/bpf/test_socket_cookie.c
> index ca7ca87e91aa..0d955c65a4f8 100644
> --- a/tools/testing/selftests/bpf/test_socket_cookie.c
> +++ b/tools/testing/selftests/bpf/test_socket_cookie.c
> @@ -133,6 +133,7 @@ static int run_test(int cgfd)
>   	struct bpf_prog_load_attr attr;
>   	struct bpf_program *prog;
>   	struct bpf_object *pobj;
> +	struct bpf_link *link;
>   	const char *prog_name;
>   	int server_fd = -1;
>   	int client_fd = -1;
> @@ -153,11 +154,18 @@ static int run_test(int cgfd)
>   	bpf_object__for_each_program(prog, pobj) {
>   		prog_name = bpf_program__section_name(prog);
>   
> -		if (libbpf_attach_type_by_name(prog_name, &attach_type))
> -			goto err;
> -
> -		err = bpf_prog_attach(bpf_program__fd(prog), cgfd, attach_type,
> -				      BPF_F_ALLOW_OVERRIDE);
> +		if (bpf_program__is_tracing(prog)) {
> +			link = bpf_program__attach(prog);
> +			err = !link;
> +			continue;
> +		} else {
> +			if (libbpf_attach_type_by_name(prog_name, &attach_type))
> +				goto err;
> +
> +			err = bpf_prog_attach(bpf_program__fd(prog), cgfd,
> +					      attach_type,
> +					      BPF_F_ALLOW_OVERRIDE);
> +		}
>   		if (err) {
>   			log_err("Failed to attach prog %s", prog_name);
>   			goto out;
> 
