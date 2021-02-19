Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D9331F4E5
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 06:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhBSFpe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 00:45:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49528 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhBSFpd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Feb 2021 00:45:33 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11J5YrwU018122;
        Thu, 18 Feb 2021 21:44:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=DkRqgTylDKpR1nxR/L2/PSAWWWoBeWzf3eaFnbJUeiI=;
 b=XNLwiM6QfGcQx2m5JSr0uG8NlhxIFfInMwxn9Y0uTXfoUC9oZdNfoX657Odw+va2RrXW
 zAp9NpagUbpbk/qfFGMj4rM668w9k0kKTQHez2KPr4BUf1H2XsQWaiUqRjqTQR4HtYW/
 hFhA3GPWJMoawS5s53wFY2eisPN2eSmxQck= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36sdpmquf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Feb 2021 21:44:35 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Feb 2021 21:44:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l82/wSZ0iF6nEQgUf/CXuXG4ltXg//WqkptBHf+8KxXny6qJ/oG54ho3kgOlBMnJqVAuQzSAA4tqKZF/7LihlzolhD2PTyLNhEXjicKgxjkdoCNxMdLiFmMlnzrKCtnzVpQJBXc7Mz/ZyaQ0Wx1yvvUC41DaI8bsLuV77zDkY7Mn6vX3c5p5igsgKuCR0VXajkiz2jq3gLdw0RQ0zTJcxuvs34ZkH3wHPeEuqqIMRYzSsS7jQunUOgVL1EdLRH79ObjifAgz9du2s4NzdBnuY9EafXhOKEhPXw4Axb3lKQGBsBOeoz8vFp2BNy8GLAI6o3tB6QDs65hJV6mfyJjlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkRqgTylDKpR1nxR/L2/PSAWWWoBeWzf3eaFnbJUeiI=;
 b=NsL1khw/5Pc08HowpYwowBvc71yDrE1skNTyiB1eY+krwQJ3nWw9SjlFgAn/60QV7BOjlJ9sLKGt3GF53j15yMzheJNY3X/wooBZjGhFIU85XEVz08qNXLvBs98v9nvDf+N0tRv7r/Yn4DS4da3vRryhi/emOvP+CazWVMliB3o2gdThe+TymkCMjsd7Hw55/esOBfRrfQDWXJyCRmTg/izj2saV2PHdsWTQfW6GVHpvx17+TC8nFVj/hH7y4JfooRbB1NvXxxFR8mpe37oty8ixZ27IurZXPh/87EDOiM44DOT77D9C+Eko4wyaVB6x66K21i1yFb5K8uWxsdZvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by SJ0PR15MB4711.namprd15.prod.outlook.com (2603:10b6:a03:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 19 Feb
 2021 05:44:33 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3846.041; Fri, 19 Feb 2021
 05:44:33 +0000
Subject: Re: [PATCH v2 bpf-next 5/6] selftest/bpf: Add BTF_KIND_FLOAT tests
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     John Fastabend <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210219022543.20893-1-iii@linux.ibm.com>
 <20210219022543.20893-6-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <56742ddc-7f24-ae1a-dc0a-f65ea156dadb@fb.com>
Date:   Thu, 18 Feb 2021 21:44:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210219022543.20893-6-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:45c1]
X-ClientProxiedBy: MWHPR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:300:116::31) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::110e] (2620:10d:c090:400::5:45c1) by MWHPR07CA0021.namprd07.prod.outlook.com (2603:10b6:300:116::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28 via Frontend Transport; Fri, 19 Feb 2021 05:44:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a77f4cd5-1073-46ff-5311-08d8d4996f1d
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4711:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4711D56A3710DBF2E6C348AFD3849@SJ0PR15MB4711.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPyAX7/vISvkVy2XU5Ifq+7N6eOUvo0m0zhHBd7I1Ew1HbUZz8HGkJ5fchiqfx0JsmVMhASfu4haUvrXaQO6Vrytb8WI0Hwm43huqzqWjBUUeRFrkEn2tvzapGpS7h4107npsEcbxaJZtXeOb84/oE+6blhdEEciuSaSiZnQJejD16p2TgQDxKfJSIPE0bRwkzYeP/I5xhRbdPxU/djyyTU7QHq2ES/2Ou0s+Xk+NgK8fuwHES4p2DwpnbmsDrf6i2RhxA1e/0DpvLvUj8mMPeN+Bfs8WJbbPMIfuj+NK8O/9CxqTFVyUOBZk+b+ODGm+l5GaMr4Yd1YlIWknqK7viD/IPIULpbQBLZWA/wPMsk21BSzTZPidwc8fm2WxBz1J9/NQgWp/R7xQf9miZbv1LmJzkZdkUSzQuGt9PYjQJlKC07vVTL6BudGhZyaDmO/qew6UWDgx9n3NVXHTB5UiSosr7OMQ4NeOMK6UFzs6tTsB5kskC353JDhGFHEPKO9wuoSh5RgRyEABeoAhImpl171uVNCPnIk1XczfAsKRNAjbJqQRPSU+OdkcANEibWKIqq1RvxsH8q6dPE1bX9wqmYimmLiD0bdPA4noihtkwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(6486002)(66946007)(86362001)(316002)(54906003)(110136005)(8676002)(53546011)(31686004)(2906002)(4326008)(8936002)(2616005)(52116002)(16526019)(66556008)(186003)(31696002)(36756003)(478600001)(66476007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bnF1TkVRVGtEa3hWcFRFMGZmMnczRWovVG52T1VWcTcwaHRtaS9Vc2Y1dnlE?=
 =?utf-8?B?THVPbUEvaE9DZDBkT1JaMWtCa3JtMVQ4WW8xZnFnM0dqUDJhR2ZBeUVLelpF?=
 =?utf-8?B?QWZzQVVsUWdqbnBNZkczc3NLZEpsY0JoRUJSODNud1JCaHVVZ1d2ZW84ZGtO?=
 =?utf-8?B?bWU1dzQzVnFubjJHbGFMUGl0MU1EZlJ1aHZ0RHYxMVkzUUZJRjI1S0lLeHVt?=
 =?utf-8?B?RUljb0dkRERFUHFQRlc2UGd2TndIV25VZitIVGlMS2QvbFdqN2ozemMvYnJa?=
 =?utf-8?B?Uk5SQTFzVWJnTXRySk9STndVcTl3TjBjd0svRmJWU3dmRC9NMmVKbzJscklz?=
 =?utf-8?B?NjZoOVNxUEZieTdMTXByZm5mVnR4bUZmYTZBME5nUHU0TnhyZW5iYUlYb2pI?=
 =?utf-8?B?Uyt4YlU2ZXFDRU5nUFBUSFZETVJ5dXZseXN5ZHhUbW5XVmRZaG55YzI2R1N6?=
 =?utf-8?B?N1FBV0ErTlhlUXo1bWw5L3pRWkt2MVdWQXJ2S2I0MUFla092eDBkV2taMGJL?=
 =?utf-8?B?dmoyaFJEeklFb21BUkV6NUp0MkQzUjVvNU9BakxnNlUxUStsK0Z1N2RnRWNY?=
 =?utf-8?B?aUhhdmd1Z3FKd1hJZmtCU3I2VkZYa1VrUmdKMXMydjhQcnlsUE9yaE0raGpF?=
 =?utf-8?B?eStvc1pLTzR4RVNMViswd2ovSTBFaTUyK0o3OVIxcE42YjkrVkY0bXNOSU9G?=
 =?utf-8?B?OW9yNkRrZHRMWTN0WlozZEhYaHoxWVM1U0tON0NINTZOSWc5aHBML0VUZWVa?=
 =?utf-8?B?MlBFQWNWcXA5QmREOTBiQWdnM2tRaDEwL1NKRlA4VE1ocnBRT29xWWZ4emJD?=
 =?utf-8?B?L3cwVWo1aVM2elVkUmRtQStCUExBRFNZVmhLSDJlM1RUVytrNHhVek4xcFIy?=
 =?utf-8?B?UXQ5R1VMa3lRVGw4d0k2cnBqUU9qdGlrSCthdWJBQ25JUmNYM1BTeDlYQ2ho?=
 =?utf-8?B?U3hjc2piNFVQY3VDOVlIUkNxUlFQRXFYV29OTDRLL09VVGdjWlBTS0NTbzhO?=
 =?utf-8?B?YllKRndpN0Y3Z01hN0NWUFlHV0E5cmJTSW10clhuV2JjejZMUWlEWklpRG9P?=
 =?utf-8?B?RzAyNHhYd1EzSFcyNE5Rbm53eVlrRiswUTJqdmc4MFBHbUd1LzVVeDhBampr?=
 =?utf-8?B?QWVmYXgrQnZlMmlUMXU5UzlPU2N6cndtdVlFVVB2OHlEbC9EdkFWdU1ocEJF?=
 =?utf-8?B?ajgyRjdUanZZRVR0U1p0Y044ZGRwYlI2ZUFGZno5NElGbHd5dEpVVDRicnc5?=
 =?utf-8?B?dGpUaGk2RTY5cjBWS0VGMlE5dmVmcFZaRHMxMzdUN0JpZWVHU29JNUlXVjBC?=
 =?utf-8?B?NDB1YUZ2ZmtLS2M1SHpyQW1FQ011UXp5MWFETlg2K0J3Y1hIU2lvdFNiNWFC?=
 =?utf-8?B?MVIrZXZFN0U5RGlyQ3oycStITmpFZ212bGdlTHJWejd3b2ppdGtGUjY3QjRR?=
 =?utf-8?B?U0xGVHhxcjhCUDBLZ21BWm5lU0lpYXdMWVJtcFgwMmVCRDlRbXNrcy9XVWZD?=
 =?utf-8?B?YmZKMlZYTXZqVTRkWnVDMmkyMVA3VE01dUxEYVpvQStJNmdIbkJiUjJUV3hS?=
 =?utf-8?B?YUdkci9UeFZuZXJqa05ycGNEN0czOHk0cTYvNFArNmFkQjdwT0RPZG9CUnow?=
 =?utf-8?B?UDRxanV0Z0ZxSU9PRTN5OUxtbDcyblRZaHBMNi9uL2UvTS9EY3BTQUZIZXlQ?=
 =?utf-8?B?dVlIbmQvTnVwcTl1WnpraDZURmF2K3VzVHBJd1B3UVg3M3lMVGJQWE00ZVlu?=
 =?utf-8?B?TGVRVDFuUERCc3hFR3A1L3VkU3ZoQTFSeUVWbWFXbTRoU1ZjUndVRnBIbkdj?=
 =?utf-8?Q?rfGfZ3jjdijM6qHxJjnV6DEC5pmCdBiAhISRI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a77f4cd5-1073-46ff-5311-08d8d4996f1d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 05:44:33.3542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIqVMX7uIHuEPwHyG3hMfnKtlGX2zPD8TF1j1XWDrz9ErOcP1sSYR+201EVcL2Ib
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4711
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_01:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190042
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/18/21 6:25 PM, Ilya Leoshkevich wrote:
> Test the good variants as well as the potential malformed ones.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tools/testing/selftests/bpf/btf_helpers.c    |   4 +
>   tools/testing/selftests/bpf/prog_tests/btf.c | 122 +++++++++++++++++++
>   tools/testing/selftests/bpf/test_btf.h       |   3 +
>   3 files changed, 129 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
> index 48f90490f922..b692e6ead9b5 100644
> --- a/tools/testing/selftests/bpf/btf_helpers.c
> +++ b/tools/testing/selftests/bpf/btf_helpers.c
> @@ -23,6 +23,7 @@ static const char * const btf_kind_str_mapping[] = {
>   	[BTF_KIND_FUNC_PROTO]	= "FUNC_PROTO",
>   	[BTF_KIND_VAR]		= "VAR",
>   	[BTF_KIND_DATASEC]	= "DATASEC",
> +	[BTF_KIND_FLOAT]	= "FLOAT",
>   };
>   
>   static const char *btf_kind_str(__u16 kind)
> @@ -173,6 +174,9 @@ int fprintf_btf_type_raw(FILE *out, const struct btf *btf, __u32 id)
>   		}
>   		break;
>   	}
> +	case BTF_KIND_FLOAT:
> +		fprintf(out, " size=%u", t->size);
> +		break;
>   	default:
>   		break;
>   	}
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
> index 6a7ee7420701..4be14d853cc3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -3531,6 +3531,127 @@ static struct btf_raw_test raw_tests[] = {
>   	.max_entries = 1,
>   },
>   
> +{
> +	.descr = "float test #1, well-formed",
> +	.raw_types = {
> +		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
> +		BTF_TYPE_FLOAT_ENC(1, 2),			/* [2] */
> +		BTF_TYPE_FLOAT_ENC(10, 4),			/* [3] */
> +		BTF_TYPE_FLOAT_ENC(16, 8),			/* [4] */
> +		BTF_TYPE_FLOAT_ENC(23, 16),			/* [5] */
> +		BTF_STRUCT_ENC(35, 4, 32),			/* [6] */

The float and struct names can also use NAME_TBD to avoid potential
miss counting, I think. This also make it consistent with using NAME_TBD 
below.

> +		BTF_MEMBER_ENC(NAME_TBD, 2, 0),
> +		BTF_MEMBER_ENC(NAME_TBD, 3, 32),
> +		BTF_MEMBER_ENC(NAME_TBD, 4, 64),
> +		BTF_MEMBER_ENC(NAME_TBD, 5, 128),
> +		BTF_END_RAW,
> +	},
> +	BTF_STR_SEC("\0_Float16\0float\0double\0long_double\0floats"),
> +	.map_type = BPF_MAP_TYPE_ARRAY,
> +	.map_name = "float_type_check_btf",
> +	.key_size = sizeof(int),
> +	.value_size = 32,
> +	.key_type_id = 1,
> +	.value_type_id = 6,
> +	.max_entries = 1,
> +},
> +{
[...]
