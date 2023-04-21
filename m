Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BB56EA8F9
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 13:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjDULSk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 07:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDULSk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 07:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8470010A
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682075876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+a819jXQkhWrRCkf1kmbqhc9TRLDMyUVW4Zd+vmWTnQ=;
        b=PIA/Yz04iAhJbOzCPVnt8jz9/3y8JV7f0tQwceA+IMwvI9IzdQ1b+Xx9vFaUKkx75OcYnB
        QwdW9gS5GyBBvtky91+SAlxlN7PJvbE/rAom9V2sMtEYqvJvraqULR/su2xojXHOHKWPNt
        h3/7l9NFAU6O9Qvn02qSxEKYgFPgzK4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-gX2HJHduMuGATRoheuo5gQ-1; Fri, 21 Apr 2023 07:17:53 -0400
X-MC-Unique: gX2HJHduMuGATRoheuo5gQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6C0985A5A3;
        Fri, 21 Apr 2023 11:17:52 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.192.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CC04140EBF4;
        Fri, 21 Apr 2023 11:17:51 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Artem Savkov <asavkov@redhat.com>,
        Viktor Malik <vmalik@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>
Subject: Re: sys_enter tracepoint ctx structure
References: <xunyjzy64q9b.fsf@redhat.com>
        <CAADnVQ+JdPGV95Y30PskgdOomU2K0UXsoCydgqaJfJ5j4S8BtQ@mail.gmail.com>
        <xunyjzy6z3vu.fsf@redhat.com>
        <CAADnVQK-Dig-5DB6tM_sgggyvqHUXSbBud0R=rAPWT2VRtQ-ZQ@mail.gmail.com>
        <xunyfs8uz0z1.fsf@redhat.com>
        <CAADnVQ+ZSTpUvV7fQ-UxCoRBCc8NYfcYHY0K9mKka=vhT6LO=Q@mail.gmail.com>
Date:   Fri, 21 Apr 2023 14:17:49 +0300
In-Reply-To: <CAADnVQ+ZSTpUvV7fQ-UxCoRBCc8NYfcYHY0K9mKka=vhT6LO=Q@mail.gmail.com>
        (Alexei Starovoitov's message of "Thu, 20 Apr 2023 16:12:49 -0700")
Message-ID: <xunybkjhzdpe.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Alexei!

>>>>> On Thu, 20 Apr 2023 16:12:49 -0700, Alexei Starovoitov  wrote:
 > On Thu, Apr 20, 2023 at 2:40=E2=80=AFPM Yauheni Kaliuta <ykaliuta@redhat=
.com> wrote:
 >> >>>>> On Thu, 20 Apr 2023 13:54:26 -0700, Alexei Starovoitov  wrote:
 >> > On Thu, Apr 20, 2023 at 1:37=E2=80=AFPM Yauheni Kaliuta <ykaliuta@red=
hat.com> wrote:
 >> >> >>>>> On Thu, 20 Apr 2023 08:59:09 -0700, Alexei Starovoitov  wrote:
 >> >> >>
 >> >> >> Should perf_call_bpf_enter/exit (kernel/trace/trace_syscalls.c)
 >> >> >> use struct trace_event_raw_sys_enter/exit instead of locally
 >> >> >> crafted struct syscall_tp_t nowadays?
 >> >>
 >> >>
 >> >> > No. It needs syscall_tp_t.
 >> >>
 >> >> > test_progs's vmlinux test
 >> >> >> expects it as the context.
 >> >> >>
 >> >>
 >> >> > what do you mean? Pls share a code pointer?
 >> >>
 >> >> https://github.com/torvalds/linux/blob/master/tools/testing/selftest=
s/bpf/progs/test_vmlinux.c#L19
 >> >>
 >> >> SEC("tp/syscalls/sys_enter_nanosleep")
 >> >> int handle__tp(struct trace_event_raw_sys_enter *args)
 >>=20
 >> > I see. That bit is correct and that's what bpftrace is doing
 >> > when attaching to syscalls.
 >> > What do you see in your patched RT kernel when you do:
 >> > cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/for=
mat
 >> > ?
 >> > Depending on the answer we might need to fix
 >> > the kernel side that has to use struct trace_entry
 >> > in syscall_tp_t instead of plain long long.
 >>=20
 >> # cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/for=
mat
 >> name: sys_enter_nanosleep
 >> ID: 374
 >> format:
 >> field:unsigned short common_type;       offset:0;       size:2; signed:=
0;
 >> field:unsigned char common_flags;       offset:2;       size:1; signed:=
0;
 >> field:unsigned char common_preempt_count;       offset:3;       size:1;=
 signed:0;
 >> field:int common_pid;   offset:4;       size:4; signed:1;
 >> field:unsigned char common_preempt_lazy_count;  offset:8;       size:1;=
 signed:0;
 >>=20
 >> field:int __syscall_nr; offset:12;      size:4; signed:1;
 >> field:struct __kernel_timespec * rqtp;  offset:16;      size:8; signed:=
0;
 >> field:struct __kernel_timespec * rmtp;  offset:24;      size:8; signed:=
0;
 >>=20
 >> print fmt: "rqtp: 0x%08lx, rmtp: 0x%08lx", ((unsigned long)(REC->rqtp))=
, ((unsigned long)(REC->rmtp))


 > Lol.
 > Jiri even fixed the issue with this format in bpftrace 3 years ago:
 > https://github.com/iovisor/bpftrace/commit/a2e3d5dbc03ceb49b776cf5602d31=
896158844a7

Hehe :)

 > Let's fix the kernel side too. Something like this should do it:

 > diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls=
.c
 > index 942ddbdace4a..7aa1f4299486 100644
 > --- a/kernel/trace/trace_syscalls.c
 > +++ b/kernel/trace/trace_syscalls.c
 > @@ -555,7 +555,7 @@ static int perf_call_bpf_enter(struct
 > trace_event_call *call, struct pt_regs *re
 >                                struct syscall_trace_enter *rec)
 >  {
 >         struct syscall_tp_t {
 > -               unsigned long long regs;
 > +               struct trace_entry ent;
 >                 unsigned long syscall_nr;
 >                 unsigned long args[SYSCALL_DEFINE_MAXARGS];
 >         } param;
 > @@ -657,7 +657,7 @@ static int perf_call_bpf_exit(struct
 > trace_event_call *call, struct pt_regs *reg
 >                               struct syscall_trace_exit *rec)
 >  {
 >         struct syscall_tp_t {
 > -               unsigned long long regs;
 > +               struct trace_entry ent;


 > pls add build_bug_on that sizeof(ent) >=3D sizeof(void*).

Ok. Should the line *(struct pt_regs **)&param =3D regs; be commented someh=
ow?

--=20
WBR,
Yauheni Kaliuta

