Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64AA2156330
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2020 07:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgBHGYg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Feb 2020 01:24:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37664 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgBHGYg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 8 Feb 2020 01:24:36 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0186OHSj017772;
        Fri, 7 Feb 2020 22:24:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=QOsqc6j94QQAl48bNJfKadkNARMtbqub3gymgt8bsvg=;
 b=UntTlKC4WRpK2ic8PnXGH0gf2wSN5GezktMVxX7IOpqFBiaDFi4u6dcTALZtP8UXunv7
 cPNLDsNeWgSPj0F83V9HL7iB2T7OmChp63iI9kL3sbZO2RaiIBHXMWgO++8lvOb0I8qA
 vfpSp62QJpm78wpycPJvkeBeTGVDUBtM6yo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2y0vk9etjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 07 Feb 2020 22:24:21 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 22:24:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ito5YFsa1k0IIYcIqmlu+bBP35c8jB76GtzFcjWhV5WyHgzPCEka2GAR0Q1cowNQANmDrO3Ot9WOh3ksR24fQLTA3ScYaclyDFDlgTQ/PFbIvem89qa9DpocA9x/gOZ7D+n6d/PMRGZZhbfQSPTiJegxUgJ45s3BCv2DvgETgtqhGu/xjr/Mdw8cHvulhxl8RkI+ez0umvMqfLri1E6C5/25rF9Z42sufTtd2DYW9lfuV6oIUEyyzVoTkzvuYFxmQwkVbh4XXyCzcqxMAhrfUbghmJxFw07aunZVrE6uZQPRIRPLgtW7yXgpVmyno6ubJ33SWmNbXbMDLFRMxqU/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOsqc6j94QQAl48bNJfKadkNARMtbqub3gymgt8bsvg=;
 b=BPB/kk/Fslj1FCve+RsvsxtfNoRbJkxoR1royZFVMwAcvGppQuy7thbpuxo/CRShBDH6I0kKVK/SuAIY1QMhhkPrquqvKtEtNaosPM3/FNQBMryxofF1qTmKJslSbo2a8KXNUBRjhkDsjyanKBotcQ9hDWp/OIytijrhYKeJV3MPXgz+BFIGluu+xveerxROBnwntfl0KbMIG3M0EaLlLVvOn41Exb14vmrzVkDy9pR1pDZFP/WHZMdbAtikZRkQVK0diiw1tsWKqnlNahzeBYopyEk1YoGr/bIN66LoJco850+jgsYFVdWGm+ktLE0bzxnzmy+Be6P50Jvi2OXwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOsqc6j94QQAl48bNJfKadkNARMtbqub3gymgt8bsvg=;
 b=eb7WTjQ8Y17rPqKWaf58ae7MJUzyiKDo96QTlfDCX0ZhyIPiWWIwv5n97B8mFUjQa97cSzwRzbHotcol2CNAHBLhQyraYhOQOWEjCYoWaRCFWXDw+JshqZPrgccCDzFxL52E9V3peZqkB3OqwG3d3pHw36Lmz7EkmR7VoCu/5U4=
Received: from DM6PR15MB3001.namprd15.prod.outlook.com (20.178.231.16) by
 DM6PR15MB3018.namprd15.prod.outlook.com (20.179.16.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Sat, 8 Feb 2020 06:24:05 +0000
Received: from DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c]) by DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c%4]) with mapi id 15.20.2707.024; Sat, 8 Feb 2020
 06:24:04 +0000
Subject: Re: [bpf PATCH v3] bpf: verifier, do_refine_retval_range may clamp
 umin to 0 incorrectly
To:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
 <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net>
 <5e320c9a30f64_2a332aadcd1385bc3f@john-XPS-13-9370.notmuch>
 <20200130000415.dwd7zn6wj7qlms7g@ast-mbp>
 <5e33147f55528_19152af196f745c460@john-XPS-13-9370.notmuch>
 <20200130175935.dauoijsxmbjpytjv@ast-mbp.dhcp.thefacebook.com>
 <5e336803b5773_752d2b0db487c5c06e@john-XPS-13-9370.notmuch>
 <20200131024620.2ctms6f2il6qss3q@ast-mbp>
 <5e33bfb6414eb_7c012b2399b465bcfe@john-XPS-13-9370.notmuch>
 <CAADnVQL+hBuz8AgJ-Tv8iWFoGdpXwSmdqHVzX5NgR_1Lfpx3Yw@mail.gmail.com>
 <5e3460d3a3fb1_4a9b2ab23eff45b82c@john-XPS-13-9370.notmuch>
 <CAADnVQ+m70Pzs33mAhsF0JEx+LVoXrTZyC-szhyk+cNo71GgXw@mail.gmail.com>
 <5e39cc3957bd1_63882ad0d49345c0c5@john-XPS-13-9370.notmuch>
 <fe3e8178-c069-4299-10df-8c983388c48c@fb.com>
 <5e3a30f3a9221_3b4f2ab2596925b8e3@john-XPS-13-9370.notmuch>
 <25e53344-8551-944e-18c7-ae4a260e80f8@fb.com>
 <5e3dccccc0a92_7e1b2b0e9aae25bcec@john-XPS-13-9370.notmuch>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3883ca15-5c4b-8065-3698-988bd08ff55d@fb.com>
Date:   Fri, 7 Feb 2020 22:23:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
In-Reply-To: <5e3dccccc0a92_7e1b2b0e9aae25bcec@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR2201CA0056.namprd22.prod.outlook.com
 (2603:10b6:301:16::30) To DM6PR15MB3001.namprd15.prod.outlook.com
 (2603:10b6:5:13c::16)
