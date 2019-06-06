Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 929D137928
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 18:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfFFQGu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 12:06:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51230 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729547AbfFFQGu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jun 2019 12:06:50 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56G3ogJ025889;
        Thu, 6 Jun 2019 09:05:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=cIGmWU9qScH0a3K6crM38GOKqqmstjqdb77S68MYp4s=;
 b=HD2upiB+Iapns1DK4Em+If0UMjV44GyoNZXuktV1HCKWkSCO6aaOAWXudj61Z/nT/HXp
 ZKFjJaVQKgq3Vv/qECLYwN64Xa4nNLbkxj31Q06OlNcA4UjXCDbBixL443Nd/o70ctLB
 nrEhhHsGIqP4UTi2p/xgPJhL6ivER4aZmrY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sxsmr2fc4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 06 Jun 2019 09:05:17 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 6 Jun 2019 09:04:51 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 6 Jun 2019 09:04:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIGmWU9qScH0a3K6crM38GOKqqmstjqdb77S68MYp4s=;
 b=KlZXW1l97+z3A7zC+7zFB5VAVqoT00NDxYLxGUKZQyQ15He8i/UrR656j9zv8PEgl+TijG4H6vUYhvR2qRgmFbgu89ZmL6aRl4n7BI5ayL0VZhRdd8H63rS3sp9bO+j19Ham5/G5LomE2EwnLzvQYW6bBl1Vr5J/ECL28Eze/po=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1549.namprd15.prod.outlook.com (10.173.235.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Thu, 6 Jun 2019 16:04:49 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 16:04:49 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Kairui Song <kasong@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
CC:     Alexei Starovoitov <ast@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel() 
Thread-Topic: Getting empty callchain from perf_callchain_kernel() 
Thread-Index: AQHVDEJXbyjc1nknl06FlgTGlvLrzKZu8J8AgAAG+ICAAAFQgIAAD2QAgAO6dwCABHK6gIAADQKAgAAxOYCAAGTygIAAdcuAgABxE4CAABWoAIAACXOAgAAVuoCAAAylAIAAlRgAgAFgsQCAA/dzAIAP/F6A
Date:   Thu, 6 Jun 2019 16:04:48 +0000
Message-ID: <145B7F65-2E06-4266-A816-A3445FE47638@fb.com>
References: <ab047883-69f6-1175-153f-5ad9462c6389@fb.com>
 <20190522174517.pbdopvookggen3d7@treble>
 <20190522234635.a47bettklcf5gt7c@treble>
 <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
 <20190523133253.tad6ywzzexks6hrp@treble>
 <CACPcB9fQKg7xhzhCZaF4UGi=EQs1HLTFgg-C_xJQaUfho3yMyA@mail.gmail.com>
 <20190523152413.m2pbnamihu3s2c5s@treble>
 <CACPcB9e0mL6jdNWfH-2K-rkvmQiz=G6mtLiZ+AEmp3-V0x+Z8A@mail.gmail.com>
 <20190523172714.6fkzknfsuv2t44se@treble>
 <CACPcB9dHzht9v9G9_z6oe5AAwgxCTuswRLxTB29vhWphqBO5Ng@mail.gmail.com>
 <20190524232312.upjixcrnidlibikd@treble>
 <CACPcB9cFGQ6OU7Zk=q_c8V8ob6vg3HMaaXGaNjaKn8rvS-wg-g@mail.gmail.com>
In-Reply-To: <CACPcB9cFGQ6OU7Zk=q_c8V8ob6vg3HMaaXGaNjaKn8rvS-wg-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::3:bed9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acd80779-bdbe-4c20-a380-08d6ea98b3ba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1549;
x-ms-traffictypediagnostic: MWHPR15MB1549:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB15496BE81B8514FC14008599B3170@MWHPR15MB1549.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(136003)(199004)(189003)(53546011)(6306002)(5660300002)(30864003)(6506007)(102836004)(4326008)(478600001)(6436002)(11346002)(71200400001)(6486002)(5024004)(4743002)(71190400001)(6246003)(68736007)(53946003)(966005)(54906003)(99286004)(6512007)(86362001)(110136005)(14444005)(76176011)(316002)(53936002)(229853002)(256004)(50226002)(81166006)(7736002)(36756003)(305945005)(66446008)(486006)(66476007)(8936002)(64756008)(46003)(2616005)(73956011)(57306001)(83716004)(6116002)(14454004)(66946007)(476003)(2906002)(66556008)(33656002)(81156014)(76116006)(82746002)(8676002)(446003)(25786009)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1549;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xLF5l8MKYDun3oQ2mLqJnWSXxg75YjLRrv0NYE5T7Yao2PJ65lL+g4sgPBpRrUPcwf9ERslOnzQhqOU8/FoPyQJKdVt9ZlUz8+8fu8CsDupFqqeU8UstebUzxMjkIP0+egBVxjK/yXFzWAqbTkwojyoEZ0bMwRgclRO77pxEIKSqzBMYmDSB1e/mnPWcpNP36JSk1rh1buKW8KGRylMSJbIb/s37JkQ+wK7sHXRm1Qt4qalhppxnf4H6SYVylwkdFMqx6IUtyiYD1HvJfAyvxeMUGd6a/B0O9DE9O7koa6eZVx7r7lFcPyfWGa8A5R8OulC9NUlE5BURRHaEImoHFkwQhkWxqXz86JFkYvSQn37WRPuYFzUqm91RgEms5BHgAtwLivOfDV3XbNHZXeilW9jMEuMTdKu6DHPtO8PEvcs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0DCD9E610647B04F844097380A168886@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: acd80779-bdbe-4c20-a380-08d6ea98b3ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 16:04:48.9214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1549
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060109
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On May 27, 2019, at 4:57 AM, Kairui Song <kasong@redhat.com> wrote:
>=20
> On Sat, May 25, 2019 at 7:23 AM Josh Poimboeuf <jpoimboe@redhat.com> wrot=
e:
>>=20
>> On Fri, May 24, 2019 at 10:20:52AM +0800, Kairui Song wrote:
>>> On Fri, May 24, 2019 at 1:27 AM Josh Poimboeuf <jpoimboe@redhat.com> wr=
ote:
>>>>=20
>>>> On Fri, May 24, 2019 at 12:41:59AM +0800, Kairui Song wrote:
>>>>> On Thu, May 23, 2019 at 11:24 PM Josh Poimboeuf <jpoimboe@redhat.com>=
 wrote:
>>>>>>=20
>>>>>> On Thu, May 23, 2019 at 10:50:24PM +0800, Kairui Song wrote:
>>>>>>>>> Hi Josh, this still won't fix the problem.
>>>>>>>>>=20
>>>>>>>>> Problem is not (or not only) with ___bpf_prog_run, what actually =
went
>>>>>>>>> wrong is with the JITed bpf code.
>>>>>>>>=20
>>>>>>>> There seem to be a bunch of issues.  My patch at least fixes the f=
ailing
>>>>>>>> selftest reported by Alexei for ORC.
>>>>>>>>=20
>>>>>>>> How can I recreate your issue?
>>>>>>>=20
>>>>>>> Hmm, I used bcc's example to attach bpf to trace point, and with th=
at
>>>>>>> fix stack trace is still invalid.
>>>>>>>=20
>>>>>>> CMD I used with bcc:
>>>>>>> python3 ./tools/stackcount.py t:sched:sched_fork
>>>>>>=20
>>>>>> I've had problems in the past getting bcc to build, so I was hoping =
it
>>>>>> was reproducible with a standalone selftest.
>>>>>>=20
>>>>>>> And I just had another try applying your patch, self test is also f=
ailing.
>>>>>>=20
>>>>>> Is it the same selftest reported by Alexei?
>>>>>>=20
>>>>>>  test_stacktrace_map:FAIL:compare_map_keys stackid_hmap vs. stackmap=
 err -1 errno 2
>>>>>>=20
>>>>>>> I'm applying on my local master branch, a few days older than
>>>>>>> upstream, I can update and try again, am I missing anything?
>>>>>>=20
>>>>>> The above patch had some issues, so with some configs you might see =
an
>>>>>> objtool warning for ___bpf_prog_run(), in which case the patch doesn=
't
>>>>>> fix the test_stacktrace_map selftest.
>>>>>>=20
>>>>>> Here's the latest version which should fix it in all cases (based on
>>>>>> tip/master):
>>>>>>=20
>>>>>>  https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/=
commit/?h=3Dbpf-orc-fix
>>>>>=20
>>>>> Hmm, I still get the failure:
>>>>> test_stacktrace_map:FAIL:compare_map_keys stackid_hmap vs. stackmap
>>>>> err -1 errno 2
>>>>>=20
>>>>> And I didn't see how this will fix the issue. As long as ORC need to
>>>>> unwind through the JITed code it will fail. And that will happen
>>>>> before reaching ___bpf_prog_run.
>>>>=20
>>>> Ok, I was able to recreate by doing
>>>>=20
>>>>  echo 1 > /proc/sys/net/core/bpf_jit_enable
>>>>=20
>>>> first.  I'm guessing you have CONFIG_BPF_JIT_ALWAYS_ON.
>>>>=20
>>>=20
>>> Yes, with JIT off it will be fixed. I can confirm that.
>>=20
>> Here's a tentative BPF fix for the JIT frame pointer issue.  It was a
>> bit harder than I expected.  Encoding r12 as a base register requires a
>> SIB byte, so I had to add support for encoding that.  I also simplified
>> the prologue to resemble a GCC prologue, which decreases the prologue
>> size quite a bit.
>>=20
>> Next week I can work on the corresponding ORC change.  Then I can clean
>> all the patches up and submit them properly.

