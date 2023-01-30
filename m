Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9C66816B4
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 17:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbjA3QnQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 11:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbjA3QnM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 11:43:12 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5943613506
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 08:43:08 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id me3so33487649ejb.7
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 08:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jD2/zjX8GAg9Lr5fHd7DWlH6xjcDsdXdZds9F24linA=;
        b=CmtV4MSpgNzbThVkTjMW8v62k+d5UcLYYinUTkwZY0N7PNVOUa73q44++xQpHWOuTO
         +9bp6fYOTSc7oqxzQNrd2uj3E5e+X3rzH7vyUnqIGzgBLJi0UgsK+Amb7N0GrjE13Q7D
         w25qydLeVPyRO28vL1At+SRkKATnhp6OLmduxCu6hgWoMOux4DP4u17okUCisrvATQRo
         OUrXa+oyPTfEeEnTPa194wdZwbhlv1abZ/OqKFjhu6vEXw+Ki5FP539D+bNeNql1pNB6
         9G4ytJ9AtOUeUq12/g3AXPdThEXd6Kp3LR8JJTJX3Lx2JTjG92Ej0TnUz2+ppXjY3qex
         PmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jD2/zjX8GAg9Lr5fHd7DWlH6xjcDsdXdZds9F24linA=;
        b=cdQFoGKb+yHNB7TAtzqyFxlcQFE/js6hWefePx7OqLR7oPc3aUZhyjSKIh1B0nX0TM
         CLmHDN+I1R3vKYiL5iC4VVsvfqut16+g3E2ycVx9Bkk0k3ytrXjV9JRT9cr3KpIc1Roy
         /33eiD8QkGC/7EGqkW7c/wxEAORTc8p0Zd+kbKHJbzyJx+rXsTDrpgSXOqZbcqh8gair
         bXT8EO1I23Q3u0rzTiNu8o1Kaiuiu1QL+2cqTt+MLa9kpqoEdDLVMyfKbmhBeihsPNeh
         Pyixq/gTJnsQxANWcbKOl/Vb380mFUoRFYGWum1BRpJehAsGLeeJftY2JuI2u+l83/Mk
         joSw==
X-Gm-Message-State: AO0yUKVhu63nc11LDnyki5b2UR/ygo+4YZlusRLBIkF6UB44YNDRYbBX
        8YU5ZtWM9XMFjL/H+yrToRlTeOFpxAwVBSF9rhA=
X-Google-Smtp-Source: AK7set/y8OecEIZGkteHLxWrTdoynlPVedmHi23XYIcHMIucXhmW9zeUQc9u7hfySvX+8CpYqiuMP9Hy6W0HtbMXvMk=
X-Received: by 2002:a17:906:2684:b0:887:e3fc:9201 with SMTP id
 t4-20020a170906268400b00887e3fc9201mr1292594ejc.65.1675096987007; Mon, 30 Jan
 2023 08:43:07 -0800 (PST)
MIME-Version: 1.0
References: <DU2PR03MB8006D93D98BD58AFF9657F3F96D39@DU2PR03MB8006.eurprd03.prod.outlook.com>
 <23537684-afd1-e31d-741e-acaf8a201156@iogearbox.net>
In-Reply-To: <23537684-afd1-e31d-741e-acaf8a201156@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 30 Jan 2023 08:42:55 -0800
Message-ID: <CAADnVQLsXLGk5nOx75r-Os+S8wxKjboV3_SKqUm0QXTZXUeDSA@mail.gmail.com>
Subject: Re: Interruptable eBPF programs
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Cc:     Ori Glassman <ori.glassman@aquasec.com>,
        "security@kernel.org" <security@kernel.org>,
        KP Singh <kpsingh@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 30, 2023 at 8:01 AM Daniel Borkmann <daniel@iogearbox.net> wrot=
e:
>
> On 1/30/23 1:12 PM, Ori Glassman wrote:
> > Hi everyone,
> >
> >
> > Since the patch to disable process migration instead of disabling preem=
ption in eBPF programs, the latter are potentially susceptible to a resched=
ule mid-execution.


Ori,

security@kernel alias is not the place to ask bpf related questions.
Yaniv, from your team, already brought it up here:
https://lore.kernel.org/bpf/CAADnVQ++LzKt9Q-GtGXknVBqyMqY=3DvLJ3tR3NNGG3P66=
gvVCFQ@mail.gmail.com/

You cannot assume that different bpf progs attached to various
events like tracepoints and lsm hooks won't overlap.
It's a bug in your program. Nothing else.

