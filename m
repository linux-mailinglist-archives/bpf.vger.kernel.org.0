Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A6F3521EF
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 00:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhDAWAD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 18:00:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1182 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233974AbhDAWAC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Apr 2021 18:00:02 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 131Lkv2l014214;
        Thu, 1 Apr 2021 14:59:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GeBYvL4idAkupuV8FG/sv0Ek8Df5YtueyV0koOLM7VA=;
 b=WxCKzvhydMU30SVeCuDCNyiUlVQtUsFmDHStfAV4aF1jISn9IeXV0kmt3IUSv4WXlpjx
 8sAZl8KnfgiTlAQIZdsGBcN2OVTVwmY4s+Lgohw976sMrfRsQyb7wCbcdfISY4pB1bM3
 aw0LAtqv/j3K0zOcW+xZlfaxtAFpVSrhmM0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 37n29nejw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Apr 2021 14:59:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 14:59:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsECPGzO5fw0uDfprRZvc/fK6vdpVQ2MCzy024+HHlUCphlN3yQ+oFFAzW8JaWmtwFUJBEe8pJqSJemEQic22TM6kDtepzkSjGl9eHVtV1lvMS0erM0KmGwOwBO3vrXfgoJhicI5HFZzLspV7Nki+/NsSA5USe2uTi7OVp9cgTKOnuY1PeiXxTOgP4ThqNhfLaw6HX0jwJNGSKBCBU8Bt00nT7VKNEAqWidyq7VxwLgBQvFEhGIxjfRr5jufNQy4JPt8RWYsLGwAn8C16O11MipRWK9YDdIVqURxcx0D8pPPL/L8lMOrbQzi++mocVzbNyc+NXjSEL2G3ROBsJ1d7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeBYvL4idAkupuV8FG/sv0Ek8Df5YtueyV0koOLM7VA=;
 b=EeMmIciVmpHBYpekYhl1aBqfj3hViBzz+jolOQtM7UVLOpro0ATMi6qFVns04clNolWEdebKCtuNmNbTp7n5khxWn4tZh0aDAfEm5Cp3Xu9CUm9MoL5jFfj5ux8b8oXn3hxvL6JCRmN9Tt38xQpT+yGuWNwKhc7PHaHAfxBg25UjBbogD5eV+ys3ohn0cjybN/B6aksCncpu3uFeYX/oOI0YaSResGgMneXHmP/YhFnexn/KtMYSefILzC0wOrzaG00jMKn+L53nkXMC86CJwstj/XrjenM8lqg3roQP10PLsM3K93kVuwa57H4IR7eUaeIJUzazDE0fL7npkTklbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4498.namprd15.prod.outlook.com (2603:10b6:806:199::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 21:59:56 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 21:59:56 +0000
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
To:     Bill Wendling <morbo@google.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>
References: <20210401025815.2254256-1-yhs@fb.com>
 <CAGG=3QWpcCG7b70oQsRTATgt10acEFS=-Tg9U=DHZ6xoS3GeMA@mail.gmail.com>
 <CAGG=3QUUYn9K7zVQ1UVZ57_FFeiiOexwq_OgDw9VFPJD3fFbVw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <06ba2ed4-2730-9ce8-0665-3c720bc786a3@fb.com>
Date:   Thu, 1 Apr 2021 14:59:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CAGG=3QUUYn9K7zVQ1UVZ57_FFeiiOexwq_OgDw9VFPJD3fFbVw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:fb66]
X-ClientProxiedBy: MW4PR04CA0371.namprd04.prod.outlook.com
 (2603:10b6:303:81::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::17eb] (2620:10d:c090:400::5:fb66) by MW4PR04CA0371.namprd04.prod.outlook.com (2603:10b6:303:81::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Thu, 1 Apr 2021 21:59:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1558a0e4-bcb0-4581-764a-08d8f5597ca3
X-MS-TrafficTypeDiagnostic: SA1PR15MB4498:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB44985FFBC57EC75A2935F697D37B9@SA1PR15MB4498.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XpZ0T4qW7KGCtLNwA3+FeQU7dF3rq8fQHgdPdS2rkwJ7uGabevcMV8jGda9jMe5iNew8p1e8IRsOQqF58walIeMj9AiwFFH8VpIRnQ5RyuH6Qg4y+QxsedSkDaIOK1SQ7Tm1G7SPjueuzX2rEBhd48pqM3okASDZzjEdb2j3Vd1R8VoV2TVy4+5nx22+YVJWmvFcLt2tj1Z42MRL4GTgFmfAYVYYtILE50xXeaGUihiwj293YdmpSdshHR1vSQ+R2RY8SgJegjvFvqrvLVXMLpAPew+znQ48CBV9MRBVh6gYIg+CrrVVNvR6SaRJWNRd0X9TDE0lhGLfYFWCFVN9BEDJA1HtzVyu6RIxnY3fkgrkJdI0tBnbkj/96mWDaNzmRRw6apBJNIp9vnl9zHTGOIUP3Et9gYQzYon1vnvXCCFByptDO1vUrcUpSoJRia2VPZYzVVrHhQZ21i19VafBwC9FkB8iG6gieUiGkPbBRFV+uyW9aWfh8v+wj3EuW4sGsFtJYffo8+yVPGD45AYwEe8Jysvg9QgRWTtymECrmBXuuZUnaGtGmVGO4cpRpLGsO5BdZ+dFMqxxMI6VxAW8G8ZFoIrlb5dLDKrgMSi/WYtfQfu7JxpDhmQRtwRq/z5itpwNbEv+4RcsCDL3DjZ7xNQbW7fUwVXKJg38hziDNpluMOOBmzrfkvvxCBMmv+079PYqcmFAwT2rLcFcJ2lc24hD+JrDCjNgJplzRLQewIesyvY+zCjqjYFGHQC0S67A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(346002)(136003)(376002)(38100700001)(66946007)(478600001)(36756003)(16526019)(66556008)(66476007)(186003)(4326008)(2906002)(8936002)(6486002)(8676002)(316002)(6916009)(5660300002)(31686004)(52116002)(54906003)(86362001)(83380400001)(53546011)(2616005)(31696002)(101420200003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WmZkQklwa2xDamFwdzEvZGtwNTJ5aEEwd2dSNjU5bk1MeHVsazREZ05nQUVu?=
 =?utf-8?B?NVArYjJ4TlNUeWE2MndiVU9tZm5GQW5zK01sRUhXSGxwdjNNVThKSGtHeXdq?=
 =?utf-8?B?RXN2RXM2TG80R2QxTklRT1JVRWlGSk1wU21xTnNvZEJpVHZpblZwVVlVcXRK?=
 =?utf-8?B?UVZRTlc3VFZkbnoxZkpOS29qeDB4aENicE1mTlZDVklNSW9JL0JHS2tsMG9p?=
 =?utf-8?B?UjhidytvbE1ybHlBTll5aDNVbGlyOGFZUi96N09QL3M0MjFmeHFyQk82dDN1?=
 =?utf-8?B?OE5TSmM3SkNnWllHMm5IZTRORi8yeUVVM3dMd2w5YmRMOUtORzc3VFRGNVZ5?=
 =?utf-8?B?MWdzTWdsdnpwRGp2VzhUejNML1FSa3JtMUE3V3ZUL3ZJQ2p1aDg4SzFpMFdK?=
 =?utf-8?B?NVBMVUYyOVRTNTFuWjBLNWxyN2I4QWxJWUE0Wm1ya0RBa1UxV09FR3RsMFJR?=
 =?utf-8?B?UG9EV2pRUW0yS0ZVWjg1bjdDeFFSOHpVUnU1RFh5UVpjUXZUWklYMEx5eVRV?=
 =?utf-8?B?Tmc1VlFrL1F1eFhnb1p3aisrQ0UwZFJhWk5kOHpiU0hEL0ZqRGgrMlorTjJq?=
 =?utf-8?B?bDVvVG5RWGpCekR2cUNkaVNsbzRENXUrUi95eWNrVldpeTFFaTNYNmM3TWN3?=
 =?utf-8?B?TEVyaWoyVE5CQkZ1UE45QjgwMU9PZExwc0NzSXNySVJQVzZ5NDVZTHhGbzZY?=
 =?utf-8?B?REtNcVhKbUtYYUFwVHowYW1lMVFCMVB6M1hrSDVwVVcyeHhZY2JiaWNGblRH?=
 =?utf-8?B?ZHpTL056QkZrN1YrcjhHM1NiUCtBVjREWlpWVmxJdWt3QXRFMGdlbEJKVnU5?=
 =?utf-8?B?OGQzMVN4OXd0YkRTcmFSbVRmbTVHdWNGVGxKWFphZWlzTmhXN3I4bkIxMGJF?=
 =?utf-8?B?bWdFcFVwRE1iMTRORHdETU5tZ25ZR05IMXhkVFVpZG4zVVNMLyt1Y0c1a2Ri?=
 =?utf-8?B?clVEZ1hmeE9ZUEpqSWkrdWFGZ3RLU3VvRDZaRDdlYlNuNDZ2cjcrREVOalBl?=
 =?utf-8?B?bEVPY2M2MTU2dWVWTFVWQ1JZVHdpMXR4TmI4WlNBN1dNbUxWeC9sY2NSMVpl?=
 =?utf-8?B?THhNdHI1d21keWpmZUErOCtWMStYb3VJelF6cWM3WWErU08wcGtKVVJlUzJP?=
 =?utf-8?B?UmMySldubTRQM0xHbDN6TGJRUm1zRkQxVTZoUllZaUVvMkppdWl0bFdKeVVW?=
 =?utf-8?B?ZFMwbUsyWGo2cU5FQ2paZ1dUTEQ5NFZTclVweCtNc0w4OWlqdjU3WGhuYmxz?=
 =?utf-8?B?M28zMFJsa2ZDd0NwTTNwRW5HZVlBcFkweS9tODgrazRGdGFmMUZyTXZpUDBa?=
 =?utf-8?B?TkhVNXFtVk5DbzVGMDE2NGhBZmtkQk52ZjRUcTJ2UTZyWmdibFdFWHRGUW9E?=
 =?utf-8?B?Rlh2dGFHNkJZSFBkcW0rMU1MdDM3aVJPT3lpRk9BTVF4bW0vb093eEdwZitw?=
 =?utf-8?B?dVQ4ZHZSOWFzUHR2Sm5TWVRTaVh6c3JNQjRtTkZSN0RqRHVRU1FPU2JmWlVq?=
 =?utf-8?B?OGpEY3o5WU0xWXRUajVuNHlxQndrUlVLcEpOUW5VNk91YUpORkJucm1XN1ZL?=
 =?utf-8?B?QTNtNVVTdDZQdUE3dGNXMno0ZHZRQlFCSEgzcTZNZXgxbko5WkRlTHNxYnhC?=
 =?utf-8?B?MEpKQk13NXMyQUlSSWwwb1JCQWN0V1dCUG4vSVBrQTBMQVBoV3RhSVVHa2Iy?=
 =?utf-8?B?aXd4K2hhR1NSdFlhVVR6c015K0o5RXR6cUxuTFYrKzljOEFjOCszUnQva1pq?=
 =?utf-8?B?bjY5eGE3TGFaZHBRalUxOW5EMHBoOEVBd3VZT1g2NGU5cFBuM0RKQ3Zob2tm?=
 =?utf-8?Q?LIrrEItjg2sqwKBvtjM/QzxTR9cxgLtgnfwGI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1558a0e4-bcb0-4581-764a-08d8f5597ca3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 21:59:56.6356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bk+8JxcAqgZ1we+NUy8o6QGJwbNhDWVEfOFf42D+m3ec0gIyFODcvASVpxcffJjE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4498
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 86nW83v1HZb1Z6tG3Hpb8qHYPsWmh5em
X-Proofpoint-ORIG-GUID: 86nW83v1HZb1Z6tG3Hpb8qHYPsWmh5em
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_13:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103310000 definitions=main-2104010139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/1/21 1:56 PM, Bill Wendling wrote:
> On Thu, Apr 1, 2021 at 12:35 PM Bill Wendling <morbo@google.com> wrote:
>>
>> On Wed, Mar 31, 2021 at 7:58 PM Yonghong Song <yhs@fb.com> wrote:
>>>
>>> Function cus__merging_cu() is introduced in Commit 39227909db3c
>>> ("dwarf_loader: Permit merging all DWARF CU's for clang LTO built
>>> binary") to test whether cross-cu references may happen.
>>> The original implementation anticipates compilation flags
>>> in dwarf, but later some concerns about binary size surfaced
>>> and the decision is to scan .debug_abbrev as a faster way
>>> to check cross-cu references. Also putting a note in vmlinux
>>> to indicate whether lto is enabled for built or not can
>>> provide a much faster way.
>>>
>>> This patch set implemented this two approaches, first
>>> checking the note (in Patch #2), if not found, then
>>> check .debug_abbrev (in Patch #1).
>>>
>>> Yonghong Song (2):
>>>    dwarf_loader: check .debug_abbrev for cross-cu references
>>>    dwarf_loader: check .notes section for lto build info
>>>
>>>   dwarf_loader.c | 76 ++++++++++++++++++++++++++++++++++++--------------
>>>   1 file changed, 55 insertions(+), 21 deletions(-)
>>>
>> With this series of patches, the compilation passes for me with
>> ThinLTO. You may add this if you like:
>>
>> Tested-by: Bill Wendling <morbo@google.com>
> 
> I did notice these warnings following the "pahole -J .tmp_vmlinux.btf"
> command. I don't know the severity of them, but it might be good to
> investigate.
> 
> $ ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
>    BTFIDS  vmlinux
> WARN: multiple IDs found for 'inode': 355, 8746 - using 355
> WARN: multiple IDs found for 'file': 588, 8779 - using 588
> WARN: multiple IDs found for 'path': 411, 8780 - using 411
> WARN: multiple IDs found for 'seq_file': 1414, 8836 - using 1414
> WARN: multiple IDs found for 'vm_area_struct': 538, 8873 - using 538
> WARN: multiple IDs found for 'task_struct': 28, 8880 - using 28
> WARN: multiple IDs found for 'inode': 355, 9484 - using 355
> WARN: multiple IDs found for 'file': 588, 9517 - using 588
> WARN: multiple IDs found for 'path': 411, 9518 - using 411
> WARN: multiple IDs found for 'seq_file': 1414, 9578 - using 1414
> WARN: multiple IDs found for 'vm_area_struct': 538, 9615 - using 538
> WARN: multiple IDs found for 'task_struct': 28, 9622 - using 28
> WARN: multiple IDs found for 'seq_file': 1414, 12223 - using 1414
> WARN: multiple IDs found for 'file': 588, 12237 - using 588
> WARN: multiple IDs found for 'path': 411, 12238 - using 411
> ...

I didn't see it with my config. Maybe you can share your config file?

> 
> -bw
> 
