Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9438165B777
	for <lists+bpf@lfdr.de>; Mon,  2 Jan 2023 23:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjABWKV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Jan 2023 17:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjABWKT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Jan 2023 17:10:19 -0500
Received: from zproxy130.enst.fr (zproxy130.enst.fr [IPv6:2001:660:330f:2::c2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC645F68
        for <bpf@vger.kernel.org>; Mon,  2 Jan 2023 14:10:17 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        by zproxy130.enst.fr (Postfix) with ESMTP id 7D7CD1204B9;
        Mon,  2 Jan 2023 23:10:15 +0100 (CET)
Received: from zproxy130.enst.fr ([IPv6:::1])
        by localhost (zproxy130.enst.fr [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id OaNy3mEXeZSD; Mon,  2 Jan 2023 23:10:14 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
        by zproxy130.enst.fr (Postfix) with ESMTP id 542831204EE;
        Mon,  2 Jan 2023 23:10:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy130.enst.fr 542831204EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ip-paris.fr;
        s=DC645FAA-A815-11EB-B77D-7E405BEDA08B; t=1672697414;
        bh=4ZOLmU9DHUAYS+fWq+OvOxFQqR/V1QwSgn3eRAnn7Yw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=BxEs/nwNT4Tug8dSuO6PRKPRPcbwP4fmMYJTG+9fMRWQLcWnAV2nzZIRN8r9EHXpI
         LZJ64lnejO89CFfxYVbM+HWxMIG+V4TFnR6RHCA1ex0G48DDveFCCfC8Quo6KuZ1hu
         LtLBxfqxfMVj1hMHsFzQ3fbd63lsKj60CbJ3e9oyiEWAzX+cEY90I5WK4/zBK+TeL2
         pox/V8N6jQdC4zM342BlbIZnI6hb3ww77r3jXu70ZHTUvpXueQw9Lj8xufOJmEkVkP
         Gt692rNDpacEkFniWDXFXdg5pwJ/UznyDa+vbkRXks0LmjQOojEvMz9qMVbvUtl0K8
         tJPMJmsJTP1nw==
X-Virus-Scanned: amavisd-new at zproxy130.enst.fr
Received: from zproxy130.enst.fr ([IPv6:::1])
        by localhost (zproxy130.enst.fr [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Vn343mnjQwo0; Mon,  2 Jan 2023 23:10:14 +0100 (CET)
Received: from zmail-ipp1.enst.fr (zmail-ipp1.enst.fr [137.194.2.209])
        by zproxy130.enst.fr (Postfix) with ESMTP id 21D541204EB;
        Mon,  2 Jan 2023 23:10:14 +0100 (CET)
Date:   Mon, 2 Jan 2023 23:10:13 +0100 (CET)
From:   Victor Laforet <victor.laforet@ip-paris.fr>
To:     Yonghong Song <yhs@meta.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>
Message-ID: <690620297.606148.1672697413986.JavaMail.zimbra@ip-paris.fr>
In-Reply-To: <42d3f4d8-fa8b-5774-0f6b-b12162c24736@meta.com>
References: <346230382.476954.1672152966557.JavaMail.zimbra@ip-paris.fr> <Y6sWqgncfvtRHp+b@krava> <505155146.488099.1672236042622.JavaMail.zimbra@ip-paris.fr> <42d3f4d8-fa8b-5774-0f6b-b12162c24736@meta.com>
Subject: Re: bpf_probe_read_user EFAULT
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2a01:e0a:167:4b30:a199:12ee:dade:6fa8]
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - GC108 (Mac)/9.0.0_GA_4478)
Thread-Topic: bpf_probe_read_user EFAULT
Thread-Index: JLS3UgftQn3zfJZzPuYr14VZSc7MUw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BAD_THREAD_QP_64,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks!

I have tried to use bpf_copy_from_user_task() in place of bpf_probe_read_us=
er() however I cannot seem to run my program. It fails with 'unknown func b=
pf_copy_from_user_task=E2=80=99.
If I understood correctly, this function should be in =E2=80=98bpf/bpf_help=
ers.h=E2=80=99?

Another quick question:
I have set the bpf program as sleepable using =E2=80=98=09bpf_program__set_=
flags(skel, BPF_F_SLEEPABLE);'
I couldn=E2=80=99t find any other way to do that. Is it the right way to se=
t it sleepable?

Victor

De: "Yonghong Song" <yhs@meta.com>
=C3=80: "Victor Laforet" <victor.laforet@ip-paris.fr>, "Jiri Olsa" <olsajir=
i@gmail.com>
Cc: "bpf" <bpf@vger.kernel.org>
Envoy=C3=A9: Mercredi 28 D=C3=A9cembre 2022 20:41:33
Objet: Re: bpf_probe_read_user EFAULT

On 12/28/22 6:00 AM, Victor Laforet wrote:
> Yes I am sorry I did not mention that the example I sent was a minimal wo=
rking example. I am filtering the events to select only preempted and event=
s with the right pid as prev.
>=20
> Would bpf_copy_from_user_task work better in this setting than bpf_probe_=
read_user ?
> I don=E2=80=99t really understand why bpf_probe_read_user would not work =
for this use case.

Right, bpf_copy_from_user_task() is better than bpf_probe_read_user().=20
You could also use bpf_copy_from_user() if you have target_pid checking.

It is possible that the user variable you intended to access is not in=20
memory. In such cases, bpf_probe_read_user() will return EFAULT. But
bpf_copy_from_user() and bpf_copy_from_user_task() will go through
page fault process to bring the variable to the memory.
Also because of this extra work, bpf_copy_from_user() and
bpf_copy_from_user_task() only work for sleepable programs.

>=20
> Victor
>=20
> ----- Mail original -----
> De: "Jiri Olsa" <olsajiri@gmail.com>
> =C3=80: "Victor Laforet" <victor.laforet@ip-paris.fr>
> Cc: "bpf" <bpf@vger.kernel.org>
> Envoy=C3=A9: Mardi 27 D=C3=A9cembre 2022 17:00:42
> Objet: Re: bpf_probe_read_user EFAULT
>=20
> On Tue, Dec 27, 2022 at 03:56:06PM +0100, Victor Laforet wrote:
>> Hi all,
>>
>> I am trying to use bpf_probe_read_user to read a user space value from B=
PF. The issue is that I am getting -14 (-EFAULT) result from bpf_probe_read=
_user. I haven=E2=80=99t been able to make this function work reliably. Som=
etimes I get no error code then it goes back to EFAULT.
>>
>> I am seeking your help to try and make this code work.
>> Thank you!
>>
>> My goal is to read the variable pid on every bpf event.
>> Here is a full example:
>> (cat /sys/kernel/debug/tracing/trace_pipe to read the output).
>>
>> sched_switch.bpf.c
>> ```
>> #include "vmlinux.h"
>> #include <bpf/bpf_helpers.h>
>>
>> int *input_pid;
>>
>> char _license[4] SEC("license") =3D "GPL";
>>
>> SEC("tp_btf/sched_switch")
>> int handle_sched_switch(u64 *ctx)
>=20
> you might want to filter for your task, because sched_switch
> tracepoint is called for any task scheduler switch
>=20
> check BPF_PROG macro in bpf selftests on how to access tp_btf
> arguments from context, for sched_switch it's:
>=20
>          TP_PROTO(bool preempt,
>                   struct task_struct *prev,
>                   struct task_struct *next,
>                   unsigned int prev_state),
>=20
> and call the read helper only for prev->pid =3D=3D 'your app pid',
>=20
> there's bpf_copy_from_user_task helper you could use to read
> another task's user memory reliably, but it needs to be called
> from sleepable probe and you need to have the task pointer
>=20
> jirka
>=20
>> {
>>    int pid;
>>    int err;
>>
>>    err =3D bpf_probe_read_user(&pid, sizeof(int), (void *)input_pid);
>>    if (err !=3D 0)
>>    {
>>      bpf_printk("Error on bpf_probe_read_user(pid) -> %d.\n", err);
>>      return 0;
>>    }
>>
>>    bpf_printk("pid %d.\n", pid);
>>    return 0;
>> }
>> ```
>>
>> sched_switch.c
>> ```
>> #include <stdio.h>
>> #include <unistd.h>
>> #include <sys/resource.h>
>> #include <bpf/libbpf.h>
>> #include "sched_switch.skel.h"
>> #include <time.h>
>>
>> static int libbpf_print_fn(enum libbpf_print_level level, const char *fo=
rmat, va_list args)
>> {
>>    return vfprintf(stderr, format, args);
>> }
>>
>> int main(int argc, char **argv)
>> {
>>    struct sched_switch_bpf *skel;
>>    int err;
>>    int pid =3D getpid();
>>
>>    libbpf_set_print(libbpf_print_fn);
>>
>>    skel =3D sched_switch_bpf__open();
>>    if (!skel)
>>    {
>>      fprintf(stderr, "Failed to open BPF skeleton\n");
>>      return 1;
>>    }
>>
>>    skel->bss->input_pid =3D &pid;
>>
>>    err =3D sched_switch_bpf__load(skel);
>>    if (err)
>>    {
>>      fprintf(stderr, "Failed to load and verify BPF skeleton\n");
>>      goto cleanup;
>>    }
>>
>>    err =3D sched_switch_bpf__attach(skel);
>>    if (err)
>>    {
>>      fprintf(stderr, "Failed to attach BPF skeleton\n");
>>      goto cleanup;
>>    }
>>
>>    while (1);
>>
>> cleanup:
>>    sched_switch_bpf__destroy(skel);
>>    return -err;
>> }
>> ```
