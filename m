Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E8E6EAE9C
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 18:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjDUQC4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 12:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjDUQCz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 12:02:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BA5975C
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:02:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94ef0a8546fso268199766b.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682092966; x=1684684966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtKPwBMFff1g5pVYtPh4nQIF1XkVy6caCFID1+G6uwg=;
        b=AJTNkwefMmEb9NDFsvgVSsmFJSa9CbLzd+Wh4RHqgkfcgjJDEkSZOXA7Z0RYwZ8Yab
         jhH6hxkiL94LaRlehGD7pU6S/rXxW6O8ulgJRcmXTjV4tPWNluBickp/9rWMb8IXBQn1
         FNabjYKfrEwO3Q99Ymj6jy28awbZk4wRWQdzEK3c59lgjDl1VBFSTvtZGJOQHUBWG1PB
         UpsLKwH1GTFPpKZiA22tbUGl8Zju5Uqqg0KxPEyAVHXhlr5tHclJlb4qqrNeHRALKQYm
         CWmicYjtTS4eusuptDY8HdX5hJ9/vLUWXGyqJvhGuV5Z+Cb7set4EG2I0yt5jodWoXoG
         ux9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682092966; x=1684684966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtKPwBMFff1g5pVYtPh4nQIF1XkVy6caCFID1+G6uwg=;
        b=H8a4en2fPkoVxZmyMeNZLANOqIm92bguDLAI3GY9fskNH7ehNBBeWZazyAQpbP+NIY
         nfKYMf9rPFT8LV3lKuDYKryvjCmeUIkSPfvYWe7ZZscH4bdxt3Z6tAVkjmrpGlgiRIBU
         kZdVYOOoEiIM0+PfJRXqff9HKriizOh85IMuqCx8XDANWIZpGRSqQejq2/L9zaguVRhY
         n0B4I8mmYIfWeQdIW5yzTV0X33l12BjDn5BAwRtlYIwG2Ix+5iH3d2sf1QHVJhmUvkFD
         3Jqe1GoV6ckdT+Ugq1ylGoiLJg55qyL+sPGf/Ui1sbEOnpvN3aXvdyUN6k2sj9X7laVg
         dvaQ==
X-Gm-Message-State: AAQBX9eIWlX3VykEa5oZuhG+T/ykKlm5RrO5+e8Vyr5h7rUmR49GX+Q2
        zqjQADYXAMKxh7hwCEpHAW3Bf5OPOtQ9JKTlp0c=
X-Google-Smtp-Source: AKy350blrXPjhh1wOJf+pf6vSVe3l+O4J07S8AypG0Rrnr8NcTFFHq6wvVliXq6jMLXJztvuksBh0voySNR3V0vvgbI=
X-Received: by 2002:a17:906:10ce:b0:94f:5242:a03a with SMTP id
 v14-20020a17090610ce00b0094f5242a03amr3348584ejv.63.1682092965564; Fri, 21
 Apr 2023 09:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <xunyjzy64q9b.fsf@redhat.com> <CAADnVQ+JdPGV95Y30PskgdOomU2K0UXsoCydgqaJfJ5j4S8BtQ@mail.gmail.com>
 <xunyjzy6z3vu.fsf@redhat.com> <CAADnVQK-Dig-5DB6tM_sgggyvqHUXSbBud0R=rAPWT2VRtQ-ZQ@mail.gmail.com>
 <xunyfs8uz0z1.fsf@redhat.com> <CAADnVQ+ZSTpUvV7fQ-UxCoRBCc8NYfcYHY0K9mKka=vhT6LO=Q@mail.gmail.com>
 <xunybkjhzdpe.fsf@redhat.com>
In-Reply-To: <xunybkjhzdpe.fsf@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 21 Apr 2023 09:02:34 -0700
Message-ID: <CAADnVQKGrSvJHXbsqzEF=QSuePF5KzGUKeC_HWsY56bTTSRWMw@mail.gmail.com>
Subject: Re: sys_enter tracepoint ctx structure
To:     Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Artem Savkov <asavkov@redhat.com>,
        Viktor Malik <vmalik@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 21, 2023 at 4:17=E2=80=AFAM Yauheni Kaliuta <ykaliuta@redhat.co=
