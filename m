Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D422D6E9FB6
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 01:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjDTXNR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 19:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjDTXNR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 19:13:17 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005085FF7
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 16:13:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-95316faa3a8so147117766b.2
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 16:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682032381; x=1684624381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ze95z8dtABZfcsIBhF0hYlFUmyS3yDDv4vlF1Pt0YA=;
        b=M/NDQPOlDWPw3j51AgjLs8gXPJ3Q0Y7VTmFcuGYVjUrYoxW6tXZd6fvHGVdkfZRX7F
         PQg2fweOTSNiVYY2ZRw6059JGpXO/Km+SJqHJG6QuARfr9r5zscBrgbI190AWcTnJOXC
         /rErAyq9Alr2d5PkpXNWS5JVEKLIAOUh+9EcCDxq/Q+VP+8QoAuBG1jkKnF8n5l2/41c
         Ww1Lrc6lzU056tGIrFctRvh55zw00n6OUgcK87qsODjqldB0TVrXit6+iZ4mrobgFrxa
         2bKGr28FJ3IQtg/I8kRuJcFB49SnaNPoCkTRD8BtgfRbRJh2NOCqh09aGqe0SLeAJHoY
         L0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682032381; x=1684624381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Ze95z8dtABZfcsIBhF0hYlFUmyS3yDDv4vlF1Pt0YA=;
        b=STX+f/Ca8+tLSOZH5TxemkQ05TyCzEuqxHZRUMW7bZYmi5uDGA+bOZPrVJWp+9QfXp
         0cnndLyKQHIi+1Nt1dZI+xpKJWm310x+mpIAobcrUWsvVgrqiPdxvmvDXNDzQDz/+75U
         f33gVw1jWIoVTcxONdi1PCkJgB66SXrYg70mO/qPek/b02257ftwubtFH8mM8rGJDQuH
         htrrjS4K5x4q4W4kRh+TuJhD3P6qr/vpWupfcdeV2SLA4EGdNGUuKm0Mfm+zVBwlxC8Y
         myUQWRaGcN3YXyjPNl8troxc2nPbqRTac+lrjekfgQ9iiYCS8lVHhIQcL6EVXPeM9WHM
         9zVw==
X-Gm-Message-State: AAQBX9dkoakI2h6lQtOs7U45p019th4c2Twojp9wseNJHStpsKWYSKKv
        EZA/GLzbGJO1UvyWicqDI/Y4i1qbK6MDnh3wAUc=
X-Google-Smtp-Source: AKy350bdTxj+0t6beRIzasqype9vKIjMx+j3GrlI+U3a9kgcmjnPCfqW4B7orQeNbPXosqvXRTtn7S2mJw6k4Pw8Gzc=
X-Received: by 2002:a17:906:46d3:b0:94b:ffe9:37f6 with SMTP id
 k19-20020a17090646d300b0094bffe937f6mr259337ejs.3.1682032381163; Thu, 20 Apr
 2023 16:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <xunyjzy64q9b.fsf@redhat.com> <CAADnVQ+JdPGV95Y30PskgdOomU2K0UXsoCydgqaJfJ5j4S8BtQ@mail.gmail.com>
 <xunyjzy6z3vu.fsf@redhat.com> <CAADnVQK-Dig-5DB6tM_sgggyvqHUXSbBud0R=rAPWT2VRtQ-ZQ@mail.gmail.com>
 <xunyfs8uz0z1.fsf@redhat.com>
In-Reply-To: <xunyfs8uz0z1.fsf@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 20 Apr 2023 16:12:49 -0700
Message-ID: <CAADnVQ+ZSTpUvV7fQ-UxCoRBCc8NYfcYHY0K9mKka=vhT6LO=Q@mail.gmail.com>
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

On Thu, Apr 20, 2023 at 2:40=E2=80=AFPM Yauheni Kaliuta <ykaliuta@redhat.co=
m> wrote:
>
> Hi, Alexei!
>
> >>>>> On Thu, 20 Apr 2023 13:54:26 -0700, Alexei Starovoitov  wrote:
>  > On Thu, Apr 20, 2023 at 1:37=E2=80=AFPM Yauheni Kaliuta <ykaliuta@redh=
at.com> wrote:
>  >> >>>>> On Thu, 20 Apr 2023 08:59:09 -0700, Alexei Starovoitov  wrote:
>  >> >>
>  >> >> Should perf_call_bpf_enter/exit (kernel/trace/trace_syscalls.c)
>  >> >> use struct trace_event_raw_sys_enter/exit instead of locally
>  >> >> crafted struct syscall_tp_t nowadays?
>  >>
>  >>
>  >> > No. It needs syscall_tp_t.
>  >>
>  >> > test_progs's vmlinux test
>  >> >> expects it as the context.
>  >> >>
>  >>
>  >> > what do you mean? Pls share a code pointer?
>  >>
>  >> https://github.com/torvalds/linux/blob/master/tools/testing/selftests=
/bpf/progs/test_vmlinux.c#L19
>  >>
>  >> SEC("tp/syscalls/sys_enter_nanosleep")
>  >> int handle__tp(struct trace_event_raw_sys_enter *args)
>
>  > I see. That bit is correct and that's what bpftrace is doing
>  > when attaching to syscalls.
>  > What do you see in your patched RT kernel when you do:
>  > cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/form=
at
>  > ?
>  > Depending on the answer we might need to fix
>  > the kernel side that has to use struct trace_entry
>  > in syscall_tp_t instead of plain long long.
>
>  # cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/form=
at
> name: sys_enter_nanosleep
> ID: 374
> format:
>         field:unsigned short common_type;       offset:0;       size:2; s=
igned:0;
>         field:unsigned char common_flags;       offset:2;       size:1; s=
igned:0;
>         field:unsigned char common_preempt_count;       offset:3;       s=
ize:1; signed:0;
>         field:int common_pid;   offset:4;       size:4; signed:1;
>         field:unsigned char common_preempt_lazy_count;  offset:8;       s=
ize:1; signed:0;
>
>         field:int __syscall_nr; offset:12;      size:4; signed:1;
>         field:struct __kernel_timespec * rqtp;  offset:16;      size:8; s=
igned:0;
>         field:struct __kernel_timespec * rmtp;  offset:24;      size:8; s=
igned:0;
>
> print fmt: "rqtp: 0x%08lx, rmtp: 0x%08lx", ((unsigned long)(REC->rqtp)), =
((unsigned long)(REC->rmtp))


Lol.
Jiri even fixed the issue with this format in bpftrace 3 years ago:
https://github.com/iovisor/bpftrace/commit/a2e3d5dbc03ceb49b776cf5602d31896=
158844a7

Let's fix the kernel side too. Something like this should do it:

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 942ddbdace4a..7aa1f4299486 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -555,7 +555,7 @@ static int perf_call_bpf_enter(struct
trace_event_call *call, struct pt_regs *re
                               struct syscall_trace_enter *rec)
 {
        struct syscall_tp_t {
-               unsigned long long regs;
+               struct trace_entry ent;
                unsigned long syscall_nr;
                unsigned long args[SYSCALL_DEFINE_MAXARGS];
        } param;
@@ -657,7 +657,7 @@ static int perf_call_bpf_exit(struct
trace_event_call *call, struct pt_regs *reg
                              struct syscall_trace_exit *rec)
 {
        struct syscall_tp_t {
-               unsigned long long regs;
+               struct trace_entry ent;


pls add build_bug_on that sizeof(ent) >=3D sizeof(void*).
