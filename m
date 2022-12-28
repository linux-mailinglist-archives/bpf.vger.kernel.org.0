Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F80657770
	for <lists+bpf@lfdr.de>; Wed, 28 Dec 2022 15:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiL1OAs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Dec 2022 09:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiL1OAr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Dec 2022 09:00:47 -0500
Received: from zproxy130.enst.fr (zproxy130.enst.fr [IPv6:2001:660:330f:2::c2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A625214
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 06:00:45 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        by zproxy130.enst.fr (Postfix) with ESMTP id 6583B120573;
        Wed, 28 Dec 2022 15:00:43 +0100 (CET)
Received: from zproxy130.enst.fr ([IPv6:::1])
        by localhost (zproxy130.enst.fr [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id x94qib2yomAr; Wed, 28 Dec 2022 15:00:43 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
        by zproxy130.enst.fr (Postfix) with ESMTP id E362812057F;
        Wed, 28 Dec 2022 15:00:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy130.enst.fr E362812057F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ip-paris.fr;
        s=DC645FAA-A815-11EB-B77D-7E405BEDA08B; t=1672236042;
        bh=2dfMfgn4BvzKtoQdyq/py8zbDjwtZUaCp01MMm1MsCk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=E4GbSXoXPwOWWyCiOXDQJcovuwZUhnmEA90CDDIbiRS462Dc21hFjlab8P9kV39nE
         myC4Nka5TyScygn02aknnBE+oluEnTYMHtDP0pxQulLq9AuTXUruQjWEB4hXQPO0hU
         5XFb6PTa31nJz+eQSjMu1g7Ov1DVOqrUTVXwArJNujaXSYTs+jbaK/DdybqhbcZ5mE
         k3GMvrsq6/iMAqJWQVuzcxYHLm5QRTXaYr+Zm2diSCdc1ZUF880PyxWq5xm2/IkqUg
         HJLnTNVqUc/2QS9G3W3RsP//AI4t/EDhwacFMsvB/qiJCKVfkQ2ZsnitjhsLa7Z0ev
         KGUEp+OinTuSw==
X-Virus-Scanned: amavisd-new at zproxy130.enst.fr
Received: from zproxy130.enst.fr ([IPv6:::1])
        by localhost (zproxy130.enst.fr [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id vewrNGKJHSmY; Wed, 28 Dec 2022 15:00:42 +0100 (CET)
Received: from zmail-ipp1.enst.fr (zmail-ipp1.enst.fr [137.194.2.209])
        by zproxy130.enst.fr (Postfix) with ESMTP id BFA64120573;
        Wed, 28 Dec 2022 15:00:42 +0100 (CET)
Date:   Wed, 28 Dec 2022 15:00:42 +0100 (CET)
From:   Victor Laforet <victor.laforet@ip-paris.fr>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Message-ID: <505155146.488099.1672236042622.JavaMail.zimbra@ip-paris.fr>
In-Reply-To: <Y6sWqgncfvtRHp+b@krava>
References: <346230382.476954.1672152966557.JavaMail.zimbra@ip-paris.fr> <Y6sWqgncfvtRHp+b@krava>
Subject: Re: bpf_probe_read_user EFAULT
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2a01:e0a:167:4b30:c952:c4a2:7d39:7b02]
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - GC108 (Mac)/9.0.0_GA_4478)
Thread-Topic: bpf_probe_read_user EFAULT
Thread-Index: Dy8sSCgFEUyhJSozelcifAbRNLGv8w==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yes I am sorry I did not mention that the example I sent was a minimal work=
ing example. I am filtering the events to select only preempted and events =
with the right pid as prev.

Would bpf_copy_from_user_task work better in this setting than bpf_probe_re=
ad_user ?
I don=E2=80=99t really understand why bpf_probe_read_user would not work fo=
r this use case.

Victor

----- Mail original -----
De: "Jiri Olsa" <olsajiri@gmail.com>
=C3=80: "Victor Laforet" <victor.laforet@ip-paris.fr>
Cc: "bpf" <bpf@vger.kernel.org>
Envoy=C3=A9: Mardi 27 D=C3=A9cembre 2022 17:00:42
Objet: Re: bpf_probe_read_user EFAULT

On Tue, Dec 27, 2022 at 03:56:06PM +0100, Victor Laforet wrote:
> Hi all,
>=20
> I am trying to use bpf_probe_read_user to read a user space value from BP=
F. The issue is that I am getting -14 (-EFAULT) result from bpf_probe_read_=
user. I haven=E2=80=99t been able to make this function work reliably. Some=
times I get no error code then it goes back to EFAULT.
>=20
> I am seeking your help to try and make this code work.
> Thank you!
>=20
> My goal is to read the variable pid on every bpf event.
> Here is a full example:
> (cat /sys/kernel/debug/tracing/trace_pipe to read the output).
>=20
> sched_switch.bpf.c
> ```
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
>=20
> int *input_pid;
>=20
> char _license[4] SEC("license") =3D "GPL";
>=20
> SEC("tp_btf/sched_switch")
> int handle_sched_switch(u64 *ctx)

you might want to filter for your task, because sched_switch
tracepoint is called for any task scheduler switch

check BPF_PROG macro in bpf selftests on how to access tp_btf
arguments from context, for sched_switch it's:

        TP_PROTO(bool preempt,
                 struct task_struct *prev,
                 struct task_struct *next,
                 unsigned int prev_state),

and call the read helper only for prev->pid =3D=3D 'your app pid',

there's bpf_copy_from_user_task helper you could use to read
another task's user memory reliably, but it needs to be called
from sleepable probe and you need to have the task pointer

jirka

> {
>   int pid;
>   int err;
>=20
>   err =3D bpf_probe_read_user(&pid, sizeof(int), (void *)input_pid);
>   if (err !=3D 0)
>   {
>     bpf_printk("Error on bpf_probe_read_user(pid) -> %d.\n", err);
>     return 0;
>   }
>=20
>   bpf_printk("pid %d.\n", pid);
>   return 0;
> }
> ```
>=20
> sched_switch.c
> ```
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/resource.h>
> #include <bpf/libbpf.h>
> #include "sched_switch.skel.h"
> #include <time.h>
>=20
> static int libbpf_print_fn(enum libbpf_print_level level, const char *for=
mat, va_list args)
> {
>   return vfprintf(stderr, format, args);
> }
>=20
> int main(int argc, char **argv)
> {
>   struct sched_switch_bpf *skel;
>   int err;
>   int pid =3D getpid();
>=20
>   libbpf_set_print(libbpf_print_fn);
>=20
>   skel =3D sched_switch_bpf__open();
>   if (!skel)
>   {
>     fprintf(stderr, "Failed to open BPF skeleton\n");
>     return 1;
>   }
>=20
>   skel->bss->input_pid =3D &pid;
>=20
>   err =3D sched_switch_bpf__load(skel);
>   if (err)
>   {
>     fprintf(stderr, "Failed to load and verify BPF skeleton\n");
>     goto cleanup;
>   }
>=20
>   err =3D sched_switch_bpf__attach(skel);
>   if (err)
>   {
>     fprintf(stderr, "Failed to attach BPF skeleton\n");
>     goto cleanup;
>   }
>=20
>   while (1);
>=20
> cleanup:
>   sched_switch_bpf__destroy(skel);
>   return -err;
> }
> ```