m> wrote:
>
> Hi, Alexei!
>
> >>>>> On Thu, 20 Apr 2023 16:12:49 -0700, Alexei Starovoitov  wrote:
>  > On Thu, Apr 20, 2023 at 2:40=E2=80=AFPM Yauheni Kaliuta <ykaliuta@redh=
at.com> wrote:
>  >> >>>>> On Thu, 20 Apr 2023 13:54:26 -0700, Alexei Starovoitov  wrote:
>  >> > On Thu, Apr 20, 2023 at 1:37=E2=80=AFPM Yauheni Kaliuta <ykaliuta@r=
edhat.com> wrote:
>  >> >> >>>>> On Thu, 20 Apr 2023 08:59:09 -0700, Alexei Starovoitov  wrot=
e:
>  >> >> >>
>  >> >> >> Should perf_call_bpf_enter/exit (kernel/trace/trace_syscalls.c)
>  >> >> >> use struct trace_event_raw_sys_enter/exit instead of locally
>  >> >> >> crafted struct syscall_tp_t nowadays?
>  >> >>
>  >> >>
>  >> >> > No. It needs syscall_tp_t.
>  >> >>
>  >> >> > test_progs's vmlinux test
>  >> >> >> expects it as the context.
>  >> >> >>
>  >> >>
>  >> >> > what do you mean? Pls share a code pointer?
>  >> >>
>  >> >> https://github.com/torvalds/linux/blob/master/tools/testing/selfte=
sts/bpf/progs/test_vmlinux.c#L19
>  >> >>
>  >> >> SEC("tp/syscalls/sys_enter_nanosleep")
>  >> >> int handle__tp(struct trace_event_raw_sys_enter *args)
>  >>
>  >> > I see. That bit is correct and that's what bpftrace is doing
>  >> > when attaching to syscalls.
>  >> > What do you see in your patched RT kernel when you do:
>  >> > cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/f=
ormat
>  >> > ?
>  >> > Depending on the answer we might need to fix
>  >> > the kernel side that has to use struct trace_entry
>  >> > in syscall_tp_t instead of plain long long.
>  >>
>  >> # cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/f=
ormat
>  >> name: sys_enter_nanosleep
>  >> ID: 374
>  >> format:
>  >> field:unsigned short common_type;       offset:0;       size:2; signe=
d:0;
>  >> field:unsigned char common_flags;       offset:2;       size:1; signe=
d:0;
>  >> field:unsigned char common_preempt_count;       offset:3;       size:=
1; signed:0;
>  >> field:int common_pid;   offset:4;       size:4; signed:1;
>  >> field:unsigned char common_preempt_lazy_count;  offset:8;       size:=
1; signed:0;
>  >>
>  >> field:int __syscall_nr; offset:12;      size:4; signed:1;
>  >> field:struct __kernel_timespec * rqtp;  offset:16;      size:8; signe=
d:0;
>  >> field:struct __kernel_timespec * rmtp;  offset:24;      size:8; signe=
d:0;
>  >>
>  >> print fmt: "rqtp: 0x%08lx, rmtp: 0x%08lx", ((unsigned long)(REC->rqtp=
)), ((unsigned long)(REC->rmtp))
>
>
>  > Lol.
>  > Jiri even fixed the issue with this format in bpftrace 3 years ago:
>  > https://github.com/iovisor/bpftrace/commit/a2e3d5dbc03ceb49b776cf5602d=
31896158844a7
>
> Hehe :)
>
>  > Let's fix the kernel side too. Something like this should do it:
>
>  > diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscal=
ls.c
>  > index 942ddbdace4a..7aa1f4299486 100644
>  > --- a/kernel/trace/trace_syscalls.c
>  > +++ b/kernel/trace/trace_syscalls.c
>  > @@ -555,7 +555,7 @@ static int perf_call_bpf_enter(struct
>  > trace_event_call *call, struct pt_regs *re
>  >                                struct syscall_trace_enter *rec)
>  >  {
>  >         struct syscall_tp_t {
>  > -               unsigned long long regs;
>  > +               struct trace_entry ent;
>  >                 unsigned long syscall_nr;
>  >                 unsigned long args[SYSCALL_DEFINE_MAXARGS];
>  >         } param;
>  > @@ -657,7 +657,7 @@ static int perf_call_bpf_exit(struct
>  > trace_event_call *call, struct pt_regs *reg
>  >                               struct syscall_trace_exit *rec)
>  >  {
>  >         struct syscall_tp_t {
>  > -               unsigned long long regs;
>  > +               struct trace_entry ent;
>
>
>  > pls add build_bug_on that sizeof(ent) >=3D sizeof(void*).
>
> Ok. Should the line *(struct pt_regs **)&param =3D regs; be commented som=
ehow?

commented out? No. It's mandatory.
And the reason for build_bug_on existence... to make sure that there
is enough space there.
