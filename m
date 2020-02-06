Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3872153C92
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2020 02:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgBFBZl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Feb 2020 20:25:41 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:65378 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727170AbgBFBZk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 5 Feb 2020 20:25:40 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0161PNl6006664;
        Wed, 5 Feb 2020 17:25:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=TVIFi7SQFhMXk9yqui9x9LaY58vm34OX9aRveFcEqNU=;
 b=NuqKfJj3286KGQeIHtvfJ8qIKscw+QuT6/lxwF4/PpI6ULDU/e5p67fQFt34DQnfJ6Sl
 nl59D1uoxFf4HfEdsHKvfwPsRQql5C+I9D6pOlibXtV2Y1zeO2TQouMqyj46hxsEC3JC
 UbK8zhjn0ydzJYADGNCbiAVlaI/GLKaF6tM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xyhmwe40x-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 Feb 2020 17:25:25 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 5 Feb 2020 17:24:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTTi33K7ldbYgKVqWWS9TVVvJ9mthx8KsUxwdEnRquOmPes7Hq0B44MynF08fUqHaZLjNduDHSrda0V5fsZ90YNl55HqThOS08XXS4YcW5pdGfxT3AqEnnN000MyBk70R5wIFmx6/RjXLh8E4PMV0f+K3phZYYTSVDB0WqfTmjS1L+U+lcv9E1crdT4UqnXbuEE/eara8aElKjby8l4Qfzpv8F/dxlZXZwKLhVsHDbmfdmjtdanbwignLsEXjsbTCDCcEOEx8JMABmLQxR8YPK5hU2ENAl35rgLQSzjlxsuVLpAG6m8g/dyprEpmzdDBJXDEXNyyNaBjwBT40nLr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVIFi7SQFhMXk9yqui9x9LaY58vm34OX9aRveFcEqNU=;
 b=RNrjOl2HyAqsaMFMioc7ml5qUgdZDiBekw7ip+2m0Uq7Ojn6UGuyJmIgJrKeNwKQKFvu9K3RPKJq22Q7AdAivY0SvNmudWAWzo13/vpeA/8sWwyS83fHE9AoosXNtOLkrlZvv35Kanjx+0cz8TtEzacWuMthJzhQuhvglXWDbe0/JOIcbC0Bder9Jd1m/DgS1wy/bd0lu3wmtY/WuwfMuHJoly3lZc7bnaoviX0n33hAPU/LAJh9f5p8va0LxUTxw8X7oh4B3jirYlJyQz025Db3qQy6a6tKlaOh+PMRclT4i5mkDHOE56Xro3+0VbCjwoajk0f2Bikr3eFWx2E04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVIFi7SQFhMXk9yqui9x9LaY58vm34OX9aRveFcEqNU=;
 b=idzoBt6rzCCmdUsUyInPeqZiewWgLsn/ivD+kkeRCHnJwr7tqTyWLtk7dkvdxdfmgCX2NYg00l4kldLwMRgNWMJzEsLWve7NcKFZTARv2sM4eLqyxKGrviytflnRzqx7I3tEhP14lTYO2mFEAft+eM3/4S60lSsySodriv3IPcE=
Received: from DM6PR15MB3001.namprd15.prod.outlook.com (20.178.231.16) by
 DM6PR15MB2972.namprd15.prod.outlook.com (20.178.230.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Thu, 6 Feb 2020 01:24:45 +0000
Received: from DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c]) by DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c%4]) with mapi id 15.20.2707.020; Thu, 6 Feb 2020
 01:24:45 +0000
Subject: Re: [bpf PATCH v3] bpf: verifier, do_refine_retval_range may clamp
 umin to 0 incorrectly
To:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
 <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
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
From:   Yonghong Song <yhs@fb.com>
Message-ID: <25e53344-8551-944e-18c7-ae4a260e80f8@fb.com>
Date:   Wed, 5 Feb 2020 17:24:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
In-Reply-To: <5e3a30f3a9221_3b4f2ab2596925b8e3@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0013.namprd14.prod.outlook.com
 (2603:10b6:300:ae::23) To DM6PR15MB3001.namprd15.prod.outlook.com
 (2603:10b6:5:13c::16)
