Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62AC311F92
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 20:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBFTS0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 14:18:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46556 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhBFTSX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 6 Feb 2021 14:18:23 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 116JF40v010913;
        Sat, 6 Feb 2021 11:17:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 mime-version; s=facebook; bh=CwlOuyb5u+sY4t2eXG7S322Ae45mEeiNgmptC4o7aM8=;
 b=jMSD7ddU+hwjfwMkbXiF/Pwj3x8DWdTsH/IlcE879ErHILB1vyshz2RItoSP2SB+6Xyc
 JH6iAcXHdklECcEfifrmpsYil7YTEUNF5wftoOR8H4k/VygYeeFW8Fc1SmCFUlWHONRt
 8zkJaJdaBxH9bKMQZ9mbBm0EKqAXP8qB91o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36hsqw16ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Feb 2021 11:17:19 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 6 Feb 2021 11:17:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfCoJfGhjmrX4A3P7pdMpHjYceoV87UrpX7QMGAW4SPwYrAIgRzw8GE4DHGIlCG7VFazE+Tr5G3aoGiAmwudiyDXq4cPEunQk5nubNE8fnMVfe6Pa09pt+mi+VkmUB/4cHFdVKVkftYZpqBZayu0oF6rb5FgQmGnXNEEPpGhln5ymUEw4nSTU4xqoP76h+pKf1tCN9FbtQqBmvtOL2tILSUiEaZClDszFf3uW+vS5BHR0j26MdO1gHzRvbjaL9rNx1prjrp1u32CtggjfGS0SVxh+oZ3e8fvRx/Do3apgYKpszyFA1Z4PeP01AeN30+gs6CDSy/hVYT9VxErgsfrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdiqIKXa7crjqDxmfjV4pLapoD+dmW9NwO5yf+OlRME=;
 b=OeuJxno3Xh/+0mYwBcOajeBtL0bybDVDsA2nuZXJVO9PEaIyvvpt291uj4uJgs22xDSNuoQ4xUlXrehGwcVOhsa5F9p42Twv0Kvwygyr6HgnpybuISGAV87b7sWAdv8+oFzeiQnCo/Mpu4CIl2bVfri1tru3HTjmpYAZkMWtUe1EHfLTGyM2b+SbGW6+aXHziK9nH7lW1gxxbx5BYOrV6eVFmsd8rbgj+s80kF9v0dBdk67T0s1DIQ1IqZ1rUzsmZBvxHNJWzR6sLwOaihd/1+Vyf0dye5NeiZ2uv/lrkYSJmF6ZE8OKAdmZKin1xdGENJGe5JxNh6eNBr66tNlL0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdiqIKXa7crjqDxmfjV4pLapoD+dmW9NwO5yf+OlRME=;
 b=gTlKTKvkICnNqesVF7NU/bgoP9H1D0MqDFicWFmiCUdQEy4F/PDhT1KZf6zrsfUEgCLD7WeWYyTVCCuksWmselEC7acZuTGOhoOZyE4LhfxGYAuixzaGimEQAnecwl2MDgrMSoreOk1RrkOUQz+71zGf7DMBxzNjHHfmxbBA7Bw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by SJ0PR15MB4757.namprd15.prod.outlook.com (2603:10b6:a03:37a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Sat, 6 Feb
 2021 19:17:12 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3805.028; Sat, 6 Feb 2021
 19:17:11 +0000
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
From:   Yonghong Song <yhs@fb.com>
Message-ID: <64206fbc-656a-5ffd-6e9d-739c8c6f7410@fb.com>
Date:   Sat, 6 Feb 2021 11:17:07 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <CA+icZUVfTH=yONintyJ+T8kvTrR4Q0gumJYNUCs6Ybraff5Kpg@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------FE8CCA679D6C73CF6F9F35BF"
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:e118]
X-ClientProxiedBy: CO2PR04CA0126.namprd04.prod.outlook.com
 (2603:10b6:104:7::28) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::103e] (2620:10d:c090:400::5:e118) by CO2PR04CA0126.namprd04.prod.outlook.com (2603:10b6:104:7::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Sat, 6 Feb 2021 19:17:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1101ba33-b020-4800-4bf5-08d8cad3ce04
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4757:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR15MB475704E801AF9C47A2A427E7D3B19@SJ0PR15MB4757.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2ux53KjQNTbfdu/I8wiQwpdwmX6eY30ZCJYGoiRSjH/8WxosB6pegkcU3I344L8DR47x52tLSOH3qTjDBZhLI3ZoEM6wXSeimE+mTYk4F17JsSQRVhdOGkwlYXALdhgg/B9cA+Yc/X9jGzS251QhbT4OIdS7yykPgw0/eSR+1n3rTHZjHFnrHjt5bjpsXa1ARNs76f164aYQiUMLwZWttxDmkVyZt8g+dyTVM7IRnTcmiiQTyp08ja7IpamlyAoe21Xc51v2H57V8Xh50CbhX6RqalO6b/terzU6rvDxZsW8Dz2Kvd8cj1KXfS+b8gArPNikY6slOi0AexwksRnGwtYwtVq9nCEr3ZxSX6W4qt74GjJ2IxPtlysENEPWTvkEYfmZyq7YLiCULu4sXcQRAdabVSU1m/0jAikfYhIUsdtRV3NmDg+witPanzCw06wXhmis/DSOCQSCmVFOD74PTz74jasFnMBGsdkXEJ5vvFdXRaZyMjNVQ/YwywAmih90IRdx07QVSxASqbqc6hrfoJP2WAv0h3kVClFqc02C35hFnDD+OEoiuEbNGwHct7uyCAVXjSTFMOJxuJhRla9VTQK+t9+Kv9+RehpOXG/m0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(346002)(39860400002)(54906003)(33964004)(8676002)(52116002)(36756003)(53546011)(6916009)(235185007)(7416002)(66946007)(2906002)(6666004)(16526019)(186003)(2616005)(316002)(8936002)(66476007)(5660300002)(66556008)(478600001)(4326008)(66616009)(86362001)(31686004)(31696002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RVRNdSt1TnlTc0JaK3MxRm8zRDlndTk4WmgvRjZuODdSVVQ1dVRlOTcwaEs3?=
 =?utf-8?B?WEt3OUs3WGxYVlBjSjdsZHJpaFhBQ2RUa3lDVTRLOTVxUThaTit1QUlRUDls?=
 =?utf-8?B?bWo0WjZ2dnprNDQ1dmx0OHNtakFJVUFWYkdaVlpWZVZKQVVwQnhtYTlDbzlk?=
 =?utf-8?B?VXhiRkx0V0lNbXhZYTRFSEV2STZLNm5tYm1BL2gxY0pjbS84Z2FzSVh2Zkxy?=
 =?utf-8?B?QnVFSWJwQjdlYUY0VlRsMVVqZ0x2d0Q1TFdCV0lMcXdtZ1pZa2w3cHR0Y2R6?=
 =?utf-8?B?VytqdUM2a2lESkNVanl1N0dGc3A0VjhDUmx3RG00Mk1lWGhLOXY0c1hZMFpR?=
 =?utf-8?B?YldjRlZRcjFYWVo2VVNzOWhyQjJ3Sm1qYmI2aVhjV05ZUVB6bysySGNmNUk0?=
 =?utf-8?B?MjZQaDhsb2tOZzlqWS9ZQnl2OHgrUWU5NFkzMlYzMGRQTHI5UWVvMWxBOU50?=
 =?utf-8?B?eGM5dDdUUktZZUFJbUxNc1RTREgxcGVNSmgyblg3R2h1aHVMRzN0cVIyTzJJ?=
 =?utf-8?B?c0lyZmZIbFY0S0NSYldQQnhBbFBvRzA3aGlBaW9mVytyU0VrKzMrbjBuNVc2?=
 =?utf-8?B?Yi9KZ3BLU2ZwSlJEeklPenNhMEFndkhzbzM4d21EYWdiazZvVHhLUDluK0pN?=
 =?utf-8?B?V2VTRE8zUUExZENVQmlMYVhaZmNhVG1rMk8vMGZzc2taWVNib1l6L25nOHFn?=
 =?utf-8?B?czVFR28xeHNldkt4RHJzNjZJWDRBOWRTQUsvMWs4SC9sVll4cEYzcWgxbDJL?=
 =?utf-8?B?T0Z6T1NTVDVRbHUvdEFLamZ2Qll0cXVFdzlsMTZlL1ovM3QrM3FRRGYrVTJy?=
 =?utf-8?B?VWdiT0pSWUpPK3RQdWxnNDNENWJOa2pSRy9jcDNYR1I4eHcvNG9kdTYxdWVE?=
 =?utf-8?B?eFFZaENNeWZ6dUFaVHJmRXZrdUd2NFdOOXdlajR3MURQa2NkMi8yVk1rM0Vy?=
 =?utf-8?B?NDAzd2RWOXFKK0FMNXNGSEh3WmRsUSszc2lLVmdLbUdYdDhCd3hnRjVrRmxy?=
 =?utf-8?B?ZTNtaFgxVHF4UnQwYm44TGd1UFRSeVFJcXUwcDlGYlBOSEU3cERLenJmOGlv?=
 =?utf-8?B?ZENzSEJRQlVMb1V3dlJoUVQ1cHVQV3NKYnd1Ym90SVA2RlFyWVp0SjJTblEr?=
 =?utf-8?B?TExKeUxsUk9EU0loN2ZaMS8vYytXdlJFUE5xb0FRYmtvNDBJUjJRUnhQUjIz?=
 =?utf-8?B?SVN5T0VQUTJ3Y0RvaUJZMlk1ejJ6bDdDNDFlTnM0a2RsakFRNTUzOU01dkpF?=
 =?utf-8?B?NVg1SEN3eFd2cU95NHJBR1lySEJOSHl0VkFnNngwU00rVUdUNlA5ZVpDMmJY?=
 =?utf-8?B?d2VXL1RNelRuWittVTRXUVdSSWFublh2TzJrTHJjZjAwME0wVzlQMFBhZmhu?=
 =?utf-8?B?cThic0tKU2pBUC8xZWk2Y0tyVTNSQVRqaGtwZWd6YkxTbDZyUXVsQkJ0NlVQ?=
 =?utf-8?B?eXdpQmxzMVZtZHUrM0hnUWpWaXFralk4RUFUU2VUMmp4Ky9jQk9HamNUdmFG?=
 =?utf-8?B?eGtyenV3SmNDbVQyQmUzVUFaMEVqQnFGU3VRUHlJZEJya1FhbkVTczAwd0xV?=
 =?utf-8?B?TWF4ei9zODRKazRRcWhGQ3RhL1pkK0Juc1JRYVFhMTNpQlVnSWdQckNtVWFO?=
 =?utf-8?B?VnNjRUtuWDJialZXV0s2QWdNSDlucUxJS29jNnk5ZXdsaVh3NTkwTjE2Y21v?=
 =?utf-8?B?SHFhUXFVNHA2WlZGWjQvNTI4L0pTN2EvYzh4QmxVamFFSk1rbzFWZXRrZVhr?=
 =?utf-8?B?S3JJdG9TZlBMdUgxNUpjZUcrUWZGbW4xQWZZN3NxZGpxUmdPQm5ZQXFGa2k3?=
 =?utf-8?Q?GGnpUrBYOedmuKk0ePKVIrdFpm3NJrGzX2fa0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1101ba33-b020-4800-4bf5-08d8cad3ce04
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2021 19:17:11.8881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiBx9DUvFXabBpZNPglvNdTWnAGLWBO46TnPVPG7xeNGyPJEcSWnjrm57lfIH+WL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4757
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-06_07:2021-02-05,2021-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102060137
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--------------FE8CCA679D6C73CF6F9F35BF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/6/21 10:10 AM, Sedat Dilek wrote:
> On Sat, Feb 6, 2021 at 6:53 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 2/6/21 8:24 AM, Mark Wieelard wrote:
>>> Hi,
>>>
>>> On Sat, Feb 06, 2021 at 12:26:44AM -0800, Yonghong Song wrote:
>>>> With the above vmlinux, the issue appears to be handling
>>>> DW_ATE_signed_1, DW_ATE_unsigned_{1,24,40}.
>>>>
>>>> The following patch should fix the issue:
>>>
>>> That doesn't really make sense to me. Why is the compiler emitting a
>>> DW_TAG_base_type that needs to be interpreted according to the
>>> DW_AT_name attribute?
>>>
>>> If the issue is that the size of the base type cannot be expressed in
>>> bytes then the DWARF spec provides the following option:
>>>
>>>       If the value of an object of the given type does not fully occupy
>>>       the storage described by a byte size attribute, the base type
>>>       entry may also have a DW_AT_bit_size and a DW_AT_data_bit_offset
>>>       attribute, both of whose values are integer constant values (see
>>>       Section 2.19 on page 55). The bit size attribute describes the
>>>       actual size in bits used to represent values of the given
>>>       type. The data bit offset attribute is the offset in bits from the
>>>       beginning of the containing storage to the beginning of the
>>>       value. Bits that are part of the offset are padding.  If this
>>>       attribute is omitted a default data bit offset of zero is assumed.
>>>
>>> Would it be possible to use that encoding of those special types?  If
>>
>> I agree with you. I do not like comparing me as well. Unfortunately,
>> there is no enough information in dwarf to find out actual information.
>> The following is the dwarf dump with vmlinux (Sedat provided) for
>> DW_ATE_unsigned_1.
>>
>> 0x000e97e9:   DW_TAG_base_type
>>                   DW_AT_name      ("DW_ATE_unsigned_1")
>>                   DW_AT_encoding  (DW_ATE_unsigned)
>>                   DW_AT_byte_size (0x00)
>>
>> There is no DW_AT_bit_size and DW_AT_bit_offset for base type.
>> AFAIK, these two attributes typically appear in struct/union members
>> together with DW_AT_byte_size.
>>
>> Maybe compilers (clang in this case) can emit DW_AT_bit_size = 1
>> and DW_AT_bit_offset = 0/7 (depending on big/little endian) and
>> this case, we just test and get DW_AT_bit_size and it should work.
>>
>> But I think BTF does not need this (DW_ATE_unsigned_1) for now.
>> I checked dwarf dump and it is mostly used for some arith operation
>> encoded in dump (in this case, e.g., shift by 1 bit)
>>
>> 0x000015cf:   DW_TAG_base_type
>>                   DW_AT_name      ("DW_ATE_unsigned_1")
>>                   DW_AT_encoding  (DW_ATE_unsigned)
>>                   DW_AT_byte_size (0x00)
>>
>> 0x00010ed9:         DW_TAG_formal_parameter
>>                         DW_AT_location    (DW_OP_lit0, DW_OP_not,
>> DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1", DW_OP_convert
>> (0x000015d4) "DW_ATE_unsigned_8", DW_OP_stack_value)
>>                         DW_AT_abstract_origin     (0x00013984 "branch")
>>
>> Look at clang frontend, only the following types are encoded with
>> unsigned dwarf type.
>>
>>     case BuiltinType::UShort:
>>     case BuiltinType::UInt:
>>     case BuiltinType::UInt128:
>>     case BuiltinType::ULong:
>>     case BuiltinType::WChar_U:
>>     case BuiltinType::ULongLong:
>>       Encoding = llvm::dwarf::DW_ATE_unsigned;
>>       break;
>>
>>
>>> not, can we try to come up with some extension that doesn't require
>>> consumers to match magic names?
>>>
> 
> You want me to upload mlx5_core.ko?

I just sent out a patch. You are cc'ed. I also attached in this email.
Yes, it would be great if you can upload mlx5_core.ko so I can
double check with this DW_ATE_unsigned_160 which is really usual.

> 
> When looking with llvm-dwarf for DW_ATE_unsigned_160:
> 
> 0x00d65616:   DW_TAG_base_type
>                 DW_AT_name      ("DW_ATE_unsigned_160")
>                 DW_AT_encoding  (DW_ATE_unsigned)
>                 DW_AT_byte_size (0x14)
> 
> If you need further information, please let me know.
> 
> Thanks.
> 
> - Sedat -
> 

--------------FE8CCA679D6C73CF6F9F35BF
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="0001-btf_encoder-sanitize-non-regular-int-base-type.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-btf_encoder-sanitize-non-regular-int-base-type.patch"

RnJvbSAyMzljNzk3MDkwYWJiZGM1MjUzZDBmZjFlOWU2NTdjNTAwNmZiYmVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb25naG9uZyBTb25nIDx5aHNAZmIuY29tPgpEYXRlOiBTYXQs
IDYgRmViIDIwMjEgMTA6MjE6NDUgLTA4MDAKU3ViamVjdDogW1BBVENIIGR3YXJ2ZXNdIGJ0Zl9l
bmNvZGVyOiBzYW5pdGl6ZSBub24tcmVndWxhciBpbnQgYmFzZSB0eXBlCgpjbGFuZyB3aXRoIGR3
YXJmNSBtYXkgZ2VuZXJhdGUgbm9uLXJlZ3VsYXIgaW50IGJhc2UgdHlwZSwKaS5lLiwgbm90IGEg
c2lnbmVkL3Vuc2lnbmVkIGNoYXIvc2hvcnQvaW50L2xvbmdsb25nL19faW50MTI4LgpTdWNoIGJh
c2UgdHlwZXMgYXJlIG9mdGVuIHVzZWQgdG8gZGVzY3JpYmUKaG93IGFuIGFjdHVhbCBwYXJhbWV0
ZXIgb3IgdmFyaWFibGUgaXMgZ2VuZXJhdGVkLiBGb3IgZXhhbXBsZSwKCjB4MDAwMDE1Y2Y6ICAg
RFdfVEFHX2Jhc2VfdHlwZQogICAgICAgICAgICAgICAgRFdfQVRfbmFtZSAgICAgICgiRFdfQVRF
X3Vuc2lnbmVkXzEiKQogICAgICAgICAgICAgICAgRFdfQVRfZW5jb2RpbmcgIChEV19BVEVfdW5z
aWduZWQpCiAgICAgICAgICAgICAgICBEV19BVF9ieXRlX3NpemUgKDB4MDApCgoweDAwMDEwZWQ5
OiAgICAgICAgIERXX1RBR19mb3JtYWxfcGFyYW1ldGVyCiAgICAgICAgICAgICAgICAgICAgICBE
V19BVF9sb2NhdGlvbiAgICAoRFdfT1BfbGl0MCwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBEV19PUF9ub3QsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRFdfT1BfY29udmVydCAoMHgwMDAwMTVjZikgIkRXX0FURV91bnNpZ25lZF8xIiwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEV19PUF9jb252ZXJ0ICgw
eDAwMDAxNWQ0KSAiRFdfQVRFX3Vuc2lnbmVkXzgiLAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIERXX09QX3N0YWNrX3ZhbHVlKQogICAgICAgICAgICAgICAgICAgICAg
RFdfQVRfYWJzdHJhY3Rfb3JpZ2luICAgICAoMHgwMDAxMzk4NCAiYnJhbmNoIikKCldoYXQgaXQg
ZG9lcyBpcyB3aXRoIGEgbGl0ZXJhbCAiMCIsIGRpZCBhICJub3QiIG9wZXJhdGlvbiwgYW5kIHRo
ZSBjb252ZXJ0ZWQgdG8Kb25lLWJpdCB1bnNpZ25lZCBpbnQgYW5kIHRoZW4gOC1iaXQgdW5zaWdu
ZWQgaW50LgoKQW5vdGhlciBleGFtcGxlLAoKMHgwMDBlOTdlNDogICBEV19UQUdfYmFzZV90eXBl
CiAgICAgICAgICAgICAgICBEV19BVF9uYW1lICAgICAgKCJEV19BVEVfdW5zaWduZWRfMjQiKQog
ICAgICAgICAgICAgICAgRFdfQVRfZW5jb2RpbmcgIChEV19BVEVfdW5zaWduZWQpCiAgICAgICAg
ICAgICAgICBEV19BVF9ieXRlX3NpemUgKDB4MDMpCgoweDAwMGY4OGY4OiAgICAgRFdfVEFHX3Zh
cmlhYmxlCiAgICAgICAgICAgICAgICAgIERXX0FUX2xvY2F0aW9uICAgICAgICAoaW5kZXhlZCAo
MHgzYykgbG9jbGlzdCA9IDB4MDAwMDhmYjA6CiAgICAgICAgICAgICAgICAgICAgIFsweGZmZmZm
ZmZmODI4MDg4MTIsIDB4ZmZmZmZmZmY4MjgwODgxNyk6CiAgICAgICAgICAgICAgICAgICAgICAg
ICBEV19PUF9icmVnMCBSQVgrMCwKICAgICAgICAgICAgICAgICAgICAgICAgIERXX09QX2NvbnZl
cnQgKDB4MDAwZTk3ZDUpICJEV19BVEVfdW5zaWduZWRfNjQiLAogICAgICAgICAgICAgICAgICAg
ICAgICAgRFdfT1BfY29udmVydCAoMHgwMDBlOTdkZikgIkRXX0FURV91bnNpZ25lZF84IiwKICAg
ICAgICAgICAgICAgICAgICAgICAgIERXX09QX3N0YWNrX3ZhbHVlLAogICAgICAgICAgICAgICAg
ICAgICAgICAgRFdfT1BfcGllY2UgMHgxLAogICAgICAgICAgICAgICAgICAgICAgICAgRFdfT1Bf
YnJlZzAgUkFYKzAsCiAgICAgICAgICAgICAgICAgICAgICAgICBEV19PUF9jb252ZXJ0ICgweDAw
MGU5N2Q1KSAiRFdfQVRFX3Vuc2lnbmVkXzY0IiwKICAgICAgICAgICAgICAgICAgICAgICAgIERX
X09QX2NvbnZlcnQgKDB4MDAwZTk3ZGEpICJEV19BVEVfdW5zaWduZWRfMzIiLAogICAgICAgICAg
ICAgICAgICAgICAgICAgRFdfT1BfbGl0OCwKICAgICAgICAgICAgICAgICAgICAgICAgIERXX09Q
X3NociwKICAgICAgICAgICAgICAgICAgICAgICAgIERXX09QX2NvbnZlcnQgKDB4MDAwZTk3ZGEp
ICJEV19BVEVfdW5zaWduZWRfMzIiLAogICAgICAgICAgICAgICAgICAgICAgICAgRFdfT1BfY29u
dmVydCAoMHgwMDBlOTdlNCkgIkRXX0FURV91bnNpZ25lZF8yNCIsCiAgICAgICAgICAgICAgICAg
ICAgICAgICBEV19PUF9zdGFja192YWx1ZSwKICAgICAgICAgICAgICAgICAgICAgICAgIERXX09Q
X3BpZWNlIDB4MwogICAgICAgICAgICAgICAgICAgICAuLi4uLi4KCkF0IG9uZSBwb2ludCwgYSBy
aWdodCBzaGlmdCBieSA4IGhhcHBlbnMgYW5kIHRoZSByZXN1bHQgaXMgY29udmVydGVkIHRvCjMy
LWJpdCB1bnNpZ25lZCBpbnQgYW5kIHRoZW4gdG8gMjQtYml0IHVuc2lnbmVkIGludC4KCkJURiBk
b2VzIG5vdCBuZWVkIGFueSBvZiB0aGVzZSBEV19PUF8qIGluZm9ybWF0aW9uIGFuZCBzdWNoIG5v
bi1yZWd1bGFyIGludAp0eXBlcyB3aWxsIGNhdXNlIGxpYmJwZiB0byBlbWl0IGVycm9ycy4KTGV0
IHVzIHNhbml0aXplIHRoZW0gdG8gZ2VuZXJhdGUgQlRGIGFjY2VwdGFibGUgdG8gbGliYnBmIGFu
ZCBrZXJuZWwuCgpDYzogU2VkYXQgRGlsZWsgPHNlZGF0LmRpbGVrQGdtYWlsLmNvbT4KU2lnbmVk
LW9mZi1ieTogWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4KLS0tCiBsaWJidGYuYyB8IDM5ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDM4
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9saWJidGYuYyBiL2xp
YmJ0Zi5jCmluZGV4IDlmNzYyODMuLjkzZmUxODUgMTAwNjQ0Ci0tLSBhL2xpYmJ0Zi5jCisrKyBi
L2xpYmJ0Zi5jCkBAIC0zNzMsNiArMzczLDcgQEAgaW50MzJfdCBidGZfZWxmX19hZGRfYmFzZV90
eXBlKHN0cnVjdCBidGZfZWxmICpidGZlLCBjb25zdCBzdHJ1Y3QgYmFzZV90eXBlICpidCwKIAlz
dHJ1Y3QgYnRmICpidGYgPSBidGZlLT5idGY7CiAJY29uc3Qgc3RydWN0IGJ0Zl90eXBlICp0Owog
CXVpbnQ4X3QgZW5jb2RpbmcgPSAwOworCXVpbnQxNl90IGJ5dGVfc3o7CiAJaW50MzJfdCBpZDsK
IAogCWlmIChidC0+aXNfc2lnbmVkKSB7CkBAIC0zODQsNyArMzg1LDQzIEBAIGludDMyX3QgYnRm
X2VsZl9fYWRkX2Jhc2VfdHlwZShzdHJ1Y3QgYnRmX2VsZiAqYnRmZSwgY29uc3Qgc3RydWN0IGJh
c2VfdHlwZSAqYnQsCiAJCXJldHVybiAtMTsKIAl9CiAKLQlpZCA9IGJ0Zl9fYWRkX2ludChidGYs
IG5hbWUsIEJJVFNfUk9VTkRVUF9CWVRFUyhidC0+Yml0X3NpemUpLCBlbmNvZGluZyk7CisJLyog
ZHdhcmY1IG1heSBlbWl0IERXX0FURV9bdW5dc2lnbmVkX3tudW19IGJhc2UgdHlwZXMgd2hlcmUK
KwkgKiB7bnVtfSBpcyBub3QgcG93ZXIgb2YgMiBhbmQgbWF5IGV4Y2VlZCAxMjguIFN1Y2ggYXR0
cmlidXRlcworCSAqIGFyZSBtb3N0bHkgdXNlZCB0byByZWNvcmQgb3BlcmF0aW9uIGZvciBhbiBh
Y3R1YWwgcGFyYW1ldGVyCisJICogb3IgdmFyaWFibGUuCisJICogRm9yIGV4YW1wbGUsCisJICog
ICAgIERXX0FUX2xvY2F0aW9uICAgICAgICAoaW5kZXhlZCAoMHgzYykgbG9jbGlzdCA9IDB4MDAw
MDhmYjA6CisJICogICAgICAgICBbMHhmZmZmZmZmZjgyODA4ODEyLCAweGZmZmZmZmZmODI4MDg4
MTcpOgorCSAqICAgICAgICAgICAgIERXX09QX2JyZWcwIFJBWCswLAorCSAqICAgICAgICAgICAg
IERXX09QX2NvbnZlcnQgKDB4MDAwZTk3ZDUpICJEV19BVEVfdW5zaWduZWRfNjQiLAorCSAqICAg
ICAgICAgICAgIERXX09QX2NvbnZlcnQgKDB4MDAwZTk3ZGYpICJEV19BVEVfdW5zaWduZWRfOCIs
CisJICogICAgICAgICAgICAgRFdfT1Bfc3RhY2tfdmFsdWUsCisJICogICAgICAgICAgICAgRFdf
T1BfcGllY2UgMHgxLAorCSAqICAgICAgICAgICAgIERXX09QX2JyZWcwIFJBWCswLAorCSAqICAg
ICAgICAgICAgIERXX09QX2NvbnZlcnQgKDB4MDAwZTk3ZDUpICJEV19BVEVfdW5zaWduZWRfNjQi
LAorCSAqICAgICAgICAgICAgIERXX09QX2NvbnZlcnQgKDB4MDAwZTk3ZGEpICJEV19BVEVfdW5z
aWduZWRfMzIiLAorCSAqICAgICAgICAgICAgIERXX09QX2xpdDgsCisJICogICAgICAgICAgICAg
RFdfT1Bfc2hyLAorCSAqICAgICAgICAgICAgIERXX09QX2NvbnZlcnQgKDB4MDAwZTk3ZGEpICJE
V19BVEVfdW5zaWduZWRfMzIiLAorCSAqICAgICAgICAgICAgIERXX09QX2NvbnZlcnQgKDB4MDAw
ZTk3ZTQpICJEV19BVEVfdW5zaWduZWRfMjQiLAorCSAqICAgICAgICAgICAgIERXX09QX3N0YWNr
X3ZhbHVlLCBEV19PUF9waWVjZSAweDMKKwkgKiAgICAgRFdfQVRfbmFtZSAgICAoImVieCIpCisJ
ICogICAgIERXX0FUX2RlY2xfZmlsZSAgICAgICAoIi9saW51eC9hcmNoL3g4Ni9ldmVudHMvaW50
ZWwvY29yZS5jIikKKwkgKgorCSAqIEluIHRoZSBhYm92ZSBleGFtcGxlLCBhdCBzb21lIHBvaW50
LCBvbmUgdW5zaWduZWRfMzIgdmFsdWUKKwkgKiBpcyByaWdodCBzaGlmdGVkIGJ5IDggYW5kIHRo
ZSByZXN1bHQgaXMgY29udmVydGVkIHRvIHVuc2lnbmVkXzMyCisJICogYW5kIHRoZW4gdW5zaWdu
ZWRfMjQuCisJICoKKwkgKiBCVEYgZG9lcyBub3QgbmVlZCBzdWNoIERXX09QXyogaW5mb3JtYXRp
b24gc28gbGV0IHVzIHNhbml0aXplCisJICogdGhlc2Ugbm9uLXJlZ3VsYXIgaW50IHR5cGVzIHRv
IGF2b2lkIGxpYmJwZi9rZXJuZWwgY29tcGxhaW50cy4KKwkgKi8KKwlieXRlX3N6ID0gQklUU19S
T1VORFVQX0JZVEVTKGJ0LT5iaXRfc2l6ZSk7CisJaWYgKCFieXRlX3N6IHx8IChieXRlX3N6ICYg
KGJ5dGVfc3ogLSAxKSkpIHsKKwkJbmFtZSA9ICJzYW5pdGl6ZWRfaW50IjsKKwkJYnl0ZV9zeiA9
IDQ7CisJfQorCisJaWQgPSBidGZfX2FkZF9pbnQoYnRmLCBuYW1lLCBieXRlX3N6LCBlbmNvZGlu
Zyk7CiAJaWYgKGlkIDwgMCkgewogCQlidGZfZWxmX19sb2dfZXJyKGJ0ZmUsIEJURl9LSU5EX0lO
VCwgbmFtZSwgdHJ1ZSwgIkVycm9yIGVtaXR0aW5nIEJURiB0eXBlIik7CiAJfSBlbHNlIHsKLS0g
CjIuMjQuMQoK

--------------FE8CCA679D6C73CF6F9F35BF--