MIME-Version: 1.0
Received: from MacBook-Pro-52.local (2620:10d:c090:180::c957) by MWHPR2201CA0056.namprd22.prod.outlook.com (2603:10b6:301:16::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Sat, 8 Feb 2020 06:24:03 +0000
X-Originating-IP: [2620:10d:c090:180::c957]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea3906ca-4042-4186-2f36-08d7ac5f7ee7
X-MS-TrafficTypeDiagnostic: DM6PR15MB3018:
X-Microsoft-Antispam-PRVS: <DM6PR15MB3018A5EEF0C33C237AA38077D31F0@DM6PR15MB3018.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 03077579FF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(6486002)(66476007)(478600001)(6512007)(86362001)(31686004)(2906002)(5660300002)(66556008)(186003)(16526019)(66946007)(966005)(8936002)(2616005)(8676002)(316002)(54906003)(110136005)(53546011)(6506007)(81166006)(81156014)(31696002)(36756003)(52116002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3018;H:DM6PR15MB3001.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPn4KfeO1tg7d63vv/Ucq27TM4mtcdHdHwx1JnWDKUoZaWJMTjz/vUdoD8NlwaNmLdbkT+Wtr9W4/9pa9niYWdrQnCvKRO+P/Pq9Pb7DYdpB/fUqQlhhLQDDPRivtjxPtRt6IREp/TfuSRVNAcEMeurQlErnkbqroAGMigybGXmEGDF7jZ7wnFSs4o3A2J69/or6HKmZHX6obuJjkzqL/54VNA2kklgT8z6wO2bN8NQt5t795hz5Emj7vZkfQJYdXHWZKJPaUtQsE5QxXmT6CVlG+oBpsYRTSD3//vt4DOd0H3IQOrgGYjtES0GHYJECifyoeM7du6TQxwPvaQdELIzvsd3Jm5hfrhpW++nAjehRAQ3UAJ23SLS4HOpJvfIQqNJH3qGRaeQkOX3lzKzrWPIe3AJBghVc4Dutc75C3+MVTsGxOoAn6mh+21gbAy8vXdZsY181BYD8r3ak17/mjAIo/14IQbWF3cQmxFibgNNpb1v2oIYxR0gco7WgFdm/JaTeApbZknC6A4EBF+/seQ==
X-MS-Exchange-AntiSpam-MessageData: f6t/tvBugZ+aF1hTlXZGA5TzMp+oZ1IgWYtJwCVas3ppBGCNNUhZ+bkrWmiH3nzx5oGae6i6ZEmyqNe385aZCLY+gdlUIvSOUkKdESSFkYgMSAAP6VSHVQeUCI6x0NqpWYz9XcQNk3BBs/813gxrOYA29fqHXosl8C0iAU+SC9I=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3906ca-4042-4186-2f36-08d7ac5f7ee7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2020 06:24:04.9044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0SJOvLm08KHnP9JZbrALoTgIjwjpq7aQ4TV7pnGWAugRLc6CNKMq9ikA3cWzrSG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3018
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-07_06:2020-02-07,2020-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002080051
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/7/20 12:47 PM, John Fastabend wrote:
> Yonghong Song wrote:
>>
>>
>> On 2/4/20 7:05 PM, John Fastabend wrote:
>>> Yonghong Song wrote:
>>>>
>>>>
>>>> On 2/4/20 11:55 AM, John Fastabend wrote:
>>>>> Alexei Starovoitov wrote:
>>>>>> On Fri, Jan 31, 2020 at 9:16 AM John Fastabend <john.fastabend@gmail.com> wrote:
>>>>>>>
>>>>>>> Also don't mind to build pseudo instruction here for signed extension
>>>>>>> but its not clear to me why we are getting different instruction
>>>>>>> selections? Its not clear to me why sext is being chosen in your case?
>>>
>>> [...]
>>>
>>>>>> zext is there both cases and it will be optimized with your llvm patch.
>>>>>> So please send it. Don't delay :)
>>>>>
>>>>> LLVM patch here, https://urldefense.proofpoint.com/v2/url?u=https-3A__reviews.llvm.org_D73985&d=DwICaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=VnK0SKxGnw_yzWjaO-cZFrmlZB9p86L4me-mWE_vDto&s=jwDJuAEdJ23HVcvIILvkfxvTNSe_cgHQFn_MpXssfXc&e=
>>>>>
>>>>> With updated LLVM I can pass selftests with above fix and additional patch
>>>>> below to get tighter bounds on 32bit registers. So going forward I think
>>>>> we need to review and assuming it looks good commit above llvm patch and
>>>>> then go forward with this series.
>>>> [...]
>>>> With the above patch, there is still one more issue in test_seg6_loop.o,
>>>> which is related to llvm code generation, w.r.t. our strange 32bit
>>>> packet begin and packet end.
>>>>
>>>> The following patch is generated:
>>>>
>>>> 2: (61) r1 = *(u32 *)(r6 +76)
>>>> 3: R1_w=pkt(id=0,off=0,r=0,imm=0) R2_w=pkt_end(id=0,off=0,imm=0)
>>>> R6_w=ctx(id=0,off=0,imm=0) R10=fp0
>>>> ; cursor = (void *)(long)skb->data;
>>>> 3: (bc) w8 = w1
>>>> 4: R1_w=pkt(id=0,off=0,r=0,imm=0) R2_w=pkt_end(id=0,off=0,imm=0)
>>>> R6_w=ctx(id=0,off=0,imm=0)
>>>> R8_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0
>>>> ; if ((void *)ipver + sizeof(*ipver) > data_end)
>>>> 4: (bf) r3 = r8
>>>>
>>>> In the above r1 is packet pointer and after the assignment, it becomes a
>>>> scalar and will lead later verification failure.
>>>>
>>>> Without the patch, we generates:
>>>> 1: R1=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0) R10=fp0
>>>> ; data_end = (void *)(long)skb->data_end;
>>>> 1: (61) r1 = *(u32 *)(r6 +80)
>>>> 2: R1_w=pkt_end(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0) R10=fp0
>>>> ; cursor = (void *)(long)skb->data;
>>>> 2: (61) r8 = *(u32 *)(r6 +76)
>>>> 3: R1_w=pkt_end(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0)
>>>> R8_w=pkt(id=0,off=0,r=0,imm=0) R10=fp0
>>>> ; if ((void *)ipver + sizeof(*ipver) > data_end)
>>>> 3: (bf) r2 = r8
>>>> 4: R1_w=pkt_end(id=0,off=0,imm=0) R2_w=pkt(id=0,off=0,r=0,imm=0)
>>>> R6_w=ctx(id=0,off=0,imm=0) R8_w=pkt(id=0,off=0,r=0,imm=0) R10=fp0
>>>> 4: (07) r2 += 1
>>>> 5: R1_w=pkt_end(id=0,off=0,imm=0) R2_w=pkt(id=0,off=1,r=0,imm=0)
>>>> R6_w=ctx(id=0,off=0,imm=0) R8_w=pkt(id=0,off=0,r=0,imm=0) R10=fp0
>>>>
>>>> r2 keeps as a packet pointer, so we don't have issues later.
>>>>
>>>> Not sure how we could fix this in llvm as llvm does not really have idea
>>>> the above w1 in w8 = w1 is a packet pointer.
>>>>
>>>
>>> OK thanks for analysis. I have this on my stack as well but need to
>>> check its correct still,
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 320e2df..3072dba7 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -2804,8 +2804,11 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
>>>                   reg->umax_value = mask;
>>>           }
>>>           reg->smin_value = reg->umin_value;
>>> -       if (reg->smax_value < 0 || reg->smax_value > reg->umax_value)
>>> +       if (reg->smax_value < 0 || reg->smax_value > reg->umax_value) {
>>>                   reg->smax_value = reg->umax_value;
>>> +       } else {
>>> +               reg->umax_value = reg->smax_value;
>>> +       }
>>>    }
>>>
>>> this helps but still hitting above issue with the packet pointer as
>>> you pointed out. I'll sort out how we can fix this. Somewhat related
>>
>> I just fixed llvm to allow itself doing a better job for zext code gen.
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__reviews.llvm.org_D74101&d=DwICaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=H-nAm78-zRumhyRoNeSzy3IaT2e1IQSfD7rq-DYkDUM&s=GwE8T2RDQGwRxrmCTHhipk47qj3aJFyICQrm-cBmS9w&e=
>> This should solve the above issue.
> 
> Great applied this but still have one more issue to resolve.