Hi Josh,=20

Have you got luck fixing the ORC side?

Thanks,
Song

>>=20
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index afabf597c855..c9b4503558c9 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -104,9 +104,8 @@ static int bpf_size_to_x86_bytes(int bpf_size)
>> /*
>>  * The following table maps BPF registers to x86-64 registers.
>>  *
>> - * x86-64 register R12 is unused, since if used as base address
>> - * register in load/store instructions, it always needs an
>> - * extra byte of encoding and is callee saved.
>> + * RBP isn't used; it needs to be preserved to allow the unwinder to mo=
ve
>> + * through generated code stacks.
>>  *
>>  * Also x86-64 register R9 is unused. x86-64 register R10 is
>>  * used for blinding (if enabled).
>> @@ -122,7 +121,7 @@ static const int reg2hex[] =3D {
>>        [BPF_REG_7] =3D 5,  /* R13 callee saved */
>>        [BPF_REG_8] =3D 6,  /* R14 callee saved */
>>        [BPF_REG_9] =3D 7,  /* R15 callee saved */
>> -       [BPF_REG_FP] =3D 5, /* RBP readonly */
>> +       [BPF_REG_FP] =3D 4, /* R12 readonly */
>>        [BPF_REG_AX] =3D 2, /* R10 temp register */
>>        [AUX_REG] =3D 3,    /* R11 temp register */
>> };
>> @@ -139,6 +138,7 @@ static bool is_ereg(u32 reg)
>>                             BIT(BPF_REG_7) |
>>                             BIT(BPF_REG_8) |
>>                             BIT(BPF_REG_9) |
>> +                            BIT(BPF_REG_FP) |
>>                             BIT(BPF_REG_AX));
>> }
>>=20
>> @@ -147,6 +147,11 @@ static bool is_axreg(u32 reg)
>>        return reg =3D=3D BPF_REG_0;
>> }
>>=20
>> +static bool is_sib_reg(u32 reg)
>> +{
>> +       return reg =3D=3D BPF_REG_FP;
>> +}
>> +
>> /* Add modifiers if 'reg' maps to x86-64 registers R8..R15 */
>> static u8 add_1mod(u8 byte, u32 reg)
>> {
>> @@ -190,15 +195,13 @@ struct jit_context {
>> #define BPF_MAX_INSN_SIZE      128
>> #define BPF_INSN_SAFETY                64
>>=20
>> -#define AUX_STACK_SPACE                40 /* Space for RBX, R13, R14, R=
15, tailcnt */
>> -
>> -#define PROLOGUE_SIZE          37
>> +#define PROLOGUE_SIZE          25
>>=20
>> /*
>>  * Emit x86-64 prologue code for BPF program and check its size.
>>  * bpf_tail_call helper will skip it while jumping into another program
>>  */
>> -static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_c=
bpf)
>> +static void emit_prologue(u8 **pprog, u32 stack_depth)
>> {
>>        u8 *prog =3D *pprog;
>>        int cnt =3D 0;
>> @@ -206,40 +209,67 @@ static void emit_prologue(u8 **pprog, u32 stack_de=
pth, bool ebpf_from_cbpf)
>>        /* push rbp */
>>        EMIT1(0x55);
>>=20
>> -       /* mov rbp,rsp */
>> +       /* mov rbp, rsp */
>>        EMIT3(0x48, 0x89, 0xE5);
>>=20
>> -       /* sub rsp, rounded_stack_depth + AUX_STACK_SPACE */
>> -       EMIT3_off32(0x48, 0x81, 0xEC,
>> -                   round_up(stack_depth, 8) + AUX_STACK_SPACE);
>> +       /* push r15 */
>> +       EMIT2(0x41, 0x57);
>> +       /* push r14 */
>> +       EMIT2(0x41, 0x56);
>> +       /* push r13 */
>> +       EMIT2(0x41, 0x55);
>> +       /* push r12 */
>> +       EMIT2(0x41, 0x54);
>> +       /* push rbx */
>> +       EMIT1(0x53);
>>=20
>> -       /* sub rbp, AUX_STACK_SPACE */
>> -       EMIT4(0x48, 0x83, 0xED, AUX_STACK_SPACE);
>> +       /*
>> +        * Push the tail call counter (tail_call_cnt) for eBPF tail call=
s.
>> +        * Initialized to zero.
>> +        *
>> +        * push $0
>> +        */
>> +       EMIT2(0x6a, 0x00);
>>=20
>> -       /* mov qword ptr [rbp+0],rbx */
>> -       EMIT4(0x48, 0x89, 0x5D, 0);
>> -       /* mov qword ptr [rbp+8],r13 */
>> -       EMIT4(0x4C, 0x89, 0x6D, 8);
>> -       /* mov qword ptr [rbp+16],r14 */
>> -       EMIT4(0x4C, 0x89, 0x75, 16);
>> -       /* mov qword ptr [rbp+24],r15 */
>> -       EMIT4(0x4C, 0x89, 0x7D, 24);
>> +       /*
>> +        * R12 is used for the BPF program's FP register.  It points to =
the end
>> +        * of the program's stack area.
>> +        *
>> +        * mov r12, rsp
>> +        */
>> +       EMIT3(0x49, 0x89, 0xE4);
>>=20
>> -       if (!ebpf_from_cbpf) {
>> -               /*
>> -                * Clear the tail call counter (tail_call_cnt): for eBPF=
 tail
>> -                * calls we need to reset the counter to 0. It's done in=
 two
>> -                * instructions, resetting RAX register to 0, and moving=
 it
>> -                * to the counter location.
>> -                */
>> +       /* sub rsp, rounded_stack_depth */
>> +       EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
>>=20
>> -               /* xor eax, eax */
>> -               EMIT2(0x31, 0xc0);
>> -               /* mov qword ptr [rbp+32], rax */
>> -               EMIT4(0x48, 0x89, 0x45, 32);
>> +       BUILD_BUG_ON(cnt !=3D PROLOGUE_SIZE);
>>=20
>> -               BUILD_BUG_ON(cnt !=3D PROLOGUE_SIZE);
>> -       }
>> +       *pprog =3D prog;
>> +}
>> +
>> +static void emit_epilogue(u8 **pprog)
>> +{
>> +       u8 *prog =3D *pprog;
>> +       int cnt =3D 0;
>> +
>> +       /* lea rsp, [rbp-0x28] */
>> +       EMIT4(0x48, 0x8D, 0x65, 0xD8);
>> +
>> +       /* pop rbx */
>> +       EMIT1(0x5B);
>> +       /* pop r12 */
>> +       EMIT2(0x41, 0x5C);
>> +       /* pop r13 */
>> +       EMIT2(0x41, 0x5D);
>> +       /* pop r14 */
>> +       EMIT2(0x41, 0x5E);
>> +       /* pop r15 */
>> +       EMIT2(0x41, 0x5F);
>> +       /* pop rbp */
>> +       EMIT1(0x5D);
>> +
>> +       /* ret */
>> +       EMIT1(0xC3);
>>=20
>>        *pprog =3D prog;
>> }
>> @@ -277,7 +307,7 @@ static void emit_bpf_tail_call(u8 **pprog)
>>        EMIT2(0x89, 0xD2);                        /* mov edx, edx */
>>        EMIT3(0x39, 0x56,                         /* cmp dword ptr [rsi +=
 16], edx */
>>              offsetof(struct bpf_array, map.max_entries));
>> -#define OFFSET1 (41 + RETPOLINE_RAX_BPF_JIT_SIZE) /* Number of bytes to=
 jump */
>> +#define OFFSET1 (35 + RETPOLINE_RAX_BPF_JIT_SIZE) /* Number of bytes to=
 jump */
>>        EMIT2(X86_JBE, OFFSET1);                  /* jbe out */
>>        label1 =3D cnt;
>>=20
>> @@ -285,13 +315,13 @@ static void emit_bpf_tail_call(u8 **pprog)
>>         * if (tail_call_cnt > MAX_TAIL_CALL_CNT)
>>         *      goto out;
>>         */
>> -       EMIT2_off32(0x8B, 0x85, 36);              /* mov eax, dword ptr =
[rbp + 36] */
>> +       EMIT3(0x8B, 0x45, 0xD4);                  /* mov eax, dword ptr =
[rbp - 44] */
>>        EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CA=
LL_CNT */
>> -#define OFFSET2 (30 + RETPOLINE_RAX_BPF_JIT_SIZE)
>> +#define OFFSET2 (27 + RETPOLINE_RAX_BPF_JIT_SIZE)
>>        EMIT2(X86_JA, OFFSET2);                   /* ja out */
>>        label2 =3D cnt;
>>        EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
>> -       EMIT2_off32(0x89, 0x85, 36);              /* mov dword ptr [rbp =
+ 36], eax */
>> +       EMIT3(0x89, 0x45, 0xD4);                  /* mov dword ptr [rbp =
- 44], eax */
>>=20
>>        /* prog =3D array->ptrs[index]; */
>>        EMIT4_off32(0x48, 0x8B, 0x84, 0xD6,       /* mov rax, [rsi + rdx =
* 8 + offsetof(...)] */
>> @@ -419,8 +449,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *ad=
drs, u8 *image,
>>        int proglen =3D 0;
>>        u8 *prog =3D temp;
>>=20
>> -       emit_prologue(&prog, bpf_prog->aux->stack_depth,
>> -                     bpf_prog_was_classic(bpf_prog));
>> +       emit_prologue(&prog, bpf_prog->aux->stack_depth);
>>=20
>>        for (i =3D 0; i < insn_cnt; i++, insn++) {
>>                const s32 imm32 =3D insn->imm;
>> @@ -767,10 +796,19 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image,
>>                case BPF_ST | BPF_MEM | BPF_DW:
>>                        EMIT2(add_1mod(0x48, dst_reg), 0xC7);
>>=20
>> -st:                    if (is_imm8(insn->off))
>> -                               EMIT2(add_1reg(0x40, dst_reg), insn->off=
);
>> +st:
>> +                       if (is_imm8(insn->off))
>> +                               EMIT1(add_1reg(0x40, dst_reg));
>>                        else
>> -                               EMIT1_off32(add_1reg(0x80, dst_reg), ins=
n->off);
>> +                               EMIT1(add_1reg(0x80, dst_reg));
>> +
>> +                       if (is_sib_reg(dst_reg))
>> +                               EMIT1(add_1reg(0x20, dst_reg));
>> +
>> +                       if (is_imm8(insn->off))
>> +                               EMIT1(insn->off);
>> +                       else
>> +                               EMIT(insn->off, 4);
>>=20
>>                        EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->=
code)));
>>                        break;
>> @@ -799,11 +837,19 @@ st:                       if (is_imm8(insn->off))
>>                        goto stx;
>>                case BPF_STX | BPF_MEM | BPF_DW:
>>                        EMIT2(add_2mod(0x48, dst_reg, src_reg), 0x89);
>> -stx:                   if (is_imm8(insn->off))
>> -                               EMIT2(add_2reg(0x40, dst_reg, src_reg), =
insn->off);
>> +stx:
>> +                       if (is_imm8(insn->off))
>> +                               EMIT1(add_2reg(0x40, dst_reg, src_reg));
>> +                       else
>> +                               EMIT1(add_2reg(0x80, dst_reg, src_reg));
>> +
>> +                       if (is_sib_reg(dst_reg))
>> +                               EMIT1(add_1reg(0x20, dst_reg));
>> +
>> +                       if (is_imm8(insn->off))
>> +                               EMIT1(insn->off);
>>                        else
>> -                               EMIT1_off32(add_2reg(0x80, dst_reg, src_=
reg),
>> -                                           insn->off);
>> +                               EMIT(insn->off, 4);
>>                        break;
>>=20
>>                        /* LDX: dst_reg =3D *(u8*)(src_reg + off) */
>> @@ -825,16 +871,24 @@ stx:                      if (is_imm8(insn->off))
>>                case BPF_LDX | BPF_MEM | BPF_DW:
>>                        /* Emit 'mov rax, qword ptr [rax+0x14]' */
>>                        EMIT2(add_2mod(0x48, src_reg, dst_reg), 0x8B);
>> -ldx:                   /*
>> +ldx:
>> +                       /*
>>                         * If insn->off =3D=3D 0 we can save one extra by=
te, but
>>                         * special case of x86 R13 which always needs an =
offset
>>                         * is not worth the hassle
>>                         */
>>                        if (is_imm8(insn->off))
>> -                               EMIT2(add_2reg(0x40, src_reg, dst_reg), =
insn->off);
>> +                               EMIT1(add_2reg(0x40, src_reg, dst_reg));
>>                        else
>> -                               EMIT1_off32(add_2reg(0x80, src_reg, dst_=
reg),
>> -                                           insn->off);
>> +                               EMIT1(add_2reg(0x80, src_reg, dst_reg));
>> +
>> +                       if (is_sib_reg(src_reg))
>> +                               EMIT1(add_1reg(0x20, src_reg));
>> +
>> +                       if (is_imm8(insn->off))
>> +                               EMIT1(insn->off);
>> +                       else
>> +                               EMIT(insn->off, 4);
>>                        break;
>>=20
>>                        /* STX XADD: lock *(u32*)(dst_reg + off) +=3D src=
_reg */
>> @@ -847,11 +901,19 @@ stx:                      if (is_imm8(insn->off))
>>                        goto xadd;
>>                case BPF_STX | BPF_XADD | BPF_DW:
>>                        EMIT3(0xF0, add_2mod(0x48, dst_reg, src_reg), 0x0=
1);
>> -xadd:                  if (is_imm8(insn->off))
>> -                               EMIT2(add_2reg(0x40, dst_reg, src_reg), =
insn->off);
>> +xadd:
>> +                       if (is_imm8(insn->off))
>> +                               EMIT1(add_2reg(0x40, dst_reg, src_reg));
>>                        else
>> -                               EMIT1_off32(add_2reg(0x80, dst_reg, src_=
reg),
>> -                                           insn->off);
>> +                               EMIT1(add_2reg(0x80, dst_reg, src_reg));
>> +
>> +                       if (is_sib_reg(dst_reg))
>> +                               EMIT1(add_1reg(0x20, dst_reg));
>> +
>> +                       if (is_imm8(insn->off))
>> +                               EMIT1(insn->off);
>> +                       else
>> +                               EMIT(insn->off, 4);
>>                        break;
>>=20
>>                        /* call */
>> @@ -1040,19 +1102,8 @@ xadd:                    if (is_imm8(insn->off))
>>                        seen_exit =3D true;
>>                        /* Update cleanup_addr */
>>                        ctx->cleanup_addr =3D proglen;
>> -                       /* mov rbx, qword ptr [rbp+0] */
>> -                       EMIT4(0x48, 0x8B, 0x5D, 0);
>> -                       /* mov r13, qword ptr [rbp+8] */
>> -                       EMIT4(0x4C, 0x8B, 0x6D, 8);
>> -                       /* mov r14, qword ptr [rbp+16] */
>> -                       EMIT4(0x4C, 0x8B, 0x75, 16);
>> -                       /* mov r15, qword ptr [rbp+24] */
>> -                       EMIT4(0x4C, 0x8B, 0x7D, 24);
>> -
>> -                       /* add rbp, AUX_STACK_SPACE */
>> -                       EMIT4(0x48, 0x83, 0xC5, AUX_STACK_SPACE);
>> -                       EMIT1(0xC9); /* leave */
>> -                       EMIT1(0xC3); /* ret */
>> +
>> +                       emit_epilogue(&prog);
>>                        break;
>>=20
>>                default:
>=20
> Thanks! This looks good to me and passed the self test and bcc test
> (with frame pointer unwinder, and JIT enabled):
> With bcc's tools/stackcount.py I got the valid stack trace, and the
> self test says:
> test_stacktrace_map:PASS:compare_map_keys stackid_hmap vs. stackmap 0 nse=
c
>=20
> --=20
> Best Regards,
> Kairui Song


