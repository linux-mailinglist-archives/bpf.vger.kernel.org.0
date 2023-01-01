Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6251A65AB26
	for <lists+bpf@lfdr.de>; Sun,  1 Jan 2023 20:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjAATU3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 Jan 2023 14:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAATU2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 Jan 2023 14:20:28 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7947F26D1;
        Sun,  1 Jan 2023 11:20:27 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 301FdDSG016860;
        Sun, 1 Jan 2023 11:20:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=qEwAA/mpOvJHvx15zQYgp2GSJ6/Ht1z68HMqHUlxf8Q=;
 b=h8MfqbFBjBZUsHEWX2hc3qA3ZipWG3QYhwrg4BgKYfpogN8uztYEZvRXFuV+badME+2j
 8cASODOPXyu5cbtWLK+DhMvgQ88yA8w7Uphon1j7P0WMimvRetVF6aQTaX/2jYIF949q
 8smwOCZF/JfUa7gdsDiBCjOrEZ4k2AdWfP01aKHhAlV23IsKnp/BvUq3QGPc4u1i9O8U
 oAQ1ms15SdT0poeQLtWMQPSmg3G5DFlG3PcdcViv1QH1DbzSVGqOfMa9SDMzvnxFc38t
 tAwyEeOrv28iRalCWKBlWMFqlTkYNU/ulKiot99OBUyfldkpyJpJ7dkp6K21gsAodslf mQ== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mtn9an4fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 01 Jan 2023 11:20:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJlvDeAYhemdJhIkBSMZ321pknP/YY6ztyyLdASxsIwW9ac3meivaSQvblh4APAMRkgAdCAovmRDxnAsEt56qP1oFybzscxCOc6SacbY+dZR23+XnlfOQO4nShyxR4RqBchyhpvbYYkaANeK619C3823EScazLO1urYY0QIo5bol+WOWaXXOpCWMqmc6ETkKOsOh3+i/ymkFNqszZkNT+DZVFRCnQZjCy9J41rRzzZBG21DpFuy5ZQUtKSItk/am6iKErjUNymjHLG2DUWYQwQq9lQ6X3agl+Nrfc7FifEKAaQLe6EJEY9Hmos0MsS+fCYqAH4CQHcbaivspOiYryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGxrXKAF0+hOrDTavTZEDS/til96eWcf5SBmuLzt8v0=;
 b=aoGwA9B3P3Qw8aEdCnb2c+3d6n8XqlOyU/GzcJ5kH76tzQa5GiigrZRvqb55dCfAKkfAM1BIev7843dcc+mKh115HuHdp9ozB71ZY7ftRYSEAfQBr2LjO9YkytkoW9tDpCSupWxScGKK5UwT7ShtK/T/LO4ho+PFOG2EPTUyQzLFsoG67/N21gl2UL/PuKYFUG9DbIm4AcXyL4g4idZE3npw1ZeVhN7CQ9OTX0AS71oJHnLOc6PJGHnub69GG74TCaOzXKtQJk9g/GkOgSGypPcnIk/JJEUmZwp8o6Cy6VHlmcN4kHoezkGxtEZM2k3f833tF9sh2ODmz7IjJFjsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3337.namprd15.prod.outlook.com (2603:10b6:5:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Sun, 1 Jan
 2023 19:20:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.018; Sun, 1 Jan 2023
 19:20:00 +0000
Message-ID: <04c66278-b044-98e4-2861-218bd159bd15@meta.com>
Date:   Sun, 1 Jan 2023 11:19:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: WARNING in __mark_chain_precision
Content-Language: en-US
To:     Hao Sun <sunhao.th@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CACkBjsaXNceR8ZjkLG=dT3P=4A8SBsg0Z5h5PWLryF5=ghKq=g@mail.gmail.com>
 <Y6C36gvJ2JnwKm3X@google.com>
 <CAEf4BzbY8SDL04W_3Vot6iiYu69Lqg9W9aMCp26+RwLBh6C_0g@mail.gmail.com>
 <ba5aacc8-7e10-e20a-936b-f3f81d7fcf03@meta.com>
 <CAEf4BzY-DMVEpy+mPTObEO56E7=fzqab8zW_4JyBeyGtTqqcXg@mail.gmail.com>
 <29B647B3-174A-4BE7-9E0E-83AE94B0EADF@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <29B647B3-174A-4BE7-9E0E-83AE94B0EADF@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3337:EE_
X-MS-Office365-Filtering-Correlation-Id: f21046ca-4dd5-4b98-2378-08daec2d2d3b
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45bhUtCEfmkabCVoX4l8pjyqS+jN62P2lotPhGsxMSZDsZKJ6R8OzgqbKTKg3weJJNM+AXitDd9CSvEx3sOF1YE6BieDGlfQsH9fqjTmmX1RqHMIIau2wbH+0tGzjAf3G016Qq4BkEgsXT+iLCJPUQ+trgOUO87vXACNzgoo+E29oUOInKNPyXVrhgELLLFgkJQn85xUv60jrHZUUgWqH5fW9W0f4BmwVjDIDNwfEMBBGfidC2mlM0fhmAGF53ev2fdmoETgwpnDvDuEv+fXgHRYp6Bpz05zhgeXSGNefdhJAODQiVSWFis0aqf+eDhaQ5+vTpZQR3r7+qtqRXB0PpxNnVJmWF2+OrFzSr+fcgmNRFhAb6+4lG3vPWxgdU6l5zxr+vWnVZAXXn+XCmeNirmyhPAxVcqKR9zGp6xZQbHjdm6jpGJeInro16s0V933RKj1Yt8Xw39Q04s0Wa+48lCIs0VzfGPLrpXvU6JLPVfxcySYOekHFghaUE+dTORDmY3A72qijZPPDufGU9W8+ydupGAM8WuPsM4piunLLmXFO7gy7Mv1XwQJNzF4f5RmiT/NKkfKEsWSNBom+j+H4Usb0OrOpus/PO+iZUvxgflOvIKYw9G64i2uWoKTpYkiShzOymHYGk/8CgvjE3FkBn5YwzCKaPMWx/GuHBpEZayKrLkHeQiL2BSrQpIrj7oOA5LDpxCtYLCGrrd9MpPS8wb+gMp161d7UowS8xNlNJFVY4c0nzvdWgbtk/2GPISuTD/Y0uBV3sZyzV7Lq4ZYgpAdiUKVp6ZBilX2UsxJkTTzOgSp321+lzJGNLMXc480K7lhcnunzQ/J7s0ZfNFIquybElKi4kuihwXYR3d2uqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199015)(186003)(2616005)(6512007)(53546011)(38100700002)(31696002)(86362001)(83380400001)(36756003)(31686004)(7416002)(316002)(8936002)(41300700001)(5660300002)(8676002)(4326008)(66946007)(66476007)(66556008)(6666004)(478600001)(966005)(6486002)(6506007)(110136005)(54906003)(2906002)(22166005)(10126625003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDhPVGJ2TjR5cnk5bDhhb1lhZTRvdis4cjk3dVdtY0hteGV6WlE5cWl0bjZj?=
 =?utf-8?B?K3ZqdEpDRWJ5WTl2S3k5RXlIRFNMQ0VhMmhwclBqN0xwMlhDaVJwWmVpVTAz?=
 =?utf-8?B?VzBDRVpSMW16bHFOTnV1N1VNZlp0bTdZbU1qVmw2ZWpvNGViNmxoS3hrMVY5?=
 =?utf-8?B?OFZxd3ByTjBCT3BlKytXaWVkNDhsSWk4c016eHl2c2JLVEJ5T1hNQW5EVjQx?=
 =?utf-8?B?RFlPL3E2dE12WjdQUU9wL2JnbitRY2swOWMyRi9HT2hHSmx0SGlaSG5EaXdT?=
 =?utf-8?B?dHZja0VBSDZtK09RMitQdTAvMHhmTXdjMEY3bHp0SkhsWnpZT2tYdThaWnBt?=
 =?utf-8?B?UHc0emxnTUluTTlSL3lzdUVTNHhRdTBaeHdIbXBkM1FieGxSeWZ4L01mWnZv?=
 =?utf-8?B?Q2lPeVF1ZkthU2hHcTdWWFNSV3BnVXhzcFhIenVxUVA3THNPRW9TNFY5eVRm?=
 =?utf-8?B?YkhZUFVrQUpERWpwT0NzSFlqVG1JWjhROEMzZ3BrWWZISDJyRDFHajJMYTM1?=
 =?utf-8?B?RG5vZ3JIemdNdWx1ODdreS9xWFhLbnBYQnR5SVpqOGZ2dzdzMEFoYWFYeWh5?=
 =?utf-8?B?MDBDUTNDRHVvMWEzWllJR1g2dzhoL01JTVM4YnlsbW1PZzU0ejZFZWcxMFFV?=
 =?utf-8?B?Rnp0Vk1CR0hscU15Z1U4bkhnUXA2MVhsbE9kL0ZCSFIzQWQ3d3pUZW5rVFFS?=
 =?utf-8?B?Y3YrMEppWC9DcjRvM3BnVU9DV2tqeXF4Z3RTcnZWbnE2eFB1ajVEclAvSVI0?=
 =?utf-8?B?SmdEWUtQOGhrMFN3OWdsMUJTM280aGpxOXJzSHp4Y051OTYwSWpnYXV5alZl?=
 =?utf-8?B?Z1VxbDFHSENMb0JSNjFINE0ydkZCTWdGak9DMk1jMWNlRnk3VXZLTmtzbXF6?=
 =?utf-8?B?SWJnNFFYVkZLblNVSklqaXltNDYwemMxdkFTZVRGSGp6Uyt5TnVVTGRtbDZn?=
 =?utf-8?B?YTRJcHRLU0JMNWdWUytnRHhLTGwwajRTbXFaWXRXb1h6SFhSREhPcHFMQW0v?=
 =?utf-8?B?L0JXSFVXYzFzVGJNbWFNMHVTSHcwcmt2dmh6WDNhR2IvUEd0RnpFN0VrUUtJ?=
 =?utf-8?B?WUhiSjRTOFQwWDErNmJwNGJxYStWOFRxL2M0Si9GNXNlSnpyTFc5TGRXbk1l?=
 =?utf-8?B?NTdRTmZ5K216cnFxbjNxbC9SRDQ3WFI5bVc2U0xtemNTd1hrRCt4VisxZERt?=
 =?utf-8?B?Nnk4MnFTSjl2STlma2VwMllrTzljckdOYU9rUVk1c1RPd2RzdXVScW0xSUZo?=
 =?utf-8?B?T25IZ0w2c0NsTGJKMUx6WCtTYXI1VlRGcmxnWEp1dXJrUmg0UXZZV1FaOUdW?=
 =?utf-8?B?WEoxZzlzSVhxU2taMnFMWWhsSTVtQW8zRitMejVmRmNpd05sWmY3VDc5eWMv?=
 =?utf-8?B?MXJyWU52YytqV2YxKzhXZmYvTUZadmpCSkpnMGd3dk14WUhwZTZxYjBXN3Iz?=
 =?utf-8?B?ZmpSNmdCN0NiTndGRHNUcGF3Nkh4YmJPKzAweDdDY2RlZllLZDNIZEdyZGcz?=
 =?utf-8?B?a0ZZZzI4NnFDWmp1WFNobzBiQlBTNkZnQ2pwTXMwbDVWQVdQVXlDYUJ3c3Rn?=
 =?utf-8?B?NjI1SlpVUzc3eE1FRkdWdnRRVldYMEhoUmZKZXovUlpadTVLMlEzNkZYUlhE?=
 =?utf-8?B?TjcrbDR1TEpkL3ZaQkJXeHVsNXp3MDAxa1ZBUEozNjlUQmw2ZFF4YU1CWjhI?=
 =?utf-8?B?QjdQeGtlbEZyaEFTb3VjSlZaWi8wdEpkOU1yRjZaOHdVTXVWK1NOMnhQb24z?=
 =?utf-8?B?SFh3NWxrQmJuZzM3Y2ZVNE1ObGRKazJRQXd6UVluVzFCc2t1djg1bXVNbWNj?=
 =?utf-8?B?NkYzcmx3M2k4cVBrUTkrUG03ejFwUWtkQURRd0RJdFpnRU5ZcFJ1QnVkV3Ro?=
 =?utf-8?B?THFWcUtwdmFNbTd1VXArMVBaNnFBNVhYSEdFdnVDRVZFckM0ckZFem93QzM5?=
 =?utf-8?B?ZUFWZVhycndGOXFmelp2dThLajNFT2gxTmUrSEpUWVM1VGpWcTdyNEN4OWk3?=
 =?utf-8?B?d00xNmZUTTdIZlBTNzVPbkc4azBxbkVqQWNhalpTdk9BTDd5WDgzUTNyUXV4?=
 =?utf-8?B?OXlJb2ppSklyTEtNb0FkSDJ5enN4QUZOYUhyMVcrVXlmd0Q2TVBtbE1Mb1RH?=
 =?utf-8?B?WGw1SXJUTXM3ZjcvSzJLa3lVdDRUK1gzczg3T0ZxMWpKeVl4czA3Qm8rdzk3?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21046ca-4dd5-4b98-2378-08daec2d2d3b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2023 19:20:00.4911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvnFZQrlpUKTfkmmNNZWK3d2SFpG1UlWCdmX6wB98eZ7gQqFKKwxlYQbkUu+y8ni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3337
X-Proofpoint-ORIG-GUID: -FUo-hSH9DY5EEGWzkPAA0BYs4ikRx-i
X-Proofpoint-GUID: -FUo-hSH9DY5EEGWzkPAA0BYs4ikRx-i
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-01_09,2022-12-30_01,2022-06-22_01
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/30/22 1:44 AM, Hao Sun wrote:
> 
> 
> Andrii Nakryiko <andrii.nakryiko@gmail.com> 于2022年12月30日周五 06:16写道：
>>
>> On Tue, Dec 27, 2022 at 9:24 PM Yonghong Song <yhs@meta.com> wrote:
>>>
>>>
>>>
>>> On 12/20/22 4:30 PM, Andrii Nakryiko wrote:
>>>> On Mon, Dec 19, 2022 at 11:13 AM <sdf@google.com> wrote:
>>>>>
>>>>> On 12/19, Hao Sun wrote:
>>>>>> Hi,
>>>>>
>>>>>> The following backtracking bug can be triggered on the latest bpf-next and
>>>>>> Linux 6.1 with the C prog provided. I don't have enough knowledge about
>>>>>> this part in the verifier, don't know how to fix this.
>>>>>
>>>>> Maybe something related to commit be2ef8161572 ("bpf: allow precision
>>>>> tracking
>>>>> for programs with subprogs") and/or the related ones?
>>>>>
>>>>>
>>>>>> This can be reproduced on:
>>>>>
>>>>>> HEAD commit: 0e43662e61f2 tools/resolve_btfids: Use pkg-config to locate
>>>>>> libelf
>>>>>> git tree: bpf-next
>>>>>> console log: https://pastebin.com/raw/45hZ7iqm
>>>>>> kernel config: https://pastebin.com/raw/0pu1CHRm
>>>>>> C reproducer: https://pastebin.com/raw/tqsiezvT
>>>>>
>>>>>> func#0 @0
>>>>>> 0: R1=ctx(off=0,imm=0) R10=fp0
>>>>>> 0: (18) r2 = 0x8000000000000          ; R2_w=2251799813685248
>>>>>> 2: (18) r6 = 0xffff888027358000       ;
>>>>>> R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0)
>>>>>> 4: (18) r7 = 0xffff88802735a000       ;
>>>>>> R7_w=map_ptr(off=0,ks=156,vs=2624,imm=0)
>>>>>> 6: (18) r8 = 0xffff88802735e000       ;
>>>>>> R8_w=map_ptr(off=0,ks=2396,vs=76,imm=0)
>>>>>> 8: (18) r9 = 0x8e9700000000           ; R9_w=156779191205888
>>>>>> 10: (36) if w9 >= 0xffffffe3 goto pc+1
>>>>>> last_idx 10 first_idx 0
>>>>>> regs=200 stack=0 before 8: (18) r9 = 0x8e9700000000
>>>>>> 11: R9_w=156779191205888
>>>>>> 11: (85) call #0
>>>>>> 12: (cc) w2 s>>= w7
>>>>
>>>> w2 should have been set to NOT_INIT (because r1-r5 are clobbered by
>>>> calls) and rejected here as !read_ok (see check_reg_arg()) before
>>>> attempting to mark precision for r2. Can you please try to debug and
>>>> understand why that didn't happen here?
>>>
>>> The verifier is doing the right thing here and the 'call #0' does
>>> implicitly cleared r1-r5.
>>>
>>> So for 'w2 s>>= w7', since w2 is used, the verifier tries to find
>>> its definition by backtracing. It encountered 'call #0', which clears
>>
>> and that's what I'm saying is incorrect. Normally we'd get !read_ok
>> error because s>>= is both READ and WRITE on w2, which is
>> uninitialized after call instruction according to BPF ABI. And that's
>> what actually seems to happen correctly in my (simpler) tests locally.
>> But something is special about this specific repro that somehow either
>> bypasses this logic, or attempts to mark precision before we get to
>> that test. That's what we should investigate. I haven't tried to run
>> this specific repro locally yet, so can't tell for sure.
>>
> 
> So, the reason why w2 is not marked as uninit is that the kfunc call in
> the BPF program is invalid, "call #0", imm is zero, right?

Yes, "call #0" is invalid. As the code below

 > /* skip for now, but return error when we find this in 
fixup_kfunc_call */
 >   if (!insn->imm)
 >   return 0;

The error report will be delayed later in fixup_kfunc_call().

static int fixup_kfunc_call(struct bpf_verifier_env *env, struct 
bpf_insn *insn,
                             struct bpf_insn *insn_buf, int insn_idx, 
int *cnt)
{
         const struct bpf_kfunc_desc *desc;

         if (!insn->imm) {
                 verbose(env, "invalid kernel function call not 
eliminated in verifier pass\n");
                 return -EINVAL;
         }


> In check_kfunc_call(), it skips this error temporarily:
> 
> /* skip for now, but return error when we find this in fixup_kfunc_call */
>   if (!insn->imm)
>   return 0;
> 
> So the kfunc call is the previous instruction before "w2 s>>= w7", this
> leads to the warning in backtrack_insn():
> 
> /* regular helper call sets R0 */
> *reg_mask &= ~1;
> if (*reg_mask & 0x3f) {
> 	/* if backtracing was looking for registers R1-R5
> 	* they should have been found already.
> 	*/
> 	verbose(env, "BUG regs %x\n", *reg_mask);
> 	WARN_ONCE(1, "verifier backtracking bug”);
> 	return -EFAULT;
> }

The main triggering the backtrack_insn() is due to

                         } else {
                                 /* scalar += pointer
                                  * This is legal, but we have to 
reverse our
                                  * src/dest handling in computing the range
                                  */
                                 err = mark_chain_precision(env, 
insn->dst_reg);
                                 if (err)
                                         return err;
                                 return adjust_ptr_min_max_vals(env, insn,
                                                                src_reg, 
dst_reg);
                         }


unc#0 @0
0: R1=ctx(off=0,imm=0) R10=fp0
0: (18) r2 = 0x8000000000000          ; R2_w=2251799813685248
2: (18) r6 = 0xffff888100d29000       ; 
R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0)
4: (18) r7 = 0xffff888100d2a000       ; 
R7_w=map_ptr(off=0,ks=156,vs=2624,imm=0)
6: (18) r8 = 0xffff888100d2ac00       ; 
R8_w=map_ptr(off=0,ks=2396,vs=76,imm=0)
8: (18) r9 = 0x8e9700000000           ; R9_w=156779191205888
10: (36) if w9 >= 0xffffffe3 goto pc+1
last_idx 10 first_idx 0
regs=200 stack=0 before 8: (18) r9 = 0x8e9700000000
11: R9_w=156779191205888
11: (85) call #0
12: (cc) w2 s>>= w7
last_idx 12 first_idx 12
parent didn't have regs=4 stack=0 marks: R1=ctx(off=0,imm=0) 
R2_rw=P2251799813685248 R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0) 
R7_rw=map_ptr(off=0,ks=156,vs=2624,imm=0) R8_w=map_ptr(off=0,ks=2396,v0
last_idx 11 first_idx 0
regs=4 stack=0 before 11: (85) call #0
BUG regs 4

For insn 12, 'w2 s>>= w7', w2 is a scalar and w7 is a map_ptr. Hence, 
based on the above verifier code, mark_chain_precision() is triggered.

Not sure what is the purpose of this test. But to make it succeed,
first "call #0" need to change to a valid kfunc call, and second, you
might want to change 'w2 s>>= w7' to e.g., 'w9 s>>= w7' to avoid
precision tracking.

> 
> Any idea or hint on how to fix this?
> 
