Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C7944DBF8
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 20:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhKKTPF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 14:15:05 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52632 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229785AbhKKTPE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 14:15:04 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1ABJ4uSu005187;
        Thu, 11 Nov 2021 11:11:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=jy++++2bATrn6YykkhRB3z0ppCpiL13HzqsHwnLepow=;
 b=gaSUYuTyY+NFA6eUMPY+ZFAYVVAtfKrxs3ZxS0OWtSL36aa0pi0rKuJDHNnRCdBSK5Fc
 ixPNkBWcmgRsZpre7dlGcTV2TmLsuxhHFp7PrLzyDGWex8u4NI6n0x/R2s8vw8T5LaLM
 hFxymNS2aMeDmo9unw7F+VPQ9yEnxh57t+U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3c8xjjd4wg-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 11 Nov 2021 11:11:58 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 11:11:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsonfHMWeWPqMpRXJKwyzAoJmtnKRxjkd1pYFBmQlqzJWpAHSziOZy331kejCdW01WmAl6O18C+mQte/dHpcnVkm0SIiWw2traPOMCUBzb85CJcMVgtJXzvxq06u3+Oh2+F/RneMl2F5+hPR5EpLcoZx+HNUu4hGr+5TzbViL90aAWEaP1d4gzRIhdqK4GMfddZ/+mgUa3iCwlG1K0PETW9aceIVx2et7L+qQ7QjZanmvBWtdEIAB7ZtdqyBV7T8GmSj0OPmEWlJR/C2UA0OLVwdrfMNjlxUQNG7N0QYFThZ9jLkgnChM/x5maO7Tb9V0UnleungKY+Lh66k57XJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okewQVRHpPGI2uYudY1fOPybC6xUSqVM3R6xOdhYack=;
 b=lo7svUviDgqSIXdfd4lYOzcnl815KrNam1MoD40WuNmn8y1a9F+O0ZoibRUQaYIxH58FyLe+OlxN5AtySXo/H3sGlcS6KCVIewsCzUNTaW/bYqFVhdRsQYQb+9RK10JC8OuK1E83nZPVUQR+WIy1811Wvs8jIS1+WHd5wXfMXHFbRvA/+ODrcDLEn41VjlFkHHR9bAes2bDNW14oy/Jl82Fqz/xQpK9WXc3CeQowUwcpN4MM+jzWIIJd4nTJEmbKHqkzZJAwZ1WX/DxXcUY+HP9rMUWILezMl6gJJJkjeshowhKOp3NdtAnhWkx7rA5w+tM/PIu2luYzkQiNz3jkKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3935.namprd15.prod.outlook.com (2603:10b6:806:8d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 11 Nov
 2021 19:11:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 19:11:31 +0000
Message-ID: <3949a319-3ef6-cd7c-051a-91699739169c@fb.com>
Date:   Thu, 11 Nov 2021 11:11:27 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH bpf-next 01/10] bpf: Support BTF_KIND_TYPE_TAG for
 btf_type_tag attributes
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
References: <20211110051940.367472-1-yhs@fb.com>
 <20211110051946.368626-1-yhs@fb.com>
 <CAEf4Bzbd9X1HOYNt_DiOz4meZVxPNPE=0g7H-R1qZu6D2EGZ3w@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4Bzbd9X1HOYNt_DiOz4meZVxPNPE=0g7H-R1qZu6D2EGZ3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR22CA0039.namprd22.prod.outlook.com
 (2603:10b6:300:69::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPV6:2620:10d:c085:21c8::18c7] (2620:10d:c090:400::5:918d) by MWHPR22CA0039.namprd22.prod.outlook.com (2603:10b6:300:69::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 11 Nov 2021 19:11:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d26602e-e046-47d6-aace-08d9a54711d8
X-MS-TrafficTypeDiagnostic: SA0PR15MB3935:
X-Microsoft-Antispam-PRVS: <SA0PR15MB3935B80D781AF18416EF88F5D3949@SA0PR15MB3935.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4v1gdstFkXN63NbnRAU3xkRp3O6e/TTlgB2E6X8kB83rVVG/7q4Wk5e8S5nRffkVJXfV6QsqB8/Di6Yk15gK/18irv15VOfYqAmF/FI3A0+Ev7gUiPZXGG5CpqKB4zNmZfyiiMHhhPx+KMwAi5gXPWWnlx+2tRmN9sCJTRP5rEPPIWRNxpUUbm4323Wu4J+qVwDDW0kNJFkyAYbKelaMO3qz7r6uVosuvW271KEUu/8E4NjggOD0cAeDKLBhy9I/Xe2ZQXNY+Cppr6f4qxyy5fUfG9HjwbTFJgLNms2strgrRrBjpfjgprXleuqHWVlm9KTqmul/Y/Bb7suI3GSpMqZbwmER5HpwXH6I+cnSDfznd9eCleWL0kprXujufURtthp+qHdAFkLF25RKFR4aWr6HARelBCDoapWxIvjxRBoWNMkBwdMKf9XaIT2XhKN/YLYvTTVm5mIHCT1kdMYFFTOHsMsJjzd4IVKXshPmH+MF5G+Qw9DU00+kD1I2e2O/T2AMkbQ8sLgnZ59SSFo6m7FNf15XqM+uCozX5B2sIVsbLRww89UyFO+DgTzSgiQb6HRY7FQjljWdKKcbIqFLz9CVmDWnY1UjMSzynm0tXUE9dqCGaW5PKmaMn2zmL10jzUxtDujVk8NpNTdNAUiAh36xUtA+ER2EYBRUTK24g7d7B12vJcU6MGAN2Kul8t4XfSOu/7kcRg5+Jr2QFMRB/A7G3P2/fxdq0InhRy6z4gLRNx1zK0PnjBompyvZ4aozz6IaqiNNRjIGl784AQg+cPPDuTF5m8qy3QH//iijIINpOB3nDpSKby46cnohHuygnRs8AvyfsEi9ZQcHP+Zg58Cf0IvalWY826lIMdYbTR9Zrpci2ScZlliEE/SbveIQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(4326008)(2616005)(31686004)(316002)(66476007)(54906003)(66556008)(66946007)(966005)(31696002)(186003)(6916009)(36756003)(86362001)(8676002)(53546011)(38100700002)(52116002)(83380400001)(6486002)(508600001)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aldDOW9KZHVhajF5c0lWZDJiamJmK2kzZVZ4WVNYY0NheHlaZ0xnWGlNUmpt?=
 =?utf-8?B?UzYyMG0vZWY3cDlnSVYxSGxjQ0Rlb29tall2NGpCdFJXOXlPd2RoUDZlUkZZ?=
 =?utf-8?B?dWgrOGh5c3AwL1VFWlZRZWppb0o4SWROczBjWVdia09INjZEaW1PN1JNWUtw?=
 =?utf-8?B?MDg3WFFJMU9jcGk0Zk9XQ3JCK3cvZ2lFZGdQTTFkVXUyTzRqTERIS1l2QWZX?=
 =?utf-8?B?bC9yakpUcTlBYUZSNzVmWHlrcHpZTXRXby9KelU3dWs1NFUvRW1KclVOV0Vi?=
 =?utf-8?B?eExraWt4U3NuTmIySVFqMVMxcm9CSGhKMlpRSDczeVpoS1dBeFdHYlRrY2Vi?=
 =?utf-8?B?SzRSanZGaCtsMXREUDg0S2NwVVB1a2hSWllLUzVvL3VtVzJZclVPdHBHVU5q?=
 =?utf-8?B?cTNEY2JJTjVyU2JQbHVQR1JUcWdNY1VlNlJzb24rVzU3alQ2NmtXRSs0VCtH?=
 =?utf-8?B?eU1Zb3RMY3lQUmRhRlh6enU4Kzk3MktoczFpQjYxTmxXNnRMdTBsbytucjZQ?=
 =?utf-8?B?QS9VbDRxU09wOWJveGg4UDI4c3lQcjZuT05CZ2tFdFVzcVpaekkyUW9uek84?=
 =?utf-8?B?NmVTUnpoMjFQcUpCcTZucldWcks4dHhSRXdFYzdaUCtzMzVBaWRWai9aT1Q3?=
 =?utf-8?B?Mjd6ek41a3FNYldqRnJBbXpTcDVkaXk1V3ljL0UvSTViVGpJdlBrU3RmUi9z?=
 =?utf-8?B?Y0Q5ZGpGa0pFK3JyWisxRTd5c2hlWVRIbU9Obi9leFlBWHVjSm10ZHg3a0FQ?=
 =?utf-8?B?U2JqTlVHTHE3aVRXQ0g0M2YrQWljMEhsQmtkRkJqU0JJNFRoSGk2RU9NMDlC?=
 =?utf-8?B?amNVY0IrRU5IUDV2TmkzQzJVRE1XWWhlam9KYXA2WUo5UUFuSU45TktNYzZr?=
 =?utf-8?B?ejY3ZUFwNkZXZXErYlFuTFNPTnlpeDVMUHhqUEhZeGt6Q3o4RXhDNXdQL1gz?=
 =?utf-8?B?ZlVQVmM5NHZaTzNiMkJrUHh6eHNiR0orSXhGcVgyNTJ2ZEhMdGdsMk00Ny9B?=
 =?utf-8?B?emJrRUhWU29iekRCY1d1bUhRbGJFNWdQbEpReUdqSjhtdlM1TlNMTCtTbGkr?=
 =?utf-8?B?dlNHWXIwYUNuWVkzQm9mMWU0ekt0N20vUVJwcFhuWXJJS3ZrMVIrdGEyM3FX?=
 =?utf-8?B?Q3R5Zm9zV2c4b0dZOHZSU21iZU15Unk2UHR6QXN5dGxWOUFLUVZmeENlaWhu?=
 =?utf-8?B?dGRmSE1DcnBodEFjekFscVJkQVNCd0dpcXl6MHh0QmJyQTN1cHYxSUx6SThK?=
 =?utf-8?B?b1RiZ09oUGJwVkM0ZnNqd3FuZzZWY1YrWC90ciswblduaGhCZDRNMjBuYmc4?=
 =?utf-8?B?Um5kb1JSVjU1ZnpsRnNSN2xnY3VwOUhsZTRVbCtrMzZ0SVE5NFlMcFE2d05R?=
 =?utf-8?B?c0ZhMm50MlVxSEpRU3Z4Ums4VTliUkJFWnFGemxGOTZLZzRpeEpKYkw3ZlVB?=
 =?utf-8?B?aWpNUEF2ZzlLSEVpbFFlUlUwcDYzVHJjNkc2UGFIL1BRaGFxdUtKSnpFangx?=
 =?utf-8?B?UElTNmJodHR0UmFjbmtEZVgxZTdyYm43UHh3Z2hRYW1pYUNTZHdLT1g5WUht?=
 =?utf-8?B?RWJXQS82SndvZmI5S2Z1RWdvZUIvWmR6LzhRZm5kK01YbjNVVy9jMHB2aitK?=
 =?utf-8?B?UVhSeGorVTVQTXpYNUdiNFVxY2ZOWXhhRmpiRytiem5CZ0I5UlBubmthSmgv?=
 =?utf-8?B?TDRQd2MySkcyNkRXRG0zMjJqMDZJbWRPa1M0RWpvOXhwa01pR1V4QUNHR2ta?=
 =?utf-8?B?dDJSM1BTR1RVSDZ3cnNDOUtTK0hIeXNHZFdoMXFIMkNYTFRUU2tJUHZFdjI1?=
 =?utf-8?B?S1FOcHpJc2pPUGc4UjY3ZHYzMnpiS0RLVlFwTVZ3ZjVMT0ZqTmxkNUFEU0I4?=
 =?utf-8?B?eExUVUtxYXBpWW0yM2hHQThyR3d5UmFBNHZHbXlxUEx2bnlHYnJFN0Mxa1dS?=
 =?utf-8?B?U0VNUGlMOG9tZVRGK2NjZnF2Smxqek9wenQrV25mTDdOZ3BkcmpOQkVmL04v?=
 =?utf-8?B?L3Z3b09ZQ1JUL3o5NVNNeUgwRE9KVUQzYmYyWEdpcVIxQzB2VFQ4SnZFTnZN?=
 =?utf-8?B?LzkrNkVobXhGU3c2czVQd0oxaVpsbFBUMDhOS3N4enlFZHBaV3JFQU1FYkRi?=
 =?utf-8?B?NzY3ZXhnNTJwQzN5VHIwTXh5SSs4bkNkbVQvNGFOOFIwaW16dkNZdWREQzd6?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d26602e-e046-47d6-aace-08d9a54711d8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 19:11:31.1268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TobestlVsUJsa8sCnV6/W6Nkkrx3cFxa/npU6MaDmQOfdJ8QmGu9HMBIVvANndd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3935
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: meu3XvwNl_DNdaG4y-5EPbQzVB2l6W7F
X-Proofpoint-ORIG-GUID: meu3XvwNl_DNdaG4y-5EPbQzVB2l6W7F
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_07,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=876 suspectscore=0 spamscore=0 mlxscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/11/21 10:27 AM, Andrii Nakryiko wrote:
> On Tue, Nov 9, 2021 at 9:19 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> LLVM patches ([1] for clang, [2] and [3] for BPF backend)
>> added support for btf_type_tag attributes. This patch
>> added support for the kernel.
>>
>> The main motivation for btf_type_tag is to bring kernel
>> annotations __user, __rcu etc. to btf. With such information
>> available in btf, bpf verifier can detect mis-usages
>> and reject the program. For example, for __user tagged pointer,
>> developers can then use proper helper like bpf_probe_read_kernel()
> 
> probably meant to write bpf_probe_read_user()?

Oh, yes, a typo. should be bpf_probe_read_user().

> 
> LGTM, otherwise.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>> etc. to read the data.
>>
>> BTF_KIND_TYPE_TAG may also useful for other tracing
>> facility where instead of to require user to specify
>> kernel/user address type, the kernel can detect it
>> by itself with btf.
>>
>>    [1] https://reviews.llvm.org/D111199
>>    [2] https://reviews.llvm.org/D113222
>>    [3] https://reviews.llvm.org/D113496
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/uapi/linux/btf.h       |  3 ++-
>>   kernel/bpf/btf.c               | 14 +++++++++++++-
>>   tools/include/uapi/linux/btf.h |  3 ++-
>>   3 files changed, 17 insertions(+), 3 deletions(-)
>>
> 
> [...]
> 
