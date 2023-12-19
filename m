Return-Path: <bpf+bounces-18333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D3F818FFE
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 19:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D316B1F24B5E
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 18:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A34381A1;
	Tue, 19 Dec 2023 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JjjWjXl2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AC538F87
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7cbe98278f8so679752241.1
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 10:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703012099; x=1703616899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MZidDprQN0C1t5nfrNf1lJcDeo/a0WFKgNv6uOViOY=;
        b=JjjWjXl2x/UOzYRIbgVvVtZtxZeM/zTZdSN+Ze8wdo0xd1AE+aaVwNiNzqE5NSZjTF
         Evd6T9QJW0WxeKfhVYGfdKUjqHQS8wNvV16bt05n8D3jed92aRX86d4jvyeCqcmc2U8u
         JlI5o2YmK83b7M+bJfntC9TAq/pxlcvwZAwwi2WvjSJ5TZk2qRsx/rYIvyY7tugmV3TH
         LroMye4Yer86wx2ueKdvJntDIdzkHuuK6ut55nC2kbvt5bqa9ZdkKrdhB9Cs8qEtJDTk
         woYQs7kF1CKilPN4Fd8tiB2Wl03RSr2n9XPyT45jLqyxah/Bnl/vyy405z/xxkWCPBb3
         F+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703012099; x=1703616899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MZidDprQN0C1t5nfrNf1lJcDeo/a0WFKgNv6uOViOY=;
        b=Kr72lTWy+ozSCA9plK0yEdC9LakrVBY2sVQ8NANycEhsbK+k8MZlP7Y2jbEI7T7f9F
         CGCVG0O2GD3/051nu4YNlAnaLKAE0OKOt7oRRXOrbKJ+MbhGGkAEVwTggXlAO1hS2/y6
         uCHu1R2L5OkMubpBtPBsI6BqbNSvJXeosNW/ze1zbNacWrTXWoy480+pDXL6sSaZncLT
         k+YDPZKNUas2xbqJVTgNsUmFuNaeMHutr4H/A4qwjF+FW7q9xMLulzB+Y1jQFTgZjHoK
         6us0yoWxiFbCR3wYDt6ek3/1WAJqPhwtsGPbFdOKm3/Eu/FuPVpdBuwhMC9vZ8AnwkeD
         rPww==
X-Gm-Message-State: AOJu0YwgavNPHqRxDClY4TS024vHAYesGXVOhNteLSTtV+H4a/jZFPCZ
	qRG9kGR8e4DrldIDc7CCV0Yx52BWDotaLlEnXUhcaX13E4pp7+UPbSsA
X-Google-Smtp-Source: AGHT+IHWgPJJ8+OHXQ9zsQPimQZjstB2rf8nzLtxT3a7zSpIzCOY9hc4p2u+soGuy7uxgXpaN4cDChV7x21japkWDcE=
X-Received: by 2002:a05:6102:a53:b0:464:7a5c:b8e2 with SMTP id
 i19-20020a0561020a5300b004647a5cb8e2mr14897178vss.3.1703012099137; Tue, 19
 Dec 2023 10:54:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3636f52d-f343-45e5-88c6-3c7e28e87a45@linux.dev>
 <20231215174639.1034164-1-dave@dtucker.co.uk> <CAADnVQ+4AYvFnrjsdtwOArA9Mj+6nfg5sgkugLKHNRR_LCB7fg@mail.gmail.com>
In-Reply-To: <CAADnVQ+4AYvFnrjsdtwOArA9Mj+6nfg5sgkugLKHNRR_LCB7fg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Dec 2023 13:54:48 -0500
Message-ID: <CAHC9VhQjpv1sgVaCbBddZxmqYc2FCA6c2y3k3SWuHgZcJUpNCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: Include pid, uid and comm in audit output
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Tucker <dave@dtucker.co.uk>, bpf <bpf@vger.kernel.org>, 
	Dave Tucker <datucker@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Yafang Shao <laoar.shao@gmail.com>, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 1:00=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Fri, Dec 15, 2023 at 9:47=E2=80=AFAM Dave Tucker <dave@dtucker.co.uk> =
