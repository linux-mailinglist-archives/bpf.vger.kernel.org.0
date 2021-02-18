Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1160231EEE3
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 19:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhBRSsw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 13:48:52 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60200 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234349AbhBRRb7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 12:31:59 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11IHF4QR006572;
        Thu, 18 Feb 2021 09:29:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=8aP8zPrN2c3nl+SjleBosEcLsMU0Mtr4FTfkP59ndYY=;
 b=iJVY+Kqos1GVmJ2yLMbGL8lF/zVFu9OApRhT+yuL6vNUst146k7VV6MMOpdTJD11aOPT
 s40AsY0l6Gv0c13TawaNXxR//OaUSqcN5pO298l0N+vIi4nsaZkd38cM+2XUdor8vi9i
 YWFjEs9gW+KI0sgUxm1dVYBRtrth2oxZRn4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36s10th545-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Feb 2021 09:29:53 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Feb 2021 09:29:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCvVU2NEwPn6gfTJeDaZXiBW1eGjqmuC31NtQUdwPpgktzIr087fc0yvkoP/vo7kLRFzIYONWx8gF7xzkXI5022WdFkJ3LDDeWwwsxsuNa0taf4J1aoxnoaEboGVeCzhv9W9RiC9bhxHordo0Wf9WM0KpJQqyhxA5WbaJX8TMhh+LOit3mDhi6bXE1dcyP2Kcfbg56DiNztrIwV3uh8i4ADR5apTsBK3xlhwneg4+/g1V79ax8VBKbvrmdOm170VZejM72pr5C/h+bfndDJHweBl3aIinZvrs/c7IUBeOvAMYf35yKp4ZuRQap6jS1LUyRDqTHYOa2ismv5WgOxDLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aP8zPrN2c3nl+SjleBosEcLsMU0Mtr4FTfkP59ndYY=;
 b=eY2Iu3j8yXTM1fMx47NSolPUVQ4IakOABgPAdkci0dFEMjPNTpRmQYMEquXh9v4Ac/S/OtZ/TmyJey6yxEdU2eHjZ7t4ui/Bs0J0wTRc9WdVQc2oszeBVbZp5YuzTDZGM3HFDS6JCY4nW0TThPtCgBYsZTvgIogxWbwFX08tLT1KgUH7+HKvp7vJv+74yll+Vgxn47qCzZ8k5mcD6VXzFC/LImHLdl2HPN8fdMWIxqR+7sW+1+FDhWEvzOvaWV5Rt6qaP4/t54wN0euSzxXh1YG3hCTxvsslzw+zYnCawuwU71IMGN3KuAKX/mVP6vtPER4XAeNcDq0w0/HwU/GRoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2887.namprd15.prod.outlook.com (2603:10b6:a03:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 18 Feb
 2021 17:29:51 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 17:29:51 +0000
Subject: Re: [PATCH bpf-next 2/6] libbpf: Add BTF_KIND_FLOAT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210216011216.3168-1-iii@linux.ibm.com>
 <20210216011216.3168-3-iii@linux.ibm.com>
 <a9e9ed02-8791-28b1-60a8-44ea46525d17@fb.com>
 <4d581ca7743982cb4a1e5baaef2165918f4a2535.camel@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d88d1796-d70c-38f8-54c8-fb08e6c54380@fb.com>
Date:   Thu, 18 Feb 2021 09:29:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <4d581ca7743982cb4a1e5baaef2165918f4a2535.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:5a6d]
X-ClientProxiedBy: MW4PR04CA0251.namprd04.prod.outlook.com
 (2603:10b6:303:88::16) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1506] (2620:10d:c090:400::5:5a6d) by MW4PR04CA0251.namprd04.prod.outlook.com (2603:10b6:303:88::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28 via Frontend Transport; Thu, 18 Feb 2021 17:29:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad3dea7e-1307-4767-3b56-08d8d432cc60
X-MS-TrafficTypeDiagnostic: BYAPR15MB2887:
X-Microsoft-Antispam-PRVS: <BYAPR15MB28875803752D09B088C0CC16D3859@BYAPR15MB2887.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/Lex5/LweVgV54ltIDS9z311DzgDSMmwAlbhupvIQssYv3nuRTgoFgFykZsji2b1nFh4BKSbn7SgvIB1SdjILYTu9UtopjU+RtZ+MmIKPp2wT2RBW+H7Ojpa1Ik87Ma+Ok4tQurs0qQYvRq6xQDqSl5fEDenf3OziWJrAPmwuFRXiFGczmYnr7dKKlZJUn1XWiqjDpc58LlRQZ9+HOAU0YyX/yGIW8ipWupYJD1/TDNRNBGqtdjANJw2IVnhhf4K0r3dimjicpvuKq45pmCDSwyaSdoPxuHMXoZsasx2lChfXuUrbGmROhk2s/MST0/ZFE0cVhbGiE300Repcp51TKQtO++7DyDdDlfMFjma9j0+heRPOqig0StwJKKzenBln7jMxlqB4miIldO0WLt+uQTa3cEMu2+B7o0FtxxvptXHWtOuJ4Za+9sHaXl2vCgei2PpqjwMjCLrRNuGhm804+dYkJjBCJzhEpw2+GRcr/vOolc3IuClWGfNugEYVvZ3n6WvlWqSYveEOUOwToSqt9k9TOvXUxmwFeSZ2SdGrurQFEku1dFH7fyaoxGQvbur0pm832czyD8rsyhJ7oeQZdepE9uTrc3qLWafoye95Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(376002)(396003)(39860400002)(2616005)(110136005)(8936002)(53546011)(8676002)(31686004)(316002)(16526019)(83380400001)(86362001)(478600001)(4326008)(54906003)(186003)(2906002)(5660300002)(31696002)(6486002)(6666004)(36756003)(66946007)(66476007)(66556008)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y0x0NmxCOFdmR1lwSmRhc1RBVVYvMjRDQ0o0eEw2QlNKS0ZKVnhPVVB0c1J5?=
 =?utf-8?B?UWpuWWkxeHhIeUF0NktCMm9mYkdHWk1XTnhXNVlRRHNINW1ncW9xdVpLcXV3?=
 =?utf-8?B?UjNISTJES2Q5MnpjK2p4YTA2VjAvUXoyaWQwT3JkQTdJbDJnMisyZkdnOXFl?=
 =?utf-8?B?LzM1MzhSTk1Wb2tRL0NvV1k5VStYRUxYbFVCaUFIUnBpTDJjSFJwY0gvTHJF?=
 =?utf-8?B?czAxOHJQeDV1UWxtK0lQd2I1aW5wQXE2VTRuODYzejBZeUdoR0srNFZVQ3cx?=
 =?utf-8?B?VmFQc3VVZCtYeXphRU4vNHNKeW9XMUdBamFYRU91NlVWV29XNE91UnU4Z3l6?=
 =?utf-8?B?Q25YWW5jSzVzTTA1QTVNa1I1TVREM2xuWU9hbEVaYzNmNTJtMlpjNnc4d0VF?=
 =?utf-8?B?QUlBZWVUV1M5a3grcHNwd2oydThHZEZVZGpiRklSM21icjlBOHQ0TitQRDYx?=
 =?utf-8?B?bjk5TlJPeG1yNTNGN2dyNk84NXVIVjZDZjJ6RTJtc3pqMlMwRWU4azlhT2Mx?=
 =?utf-8?B?TVhMR1BBeFo2d2hWeld3ZVkyQW41cGtwTGZiTmlBNDRIMVVaNmNFakp1Sko1?=
 =?utf-8?B?dDVjc1BtK0hJa2JicXkyRnZNMEJaTUpZWmMzTGliMUNXMkZ6cVhpakxhaTRy?=
 =?utf-8?B?U01ndVpDalJNV2J5dTQ5b1I2M1JaK3ZRbFJYaHo4S1dzQ2FBempnOHpsWTFX?=
 =?utf-8?B?Q0R6UW9keHJZS1Y0emo1ZzBISnRrTWVIc1VrT2Fjcms3SkV4YTk0cjhHcGwv?=
 =?utf-8?B?Y2dhRzhEczUrRUZuZ2VnRjlRcklHYnNuTFdMK1hmRjRVSmRxck4yTU1SQzFx?=
 =?utf-8?B?Um13QnpwZDFLd1lLU1pWYlJvNm1pdHh5QjJES2dTS3VPY1FRTGMvQ0cvcDky?=
 =?utf-8?B?cHNkWDVCdlBCREoxZ3BBN3NQYWtIdU5JZ0xvOWlwMmJmN1JvUDZyeThIOEVw?=
 =?utf-8?B?VUdmK3lSSlliVkhpcHBzeVRKekQvTFVCeksxd0RQTDJmOGJ5UVJNMGp3dXpy?=
 =?utf-8?B?NUhrRVY0Nm5SVmFIUXNEQmd4aXcvRDRaem9pODAxVDhuaitjSTNnN3UwbnBB?=
 =?utf-8?B?enVBY0cxVVhLbGcvZWgvR3VDdkd0eklGcW5wZzk4eE1yUnhaUTBNaUQvbG9S?=
 =?utf-8?B?TXMzOWhjT04xREFXcHRFOUQ5Y3RVNjBpTVBKMHJzQlhEOTF0SFRxWFZlMTRr?=
 =?utf-8?B?VXpRb0x0MUl1bGFJdUY2OXVZb3cyMzMrbnhmNWFLQ0kvRjc1ek9weXJ3TTkx?=
 =?utf-8?B?TTk2Y3d3d3UySUxEWHM5L1Z1SGw1RkJqdHFMWlRibHArQlhhV3UzUG9LZWFU?=
 =?utf-8?B?cGJSb2YxSUZYMi9nK1N2emtPRjU1alh5ZG13SUtJeGdPL3RWam9yVFdINFdN?=
 =?utf-8?B?b3J3OWcvZTRPYW5mRDBrUnpOOHgwR01SMVE0eTUwbWdsdE5VWUdudmh3VVd1?=
 =?utf-8?B?NngyTlJhN2lCcndDN25OQ3NWWVFYWFZMd3ExY0grVWtDRnF6aVhZakNpbDE0?=
 =?utf-8?B?UDBvYmJsL1JkekhUSm1rYU5FUCtxM21HSzNEVjdCRHVBQWZzODdjb1BBbG54?=
 =?utf-8?B?TXpqazhIZUROZGd4M0cxNVFwMWpoTXJxWTNFdHdiMHFwVG1jNStnSjRGeWRn?=
 =?utf-8?B?YW5raUNLdlg5NVVhR1NCNDZNZm53L2RPN3hsc2crdG5za1pWRm56ZXpzZER6?=
 =?utf-8?B?T2JhQVVqcitIZUFmZEJwMW5mWlRnUDBvUzZReFUvK1pKQkZib2kzQjdRb0Nq?=
 =?utf-8?B?TTJCNmkwOGM3RDZDTFBFbFJhN1VwVnlEMm9Ec0pEYWtmSnJ1S2hJeVVPaEp0?=
 =?utf-8?B?Tkswa1ByZ0FUUzc1cnZ3UT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3dea7e-1307-4767-3b56-08d8d432cc60
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 17:29:51.7735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydCSR/DZTfphOP/jHYjwG/sO4vpkq8WQIlYyEIAUwDR9vZ/4DbUNIXOczY9IIOZb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2887
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_09:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180145
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/18/21 5:34 AM, Ilya Leoshkevich wrote:
> On Wed, 2021-02-17 at 23:16 -0800, Yonghong Song wrote:
>> On 2/15/21 5:12 PM, Ilya Leoshkevich wrote:
>>> The logic follows that of BTF_KIND_INT most of the time.
>>> Sanitization
>>> replaces BTF_KIND_FLOATs with equally-sized BTF_KIND_INTs on older
>>> kernels.
>>>
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>    tools/lib/bpf/btf.c             | 44
>>> +++++++++++++++++++++++++++++++++
>>>    tools/lib/bpf/btf.h             |  8 ++++++
>>>    tools/lib/bpf/btf_dump.c        |  4 +++
>>>    tools/lib/bpf/libbpf.c          | 29 +++++++++++++++++++++-
>>>    tools/lib/bpf/libbpf.map        |  5 ++++
>>>    tools/lib/bpf/libbpf_internal.h |  2 ++
>>>    6 files changed, 91 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>>> index d9c10830d749..07a30e98c3de 100644
>>> --- a/tools/lib/bpf/btf.c
>>> +++ b/tools/lib/bpf/btf.c
> 
> [...]
> 
>>> @@ -2445,6 +2450,9 @@ static void bpf_object__sanitize_btf(struct
>>> bpf_object *obj, struct btf *btf)
>>>                  } else if (!has_func_global && btf_is_func(t)) {
>>>                          /* replace BTF_FUNC_GLOBAL with
>>> BTF_FUNC_STATIC */
>>>                          t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0,
>>> 0);
>>> +               } else if (!has_float && btf_is_float(t)) {
>>> +                       /* replace FLOAT with INT */
>>> +                       t->info = BTF_INFO_ENC(BTF_KIND_FLOAT, 0,
>>> 0);
>>
>> You can replace float with a "pointer to void" type.
> 
> Wouldn't this cause problems with 32-bit floats on 64-bit machines?

Oh, yes. You are right. I am just thinking of standalone float type, but
obviously it could be struct/union member which makes it very important
to keep the sanatized type having the same size.

So replacing float with "point to void" won't work as you suggested.
Looks like INT is the best candidate to replace, another is CHAR array.
They do not match total size though. Maybe one of modifier type will
be a good choice. For example, you can replace float with a
BTF_KIND_CONST type and the base type for BTF_KIND_CONST type
is an int type with the same size of float and you have to
create that int type somewhere. In power-of-2 cases, it is possible
this type already exists.

> 
> [...]
> 
