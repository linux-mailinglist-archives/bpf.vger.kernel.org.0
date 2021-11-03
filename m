Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA0A443B6C
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 03:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhKCCkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 22:40:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31422 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229650AbhKCCkV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 22:40:21 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2LbIB5004484;
        Tue, 2 Nov 2021 19:37:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3YCTPTpB6qOUGsastAjPm/cDKREYTCG4tDBaEn++BkY=;
 b=BzoXmqskJVhtkw3g/VHzCDya9s9XSbS2n9+MNV8vPirq7U7enDSbZ57r7OpO3dMkHIwA
 PKZ4YGMe6eA706QJj8kN6TsOgK3neG5DiBVXVoYY3rg1SFLVXbA9bQB2+FpfkHLZGjQi
 uC8WbZo6/8rxMLp1aZAWQ1zg1r1p6Cah8dc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3ddfhm6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Nov 2021 19:37:21 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 19:37:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiHBWDv2OXKPBZNcCBFWvhMmQiGTwH3WxS3KuX7BqCnKY008J2UKs6emRfBIgJmpomw9puDuh+r0vHjm9Y2MfcApqRGfV2SLc9So8G7jKdCwGoxv5O7E+IJ3Bw4RV7c+vYw2L1rPvOKAzn9yTzQtjXxrr7I4glkwoApeqvUoeSsguJ/D1Mf1vCN2FatSYKm1fnQBOvQTYE2oS0UvP80nVqQIv09tKWFzmbFLsEcHS2tJzL0LKg4HO/KQnfuh23fTo8Q6dD5gMdACSbCv+QaXbv7l17gnrSAbKROhxEGJak2+ui8o/lSRlfPtLecX1VUaFwEJqnt/SpU/Kq/R3B9vNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YCTPTpB6qOUGsastAjPm/cDKREYTCG4tDBaEn++BkY=;
 b=jTcWJTebJP6VRWiSrAUn4FNqThzek7nIqedBU0DLHM+foUDyJ7ZEVdFQq/KoXye8tSdZIa0c6YssCL4lHNbEBwSHz15RsdY4onLiTqXo229J0LgKj1UXy9EysO86Ft4cDZpEY8yyLhK4NcBRTqOTMFwPsZ+l/E/zoT9fr7v3X8x5OJBtVUjAZnDbkUd+Ttr2KWGorPxQEcbUTPWlnj93QiwLE9fAc2qF5JSHnXD1TSNpZ7+sbRK/JDFEq6iRrySREiOwDIy0/sJuA8dAwohTUYb3wccTkjnPFCXL/hHDi50K2lWlLhn7p7O8W4a5tCUIjTTKQLLLMkH+TWRv8StNPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2128.namprd15.prod.outlook.com (2603:10b6:805:f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 3 Nov
 2021 02:37:20 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 02:37:20 +0000
Message-ID: <c01bfc5b-7f65-bd40-fbee-69745b6d3d60@fb.com>
Date:   Tue, 2 Nov 2021 19:37:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next v4 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
Content-Language: en-US
To:     "zhudi (E)" <zhudi2@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "jakub@cloudflare.com" <jakub@cloudflare.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <fd5046d2575a45c2b97965207226b500@huawei.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <fd5046d2575a45c2b97965207226b500@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:300:13d::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::198e] (2620:10d:c090:400::5:deca) by MWHPR20CA0014.namprd20.prod.outlook.com (2603:10b6:300:13d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 02:37:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7592e5c-c586-4c8e-b450-08d99e72db96
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2128:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2128B42AE410398F3FA33272D38C9@SN6PR1501MB2128.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/gQH5AYDzCpEcS1IAHYcYIBrIM/yleyMrES1c85HV2u4CzvlBoaOziRh5uFlC/TaU6kwNwZFVnf/zbz6jZO6SXROoSQGLTFFB2idKvyzb8I8kEq1otABtZFtKn3pBvcloC8gOmqZzdvuGo7AqqA8vnlxZ1NZS0iJ1PttLKws2l/kIDaA11WSmIPZAjXQBIozm/AMDlAH1+2zEiIL4UgYBJQmMEOtBj2kZG7sKw7icabn/ySpHRH0ZvFkU1aresgxeIIk/yZmsgKYXkjC8bjFqE3u5hBZBaz4Zhd1dL01Qsj1EO4FF2z09Qrcbt/iSP+p3WVFpLqXie9ZZNFtfEzt2f2pjHvg3u7A18NgQFbjFfYgduKXiZHnkX+HbehmQgkT53X7A8zFqYqgImgIce1jLcdDcsOO47uBvEjyrfXikPdvQbkViuWmA+A7ULaCnopMr6yG5k9G9VpzG7XweOKu+PCQju+M5YB/2fIN90lyrV+lxwZnbgUuu1k5bgB/rYro6h2+2RSUFdgUQrn62N8GfuG15/W62UDOC3E7arj24dYIrkGT88TkL5apmEZrhYnONdFUrqMAfyUAwsTc5gNPYLFf++Hx4nHnqAbXrCKgkRujK0sUtH6jgcBkNjpXjtrEcAQV7uRSEtLhMlny/+zDYZS0Cc39Blv1d48RVrYyB2bdN78F56Rumdgr7CjlfU9hgMRdFHCqgfrP8nDE29SEcIgBtT8wjNvr0vvHn6OSU8raENyQNP8jdIx3Nrzo89zU1yC5VmIeLCD2IC+6seIBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(110136005)(83380400001)(921005)(8676002)(316002)(2906002)(8936002)(86362001)(38100700002)(36756003)(508600001)(52116002)(31696002)(7416002)(31686004)(53546011)(4326008)(66946007)(186003)(66476007)(2616005)(6486002)(5660300002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1BmdXpmWjF2cTRNMmZ4K0tpN3prVVZwdHk4RGlUV3N2cVA5RFB4cFhuMHFR?=
 =?utf-8?B?bHlWVUc3bnlaY0ZQQnErclZpRDBTOWdMKzhUbWo5ZVhnQ3ppNTE1dTFiTXBN?=
 =?utf-8?B?MlZYU0tzRmlCWWFTb2dzbGwvaEZ1N1ZGVHNGM0lUYnJ0bVhMSzZNT2F4eS9B?=
 =?utf-8?B?Q1NvUXFCMTVadmM5UGtSLzlYUWtLQ3FCYjFsTS9Pd3NlMXpJMjVVenp3WE5k?=
 =?utf-8?B?YTBXMlFWaDZ5L3lnaG1zMDkrNERUTGtqR3BNcDBSZ21sMXV0TVI0STVpWHJR?=
 =?utf-8?B?SDMwNUI1cnkvVHorNWFLenNxWmZCTko5MDd0a0o2NGsxdk1oMWdjNDd1ZHJZ?=
 =?utf-8?B?MmE1MFllMnlyTXBWQzlFaG9OUmNFblVvMVpuU3Zsa1lUS0Vzbkt4RkVlTVp5?=
 =?utf-8?B?UVBaeXJXeUJwRVRBbHNUUXgvaUkyT2w1UEx2MVE5bDFNdktRb1dhTC9Xc0Uw?=
 =?utf-8?B?NFNjbnZFRUFKMGhTN0s0cjl1UFlBc3YyQlJTK2gvclNjdEhWSzZWRWhyNlRa?=
 =?utf-8?B?aU5tSEprWDNNSGJHVlZUdFNiVGswVnZuUlBIK2xONFNuQWNUYWVYaVFTdWc5?=
 =?utf-8?B?VGJ0QlFoTXdFaGlNVjROMFBPWk1yZm9Ra1I4SFI0OVpoZ0s5NWlMWXF1Rk9O?=
 =?utf-8?B?MzVIN0hMcHh3bVptLzRZaktmSmc1eCtMazBlWStzZTY2VjEvK203UHhDczA1?=
 =?utf-8?B?ZzFEbkV4R09heENQeWx2SFRVZGtHeGxjWVZWVWc1SzVtU0o2dnRiK0NZRFIy?=
 =?utf-8?B?YWpzRW5FcUNQYWo3UG9yTEh3eTlPQmJtMkEvd2xhOXZWSzdUcUZvTDdHT3NH?=
 =?utf-8?B?ci96QlB1cVBGamY1L1crZFFWRmlHV0Q2ekNUWncyemlndG82RWlUeWh5N0NE?=
 =?utf-8?B?djVQY2drQzh1R2VNRUFPS2ZBNUZSUUoxVWMxcjRhaEZrZ2I1Y28xY2JDMnlI?=
 =?utf-8?B?bEN6RHBtbkxjUVhPSE9JL0ZUdzJLbFNwUUdSMG91SWIzbk5tTE9xZ3FleEEy?=
 =?utf-8?B?aVZUVDg3R20zYnc4ZmRUeDJYWDBxUU9kUzE1SGlmTVRyd3R3ZWc1SjhaSUdm?=
 =?utf-8?B?blJIdk1CQUxmVFlFV3hpN0cvZzNvMmRYWjk2bE5DWmZXSnc4eUJkZnJiRUpY?=
 =?utf-8?B?Wm1HR0xqeGl2YmRQRldOekZ3SCtibEVTWlV1MUJqZ2JBNXZHK0xpbUw3RUV2?=
 =?utf-8?B?anhnNXZZdFNQRWs2ZnlLU2E0V2Y0ZXZ5ZmlHSms3bnlRdmZDTmRVSTZ5Rzlv?=
 =?utf-8?B?YllUV3M0YnIwYTZTOVIvc0I4cXF3TlRENFJNYVoxbEdJUjJja0doakl1VHJN?=
 =?utf-8?B?Rk41NWRTQUpvT1hQTDJPNmpoblhYL29TSFo5ZTJBRFVaSmczS0oxdFhiT1BV?=
 =?utf-8?B?dDBjd2FHQkN0U2pIa3NTVDVOSlhobExIREhyblo4RnNPVGtWbGZpSXEza2lG?=
 =?utf-8?B?VWoycnROWEkzOGFhNzZEa0Q0ZnYzRytCelVYTFZpc2tHdzZLek5lUEdmMi82?=
 =?utf-8?B?MUJRQkhyQTlsRjZXSFBOUThxbUhXTGlUZ2s3QjNPcVBZRUpUY1V5bFRMOW5I?=
 =?utf-8?B?bVM5OE9BRGdySU42aEVjSEptUkdnMWx5dFdaQ2RxYldjQk9yRTlJWWh1OFM1?=
 =?utf-8?B?cnhXTS9wWjI3OW8waTdHMWhwczhvNCsvVDd4cmxYdWMxSHYxZXZpQ0JEdHlM?=
 =?utf-8?B?MVI2WU41TURZOTFXQVJVS3ljY0tYTldabThuVWFjbUxWSmJWTHovUXhMNnlo?=
 =?utf-8?B?a0xrUmoxWC9ibEJhVjgwVDJFTzdQMDVhNXRaaGRUZmFVQ3gxSHlPNGh2ZHp4?=
 =?utf-8?B?ZTVIU2RxSTJEVkJMNitYbE5JcXIvejJzZGlKMEpmdjBkelpZMkorR29GTUpC?=
 =?utf-8?B?eEczYnRHNEVVWHJkSVc5cHhBNWFMNldmOGZtQjB0ZFZJcElDY3BVdWI0U1Jh?=
 =?utf-8?B?NDlNdXJnWFZvcGpsTjN1c2VnaU9xUElpU2Z2Mm0rWG0wd0J5dHBnTjg0aDQy?=
 =?utf-8?B?YjhOZU5IRWhoQi9FTnpUNGlhVDhoUS9BYWRqbmYybEVzL2w2TUtNRFF6WFZn?=
 =?utf-8?B?R1QxLzUzM25mV3B4L01ZNTVSSVpNR1hJaWxwMk9xT2pPaUF1VEVZeWorTWhs?=
 =?utf-8?B?MXVxZ0RBcHVMQk15WnFVaHc1SWZSaklRMnMxb2RiQWEvNDRUZXEzL2MwNjIz?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7592e5c-c586-4c8e-b450-08d99e72db96
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 02:37:19.8612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAIbPf+hmi8mYEyBBSsxgv+QYp+DcHnhf5OyGEUxapA5jE2JuFCTvMn9Um3tFv20
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2128
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: DvKoSM0b2FsfJQiI8fvIiwmJbM8JhCsW
X-Proofpoint-GUID: DvKoSM0b2FsfJQiI8fvIiwmJbM8JhCsW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_13,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=870 spamscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111030012
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/2/21 7:23 PM, zhudi (E) wrote:
>> On 11/2/21 1:48 AM, Di Zhu wrote:
>>> Right now there is no way to query whether BPF programs are
>>> attached to a sockmap or not.
>>>
>>> we can use the standard interface in libbpf to query, such as:
>>> bpf_prog_query(mapFd, BPF_SK_SKB_STREAM_PARSER, 0, NULL, ...);
>>> the mapFd is the fd of sockmap.
>>>
>>> Signed-off-by: Di Zhu <zhudi2@huawei.com>
>>> ---
>>>    include/linux/bpf.h  |  9 +++++
>>>    kernel/bpf/syscall.c |  5 +++
>>>    net/core/sock_map.c  | 88
>> ++++++++++++++++++++++++++++++++++++++++----
>>>    3 files changed, 95 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index d604c8251d88..594ca91992db 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -1961,6 +1961,9 @@ int bpf_prog_test_run_syscall(struct bpf_prog
>> *prog,
>>>    int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog
>> *prog);
>>>    int sock_map_prog_detach(const union bpf_attr *attr, enum
>> bpf_prog_type ptype);
>>>    int sock_map_update_elem_sys(struct bpf_map *map, void *key, void
>> *value, u64 flags);
>>> +int sockmap_bpf_prog_query(const union bpf_attr *attr,
>>> +			   union bpf_attr __user *uattr);
>>
>> All previous functions are with prefix "sock_map". Why you choose
>> a different prefix "sockmap"?
>>
> 
> Thanks for all your suggestions, I will make changes to the inappropriate code.
> 
>>> +
>>>    void sock_map_unhash(struct sock *sk);
>>>    void sock_map_close(struct sock *sk, long timeout);
>>>    #else
>>> @@ -2014,6 +2017,12 @@ static inline int
>> sock_map_update_elem_sys(struct bpf_map *map, void *key, void
>>>    {
>>>    	return -EOPNOTSUPP;
>>>    }
>>> +
>>> +static inline int sockmap_bpf_prog_query(const union bpf_attr *attr,
>>> +					 union bpf_attr __user *uattr)
>>> +{
>>> +	return -EINVAL;
>>> +}
>>>    #endif /* CONFIG_BPF_SYSCALL */
>>>    #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
>>>
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index 4e50c0bfdb7d..17faeff8f85f 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -3275,6 +3275,11 @@ static int bpf_prog_query(const union bpf_attr
>> *attr,
>>>    	case BPF_FLOW_DISSECTOR:
>>>    	case BPF_SK_LOOKUP:
>>>    		return netns_bpf_prog_query(attr, uattr);
>>> +	case BPF_SK_SKB_STREAM_PARSER:
>>> +	case BPF_SK_SKB_STREAM_VERDICT:
>>> +	case BPF_SK_MSG_VERDICT:
>>> +	case BPF_SK_SKB_VERDICT:
>>> +		return sockmap_bpf_prog_query(attr, uattr);
>>>    	default:
>>>    		return -EINVAL;
>>>    	}
>>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>>> index e252b8ec2b85..ca65ed0004d3 100644
>>> --- a/net/core/sock_map.c
>>> +++ b/net/core/sock_map.c
>>> @@ -1412,38 +1412,50 @@ static struct sk_psock_progs
>> *sock_map_progs(struct bpf_map *map)
>>>    	return NULL;
>>>    }
>>>
>>> -static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog
>> *prog,
>>> -				struct bpf_prog *old, u32 which)
>>> +static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog
>> **pprog[],
>>
>> Can we just change "**pprog[]" to "***pprog"? In the code, you really
>> just pass the address of the decl "struct bpf_prog **pprog;" to the
>> function.
>>
>>> +				u32 which)
>>
>> Some format issue here?
> 
> 
> Format is right, passed the checkpatch script check.

Sorry about this. I guess my reply formating cheated me:

 >>> +static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog
 >> **pprog[],
 >>> +				u32 which)

I see a larger misalignment between "struct bpf_map *map" and
"u32 which" in the reply email. But looking at original
patch, there are no issues.

> 
> 
>>
>>>    {
>>>    	struct sk_psock_progs *progs = sock_map_progs(map);
>>> -	struct bpf_prog **pprog;
>>>
>>>    	if (!progs)
>>>    		return -EOPNOTSUPP;
[...]
