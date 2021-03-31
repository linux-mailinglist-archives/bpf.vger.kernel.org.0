Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895FD34F741
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 05:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhCaDOY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 23:14:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55308 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233072AbhCaDN4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Mar 2021 23:13:56 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12V38hbg012179;
        Tue, 30 Mar 2021 20:13:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=b7wva3QuDHJevGdRaMwOt9DAL4E0EZKD9BiyRn+qP3E=;
 b=cTgBc46F/WQ6trcMWuEJ18HYrjQjGQIrRgm+FOZMYkfc9iq99z035kcUW4tqFJIP+3HJ
 7siCEpWKkXJuea541SmMuvuF/nFWexISL1CNAISDVid/0rwtNR2+54hYlz21A3z5rULM
 4h5M9fFK20gCvvwX4vOOGZUe4DS//wjotvg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37ma9rsuah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Mar 2021 20:13:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 30 Mar 2021 20:13:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiEEAvUgMMcwvWvB/9ohWh11A1wDdRaGrfX5tBngDa2EgzzmIXgw2/tgl7hm0mFYJkpexPYQrQLmpuGHbUAKmFCdbPOWPNxfUvD+xycktlOAZjxenVTIn0B7geQyGT83ywQ4aGbZPmMD9XHlklz86z8ltknvnqOj9mZfoed8eNSSfdu4Z9ZwCZnv+sGTdIK2Y1OFsGkGkeE2ePB6OBzdNGXAbRSFyTGfDL9CxwEDgZi6xlv/0vfi3IGy0MuM9GTiI81tNvx+WpCkulzA/JtH64b0ouIiN5rGezzP0tkpi262FBPKMSeFkT1ON7Z9NtTbGc+QVFnQnIwJjVC9P/+vXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7wva3QuDHJevGdRaMwOt9DAL4E0EZKD9BiyRn+qP3E=;
 b=HKJStoCSKZDfYaOA8WpoSCyTeMJ/qvcyqfGksgyCyPXuMBKZNSLzhxJbqO+qrGQU3RCqKy+CmpRIIQc+NbQqbgmp5lB60zyxKQSH5LOQwLQIlCZpnvsz/KKI4U0S2wp0PsifuXfItbXQ5fNRy1REQwYeI1jrOk26yHwP+AGfJKR+F/NmEFqY0WRq9Oo/eQMzyCjomsq55gdymqSlpELFwtxen6tYVbiSRJ45gUwhEx5ILPaGpwH3q7diPLGrNk7d+aBNcb3h0aeJPc32JOhfY4Tm99xXjql8K0lZ7zqZLcZOcf8eHpg/jmZDWlDlHMIbjTRiYmgFS7b19WlRKbe7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3968.namprd15.prod.outlook.com (2603:10b6:806:8d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 31 Mar
 2021 03:13:38 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 03:13:38 +0000
Subject: Re: [PATCH kbuild] kbuild: add -grecord-gcc-switches to clang build
To:     David Blaikie <dblaikie@gmail.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        <kernel-team@fb.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Bill Wendling <morbo@google.com>
References: <20210328064121.2062927-1-yhs@fb.com>
 <20210329225235.1845295-1-ndesaulniers@google.com>
 <0b8d17be-e015-83c3-88d8-7c218cd01536@fb.com>
 <20210331002507.xv4sxe27dqirmxih@google.com>
 <79f231f2-2d14-0900-332e-cba42f770d9e@fb.com>
 <CAFP8O3JjU26pNKhFE2AniP-k=8-G09G2ZXc6BXndK9hugX-0ag@mail.gmail.com>
 <CAENS6EuKv9iWLy24Gp=7dyA0RHNo9sjORASAph4UWLXvDWB+oQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d34a3d62-bae8-3a30-26b6-4e5e8efcd0af@fb.com>
Date:   Tue, 30 Mar 2021 20:13:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <CAENS6EuKv9iWLy24Gp=7dyA0RHNo9sjORASAph4UWLXvDWB+oQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:d5a5]
X-ClientProxiedBy: MWHPR1701CA0020.namprd17.prod.outlook.com
 (2603:10b6:301:14::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1120] (2620:10d:c090:400::5:d5a5) by MWHPR1701CA0020.namprd17.prod.outlook.com (2603:10b6:301:14::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Wed, 31 Mar 2021 03:13:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20c8023b-e188-492e-767b-08d8f3f2fa49
X-MS-TrafficTypeDiagnostic: SA0PR15MB3968:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB39682779A6E7D4F001FC8FCBD37C9@SA0PR15MB3968.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcMDNTXH6RrNXvK0REdNCvpkYGHk0k8YmglPIDNy4m6bc/puzAI/ubLThhMLIZOjsRYgef6Kbq29lVqyscd6YNcu1q+uU+8Ki5y6zuVhf2+yyCNMjEtn8rmINWelvvMyXnSc+ulDQ2I9scpk9mhEAVJAtPA3LFrE606Iiqm/cPCosU7zl5JtsvQb0fjPkS5hdLVv7RTN+th2bkJmhPbFMPpWQXUyVhBlwfXlzdX7xn+qE1i9rhcoWDa/V0DT3GMExhkFgMJdeVeUSWArdTkrbwdHaavBCPNrMWRN2SGMMiGYzP30hUsrRXXidvanhvkoZUorDDKJvZwoAiXG8O7lFIYDmceHbBJ0nvx5kQnDHliqacZlT88RURjAIvPQHSiedOOj+fQ3v1eXfABeyBD8q8CRh20bA+jaQk3RKsZSN50C8SDxRTI0kscqfu7EVBYX4GoczwJLWIKEKRNf8j5x0H66ZR0uruP+py7K3YYsvEFf4FE/rwDzq25VrOR3T481hHT+udLXqxQ0EPr1n2yQD5k0CRawnzwMPfMo2bTBMb4FuPL70/BfYwtGq6gFxISBfoHj1KPzBavgFS/e1d+8Fw9CqIAg+3qJrs9rg6VkKGd5czn0kMnN3WD6nbXjEFDeXnJ+cXqm4/xzYKLaulwhoJ55FHBCnNznifpPG145vNQAHoqmo1mI4knVd8DpP1o2tLLyqMbQutSKl9ZLwrdq4vwUMSCfhdRR204xuXcBjcCRLSlEa1fENDgIDD5y6heyLnDC3bfDB/7piDccxDKbZrInp+APdK/L+1A1Jpyxg/SR2aQ3JVjoTXnCdC3fDfJv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(396003)(376002)(39860400002)(52116002)(31686004)(66574015)(54906003)(86362001)(5660300002)(110136005)(8936002)(7416002)(2906002)(53546011)(83380400001)(31696002)(8676002)(16526019)(186003)(4326008)(66556008)(66476007)(38100700001)(478600001)(36756003)(966005)(2616005)(316002)(6486002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Mk4xdWdwUU5tVWUzVzRmMVQyY3RjbHlMdnRWbUYzSUNhYmttaHF6L1h3bk5C?=
 =?utf-8?B?QXhPTEY4T3FaSk1PWmVGMU8yRFNTUE92NGFMRGcxY2YxdFQyUzZEL1VvLzk4?=
 =?utf-8?B?d0hOR24yUjZYek9xUy9IS0NlbGZvRG5VcmpqMWZXM3ZiOTlvaDZ5eGdjdU9V?=
 =?utf-8?B?UlMwVTBjZGJvTHRNYUFrVGhpZzdoeXR4VnF6TUw1TERUMzhRa2N1Y2UvdDVR?=
 =?utf-8?B?TGxvYVo2aHhLRXdCeEFrWjJjTnFpUXN5czhocFRmWDREQjNUOXovK0Nab3Jq?=
 =?utf-8?B?a2xOdy9NSzJLZ2dDVU5MOUx2MkVjaGoyZVpUVm84a1FYTzN5NDE5K0FhZUJj?=
 =?utf-8?B?MjNobjVwdXV6UUNvM2V4d0lTRTBKRi9HcjYwMkhEQjlnRVhBcnRyelBrdlVF?=
 =?utf-8?B?VjIvVnlBS2tRWkNOSm8zSGszTE1KRTkzeDdtTCtNb3ZTR0lmV0RwdHNpL0g5?=
 =?utf-8?B?MlFzM2xDRTFRRi9tRHNob2l1U2ZQalFUeVlSN3o4bDRqcVNaeGhabDJ3YllS?=
 =?utf-8?B?UGRDSEZMQ1J3ZnVIZUc5SlhZeTlxUmVScVlkWmV6T3VlZHhKY3RZV2xaR05i?=
 =?utf-8?B?Qm9JdDlKdHZZcTQxSFptaXppZ0tPWElpTzVaTzVML0hkWHVVdWgycHJJR1BY?=
 =?utf-8?B?czdXZXZrVmZUNWJDSzhZeVNXOHVuVUVPd2twd2o2QTh0dlJOYTZlbW5FOVFk?=
 =?utf-8?B?ZEpKL1RMZ3ZLK296ZTlpU1M2N083a3UxTlBnbGNGRWppTUtBd1hndlhpaXBp?=
 =?utf-8?B?U09udmluYm80ZHZIUkg1bUJyQUZpbDVXRGJBblJGYXJUc2JrQnFzb2RGcEJB?=
 =?utf-8?B?WVBKbzJJNVFZSVNXNXRLZlpLbUJzV1FMbVlIVVBHK05lZTNORUF6R2gyM1VT?=
 =?utf-8?B?bU9tVjJkLzJLTXU2UklPYnVJZUJpU0ErOTdNbk0vNmZkbjk0eU9HYkU4ME83?=
 =?utf-8?B?K1JNbGpURndsZUR0bU40QmxTVTI1UDZSRkZFQkdQdTRLRUVmZUlsVGpJVFZY?=
 =?utf-8?B?Sy9PTHpGOEI5cE5XR3ZMM0tnTzJqRTlXajhCWHQrbGZRYUNLdUF4SzROUGIv?=
 =?utf-8?B?WDBDVWFFSVhBR3BYYU4rTkVlMjhlelNTazhLM2k4dE5BQUd5MEo5ajcxNFJT?=
 =?utf-8?B?UnY0cVFKekc3NmFUQ2tMQWJRMDRUUk5RQ1pwSVdNL21qMytJRWk0R3NBV20v?=
 =?utf-8?B?alFjdVhuWC9GWFpZQTZxelR0a1VRb1NOQlJNMDNwTGdVNndIZVJaNzZZb1dL?=
 =?utf-8?B?MktKMnYxNDh6eCt6Q3pMTG90Tzc2RGkwQTFtR2xXckhqajRrbzkrbzBXaFlR?=
 =?utf-8?B?cnZkdWpxWEpGN2JzUmFETDRkalhSMnBsSWwxZ0c0Q2hzMUtOZm1XV211QXMw?=
 =?utf-8?B?b253bS9PcTVBS3ExVHFoZEpKckhMTW9ZY3Y4SFJxTnBMc1dTbkRNRHdzbUpo?=
 =?utf-8?B?M0FON1NFYWN4bStJaHpLWEE5U2NqSzI1YmdCVnNpYStML0ZDcStlWEZkbFZW?=
 =?utf-8?B?Nzg4UHJBTGY5eVZsQjBIMjNMR3gvbllIRytCS08zRkM0OHVMb2xUTC85ZDB3?=
 =?utf-8?B?S0hFemE0Y3hiKzJKWTJCYU9KaDdSSklueDRZTFhGOWI0dGE1TE00bU56djBS?=
 =?utf-8?B?RmliQWhnRVR6MkZOajI5a3V0Y3I0ZTBCWHkvSlVQcEdaWG5EN2pZdDUzMG5v?=
 =?utf-8?B?aGZIQ250SFZrekFPb1hKRld1YktIZ0h1UGVUZXdDR2J3MnFtZHkyd21Pbzlj?=
 =?utf-8?B?Mk92eFMxMzlaT0EzSlpKVk13aUw2a29Hbnd3cEpaclh2dzk2K28yY3cycGRQ?=
 =?utf-8?Q?/SHwNG/EI63bqZWC2/O1ZOziHCR3TUEpzoAeY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c8023b-e188-492e-767b-08d8f3f2fa49
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 03:13:38.0928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoRNZWugPvxOvSYxzEn+uLaHMX8s7FWwOO+mwht2MW8ZgFp5iM0QgZ/Yjzs3/lz0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3968
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: qvvxRYojvLyV5j-1rq92fAfH6tbFSv-X
X-Proofpoint-GUID: qvvxRYojvLyV5j-1rq92fAfH6tbFSv-X
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_01:2021-03-30,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=760 adultscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/30/21 7:51 PM, David Blaikie wrote:
> On Tue, Mar 30, 2021 at 7:39 PM Fāng-ruì Sòng <maskray@google.com> wrote:
>>
>> On Tue, Mar 30, 2021 at 6:48 PM Yonghong Song <yhs@fb.com> wrote:
>>>
>>>
>>>
>>> On 3/30/21 5:25 PM, Fangrui Song wrote:
>>>> On 2021-03-30, 'Yonghong Song' via Clang Built Linux wrote:
>>>>>
>>>>>
>>>>> On 3/29/21 3:52 PM, Nick Desaulniers wrote:
>>>>>> (replying to
>>>>>> https://lore.kernel.org/bpf/20210328064121.2062927-1-yhs@fb.com/)
>>>>>>
>>>>>> Thanks for the patch!
>>>>>>
>>>>>>> +# gcc emits compilation flags in dwarf DW_AT_producer by default
>>>>>>> +# while clang needs explicit flag. Add this flag explicitly.
>>>>>>> +ifdef CONFIG_CC_IS_CLANG
>>>>>>> +DEBUG_CFLAGS    += -grecord-gcc-switches
>>>>>>> +endif
>>>>>>> +
>>>>
>>>> Yes, gcc defaults to -grecord-gcc-switches. Clang doesn't.
>>>
>>> Could you know why? dwarf size concern?
>>>
>>>>
>>>>>> This adds ~5MB/1% to vmlinux of an x86_64 defconfig built with clang.
>>>>>> Do we
>>>>>> want to add additional guards for CONFIG_DEBUG_INFO_BTF, so that we
>>>>>> don't have
>>>>>> to pay that cost if that config is not set?
>>>>>
>>>>> Since this patch is mostly motivated to detect whether the kernel is
>>>>> built with clang lto or not. Let me add the flag only if lto is
>>>>> enabled. My measurement shows 0.5% increase to thinlto-vmlinux.
>>>>> The smaller percentage is due to larger .debug_info section
>>>>> (almost double) for thinlto vs. no lto.
>>>>>
>>>>> ifdef CONFIG_LTO_CLANG
>>>>> DEBUG_CFLAGS   += -grecord-gcc-switches
>>>>> endif
>>>>>
>>>>> This will make pahole with any clang built kernels, lto or non-lto.
>>>>
>>>> I share the same concern about sizes. Can't pahole know it is clang LTO
>>>> via other means? If pahole just needs to know the one-bit information
>>>> (clang LTO vs not), having every compile option seems unnecessary....
>>>
>>> This is v2 of the patch
>>>     https://lore.kernel.org/bpf/20210331001623.2778934-1-yhs@fb.com/
>>> The flag will be guarded with CONFIG_LTO_CLANG.
>>>
>>> As mentioned in commit message of v2, the alternative is
>>> to go through every cu to find out whether DW_FORM_ref_addr is used
>>> or not. In other words, check every possible cross-cu references
>>> to find whether cross-cu reference actually happens or not. This
>>> is quite heavy for pahole...
>>>
>>> What we really want to know is whether cross-cu reference happens
>>> or not? If there is an easy way to get it, that will be great.
>>
>> +David Blaikie
> 
> Yep, that shouldn't be too hard to test for more directly - scanning
> .debug_abbrev for DW_FORM_ref_addr should be what you need. Would that
> be workable rather than relying on detecting clang/lto from command
> line parameters? (GCC can produce these cross-CU references too, when
> using lto - so this approach would help make the solution generalize
> over GCC's behavior too)

Thanks, David. This should be better. I tried with a non-lto vmlinux.
Did "llvm-dwarfdump --debug-abbrev vmlinux > log" and then
"grep "DW_CHILDREN_no" log | wc -l" and get 231676 records.

I will try this approach. If the time is a very small fraction of
actual dwarf cu processing time, we should be fine. This definitely 
better than visit all die's in cu trying to detect cross-cu reference.