So this one more issue is related to coerce_reg_to_size(), right?

> 
>>
>>> we have a similar issue we hit fairly consistently I've been meaning
>>> to sort out where the cmp happens on a different register then is
>>> used in the call, for example something like this pseudocode
>>>
>>>      r8 = r2
>>>      if r8 > blah goto +label
>>>      r1 = dest_ptr
>>>      r1 += r2
>>>      r2 = size
>>>      r3 = ptr
>>>      call #some_call
>>>
>>> and the verifier aborts because r8 was verified instead of r2. The
>>> working plan was to walk back in the def-use chain and sort it out
>>> but tbd.
>>
>> I have another llvm patch (not merged yet)
>>     https://urldefense.proofpoint.com/v2/url?u=https-3A__reviews.llvm.org_D72787&d=DwICaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=H-nAm78-zRumhyRoNeSzy3IaT2e1IQSfD7rq-DYkDUM&s=yvw4ipXO3Eln_HHZvXPBZS9n-0w2ek5BjKbtG_Q2f4E&e=
>> to undo some llvm optimization so we do not have the above code.
>> But the resulted byte code needs some kernel verifier change. The
>> following is my previous attempt and you commented on.
>>
>> https://lore.kernel.org/bpf/20200123191815.1364298-1-yhs@fb.com/T/#m8e3dee022801542ddf15b8e406dc05185f959b4f
>>
>> I think this is better than making verifier more complex to do
>> backtracking. What do you think?
>>
> 
> In general I think its nice if llvm can continue to optimize as it
> wants and we can verify it. I was hoping to try this next week and
> see how it falls out after getting the above resolved. If it gets
> too ugly sure we can fall back to removing the optimization.

Sounds good. Looking forward to your patch. Thanks!
