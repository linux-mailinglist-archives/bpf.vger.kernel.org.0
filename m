Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEA23D52DF
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 07:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhGZEw7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 00:52:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59208 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231691AbhGZEw7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Jul 2021 00:52:59 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16Q5ERR7016599;
        Sun, 25 Jul 2021 22:33:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Hruz2p+eZFRIsH9zVufuFQOUmgZTmtdb4d6yJ/fxxlQ=;
 b=paALmxeyad7V7Nda3rn/ESKT4nwGe4YFYmKnVyG9VgclFp3xLwq+5BIJOaZoEY4XYGZ9
 1kVenvAgC0h9z9rjCq2Y321ZRej45ByqzX8l5jR9cHEoprAxO9L7u5ICyG5vF2++BvzO
 6bivKaHmOKrhhFZ+rZboMk1+Jjy4FncRyAM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a0fyy7jfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 25 Jul 2021 22:33:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 25 Jul 2021 22:33:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rg6harcUzf8i8BiTLmN1XSVzeEOfzRAxrgvPFRplWncHZxNf2Ejt+y8YhkHzjpQJqotpZZcA6/TS5dw2PnQoI8rKiM4MCVUYxObUoy/hXSrM8Vm7eEbBYGQrDUBKo9eYOdx+6qGxdFfE1A+OldKnuCQUyHfsvkweSW+1lzp067NzDjO/YCF00lzl+ra9Uyq1Mn8/ppzxtWaSHDevRwHQbX30CEljHzFthG0f7nccUH9thTsBsbtGt+5V+LGOa12DxoVmNLXaJZkFDDQT3jL86OM/wbIPwVeJSLsteNbkDk8ef1x9983kw3KhcsntAwfolbgHgM6vPZ+aBYhhekWOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hruz2p+eZFRIsH9zVufuFQOUmgZTmtdb4d6yJ/fxxlQ=;
 b=h2RlnNe41M5x3/IoR0UXfYxNOZMAV9hw0PPdn+ylKLu82X+rJ89iJSf/GHSyLKOzlh4ca+IRczIUxJyPSESm177SdyZfCfCiTyGzRLvq/ugXL5RLgpvmlYoVz+PELpADVRYrROcWQLc7b+1w5BPfdFRUVvlJXACcFtvDgB5RzUuJp4uC37qxth12MGMYxgKqEfhk9qVGGoTIq/tAWrKzdSy841jBcV8vLz8WPO3sex0U51xbVrW9SDUn4rA6GJF/1NFNcx3TZTQpL56rD6Vdbw2WA/ywD6+79s8ohYBg3ZlSE0n34cHKEG5lQhkY02RJkrP+M6YUpmN0lZf20pZ+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4805.namprd15.prod.outlook.com (2603:10b6:806:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Mon, 26 Jul
 2021 05:33:05 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 05:33:05 +0000
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
 <e077b67e-d7d7-b8ff-f026-2280ce89a6f8@fb.com>
 <f1e7a60c-78ca-ce24-313b-c0e46507501a@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <6863a87b-7121-79cb-76d9-6a02cd0acf33@fb.com>
Date:   Sun, 25 Jul 2021 22:33:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <f1e7a60c-78ca-ce24-313b-c0e46507501a@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10b9] (2620:10d:c090:400::5:64c5) by BY3PR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:39b::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend Transport; Mon, 26 Jul 2021 05:33:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00b02021-eebe-4b7f-f1b4-08d94ff6d7b0
X-MS-TrafficTypeDiagnostic: SA1PR15MB4805:
X-Microsoft-Antispam-PRVS: <SA1PR15MB48056C6B5EE4E650B793B58DD3E89@SA1PR15MB4805.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 68HUjSEoamUhjV51aH9aMB6z7j+NuXTU9zMioAOpMiW4LH2Y1spXo7xW6Gri49jUPCJ1L5REQaCHNX19W6o7Kiu2in+fyRvwZsNxDd1DtqBLLwPge+DyZYJVHsRkRS7aOmfoyAaVQhzSfWz2uby5eHuHyGQTkWdPfgQlZjgJGnwcgbAjKWsTj9NXXN1YbbEtMwCeenSDH4SHlqjPi8Q1CD1QV6BV34CZcKK29gB9oGfWm/ktb1gjqMn7K+JPs3L+CxzqoQuoLBeOms+tmqSYLamXw2GdBNIJjbC3K1Q7DcKG33y2qFVOHA2J4R37zbFcF/jmcM2mk2oK8BzERjgDHvlWr+BbE7cUQXUOaIcdilDU164ACN2U/acadhBqjtEZKqCphDSbpNfUQrUimCNjLZ4dmgRCxGgcfxsh9QZ5l9nEoXgtZ8GzjGPyPjlnQwrrWjf4UOIOmYF+NjsNCZi71alLES0CI73rHWg/NlCdwlxRbZy22iJ5JrPoIftVWFWhGEcaSvRu7GC1Tb8m+vgj/qysO3PoszeyyFazJ8RihPNGiUn2SitBdOhRDT1CO7xVMlV01YXcCAniBZIpPqC7dCorQ6e7NFFg/j0jYIOvKraU+4MspuXq549sO5k6vIjGo5JnkQwXnC6q17txI5g/uTazB8nTQAVAfZpA1Y1POdgOi/mB84mxoJUTOtugXHVEezubsJGSg5jBt9RD2Ua9DlIKvxQql/cGWoM+s8s+h20=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(186003)(6486002)(31696002)(86362001)(4326008)(83380400001)(36756003)(52116002)(53546011)(31686004)(2616005)(8676002)(2906002)(8936002)(66476007)(66946007)(316002)(478600001)(66556008)(5660300002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm9mc2l1MmNHOXIvTWZNazJiQXh3cVJLNXpmL01Jd3E0U05pSHBtTHRITjZk?=
 =?utf-8?B?TmNGSUlOeGJad042dGJGZGF4eTlwU1c1M0xlakZYRC80RTZydTdob1ZEa2tW?=
 =?utf-8?B?MmtjeUlYZytPcUQ3NklXRFVFZkJsZkMxYjNaQmVqZWdJU0VuWjdmS2xpK0NF?=
 =?utf-8?B?cDI3SFkvb3c4eldYMlpnN0Y0UC9RR0VPLzgyK3FGTVg4bGRsY1VoNDhqSlFh?=
 =?utf-8?B?YWlzeVFuUXpyK1FHdmFHWGpSeHFwb2xGMWZZMi9yQUxXWStFL1N5VCtpYkY4?=
 =?utf-8?B?N1A2WGRVZ1NMZ21sQytJL0N2KzNRVkhPeHloTzVHZ0Rud1JwbHNWdTVOY252?=
 =?utf-8?B?SlZwSkdpenBBSjkxUTNaOTkyZmxIRjlzSXJGbXBsdXRMVFdGVnRwUXhMSjNl?=
 =?utf-8?B?cC9CVXJkWmppTHpoZWJnQ2F2eStnUUZXdXNvN2s0M0NLbGRDN2NnOUVpY2hF?=
 =?utf-8?B?Qm5sTk9lSXhUVStLM3dVeUpGVVErWUNDY1VRME9raHJHVWE4M0p4VGVEbGZk?=
 =?utf-8?B?V2c0R1VWMmRGSmlmb0ZaSnhMSTB3cncyZFVOQ2pYT1lhYVRHMDVyYUNSbktE?=
 =?utf-8?B?NUg3NzR3Y3A3Yy92WjBRT1lpSWYwMkJ6ZjlKY2tralhwcFhtRytLOVltYUZU?=
 =?utf-8?B?eisydnBxZUJPTFZvQ3hEcFV3ZFlpOVVpcEx6WHZUYmV3ZWNiN1B0SHBsQ1hR?=
 =?utf-8?B?bWEvN3NuRExMNzV0MTRWWjhOVjdSQUd4U0pVV3Y1YnFDSmZzbTVkRlREV2sr?=
 =?utf-8?B?NzdhajZsT2M0UEFJMUtsYjQwS3dvRURvZ2hHVld3RklkR1drVkthSkFQanNx?=
 =?utf-8?B?K0owVEl3NFVCUjA1bk5rWUFEN1IxRjlLWWM3d3RubjlkcVpMa0pFRWpVR2Fl?=
 =?utf-8?B?RlFGTFI2NjhvdFVsdVUyY2dqcGhRbWVGTExzcmNoaVNiU2ErcndVaGl1RVZV?=
 =?utf-8?B?cjJWdzJvZVJqcUJMNlo3UUZwNWFTTExKbnAwUHBoazBRRWhtNHNJeUVmR1pR?=
 =?utf-8?B?Q3drREp0Ri9TREZUeFgwR3VaaG1FL3NuS29IWEZpQ3dPVlhHaXV5SHhRL0Uv?=
 =?utf-8?B?L29vaVdia215KzFEZFlpMU1ZNHJrNkt1OG9jRXRrVzljZGUzMzVrQ0gwV2xI?=
 =?utf-8?B?SDk4a0lYRDVXYzBCU29QTjB6bFJyV0Qva0JFQUZtOFFwYlBLVUtxZWFMNXZx?=
 =?utf-8?B?c2MyejBwS2xkQ09oYU00a2l0aE9zOW1yQnFuNFhxV293andIUDBYa2RnTWgv?=
 =?utf-8?B?MFYySWR1ajZIaEhqU3E5MUQrL0t2ZjBCaW5KditwNHV6WVVKNzA0N1VibnU3?=
 =?utf-8?B?c3o4TSs4Nm8zeC9FYm1Wby9qYnlsNmUrZHJxWHNpRWZqS1U1VCtrZkZRNnE3?=
 =?utf-8?B?MEtBeGpSTzJmRFg0NnM2S3lVNE9xSVQrdXZ3WlVuYVVtdm9nNzNBL01DV1Bu?=
 =?utf-8?B?V3VlMU5BT2pXc2lubXBpRzlkMllwNjduRmdpeG9LWkJYU0R5RkZheXUxd24v?=
 =?utf-8?B?aU9aamVVZ2grTmVnTnd0NmhwUnZVdTF6TkNwV3BrSG5QQWNRRUdROThSeGUw?=
 =?utf-8?B?QzdDM0owd1ROWVJLcGQ3M0l3eEhrZWdpdWdYOTV1bnFCaml0RzlmWmhRS21s?=
 =?utf-8?B?UFZiWTlsb01YMDJhemY4eHZldjd4ZVVyMjlwaUh3ZUYxUlNJbkVPRTFtUTNj?=
 =?utf-8?B?bEk0NFlGMWJPNXduQUJJdUpNY2JCOGl5RlV6OFU4c083c1FuUVFTd21RQ244?=
 =?utf-8?B?Y0wrRW45RGczbkpjcjJoVEZ4dHQ4T3l5NlBWQUNxUzhnZStaTzFmZHdhOU5M?=
 =?utf-8?Q?DFY2EPxyVMMztK8JwC7/RGt/tOXJSqsg2cQuI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b02021-eebe-4b7f-f1b4-08d94ff6d7b0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 05:33:04.9922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSMFlE6RqFBlWTkCW27E+snLi9JolB0mRBl4RTc553hNImj7Cj8/hKu5kiwknI+6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4805
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: OOT6Ybomk5OFIy126nEZDUDw47RI7Atj
X-Proofpoint-GUID: OOT6Ybomk5OFIy126nEZDUDw47RI7Atj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_01:2021-07-23,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 suspectscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260031
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/25/21 10:22 PM, Hengqi Chen wrote:
> 
> 
> On 2021/7/26 12:56 PM, Yonghong Song wrote:
>>
>>
>> On 7/25/21 9:41 PM, Hengqi Chen wrote:
>>>
>>>
>>> On 2021/7/26 11:32 AM, Yonghong Song wrote:
>>>>
>>>>
>>>> On 7/25/21 7:18 AM, Hengqi Chen wrote:
>>>>> Kernel functions referenced by .BTF_ids may changed from global to static
>>>>> and get inlined and thus disappears from BTF. This causes kernel build
>>>>
>>>> the function could be renamed or removed too.
>>>>
>>>>> failure when resolve_btfids do id patch for symbols in .BTF_ids in vmlinux.
>>>>> Update resolve_btfids to emit warning messages and patch zero id for missing
>>>>> symbols instead of aborting kernel build process.
>>>>>
>>>>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>>>>
>>>> LGTM with one minor comment below.
>>>>
>>>> Acked-by: Yonghong Song <yhs@fb.com>
>>>>
>>>>> ---
>>>>>     tools/bpf/resolve_btfids/main.c | 13 +++++++------
>>>>>     1 file changed, 7 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>>>>> index 3ad9301b0f00..3ea19e33250d 100644
>>>>> --- a/tools/bpf/resolve_btfids/main.c
>>>>> +++ b/tools/bpf/resolve_btfids/main.c
>>>>> @@ -291,7 +291,7 @@ static int compressed_section_fix(Elf *elf, Elf_Scn *scn, GElf_Shdr *sh)
>>>>>         sh->sh_addralign = expected;
>>>>>
>>>>>         if (gelf_update_shdr(scn, sh) == 0) {
>>>>> -        printf("FAILED cannot update section header: %s\n",
>>>>> +        pr_err("FAILED cannot update section header: %s\n",
>>>>>                 elf_errmsg(-1));
>>>>>             return -1;
>>>>>         }
>>>>> @@ -317,6 +317,7 @@ static int elf_collect(struct object *obj)
>>>>>
>>>>>         elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
>>>>>         if (!elf) {
>>>>> +        close(fd);
>>>>>             pr_err("FAILED cannot create ELF descriptor: %s\n",
>>>>>                 elf_errmsg(-1));
>>>>>             return -1;
>>>>> @@ -484,7 +485,7 @@ static int symbols_resolve(struct object *obj)
>>>>>         err = libbpf_get_error(btf);
>>>>>         if (err) {
>>>>>             pr_err("FAILED: load BTF from %s: %s\n",
>>>>> -            obj->path, strerror(-err));
>>>>> +            obj->btf ?: obj->path, strerror(-err));
>>>>
>>>> Why you change "obj->path" to "obj->btf ?: obj->path"?
>>>> Note that obj->path cannot be NULL.
>>>
>>> The diff didn't see the whole picture. Let me quote it here:
>>> ```
>>> btf = btf__parse(obj->btf ?: obj->path, NULL);
>>> err = libbpf_get_error(btf);
>>> if (err) {
>>>           pr_err("FAILED: load BTF from %s: %s\n",
>>>                   obj->path, strerror(-err));
>>>           return -1;
>>> }
>>> ```
>>>
>>> Because btf__parse parses either obj->btf or obj->path,
>>> I think the error message should reveal this.
>>
>> Okay, I see, obj->btf may not be NULL due to
>>                  OPT_STRING(0, "btf", &obj.btf, "BTF data",
>>                             "BTF data"),
>>
>> How about
>>    obj->btf ? "input BTF data" : obj->path
>>
>> The error message like
>>    FAILED: load BTF from : <error msg>
>> does not sound good.
>>
> 
> Sorry, I am confused.
> 
> If obj->btf is set, say, vmlinux.btf, the message should look like:
>   FAILED: load BTF from vmlinux.btf: <error msg>
> 
> Otherwise, it should look like:
>   FAILED: load BTF from vmlinux: <error msg>
> 
> Am I missing something ?

Ah, you are right. Your patch looks good. I didn't pay attention
and thought
   OPT_STRING(0, "btf", &obj.btf, "BTF data","BTF data")
is a string input for *btf data*, but actually it is actually
/sys/kernel/btf/vmlinux.

> 
>>>
>>>>
>>>>>             return -1;
>>>>>         }
>>>>>
>>>> [...]
