Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6411B31F4E0
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 06:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhBSFjR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 00:39:17 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54942 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhBSFjQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Feb 2021 00:39:16 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11J5YBGR015414;
        Thu, 18 Feb 2021 21:38:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=sQo+G57pecugqGey8gFp4QpyhOn1ZhaFSgb8gNeyVcs=;
 b=LQqDgsrI/8DIzPoeWn9XRTjpFgz6CijA2E5YcgApEj2KI5bOK5NjDOmrwOyWhOQ3W4DX
 ojRms7ebSJOFBwkRFhoiUsSZc9z7SoK8zqoYujWU9YTUzezggaJOhbI883nE9dkcDOoh
 khUuhVI+xLiVzAmEkPMct/ZRh4jGRxOkGUI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36rrd8q4a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Feb 2021 21:38:16 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Feb 2021 21:38:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3Sx4uedOj7/Wac/vqb0T+ubMy5C7z4LlGam4snFACJ0Oseda5ZYVHoSEAYJ54kAxj6IX4YiRTXQBsQ5RbwVqvSlGnOlPP53dA4bCDrb7++QhMEIwgZRJaJVaxD2sK9Y+EBozAw+ywzaypxBixkmPDS8kDTakW9DKuZ8sCpYWFcqS86opvfq6fQPl2j5rd2MW/RN5uDxwuUuLlLpud6/k+UhKR/eUQGuzbI0XZC/tB8ZQNxho32s/x5x+4CJYN4HhzDh54WE2I9GV9ay6hyENhOqTegPxzkTij7wH2mEaPjSUBM0ZEKUj9E+VQZsn1Pei+DECbMt2n36Ws33F1uPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQo+G57pecugqGey8gFp4QpyhOn1ZhaFSgb8gNeyVcs=;
 b=cemHfKdJHTuhUMx7c4P9JS7yAcVYEU4o9FIPuUPQjK9eqvU5aaDSt/CsGiwxAOnONchR67FMpjuGowY3V6G7LKjefB2vsBLW19uMpRuGA2Fg+GDTyL9ZIhezdWmwblaZP7zTFlKiu3m/NEHw4cS/Lec1akXlwuysLLnzQ8uHpEOxDk+qQS2DsKi59BBmFenEVO81lVUeLbFbLyWxVcpY5ZTgHSXLUv93UH7LG2wRgTn6xWmGtF0CQXM+hw0aUmFuuYlu3btNGNLFsiuQFibJeDZRpHpuj5GsJYKX9nWRi2o7QeO/nHZJx4EhxMdUXNamhWOfpxXd6zpoQNGJwZ3IGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2455.namprd15.prod.outlook.com (2603:10b6:a02:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38; Fri, 19 Feb
 2021 05:38:14 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3846.041; Fri, 19 Feb 2021
 05:38:14 +0000
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
Message-ID: <ccf4174e-f574-59f5-1edc-8ab8306dc269@fb.com>
Date:   Thu, 18 Feb 2021 21:38:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210219022543.20893-6-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:45c1]
X-ClientProxiedBy: MWHPR15CA0072.namprd15.prod.outlook.com
 (2603:10b6:301:4c::34) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::110e] (2620:10d:c090:400::5:45c1) by MWHPR15CA0072.namprd15.prod.outlook.com (2603:10b6:301:4c::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 05:38:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d38ecae-6806-4b86-6508-08d8d4988cf7
X-MS-TrafficTypeDiagnostic: BYAPR15MB2455:
X-Microsoft-Antispam-PRVS: <BYAPR15MB24551EB9C7F18EEAB7F7D93AD3849@BYAPR15MB2455.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GKs5WgLs/Z5ZVHBsOmH9D7GKsmkZYVDEGJsyVXU5ay27chRUa6YxTQmHKQOQ8w/j4ueiGVRsugLVpdZrG0YN1GVh/MQb+2eNYFnXkUfJm/0NY0VpHxM7QRfjPbOFn4QulzoEKJKwgwg5hCkxldjaJMQ6t4ZTYhY0p/z3ccAnU6+aWpm44Bj2n44/1p5REHiah9W+Y34IYKJisDyhwyFGiEus3PkRScU7WaA8NcDlWuy9GDZvOO9PymFu5ReYepm5V6A2Wgkej2B7gKlzrOvbLkEsnp0SFd63qqx3HJtiHiYV5VOLL7isQgutsCQXLjif+WjOe3GM7LDlvAfY6alU6pIXsO+OnJbSAUFHwJSAgSm7Guynwuc6xTwrijorFsp4amqRxUdFtbn+X3nRXFWfdSTuawW64h6IriW4/sgMWBDxixxTYz43HYX1sjOomYx8vjrC32Hd9/lAuc/lQwOOJo1JPvxbFFXihsU5zndqREwIZRi7VbSH6d3pXjZCIwze/FnXMqwWlvjHqBzHr85aKXEG4joMCmt9RJPRtU2xCzDJwlshJIDfxrnVwqY/dxogJuw7Q0IOkvSk3uuFiI6PqYr8tMPa9G2WrxF4ksNBERo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(396003)(39860400002)(8936002)(86362001)(66476007)(110136005)(478600001)(6486002)(31686004)(31696002)(66946007)(83380400001)(4326008)(52116002)(186003)(8676002)(66556008)(2616005)(5660300002)(16526019)(2906002)(53546011)(54906003)(316002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bEppY1MvUkp3dk1Vc3VBcEZKa01CemUyUWZ5ejM2VXhpejVBdVB5aWRqZEZX?=
 =?utf-8?B?anpFUm8xa3NKRm14S3NqQ0ZtRUV6Vnd4RjF4cy9NVHBPQmhOWUp3T2lJT3FS?=
 =?utf-8?B?MkZJclhOWTZ1VzI4QktDQy9JMCtsbE5WSlhpOGdhYXBiU1E2UWlkM0xpT0tz?=
 =?utf-8?B?ZHRSSmt1RlRuT1lZMEZhNW9xc2ZRTHF0WENIT0FXUDgwVlp2Z01US3p1eGxa?=
 =?utf-8?B?dCtSbTg2b1B4dExVTmtlR3hxMnlwaVZIWjRyK2d1M29YR21aQU8xOTk0OG1P?=
 =?utf-8?B?ekI1QVRKN3QrcUU0cytYRHMzS09yWUVIK2htTTRMWXNmM2VzbUxaOGlTTWtR?=
 =?utf-8?B?YXJ0Ny9XcEYzaVQrRUw5RHlIbHRmSm1OQmw3U3JleHZLRXl2VmIzVEc0OFMx?=
 =?utf-8?B?Wm9WUjRXR2dMUTRBeS9GT2YvcFhIek12eUF1RXZPUk1PbjhrNGtNTXdNK2oz?=
 =?utf-8?B?SG96ajYxQXhaU21qZFF6VjVBdElaR1ZuQ2pQR212S1dxeTZsMldXbkM3cmdB?=
 =?utf-8?B?VC8xSEwxektiWFN0N2JRY1d3YU9lSGdXQXBvVDVTL3hMNjZpYWVjTjdDYWhK?=
 =?utf-8?B?LzJDeXhibGhqcmZDNDltSjJwbXFTTmlLQWRTK2ZLdTlMZFhGVEV4cnJvb1NU?=
 =?utf-8?B?V05rcVcweDdvcHZPdDBTTE5qcUZQYTd0RUszZndNdDY0aUxyeUszditzOCtS?=
 =?utf-8?B?RkpCT2l4ZzUyUEJsdGFBc05KZi9nOERSVHo5QnFFUlU2amtHUFJCbXVucmhN?=
 =?utf-8?B?alNvTlBUZ2JYc08xdFRUZXdOMlQ0b1pUcFRiVkVQNXpQa2VKTkpBbEhTcGZh?=
 =?utf-8?B?ODJ2c2hiYmhaNk5PMVdjSVp2cHJPNHIwR3I2YkNPS25qVnZYenl2eExLY044?=
 =?utf-8?B?Z0o5R2FJdlAxZ0pDRXM3Nkw2MnpwMHlqamI5SmxRSGM1TUo5WnZ0U1hySFNq?=
 =?utf-8?B?UGdnaWV6S0RDWDlZcG1POXEvcm1WVUovQ0tueEcwNUFxbDBiZVFPaUI1dTRt?=
 =?utf-8?B?Mm91bDNidUNVWi9LMXkwdGJtajlHTk51cHNSa3R5dnV3QS9sOStMWXZWNlFx?=
 =?utf-8?B?VHY2WThlSk1HSXQ5ZXFZRnFqL2Y4L3N5YXVSOHNKc1ZaSGltaHYwR2ZIMlho?=
 =?utf-8?B?cWhQODFBSmtnbHdtNFIvN3ZaTUFQT1ZwbXB2bUNBL21zbmNjRzJEYmwreHU3?=
 =?utf-8?B?bk5NVk1wM1lsL0JmMGVIVFI2U1FEdFl6dmM5ZklnVFlrZGlDelM3Z2RnMm9k?=
 =?utf-8?B?YVZHTzlPaGUybStVS09KblB3QVgzMTl0OWtscVBKc3RZVHNOYWlUaUdZMG0r?=
 =?utf-8?B?UzQyQm50RVZTSDZXdS9MRUFyOXpHbkhOQk1jRTFtMUJHYm5OaEdFSFlyUkpV?=
 =?utf-8?B?R2hWSDZLVGpUNHlwZ2pzT0JmeTZzZkppbWx6ZytycU5Vc0NXNlpXUS9yelVU?=
 =?utf-8?B?MFBrWEhCSGEzZnNScW5WTnpzKzIzOEEwTmV5Qy8zaUZJRDV0TkZoM3pQZHBQ?=
 =?utf-8?B?UTBrTHZneEFXUHF5OW1FU1ZjeFZISkdpc1VOaVhOU2t4RzN6eU93SDdyOVpv?=
 =?utf-8?B?QWdQYnRXZnpuaUtXKzUvOEs2Um5Uck1sQnUvbStzMmV1Y1BRWjMreWhwdlJN?=
 =?utf-8?B?K09ON0ZnaEpwdlowR2s5Ky9yOC9PbFowK2JvbjRNMDN1bXNZb2lJM2hpMzJZ?=
 =?utf-8?B?OGo4TkVkYXEyWHBwT3BCY29qQzMrSThjMjYzaGFibVFUSGlyTTlZRVIxOUdJ?=
 =?utf-8?B?ZGdZc3JQY0lwTmhBYnpSdXBpR1M1b1ErcjQ3Mi9MUFdjcU9RVGJmM1ZHeTJv?=
 =?utf-8?Q?iwfOOoOeDP0GYMynqcfrv0nrCZ2v1m/btVn0k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d38ecae-6806-4b86-6508-08d8d4988cf7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 05:38:14.0324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pw1wFWdOOdC7ohGR30yLe+q8OqujnPZ2mW42cxNYABTCeXoI1eL8atM6t0M5lp8l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2455
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_01:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102190042
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
> +	.descr = "float test #2, invalid vlen",
> +	.raw_types = {
> +		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
> +		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 1), 4),
> +								/* [2] */
> +		BTF_END_RAW,
> +	},
> +	BTF_STR_SEC("\0float"),
> +	.map_type = BPF_MAP_TYPE_ARRAY,
> +	.map_name = "float_type_check_btf",
> +	.key_size = sizeof(int),
> +	.value_size = 4,
> +	.key_type_id = 1,
> +	.value_type_id = 2,
> +	.max_entries = 1,
> +	.btf_load_err = true,
> +	.err_str = "vlen != 0",
> +},
> +{
> +	.descr = "float test #3, invalid kind_flag",
> +	.raw_types = {
> +		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
> +		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_FLOAT, 1, 0), 4),
> +								/* [2] */
> +		BTF_END_RAW,
> +	},
> +	BTF_STR_SEC("\0float"),
> +	.map_type = BPF_MAP_TYPE_ARRAY,
> +	.map_name = "float_type_check_btf",
> +	.key_size = sizeof(int),
> +	.value_size = 4,
> +	.key_type_id = 1,
> +	.value_type_id = 2,
> +	.max_entries = 1,
> +	.btf_load_err = true,
> +	.err_str = "Invalid btf_info kind_flag",
> +},
> +{
> +	.descr = "float test #4, member does not fit",
> +	.raw_types = {
> +		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
> +		BTF_TYPE_FLOAT_ENC(1, 4),			/* [2] */
> +		BTF_STRUCT_ENC(7, 1, 2),			/* [3] */
> +		BTF_MEMBER_ENC(NAME_TBD, 2, 0),
> +		BTF_END_RAW,
> +	},
> +	BTF_STR_SEC("\0float\0floats"),
> +	.map_type = BPF_MAP_TYPE_ARRAY,
> +	.map_name = "float_type_check_btf",
> +	.key_size = sizeof(int),
> +	.value_size = 4,
> +	.key_type_id = 1,
> +	.value_type_id = 3,
> +	.max_entries = 1,
> +	.btf_load_err = true,
> +	.err_str = "Member exceeds struct_size",
> +},
> +{
> +	.descr = "float test #5, member is not properly aligned",
> +	.raw_types = {
> +		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
> +		BTF_TYPE_FLOAT_ENC(1, 4),			/* [2] */
> +		BTF_STRUCT_ENC(7, 1, 8),			/* [3] */
> +		BTF_MEMBER_ENC(NAME_TBD, 2, 8),
> +		BTF_END_RAW,
> +	},
> +	BTF_STR_SEC("\0float\0floats"),
> +	.map_type = BPF_MAP_TYPE_ARRAY,
> +	.map_name = "float_type_check_btf",
> +	.key_size = sizeof(int),
> +	.value_size = 4,
> +	.key_type_id = 1,
> +	.value_type_id = 3,
> +	.max_entries = 1,
> +	.btf_load_err = true,
> +	.err_str = "Member is not properly aligned",
> +},
> +{
> +	.descr = "float test #6, invalid size",
> +	.raw_types = {
> +		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
> +		BTF_TYPE_FLOAT_ENC(1, 6),			/* [2] */
> +		BTF_END_RAW,
> +	},
> +	BTF_STR_SEC("\0float"),
> +	.map_type = BPF_MAP_TYPE_ARRAY,
> +	.map_name = "float_type_check_btf",
> +	.key_size = sizeof(int),
> +	.value_size = 6,
> +	.key_type_id = 1,
> +	.value_type_id = 2,
> +	.max_entries = 1,
> +	.btf_load_err = true,
> +	.err_str = "Invalid type_size",
> +},
> +
>   }; /* struct btf_raw_test raw_tests[] */
>   
>   static const char *get_next_str(const char *start, const char *end)
> @@ -6632,6 +6753,7 @@ static int btf_type_size(const struct btf_type *t)
>   	case BTF_KIND_FUNC:
>   		return base_size;
>   	case BTF_KIND_INT:
> +	case BTF_KIND_FLOAT:
>   		return base_size + sizeof(__u32);

This is not correct.

>   	case BTF_KIND_ENUM:
>   		return base_size + vlen * sizeof(struct btf_enum);
> diff --git a/tools/testing/selftests/bpf/test_btf.h b/tools/testing/selftests/bpf/test_btf.h
> index 2023725f1962..e2394eea4b7f 100644
> --- a/tools/testing/selftests/bpf/test_btf.h
> +++ b/tools/testing/selftests/bpf/test_btf.h
> @@ -66,4 +66,7 @@
>   #define BTF_FUNC_ENC(name, func_proto) \
>   	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0), func_proto)
>   
> +#define BTF_TYPE_FLOAT_ENC(name, sz) \
> +	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
> +
>   #endif /* _TEST_BTF_H */
> 