> Thanks for the report, Ori. We'll take a look and get back to you (also C=
c'ing KP and Alexei
> for visibility in here).
>
> > bpf_perf_event_output helper in an eBPF program, can trigger irq_work->=
arch_irq_work_raise, which will send an ipi to the current CPU, which may r=
eschedule.
> >
> > By hooking a tracepoint such as sched_process_free that runs within an =
interrupt context, an execution flow (of a certain CPU) like the following =
may occur:
> > - start execution of lsm/<some_func> and executing bpf_perf_event_outpu=
t within the hook code
> > - while executing bpf_perf_event_output, gets rescheduled and runs tp/s=
ched_process_free
> > - tp/sched_process_free returns and the CPU continues execution of lsm/=
<some_func>
> >
> > Using per-CPU data is a known issue in this kind of environment [1], th=
is is also relevant for per-task local storage implemented in v5.11 [2].
> >
> > This is risky in general but becomes particularly dangerous when used i=
n LSM modules (such as apparmor), since the block/allow logic may rely on s=
hared storage that may be manipulated mid-execution from the interrupt cont=
ext and corrupt the decision of the module.
> > A very un-harm example of such usage can be seen in bpf selftests [3].
> >
> > This becomes a vulnerability if an LSM hook uses a pinned per-task loca=
l storage - which is not expected to get corrupted mid execution, since an =
attacker may load a program such as tp/sched_process_free, and bypass silen=
tly the LSM hook by corrupting the self-storage. The flaw is in the per-tas=
k local storage, which is not reliable.
> >
> > An example:
> > -----------------------------------------------------------------------=
----
> > // User loads the following program:
> > SEC("lsm/bprm_creds_for_exec")
> > int BPF_PROG(secure_exec, struct linux_binprm *bprm)
> > {
> >      int *secureexec;
> >      secureexec =3D bpf_task_storage_get(&per_task_map, bpf_get_current=
_task_btf(), 0, BPF_LOCAL_STORAGE_GET_F_CREATE); // assume per_task_map is =
pinned
> >
> >      if (secureexec && STR_EQUALS(bprm->filename, "some_virus")) // ass=
ume this condition is fulfilled
> >          *secureexec =3D 1;
> >
> > // secureexec is now 1
> >      ...
> >      ...
> >      ...
> >      bpf_perf_event_output();
> >      ...
> >      ...
> >      ...
> >
> >      // secureexec is expected to be 1, but was changed from the interr=
upted context and is now 0
> >      bpf_bprm_opts_set(bprm, *secureexec);
> >
> >      // the binary "some_virus" will run without AT_SECURE
> >
> >      return 0;
> > }
> >
> > // The attacker code:
> > SEC("raw_tracepoint/sched_process_free")
> > int tracepoint__sched_sched_process_free(struct bpf_raw_tracepoint_args=
 *ctx)
> > {
> >      int *secureexec;
> >      secureexec =3D bpf_task_storage_get(&per_task_map, bpf_get_current=
_task_btf(), 0, BPF_LOCAL_STORAGE_GET_F_CREATE); // uses per_task_map pinne=
d map that was defined in a different eBPF program
> >      if (secureexec)
> >          *secureexec =3D 0; // always turn off secureexec
> >
> >      return 0;
> > }

These two programs access some task local storage.
This code racy regardless of preempt_disable vs migrate_disable.
bpf_task_storage_get() of the same task can run on different cpus.

Whether trace_sched_process_free and security_bprm_creds_for_exec
can happen on different cpus is kernel implementation detail.

There looks to be another bug in the above:
doing bpf_get_current_task_btf from raw_tracepoint/sched_process_free
will return task_struct of the worker thread.
I don't think it's the one you want.

Anyway, please start a clean thread at bpf@vger with bpf questions.
Don't spam security@kernel.

---------------------------------------------------------------------------
> >
> > Similarly, in cases where the LSM hook decides the return value (deny/a=
llow) based on data from the local storage, this can also be altered by the=
 attacker, resulting in doing a malicious action that the LSM module should=
 normally block.
> >
> >
> > I'd like to propose a tentative public disclosure date on 02/06/2023 12=
:00UTC.

You must be kidding.

> >
> >
> > [1] https://lwn.net/Articles/836503/
> > [2] https://github.com/torvalds/linux/commit/4cf1bc1f10452065a29d576fc5=
693fc4fab5b919
> > [3] https://elixir.bootlin.com/linux/latest/source/tools/testing/selfte=
sts/bpf/progs/bprm_opts.c#L24
> >
> >
> > Thanks,
> > Ori
> >
>
