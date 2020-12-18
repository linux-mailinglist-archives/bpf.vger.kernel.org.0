Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3A02DDDB9
	for <lists+bpf@lfdr.de>; Fri, 18 Dec 2020 05:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgLREks (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Dec 2020 23:40:48 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30586 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbgLREkr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Dec 2020 23:40:47 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BI4YHQ7016537;
        Thu, 17 Dec 2020 20:39:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=emAeDC8o5q2Dynz5ZhHPpNhca4v4IqyuMlvhmd6o6lI=;
 b=DSrRBPbuSFYfeLofrj57E/yPd+HV4e80DjW99iq0WQElx1tJuFRrpn3ljcwap3nZgHio
 3r/AeKjuqUIvhnFtpa2f9I9g6Lo1R4/2NC8fDVzw3Bg8wru+m+v967jl8sMu8sZMAxP/
 5kFe+hKcq/QSKGAnEtEogZK2blKxLYr6Cmc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35ftgnyfnh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Dec 2020 20:39:50 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 17 Dec 2020 20:39:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbSXRJlQM3Bruq7A9LWyBJkXd+Q8k9Pp3f9Y9cuE8Kia7Vf66lBHXGGDLWbP6AqG52mJbuZXlNEuRk66srL/sWiGRK8G92+YjQKWiPwyBqf7ubBJ769ztKXpExqFVZ/xt0SLYHhgFp9j4rr6eKoeMJKS5paEx3PWrtqF+29sCO7+iZgPJSoodu9i6EzLkTEXjTvNNmRajGpq8wDQlNPFmFZrf3vYkeMi6pFCCV7hETvKiOeZrmdpXTGtbcNdVTmSDWt/uUA5RNFpgjue2VaRt2yobCLL9QDWqo1BM4ucAQKPTywYQ3GkpE1QYaeRIywcO8f+xOB4LF6RVJNMZSz3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emAeDC8o5q2Dynz5ZhHPpNhca4v4IqyuMlvhmd6o6lI=;
 b=Ld5NT29FS7O8s5dUCJvJ8D4NsTXNOSD4TLXi2baBBCWp8WbEEcjWJr28IQVAT/vrGDOJLkA8G51XxAdbM7/zbvDe5TisK/CGLx/mBl+d39kxuJh9koOTthy1Jpe2nt8UL0bBjP16qYfjF/4/Ae8CA0stgr0SIjkOysHjPXYwA3EEKagm39+pDSkKoRjRox+T92DDQGav7OBRV0HptcVCXIBGgVJSixOirRswCrxdMGKv8Lo2uODWO+qrG9rCv9Un5lKuBjUeMe49IKI3TFCGV68vmZ9G2q+yyjKPvVWDsKnkbAEfzvzRxWJ588hlGaTgIJSX44/iG9kloI2dVgTAmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emAeDC8o5q2Dynz5ZhHPpNhca4v4IqyuMlvhmd6o6lI=;
 b=fdvHnFDM9ymZMN1K6xi2LVXX8gNNATmnSKjZ5g6NtolI1LG+GTFCg+Vat22E6PIvRtIn/yRQrLXXzPlH3tpZTdWKCrQsynvDvJgGMvuqSySJqKC5J7SB89VUo0n+Fq9FwuIKwAMwp5oH3HHIoT0sneKZTYb2nBKfJMoH8He6Izs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2645.namprd15.prod.outlook.com (2603:10b6:a03:156::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 18 Dec
 2020 04:39:48 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3654.025; Fri, 18 Dec 2020
 04:39:48 +0000
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Florent Revest <revest@chromium.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
 <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
 <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com>
 <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
 <194b5a6e6e30574a035a3e3baa98d7fde7f91f1c.camel@chromium.org>
 <CAADnVQK6GjmL19zQykYbh=THM9ktQUzfnwF_FfhUKimCxDnnkQ@mail.gmail.com>
 <CABRcYm+zjC-WH2gxtfEX5S6mZj-5_ByAzVd5zi3aRmQv-asYqg@mail.gmail.com>
 <221fb873-80fc-5407-965e-b075c964fa13@fb.com>
 <CABRcYmLL=SUsPS6qWVgTyYJ26r-QtECfeTZXkXSp7iRBDZRbZA@mail.gmail.com>
 <d29c2ed6-d99c-9d28-e6ea-d79ffd4d7e65@fb.com>
 <20201218032009.ycmyqn2kjs3ynfbp@ast-mbp>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <eba010db-8528-1a2f-a76d-a52377a533f5@fb.com>
Date:   Thu, 17 Dec 2020 20:39:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201218032009.ycmyqn2kjs3ynfbp@ast-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:370a]
X-ClientProxiedBy: MWHPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:300:117::28) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::12e6] (2620:10d:c090:400::5:370a) by MWHPR03CA0018.namprd03.prod.outlook.com (2603:10b6:300:117::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Fri, 18 Dec 2020 04:39:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5df619c-4877-4fff-390b-08d8a30ef36b
X-MS-TrafficTypeDiagnostic: BYAPR15MB2645:
X-Microsoft-Antispam-PRVS: <BYAPR15MB264538999EAA936FC30512F1D3C30@BYAPR15MB2645.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/ZfuXnX6rB1cRnWQXvYywJObz5diJ9TS+ZyWBsvVBFyFVzN0NGXxoDrohyw5ANoT6zo70t4/LTQeLDYIt/msoOoPso5yqwJyPeRdNRCdJIgNKrSCuOGBlBSezqMznEZiaAXPUdfJvrhZeDCPZQp7RjX37QRz6x5d+DYCxzwROcx3E524hxTwbDKELL9WMy2WNYMyLRq2rXv2jSYRJ++9rX6zrqcR76UuIh7EqICA8TmOCKFgv7dWlSXxQ92xIYmA+0n08ryw/LTbrMOc/nTz/WO/hJVZh0pU+ull2iRVLZ+ihuByDvxqKfJ2ykfUE1sCtmSmbw6GpPTAfWIFjjG2mxtpMDsQlhpSlvl83+rleGqqifHSVX1pHJRWtVpuZYOQLmohBMi9CR0Gaa9YdlrlosX7iEYh/3bbxMXnOvU+ds=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(396003)(376002)(366004)(2616005)(5660300002)(52116002)(4326008)(16526019)(31696002)(8676002)(36756003)(83380400001)(86362001)(2906002)(54906003)(8936002)(6916009)(66946007)(53546011)(31686004)(66556008)(316002)(478600001)(7416002)(186003)(66476007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UFQzOWJiZFM5a3BLRHhnUE5FdG44OFc2QmJFd3hOd21oTFZ3S21mYlQ0elhX?=
 =?utf-8?B?YWlxaCtmWkJuOFBEVXdKTStwb2xjem5aTFRIUVNQY3U1cG0zSFl6Nk4xSUY1?=
 =?utf-8?B?OU5IOEJoM1NOemh0VmE4d3BMd2dDQ3dQNnJuTitnQkZkR2MxeFdxNjhPcVZ0?=
 =?utf-8?B?eVZVTWg3MDg5SHFpQzRRb1pBSVpLZVUxNUVaNWhkZDVxZDNvV2hEMElVSllC?=
 =?utf-8?B?WVpKUksrazNKc25RVDYwMFpYcFRQWGp1eFk0azFCbnNZdmMrOVhLVjNxTER0?=
 =?utf-8?B?SWZsRkhRYXFzaWRMQjJ4S1M1aXlsYUhQWEk4aXY1WlB4czFWUm96N1drWVAz?=
 =?utf-8?B?SVJjWkMxNGcyUUp1bHNocWZGWUkwR2gzaHF3Ui9TL2FLb0JnaGFmZmcwNU1V?=
 =?utf-8?B?UWo5WFpCS2NHSW5lakdrM2t4WlhQRHR6M25VYTJmbG9qbXZQSVl2eGtWaE5t?=
 =?utf-8?B?SWJVSGxUNlJBYWNEQjNvajc1QkZDcHFzcjdRU2x1QXo1b2toYzFhOEhObXhp?=
 =?utf-8?B?OFEyWWxINTkwV1pmMDg2MVdNcVIvS3pwcmJOaERYbzgyUGJoejNIS25Bc3NE?=
 =?utf-8?B?dm5hZjRnTEJqYmRrekJyTC9lQ3AxTjFzelhOS2EyWW9qTmlYaHFEd1RYWkNk?=
 =?utf-8?B?NnRhSXI1RnltRXE3MGhJck5GQzNlei9jU2J2S1lKK0pXcCsrVTFEaHlTVmg4?=
 =?utf-8?B?dEhtQi9pM2p2VmZaVzI1VWtvN01aQWUrUW02dlI3S0FBblFEdDlPR1VWVzVi?=
 =?utf-8?B?eEJhTUJsbXRtakszTmY2SkVFZVFBRU1nU1pFcytpc0tNR2w1UTkzUm12T3Rq?=
 =?utf-8?B?RU90ZFh1VEhKdkFKTTE5clBjajFGdHRVeFhKY0NNM2VGTytyNkRoYTlqblVS?=
 =?utf-8?B?R0t0Zzl0YWFNbjloY2RaVmlSTEhCU2puNVZUbzhxQ2FqeW5CZG5JTUxYZmZ1?=
 =?utf-8?B?SmttVVBHQ3Q1akp4SzNyZldxeFYyd0tVdlRLanBIYTNYSzFNL3I2UXUreDBP?=
 =?utf-8?B?MmRManRVMlVSYUJ5NlhZUmNnN1BiK0ZsZWZvcFM0Uk54VnhoSGd5Mlp5VTI4?=
 =?utf-8?B?V3lYdzRXL0p2bWVlTGpjc3pQT3NBMC9aQTEwNU9ZUkhtZ3ZMTHZscnQ0QXhD?=
 =?utf-8?B?Vk4xMG5SWXdJWEswMW9LYzBRb0szelNhUHZFejBuVGJmd3o1SzZEMTB1R29B?=
 =?utf-8?B?b3N2THdWWTVCQWx6MG5zNFRLSnRYYzB0MjZTNzRNYzhxZ3haZlJiKzR3YkdF?=
 =?utf-8?B?Y1pYbHJZd2pBcmozS1NGRHhKY3MxWWQwRTNRdVNlK1hlanFFUXM3bk9ZQ1Rz?=
 =?utf-8?B?UzBaL00vVWdnTHV4V0xWRE50UElaMmlEc084UUpXT3ZOL1lCWnYxV2g3V1pM?=
 =?utf-8?B?UElvamtMQktISHc9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 04:39:47.9386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: f5df619c-4877-4fff-390b-08d8a30ef36b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snVkOtCVduQfgPxu2FB+YIZ9n/pMmKlUSY2I6Jkt2stKpxuwDNYMm38g+J/E2cHU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2645
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_03:2020-12-17,2020-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012180032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/17/20 7:20 PM, Alexei Starovoitov wrote:
> On Thu, Dec 17, 2020 at 09:26:09AM -0800, Yonghong Song wrote:
>>
>>
>> On 12/17/20 7:31 AM, Florent Revest wrote:
>>> On Mon, Dec 14, 2020 at 7:47 AM Yonghong Song <yhs@fb.com> wrote:
>>>> On 12/11/20 6:40 AM, Florent Revest wrote:
>>>>> On Wed, Dec 2, 2020 at 10:18 PM Alexei Starovoitov
>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>> I still think that adopting printk/vsnprintf for this instead of
>>>>>> reinventing the wheel
>>>>>> is more flexible and easier to maintain long term.
>>>>>> Almost the same layout can be done with vsnprintf
>>>>>> with exception of \0 char.
>>>>>> More meaningful names, etc.
>>>>>> See Documentation/core-api/printk-formats.rst
>>>>>
>>>>> I agree this would be nice. I finally got a bit of time to experiment
>>>>> with this and I noticed a few things:
>>>>>
>>>>> First of all, because helpers only have 5 arguments, if we use two for
>>>>> the output buffer and its size and two for the format string and its
>>>>> size, we are only left with one argument for a modifier. This is still
>>>>> enough for our usecase (where we'd only use "%ps" for example) but it
>>>>> does not strictly-speaking allow for the same layout that Andrii
>>>>> proposed.
>>>>
>>>> See helper bpf_seq_printf. It packs all arguments for format string and
>>>> puts them into an array. bpf_seq_printf will unpack them as it parsed
>>>> through the format string. So it should be doable to have more than
>>>> "%ps" in format string.
>>>
>>> This could be a nice trick, thank you for the suggestion Yonghong :)
>>>
>>> My understanding is that this would also require two extra args (one
>>> for the array of arguments and one for the size of this array) so it
>>> would still not fit the 5 arguments limit I described in my previous
>>> email.
>>> eg: this would not be possible:
>>> long bpf_snprintf(const char *out, u32 out_size,
>>>                     const char *fmt, u32 fmt_size,
>>>                    const void *data, u32 data_len)
>>
>> Right. bpf allows only up to 5 parameters.
>>>
>>> Would you then suggest that we also put the format string and its
>>> length in the first and second cells of this array and have something
>>> along the line of:
>>> long bpf_snprintf(const char *out, u32 out_size,
>>>                     const void *args, u32 args_len) ?
>>> This seems like a fairly opaque signature to me and harder to verify.
>>
>> One way is to define an explicit type for args, something like
>>     struct bpf_fmt_str_data {
>>        char *fmt;
>>        u64 fmt_len;
>>        u64 data[];
>>     };
> 
> that feels a bit convoluted.
> 
> The reason I feel unease with the helper as was originally proposed
> and with Andrii's proposal is all the extra strlen and strcpy that
> needs to be done. In the helper we have to call kallsyms_lookup()
> which is ok interface for what it was desinged to do,
> but it's awkward to use to construct new string ("%s [%s]", sym, modname)
> or to send two strings into a ring buffer.
> Andrii's zero separator idea will simplify bpf prog, but user space
> would need to do strlen anyway if it needs to pretty print.
> If we take pain on converting addr to sym+modname let's figure out
> how to make it easy for the bpf prog to do and easy for user space to consume.
> That's why I proposed snprintf.
> 
> As far as 6 arg issue:
> long bpf_snprintf(const char *out, u32 out_size,
>                    const char *fmt, u32 fmt_size,
>                    const void *data, u32 data_len);
> Yeah. It won't work as-is, but fmt_size is unnecessary nowadays.
> The verifier understands read-only data.
> Hence the helper can be:
> long bpf_snprintf(const char *out, u32 out_size,
>                    const char *fmt,
>                    const void *data, u32 data_len);
> The 3rd arg cannot be ARG_PTR_TO_MEM.
> Instead we can introduce ARG_PTR_TO_CONST_STR in the verifier.

This should work except if fmt string is on the stack. Maybe this is
an okay tradeoff.

> See check_mem_access() where it's doing bpf_map_direct_read().
> That 'fmt' string will be accessed through the same bpf_map_direct_read().
> The verifier would need to check that it's NUL-terminated valid string.
> It should probably do % specifier checks at the same time.
> At the end bpf_snprintf() will have 5 args and when wrapped with
> BPF_SNPRINTF() macro it will accept arbitrary number of arguments to print.
> It also will be generally useful to do all other kinds of pretty printing.
> 
