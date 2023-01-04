Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E071865D737
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 16:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjADPYf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 10:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjADPYe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 10:24:34 -0500
Received: from zproxy110.enst.fr (zproxy110.enst.fr [IPv6:2001:660:330f:2::c0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64C2EB1
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 07:24:30 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        by zproxy110.enst.fr (Postfix) with ESMTP id 37CDD8124F;
        Wed,  4 Jan 2023 16:24:28 +0100 (CET)
Received: from zproxy110.enst.fr ([IPv6:::1])
        by localhost (zproxy110.enst.fr [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id h5qR78F9jTB0; Wed,  4 Jan 2023 16:24:27 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
        by zproxy110.enst.fr (Postfix) with ESMTP id BF0CE81269;
        Wed,  4 Jan 2023 16:24:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy110.enst.fr BF0CE81269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ip-paris.fr;
        s=DC645FAA-A815-11EB-B77D-7E405BEDA08B; t=1672845867;
        bh=mqM87GZnNdNeOa1zrQ8ZSBe0TRLUV5MPVAyG6fQgf+8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=cB52+bE5Kw2OYmpt9M8U3+3Fq51oA2iQdYaj8kDm2CTCyLBXY1faQoM1CYvS+Tlwh
         F8Fn/n2MGKXmsGlNgg8JLt/3A+QzdJ/1gPFifsImpcfPzvryzKrWpa5thU83yP03rN
         JWo/XaPHNH6AqXHYvWYbyysmg552cVbxBgL7+JK1TGGbc+5Ig5VAnjHCrQQhoJ6e0i
         0XkSp6kB9moUu6id2L9QyekHiJvskrN9gAAP8zIOjp1w+5WyejlXEkIuVSj/Bt8l9U
         xHoKCxdRNt5YAO6Gd5zbMvB0YbSR7UsV4XwIhsRHCuykjpR3nJeMIXfnT8ej9T3WXe
         +kuZx0J4TiecQ==
X-Virus-Scanned: amavisd-new at zproxy110.enst.fr
Received: from zproxy110.enst.fr ([IPv6:::1])
        by localhost (zproxy110.enst.fr [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Wobi9TVGnHxY; Wed,  4 Jan 2023 16:24:27 +0100 (CET)
Received: from zmail-ipp1.enst.fr (zmail-ipp1.enst.fr [137.194.2.209])
        by zproxy110.enst.fr (Postfix) with ESMTP id 9FB038124F;
        Wed,  4 Jan 2023 16:24:27 +0100 (CET)
Date:   Wed, 4 Jan 2023 16:24:27 +0100 (CET)
From:   Victor Laforet <victor.laforet@ip-paris.fr>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org
Message-ID: <1105578275.675049.1672845867568.JavaMail.zimbra@ip-paris.fr>
In-Reply-To: <Y7PhWlqdG/TjwT75@krava>
References: <346230382.476954.1672152966557.JavaMail.zimbra@ip-paris.fr> <Y6sWqgncfvtRHp+b@krava> <505155146.488099.1672236042622.JavaMail.zimbra@ip-paris.fr> <42d3f4d8-fa8b-5774-0f6b-b12162c24736@meta.com> <5692f180-5b78-48e0-b974-b60bd58c0839@Spark> <Y7PhWlqdG/TjwT75@krava>
Subject: Re: bpf_probe_read_user EFAULT
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2a04:8ec0:0:144:e9f5:68c4:e3a1:2559]
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - GC108 (Mac)/9.0.0_GA_4478)
Thread-Topic: bpf_probe_read_user EFAULT
Thread-Index: l2VwSDzLdlWsCvnEX5viTFOLpZAESQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BAD_THREAD_QP_64,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ok thanks. As I understand, tp_btf/+ probes (specifically tp_btf/sched_swit=
ch that I need) cannot be sleepable? It is then not possible to read user s=
pace memory from the bpf code?

----- Mail original -----
De: "Jiri Olsa" <olsajiri@gmail.com>
=C3=80: "Victor Laforet" <victor.laforet@ip-paris.fr>
Cc: "Jiri Olsa" <olsajiri@gmail.com>, "Yonghong Song" <yhs@meta.com>, "bpf"=
 <bpf@vger.kernel.org>
Envoy=C3=A9: Mardi 3 Janvier 2023 09:03:38
Objet: Re: bpf_probe_read_user EFAULT

On Mon, Jan 02, 2023 at 11:07:50PM +0100, Victor Laforet wrote:
> Thanks!
>=20
> I have tried to use bpf_copy_from_user_task() in place of bpf_probe_read_=
user() however I cannot seem to run my program. It fails with 'unknown func=
 bpf_copy_from_user_task=E2=80=99.
> If I understood correctly, this function should be in =E2=80=98bpf/bpf_he=
lpers.h=E2=80=99?

the declaration is in bpf_helper_defs.h, which is included by
bpf_helpers.h, so you need to #include it

>=20
> Another quick question:
> I have set the bpf program as sleepable using =E2=80=98=09bpf_program__se=
t_flags(skel, BPF_F_SLEEPABLE);'
> I couldn=E2=80=99t find any other way to do that. Is it the right way to =
set it sleepable?

should work, but you could specify that directly in the program
section name, like SEC("fentry.s/...")

and it's just certain program types that can sleep:

=09[jolsa@krava bpf]$ grep SEC_SLEEPABLE libbpf.c
=09...
        SEC_DEF("uprobe.s+",            KPROBE, 0, SEC_SLEEPABLE, attach_up=
robe),
        SEC_DEF("uretprobe.s+",         KPROBE, 0, SEC_SLEEPABLE, attach_up=
robe),
        SEC_DEF("fentry.s+",            TRACING, BPF_TRACE_FENTRY, SEC_ATTA=
CH_BTF | SEC_SLEEPABLE, attach_trace),
        SEC_DEF("fmod_ret.s+",          TRACING, BPF_MODIFY_RETURN, SEC_ATT=
ACH_BTF | SEC_SLEEPABLE, attach_trace),
        SEC_DEF("fexit.s+",             TRACING, BPF_TRACE_FEXIT, SEC_ATTAC=
H_BTF | SEC_SLEEPABLE, attach_trace),
        SEC_DEF("lsm.s+",               LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | =
SEC_SLEEPABLE, attach_lsm),
        SEC_DEF("iter.s+",              TRACING, BPF_TRACE_ITER, SEC_ATTACH=
_BTF | SEC_SLEEPABLE, attach_iter),
        SEC_DEF("syscall",              SYSCALL, 0, SEC_SLEEPABLE),

jirka


>=20
> Victor
> On 28 Dec 2022 at 20:41 +0100, Yonghong Song <yhs@meta.com>, wrote:
> >
> >
> > On 12/28/22 6:00 AM, Victor Laforet wrote:
> > > Yes I am sorry I did not mention that the example I sent was a minima=
l working example. I am filtering the events to select only preempted and e=
vents with the right pid as prev.
> > >
> > > Would bpf_copy_from_user_task work better in this setting than bpf_pr=
obe_read_user ?
> > > I don=E2=80=99t really understand why bpf_probe_read_user would not w=
ork for this use case.
> >
> > Right, bpf_copy_from_user_task() is better than bpf_probe_read_user().
> > You could also use bpf_copy_from_user() if you have target_pid checking=
.
> >
> > It is possible that the user variable you intended to access is not in
> > memory. In such cases, bpf_probe_read_user() will return EFAULT. But
> > bpf_copy_from_user() and bpf_copy_from_user_task() will go through
> > page fault process to bring the variable to the memory.
> > Also because of this extra work, bpf_copy_from_user() and
> > bpf_copy_from_user_task() only work for sleepable programs.
> >
> > >
> > > Victor
> > >
> > > ----- Mail original -----
> > > De: "Jiri Olsa" <olsajiri@gmail.com>
> > > =C3=80: "Victor Laforet" <victor.laforet@ip-paris.fr>
> > > Cc: "bpf" <bpf@vger.kernel.org>
> > > Envoy=C3=A9: Mardi 27 D=C3=A9cembre 2022 17:00:42
> > > Objet: Re: bpf_probe_read_user EFAULT
> > >
> > > On Tue, Dec 27, 2022 at 03:56:06PM +0100, Victor Laforet wrote:
> > > > Hi all,
> > > >
> > > > I am trying to use bpf_probe_read_user to read a user space value f=
rom BPF. The issue is that I am getting -14 (-EFAULT) result from bpf_probe=
_read_user. I haven=E2=80=99t been able to make this function work reliably=
. Sometimes I get no error code then it goes back to EFAULT.
> > > >
> > > > I am seeking your help to try and make this code work.
> > > > Thank you!
> > > >
> > > > My goal is to read the variable pid on every bpf event.
> > > > Here is a full example:
> > > > (cat /sys/kernel/debug/tracing/trace_pipe to read the output).
> > > >
> > > > sched_switch.bpf.c
> > > > ```
> > > > #include "vmlinux.h"
> > > > #include <bpf/bpf_helpers.h>
> > > >
> > > > int *input_pid;
> > > >
> > > > char _license[4] SEC("license") =3D "GPL";
> > > >
> > > > SEC("tp_btf/sched_switch")
> > > > int handle_sched_switch(u64 *ctx)
> > >
> > > you might want to filter for your task, because sched_switch
> > > tracepoint is called for any task scheduler switch
> > >
> > > check BPF_PROG macro in bpf selftests on how to access tp_btf
> > > arguments from context, for sched_switch it's:
> > >
> > > TP_PROTO(bool preempt,
> > > struct task_struct *prev,
> > > struct task_struct *next,
> > > unsigned int prev_state),
> > >
> > > and call the read helper only for prev->pid =3D=3D 'your app pid',
> > >
> > > there's bpf_copy_from_user_task helper you could use to read
> > > another task's user memory reliably, but it needs to be called
> > > from sleepable probe and you need to have the task pointer
> > >
> > > jirka
> > >
> > > > {
> > > > int pid;
> > > > int err;
> > > >
> > > > err =3D bpf_probe_read_user(&pid, sizeof(int), (void *)input_pid);
> > > > if (err !=3D 0)
> > > > {
> > > > bpf_printk("Error on bpf_probe_read_user(pid) -> %d.\n", err);
> > > > return 0;
> > > > }
> > > >
> > > > bpf_printk("pid %d.\n", pid);
> > > > return 0;
> > > > }
> > > > ```
> > > >
> > > > sched_switch.c
> > > > ```
> > > > #include <stdio.h>
> > > > #include <unistd.h>
> > > > #include <sys/resource.h>
> > > > #include <bpf/libbpf.h>
> > > > #include "sched_switch.skel.h"
> > > > #include <time.h>
> > > >
> > > > static int libbpf_print_fn(enum libbpf_print_level level, const cha=
r *format, va_list args)
> > > > {
> > > > return vfprintf(stderr, format, args);
> > > > }
> > > >
> > > > int main(int argc, char **argv)
> > > > {
> > > > struct sched_switch_bpf *skel;
> > > > int err;
> > > > int pid =3D getpid();
> > > >
> > > > libbpf_set_print(libbpf_print_fn);
> > > >
> > > > skel =3D sched_switch_bpf__open();
> > > > if (!skel)
> > > > {
> > > > fprintf(stderr, "Failed to open BPF skeleton\n");
> > > > return 1;
> > > > }
> > > >
> > > > skel->bss->input_pid =3D &pid;
> > > >
> > > > err =3D sched_switch_bpf__load(skel);
> > > > if (err)
> > > > {
> > > > fprintf(stderr, "Failed to load and verify BPF skeleton\n");
> > > > goto cleanup;
> > > > }
> > > >
> > > > err =3D sched_switch_bpf__attach(skel);
> > > > if (err)
> > > > {
> > > > fprintf(stderr, "Failed to attach BPF skeleton\n");
> > > > goto cleanup;
> > > > }
> > > >
> > > > while (1);
> > > >
> > > > cleanup:
> > > > sched_switch_bpf__destroy(skel);
> > > > return -err;
> > > > }
> > > > ```
