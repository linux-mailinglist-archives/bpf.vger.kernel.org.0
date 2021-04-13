Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1252F35E901
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 00:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345478AbhDMW2D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 18:28:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52710 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231466AbhDMW2C (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 18:28:02 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13DMRY0H026904;
        Tue, 13 Apr 2021 15:27:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=r37LFTtCeWbl7TbfY3jq07F7KeFH4A3d98sm5lBET2c=;
 b=jUJmLKC2iqq0PGUONeLarCiUyw2YPcJe5VlRMtIEyqWNYkd2ueJqJ/jl5LO2Lls0H5pe
 orwO24oNHBps0ByUQ2AIxIxZ/ytn7ApSMTfBdQhGl6EfJcqvZK918/elmtofNkEuHwro
 ySsuAg3HZPvCZgHeD/yxrt7q97yEtDMyuj8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 37wackumja-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 13 Apr 2021 15:27:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Apr 2021 15:27:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9spm2O4NGg8B66vLeenv8gv3kL0lAMUQiNygjh9kunhB/OoW7hRumVB4Fl7rksBs5q35X8cNE3Y72ZAJUhJFSBvsCUtF+hpDGbUu6j/2fDsnLsW7uYRcgGykjvElxRbESKOrK71oGNcPK7Oscyh8S6my/coA42rnQIEnlLCORZENSGOtVjVTwk7lGLN8GV5F8tq37mPBCn4EPXxcpzEFK0clx9zbeZ0favUIUQRkgOi2uexIXtDcWHHCsXs2a4gdLBEPLczuPJf2rfMcIY7bug2xod0RmHxtvEpuIqbH+qOuhCxfCah/U8UaMFdcsGcCs7eksuGNgNxc02T0qUq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r37LFTtCeWbl7TbfY3jq07F7KeFH4A3d98sm5lBET2c=;
 b=h4QG72TTRnLWSK6XHWLHDg6F6OrtM+b4TbYofuqk6w9r1MVSm44GhwipZwcIXQi4SLN3XSaIy3GDvGhsGT6SgxrONY5qu68iu3J/UDnlRbf6FkucDYzUltJYqxYDdqO2ltflETxNYlRfFiT3Bfy7pGiuyEEIEYTNRI0f/eLh9ltTFMKQQFGWmfCdwj66erlKt47JEcny8I/KhDX1zgNmHy7niu8tFisLWkymcz/x/7Qh5DZY1IYReA2TUpZJ78tbdhEfiNVF8+Z4ELuq5zFqA7Cl0mIZKt0WKi4CVIyiUe74yRHmE7NjmbeiQL4+58PirecLjIZ9lZtwbW7EJXpuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4062.namprd15.prod.outlook.com (2603:10b6:806:82::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 22:27:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Tue, 13 Apr 2021
 22:27:32 +0000
Subject: Re: [PATCH bpf-next v3 1/5] selftests: set CC to clang in lib.mk if
 LLVM is set
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20210413153408.3027270-1-yhs@fb.com>
 <20210413153413.3027426-1-yhs@fb.com>
 <CAEf4BzZM3bLp=zFJ99ZX6iyM1D5gfB6eyweurVjn6iVOLdsrow@mail.gmail.com>
 <CAKwvOdnJYbBs=F2yZLqKvZX5_iHv_X_zCfQXSS3sv=iVDejL=w@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e07d9794-75c1-f554-d827-26a02a6b09f1@fb.com>
Date:   Tue, 13 Apr 2021 15:27:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CAKwvOdnJYbBs=F2yZLqKvZX5_iHv_X_zCfQXSS3sv=iVDejL=w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:fd10]
X-ClientProxiedBy: MWHPR21CA0056.namprd21.prod.outlook.com
 (2603:10b6:300:db::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1058] (2620:10d:c090:400::5:fd10) by MWHPR21CA0056.namprd21.prod.outlook.com (2603:10b6:300:db::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.0 via Frontend Transport; Tue, 13 Apr 2021 22:27:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3153dbad-8444-4ede-fc1b-08d8fecb5485
X-MS-TrafficTypeDiagnostic: SA0PR15MB4062:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB40620C2160D167B59C86C57FD34F9@SA0PR15MB4062.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:350;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKyQXrWJPZz7qAMDDsisse9iczk8mMqKWYsDngFlgamYPHfOaASvGo6rNh9LUxJNv3qAM+HvuHxep57Xz/i3zOAgsjlQH8FTN4LhCIP5KSk4Bd5oO15UmHLrCqC8AhJd+nLP4E7sLKrmzTqiw35HgWwbC8Xsat0cC271vNz7XHrweVigilNCZA2kgyn5B4VYDWSWE7ppKHEtflet2uxReA7/TQ+4rYEiMvj2M8BfROQkN2faijA9weUUQZxFaqxghD/LJkYZQABivTTPdBIRweSRPWIXTXBKArfo7CUJI8VFNgYmLMgSioEcPGCunSiXLHukVQb1pAzRxJfKhD5XbFvomkf7IQyP8XuDolMAeFPaqsYdWZHfKBVaj7OGU1Jy9RNwVrc6/HZO541sucDQ3mvzqt6Utd6/YF93M/9wA1i94/QJ7ii9bEXXcVBh6fS0yqywQhli0ktvsp3spLS00rUCIhy4KJEeMuW4SLGjtqZ0a3yxzqmHIS+t0JhStCoRqm3pE0VSZcHaCV2LEnwYr2HIAAIRXbmee15YLyFHAUeTa4EzUsYoa1m9zqZfnZA8uB7usdgLMDsFxN90OFYt6koeJ9ofvMtw42ReKJ+OSz7EzHcbxQFj8kd4Sv1TBR61XUbbk/3MeloE+oMHKHPAPgzcvjUO+5aXr7XvaJluuRwBHws/gDzgXlFcpO5OIaFV6ErGYUUOOoIDAp4Z0b8dXIejAzPYJEW1o83q2OEYwW7hOBh/Uva9IIH1c4hV+wAap0nYf2IyVDQ7j2cRHL6g+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(376002)(366004)(396003)(31696002)(54906003)(316002)(53546011)(66946007)(86362001)(8676002)(4326008)(186003)(2906002)(66556008)(36756003)(16526019)(8936002)(110136005)(52116002)(38100700002)(66476007)(5660300002)(478600001)(6486002)(2616005)(966005)(31686004)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ekFqM3NrLzU2MDBzLzQrOGJHbWlpeUxDMEtrVFpFU1MvNzFjOUdxam81YWcy?=
 =?utf-8?B?a1U0RDl4MkNrU0xWdXRmTXRmUDBHVFlKb2R6SEdyYTVwbEZ6M1Z3QW5iYm95?=
 =?utf-8?B?dU1yZUYyNFQxeUhUTXhRVGxKV1B5cFBjcnh5L3BJc2NGRFBIR2g3cjVNcmJV?=
 =?utf-8?B?TTZRZkZXZlhhb1BqLzA4c2trNjVlaVAvZi9rTDlKTFpGL1IwVmZYRnd1MjFW?=
 =?utf-8?B?Y25ibDlYTEhQcmEyVTcrOVcvaFZqclBnbWhJNTRqbG1KczVtQitSTUY0cUdv?=
 =?utf-8?B?R1c0K09oQ2tUN0M5THd3V3g3QkZMU1QzSUNtcEt5M0hLZ2R0K2VwVkYzKzIx?=
 =?utf-8?B?TThKcXBGWUNwcTlUWkJia2J5ajN6bkxxOVQyYUkxOThkVVc3WXpXY21wT0dI?=
 =?utf-8?B?blphdFd1L1huV2F6d09Jbm9OUFQ0bmY4bWNJVkdZT2ZUS1UzbU0vWUsrT2xG?=
 =?utf-8?B?RzkzbFNVRjZPQm9aUll1TlVHc2ZldDcvMzc3SjA5S1RYRFpNZFFUVXErMW5j?=
 =?utf-8?B?UFNlY0hRT1QrRnBNVDR6anNndndYSE0wY0l1bkovUHdLcStEZkNwRldMTm9x?=
 =?utf-8?B?YllSMTJkUkc5TlBvMGhHdVluS0RMYlYrYm1uZFAraVJpTHh0Z0VEK0xTTm1a?=
 =?utf-8?B?UFkyRTlDNEg2bVlDRHY5WTdzbmlnb2lEbWVvTFBKbXhsTnFnTXROaTBHU2pU?=
 =?utf-8?B?REw5ZkVQck93RCt6N2lVcWUvaTR3VnJ0VGRxdHZsdlNiQzhyMG51R0phWStx?=
 =?utf-8?B?VTdDWUQyRU5nSUhqdTEvQkE5bmR4c2J6VVdsY3hxTTZzdytwS0xNekhveWds?=
 =?utf-8?B?TU02V0JuMjIwVmp2WGVzeWZ1azJyUkN5dzVNWDJKaitvcTVvemk1amxTb3VG?=
 =?utf-8?B?MUkyYTBKa2RBR2xOK25ldUgxTkxwZVg1RGFtQTdURm1jL01qY1ZFMDNzT2Jy?=
 =?utf-8?B?VTRRelo1ZzBwM3RYYnlyc3N3WVVTRzdjOGZmTkVFL1VEWVR5L1dXRUtkeE9l?=
 =?utf-8?B?M08vczdZa01Hd1h0bHE3NEFmWmcwN0hpampMc3dxc05RRTVvekVTWkZiNG9P?=
 =?utf-8?B?VHc2c21DVW9nWDhnZWFvbEI4bnhYVVZHMjRqNnJSd3Z2NFprcmxYRWJ2MzB0?=
 =?utf-8?B?Zy9nREZrRUVYckV6VUFJVE4zM2NxOVR0QkhvaXlLaTY3M2RNTlpkVmRmYWts?=
 =?utf-8?B?YkFwT0QzVnZDOGI2cGd6SlVaeUUvQTF4dFgyTjlMT0U4ek1RNGtjSndRbVZp?=
 =?utf-8?B?aDNJTjhpb1ZZNERDdTN3Y3VFRUVRWnJ5S1I4LzVjMVdCeXc1RURVNEczaFc4?=
 =?utf-8?B?L1gvazFHN2M5bXU5WkUzSXh4UjcrN210MW9qbG5hTUc0MTZSL004SUxUUzNn?=
 =?utf-8?B?UWd5YVZMeWhSM0crcW56eEJPajVKSFlpN0VJSy9ZL1IyTzROOEJUcGdRVUMz?=
 =?utf-8?B?Z2UwVW5WR0FBQi9nYWgwaVNkekZiVk9mSHl3eUVyd0hZVkozWVJSa1Q0V04v?=
 =?utf-8?B?dTFCeHl6VDR0YmFRMWEwVllRNEJMbk1CZzkvNVU2RlppRE9xNEw3ZVl0cE90?=
 =?utf-8?B?aC91ejJkWjkxTEs0M3BKNUJXejRzaDh4dWFDWTFIYWE1ak5ma3VEZ3BWcE9T?=
 =?utf-8?B?dCtTTFBSZVhPbWdRNGFlSTJBdlUxSVd1aW0rakV0S2w0K1p5dVFZN0NCUnVq?=
 =?utf-8?B?NDRoUkYxMHRqYjhsYlE2RGozZktEYjkwQjFzUldpVndUTGw2NWtxQW5ONFQv?=
 =?utf-8?B?RXY1bndyQjdGMTN0UjdOTmRIMG9vL3RlSDQzREhIbmc0ZDMxZFRQYkJPOC9U?=
 =?utf-8?B?VitQdldCV3VsZDNtcTR6UT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3153dbad-8444-4ede-fc1b-08d8fecb5485
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 22:27:32.4487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzS1IkpIr+3Z4N8c3cEMh8e52BShqqP1vy4ppO1LwnYPbi5I77A+Vzlw3J/JWdws
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4062
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 8pBO0JbNxaI-p8vFpKuRgQlLfwADGIJr
X-Proofpoint-ORIG-GUID: 8pBO0JbNxaI-p8vFpKuRgQlLfwADGIJr
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_16:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/13/21 3:13 PM, Nick Desaulniers wrote:
> On Tue, Apr 13, 2021 at 3:05 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Tue, Apr 13, 2021 at 8:34 AM Yonghong Song <yhs@fb.com> wrote:
>>>
>>> selftests/bpf/Makefile includes lib.mk. With the following command
>>>    make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
>>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1 V=1
>>> some files are still compiled with gcc. This patch
>>> fixed lib.mk issue which sets CC to gcc in all cases.
>>>
>>> Cc: Sedat Dilek <sedat.dilek@gmail.com>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>   tools/testing/selftests/lib.mk | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
>>> index a5ce26d548e4..9a41d8bb9ff1 100644
>>> --- a/tools/testing/selftests/lib.mk
>>> +++ b/tools/testing/selftests/lib.mk
>>> @@ -1,6 +1,10 @@
>>>   # This mimics the top-level Makefile. We do it explicitly here so that this
>>>   # Makefile can operate with or without the kbuild infrastructure.
>>> +ifneq ($(LLVM),)
>>> +CC := clang
>>
>> Does this mean that cross-compilation with Clang doesn't work at all
>> or is achieved in some other way?
> 
> Right, this probably doesn't support cross compilation w/ Clang.
> Rather than invoke `$(CROSS_COMPILE) clang`, you'd do `clang
> --target=$(CROSS_COMPILE)`.  Even then, cross linking executables is
> hairy.  But at least this should enable native compilation, which is a
> start.

See https://clang.llvm.org/docs/CrossCompilation.html.
As Nick said, clang prefers --target=$(CROSS_COMPILE) to
indicate cross compilation. User can pass additional
flags (CFLAGS) for cross compilation for the time being.
This is the same as main kernel Makefile.

ifneq ($(LLVM),)
CC              = clang
LD              = ld.lld
AR              = llvm-ar
NM              = llvm-nm
OBJCOPY         = llvm-objcopy
OBJDUMP         = llvm-objdump
READELF         = llvm-readelf
STRIP           = llvm-strip
else
CC              = $(CROSS_COMPILE)gcc
LD              = $(CROSS_COMPILE)ld
AR              = $(CROSS_COMPILE)ar
NM              = $(CROSS_COMPILE)nm
OBJCOPY         = $(CROSS_COMPILE)objcopy
OBJDUMP         = $(CROSS_COMPILE)objdump
READELF         = $(CROSS_COMPILE)readelf
STRIP           = $(CROSS_COMPILE)strip
endif

>>
>>
>>> +else
>>>   CC := $(CROSS_COMPILE)gcc
>>> +endif
>>>
>>>   ifeq (0,$(MAKELEVEL))
>>>       ifeq ($(OUTPUT),)
>>> --
>>> 2.30.2
>>>
> 
> 
> 