wrote:
> >
> > Current output from auditd is as follows:
> >
> > time->Wed Dec 13 21:39:24 2023
> > type=3DBPF msg=3Daudit(1702503564.519:11241): prog-id=3D439 op=3DLOAD
> >
> > This only tells you that a BPF program was loaded, but without
> > any context. If we include the prog-name, pid, uid and comm we get
> > output as follows:
> >
> > time->Wed Dec 13 21:59:59 2023
> > type=3DBPF msg=3Daudit(1702504799.156:99528): op=3DUNLOAD prog-id=3D500=
92
> >         prog-name=3D"test" pid=3D27279 uid=3D0 comm=3D"new_name"
> >
> > With pid, uid a system administrator has much better context
> > over which processes and user loaded which eBPF programs.
> > comm is useful since processes may be short-lived.
> >
> > Signed-off-by: Dave Tucker <dave@dtucker.co.uk>

Assuming you have audit configured to not disable syscall auditing
(most distros disable it by default[1]), you should see a SYSCALL
audit record associated with the bpf(BPF_PROG_LOAD) call.  Below is a
quick example taken from a Fedora Rawhide test system:

type=3DPROCTITLE msg=3Daudit(12/19/2023 13:44:22.917:1976) :
  proctitle=3D(systemd)
type=3DSYSCALL msg=3Daudit(12/19/2023 13:44:22.917:1976) :
  arch=3Dx86_64 syscall=3Dbpf success=3Dyes exit=3D11
  a0=3DBPF_PROG_LOAD a1=3D0x7ffd6c818190 a2=3D0x90 a3=3D0x13
  items=3D0 ppid=3D1 pid=3D29898 auid=3Droot uid=3Droot gid=3Droot
  euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsgid=3Droot
  tty=3D(none) ses=3D4 comm=3Dsystemd
  exe=3D/usr/lib/systemd/systemd
  subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=3D(null)
type=3DBPF msg=3Daudit(12/19/2023 13:44:22.917:1976) :
  prog-id=3D128 op=3DLOAD

You will notice that the full user credentials and process
information, e.g. PID, are captured in the SYSCALL record.
Admittedly, we are missing the BPF program name, which I think could
be a reasonable addition to the BPF record, but I don't want to see us
duplicate information from the SYSCALL record in the BPF record unless
we have a situation where we are loading BPF programs outside a user
syscall event.

[1] https://github.com/linux-audit/audit-documentation/wiki/HOWTO-Fedora-En=
able-Auditing

> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 06320d9abf33..86600ca1f106 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -35,6 +35,7 @@
> >  #include <linux/rcupdate_trace.h>
> >  #include <linux/memcontrol.h>
> >  #include <linux/trace_events.h>
> > +#include <linux/uidgid.h>
> >
> >  #include <net/netfilter/nf_bpf_link.h>
> >  #include <net/netkit.h>
> > @@ -2110,6 +2111,8 @@ static void bpf_audit_prog(const struct bpf_prog =
*prog, unsigned int op)
> >  {
> >         struct audit_context *ctx =3D NULL;
> >         struct audit_buffer *ab;
> > +       const struct cred *cred;
> > +       char comm[sizeof(current->comm)];
> >
> >         if (WARN_ON_ONCE(op >=3D BPF_AUDIT_MAX))
> >                 return;
> > @@ -2120,8 +2123,22 @@ static void bpf_audit_prog(const struct bpf_prog=
 *prog, unsigned int op)
> >         ab =3D audit_log_start(ctx, GFP_ATOMIC, AUDIT_BPF);
> >         if (unlikely(!ab))
> >                 return;
> > -       audit_log_format(ab, "prog-id=3D%u op=3D%s",
> > -                        prog->aux->id, bpf_audit_str[op]);
> > +
> > +       audit_log_format(ab, "op=3D%s prog-id=3D%u",
> > +                        bpf_audit_str[op], prog->aux->id);
> > +       audit_log_format(ab, " prog-name=3D");
> > +       audit_log_untrustedstring(ab, prog->aux->name ?: "(none)");
> > +
> > +       if (current->mm) {
> > +               cred =3D current_cred();
>
> Is this how you're trying to detect whether it's running
> out of workqueue?
> You probably need:
> if (!current->mm || (current->flags & PF_KTHREAD))
>
> But even with that it looks wrong, since
> BPF_AUDIT_UNLOAD message will be _randomly_ unbalanced
> with LOAD message.
> Last __bpf_prog_put() can happen in either context.
>
> You also need to cc Paul.
> He needs to ack it before we can take it.
> As it stands I think this change makes the audit worse.

Thanks Alexei.  Yes, please send any audit related patches to the
audit mailing list.  It's listed in MAINTAINERS, but I've also added
it to the CC line above.

--=20
paul-moore.com

