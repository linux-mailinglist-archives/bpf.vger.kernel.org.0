Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0413159AF
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 23:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhBIWtc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 17:49:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56336 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234566AbhBIWdd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 17:33:33 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119MNOGo027161;
        Tue, 9 Feb 2021 14:32:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=sQR14Uu675ieYp8xY/PMLOTSmD8auuC8aUx0zKQ+iw8=;
 b=Ei4IGNdd2ONsvutyaKbFr33czLx6TV0QZlUr47RA6ziDJVIBCTgOZ4qyRahJkOph1ZPo
 j4eEbaftVhP3ZDmsSUvrO5KclRtfpjr+GurzYsDIwhDJBpO8DNOH/KKukYF6zKpvc7De
 gg+XjO60rGD4MvXQgI3q0Ou/bn7vFAV8tCQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36jy96u98p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 14:32:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 14:32:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hflffJ/jt8zzKKdcqQCBeAFPxD4VrxNVxAqVhVDXtSXew/xH329zGFzYj6Rf3LISXEmvJrnyllD9HJJlOe+skDKZ2xoTMJHTncpAAhhQ5b7KutVoJNtws0m3pka3MZK6bsU1VW+KnEn8YfYR8SzqRbGsSG7plhZiwjXduriTweDthW0+clEddFuFBytKk86YIU5qsct0bRhfcUgDqj4QHhqJNGtuQXicnrNcU4vCYC1TOIEj7g4CBl4uTHLCOVQc+ZRKCgvri2J4F72HQvBWOqiwqXe4wBDNSXTDdbDoncsQjhBgzcqkPvxvB6evguOaTXwqqe/lXjTfRejC51aQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQR14Uu675ieYp8xY/PMLOTSmD8auuC8aUx0zKQ+iw8=;
 b=byIiM7y1/KLw/V8exLZGJbQ99Lomu6YohimdMk+jurQFA+aolwVdPjWUwMZY7cLVP7+0UTg0cW8MAWeilLYr4AB4Qj7HCiiSoBQlAMsgnEp3PpvAETQJdkTVu7EC4iHa71zwH3drCYun7eUryKexTDvBhgpm4yWVcAt2OCmBiRT5dKPZ074VsKWWcOLNMWCX0Ib69giDJSSYLI8RfxcFmkCt/WORH5Ej//BpfSlDnEljKOIMJG/AOMH7Sab5KnLntvnt4COm11Xfc51AlHoceNl+0jmHCG/VKMGMRghouGI58TqFBc1blqEShQ93qFxDl/GqTWagFRTeb80+ovkhiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQR14Uu675ieYp8xY/PMLOTSmD8auuC8aUx0zKQ+iw8=;
 b=Xqdo3rkw+4td1aeYfLqQDkGVB8WgG0TWrzzcmFCwlwXYkq4xti4AartFicFSu0qpOs53h3c50mRMA0FkcYJ6FDLaw6/C+G/95EBB0X8QFqGDeovClALhp1gxWZkMt0Ml3JKEkGcLyemWmLi3nv6Z4bCV8mWwQP/OHq9oNe4o4B0=
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN6PR15MB1474.namprd15.prod.outlook.com (2603:10b6:404:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 22:32:02 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd%6]) with mapi id 15.20.3763.019; Tue, 9 Feb 2021
 22:32:01 +0000
Subject: Re: [PATCH v3 bpf-next 7/8] bpf: Allows per-cpu maps and map-in-map
 in sleepable programs
To:     KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
 <20210209194856.24269-8-alexei.starovoitov@gmail.com>
 <CACYkzJ66POr0opxbrvRTTTc-T4CsyirHpDPvWRaM3R1bmNvm8w@mail.gmail.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <9a45e856-c464-c6e0-6c26-baf364b6bbe8@fb.com>
