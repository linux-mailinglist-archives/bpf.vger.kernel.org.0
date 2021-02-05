Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC2B3113FF
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 23:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhBEVzT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 16:55:19 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52190 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231250AbhBEVzA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Feb 2021 16:55:00 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 115LrnMM031021;
        Fri, 5 Feb 2021 13:54:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wGjk+hKyeIxseMViYA28u8ZWZQqhiNJjAX6PPLTgkiE=;
 b=lsXFCVQecRrLnsBah+dbZfjUtp2UlQ8w2QxnjUhr2iteFl1TGBqfq2hJR23v0vR14MOc
 FCvS0OumWJSqjPTHogIxmYbtJZZXKvXv6oM2hcmOgA0svPQ+jXeTPcUGgEFs+JPMHDaV
 xFXTaaEn0Y+DDXYt5Fiyylg3cNFiKsO5JXU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 36he09g3mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Feb 2021 13:54:06 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 13:54:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRiCEINTqTJLyYXAU2U1sd4yIqU0zZHMQUKHl7zIEIOqhBMq8/o9fWt9G4nvNcsn8DBnTcIWwWsL/Sj/gLnSaMxAioVYVSG7Qme8vGiCcUaJtq0W+zj8is5mx3Y/RGebFEXZn0i/wjIlCnO7ghg2spjBV69mwq2OFGxmDRywU0SK3t1kBGsC4elfXL9x3YVzmHr1zbzt9AmXHO2/fq8CjUilGYuWyR7wzrAZI6G92Omg1pRn811uN/vVbtll4qHuZ2E4SC9X+nG2H+4tXPpSJzt+eNfiAuGR7lJkMvJcwV0alYEEvw11cqb0ZZ2upw6pUMfKwQ1eetkOcwW2TyiSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGjk+hKyeIxseMViYA28u8ZWZQqhiNJjAX6PPLTgkiE=;
 b=Rwdl20GsONgpDvso41HvngjFSOOZ/6PItH9GJcGUQ6IiqLWwRMnQ3Fo7Mh+JV1qMXSK5dt1u0yxe58NuYS3FtralDGM/0fcANsypqboarSPDtc2VycdMHpwtJ1GUfovVxUf6Y9LgcXhq9lQVawoaN/u/mEFbcm+zGn5sHn+YXSMZTcBwDNOOhnQ4JETvmKQvqk2YKMYkOT23P5lhgqrh3l8yeeXcY+7li6xOStUJKsq0Gp5DiLjv/v9NvQpfoXBa+aDM4t0W7yEyzFPnW+rjS7G2NKkBmcksDEcMbewn48mLxz4xrSppRd/gDTzZ8r1KOU11LErH2vXF5DO2XBZgrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGjk+hKyeIxseMViYA28u8ZWZQqhiNJjAX6PPLTgkiE=;
 b=U/1oCJWEgOZ26LdVOncI/Fp+WXFR7CSnqPRBUYdFSRW7c1fBgPYMxPR9XFy0l1CZeqJrFztWab1MjjFIGtkICDbSny7rNejKuQHsrf1nohW4bNT9/3qdt6+l6f+5wxfXj8lid1kRP7164OfuIb9FZhr9u74z8UlHgswvez62TOw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3413.namprd15.prod.outlook.com (2603:10b6:a03:10b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Fri, 5 Feb
 2021 21:54:04 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3805.028; Fri, 5 Feb 2021
 21:54:04 +0000
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     <sedat.dilek@gmail.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
References: <20210204220741.GA920417@kernel.org>
 <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <CA+icZUU2xmZ=mhVYLRk7nZBRW0+v+YqBzq18ysnd7xN+S7JHyg@mail.gmail.com>
 <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
 <20210205152823.GD920417@kernel.org>
 <CA+icZUWzMdhuHDkcKMHAd39iMEijk65v2ADcz0=FdODr38sJ4w@mail.gmail.com>
 <CA+icZUXb1j-DrjvFEeeOGuR_pKmD_7_RusxpGQy+Pyhaoa==gA@mail.gmail.com>
 <CA+icZUVZA97V5C3kORqeSiaxRbfGbmzEaxgYf9RUMko4F76=7w@mail.gmail.com>
 <baa7c017-b2cf-b2cd-fbe8-2e021642f2e3@fb.com>
 <20210205192446.GH920417@kernel.org>
 <cb743ab8-9a66-a311-ed18-ecabf0947440@fb.com>
 <CA+icZUUcjJASPN8NVgWNp+2h=WO-PT4Su3-yHZpynNHCrHEb-w@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d59c2a53-976c-c304-f208-67110bdd728a@fb.com>
Date:   Fri, 5 Feb 2021 13:54:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <CA+icZUUcjJASPN8NVgWNp+2h=WO-PT4Su3-yHZpynNHCrHEb-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:b8ac]
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::11b4] (2620:10d:c090:400::5:b8ac) by BY3PR10CA0030.namprd10.prod.outlook.com (2603:10b6:a03:255::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Fri, 5 Feb 2021 21:54:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44470952-473d-4c49-30fd-08d8ca208dee
X-MS-TrafficTypeDiagnostic: BYAPR15MB3413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3413E4E87E9D60A4D0F757DED3B29@BYAPR15MB3413.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: et99iTXiyQIt0w3h8f9PmEbZ3KHhIxevISfLPEqvZu1ezvPuuTP681S3f5GWqK83yxs3GK82H4OJBr+fPsrjaHuSJ0oY/eR+CT1TmnrJLYyu4FrFooXDmNpKJsVtmT8kJeKOEPWYDSSQaSYB5hhC9ZDtzQjHbmbP+ZxHeWXFCsfv4+isb+GxbDmIqWAtGM7AMSzuuwH6KpSJ8NDQhuCpvxlD6b4/FIe73wUQis4O909FBzV7Tp5IQDQPLrqhLeg3f9Ky/dvdRTMqjb2xLYAbFNAV3l1STsO6rAIVbl0j2QtatEYBaoGaH/g2Cc4ONhDfsyCKa/X8sZU+1dbr2o4rXP/4k2EhTSStWD91rEr7hSjCyF87USEJA4x3jgQLZKjReaPwM4QeF86N3D3d8+0b0z5/XjDjlGiXDrMM8rXc+Kp6YoyFaCkffwlp9nynaYsNEisAOI6eefWfimn2wv5Dgrlmi5L4AOsQ2bFbis34up0lGZMZPEMvt0R6ajCafzQR13wuyIFsYuoCnpaYs/Yr4V6f9eUlpHXIooqKZ7DzIbTVm94hhOOoIaQfUlwBZ8lQvHPoSKummZmpqU3j+3SVUTPmpUcB4Bqg83GWWsjXqEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(346002)(366004)(39860400002)(478600001)(31696002)(66946007)(7416002)(6486002)(36756003)(8936002)(52116002)(5660300002)(31686004)(316002)(54906003)(53546011)(2616005)(16526019)(6916009)(186003)(66476007)(8676002)(66556008)(4326008)(2906002)(86362001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WEhDVlVHUTFVSDZxdE1PV291bWxmTWZ5N0IvVHFJMStYZ2JUVmFQd0dXOU1Q?=
 =?utf-8?B?SkZGNGZLMmwydHhMRnF3QS9sRHVuMXY4RUlRR1R2N0M5L01JRlk5R2MyS2U2?=
 =?utf-8?B?RExsaFlvaHJRaGVPY0NHdFRwa1RWV2d6enBKV1FodUl6eWVHaFlpRHk0KzBn?=
 =?utf-8?B?eFhlVERoZTg3SUJ5bVJ2cS8zcWQ5cEhWdmdxc2gwK05EWmd6THlLNm5IWFc2?=
 =?utf-8?B?Y2dUeUlMUUorWkorZ29oeEM3Ym04OGVHaU5oVllqdXdEU3VYUTdtRXVnYzRD?=
 =?utf-8?B?aUtkNXo4ZnhjZWNJZy9qZTJWVnE1c3NmQzNIbmNjdlNUZWdKTXE5N3pZc0c2?=
 =?utf-8?B?YlFpTktib3NQZjBwdmtMUlZUYkF5WmJzM0dsZ2taOWc1Ynk1eGl6YXlyNE8v?=
 =?utf-8?B?dGVQTVlldzBRKzQyZ0NFSWQ2eXB2TDJ6MmtnQys3SGNWMWF6MEluQmxBbnpl?=
 =?utf-8?B?U3FQQXBNZG1TbWRGOWVVdzFqOXgzK0M3ZnQwRU5WVmFBUVc2aDZnTk1SVUo0?=
 =?utf-8?B?SFhIL1V1dGhzbXFqd0huenJ0b28rZE9nYzUvYWtqWE0zQmZJcUxCY0g1akxV?=
 =?utf-8?B?c2FRVnFBdkdwbExNYjQxS1dNdTFYdzhSMFI0clZxbWNrT0VTKy9wR2VuSVlS?=
 =?utf-8?B?cGI4eGZGYUQ3RzUydFlrYXQyUmxlWjFCYVJSakliOE9RaDAzajhoSGxsU3VO?=
 =?utf-8?B?UU5JdW1hcm9kbHU3MjNkbTR3MmRoRnBIUVJmZDlFaUhSK1Fld2tmVVRPMTZ1?=
 =?utf-8?B?aWN1K2tXN2xNby8wVEluREV0TysybTFYcC9OV0JEU1UyV0hjYkNLaHJwVTBR?=
 =?utf-8?B?SHdtUjBuMUYvcmo2aUxpcjlSSW5IeW83aDRUeFNKaHNiTzdQLzduSFNhWEE3?=
 =?utf-8?B?c1d1SXdZalE1YytSWENBMWVXMHRhRXNoZG1pL3lSZG9QVFRHV05DZjVtaGpw?=
 =?utf-8?B?aDRROHk0TkExWnRRUTAwcGZoWDRYWXZaVkxiZGVTVzNuQ3lmOHJEZnRCL0Fq?=
 =?utf-8?B?WjlWRm42REtPZi9MdmhzMHhLQWtwRlEyTUpvdUZUZ3ZrY3pSNnVQYkpIOGVN?=
 =?utf-8?B?R1RBNk8ySjhrRW9GWGx3THA3ZEJIYWFjaXp1L2VHekZSOVdGMGV6M2tqK3hL?=
 =?utf-8?B?OEw3dk5IbHIrSlNPZWNwSk5jTS9WOEJsUHJ0QTF1OUJjZ24rQm9CWmpVbWVS?=
 =?utf-8?B?aTArYkY1MC9VVHpHZ0ZiSmdGN2c5Qkg3RWg3SWhxeGQrZy9Ua0QyUnA1STZ2?=
 =?utf-8?B?NXBtUlZkaXc5RHE5bXl4N21uMjlWaXlLa1RQWlpzbjhscWtmNWJueUVkcGpX?=
 =?utf-8?B?aDF5RnZZQktpVFY5YVc0VjJyc3VTY3hZbEgvL1hBenQ3Z3ByRXc4RjRNN0ZE?=
 =?utf-8?B?WTdyZ2JyVk5sSmU0bFhUNHN2QUtLY3NhaHR5SU5OYSt4UVQ2T2xFRUprSU8r?=
 =?utf-8?B?QVRJaUxGS1R1L2F3MFhuM3hSRWFPb1dvd1NJcVE0enMzR1V4NUduTHdwaDhj?=
 =?utf-8?B?czQ3NFo4QmlYWmRveU43aitnNXdpdmpnM3kwZkU0elBlR3lnZ3dyT0xBMjhp?=
 =?utf-8?B?dktIUVpHVDh1VHRqc3lQRkt3VjlZZlpLSDRjN0dHK1hCRVNkRUFCY0Z2SkpK?=
 =?utf-8?B?Rm1XTzRWYW53OFFjNnRCb0hzajFCOW40SENZd3hBdzcxTjlzaEQ1VmZRRGlI?=
 =?utf-8?B?dzJIMUR5dWl0Y2w3cElvVTJkMnBmKzVmd2x0UUlGbEp0NWFOMHVEak1IL2Q4?=
 =?utf-8?B?WkNBY3Q4SEI5Wk1iTlhlSGx1dEJMT0hWNlZURHVIcElCeERHTVAzY293UFhE?=
 =?utf-8?Q?yLaIWnEbZASSDJPI66QDgqpAT82wMqFKw+ZVU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44470952-473d-4c49-30fd-08d8ca208dee
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 21:54:04.3016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NGqhBbeFhasFb6snPStP3hCDxb83p8k4RNRzsEVRnXL/yRhUbpLJgdP2yzjuslR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3413
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_13:2021-02-05,2021-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050135
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/5/21 12:31 PM, Sedat Dilek wrote:
> On Fri, Feb 5, 2021 at 9:03 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 2/5/21 11:24 AM, Arnaldo Carvalho de Melo wrote:
>>> Em Fri, Feb 05, 2021 at 11:10:08AM -0800, Yonghong Song escreveu:
>>>> On 2/5/21 11:06 AM, Sedat Dilek wrote:
>>>>> On Fri, Feb 5, 2021 at 7:53 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>>> Grepping through linux.git/tools I guess some BTF tools/libs need to
>>>>> know what BTF_INT_UNSIGNED is?
>>>
>>>> BTF_INT_UNSIGNED needs kernel support. Maybe to teach pahole to
>>>> ignore this for now until kernel infrastructure is ready.
>>>
>>> Yeah, I thought about doing that.
>>>
>>>> Not sure whether this information will be useful or not
>>>> for BTF. This needs to be discussed separately.
>>>
>>> Maybe search for the rationale for its introduction in DWARF.
>>
>> In LLVM, we have:
>>     uint8_t BTFEncoding;
>>     switch (Encoding) {
>>     case dwarf::DW_ATE_boolean:
>>       BTFEncoding = BTF::INT_BOOL;
>>       break;
>>     case dwarf::DW_ATE_signed:
>>     case dwarf::DW_ATE_signed_char:
>>       BTFEncoding = BTF::INT_SIGNED;
>>       break;
>>     case dwarf::DW_ATE_unsigned:
>>     case dwarf::DW_ATE_unsigned_char:
>>       BTFEncoding = 0;
>>       break;
>>
>> I think DW_ATE_unsigned can be ignored in pahole since
>> the default encoding = 0. A simple comment is enough.
>>
> 
> Yonghong Son, do you have a patch/diff for me?

Looking at error message from log:

  LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
.tmp_vmlinux.btf
[115] INT DW_ATE_unsigned_1 Error emitting BTF type
Encountered error while encoding BTF.

Not exactly what is the root cause. Maybe bt->bit_size is not
encoded correctly. Could you put vmlinux (in the above it is
.tmp_vmlinux.btf) somewhere, I or somebody else can investigate
and provide a proper fix.

> Thanks.
> 
> - Sedat -
> 
