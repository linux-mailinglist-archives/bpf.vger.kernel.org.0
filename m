Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478192D155F
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 17:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgLGP7O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 10:59:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30330 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725804AbgLGP7N (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Dec 2020 10:59:13 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B7Fw1D1008973;
        Mon, 7 Dec 2020 07:58:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Y5wcnFtGWDICQfOh4AcjGdPqU6HfaEKzHN1zV8Hu0Oc=;
 b=A91BL+Op8kSL4EtMb2Ka7JidMG13j4/99IwhkPSqaj7HViquu8dsl2nkGWZsmOooTTrJ
 gGtT/XeSlJRp1yAHyxgFvdVQdmtZH28+ra31v/dKP8+ubmZgYq1QulZR7c+v6FnLe6X7
 aMqzBXdMnYZb6WDrVCyX9dzv1Dh39vUmAP0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 358u5apxcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Dec 2020 07:58:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 07:58:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3AqU6YQYyzOPPevtSNUdgMFqOYqD6M6CzP/KMMAojE1nLZOb6WcMHsrvtgl1DZGvvK3cpZ16/+DNKaRB5sG7COQleDjXCGc2ECIehv2Xy3Dk/71SNWSek5HVm8dvydhslgGghocoAw7Ev8d5x1i6guh+OifgX7tLt3lzm2apJwHZ7SCO2DNxix7EN9nSh4doFbWHL09b6q0RtE93LAKZ6heev0I3MGF/K13QXWJRVxE7skJ/1k8kLQRS7ppzumR8/+438QismQHaQkwFZFwnwox4C+YSfQaXUKlIEgR1z7Ifgivjv02TGMl5V/UjATTZg4pdibuLEfW30bc57Cqag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5wcnFtGWDICQfOh4AcjGdPqU6HfaEKzHN1zV8Hu0Oc=;
 b=UV4Mb9vJPg7ySpf+8CBVFPq8uo+LpAoJrzx8GunUE3YjwflDQYAqyOXqua0QE+T0DNOB/yamVXyhS4WfAdA6b8WdGiYMQuPy4Etvva9Gzw60UO819WTNkDXF1OVciIEGlAe7sALW7yr/bxOKWNbUsuTdiZiSNwrUgMJEmRgVsyjHiZOw0qV3glyzYVNDxlzt6RQGi0i4nbfMsf9kyoG/D/pdA3UJOt8MMzOTQotwuo3NJvONN5HvCJbT6/A5yMe09Xgq6QN+b04atLabQnWudPv7yfWcuf0cFuPC2exPoYoxcO5SWjwZGFtTG5xosAhpa5EKH/D8q011yYo/e/bkEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5wcnFtGWDICQfOh4AcjGdPqU6HfaEKzHN1zV8Hu0Oc=;
 b=EPbthmumjxirFdyaXkQzTqHX5suDyt2oxATFv5KE8JcDiXcROFDa+7Gw/jfc2zxDFc8DY2ynqYY6MUGD2u/tiKjtHknXL3iXD5orJH+WJTeAcWOe61Eb/S/xNz1DF+lodexE7ISbHYQoZkMVWYu2qubzEWby3ssAu0mDaYtLEbA=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2648.namprd15.prod.outlook.com (2603:10b6:a03:150::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 15:58:12 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 15:58:12 +0000
Subject: Re: [PATCH bpf-next v3 10/14] bpf: Add bitwise atomic instructions
To:     Brendan Jackman <jackmanb@google.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-11-jackmanb@google.com>
 <86a88eba-83a1-93c0-490d-ceba238e3aad@fb.com> <X8oDEsEjU059T7+k@google.com>
 <534a6371-a5ed-2459-999b-90b8a8b773e8@fb.com> <X84R5DttN3WuHDYo@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <881f46d7-b8c1-d718-660b-b4db61b98e29@fb.com>
Date:   Mon, 7 Dec 2020 07:58:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <X84R5DttN3WuHDYo@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ca62]
X-ClientProxiedBy: MWHPR1201CA0015.namprd12.prod.outlook.com
 (2603:10b6:301:4a::25) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::113f] (2620:10d:c090:400::5:ca62) by MWHPR1201CA0015.namprd12.prod.outlook.com (2603:10b6:301:4a::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 15:58:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 362fb036-9ba1-465c-60ac-08d89ac8e659
X-MS-TrafficTypeDiagnostic: BYAPR15MB2648:
X-Microsoft-Antispam-PRVS: <BYAPR15MB26484D3A75796187D2081A16D3CE0@BYAPR15MB2648.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+Q2JAmvf9vRbmt3fHR9CEGFxajJW+lrn0mNAch51oyIs7JbKXe/UdHTE9lCE+yqVauJ6dw8T/Bh0QHJyVMtoIg3i1mrUtHB0dlurHyxPstWqrw9RbXkRmysgLRaFVkhOVp3f30JwXd2o0b/z9TYgZfDS8hVMYknYdimewGLqhlzYWxgz4H7zsmiG6BfP9BCgxPioER2N9/taEjbuTx4/T7RQ2exX49YiIjXSIuyJU5QBHyEqMKRtCiz9jciSyoWLESihedEwXBKiDGog37rJPXABxOiimCtkQwyUcX+PPCtmtba3pJsR6LsyOkJ9PYl7C5IKHpRW0XYaHOt9J5OEcCJGO8jfvagMft0Th3fM41lrGZBCBgIAbmH3Ivp2iFbHgj/pRLA0Zh63VeUJK1vy/gMQBy6Q4Nh3xfZEw4h4o4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(396003)(39860400002)(376002)(52116002)(2616005)(316002)(4326008)(66556008)(31686004)(5660300002)(83380400001)(54906003)(66946007)(6916009)(478600001)(2906002)(66476007)(36756003)(86362001)(53546011)(31696002)(16526019)(6486002)(8676002)(8936002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N0R0UnNnUW5WeXVLb0JxcjJmODFnU1JJNFFLRWpZbVh4NFRtMTY3TDlsUWMr?=
 =?utf-8?B?bFRwZGFFYWJDMEdhcmRFTDNyZmVKb05yeDl1djZjcndoN1o0Q01qbFRZYzQx?=
 =?utf-8?B?ZGlyeHNOWWhGRk4xVjkrSGJFV3RNb3pjcWJLZk43OXhlVVZieFFzcVpUZGdF?=
 =?utf-8?B?M2ZYRDFtZjA1SHE3NDhDemNNRmRaLzVFaGQ5dGtyd0EwRFJyVlZoVmd3NzRB?=
 =?utf-8?B?aFh2V0tYcllwcXRHVEcyUjVFTXdtTCtIN3h3WlorL2ltRERoVUNlWE1BbGZn?=
 =?utf-8?B?M3UxeFZvNUV2WnZrQ01ZdWVLV3hzbDhIWWVjUkhWZkdkbnd6cHUzYUtvZm5O?=
 =?utf-8?B?RENsY1JPNkVGUmYrR202U2VlcXRMNVRSTnNIUXl0VU9mUFFCUTRmTHY5RXI0?=
 =?utf-8?B?K3lidVM0eEZRT3I1TG9Jc1B1emNmUUc0NjVJWlJJNGVBemdQdXdFdHhpaXJk?=
 =?utf-8?B?S2dmdjlHQnA5V1I3ZXRNLzQ0QkpYRy93UDNXWjRMZkFSTnFoYzlpR2xTTjl4?=
 =?utf-8?B?UnJRRFp0MDlPdW1EYWdtcjJKNFkxb1RrL0dtVmh5VS93V05BT0JFbDNjNXRT?=
 =?utf-8?B?S2pWNHVyNVdzM0owRUN4WS9COU9NSmY5c3J3Qmk3dEQxZFFSTEY1M3ljOE4x?=
 =?utf-8?B?Mmttb1pFMFB5QXRYWkVkMXFJcGZwV04yMWFCTXNqYjdoN0Q2SUorUENDZzY3?=
 =?utf-8?B?YXdIcjZ2cnBiVHpuTDFuTmg1c1VQNHpIQzR6blNhWnczN2tVek9HbzBhMjhn?=
 =?utf-8?B?TU8xVmlGRUFBS25YMjZ2OEZNMUtpL3lZWVdoVDNJNHZUc0MvL2JzeXBLVStl?=
 =?utf-8?B?R1VIWnYvMWNSVUVBQ2pMWVBYUU1DV0pnYmhlOTEyeHd4SDdQelpZTndpWU5q?=
 =?utf-8?B?WkpyRGR3c043NkN0bkxOY1ZFVEgvWkoyWHhTQ2x6ckRmVDRCZGs4cWdLeW42?=
 =?utf-8?B?Z1l6MUJaYkhMWlkzaHcxVWp1VXRRV3duelp6WitaRm5rUHlsN1ppODhGYnZ3?=
 =?utf-8?B?dkRVYlZpVDE1cFZIZFZyQkJQZU13bmhUTU13QTFoQzlhMnMwYTFkaWRGTFor?=
 =?utf-8?B?aWg5cS9OaUl1aFVMNGRqeGJNS3FSSExTT2R5V1N3SGJxL0JtUkFWWGsyK0pC?=
 =?utf-8?B?VGJzU2ppZzV5dE1tSCtMcEZKYzYyakpTU3pqUi9MUktieklrMHp3ZmhSaGRC?=
 =?utf-8?B?OVNZdllmakozQVpVVWF6UVhTdHI5SUZRZmFNeWg0eEsyNFBsOGF4RmlSUCta?=
 =?utf-8?B?cW40UG1EQUhSWlNIVXoxb0RhWDE2Rjdkaks5WHg2TWo2TDFRZXBMQ1VtZjlu?=
 =?utf-8?B?K3FQUktFc01LeUFlYnM2M2ZGR3VhNHZMVVJFWWQyZmFrQUJSMXNZQVM3N2lv?=
 =?utf-8?B?eUtKUElrUGVweVE9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 15:58:12.0799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 362fb036-9ba1-465c-60ac-08d89ac8e659
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKgR+qCMBCRMXLOLNefgBLVZhtQZRL0nnJ636g4jO++5hsv7iqOq3EHJvt14Gb/y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2648
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_11:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/7/20 3:28 AM, Brendan Jackman wrote:
> On Fri, Dec 04, 2020 at 07:21:22AM -0800, Yonghong Song wrote:
>>
>>
>> On 12/4/20 1:36 AM, Brendan Jackman wrote:
>>> On Thu, Dec 03, 2020 at 10:42:19PM -0800, Yonghong Song wrote:
>>>>
>>>>
>>>> On 12/3/20 8:02 AM, Brendan Jackman wrote:
>>>>> This adds instructions for
>>>>>
>>>>> atomic[64]_[fetch_]and
>>>>> atomic[64]_[fetch_]or
>>>>> atomic[64]_[fetch_]xor
>>>>>
>>>>> All these operations are isomorphic enough to implement with the same
>>>>> verifier, interpreter, and x86 JIT code, hence being a single commit.
>>>>>
>>>>> The main interesting thing here is that x86 doesn't directly support
>>>>> the fetch_ version these operations, so we need to generate a CMPXCHG
>>>>> loop in the JIT. This requires the use of two temporary registers,
>>>>> IIUC it's safe to use BPF_REG_AX and x86's AUX_REG for this purpose.
>>>>>
>>>>> Change-Id: I340b10cecebea8cb8a52e3606010cde547a10ed4
>>>>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>>>>> ---
>>>>>     arch/x86/net/bpf_jit_comp.c  | 50 +++++++++++++++++++++++++++++-
>>>>>     include/linux/filter.h       | 60 ++++++++++++++++++++++++++++++++++++
>>>>>     kernel/bpf/core.c            |  5 ++-
>>>>>     kernel/bpf/disasm.c          | 21 ++++++++++---
>>>>>     kernel/bpf/verifier.c        |  6 ++++
>>>>>     tools/include/linux/filter.h | 60 ++++++++++++++++++++++++++++++++++++
>>>>>     6 files changed, 196 insertions(+), 6 deletions(-)
>>>>>
>>> [...]
>>>>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>>>>> index 6186280715ed..698f82897b0d 100644
>>>>> --- a/include/linux/filter.h
>>>>> +++ b/include/linux/filter.h
>>>>> @@ -280,6 +280,66 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
>>> [...]
>>>>> +#define BPF_ATOMIC_FETCH_XOR(SIZE, DST, SRC, OFF)		\
>>>>> +	((struct bpf_insn) {					\
>>>>> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
>>>>> +		.dst_reg = DST,					\
>>>>> +		.src_reg = SRC,					\
>>>>> +		.off   = OFF,					\
>>>>> +		.imm   = BPF_XOR | BPF_FETCH })
>>>>> +
>>>>>     /* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
>>>>
>>>> Looks like BPF_ATOMIC_XOR/OR/AND/... all similar to each other.
>>>> The same is for BPF_ATOMIC_FETCH_XOR/OR/AND/...
>>>>
>>>> I am wondering whether it makes sence to have to
>>>> BPF_ATOMIC_BOP(BOP, SIZE, DST, SRC, OFF) and
>>>> BPF_ATOMIC_FETCH_BOP(BOP, SIZE, DST, SRC, OFF)
>>>> can have less number of macros?
>>>
>>> Hmm yeah I think that's probably a good idea, it would be consistent
>>> with the macros for non-atomic ALU ops.
>>>
>>> I don't think 'BOP' would be very clear though, 'ALU' might be more
>>> obvious.
>>
>> BPF_ATOMIC_ALU and BPF_ATOMIC_FETCH_ALU indeed better.
> 
> On second thoughts I think it feels right (i.e. it would be roughly
> consistent with the level of abstraction of the rest of this macro API)
> to go further and just have two macros BPF_ATOMIC64 and BPF_ATOMIC32:
> 
> 	/*
> 	 * Atomic ALU ops:
> 	 *
> 	 *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
> 	 *   BPF_AND                  *(uint *) (dst_reg + off16) &= src_reg
> 	 *   BPF_OR                   *(uint *) (dst_reg + off16) |= src_reg
> 	 *   BPF_XOR                  *(uint *) (dst_reg + off16) ^= src_reg

"uint *" => "size_type *"?
and give an explanation that "size_type" is either "u32" or "u64"?

> 	 *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
> 	 *   BPF_AND | BPF_FETCH      src_reg = atomic_fetch_and(dst_reg + off16, src_reg);
> 	 *   BPF_OR | BPF_FETCH       src_reg = atomic_fetch_or(dst_reg + off16, src_reg);
> 	 *   BPF_XOR | BPF_FETCH      src_reg = atomic_fetch_xor(dst_reg + off16, src_reg);
> 	 *   BPF_XCHG                 src_reg = atomic_xchg(dst_reg + off16, src_reg)
> 	 *   BPF_CMPXCHG              r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg)
> 	 */
> 
> 	#define BPF_ATOMIC64(OP, DST, SRC, OFF)                         \
> 		((struct bpf_insn) {                                    \
> 			.code  = BPF_STX | BPF_DW | BPF_ATOMIC,         \
> 			.dst_reg = DST,                                 \
> 			.src_reg = SRC,                                 \
> 			.off   = OFF,                                   \
> 			.imm   = OP })
> 
> 	#define BPF_ATOMIC32(OP, DST, SRC, OFF)                         \
> 		((struct bpf_insn) {                                    \
> 			.code  = BPF_STX | BPF_W | BPF_ATOMIC,         \
> 			.dst_reg = DST,                                 \
> 			.src_reg = SRC,                                 \
> 			.off   = OFF,                                   \
> 			.imm   = OP })

You could have
   BPF_ATOMIC(OP, SIZE, DST, SRC, OFF)
where SIZE is BPF_DW or BPF_W.

> 
> The downside compared to what's currently in the patchset is that the
> user can write e.g. BPF_ATOMIC64(BPF_SUB, BPF_REG_1, BPF_REG_2, 0) and
> it will compile. On the other hand they'll get a pretty clear
> "BPF_ATOMIC uses invalid atomic opcode 10" when they try to load the
> prog, and the valid atomic ops are clearly listed in Documentation as
> well as the comments here.

This should be fine. As you mentioned, documentation has mentioned
what is supported and what is not...
