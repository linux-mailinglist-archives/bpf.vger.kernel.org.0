Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C485223E5B
	for <lists+bpf@lfdr.de>; Mon, 20 May 2019 19:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733069AbfETRX3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 May 2019 13:23:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54272 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730508AbfETRX2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 May 2019 13:23:28 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4KHLIjK015586;
        Mon, 20 May 2019 10:22:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=9AeCGs9a9Iem7PytN48zI7tnhoLUs54Z23CS0FuqDu4=;
 b=HCBtN0ByARVD7tgPGu4d+Ka9CrYoHUJUKHzBSVbwPVnBRmlGbxxEH/iQiPyVVrTLJfZq
 M0cbLIPjntF2zwva+H6wghMsjm4do/N/VBlVZQs0CJKldLj1TOh/ik989j7kBJYJZ1za
 PoipMa05F7t0QbYMReSn8N6hFDK0eQf9UoU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sjfqyp7k1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 May 2019 10:22:47 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 May 2019 10:22:14 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 20 May 2019 10:22:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AeCGs9a9Iem7PytN48zI7tnhoLUs54Z23CS0FuqDu4=;
 b=BT2RT/68YlrIQF6dZAVHI6udTetG55RnoCLhvXLDey84laqGtrWMVN5G6KCk4Vm3oocqTCka8PzBVPcYn+pkWBVxlXBfjAB/PTokMgr8FVnjnuhF0sg2IdFg7YCjGqmyn5A9TTGFRt8ef64gfbjmv2tio6v6xatHu4y8rZRwIkQ=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1133.namprd15.prod.outlook.com (10.175.2.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Mon, 20 May 2019 17:22:12 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 17:22:12 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Kairui Song <kasong@redhat.com>
CC:     Alexei Starovoitov <ast@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel() 
Thread-Topic: Getting empty callchain from perf_callchain_kernel() 
Thread-Index: AQHVDEJXbyjc1nknl06FlgTGlvLrzKZu8J8AgAAG+ICAAAFQgIAAD2QAgACfPoCAACi4gIAAC66AgALm8YCAAYW5gA==
Date:   Mon, 20 May 2019 17:22:12 +0000
Message-ID: <842A0302-9B36-4FBF-ADF7-9C6749E8C5BE@fb.com>
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
 <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net>
 <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net>
 <8C814E68-B0B6-47E4-BDD6-917B01EC62D0@fb.com>
 <c881767d-b6f3-c53e-5c70-556d09ea8d89@fb.com>
 <8449BBF3-E754-4ABC-BFEF-A8F264297F2D@fb.com>
 <CACPcB9emh9T23sixx-91mg2wL6kgrYF4MVfmuTCE0SsD=8efcQ@mail.gmail.com>
In-Reply-To: <CACPcB9emh9T23sixx-91mg2wL6kgrYF4MVfmuTCE0SsD=8efcQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::1:c888]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc3112f9-704f-4e34-56fe-08d6dd47b254
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1133;
x-ms-traffictypediagnostic: MWHPR15MB1133:
x-microsoft-antispam-prvs: <MWHPR15MB1133039258BE4CFBB5C4A5DDB3060@MWHPR15MB1133.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(396003)(39860400002)(189003)(199004)(51914003)(86362001)(229853002)(6246003)(4743002)(102836004)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(57306001)(6116002)(53546011)(6506007)(8936002)(4326008)(99286004)(73956011)(25786009)(76176011)(54906003)(50226002)(11346002)(53936002)(82746002)(8676002)(81156014)(81166006)(486006)(2616005)(476003)(36756003)(83716004)(71200400001)(71190400001)(446003)(33656002)(6486002)(6436002)(5660300002)(7736002)(256004)(186003)(316002)(6512007)(46003)(478600001)(6916009)(2906002)(68736007)(14454004)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1133;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bay9OpbVvcsu/yiOlssjQvI0+gd9Vc8zObhjZ1MQHSGpgunPzaF5cR+pEkviZAa1oj4PChkMGiueEs/0bO2QF3obxrpVpAXfqdtI8wAAZt+TLALsY03vgvxfcEzquv6I1sqpYfC/gVm0I5P9Om7YB/77fXlYSZj2taifbyNFlth9qCy7nD/MQ6VDUQ0/OhoiIQ4sirZ/XeVhLDvX0iXn9Hxz86GZZN1p/nSNnie9yo7d9flwpVcmAUKEjhbTBd64YdlI8i0AlUl2fJiK9VcdajCflQ3cpiHs6ruacQZ2mhy6zHjrWGFKgm9G/taxrnI8JUS49eK68+eHW+bHeLkq4YxFDVAw75JL1DuBGc69fTm49mi4RqhQ5YiIPEmGgQkhe5Qtu4ZaplmD6c36CH1Yd1e7nAdbqYszqrssdJtXti0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <70568BDCC382ED4D80EE7C1C00232BB2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3112f9-704f-4e34-56fe-08d6dd47b254
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 17:22:12.2130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1133
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905200110
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On May 19, 2019, at 11:07 AM, Kairui Song <kasong@redhat.com> wrote:
>=20
> On Sat, May 18, 2019 at 5:48 AM Song Liu <songliubraving@fb.com> wrote:
>>=20
>>=20
>>=20
>>> On May 17, 2019, at 2:06 PM, Alexei Starovoitov <ast@fb.com> wrote:
>>>=20
>>> On 5/17/19 11:40 AM, Song Liu wrote:
>>>> +Alexei, Daniel, and bpf
>>>>=20
>>>>> On May 17, 2019, at 2:10 AM, Peter Zijlstra <peterz@infradead.org> wr=
ote:
>>>>>=20
>>>>> On Fri, May 17, 2019 at 04:15:39PM +0800, Kairui Song wrote:
>>>>>> Hi, I think the actual problem is that bpf_get_stackid_tp (and maybe
>>>>>> some other bfp functions) is now broken, or, strating an unwind
>>>>>> directly inside a bpf program will end up strangely. It have followi=
ng
>>>>>> kernel message:
>>>>>=20
>>>>> Urgh, what is that bpf_get_stackid_tp() doing to get the regs? I can'=
t
>>>>> follow.
>>>>=20
>>>> I guess we need something like the following? (we should be able to
>>>> optimize the PER_CPU stuff).
>>>>=20
>>>> Thanks,
>>>> Song
>>>>=20
>>>>=20
>>>> diff --git i/kernel/trace/bpf_trace.c w/kernel/trace/bpf_trace.c
>>>> index f92d6ad5e080..c525149028a7 100644
>>>> --- i/kernel/trace/bpf_trace.c
>>>> +++ w/kernel/trace/bpf_trace.c
>>>> @@ -696,11 +696,13 @@ static const struct bpf_func_proto bpf_perf_even=
t_output_proto_tp =3D {
>>>>        .arg5_type      =3D ARG_CONST_SIZE_OR_ZERO,
>>>> };
>>>>=20
>>>> +static DEFINE_PER_CPU(struct pt_regs, bpf_stackid_tp_regs);
>>>> BPF_CALL_3(bpf_get_stackid_tp, void *, tp_buff, struct bpf_map *, map,
>>>>           u64, flags)
>>>> {
>>>> -       struct pt_regs *regs =3D *(struct pt_regs **)tp_buff;
>>>> +       struct pt_regs *regs =3D this_cpu_ptr(&bpf_stackid_tp_regs);
>>>>=20
>>>> +       perf_fetch_caller_regs(regs);
>>>=20
>>> No. pt_regs is already passed in. It's the first argument.
>>> If we call perf_fetch_caller_regs() again the stack trace will be wrong=
.
>>> bpf prog should not see itself, interpreter or all the frames in betwee=
n.
>>=20
>> Thanks Alexei! I get it now.
>>=20
>> In bpf_get_stackid_tp(), the pt_regs is get by dereferencing the first f=
ield
>> of tp_buff:
>>=20
>>        struct pt_regs *regs =3D *(struct pt_regs **)tp_buff;
>>=20
>> tp_buff points to something like
>>=20
>>        struct sched_switch_args {
>>                unsigned long long pad;
>>                char prev_comm[16];
>>                int prev_pid;
>>                int prev_prio;
>>                long long prev_state;
>>                char next_comm[16];
>>                int next_pid;
>>                int next_prio;
>>        };
>>=20
>> where the first field "pad" is a pointer to pt_regs.
>>=20
>> @Kairui, I think you confirmed that current code will give empty call tr=
ace
>> with ORC unwinder? If that's the case, can we add regs->ip back? (as in =
the
>> first email of this thread.
>>=20
>> Thanks,
>> Song
>>=20
>=20
> Hi thanks for the suggestion, yes we can add it should be good an idea
> to always have IP when stack trace is not available.
> But stack trace is actually still broken, it will always give only one
> level of stacktrace (the IP).

I think this is still the best fix/workaround here? And only one level=20
of stack trace should be OK for tracepoint?=20

Thanks,
Song

>=20
> --=20
> Best Regards,
> Kairui Song