MIME-Version: 1.0
Received: from macbook-pro-52.dhcp.thefacebook.com (2620:10d:c090:200::3:fac5) by MWHPR14CA0013.namprd14.prod.outlook.com (2603:10b6:300:ae::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 01:24:44 +0000
X-Originating-IP: [2620:10d:c090:200::3:fac5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aadb6f4-2931-4840-2fc1-08d7aaa3597a
X-MS-TrafficTypeDiagnostic: DM6PR15MB2972:
X-Microsoft-Antispam-PRVS: <DM6PR15MB2972A408C0D3D5DAC4D2B71ED31D0@DM6PR15MB2972.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(376002)(136003)(396003)(189003)(199004)(5660300002)(110136005)(316002)(54906003)(966005)(86362001)(36756003)(8676002)(81166006)(81156014)(66946007)(2906002)(4326008)(66476007)(66556008)(31686004)(478600001)(31696002)(6506007)(2616005)(53546011)(6512007)(186003)(52116002)(16526019)(8936002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2972;H:DM6PR15MB3001.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zSQnUKXv9hv5UAN4RapEjbiC9fbTrL9ctkRbdSJkJN126FQ/69tCQS79Bd+yiPshHei8RpnpIbfVQyQ7fxuP4Kj6fdKwWfvKfJeiHTkIgC3kqqCg4uwEixv+D+49Jde2xu3QtwMdHTSzUmWhGbUDLNmbzjkVc3cp8tITpLjJhTxfWcN3te3sAiNvXau7l0RJPqoY3OXfKnmkk19L4ZlT+bj5tgi7MeGcvzS753XixfsW0y43KRK1KaKh9HwX3yIsrJVDqI2r/q2V7gSlWBY/Tplw2//fkqLtQhThiaOsCUyIpJXbhTkM6UB/y02LZSkTF/EmD88QtLAsKni6Yj90wcJAsfm96U1K8ehh1WfXwuUGRVVcXCGLzbFpDSi5ECTyNXoDq+mGRKNeETCu3llNzVKJ6EkZ+0Il0OI619gLw8nKKvdQ/cUYMq20EqDT8u6BcrphDXJaLRf+ozmATkUQrV4z5903wtmJnIzvfSUh6iS9ydzjujhCM5qd1DI4pz9/pVc9/xcWTI1nsj+5MffnDA==
X-MS-Exchange-AntiSpam-MessageData: PIFdFNtp9dQxEXQnCA/UHUWSlBfsecut7dxHylI7IFx9QANb0F8PXmwBfBlj6tfg10rsaNPGk0+EjU+Aphl7bSKAw9hrx/ZQ1Xj8xF3hTOW6CDXszA9DXAsiEZDYOCNZiTBKBAcj8t13d5B6pscZ2RvdgDmqleMiWWGaY2hc+LkzZRlT8+xB3Tb/AySeGQnN
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aadb6f4-2931-4840-2fc1-08d7aaa3597a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 01:24:45.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyKWRyOblYMWfAhPpIzfBcCrv8OqEZUq8uYEfp3neNWYYNGvbC4KGQYvFTT7X5fV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2972
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060007
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/4/20 7:05 PM, John Fastabend wrote:
> Yonghong Song wrote:
>>
>>
>> On 2/4/20 11:55 AM, John Fastabend wrote:
>>> Alexei Starovoitov wrote:
>>>> On Fri, Jan 31, 2020 at 9:16 AM John Fastabend <john.fastabend@gmail.com> wrote:
>>>>>
>>>>> Also don't mind to build pseudo instruction here for signed extension
>>>>> but its not clear to me why we are getting different instruction
>>>>> selections? Its not clear to me why sext is being chosen in your case?
> 
> [...]
> 
>>>> zext is there both cases and it will be optimized with your llvm patch.
>>>> So please send it. Don't delay :)
>>>
>>> LLVM patch here, https://urldefense.proofpoint.com/v2/url?u=https-3A__reviews.llvm.org_D73985&d=DwICaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=VnK0SKxGnw_yzWjaO-cZFrmlZB9p86L4me-mWE_vDto&s=jwDJuAEdJ23HVcvIILvkfxvTNSe_cgHQFn_MpXssfXc&e=
>>>
>>> With updated LLVM I can pass selftests with above fix and additional patch
>>> below to get tighter bounds on 32bit registers. So going forward I think
>>> we need to review and assuming it looks good commit above llvm patch and
>>> then go forward with this series.
>>[...]
>> With the above patch, there is still one more issue in test_seg6_loop.o,
>> which is related to llvm code generation, w.r.t. our strange 32bit
>> packet begin and packet end.
>>
>> The following patch is generated:
>>
>> 2: (61) r1 = *(u32 *)(r6 +76)
>> 3: R1_w=pkt(id=0,off=0,r=0,imm=0) R2_w=pkt_end(id=0,off=0,imm=0)
>> R6_w=ctx(id=0,off=0,imm=0) R10=fp0
>> ; cursor = (void *)(long)skb->data;
>> 3: (bc) w8 = w1
>> 4: R1_w=pkt(id=0,off=0,r=0,imm=0) R2_w=pkt_end(id=0,off=0,imm=0)
>> R6_w=ctx(id=0,off=0,imm=0)
>> R8_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0
>> ; if ((void *)ipver + sizeof(*ipver) > data_end)
>> 4: (bf) r3 = r8
>>
>> In the above r1 is packet pointer and after the assignment, it becomes a
>> scalar and will lead later verification failure.
>>
>> Without the patch, we generates:
>> 1: R1=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0) R10=fp0
>> ; data_end = (void *)(long)skb->data_end;
>> 1: (61) r1 = *(u32 *)(r6 +80)
>> 2: R1_w=pkt_end(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0) R10=fp0
>> ; cursor = (void *)(long)skb->data;
>> 2: (61) r8 = *(u32 *)(r6 +76)
>> 3: R1_w=pkt_end(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0)
>> R8_w=pkt(id=0,off=0,r=0,imm=0) R10=fp0
>> ; if ((void *)ipver + sizeof(*ipver) > data_end)
>> 3: (bf) r2 = r8
>> 4: R1_w=pkt_end(id=0,off=0,imm=0) R2_w=pkt(id=0,off=0,r=0,imm=0)
>> R6_w=ctx(id=0,off=0,imm=0) R8_w=pkt(id=0,off=0,r=0,imm=0) R10=fp0
>> 4: (07) r2 += 1
>> 5: R1_w=pkt_end(id=0,off=0,imm=0) R2_w=pkt(id=0,off=1,r=0,imm=0)
>> R6_w=ctx(id=0,off=0,imm=0) R8_w=pkt(id=0,off=0,r=0,imm=0) R10=fp0
>>
>> r2 keeps as a packet pointer, so we don't have issues later.
>>
>> Not sure how we could fix this in llvm as llvm does not really have idea
>> the above w1 in w8 = w1 is a packet pointer.
>>
> 
> OK thanks for analysis. I have this on my stack as well but need to
> check its correct still,
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 320e2df..3072dba7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2804,8 +2804,11 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
>                  reg->umax_value = mask;
>          }
>          reg->smin_value = reg->umin_value;
> -       if (reg->smax_value < 0 || reg->smax_value > reg->umax_value)
> +       if (reg->smax_value < 0 || reg->smax_value > reg->umax_value) {
>                  reg->smax_value = reg->umax_value;
> +       } else {
> +               reg->umax_value = reg->smax_value;
> +       }
>   }
> 
> this helps but still hitting above issue with the packet pointer as
> you pointed out. I'll sort out how we can fix this. Somewhat related

I just fixed llvm to allow itself doing a better job for zext code gen.
https://reviews.llvm.org/D74101
This should solve the above issue.

> we have a similar issue we hit fairly consistently I've been meaning
> to sort out where the cmp happens on a different register then is
> used in the call, for example something like this pseudocode
> 
>     r8 = r2
>     if r8 > blah goto +label
>     r1 = dest_ptr
>     r1 += r2
>     r2 = size
>     r3 = ptr
>     call #some_call
> 
> and the verifier aborts because r8 was verified instead of r2. The
> working plan was to walk back in the def-use chain and sort it out
> but tbd.

I have another llvm patch (not merged yet)
   https://reviews.llvm.org/D72787
to undo some llvm optimization so we do not have the above code.
But the resulted byte code needs some kernel verifier change. The 
following is my previous attempt and you commented on.

https://lore.kernel.org/bpf/20200123191815.1364298-1-yhs@fb.com/T/#m8e3dee022801542ddf15b8e406dc05185f959b4f

I think this is better than making verifier more complex to do 
backtracking. What do you think?


> 
> .John
>     
> 
