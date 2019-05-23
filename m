Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 316B0277F4
	for <lists+bpf@lfdr.de>; Thu, 23 May 2019 10:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfEWI2u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 May 2019 04:28:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51136 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbfEWI2u (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 May 2019 04:28:50 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4N8SCKY006201;
        Thu, 23 May 2019 01:28:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=owkI1MCeegK0GeLOoOmccJxuY/l436SvZVEL60C/ZCM=;
 b=dWi1duwiYXlWbQhs9369N1iGSE3iNgaEbvfOjF1k6DVQMBRcNrfErhmpZJjcp7+5Oco0
 JnZkRa1HJOaRJubRr44om5RWFbKldlzSgzeRZiFpSb9C6kF6OX3vrXaAeUjjh0QIa5Pw
 ZPFUsozP4ViLmw1bCxbPNSynibyKjySrnYs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sn9bgu00s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 May 2019 01:28:11 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 May 2019 01:28:10 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 May 2019 01:28:10 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 23 May 2019 01:28:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owkI1MCeegK0GeLOoOmccJxuY/l436SvZVEL60C/ZCM=;
 b=DFI/eCLAmR49SaqpqVaDzhwp8DI+EWVjHHHzSTJP2SVw78Ox3FEfjFAHqybAvv4Zv1djvdSJc+TsmksMiISmrXebjyp+K+2/oaXQdCAmUcjAQzhVU0TC7NecUlKJWm8JvXP9cqbSQWoTr6dpr7xCErXx9227LURXmeEznLwjf50=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1136.namprd15.prod.outlook.com (10.175.2.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Thu, 23 May 2019 08:27:50 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1900.020; Thu, 23 May 2019
 08:27:50 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Kairui Song <kasong@redhat.com>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Thread-Topic: Getting empty callchain from perf_callchain_kernel()
Thread-Index: AQHVDEJXbyjc1nknl06FlgTGlvLrzKZu8J8AgAAG+ICAAAFQgIAAD2QAgAO6dwCABHK6gIAADQKAgAAxOYCAAGTygIAAdcuAgAAb14A=
Date:   Thu, 23 May 2019 08:27:50 +0000
Message-ID: <39AB1404-1C9A-43E9-A3EC-AED4AA26DC8C@fb.com>
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
 <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net>
 <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net>
 <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
 <20190522140233.GC16275@worktop.programming.kicks-ass.net>
 <ab047883-69f6-1175-153f-5ad9462c6389@fb.com>
 <20190522174517.pbdopvookggen3d7@treble>
 <20190522234635.a47bettklcf5gt7c@treble>
 <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
In-Reply-To: <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::4db0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 044b308b-45c0-498a-81cb-08d6df588b5d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1136;
x-ms-traffictypediagnostic: MWHPR15MB1136:
x-microsoft-antispam-prvs: <MWHPR15MB113612CFA1486B4D54BB5CF2B3010@MWHPR15MB1136.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(366004)(396003)(346002)(199004)(189003)(478600001)(316002)(81156014)(8676002)(68736007)(14454004)(46003)(81166006)(4326008)(76176011)(53546011)(6506007)(25786009)(50226002)(8936002)(6116002)(446003)(2906002)(82746002)(57306001)(476003)(2616005)(11346002)(486006)(256004)(5024004)(14444005)(86362001)(36756003)(33656002)(71190400001)(83716004)(71200400001)(5660300002)(54906003)(99286004)(6436002)(6486002)(7736002)(305945005)(229853002)(66946007)(73956011)(66446008)(64756008)(66556008)(66476007)(53936002)(6916009)(6512007)(102836004)(186003)(6246003)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1136;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iFLdebaRgElfSwhak0MOze/x9FtOWr5ct+giKSST1mY1HHxBAsfJyaJ1mMQgZQgVsFAdU46XjKZKneYMPd9cCRZTDNK/YFg6abajF0kKI4FZjsWDynKZrnCGqWbprROe/NbxbqKjMvHg6BdFjGUvEJhuev6+9b0GP8/XGgfwE6Y7JnQgUMFpCBpt5HDjBrlnP814ZwFXC+Uflr5V7dzi7yn6nfrjjNPJBRiqc9bzuH4PEgN1uLQfVqZbIv+N6jmoA+kHW97GUW1Ti07tPaRhpFPte1xokqd4ODrVrHRU6fNN+mllMs91NY1hYHFVlujaxfOynCbeHDCe0HtQYQ/swRxJbUhhw69nY6Rk30FXsGm6sfe1x+r9zNzVz3ex1znHJLWi5KZc4qjH/bU14Yr49PrhqMAXKpjYxwZjbi2VRiM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <369C0EAFB3BD2943A719CC1D7F6C5BB1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 044b308b-45c0-498a-81cb-08d6df588b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 08:27:50.6359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1136
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905230061
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On May 22, 2019, at 11:48 PM, Kairui Song <kasong@redhat.com> wrote:
>=20
> On Thu, May 23, 2019 at 7:46 AM Josh Poimboeuf <jpoimboe@redhat.com> wrot=
e:
>>=20
>> On Wed, May 22, 2019 at 12:45:17PM -0500, Josh Poimboeuf wrote:
>>> On Wed, May 22, 2019 at 02:49:07PM +0000, Alexei Starovoitov wrote:
>>>> The one that is broken is prog_tests/stacktrace_map.c
>>>> There we attach bpf to standard tracepoint where
>>>> kernel suppose to collect pt_regs before calling into bpf.
>>>> And that's what bpf_get_stackid_tp() is doing.
>>>> It passes pt_regs (that was collected before any bpf)
>>>> into bpf_get_stackid() which calls get_perf_callchain().
>>>> Same thing with kprobes, uprobes.
>>>=20
>>> Is it trying to unwind through ___bpf_prog_run()?
>>>=20
>>> If so, that would at least explain why ORC isn't working.  Objtool
>>> currently ignores that function because it can't follow the jump table.
>>=20
>> Here's a tentative fix (for ORC, at least).  I'll need to make sure this
>> doesn't break anything else.
>>=20
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 242a643af82f..1d9a7cc4b836 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -1562,7 +1562,6 @@ static u64 ___bpf_prog_run(u64 *regs, const struct=
 bpf_insn *insn, u64 *stack)
>>                BUG_ON(1);
>>                return 0;
>> }
>> -STACK_FRAME_NON_STANDARD(___bpf_prog_run); /* jump table */
>>=20
>> #define PROG_NAME(stack_size) __bpf_prog_run##stack_size
>> #define DEFINE_BPF_PROG_RUN(stack_size) \
>> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
>> index 172f99195726..2567027fce95 100644
>> --- a/tools/objtool/check.c
>> +++ b/tools/objtool/check.c
>> @@ -1033,13 +1033,6 @@ static struct rela *find_switch_table(struct objt=
ool_file *file,
>>                if (text_rela->type =3D=3D R_X86_64_PC32)
>>                        table_offset +=3D 4;
>>=20
>> -               /*
>> -                * Make sure the .rodata address isn't associated with a
>> -                * symbol.  gcc jump tables are anonymous data.
>> -                */
>> -               if (find_symbol_containing(rodata_sec, table_offset))
>> -                       continue;
>> -
>>                rodata_rela =3D find_rela_by_dest(rodata_sec, table_offse=
t);
>>                if (rodata_rela) {
>>                        /*
>=20
> Hi Josh, this still won't fix the problem.
>=20
> Problem is not (or not only) with ___bpf_prog_run, what actually went
> wrong is with the JITed bpf code.
>=20
> For frame pointer unwinder, it seems the JITed bpf code will have a
> shifted "BP" register? (arch/x86/net/bpf_jit_comp.c:217), so if we can
> unshift it properly then it will work.
>=20
> I tried below code, and problem is fixed (only for frame pointer
> unwinder though). Need to find a better way to detect and do any
> similar trick for bpf part, if this is a feasible way to fix it:
>=20
> diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_fram=
e.c
> index 9b9fd4826e7a..2c0fa2aaa7e4 100644
> --- a/arch/x86/kernel/unwind_frame.c
> +++ b/arch/x86/kernel/unwind_frame.c
> @@ -330,8 +330,17 @@ bool unwind_next_frame(struct unwind_state *state)
>        }
>=20
>        /* Move to the next frame if it's safe: */
> -       if (!update_stack_state(state, next_bp))
> -               goto bad_address;
> +       if (!update_stack_state(state, next_bp)) {
> +               // Try again with shifted BP
> +               state->bp +=3D 5; // see AUX_STACK_SPACE
> +               next_bp =3D (unsigned long
> *)READ_ONCE_TASK_STACK(state->task, *state->bp);
> +               // Clean and refetch stack info, it's marked as error out=
ed
> +               state->stack_mask =3D 0;
> +               get_stack_info(next_bp, state->task,
> &state->stack_info, &state->stack_mask);
> +               if (!update_stack_state(state, next_bp)) {
> +                       goto bad_address;
> +               }
> +       }
>=20
>        return true;
>=20
> For ORC unwinder, I think the unwinder can't find any info about the
> JITed part. Maybe if can let it just skip the JITed part and go to
> kernel context, then should be good enough.

In this case (tracepoint), the callchain bpf_get_stackid() fetches is the=20
callchain at the tracepoint. So we don't need the JITed part.=20

BPF program passes the regs at the tracepoint to perf_callchain_kernel().=20
However, perf_callchain_kernel() only uses regs->sp for !perf_hw_regs()
case. This is probably expected, as passing regs in doesn't really help.=20

There are multiple cases in unwind_orc.c:__unwind_start(), which I don't=20
understand very well.=20

Does the above make sense? Did I mis-understand anything?

@Alexei, do you remember some rough time/version that ORC unwinder works
well for tracepoints? Maybe we can dig into that version to see the
difference.  =20

Thanks,
Song

>=20
>=20
>=20
>=20
>=20
> --
> Best Regards,
> Kairui Song

