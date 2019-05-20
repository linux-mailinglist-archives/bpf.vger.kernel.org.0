Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF19923E4B
	for <lists+bpf@lfdr.de>; Mon, 20 May 2019 19:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733201AbfETRUM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 May 2019 13:20:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48458 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733069AbfETRUL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 May 2019 13:20:11 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4KH9NEb018704;
        Mon, 20 May 2019 10:19:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=81AfIakDmhkQKoU122SDnOftu+nkWvzOxvv35A+cUo8=;
 b=CAA7Ixg5rLdS8gs4YjIv3KxipsBxCgh06okHYPL5HjKjx9gzSdu0Rr+VFOjPVE/TD0RP
 PeSR0/Jq71UO9tTm1kdy3xrO4GrYY5SJctvZhUkPf71atQyfMA9pUTNT/3wS5VeqQIKU
 DGuGR2msKirjbe5YywVvlC2LZi2ICsMuktk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sm07hg2q3-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 20 May 2019 10:19:25 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 20 May 2019 10:19:24 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 20 May 2019 10:19:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81AfIakDmhkQKoU122SDnOftu+nkWvzOxvv35A+cUo8=;
 b=eHj9FZl+O9Gei+6HDcDfPzhdK6AXxpyceTETFZSoeLao6yQinFpoBqItD0kR/xDJCIDPtPTY/ba61bwzfnYshjSytlzxJBUSmVjS+xfbdLLhgOPjFJ/dKTOtyoZvYrodAVOdDMKrmvSBOOZ8Vrex9sJmkAs8cxHNYfsBGvo+EdQ=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1133.namprd15.prod.outlook.com (10.175.2.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Mon, 20 May 2019 17:19:22 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 17:19:22 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Kairui Song <kasong@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel() 
Thread-Topic: Getting empty callchain from perf_callchain_kernel() 
Thread-Index: AQHVDEJXbyjc1nknl06FlgTGlvLrzKZu8J8AgAAG+ICAAAFQgIAAD2QAgAO6dwCAAYUMgA==
Date:   Mon, 20 May 2019 17:19:22 +0000
Message-ID: <BB5859B6-6686-474A-8CB2-FAC183C92829@fb.com>
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
 <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net>
 <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net>
 <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
In-Reply-To: <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::1:c888]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7fa8d74e-9d25-470b-8d22-08d6dd474d0b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1133;
x-ms-traffictypediagnostic: MWHPR15MB1133:
x-microsoft-antispam-prvs: <MWHPR15MB113380E22A56BF1FC38E04F7B3060@MWHPR15MB1133.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(396003)(39860400002)(189003)(199004)(86362001)(229853002)(6246003)(4743002)(102836004)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(57306001)(6116002)(53546011)(6506007)(8936002)(4326008)(99286004)(73956011)(25786009)(76176011)(54906003)(50226002)(11346002)(53936002)(82746002)(8676002)(81156014)(81166006)(486006)(2616005)(476003)(36756003)(83716004)(71200400001)(71190400001)(446003)(33656002)(6486002)(6436002)(5660300002)(7736002)(256004)(186003)(316002)(6512007)(46003)(478600001)(6916009)(2906002)(68736007)(14454004)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1133;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u8GgpFUoEVk+T6sRir4y67DOdzoz2p44B49npZTKRa9e+hfOqqosDg754OoQgJ5xD0D9K9ZwyOBDNWgCRpXZ0fYbx3hFXbr1qAtl7txmymD8MALJzugh+surYvgfdMYs24Ql/IMYF5VC0EnFv9n4IMc9IjUhwMGBgEHyUKUvMSq9exxo5SXoKecCN9sdw7Yb0y/N3f3lkTXrl7pmXzgQqSik/6nH2Ff24OnzDCkil/XA0gpmBwM6O93rHjFEgvrxgzyU0KLd0eWZo0u4OVbZuUTUfUdi3Ih0VXMc5N5jAUmQbjZPyiB1e00lSa60q0acAcH/oEixMCl3khWiIR4+3MyKO716N4qtvHsWnUqZMT+2TsxeVIbcA0/ifDlk+FIl9ZIpomQO3iFqxw5BR7+4asiKBg1pdqdGpIfJkh8tAI8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D73D2FFA67EDE42A6DEA59B93F87828@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa8d74e-9d25-470b-8d22-08d6dd474d0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 17:19:22.2561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1133
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sorry for previous empty email.. Clicked send by accident.=20

