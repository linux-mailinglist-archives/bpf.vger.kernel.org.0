Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755F32DD61C
	for <lists+bpf@lfdr.de>; Thu, 17 Dec 2020 18:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgLQR1c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Dec 2020 12:27:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21036 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727723AbgLQR1b (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Dec 2020 12:27:31 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHHPDYR004279;
        Thu, 17 Dec 2020 09:26:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3W8ZRbBJhJBCjrbDqS3oJfVJPUGJCcRvWdRvftq6N1M=;
 b=hZPYBKJDZ4qzJhI3lusADIuTReN1SKfoZLTTTvdVQgpx+PNR23Krktm40Lr6+kXYJE3o
 Iz8r552kAjwHc9Y46fTGIZ9g94zpRVdCAHvDTsYTb1Llr7hpBSv/Q71tSVekDC8v1AHt
 ctJxwNp3flL5qytww1WnPXixhfyBGNBA4FI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35g83xhb8n-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Dec 2020 09:26:33 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 17 Dec 2020 09:26:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hL5lsHI+26staOxGSzK+9qjMKsAZK70YCf8mKjYae1iZ6LHr+AV0d80XstRKfjbsDRNQgnas8De1WG2GHetYb2YE102i0w6AcpS4HZCqVb0Lyc8nawJ4tkiFhuqRPhNAMPDJS/EUVdz9NUZ1E2EYeoiKTjkcgE1y4NbPJmkvDEloXkAzIrxEmX/FqzNkWyEWa0SG40STh/LEVYOGCymLa0CN9gdehnOkRJz6evsuCZygbvQPVdBeI9kRc/egoFSImals+dEtv5pNZPsW01rSAL/5YbQd4hoNPGOgUiihCiRSJddtxfMkBlCoFbJhIpurzOiHGxZZm5X0enpxGYGhyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W8ZRbBJhJBCjrbDqS3oJfVJPUGJCcRvWdRvftq6N1M=;
 b=D5tVGQDdFOu1xecCavc/gC0FBuvFyyUDtU/t3S4ThmF8UyjSU4CkDV3DcLiCG1LnWD2YoAn3TeXihXsTWpnGf+UxfcTE5m2apYayyWF+AWVCQAinFbhlL6JOgOFgTvvel6eFj8tDiUqQF8H1ROyARbM5bK01AL6P+bITpqL4g5do+yKcGQevZBEjDl4SzSBSipkzgaxStKwTtrCbyBylQN+TEOnWKtAXy0GeLa45LXvm8OGl7T05KXbHZ8coUFkFogeTfN9octS0+eXSiZKEXP/5eM/HQOAd2eaD39jTt+XEUWImTQISxYEMBkui2pWlF2NzvruvI3Zd9ZEmx+y6ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W8ZRbBJhJBCjrbDqS3oJfVJPUGJCcRvWdRvftq6N1M=;
 b=lDnAW/W1a5VwxSj3A7evsO0Xp92H1jFXnap8nTlIFZeQzZJ6wMHuWDUSuE7R9O20KdNOxHqvb0ClyIIx8rVDFg6vfIAW66j5F8DW3hggxrYRpgCX6eUG7fP9bB3qSj68d6tFjsbzsAM6sTBS62ekOlAI84FuwQNJnzdQyFIGkok=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2728.namprd15.prod.outlook.com (2603:10b6:a03:14c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.20; Thu, 17 Dec
 2020 17:26:14 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3654.025; Thu, 17 Dec 2020
 17:26:14 +0000
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
To:     Florent Revest <revest@chromium.org>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20201126165748.1748417-1-revest@google.com>
 <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
 <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
 <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com>
 <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
 <194b5a6e6e30574a035a3e3baa98d7fde7f91f1c.camel@chromium.org>
 <CAADnVQK6GjmL19zQykYbh=THM9ktQUzfnwF_FfhUKimCxDnnkQ@mail.gmail.com>
 <CABRcYm+zjC-WH2gxtfEX5S6mZj-5_ByAzVd5zi3aRmQv-asYqg@mail.gmail.com>
 <221fb873-80fc-5407-965e-b075c964fa13@fb.com>
 <CABRcYmLL=SUsPS6qWVgTyYJ26r-QtECfeTZXkXSp7iRBDZRbZA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d29c2ed6-d99c-9d28-e6ea-d79ffd4d7e65@fb.com>
Date:   Thu, 17 Dec 2020 09:26:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <CABRcYmLL=SUsPS6qWVgTyYJ26r-QtECfeTZXkXSp7iRBDZRbZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:9810]
X-ClientProxiedBy: MW4PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:303:b6::32) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::12e6] (2620:10d:c090:400::5:9810) by MW4PR03CA0087.namprd03.prod.outlook.com (2603:10b6:303:b6::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Thu, 17 Dec 2020 17:26:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f762e00f-350a-4496-5681-08d8a2b0daf0
X-MS-TrafficTypeDiagnostic: BYAPR15MB2728:
X-Microsoft-Antispam-PRVS: <BYAPR15MB27287B96D087B12BE646C74FD3C40@BYAPR15MB2728.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUhkR3AUGfOV8KWLfRCIZYVZ5eXRKA+YHGWhQ506X/lqkv2Nn67tA2AKSADRLhUKb018iZy5FBKZTXzaST5/MOVVw2P/U+IslUawKjkvkWe6QG3wCzfIL4hY/iMSPiO4l1OKmJmI7SDWrzayFsonMUqROewNaJG8tGmYZYAf+0S2MiOy63fZKSqELEGwcZXu8jwWGxQSlsrcNg7PlzYt8IGZn0Ox7bLv/n6OV1yoaee9avzYrxJ/T9l75SWeldVFsRVNsRu1ii2OYgTg2lj2YmEYvajJjWZQ7Wn85mx5jbUBQn7KiYDWd2UJVz7DlfR+yvhBP/He9M9khWj3a6olJCEH0KSM0lLUH3CnSXZttEXoFoCrn3uCUCuO9z/IWbRtaNIfjjKgVWk3yun9B3tQgDFZjdGIre+MtB2C4vhkFTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(316002)(52116002)(86362001)(5660300002)(8936002)(83380400001)(36756003)(16526019)(2616005)(2906002)(6666004)(53546011)(31696002)(4326008)(6916009)(7416002)(6486002)(66476007)(66946007)(478600001)(8676002)(186003)(66556008)(31686004)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NG5PRHpGSUFzR3h0Nkk1UjBMWWl2eTIwQzRKbnA2dnEwTXo3a01iVmJJUkZi?=
 =?utf-8?B?WG9PQVJlbjZYNlVDWEU3ZVJ4MTFFbVR4WVQ2dnltV3lCU20vemJVa3NBOGxw?=
 =?utf-8?B?YkpTUmdRWnRhOGZOTFlScDB4V005Z0dENU9kdDZWVTl2R3hUWjJRRDFxWW9k?=
 =?utf-8?B?ZGM3Q3NMNmNYOWxkcmVZTTV0U1JNSXpmT2FGcjliOEFob2dxK2FET2l2OVdC?=
 =?utf-8?B?a3NkRjRMVWhSdXZLN1V5SXROOTZsRW8zNDRhRmNuQ1EyWVhwRy9IMGNxTExX?=
 =?utf-8?B?dmNickVuRmllOUZsdWU0dDZUNnhJaThNN3Z4REJ4YmozTFBTa0RsRUFKUmxV?=
 =?utf-8?B?SzZrZmdFOW1PenJqOE1XRDVXMFUxWmtqUW1qaFBxQWs5VmdQcjNXQmJaMlJP?=
 =?utf-8?B?T2l1TWlHUEYrS3JGeC81Y3g0NVkxaVpDOVp0VFBOdHBkVW9PQ0Q1VEs2ZTht?=
 =?utf-8?B?VHVTUUlzbTlCRmphZ3U2NUZWQkdxN1p1bjNkbGRZaExYSUJDUDl6NEF3WDBu?=
 =?utf-8?B?WmpZOVFSSVZqUjdFNFdVNGR5aDR2cUs1YWJldDY3SldmQjBVWWg2c0dJUzlC?=
 =?utf-8?B?aU5zWC80V2QzUUEwaXVkL08xaG1FamhuY21rVEtDK244MmtLOHdzNUl4Sm90?=
 =?utf-8?B?UUJsQ2RvTGJzczd3OWd3YUM4RUxwZUFZR09LaHZRSlgwZDdTZzFqK2EwZ09P?=
 =?utf-8?B?U1dWK2pmNHpSTWhqOUp3N3YyUXo3bDhERUlaWU1ZSmpMNWMzTmovOWhiZ3Zx?=
 =?utf-8?B?b2VGZklIL0xjYzVwUXdtNnZmR0ZCWmRNQzltUU4ramtIcTZrNXZQY0xrV3dv?=
 =?utf-8?B?ZzBYRVpnekJ2MUZYVkc4bUQyb0Z0SlNXU1JXbitBN3g1RXJIYzcrbmdlaUJC?=
 =?utf-8?B?aGZCQ2h0R1EyY0UzV01xMWJYRWQ5YjN4bXNrZGs1a0cvUG9PajZuN2FZQk4v?=
 =?utf-8?B?RVJQMGtNaExsY0tvT0FyZTRjclpUdmQ2NG1kL2RGME5kaVNyNDI4WXMwUFU0?=
 =?utf-8?B?WUFNTHNHSzV0Q0dTWG9MZmJiRDlnaHVCV01lUjFGTEJENGRzWFp6cGcwYUxw?=
 =?utf-8?B?L1J6Y3F0Y0VRL2t6M0RtTUdwRkhFM25EZFkxNkdsbC9QWkhVQWVINCtiUUxN?=
 =?utf-8?B?RGhmdUl4YjF5Q01xck1teFVQTE1uTDh4bGY0TmpKeXUxbjlpaU5lYUxyeEcx?=
 =?utf-8?B?ckZld0NlMG9WUEdNc0piUGhJTlduNnMrcDMyWm42Mlh4Nlloejc1dExJeE1X?=
 =?utf-8?B?eEFlbGhjZC9QYW41T3piZ3NFQ0hXZXpIVHBuSXJXVGNic1cyUkR1Y0ErZDJq?=
 =?utf-8?B?emZHS3JEZkFSMFVMc0xMV29mZUhhVDVtNE1Objc5aTlMWlJLMVliRmJmcFVQ?=
 =?utf-8?B?MFlCaXBseGhZTnc9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 17:26:14.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: f762e00f-350a-4496-5681-08d8a2b0daf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJU3u89cMz6VLXkT0Ok229M2aRq3ItXyKq0ljDVuy/vT3kBouWxKO5RbH4eltSya
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2728
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_11:2020-12-15,2020-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/17/20 7:31 AM, Florent Revest wrote:
> On Mon, Dec 14, 2020 at 7:47 AM Yonghong Song <yhs@fb.com> wrote:
>> On 12/11/20 6:40 AM, Florent Revest wrote:
>>> On Wed, Dec 2, 2020 at 10:18 PM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>> I still think that adopting printk/vsnprintf for this instead of
>>>> reinventing the wheel
>>>> is more flexible and easier to maintain long term.
>>>> Almost the same layout can be done with vsnprintf
>>>> with exception of \0 char.
>>>> More meaningful names, etc.
>>>> See Documentation/core-api/printk-formats.rst
>>>
>>> I agree this would be nice. I finally got a bit of time to experiment
>>> with this and I noticed a few things:
>>>
>>> First of all, because helpers only have 5 arguments, if we use two for
>>> the output buffer and its size and two for the format string and its
>>> size, we are only left with one argument for a modifier. This is still
>>> enough for our usecase (where we'd only use "%ps" for example) but it
>>> does not strictly-speaking allow for the same layout that Andrii
>>> proposed.
>>
>> See helper bpf_seq_printf. It packs all arguments for format string and
>> puts them into an array. bpf_seq_printf will unpack them as it parsed
>> through the format string. So it should be doable to have more than
>> "%ps" in format string.
> 
> This could be a nice trick, thank you for the suggestion Yonghong :)
> 
> My understanding is that this would also require two extra args (one
> for the array of arguments and one for the size of this array) so it
> would still not fit the 5 arguments limit I described in my previous
> email.
> eg: this would not be possible:
> long bpf_snprintf(const char *out, u32 out_size,
>                    const char *fmt, u32 fmt_size,
>                   const void *data, u32 data_len)

Right. bpf allows only up to 5 parameters.
> 
> Would you then suggest that we also put the format string and its
> length in the first and second cells of this array and have something
> along the line of:
> long bpf_snprintf(const char *out, u32 out_size,
>                    const void *args, u32 args_len) ?
> This seems like a fairly opaque signature to me and harder to verify.

One way is to define an explicit type for args, something like
    struct bpf_fmt_str_data {
       char *fmt;
       u64 fmt_len;
       u64 data[];
    };

The bpf_snprintf signature can be
    long bpf_snprintf(const char *out, u32 out_size,
                      const struct bpf_fmt_str_data *fmt_data,
                      u32 fmt_data_len);

Internally you can have one argument type for "struct bpf_fmt_str_data" 
like PTR_TO_FMT_DATA as a verifier reg state. if bpf_snprintf is used, 
when you try to verify PTR_TO_FMT_DATA, you can just verify 
fmt_data->fmt and fmt_data->fmt_len which satifies mem contraints.
The rest of data can be passed to the helper as is.

Yes, still some verifier work. But may be useful for this and
future format string related helpers.
