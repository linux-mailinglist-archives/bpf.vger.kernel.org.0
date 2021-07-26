Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB283D52B5
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 06:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhGZEQM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 00:16:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30986 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhGZEQM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Jul 2021 00:16:12 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16Q4tocm001972;
        Sun, 25 Jul 2021 21:56:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=QAGCEGpixwQsax5NIsIrTwly6TzXvLUH7XO+YxhXm6w=;
 b=d06HMD0sgMF6VDhB1HAddWcqjAuEtAfYwnO/OVLKG60PbBJRP9AFncF09prOkRKze0DZ
 1xiiNcm9lmDTfPWmuoTZfj5/fHh0gN+6CTPoatnSAd2ITDgoPeGbP/3IYvjtH1lCcmuE
 NimCMgGTkSMGr+PWluc/D+4x8Je+NIMLfjE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a0gpw7dam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 25 Jul 2021 21:56:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 25 Jul 2021 21:56:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXfSQ+YIW4v0nQa73lDXoGt6rS6IL0nSF3VFlbCWZYTxt1Bbup0RPGpXDYPJ2OvoDDKYg38dRCUbFdVO+hFC5+IfobQQbcbU7Yoa8lkcyWqphZaC6WeOrxjYLaxx4mgpcTLbU5oLOxTx6I6WsNZPkTA8aJX96HwWR/QI0iW7JNrHmRIUKQlqhF1+M5YVt4ADdQ+9pzCLD0KxsRt1bJgsjWcyvHgBxrCj/NgpCQ1mIYDmbvoWzNmEfKhN8jLlXsKwsu3X6/GnVmJ9bdZdiv6hJl7jXm3enPi5ZhNzlXWNRNHy/T2YPP7UdB0O98d/901z2LaeKvGro3p9CghfzaGxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAGCEGpixwQsax5NIsIrTwly6TzXvLUH7XO+YxhXm6w=;
 b=GqPK9ojuzCrAYsSkwcXrewbkyX50QaPokdUwyPwpK/WlrBgxMDbXNrZySx90bctl3QFeb5Xl3lRJsdS0Z0urbO7PO4mqDoQQj/vmNbHJTk+gUEQlGq0+jtzR2HbNccXnfEgACnZPcO2unTgPe5/q+B1wrDTv0sjoyGiMUvTYJY9q3qVJIFcfmz9TS6UKSviUinM59KFxh+Hhy418gOryYL7pb00A1rmxrBiERkdjPbSG1XfRKWHTnNBvdpcnYpq1YNu50aX2PwUqxF2kL5RtbbzIqcvnoV6rnwUM4LHw0X1E4997PF79LgCNsnGgWgxUAiTLXoXYg9bGREPDlfHMYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4917.namprd15.prod.outlook.com (2603:10b6:806:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 04:56:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 04:56:19 +0000
Subject: Re: [PATCH bpf-next 1/2] tools/resolve_btfids: emit warnings and
 patch zero id for missing symbols
To:     Hengqi Chen <hengqi.chen@gmail.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <yanivagman@gmail.com>
References: <20210725141814.2000828-1-hengqi.chen@gmail.com>
 <20210725141814.2000828-2-hengqi.chen@gmail.com>
 <dde36573-f6b9-8570-0878-e313e771345a@fb.com>
 <95d1c440-bb99-13ad-0227-f9ab20a001f2@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e077b67e-d7d7-b8ff-f026-2280ce89a6f8@fb.com>
Date:   Sun, 25 Jul 2021 21:56:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <95d1c440-bb99-13ad-0227-f9ab20a001f2@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:40::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10b9] (2620:10d:c090:400::5:64c5) by BYAPR04CA0012.namprd04.prod.outlook.com (2603:10b6:a03:40::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Mon, 26 Jul 2021 04:56:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c456a2aa-8e22-4550-1be1-08d94ff1b53f
X-MS-TrafficTypeDiagnostic: SA1PR15MB4917:
X-Microsoft-Antispam-PRVS: <SA1PR15MB491740792D66CBE7E15CFA7AD3E89@SA1PR15MB4917.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nS12jueKpx2D+gw1HGOF3BSfoYFDR2YerCFJhD0MW1bZjInlmN075zIkeA4og7NoE8xdEtA8azrBilcfeceFRT7qAU5ZQsGtFdMpdEBd6i1q56Mk6TqKlvL749OVsOafZnpcD95VAur4+6ypGx+vzd171XWstND+Hp9qQOPUOYFv5YaisMJTQXfWNqD3kBdjErbQvnJtuYE+7VPuXXUtJskPrMl1znN5PpcXRdSeX719FlNH9+tb1memOcPSY0qlfShdXoJgktwuXrrVw3G/ECJ7VXKoxAzNjD7/n2CQLKJOzgBPG6DTxzcnwBQRW4BVtW71KdPFMhM092djIU/DD5bYvnmBVY7R1GWgU0WxEJMILZ2qeH0RvRKm8GFkA1cd6MzK+ACfHiSZryxG/twpYAto3xEueH2l4SyO38ZVC32g/k7+blhYq0MC2IGSJid/9UZuYDVk4xycbDwvNiCBR3o0zNk0X3SOTBTYW+pkTLjWfCC5hfdD0DABVM69zz6jvAGxqV6yhrjVSW1byrUrkorUN4wUYX2L9/DXD+TosSv9PHs4gjJ/iXpxydCr9GsqgP+V4lMCRb44yrnkQYlX/pjgDEi501hRkPPRgJXWkyONcANQFhi0QSgUd4GtKmIC3PCJ5ZpF5nHXT+dbHg2LB+IRU8vBVLzVnWA2PI5Vq0qxuHxeILHNvaRy8IkbjWRIS1sVRLZ93pK8VP7b/VwYYtFl/L3l4wCV1gZeU+EFiEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(4326008)(66556008)(66476007)(86362001)(316002)(83380400001)(31696002)(66946007)(6486002)(5660300002)(36756003)(31686004)(53546011)(478600001)(2616005)(186003)(52116002)(8936002)(2906002)(38100700002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEpkZjA2N3ZVRlNhSTB2MGdTenRycmZYUkx4UXVPZDB5VGJmaU5CRUV5SEpn?=
 =?utf-8?B?VEV2WUJhOFhteUFMTnN5aEw2emdEaWlTWmFQajB6bHRiWkhzRE5tQWIwYW5L?=
 =?utf-8?B?SFFVazZXVmU1bWM3UmVqNDh0b0FvdGdKVG1PUXh1cVhoQTZQSmI5Y2kvQzVy?=
 =?utf-8?B?dzFjbzdoOUN5SFpMTnorMnFhM0VzWUFNQ0Vac2JxdnhkSWhkajZxRGNSNXpE?=
 =?utf-8?B?WjM3QjA0b1YwcXBSZWlsamlaczJPZHVHcm8rSFJibldBWGJZOFlTb09pUDVO?=
 =?utf-8?B?ZnhCN3J2Z1NQSzFlRFFKb0s1UldEYmhsbkZEVGhoYklneXJGUHkwNTh4eFpa?=
 =?utf-8?B?LzB6ZWYrdnh2ODRtNEk3V0o5czd1bzhBUHpvWk13UUhGM2dCTXh5SGxjcGZs?=
 =?utf-8?B?Wnp1bVN2bWg0VXJlYS9YTTdBZ085L2lBNDlyYkxLTld3NVBuajZOaGw0RzZI?=
 =?utf-8?B?dXBWVlk0bndlRUtZdm16Z04rSTJIUnl5UXJYbVNWQ2k4NHVNYWZwK3U2MEZs?=
 =?utf-8?B?NFZqa1JKNG9uOVBTd1c3b2FOYytsNE81YU01UEMrN3FDTENxZ2dhM2FvZE5O?=
 =?utf-8?B?Q0ZzRHMxV2RRcGpmaFZQUFNvT1BuN2ZmbDJ3OHBRZkRJTVZNd1NOUWVwQkhO?=
 =?utf-8?B?bk55MmZkZVZra2dFUlRNVGp0WmRmd0RWYUtSbWdSeVNvdkoxWXdLQXJpSjlY?=
 =?utf-8?B?dCtlcnJvSnFjaC9LcXZCRE05WDkvU3E3SmFCMWEzd1V1bzZyR1BrbjNzaXNW?=
 =?utf-8?B?MlRWakllQXdZRTFyVTl2N05ZR1RDVGM3bDNocHVPYVRGL3JXbXhCb0VCU3p2?=
 =?utf-8?B?eVRBUlNwRWhYendlVS9Ta29CTElUUDY3bGk0b1ZlbjliSUErbmxpeE81YTEy?=
 =?utf-8?B?dXZnSkdTSDQ2YTlOVDEybzhWZ25aRi9GMmQxN2xqZk52SHorbXhTOVYyS0hk?=
 =?utf-8?B?R09Ld2FocVkrMkNOd3E0a3E5UnE4UnBveWtHbjdGa0pXaGdtakJtSVV4OXpw?=
 =?utf-8?B?RytkaDFjamc2NzBTTEozaFpybUtpdUFrcndWL1JDTUl4c3BLNGZxZHpzMzVx?=
 =?utf-8?B?MW1qK2dsOEt5bm1teFZLVzRtTHZEaG9UZjZtT1pJWmdLNnowNEVvdWJvb29w?=
 =?utf-8?B?TW1DQWpSLzVsSy94NXIxQldMWlJwRS9paVZtWFBqSzBpeFp6YmNaWTFCaVVh?=
 =?utf-8?B?bEhhSXRNVFVLb1RFUXNJWERHenBVVW5SYnNUTXAwMTd1RkxzS0NISjBoRGFL?=
 =?utf-8?B?aTBnclRQM01vZkNDc05jcDZZdUhVb1BJUHhjaXBIbW5mYkc4WUozV1Z5SWVR?=
 =?utf-8?B?RmFobXVCZ24zRkh4Q0R4S0doQ2pHaHhJUXV0NHAzSEtLRE5sUWlBZFpPQjNJ?=
 =?utf-8?B?NWpSMER6bGtwM2xTZnpVYUZVaGY1NnkzSytCVktMdmU4R1dueXhHVnZsdEpx?=
 =?utf-8?B?M0d2SEM4VUNUYkRUM0d1djJYTUNKUVFZcFQyTnVGdjhYUTVUUkJpZzBUWEpT?=
 =?utf-8?B?WkhoNzBVaUFNeFQ2Tk5QY01rUmM1UDMwSFNHSEZ4bTJLaGx5RytUdHdWQU50?=
 =?utf-8?B?ZkZOQkdJVko2cWNHK2JZbVJ2RU9qRFNVNXI2RXJlMnJjTW11NzJ1QTdRNzh6?=
 =?utf-8?B?SW5jOWlCMjBXajg2Zzlha2huQi9wYXJtZjhDWUhYOFN2ekFndTl6Q1MrUmJH?=
 =?utf-8?B?YVFCcVFHYWJCdHpHQzVERWx3elRxZDRjYUNvekFPMkZaN3h3QktlNkZsa0pV?=
 =?utf-8?B?bnJCcERPZnNvdysySlBPYzd5bVJ4MVE1N0E1aTFCQ2FKTjdJZWQ5ZlhXSmF0?=
 =?utf-8?B?cGg1YkptVEgrNDg5RTJ0Zz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c456a2aa-8e22-4550-1be1-08d94ff1b53f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 04:56:19.7549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGTrvdjO9FzEoAuIto96UxoveT/1LTZHwT0+oF2fdugqv55snagPe1gMZL79iLsi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4917
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Kn-VeuQ37vTeYxKOWliFdmzXJ_CJcYZW
X-Proofpoint-ORIG-GUID: Kn-VeuQ37vTeYxKOWliFdmzXJ_CJcYZW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_01:2021-07-23,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260028
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/25/21 9:41 PM, Hengqi Chen wrote:
> 
> 
> On 2021/7/26 11:32 AM, Yonghong Song wrote:
>>
>>
>> On 7/25/21 7:18 AM, Hengqi Chen wrote:
>>> Kernel functions referenced by .BTF_ids may changed from global to static
>>> and get inlined and thus disappears from BTF. This causes kernel build
>>
>> the function could be renamed or removed too.
>>
>>> failure when resolve_btfids do id patch for symbols in .BTF_ids in vmlinux.
>>> Update resolve_btfids to emit warning messages and patch zero id for missing
>>> symbols instead of aborting kernel build process.
>>>
>>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>>
>> LGTM with one minor comment below.
>>
>> Acked-by: Yonghong Song <yhs@fb.com>
>>
>>> ---
>>>    tools/bpf/resolve_btfids/main.c | 13 +++++++------
>>>    1 file changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>>> index 3ad9301b0f00..3ea19e33250d 100644
>>> --- a/tools/bpf/resolve_btfids/main.c
>>> +++ b/tools/bpf/resolve_btfids/main.c
>>> @@ -291,7 +291,7 @@ static int compressed_section_fix(Elf *elf, Elf_Scn *scn, GElf_Shdr *sh)
>>>        sh->sh_addralign = expected;
>>>
>>>        if (gelf_update_shdr(scn, sh) == 0) {
>>> -        printf("FAILED cannot update section header: %s\n",
>>> +        pr_err("FAILED cannot update section header: %s\n",
>>>                elf_errmsg(-1));
>>>            return -1;
>>>        }
>>> @@ -317,6 +317,7 @@ static int elf_collect(struct object *obj)
>>>
>>>        elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
>>>        if (!elf) {
>>> +        close(fd);
>>>            pr_err("FAILED cannot create ELF descriptor: %s\n",
>>>                elf_errmsg(-1));
>>>            return -1;
>>> @@ -484,7 +485,7 @@ static int symbols_resolve(struct object *obj)
>>>        err = libbpf_get_error(btf);
>>>        if (err) {
>>>            pr_err("FAILED: load BTF from %s: %s\n",
>>> -            obj->path, strerror(-err));
>>> +            obj->btf ?: obj->path, strerror(-err));
>>
>> Why you change "obj->path" to "obj->btf ?: obj->path"?
>> Note that obj->path cannot be NULL.
> 
> The diff didn't see the whole picture. Let me quote it here:
> ```
> btf = btf__parse(obj->btf ?: obj->path, NULL);
> err = libbpf_get_error(btf);
> if (err) {
>          pr_err("FAILED: load BTF from %s: %s\n",
>                  obj->path, strerror(-err));
>          return -1;
> }
> ```
> 
> Because btf__parse parses either obj->btf or obj->path,
> I think the error message should reveal this.

Okay, I see, obj->btf may not be NULL due to
                 OPT_STRING(0, "btf", &obj.btf, "BTF data",
                            "BTF data"),

How about
   obj->btf ? "input BTF data" : obj->path

The error message like
   FAILED: load BTF from : <error msg>
does not sound good.

> 
>>
>>>            return -1;
>>>        }
>>>
>> [...]