> On May 19, 2019, at 11:06 AM, Kairui Song <kasong@redhat.com> wrote:
>=20
> On Fri, May 17, 2019 at 5:10 PM Peter Zijlstra <peterz@infradead.org> wro=
te:
>>=20
>> On Fri, May 17, 2019 at 04:15:39PM +0800, Kairui Song wrote:
>>> Hi, I think the actual problem is that bpf_get_stackid_tp (and maybe
>>> some other bfp functions) is now broken, or, strating an unwind
>>> directly inside a bpf program will end up strangely. It have following
>>> kernel message:
>>=20
>> Urgh, what is that bpf_get_stackid_tp() doing to get the regs? I can't
>> follow.
>=20
> bpf_get_stackid_tp will just use the regs passed to it from the trace
> point. And then it will eventually call perf_get_callchain to get the
> call chain.
> With a tracepoint we have the fake regs, so unwinder will start from
> where it is called, and use the fake regs as the indicator of the
> target frame it want, and keep unwinding until reached the actually
> callsite.
>=20
> But if the stack trace is started withing a bpf func call then it's broke=
n...
>=20
> If the unwinder could trace back through the bpf func call then there
> will be no such problem.
>=20
> For frame pointer unwinder, set the indicator flag (X86_EFLAGS_FIXED)
> before bpf call, and ensure bp is also dumped could fix it (so it will
> start using the regs for bpf calls, like before the commit
> d15d356887e7). But for ORC I don't see a clear way to fix the problem.
> First though is maybe dump some callee's regs for ORC (IP, BP, SP, DI,
> DX, R10, R13, else?) in the trace point handler, then use the flag to
> indicate ORC to do one more unwind (because can't get caller's regs,
> so get callee's regs instaed) before actually giving output?
>=20
> I had a try, for framepointer unwinder, mark the indicator flag before
> calling bpf functions, and dump bp as well in the trace point. Then
> with frame pointer, it works, test passed:
>=20
> diff --git a/arch/x86/include/asm/perf_event.h
> b/arch/x86/include/asm/perf_event.h
> index 1392d5e6e8d6..6f1192e9776b 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -302,12 +302,25 @@ extern unsigned long perf_misc_flags(struct
> pt_regs *regs);
>=20
> #include <asm/stacktrace.h>
>=20
> +#ifdef CONFIG_FRAME_POINTER
> +static inline unsigned long caller_frame_pointer(void)
> +{
> +       return (unsigned long)__builtin_frame_address(1);
> +}
> +#else
> +static inline unsigned long caller_frame_pointer(void)
> +{
> +       return 0;
> +}
> +#endif
> +
> /*
>  * We abuse bit 3 from flags to pass exact information, see perf_misc_fla=
gs
>  * and the comment with PERF_EFLAGS_EXACT.
>  */
> #define perf_arch_fetch_caller_regs(regs, __ip)                {       \
>        (regs)->ip =3D (__ip);                                    \
> +       (regs)->bp =3D caller_frame_pointer();                    \
>        (regs)->sp =3D (unsigned long)__builtin_frame_address(0); \
>        (regs)->cs =3D __KERNEL_CS;                               \
>        regs->flags =3D 0;                                        \
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index abbd4b3b96c2..ca7b95ee74f0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8549,6 +8549,7 @@ void perf_trace_run_bpf_submit(void *raw_data,
> int size, int rctx,
>                               struct task_struct *task)
> {
>        if (bpf_prog_array_valid(call)) {
> +               regs->flags |=3D X86_EFLAGS_FIXED;
>                *(struct pt_regs **)raw_data =3D regs;
>                if (!trace_call_bpf(call, raw_data) || hlist_empty(head)) =
{
>                        perf_swevent_put_recursion_context(rctx);
> @@ -8822,6 +8823,8 @@ static void bpf_overflow_handler(struct perf_event =
*event,
>        int ret =3D 0;
>=20
>        ctx.regs =3D perf_arch_bpf_user_pt_regs(regs);
> +       ctx.regs->flags |=3D X86_EFLAGS_FIXED;
> +
>        preempt_disable();
>        if (unlikely(__this_cpu_inc_return(bpf_prog_active) !=3D 1))
>                goto out;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index f92d6ad5e080..e1fa656677dc 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -497,6 +497,8 @@ u64 bpf_event_output(struct bpf_map *map, u64
> flags, void *meta, u64 meta_size,
>        };
>=20
>        perf_fetch_caller_regs(regs);
> +       regs->flags |=3D X86_EFLAGS_FIXED;
> +
>        perf_sample_data_init(sd, 0, 0);
>        sd->raw =3D &raw;
>=20
> @@ -831,6 +833,8 @@ BPF_CALL_5(bpf_perf_event_output_raw_tp, struct
> bpf_raw_tracepoint_args *, args,
>        struct pt_regs *regs =3D this_cpu_ptr(&bpf_raw_tp_regs);
>=20
>        perf_fetch_caller_regs(regs);
> +       regs->flags |=3D X86_EFLAGS_FIXED;
> +
>        return ____bpf_perf_event_output(regs, map, flags, data, size);
> }
>=20
> @@ -851,6 +855,8 @@ BPF_CALL_3(bpf_get_stackid_raw_tp, struct
> bpf_raw_tracepoint_args *, args,
>        struct pt_regs *regs =3D this_cpu_ptr(&bpf_raw_tp_regs);
>=20
>        perf_fetch_caller_regs(regs);
> +       regs->flags |=3D X86_EFLAGS_FIXED;
> +
>        /* similar to bpf_perf_event_output_tp, but pt_regs fetched
> differently */
>        return bpf_get_stackid((unsigned long) regs, (unsigned long) map,
>                               flags, 0, 0);
> @@ -871,6 +877,8 @@ BPF_CALL_4(bpf_get_stack_raw_tp, struct
> bpf_raw_tracepoint_args *, args,
>        struct pt_regs *regs =3D this_cpu_ptr(&bpf_raw_tp_regs);
>=20
>        perf_fetch_caller_regs(regs);
> +       regs->flags |=3D X86_EFLAGS_FIXED;
> +
>        return bpf_get_stack((unsigned long) regs, (unsigned long) buf,
>                             (unsigned long) size, flags, 0);
> }
>=20

I think we really cannot do something above, as it leaks x86 specific
code into kernel/events and kernel/trace.=20

> And *_raw_tp functions will fetch the regs by themselves so a bit
> trouble some...
>=20
> ----------
>=20
> And another approach is to make unwinder direct unwinding works when
> called by bpf (if possible and reasonable). I also had a nasty hacky
> experiment (posted below) to just force frame pointer unwinder's
> get_stack_info pass for bpf, then problem is fixed without any other
> workaround:
>=20
> diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_6=
4.c
> index 753b8cfe8b8a..c0cfdf25f5ed 100644
> --- a/arch/x86/kernel/dumpstack_64.c
> +++ b/arch/x86/kernel/dumpstack_64.c
> @@ -166,7 +166,8 @@ int get_stack_info(unsigned long *stack, struct
> task_struct *task,
>        if (in_entry_stack(stack, info))
>                goto recursion_check;
>=20
> -       goto unknown;
> +       goto recursion_check;
>=20
> recursion_check:
>        /*

I think this one doesn't work for ORC either?=20

Thanks,
Song

> Don't know how to do it the right way, or is it even possible for all
> unwinders yet...
>=20
> --=20
> Best Regards,
> Kairui Song

