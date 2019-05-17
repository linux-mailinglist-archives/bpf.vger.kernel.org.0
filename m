Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBC0B21FDE
	for <lists+bpf@lfdr.de>; Fri, 17 May 2019 23:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfEQVs4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 May 2019 17:48:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57470 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727073AbfEQVsz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 May 2019 17:48:55 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4HLdGuw014136;
        Fri, 17 May 2019 14:48:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=99DsirUeES8fI/He/UC9YgZQLYAFCYV4skA2BE7bZz8=;
 b=m71+ioXux2su/1UXa5+kIalIwHMW8nc5OxZIm4DDQsDmUcnxODmZ2O3RgEE/kIO/MK2u
 f2862LrMARaDhONrdigrMsO/tFuzZTl8iYuoblEiC22M3L/uJbuni7tskvDSY+Z8gMP+
 Y8N8VK2FL4NLk1V14/kgB3/Wti2alkLEpeg= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sj4bmg5kr-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 17 May 2019 14:48:26 -0700
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 17 May 2019 14:48:15 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 17 May 2019 14:48:15 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 17 May 2019 14:48:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99DsirUeES8fI/He/UC9YgZQLYAFCYV4skA2BE7bZz8=;
 b=Q4Tc+d6fEm3A0uqTjc+l6Z8QY8vJyjDG6V2RtGHSf98Qy9q8GBEiB/j5u5W4Eha9M0/OLxhiKW9FVLUnGJj6XSo4re+c6C4ouU4Rj5OB+ZE8OdznoWnjUDQQpPF0pkh8D8QEFMPunkVoxZOe33GP1aPWQG+dniZq723lM3cX0BE=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1648.namprd15.prod.outlook.com (10.175.139.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Fri, 17 May 2019 21:48:14 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 21:48:14 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Alexei Starovoitov <ast@fb.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Kairui Song <kasong@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Thread-Topic: Getting empty callchain from perf_callchain_kernel()
Thread-Index: AQHVDEJXbyjc1nknl06FlgTGlvLrzKZu8J8AgAAG+ICAAAFQgIAAD2QAgACfPoCAACi4gIAAC66A
Date:   Fri, 17 May 2019 21:48:14 +0000
Message-ID: <8449BBF3-E754-4ABC-BFEF-A8F264297F2D@fb.com>
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
 <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net>
 <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net>
 <8C814E68-B0B6-47E4-BDD6-917B01EC62D0@fb.com>
 <c881767d-b6f3-c53e-5c70-556d09ea8d89@fb.com>
In-Reply-To: <c881767d-b6f3-c53e-5c70-556d09ea8d89@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::3:f949]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b181ee31-5ce4-4350-9292-08d6db115d11
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1648;
x-ms-traffictypediagnostic: MWHPR15MB1648:
x-microsoft-antispam-prvs: <MWHPR15MB1648252F86253BAFB6A09DAEB30B0@MWHPR15MB1648.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(346002)(136003)(396003)(189003)(199004)(186003)(66476007)(66556008)(64756008)(57306001)(102836004)(446003)(37006003)(68736007)(478600001)(66446008)(46003)(8936002)(54906003)(2616005)(11346002)(53546011)(6506007)(76176011)(76116006)(4326008)(6862004)(316002)(86362001)(5660300002)(73956011)(66946007)(6246003)(25786009)(82746002)(14454004)(6116002)(36756003)(305945005)(7736002)(6636002)(53936002)(81156014)(6512007)(229853002)(2906002)(6436002)(256004)(50226002)(476003)(6486002)(99286004)(71200400001)(71190400001)(83716004)(81166006)(486006)(8676002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1648;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QUi1hrEjfdNEAtdOIvcL8pPD9Pi12oX1naRkDAcaAwd3bVLryN/HIPFBygVtn9A8EWLLyXVIT+2V4+6rQH2hS8f945cLqmBphECpjYNQYuTVaqX7jXAEoqRbzoKZ/Wy2wKN2kQzz2VPr7RhoZJZ6kbShoe1pRH4lQ8ywcGgmoE1mUq2JT/IRKU6WVgS+s/KW2vMsgcFsgxpwgE+rSYi9L9F5bBBKhTjzVIHT7IpzENvGaZJY10If/Lqx6ezINdyxGRzfIW0OEeIc/THl9O8qK9Hnec33VdQGhRoTugpiUhefNF2Kzd4HvNnogVI2BCv7jJQ0w39zOPMdgva/hpdVuPbmm0Yo9RC/3zgqThu2iQxXZyepcNnPS9Umk8mr4xra5hvbpaxa7CQuvVbAVHxyrLlRuGUKMFVVNEiH+zqQAFg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <84CD2ECF61D29244B5029CBEE63D56A4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b181ee31-5ce4-4350-9292-08d6db115d11
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 21:48:14.0672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1648
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On May 17, 2019, at 2:06 PM, Alexei Starovoitov <ast@fb.com> wrote:
>=20
> On 5/17/19 11:40 AM, Song Liu wrote:
>> +Alexei, Daniel, and bpf
>>=20
>>> On May 17, 2019, at 2:10 AM, Peter Zijlstra <peterz@infradead.org> wrot=
e:
>>>=20
>>> On Fri, May 17, 2019 at 04:15:39PM +0800, Kairui Song wrote:
>>>> Hi, I think the actual problem is that bpf_get_stackid_tp (and maybe
>>>> some other bfp functions) is now broken, or, strating an unwind
>>>> directly inside a bpf program will end up strangely. It have following
>>>> kernel message:
>>>=20
>>> Urgh, what is that bpf_get_stackid_tp() doing to get the regs? I can't
>>> follow.
>>=20
>> I guess we need something like the following? (we should be able to
>> optimize the PER_CPU stuff).
>>=20
>> Thanks,
>> Song
>>=20
>>=20
>> diff --git i/kernel/trace/bpf_trace.c w/kernel/trace/bpf_trace.c
>> index f92d6ad5e080..c525149028a7 100644
>> --- i/kernel/trace/bpf_trace.c
>> +++ w/kernel/trace/bpf_trace.c
>> @@ -696,11 +696,13 @@ static const struct bpf_func_proto bpf_perf_event_=
output_proto_tp =3D {
>>         .arg5_type      =3D ARG_CONST_SIZE_OR_ZERO,
>>  };
>>=20
>> +static DEFINE_PER_CPU(struct pt_regs, bpf_stackid_tp_regs);
>>  BPF_CALL_3(bpf_get_stackid_tp, void *, tp_buff, struct bpf_map *, map,
>>            u64, flags)
>>  {
>> -       struct pt_regs *regs =3D *(struct pt_regs **)tp_buff;
>> +       struct pt_regs *regs =3D this_cpu_ptr(&bpf_stackid_tp_regs);
>>=20
>> +       perf_fetch_caller_regs(regs);
>=20
> No. pt_regs is already passed in. It's the first argument.
> If we call perf_fetch_caller_regs() again the stack trace will be wrong.
> bpf prog should not see itself, interpreter or all the frames in between.

Thanks Alexei! I get it now.=20

In bpf_get_stackid_tp(), the pt_regs is get by dereferencing the first fiel=
d
of tp_buff:

	struct pt_regs *regs =3D *(struct pt_regs **)tp_buff;

tp_buff points to something like

	struct sched_switch_args {
        	unsigned long long pad;
	        char prev_comm[16];
        	int prev_pid;
	        int prev_prio;
        	long long prev_state;
	        char next_comm[16];
        	int next_pid;
	        int next_prio;
	};

where the first field "pad" is a pointer to pt_regs.=20

@Kairui, I think you confirmed that current code will give empty call trace=
=20
with ORC unwinder? If that's the case, can we add regs->ip back? (as in the=
=20
first email of this thread.=20

Thanks,
Song







