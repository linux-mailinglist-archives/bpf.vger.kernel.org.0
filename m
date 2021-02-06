Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238DC311FB5
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 20:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhBFTd6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 14:33:58 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27736 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229684AbhBFTd5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 6 Feb 2021 14:33:57 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 116JX4js021229;
        Sat, 6 Feb 2021 11:33:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=SdO+GLjo3EdwNuxNDoAdOezsACmp76Wf68nn5kLIXUM=;
 b=GGP6XBy6jrCM7ORkZgST/Zdf23clNv4MkKgdr64u2sweBQ8q1zsY3IdHo/YY/Er5cSFD
 VMAUE0WrfNNcSYcSwjY3oY/7CbB2RkpQdSfu1y7hPLRhNzzcX+WGMcCqQfMlhPEliL3w
 GE0ajw6VzImLmOiuh9mDN6Nn/SE7amTw9IE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36hs3r9a8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Feb 2021 11:33:04 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 6 Feb 2021 11:33:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7kGLHkwFhUbSoWyiCqXyME01PGgrYfxj/TLhMhApkdjiESNh2nGiF0aYFZO8gQJ8A2sRBNHLUycQsG6K9OKtVTajXQjZa+gsJDRkqBueQWsMo1VErdZcuheBRHqmLJ+EIaLwLH+K42hyd8Px71ybxHx6JtIu0A51BswLcurwg3kZT4CeVjk+gc4bLSq9YFAF/juf6JOxnsoqBMYc9DnMBgyu7RNNkuRbHuIhClj8r0ahbhNvdkjSsrf6xT4U84QwC7TIrwf0HSzlf33D+Tz2A2+jOLdMz+MPaDtN0SAlr3Jc+QqqG53GmTHzIRcDmtfqMgySvXGrz1FumMac9OtgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdO+GLjo3EdwNuxNDoAdOezsACmp76Wf68nn5kLIXUM=;
 b=WbzrSbyu1bHrP6KGrh9IJbkdNvfGYaMjmxVFER8EdOeVANGgAZPmNP+8kcZLlcFMgKGBlRLou7skOKD79DylyEx3UftuaQQXUawvP/ecd9N/cXF1KgFCnLdwMkL2I+GB07ZOLl1KZFTMC0xa1gE1981NiX3OrtZlWtyWPqn64yKzVjouxLeAavf0+ElKAqtu6y+GkjThPqd4qUgfNIE1domEx6/woxG9uIpYecgTR742Kd5MDYMw3M8wKThXO5ep6KxnFhq352szwcfbabaxaI+bxS3yNFKVUmk8W1gA45Un5aqREgtbhmpPsM9sJrOlFzlFv6WwqvKqNCGGfEGreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdO+GLjo3EdwNuxNDoAdOezsACmp76Wf68nn5kLIXUM=;
 b=B241SV3B3mo6Xv6O5paL6jxA5/9CLo5YrYxmywq5FO8kvOHVemvK3EgqltqGjujybLU1XbATv6XfqlEwJhI5YgCx310dHR2BeYUpG+0X3gthUf0A0ZKh6OOM/jQ9wNP0PeuNXRe/A0ohzAuBTudOymAeYtqgnSY43vdJZGoe3zo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB4118.namprd15.prod.outlook.com (2603:10b6:a02:bf::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Sat, 6 Feb
 2021 19:33:01 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3805.028; Sat, 6 Feb 2021
 19:33:01 +0000
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     <sedat.dilek@gmail.com>
CC:     Mark Wieelard <mark@klomp.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
References: <20210205192446.GH920417@kernel.org>
 <cb743ab8-9a66-a311-ed18-ecabf0947440@fb.com>
 <CA+icZUUcjJASPN8NVgWNp+2h=WO-PT4Su3-yHZpynNHCrHEb-w@mail.gmail.com>
 <d59c2a53-976c-c304-f208-67110bdd728a@fb.com>
 <CA+icZUVhgnJ9j7dnXxLQi3DcmLrqpZgcAo2wmHJ_OxSQyS6DQg@mail.gmail.com>
 <CA+icZUWFx47jWJsV6tyoS5f18joPLyE8TOeeyVgsk65k9sP2WQ@mail.gmail.com>
 <CA+icZUUj1P_PAj=E8iF=C4m6gYm9zqb+WWbOdoTqemTeGnZbww@mail.gmail.com>
 <CA+icZUWY0zkOb36gxMOuT5-m=vC5_e815gkSEyM45sO+jgcCZg@mail.gmail.com>
 <CA+icZUW+4=WUexA3-qwXSdEY2L4DOhF1pQfw9=Bf2invYF1J2Q@mail.gmail.com>
 <8ff11fa8-46cd-5f20-b988-20e65e122507@fb.com>
 <20210206162419.GC2851@wildebeest.org>
 <3f5a00ef-1c71-d0da-e9fd-c7f707760f5c@fb.com>
 <CA+icZUVfTH=yONintyJ+T8kvTrR4Q0gumJYNUCs6Ybraff5Kpg@mail.gmail.com>
 <64206fbc-656a-5ffd-6e9d-739c8c6f7410@fb.com>
 <CA+icZUUZVYN97wKiR9-LOwhQmxMSxggvm4MS4z9nLCvZOB8FLQ@mail.gmail.com>
 <CA+icZUV=-NmFtF9RQTRnbwBUiaPnroiSwyv-9RxA-3-nrgQ_rQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <89f15151-6843-b260-c8f4-88deefd7d569@fb.com>
Date:   Sat, 6 Feb 2021 11:32:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <CA+icZUV=-NmFtF9RQTRnbwBUiaPnroiSwyv-9RxA-3-nrgQ_rQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:e118]
X-ClientProxiedBy: MWHPR21CA0058.namprd21.prod.outlook.com
 (2603:10b6:300:db::20) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::103e] (2620:10d:c090:400::5:e118) by MWHPR21CA0058.namprd21.prod.outlook.com (2603:10b6:300:db::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.5 via Frontend Transport; Sat, 6 Feb 2021 19:33:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8fc5d6e-ed0d-4c3d-3dac-08d8cad60427
X-MS-TrafficTypeDiagnostic: BYAPR15MB4118:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB41181E849D6F6CF47A5E5396D3B19@BYAPR15MB4118.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UiEFcLQxm/VXUyTNKJGS+AYJ42Qg12W9OX8nVrvk2MaNpqiLPqUF/C7LwPgIHJUdcF3+Wx+dBneAx7KQuPvxZl9pMzMA6Go/sg8bLISclvucWlq7vaMqyS/0aHnWRARWnMiZ7EUvHUmt5y3DS/CX7mpCht6DurVKld1fCcPA4Lml70wyD6hUU5bz+oCq7X5gF9w423m+zGjFTfUU415bRszyARm8P/vSwpAQlwLN57onEG2+Ex37+cIR1Rt6VAZ6tmhsOuSkbnV2kTCZZCtAI++0uAT+zejynHV3mjkWua0T7Mbx9S1eo/DDe6/PIN8TaV3P26jYsNulfKpvqdUHIRfOQ05K0HkX5K7qpBcSk5Z2Mczl8rv9h3a3rCe6KB9FOHddXa7TCIg4vsxhZzZJc+6sDFoY52kbmJuLqXXvDIoPaD2mteBsJBz2QLSvyDOq+Q4g65/R5x4pEq4t/m7H/mtvcbG0ofUjVqr/CRPDu4dSuBix4z8bjsWzib83s2Z1YJ5K63v/nni9VOorKOa124ohhttVGU4/Se+BqZAU9Ygm/SjJSmvdxDyU4LYDtYrc7RS1g6tm1tr7p+agHsVZWXuDjBCYmI1t/bsG3pITLtg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(39860400002)(366004)(66476007)(66946007)(478600001)(6486002)(186003)(66556008)(16526019)(31686004)(31696002)(316002)(7416002)(6666004)(54906003)(8936002)(53546011)(2906002)(6916009)(86362001)(36756003)(4326008)(8676002)(2616005)(5660300002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z21CRmFreDhrd2FkSDVsRUJCMHEzREpsczNTZUgrWTI1K2lpdElyMXhZTHlt?=
 =?utf-8?B?M015RkUrOWdrN0VLaFUwanZhcEgzVkNTdXltajh1UUtMZ1hoRWg3SVVLSlV5?=
 =?utf-8?B?TEFucEF5dHozMVJMR2QvVHVuSllVZkorRm44L2J2SGpNOXgyZ2dZMzI3dWh3?=
 =?utf-8?B?MFZ3Uk1OT1N3bGtvRW1uZ3JFZ0pEMThzRFRBVHlwUFlLaHQ2Qk90UXV6SzVB?=
 =?utf-8?B?R2Ivc1A0NGNaY0c4VGdqN2RmNm45T3l4aXI0Mm4vWWJDQUxVZis4UHpXMVlD?=
 =?utf-8?B?b2U1U0tMVG5pZUg1eTNEVEV0OFRRaGlta3JseXl1c2N4UkFDQmh6Nlk0ZjBs?=
 =?utf-8?B?U1YvMmcwaGhEMjcwWE9xMFYzT2lTK1lmYklJYWVXQkhWOWtRSHdHU3BaYllo?=
 =?utf-8?B?Q3I2WTByNjRPcUhyQmJibnFaTGQ5UngyNkxhOEROQm8xd2FVYkhPOEVuTUZE?=
 =?utf-8?B?OTMwdDlERmJhSUdJL1BtOXVQcmpMMGZTa3N6WmtLSmp0Yy9LbXZGNFJXd2R2?=
 =?utf-8?B?U0dTY2NrTFhCaG9nU1AwOFJ1WEZHZXBvb3dyYTM2aFFScjQyOEJoWndOcDh6?=
 =?utf-8?B?Rkc5SDNubXFZYkFiNU95ZkUwYXZxdkdXZm12dXJpZFZsZmtTRjBNNUE5eGxH?=
 =?utf-8?B?dGpMZFBVSW4rTWFhOUNLNHZvRFMzNWxVWnYvRzBIeG1HczhUS3lCOWZLcWVE?=
 =?utf-8?B?U2U2Z09vMEI5Qkc0OE0rY3BuSDQzRjFMY2FVUnJwclA5Uzc5czZrdFNxVUJk?=
 =?utf-8?B?K2RneW42anFNYk8xVGw1aFhSS2tMcEZlRFo5bllpNm8yeHhXSXNnTHcvUmlh?=
 =?utf-8?B?Qk1Wcm5xWmppb3lRbjgxRE11Y3pIN3BJM1gyVS81VFA1WHp2bmVwUDhsREhN?=
 =?utf-8?B?Vjg0ZU9ZME1CbEJFazJIR09SMExpK1FwbDN2WnpmL2RKUkFPY0RSUm9mVS9N?=
 =?utf-8?B?Y0ppQ3k0QXZkaXl2N2RkbDR5dXhDbnkweGdOR0xSTFZ0ZURXUXViMkZtNmdL?=
 =?utf-8?B?bDJiMCtXd2I2ajNmeWg0c2xkbkxZaUIveUM0ZE9CS0VBc1RobVVtbWtxd2Mr?=
 =?utf-8?B?VlBEa0Q0YkIxQkdGK3FOTFdJTGs5VFlseEpEVFJYa0U2MFhPRE95MU1iV3ZT?=
 =?utf-8?B?a0szVWRzQ2xSZ3RIUnloK00wN3NCT0wxbER4ZEpxZXRZdlVsVjNWNzR1aWZT?=
 =?utf-8?B?UHFhRiszdFhuRGVycUtYSzY1QkIrejlNZ3lvR3lXY1V4cXNhbjNjNmlJbHpT?=
 =?utf-8?B?aUJMcGFML1dVTll1Y29sdTVvMDFCUWs1eEZ2UWlzaUJrK2hBRklzL2E0c2ZO?=
 =?utf-8?B?S0tPN0QyTkVaMCs1eDZtbnAxT3ZwNG03NWdLTnVBRnpaajZBekRueHZUSTNK?=
 =?utf-8?B?MlJNbHVwa3ZSZy82RWQ3U2tTYVJYVmpRV29DRXFNeXhDWmNKcUlDRGxBbUhB?=
 =?utf-8?B?RlJjSkErMTR5elFuVEN3T3g2Z25KdEZySm96aGpPZnNxUTV4aWNFdnB0Zk5J?=
 =?utf-8?B?dzdiWmV2RlRmdzZZdEU0R2hWc3lvQkticmpaTkJWMUFDNTNVRFl1MnRhS3FH?=
 =?utf-8?B?cS8xRVJFLzc1aFo2bWJ3UmR0OUdRNlQrREYxV2tOY0VJb3duNVdNWGlTQXdu?=
 =?utf-8?B?ZHZlT0hFdHdCMzRkTHdtWXkzeHlJdGwyNGNFbWhWWmtuZUZkSldxbVpySE5r?=
 =?utf-8?B?UmFzYktVS3BXWERiYXYxQ0t6c1VDdDVyWUhWSmRGNGlrWDF2cVRYejk3dGNl?=
 =?utf-8?B?N2wyTFJmdUFoVENjd2ZHN2ZCQ0wvdW4wYWljSnJLZHZMYmEzWUQ3eTRiZHlw?=
 =?utf-8?Q?DITzFGTnwkpuMZoLeIVSdj/w1I3h2zFOZMl3w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fc5d6e-ed0d-4c3d-3dac-08d8cad60427
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2021 19:33:01.5956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyxlNpaN5zvPyefuQncQAx0hYR17mpx1RhD8EMSvos/v044tQFL3dOXIQogq9IS4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4118
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-06_07:2021-02-05,2021-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102060140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/6/21 11:28 AM, Sedat Dilek wrote:
> On Sat, Feb 6, 2021 at 8:22 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>
>> On Sat, Feb 6, 2021 at 8:17 PM Yonghong Song <yhs@fb.com> wrote:
>>>
>>>
>>>
>>> On 2/6/21 10:10 AM, Sedat Dilek wrote:
>>>> On Sat, Feb 6, 2021 at 6:53 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2/6/21 8:24 AM, Mark Wieelard wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Sat, Feb 06, 2021 at 12:26:44AM -0800, Yonghong Song wrote:
>>>>>>> With the above vmlinux, the issue appears to be handling
>>>>>>> DW_ATE_signed_1, DW_ATE_unsigned_{1,24,40}.
>>>>>>>
>>>>>>> The following patch should fix the issue:
>>>>>>
>>>>>> That doesn't really make sense to me. Why is the compiler emitting a
>>>>>> DW_TAG_base_type that needs to be interpreted according to the
>>>>>> DW_AT_name attribute?
>>>>>>
>>>>>> If the issue is that the size of the base type cannot be expressed in
>>>>>> bytes then the DWARF spec provides the following option:
>>>>>>
>>>>>>        If the value of an object of the given type does not fully occupy
>>>>>>        the storage described by a byte size attribute, the base type
>>>>>>        entry may also have a DW_AT_bit_size and a DW_AT_data_bit_offset
>>>>>>        attribute, both of whose values are integer constant values (see
>>>>>>        Section 2.19 on page 55). The bit size attribute describes the
>>>>>>        actual size in bits used to represent values of the given
>>>>>>        type. The data bit offset attribute is the offset in bits from the
>>>>>>        beginning of the containing storage to the beginning of the
>>>>>>        value. Bits that are part of the offset are padding.  If this
>>>>>>        attribute is omitted a default data bit offset of zero is assumed.
>>>>>>
>>>>>> Would it be possible to use that encoding of those special types?  If
>>>>>
>>>>> I agree with you. I do not like comparing me as well. Unfortunately,
>>>>> there is no enough information in dwarf to find out actual information.
>>>>> The following is the dwarf dump with vmlinux (Sedat provided) for
>>>>> DW_ATE_unsigned_1.
>>>>>
>>>>> 0x000e97e9:   DW_TAG_base_type
>>>>>                    DW_AT_name      ("DW_ATE_unsigned_1")
>>>>>                    DW_AT_encoding  (DW_ATE_unsigned)
>>>>>                    DW_AT_byte_size (0x00)
>>>>>
>>>>> There is no DW_AT_bit_size and DW_AT_bit_offset for base type.
>>>>> AFAIK, these two attributes typically appear in struct/union members
>>>>> together with DW_AT_byte_size.
>>>>>
>>>>> Maybe compilers (clang in this case) can emit DW_AT_bit_size = 1
>>>>> and DW_AT_bit_offset = 0/7 (depending on big/little endian) and
>>>>> this case, we just test and get DW_AT_bit_size and it should work.
>>>>>
>>>>> But I think BTF does not need this (DW_ATE_unsigned_1) for now.
>>>>> I checked dwarf dump and it is mostly used for some arith operation
>>>>> encoded in dump (in this case, e.g., shift by 1 bit)
>>>>>
>>>>> 0x000015cf:   DW_TAG_base_type
>>>>>                    DW_AT_name      ("DW_ATE_unsigned_1")
>>>>>                    DW_AT_encoding  (DW_ATE_unsigned)
>>>>>                    DW_AT_byte_size (0x00)
>>>>>
>>>>> 0x00010ed9:         DW_TAG_formal_parameter
>>>>>                          DW_AT_location    (DW_OP_lit0, DW_OP_not,
>>>>> DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1", DW_OP_convert
>>>>> (0x000015d4) "DW_ATE_unsigned_8", DW_OP_stack_value)
>>>>>                          DW_AT_abstract_origin     (0x00013984 "branch")
>>>>>
>>>>> Look at clang frontend, only the following types are encoded with
>>>>> unsigned dwarf type.
>>>>>
>>>>>      case BuiltinType::UShort:
>>>>>      case BuiltinType::UInt:
>>>>>      case BuiltinType::UInt128:
>>>>>      case BuiltinType::ULong:
>>>>>      case BuiltinType::WChar_U:
>>>>>      case BuiltinType::ULongLong:
>>>>>        Encoding = llvm::dwarf::DW_ATE_unsigned;
>>>>>        break;
>>>>>
>>>>>
>>>>>> not, can we try to come up with some extension that doesn't require
>>>>>> consumers to match magic names?
>>>>>>
>>>>
>>>> You want me to upload mlx5_core.ko?
>>>
>>> I just sent out a patch. You are cc'ed. I also attached in this email.
>>> Yes, it would be great if you can upload mlx5_core.ko so I can
>>> double check with this DW_ATE_unsigned_160 which is really usual.
>>>
>>
>> Yupp, just built a new pahole :-).
>> Re-building linux-kernel...
>>
>> Will upload mlx5_core.ko - need zstd-ed it before.
>>
> 
> Hmm, I guess you want a mlx5_core.ko with your patch applied-to-pahole-1.20 :-)?

this should work too. I want to check dwarf data. My patch won't impact 
dwarf generation.

> 
>> - Sedat -
>>
>>>>
>>>> When looking with llvm-dwarf for DW_ATE_unsigned_160:
>>>>
>>>> 0x00d65616:   DW_TAG_base_type
>>>>                  DW_AT_name      ("DW_ATE_unsigned_160")
>>>>                  DW_AT_encoding  (DW_ATE_unsigned)
>>>>                  DW_AT_byte_size (0x14)
>>>>
>>>> If you need further information, please let me know.
>>>>
>>>> Thanks.
>>>>
>>>> - Sedat -
>>>>
