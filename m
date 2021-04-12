Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68F335B9E5
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 07:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhDLFm7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 01:42:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63518 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229482AbhDLFm7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Apr 2021 01:42:59 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13C5fgSV006303;
        Sun, 11 Apr 2021 22:42:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=2s72PkXY7mRV3gFC7SfQcHGu+skqgE+71goewvlpovs=;
 b=fVG2JMs2X2qFbF3Yu5bNUzixvrBAayz5C71UfWQRrbOCGCEY0jIMWYKLxq1QwoPiqtzs
 nKECyuxbTlNLZgkSaC9ZeNQZ9L6YSZ/VJuUa1KO8okf1PcATLaVfJa+euGQ4meziS7q3
 nBFntbMx8lMmYPBzRyZzXI6n3KWEfLUlOW8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37uuusbch8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 11 Apr 2021 22:42:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 11 Apr 2021 22:42:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQR6rPbWrb2/W559AtS6g7uUd3/aRoz1zPvoN2f4MWy0iWAI3INVY+ysOGeHOv5vnE5Pb9s1msXCwx1ksZCacjWrbGac0BqzDTFCaUNoJ6Ylzd5snX/1nbSoOXGEGJ6xBNTD0zd3CZXc8VkI5otAb9dsJ+/vfX/N7p6IyHwRMW5V01GhAcCM3DoqoeBayuA/zh1qhV93Q64yYGDbPiDHP5CTRHO4IgniKyyFT2EChObz7N9AFP0xvPEZ3MmJ6/etmsQExMkneB1aGEUXeDct+rR7ybahFV2qu6QlzX1BejRHQp4u1PaG8YXBmdYbkDFk/Z1nXZxCNQsZ7C7p0vnhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s72PkXY7mRV3gFC7SfQcHGu+skqgE+71goewvlpovs=;
 b=LSmFlp9asuvKxPEZodIGBRiC/niJMvIQ0AlyjCFQuOT0DRMeUwtz+i/yW/CI82/Jx/4FGrhzCeDpGeYlL5/b51yKjLamvMwU/n8y99xALyI1YZMB4M0zITBGfBFsvRl0R59Io5ZUj4yKH542DReKEspdjW11jDeZTLQCngWxp1pYe/jxpWhpRk5HyYkvag3/Er77Bs7sXBvwrz1jeGTz68pse+rdWrThxzPaZpB/iy8ZweRQETbaU/4RcFCL/xteJo2JIzC4igxkePSlxd1XxjY/CIeFRnY2hmNqTiDwxCJpb4+jSMKqES/DjoCpX23NRSpwenqiWVQmvzWwYpAZVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3936.namprd15.prod.outlook.com (2603:10b6:806:80::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Mon, 12 Apr
 2021 05:42:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Mon, 12 Apr 2021
 05:42:35 +0000
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: fix test_cpp compilation
 failure with clang
To:     <sedat.dilek@gmail.com>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>
References: <20210410164925.768741-1-yhs@fb.com>
 <20210410164940.770304-1-yhs@fb.com>
 <CA+icZUXzCpHWk8Vm5D4ZcCbdd9gqipVD5ALCw6SGTFbYfdJZiA@mail.gmail.com>
 <7c82c0f5-2a96-7a5c-b090-f26c9351786c@fb.com>
 <CA+icZUWwSg4Nd+AzAMx8Os4iAfs=40zeoYn0eVKg3Cy7fB5Cow@mail.gmail.com>
 <3f224f2c-bb7e-accc-b095-7fee8210861b@fb.com>
 <CA+icZUVPQT9WNona7xdmZP+2nS=xLn6hssd1wmLSeVNBzsOqTQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <1184be32-46d6-15a8-06b6-7e9bd26a88c6@fb.com>
Date:   Sun, 11 Apr 2021 22:42:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CA+icZUVPQT9WNona7xdmZP+2nS=xLn6hssd1wmLSeVNBzsOqTQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:5961]
X-ClientProxiedBy: MWHPR1401CA0003.namprd14.prod.outlook.com
 (2603:10b6:301:4b::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::110f] (2620:10d:c090:400::5:5961) by MWHPR1401CA0003.namprd14.prod.outlook.com (2603:10b6:301:4b::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 05:42:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 682f6659-c7f1-4421-2405-08d8fd75c672
X-MS-TrafficTypeDiagnostic: SA0PR15MB3936:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB393617214CEB8D8CB0B2129DD3709@SA0PR15MB3936.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvHh4S8iRyZ5YC0hOOsB6MKlssXij0Rpign2VBEo3A9WhV84fzvsbBClR8P1oG1eN+Lkk36MuHEtkYMrkJsy+JD31CeJmgVgl6Ixgssd2ctNVCCeDUpRW9lCbvJOYSnseJNGzeS6Z1o3JSFi5mXuNe8Ja9MdceyaW03zd1VD/ksY+Jb9Zozjo1iqh8uEEqv5BGk3zu7IyT5TmmbfCvOJ3NyVd5VjyekVp/wnKSGgBk2TfF5V86/u1k00CR/Sbo2Js7x52bBajf2fMlnxdAXfkFVvcWMW54PkckTG7vI6VDgc+XPg9/7yA36fMNC4H7ImV/RplmbOEg+CmzmvCGbcu43c/B4PPDv35gZfiuCgbWOGFU8WODo/XcIsaJQ3LHLRi59kpQEZJlm8Pd585Z+IY6ALMcl4LTQ9af+wi0ZmjyRVQ9V/2i2NJWTg/iarEb8npkaV2oXisebVcvFDlooSSr3S2uGdfpjjGfPZeIYa29Xrez359v/Tc5FZ+t0nCs4G7TPLPIBQbuVYiTCda6gQ0Wql8DRqNg+zL8Ia9mQYvu1lsV0iFAx9la0ppb/9FvWUZRWOu3CASzQgQMdjL4XmlHfi1ez5ykFHuhg1wkBPVKgzbdPw0QqT8fkWsA+vMx7w96tj6s3pJJmPWIZoL8kZzgch89uiG+vhmBPwF1ZC5DJ6mXc+5M+/Dmx6tRvgcr8J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(376002)(136003)(346002)(52116002)(66946007)(6486002)(38100700002)(36756003)(478600001)(5660300002)(2906002)(16526019)(2616005)(66556008)(4326008)(53546011)(31696002)(316002)(186003)(83380400001)(6666004)(8936002)(54906003)(6916009)(66476007)(31686004)(8676002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SFRaTDVKZk9laGljNXFDS3ZGUFpvUTl4MXBkQ0FZMXIzbGtlQ0lxRTdqeWxm?=
 =?utf-8?B?YlV0WGRWM1k1OHgxaG9IeTZmSGlJY24vWDV1YlpQTXlzN1JyT0FlRFNQcE5r?=
 =?utf-8?B?ZFJPOHRCMkF4N0hORWoxOHBlb1dLeW03WkxrK1Rvd3lOeHI4VE5zVHJScW1v?=
 =?utf-8?B?U29KWU8wcTNzb25UUm1uMDZKNnIzM2duT2twcloxc2pzMzZDRWFySVdTdlk4?=
 =?utf-8?B?MUtsQWRBcEVXSXJ1VExaMllTekxNWDF1QkwvWC9FVHhLQms4eUdzU1g2aEk0?=
 =?utf-8?B?eEVYUjc4K3JNWGJZaXNETlZtRGdPbVZscHBTRE1xMEkvUWozQVRCcjZVQ3JQ?=
 =?utf-8?B?c3hKQmxJcVE1eEpZeE5mMFJYV3lvaHlqbDBOamJhdytJekh2dzBPNGt4cGw0?=
 =?utf-8?B?QllnK3pEMU1Yb3IwcUtpOUJkcVE0dVFhcDk0TFhxcDRCc1AvRkdTb29SZU9K?=
 =?utf-8?B?K0ZkbjkvS2J2TnE5OVExMnB3Mk9UenZFTUpjZkV5aXNIU2Nlb3lIcXM0QnF1?=
 =?utf-8?B?Z0pIRzhMc0NSaXZaQS9xeDMrV0FFbjNidDRyaVlhUExiNGk4dS9KMFFsR0Rk?=
 =?utf-8?B?Wm5YelhJT2FmOVc4Y0cyZmR2VWR1Q1pUVWU2UUN4ejdQRmRmVEtwbUFqYmQ5?=
 =?utf-8?B?d29McVFCZDRDdTVtU3BwNklObXVkSnIwTUhWRjN4SllOTEpNNXY4aUc0a1Vr?=
 =?utf-8?B?WVUyR205Q3NUL0pXU2s3MlJDT1FxRk1kVXZHZzk2ZGYxZWd5b1lpbml5NmJx?=
 =?utf-8?B?bU9MTkV2OEVuN1NwNGMwc0NOOG9vRmpTd1hLa1ErSndia0prMTQxL1FZc2Vi?=
 =?utf-8?B?V21jMnR3THNqSzFnVGR6V2VjVEpocDlZdVlSRy9DSU1TWCtsTjllTDdYQ3Bm?=
 =?utf-8?B?R0xvLzM0d0Q5eWgzMVorUHZMZlRCVjVPVXNZVVg2RzZteWJ6dVNMZDluOWY4?=
 =?utf-8?B?TnFWcm5RUW9BaXNOTUVWOS8ralNxM0NqaitGZENXNk44Zi93SHZyV0RXSkhv?=
 =?utf-8?B?MU9GRmdvNGwvTlNRNjV3UTR1dWVBamFEcU1FeW5haUpPS3JtcmRUakFYelJR?=
 =?utf-8?B?dGpZRXV2aHdpcDY3Yk5lNk9wSm9hWU1pc200azJIWVVWNUxNQmdnT1lYTlds?=
 =?utf-8?B?UEJwd0dQQkVHS1JHY3dIMWpXaVFNSUJUNFhwUGFQVHRRYjZBZHhSOTlTYjdZ?=
 =?utf-8?B?T0Q0YlptVjR0cjNoNk1iOEFjaURUbnRsUGZPN0RXSDlFd0RSWjVESWtsdUkz?=
 =?utf-8?B?S1NzSHVtL3QzcFRqSHVMaEZmYzZ0aW5OVHNERElkUEV6WnQ4RzJ5cHFxbnRx?=
 =?utf-8?B?RnhFdk4yb3RzK0QvVW02V1J4Zkdpa1A1d1plcm5EeGJQY2U4ZFdjRkFIanFC?=
 =?utf-8?B?RCs5S0lUUlZUWDhNZTF0NHF6dzNTQmJpd21CRndxM1E4cm9jU256Qlc1TFR5?=
 =?utf-8?B?T29mSnpwQk55QmludHBSVTlGTWk0cXhKblRZL21hT0ZrRzk3R3NBT1lpdVpW?=
 =?utf-8?B?SXlDTHA0c0hOenFmbHpjaVRxMmd0TVVjTEIybUVGdmRIVEJoMlRMdEdCUWdK?=
 =?utf-8?B?eE5VdGhqODRPTHYybUpic2xTQlV4QWg4NzVXUDQrK2thSVlTbU9HbEFITUR2?=
 =?utf-8?B?MG9EWTV4TWV3VVhQdG8wZWJQWWlaRUU5eEtpUERkL0dhejZzVEwwY3NMdEFB?=
 =?utf-8?B?TURVeUdaZW01dys4bXhMblQyeVpDQVdDSWRwa1o5RnlobFFaYk9nWWpPSXVE?=
 =?utf-8?B?c04vUWNyMmZFQlFEaEV6SzI2L3hXaGZrV0RLVlkvYVIzL0EyNjVibHRYd2xY?=
 =?utf-8?B?VFQvUlV3aTJVQ1NzczRHZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 682f6659-c7f1-4421-2405-08d8fd75c672
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 05:42:35.7194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VN8m6t1UFKRAd+9BKvU4lIg72c2VQ3F/ZUup4r7zPfdtKXEGijOBl52TmvdVh83Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3936
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 3QBMcLu0UiTnRorHTRZik_y7t_vZ_NRa
X-Proofpoint-ORIG-GUID: 3QBMcLu0UiTnRorHTRZik_y7t_vZ_NRa
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_03:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 bulkscore=0 mlxlogscore=851 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/11/21 9:47 PM, Sedat Dilek wrote:
> On Sun, Apr 11, 2021 at 9:08 PM Yonghong Song <yhs@fb.com> wrote:
> [ ... ]
>>> BTW, did you check (llvm-)objdump output?
>>>
>>> $ /opt/llvm-toolchain/bin/llvm-objdump-12 -Dr test_cpp | grep core_extern
>>
>> This is what I got with g++ compiled test_cpp:
>>
>> $ llvm-objdump -Dr test_cpp | grep core_extern
>>     406a80: e8 5b 01 00 00                callq   0x406be0
>> <_ZL25test_core_extern__destroyP16test_core_extern>
>>     406ab9: e8 22 01 00 00                callq   0x406be0
>> <_ZL25test_core_extern__destroyP16test_core_extern>
>> 0000000000406be0 <_ZL25test_core_extern__destroyP16test_core_extern>:
>>     406be3: 74 1a                         je      0x406bff
>> <_ZL25test_core_extern__destroyP16test_core_extern+0x1f>
>>     406bef: 74 05                         je      0x406bf6
>> <_ZL25test_core_extern__destroyP16test_core_extern+0x16>
>>
> 
> What is the output when compiling with clang++ in your bpf-next environment?

$ llvm-objdump -Dr test_cpp | grep core_extern
$

So looks like all test_core_extern_*() functions are inlined.
This can be confirmed by looking at assembly code.
while for gcc, there is still the call to
   _ZL25test_core_extern__destroyP16test_core_extern
which is
   test_core_extern__destroy(test_core_extern*)

This is just a difference between compiler optimizations
between gcc and clang. We don't need to worry about this.

> 
> - Sedat -
> 
