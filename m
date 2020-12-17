Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6B52DCAC5
	for <lists+bpf@lfdr.de>; Thu, 17 Dec 2020 03:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgLQCBO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 21:01:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15550 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727992AbgLQCBN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Dec 2020 21:01:13 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BH1sAuv021229;
        Wed, 16 Dec 2020 18:00:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=udSCCU1JCdQ/a0eTwesKw0EPxCNPtF2hRUWfk0SXizA=;
 b=PwojphNwPEGh6d9WMqGWK3TjhilsaDP26LBDCqvJkcyW1FJrDRrgK1MQdUEoDPb4JvTa
 mm9CstYspTvnQAmex70GkHLOFkT0fN+9B4GDh9/M/yeEEiJJYxMVc+Q4ugyOLCXEmvEK
 VlSbcZ0lhGa7PT6LbPZGBUbybw3Y59BnGt0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35fn0sb5uf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Dec 2020 18:00:17 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Dec 2020 18:00:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcoE3Ju7DFvz92LynW1GSsXGOJYQxnn4fB1mR6a083YW38pLCrdWg0UO5DcFlncBOesYJd0cBmzukenoU/OzNarh4B20eeak4O0Vs+dsFD6eIqPH5ViULdoJNJJuGkBUtY+AlChFDGIvNY+Qv82foZA8payJefwuQxNL9CRGhTrGIAMjXDUpAAmZnmyLjmsMFU8akzc7LoLnk1vHMlbfViZQKGUSghnGz0TUoZhEwklX4frmOlHjuSlX/dJSHaYBvW4ErDWxIJI1U62b+3gjKT9OQ2iZmAH3+/CP7Kk0BiNty7AexegXB+GJOA3AkBsqK8n1e7dREy03gH2GH87/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udSCCU1JCdQ/a0eTwesKw0EPxCNPtF2hRUWfk0SXizA=;
 b=HZ3AXVzYiGn8ZCdNE6oxyzBzCB3W3NHgEn/jT/76eXaPUVP5NbeP8tdJwpnLJZDM6BF534H9IWaI1m9gD2QXp4fzjioLzvR1NfxP9jN6RzBFLZEsoo2LNkbt748nw64cIehrubnJO0IC83wu7+Vw46Z0O+mizD9iW9nPyhMXBv+kEgyTjNQSt5bSpsh6KFORjKQYlKF2RwSwcNQYfWdMK0NgKDHoimDHu4ZOpKVSTrLKvHvl8kqeagPsuKrKZsV/s56alAEbtToDqPNwK2VOhtrmjCke3FZQU9fAQZlEHLxTIGxPP8pV27bLH1AG2JqvnsIdwZdWM7JIUBjm5TXL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udSCCU1JCdQ/a0eTwesKw0EPxCNPtF2hRUWfk0SXizA=;
 b=C1M7JjW7ddlPAp6ioQ7uvt6Hie+VyaSot1hC/T8r0K+vhjxOUc8HIs+lgJN4rEofXRnoXLLLLbkbrs7gK9dzau4IMF5w+vdXE4acoDuKz6SZqe0kt9WdMsCMEF8URBd+Dmsa559f6TnalOBe3gtCRWi/aN7HVAzIk+tSEkP4bo8=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3046.namprd15.prod.outlook.com (2603:10b6:a03:fa::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 17 Dec
 2020 02:00:13 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3654.025; Thu, 17 Dec 2020
 02:00:13 +0000
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add unit tests for global
 functions
To:     Dmitrii Banshchikov <me@ubique.spb.ru>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>, <rdna@fb.com>
References: <cover.1607973529.git.me@ubique.spb.ru>
 <4a0f45692b124b7bca139a6c58c131496ec2dc12.1607973529.git.me@ubique.spb.ru>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b6600648-1549-ded3-e736-1f759dee7b09@fb.com>
Date:   Wed, 16 Dec 2020 18:00:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <4a0f45692b124b7bca139a6c58c131496ec2dc12.1607973529.git.me@ubique.spb.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:843a]
X-ClientProxiedBy: MW4PR03CA0200.namprd03.prod.outlook.com
 (2603:10b6:303:b8::25) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::12e6] (2620:10d:c090:400::5:843a) by MW4PR03CA0200.namprd03.prod.outlook.com (2603:10b6:303:b8::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17 via Frontend Transport; Thu, 17 Dec 2020 02:00:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dab7e225-f977-4701-917f-08d8a22f7e49
X-MS-TrafficTypeDiagnostic: BYAPR15MB3046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB30462013F9AA704972D4DC6AD3C40@BYAPR15MB3046.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpstK8SROpTP94bA3Ev1F7xuce95W+cQMpLjQ+KWzFEkX/r3qZrymK0Ht4RFD5kA4UoTra/TekDGK99bcF0lnXmqfIsaRFkHnyQI2W3+5T5f2T4ojhbpDLrLtyJUZgei/oFFSrhCZH/wnaRXIsx80gg95LT3YY7CW2qk5d73IxQCO6KaegeuBSHtvsgdMGWhKkvQhGsqNwlw/NkGS+ZWC//Lzn/EkceyD8pOpAGTUbwleF1VZ9/4nrWWZyXlNL/eUACyROvHQNSD/1s5C9xu2R7dxpmUd32T+cnvLMJGM7kY6t47XCVCeBFo3EKSqOghQ98l4r6G3vLQPxHhaz3/oAtmARqNOqtl3pcI8UEu2XCwQceDGhAhCwOEL+iKofnINixiPSbGMQAE3CfAgQTiZ4vsQZXkulvBj4MRGhjZG88=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(366004)(136003)(66556008)(8676002)(16526019)(86362001)(5660300002)(8936002)(36756003)(2616005)(52116002)(6486002)(31696002)(31686004)(83380400001)(186003)(53546011)(316002)(4326008)(478600001)(2906002)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Vmx4WmsvalVVY1lZbmNYcHRnZVJpcUszMVV0YmxFMnFJa2Z0RC9UU1k4WG1l?=
 =?utf-8?B?QmYyVHBJTS9FWTJFYUs4cUlNTGJ6dEhjYmVTd2VMTjhUTzFOQURaT1pqdlZa?=
 =?utf-8?B?UkZNM0Yvb2hJQ25OZWo1RzhjQThiNGZBWDE5MWRlYVhSRm9DLzNPdmEraXEv?=
 =?utf-8?B?MmJrWGpxVlNPNDQ1cFNyUHZmUE1peDgrWUd3d09DR0lWZHp5UG52Q1c0WURZ?=
 =?utf-8?B?RkorMkx1MlhvaFhnY0JJN3gzRmt1R3VqVkRvaXozMFZiNlo1K1BUazZ1WjMw?=
 =?utf-8?B?Zmd2N1BVSE9WYi93ZE5lOS9sUGdDc2pJckxYMFJRNWljMDJuOTJMVlhVdkhN?=
 =?utf-8?B?SlFVWFVpaE1UN21hWGtYaXRoN08wdDg2SDdHeTRadDZNZXB2RzVxYzFDOGkr?=
 =?utf-8?B?eUlBMG9Pc0dCbkVXTGJEcU1qc2JBcGtFWFZueXd5OWxwak5Eb3NKZlR4aXZO?=
 =?utf-8?B?ckJyT0pZRmZJUnZlSVBpZGoxV0c5TTVSbG1RQ0N6MlBvcDhxRytrVk4ySVFE?=
 =?utf-8?B?QlhZOCs0aUNKazQvWnd5RkZoTkFtZjFwdUxJZkJqOUpIZzk4MVlqN0hZTlVR?=
 =?utf-8?B?Tng1OXRFR2NWLzc2MjZldWdoK2VEMzFubTJBV2RNNUsyRm94VENXUW9iUTEv?=
 =?utf-8?B?ZEdxc2hqWWJuSjlOcmZWZDJRVlZtemNiSGxkcEJNKzFvYWNicjM2eFBHMDAz?=
 =?utf-8?B?dmtPdjVTV1RYdnlia3JuZUZNejh6OWNIc2Fmdmw4UHdEazBoaVp2aTV6RjNn?=
 =?utf-8?B?ZFIrWnk0eDMxd3cwbEFWWDVrSzFwanJFcmMwNEtrTjVia3dadlpGVzh0VEN4?=
 =?utf-8?B?bHZ2eldHVFlsY3FsaFV4Rmhycm54NzdBUWROYVVwYlg3Rnp6RG9QTVdWaGhI?=
 =?utf-8?B?Ti8yRXBVekxqQ0ZEWnhyaHViK3dUSVZjckY1d2ZuSFBORDBaSXdGUktIRDJw?=
 =?utf-8?B?a0lYYjd4NUwvb1BsYkw4SGRrQ1RmQUlKdGt0cFNZZThaZ0xkNHlZVXRkZHlj?=
 =?utf-8?B?bHFCZVp4TkhQV2tTUldGVzh3UnduTEFmZkszSjVoOUZaZjRER1BxWURjcjhG?=
 =?utf-8?B?R0hhQkhSOEZDWnJUZEEyNk1rbFNJSVdWaUxObHpuR2hzVm5aMVpQNjJQbEtH?=
 =?utf-8?B?L3FreW5VekJYZmtHRjYxOHg5V0VUNWI1S0JCWnFYQUdiWDBWd3ViUWtRazB0?=
 =?utf-8?B?djRxcnREeHozMndGVm1JR0FFcHhtOGQvVDJna2xYaUduMEttRkdsMVdaOUJu?=
 =?utf-8?B?My9jZmFNUFo5YnJwakNPcEFsVm9uSDZRM1VoLzZxNDVLSjB6Ly9YNTlaZHFH?=
 =?utf-8?B?M2FXL1k0MVBudWdLd1cxSkhoRWxya0ttZGV2eUxOSDM3enYwYVQ4MzdlTVVO?=
 =?utf-8?B?RmhDRzJsQkV0aWc9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 02:00:13.7339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: dab7e225-f977-4701-917f-08d8a22f7e49
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uznNV/K6ztwLJuFQ7R3LSVQRj1XjeDP9YQKMO9BTXBDOrY4XPev0eB9Uv2iRjNXE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3046
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_12:2020-12-15,2020-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170011
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/14/20 11:52 AM, Dmitrii Banshchikov wrote:
> test_global_func9  - check valid scenarios for struct pointers
> test_global_func10 - check that the smaller struct cannot be passed as a
>                       the larger one
> test_global_func11 - check that CTX pointer cannot be passed as a struct
>                       pointer
> test_global_func12 - check access to a null pointer
> test_global_func13 - check access to an arbitrary pointer value
> 
> Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> ---
>   .../bpf/prog_tests/test_global_funcs.c        |  5 ++
>   .../selftests/bpf/progs/test_global_func10.c  | 29 +++++++++
>   .../selftests/bpf/progs/test_global_func11.c  | 19 ++++++
>   .../selftests/bpf/progs/test_global_func12.c  | 21 +++++++
>   .../selftests/bpf/progs/test_global_func13.c  | 24 ++++++++
>   .../selftests/bpf/progs/test_global_func9.c   | 59 +++++++++++++++++++
>   6 files changed, 157 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/test_global_func10.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_global_func11.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_global_func12.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_global_func13.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_global_func9.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> index 32e4348b714b..c4895e6c83c2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> @@ -61,6 +61,11 @@ void test_test_global_funcs(void)
>   		{ "test_global_func6.o" , "modified ctx ptr R2" },
>   		{ "test_global_func7.o" , "foo() doesn't return scalar" },
>   		{ "test_global_func8.o" },
> +		{ "test_global_func9.o" },
> +		{ "test_global_func10.o", "invalid indirect read from stack off -8+4 size 8" },
> +		{ "test_global_func11.o", "Caller passes invalid args into func#1" },
> +		{ "test_global_func12.o", "invalid mem access 'mem_or_null'" },
> +		{ "test_global_func13.o", "Caller passes invalid args into func#1" },
>   	};
>   	libbpf_print_fn_t old_print_fn = NULL;
>   	int err, i, duration = 0;
> diff --git a/tools/testing/selftests/bpf/progs/test_global_func10.c b/tools/testing/selftests/bpf/progs/test_global_func10.c
> new file mode 100644
> index 000000000000..61c2ae92ce41
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_func10.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <stddef.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct Small {
> +	int x;
> +};
> +
> +struct Big {
> +	int x;
> +	int y;
> +};
> +
> +__noinline int foo(const struct Big *big)
> +{
> +	if (big == 0)
> +		return 0;
> +
> +	return bpf_get_prandom_u32() < big->y;
> +}
> +
> +SEC("cgroup_skb/ingress")
> +int test_cls(struct __sk_buff *skb)
> +{
> +	const struct Small small = {.x = skb->len };
> +
> +	return foo((struct Big *)&small) ? 1 : 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_global_func11.c b/tools/testing/selftests/bpf/progs/test_global_func11.c
> new file mode 100644
> index 000000000000..28488047c849
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_func11.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <stddef.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct S {
> +	int x;
> +};
> +
> +__noinline int foo(const struct S *s)
> +{
> +	return s ? bpf_get_prandom_u32() < s->x : 0;
> +}
> +
> +SEC("cgroup_skb/ingress")
> +int test_cls(struct __sk_buff *skb)
> +{
> +	return foo(skb);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_global_func12.c b/tools/testing/selftests/bpf/progs/test_global_func12.c
> new file mode 100644
> index 000000000000..62343527cc59
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_func12.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <stddef.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct S {
> +	int x;
> +};
> +
> +__noinline int foo(const struct S *s)
> +{
> +	return bpf_get_prandom_u32() < s->x;
> +}
> +
> +SEC("cgroup_skb/ingress")
> +int test_cls(struct __sk_buff *skb)
> +{
> +	const struct S s = {.x = skb->len };
> +
> +	return foo(&s);
> +}

I assume struct member write is also supported? In the next revision, 
could you also test case something like

struct S { int x; int y; };
__noinline int foo(struct S *s) {
     s->x = 1;
     return s->y;
};
SEC(...) int test(struct __sk_buff *skb) {
     struct S s = {.y = skb->len};
     int ret = foo(&s);
     return ret < 100 ? 0 : s.x;
}

In the above, to facilitate implementation, if initializing s.x is 
desirable, we can do
SEC(...) int test(struct __sk_buff *skb) {
     struct S s = {.x = 0, .y = skb->len};
     int ret = foo(&s);
     return ret < 100 ? 0 : s.x;
}

> diff --git a/tools/testing/selftests/bpf/progs/test_global_func13.c b/tools/testing/selftests/bpf/progs/test_global_func13.c
> new file mode 100644
> index 000000000000..ff8897c1ac22
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_func13.c
[...]