Date:   Tue, 9 Feb 2021 14:31:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <CACYkzJ66POr0opxbrvRTTTc-T4CsyirHpDPvWRaM3R1bmNvm8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:c01f]
X-ClientProxiedBy: CO2PR04CA0168.namprd04.prod.outlook.com
 (2603:10b6:104:4::22) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103:c99:e09d:8a8f:94f0] (2620:10d:c090:400::5:c01f) by CO2PR04CA0168.namprd04.prod.outlook.com (2603:10b6:104:4::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Tue, 9 Feb 2021 22:32:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55ec49bc-ab20-44f7-bede-08d8cd4a84fb
X-MS-TrafficTypeDiagnostic: BN6PR15MB1474:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR15MB14740C5B095B944C84E631A0D78E9@BN6PR15MB1474.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oBHj6YXVxiuDZ+aCuUnbbMzFXteh8H8Wxh7Uai/1f+DpQQeS78Ts/2cZ5gYjwwc7qoLVlKQH1qc6Q8OhZAPOOU0DEzs3Z9zAY6zNOOmx423gmzcnAQWj16afPh0gmcTZwYHsvICsug7/3B3eH/ey6YY7j5w0nnkS3SGkNNXCRtNlNZh9LD+ZFSGRQDrrjUfDrLa+ATvQ8uBrx7B4XSpsFVY3ZQpKA+mHJDJnx3TpeZfRJIgA9CZ7iccWRnnNvCWBR65cXULY/OCzENuERPskYNHvOLAoh7wT5oqztJf/7SjB/WQu6Q5Y6ft7o6BULsKce0Ws3TE/VCNFRWj9nyXh+P0zEYzjVbGJEuw0YIkhUIvnkchzENVWXQNSwvtkbG5jJe0QSgnwnW8+BUqQhrXjXnorNEy9/78dbXymeP+cy4FUwrLzAMue/paV4Hrdw28Q9cDS0v8QQao877dLcEsH8KhjmXrFNjgvEt3BJqDZurG+gJM3jYJPkei6kaJW1dt+rz/7tCa9i9clW9hy4fRwi6s9U+DQa6uEFGxxmqLny/i1adZP5Sv8VkI8wRnFPh44tVhnvJ+xNBurIEpE3QgpZtLz0wuKsvw4yELf6nmsyf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(346002)(136003)(396003)(316002)(66476007)(8936002)(6666004)(86362001)(54906003)(66556008)(66946007)(31686004)(110136005)(2906002)(52116002)(8676002)(5660300002)(36756003)(478600001)(2616005)(6486002)(53546011)(4326008)(186003)(16526019)(31696002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ODltbkRzZkVsVkdjYUc1QlVxanYrWHZ4QVNnNTQ0amRTNXVzOG9WUHZkT1V5?=
 =?utf-8?B?ZG5tREJqSFVFejlEUHQwbUJONU43eTRtaXZ6TXZWV2drek9UTnlvRFVHR2hG?=
 =?utf-8?B?SXltWFF6dklGaHdhWU5Jc05VVzVsZ0hRcFBtTkhiV2pJVXQ2WGQ4eTZVamxI?=
 =?utf-8?B?L0VSNXhlejZmNTFxNTY4Y05DaEFwYmswQlpxOHN5QzliNWNPZXk0MGZBRHY3?=
 =?utf-8?B?MFRZb2ZhL3hoUGtaYnd2VlBSVThMU2tlN1JVazhzdFhTV2VjdG0xTFl3RzVq?=
 =?utf-8?B?ejI4TUtqcnhBbit6eGV2R2M0QU1pVkhWdWl0a2I1M0s1djk2bFlZN1BKay9N?=
 =?utf-8?B?Y09HNFhoVGdYdVNSbEE0ekcyYUo5ZzFNT25RdDdHOE93bTkwSEQ2Qkw2azAr?=
 =?utf-8?B?TFFMR2VxYW9zSnRRQWpIL2FDSkdxUWs0dnl6bmxOYzdtV29aVHVFcFl1MHN5?=
 =?utf-8?B?M3YvdVZOQmJ3b3RaOEplcWQvWU5iTUlSQ3dkR216K2dZUW5PM1RzSGF6M2tO?=
 =?utf-8?B?YmxUbVFNNyt5ODZuWXZoU2U3bWp2WVY4MkoyeGN2K1dtNXBzUE9CY1BpZGJP?=
 =?utf-8?B?V2hMcEcwUVY4NTRySEFKM0t6dzUzVUQydGJ5dnFFVWZkeXlZbHFBM0M3eGlC?=
 =?utf-8?B?WjdydEZwNkVTSGl6QW5ZOVBUeVdCYzVqYTJVa2lMcWNCR2VFYU1hYnB4VEJF?=
 =?utf-8?B?a1dZQlU2UVB0ZXFsTGUzRFJLZ29XU3hVSWQyNWNLWEVnbFdqQWZBRUJxcm9Z?=
 =?utf-8?B?ajgyQUwvNVdQbyt4c2FFSitLUmxGRm5mdkFXWFdGc0hkK05yZVN0cnU5UjBR?=
 =?utf-8?B?d3BJNzJoQURVRjZDejBEdXgrZGpjbjAwczR2eUdNSjZRTVVCUDAwTXJwMzlN?=
 =?utf-8?B?eFZldXBrV1RtbTJja09sNTRNdlZqS1laVys1eVBwd0RKbVNHVlZ2ZFJHV2xi?=
 =?utf-8?B?WlRpUXlSZVRvbndCOFM4SjJlZnVTSWFDWWUzdVJSZmNLTXBVWllUb3RDQmhn?=
 =?utf-8?B?ZmpFV01TYjdyeGtSd0tUbm9PcmRzRnV3bUNkb0FUNlZjL2RSUkx1bG5YMi9r?=
 =?utf-8?B?YXBwckdOQ3hMQjBvWTB4aVYrVGdMOURhYWdwcXhUQmlEeGxnb2RDSWpnQUN6?=
 =?utf-8?B?QUgvanFReDFCNEoyZDJ5bGsyWTNRWlBkaitQVFVYL09xdklJTnY4YmxjMkFo?=
 =?utf-8?B?NUVzblpRZmIvQTF0a3Z2UW84ZkR0WHNVdE40cTk2SlZXUlpTOGszOEZhQmdr?=
 =?utf-8?B?ZGJqQTZnNGRwaXhDMXdsV3l4cSs0d2lyRk9PZ1AwTkczWEsybWNvazF5T1d3?=
 =?utf-8?B?dWhTcHhOcGNUOFdkWlhvQmUxZFoyMVdRNFRpMHJ3R1FWR0ovV09HdTVaWUQy?=
 =?utf-8?B?R0E0WENoNFNSKzJJZW10aE9wMHR6b1BYYXVIc1BPZU90OUkyMThxMmc4d3h6?=
 =?utf-8?B?WTlMUStNbWtSTy80Uk0vei9iSW4zVDBaaTRFZzM3QVBtSEFnOGt6bW5McnBL?=
 =?utf-8?B?WHlPVU1TOStHSW52REVDc0NqVDZXWE9TREZPbjg0Y0V1YWpvWXRHRUV4dzdo?=
 =?utf-8?B?Zlg2aWV3Q3ZlQlpjTkw3NW1wRXhuWWRXdGh5VWpJelNMSzEyeXFwUVhLOHV4?=
 =?utf-8?B?RnpLK25jYkNIM1VZdzd3UGcxSlhWNDJ2RTV6YkVHWlhLZFRCSkVXcFR4eUx1?=
 =?utf-8?B?ckg1NTAyMW85aDhkVjB0QjZHT09FKzdIVUhmZysyeVIrOTRjVHJBeis3czRv?=
 =?utf-8?B?Nkl1L1FENXhvT2RJSXUxN0M2YWZPRnBteW9vakxiaGRGVXF6WTE3by9WVEZn?=
 =?utf-8?Q?VmAeHTMEAE7D3Hi83gFdkJuPSCX6JsiglYl84=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ec49bc-ab20-44f7-bede-08d8cd4a84fb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 22:32:01.7748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kpywQN4Qkle9Mng5GEJvWi+p37v5frKG0U8no4bulp/OYJErlCoIkM50GUuzLmP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1474
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/9/21 1:12 PM, KP Singh wrote:
> On Tue, Feb 9, 2021 at 9:57 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> From: Alexei Starovoitov <ast@kernel.org>
>>
>> Since sleepable programs are now executing under migrate_disable
>> the per-cpu maps are safe to use.
>> The map-in-map were ok to use in sleepable from the time sleepable
>> progs were introduced.
>>
>> Note that non-preallocated maps are still not safe, since there is
>> no rcu_read_lock yet in sleepable programs and dynamically allocated
>> map elements are relying on rcu protection. The sleepable programs
>> have rcu_read_lock_trace instead. That limitation will be addresses
>> in the future.
>>
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Acked-by: KP Singh <kpsingh@kernel.org>
>
> Thanks! I actually tested out some of our logic which uses per-cpu maps by
> switching the programs to their sleepable counterparts

You mean after applying this set, right?
migrate_disable is the key.
It will be difficult to backport to your kernels though.
The bpf change to enable per-cpu is easy, but backporting
sched support is a different game.

