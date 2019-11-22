Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A184A1079E6
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2019 22:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKVVUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Nov 2019 16:20:09 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43679 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKVVUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Nov 2019 16:20:09 -0500
Received: by mail-lj1-f193.google.com with SMTP id y23so8903603ljh.10
        for <bpf@vger.kernel.org>; Fri, 22 Nov 2019 13:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dQSqJ6neRFmXDx8lm8Qp3vA/Za7E/c7vX34zGsQVNcI=;
        b=zmzp5QKjm3RxfhUT+vo2o9N5jizfQvRqUnlGE6/Nm2sVPpCVAu7v7H3TVZ7P68Rt1O
         5/TOHFdfXEunAvzujqG9qhg93NhCkt2y4aaGKTLPy0Yvq0kW/3lto7+h0Fslc3lbB13u
         KcppwARZThe3WDibvrsMaC8C9W7VDzHyZyWEOL9qb4FUqXk/xrPfdBhLuqGoj7qLE7Ta
         wMaActZKiJnFhkBWQc9GMQvwA4dXmQMsbLMd1ogo74FkhaqWtm9jIKuMAayqs/errc93
         DJ5AEHyQDeeDE6Xe/hMBQsesQ2ctd8D2HBMPsFNwnwH4tR7ykf6Y585YlqumJnB7WO+h
         3ISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dQSqJ6neRFmXDx8lm8Qp3vA/Za7E/c7vX34zGsQVNcI=;
        b=mYrXen9brvVjzuLOKc2cu8laenWWq6lAt6U7F0yzJXwXNi8KgKHbPSaglORyXKmnb2
         fGVFR15rfELMhKu3/ufKtFLqGFFiCQWKI7sypzx+ZUPTMv0suZrf3oXP25H716Toeeog
         7nyArLGh5QRYNOrPdeUlTjJreDjgH81QCUslfIlnSfJZ8rj7iqmGq0iV8AO+lwZB7NJj
         RuQMgdPbdw78YmCnlKTt/z6lJ9bi/g5r+S9cHisPK5aubvBVnCFfY+KRBprkHw4g/VWv
         rS5lyOFtkSyLDzt7coCnYa3wgWi/RJawQgih93Gtu88F5I+DvLhq8+/oKAns5LVZhiak
         nhyg==
X-Gm-Message-State: APjAAAWxD8dWGoZqihhnx0KbDCFBf4tqm6cnDkqOOxCofISyDAHL2NEy
        Fe2kQXs1yzfid558LN6Zbs9H22bFskFrfXgcGIdm
X-Google-Smtp-Source: APXvYqxYVbuLzbKwGGTALH/2DmA4GvH8Ct41sz4a8CcIQjCWRPZy1Z9qdLAKi6ck2lLud5M83S1DJltWAnNy0qcyvok=
X-Received: by 2002:a2e:95c5:: with SMTP id y5mr13945218ljh.184.1574457606553;
 Fri, 22 Nov 2019 13:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20191120213816.8186-1-jolsa@kernel.org> <8c928ec4-9e43-3e2a-7005-21f40fcca061@iogearbox.net>
 <CAADnVQKu-ZgFTaSMH=Q-jMOYYvE32TF2b2hq1=dmDV8wAf18pg@mail.gmail.com>
 <CAHC9VhQbQoXacbTCNJPGNzFOv30PwLeiWu4ROQFU46=saTeTNQ@mail.gmail.com>
 <20191122002257.4hgui6pylpkmpwac@ast-mbp.dhcp.thefacebook.com>
 <CAHC9VhRihMi_d-p+ieXyuVBcGMs80SkypVxF4gLE_s45GKP0dg@mail.gmail.com> <20191122192353.GA2157@krava>
In-Reply-To: <20191122192353.GA2157@krava>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Nov 2019 16:19:55 -0500
Message-ID: <CAHC9VhRi0JtKgHyAOdAJ=_--vL1VbK7BDq1FnRQ_GwW9P4J_zA@mail.gmail.com>
Subject: Re: [PATCH] bpf: emit audit messages upon successful prog load and unload
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-audit@redhat.com, Jiri Olsa <jolsa@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Steve Grubb <sgrubb@redhat.com>,
        David Miller <davem@redhat.com>,
        Eric Paris <eparis@redhat.com>, Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 22, 2019 at 2:24 PM Jiri Olsa <jolsa@redhat.com> wrote:
> Paul,
> would following output be ok:
>
>     type=3DSYSCALL msg=3Daudit(1574445211.897:28015): arch=3Dc000003e sys=
call=3D321 success=3Dno exit=3D-13 a0=3D5 a1=3D7fff09ac6c60 a2=3D78 a3=3D6 =
items=3D0 ppid=3D1408 pid=3D9266 auid=3D1001 uid=3D0 gid=3D0 euid=3D0 suid=
=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3Dpts0 ses=3D1 comm=3D"test_=
verifier" exe=3D"/home/jolsa/linux/tools/testing/selftests/bpf/test_verifie=
r" subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=3D(null=
)ARCH=3Dx86_64 SYSCALL=3Dbpf AUID=3D"jolsa" UID=3D"root" GID=3D"root" EUID=
=3D"root" SUID=3D"root" FSUID=3D"root" EGID=3D"root" SGID=3D"root" FSGID=3D=
"root"
>     type=3DPROCTITLE msg=3Daudit(1574445211.897:28015): proctitle=3D"./te=
st_verifier"
>     type=3DBPF msg=3Daudit(1574445211.897:28016): prog-id=3D8103 event=3D=
LOAD
>
>     type=3DSYSCALL msg=3Daudit(1574445211.897:28016): arch=3Dc000003e sys=
call=3D321 success=3Dyes exit=3D14 a0=3D5 a1=3D7fff09ac6b80 a2=3D78 a3=3D0 =
items=3D0 ppid=3D1408 pid=3D9266 auid=3D1001 uid=3D0 gid=3D0 euid=3D0 suid=
=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3Dpts0 ses=3D1 comm=3D"test_=
verifier" exe=3D"/home/jolsa/linux/tools/testing/selftests/bpf/test_verifie=
r" subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=3D(null=
)ARCH=3Dx86_64 SYSCALL=3Dbpf AUID=3D"jolsa" UID=3D"root" GID=3D"root" EUID=
=3D"root" SUID=3D"root" FSUID=3D"root" EGID=3D"root" SGID=3D"root" FSGID=3D=
"root"
>     type=3DPROCTITLE msg=3Daudit(1574445211.897:28016): proctitle=3D"./te=
st_verifier"
>     type=3DBPF msg=3Daudit(1574445211.897:28017): prog-id=3D8103 event=3D=
UNLOAD

There is some precedence in using "op=3D" instead of "event=3D" (an audit
"event" is already a thing, using "event=3D" here might get confusing).
I suppose if we are getting really nit-picky you might want to
lower-case the LOAD/UNLOAD, but generally Steve cares more about these
things than I do.

For reference, we have a searchable database of fields here:
* https://github.com/linux-audit/audit-documentation/blob/master/specs/fiel=
ds/field-dictionary.csv

> I assume for audit-userspace and audit-testsuite the change will
> go in as github PR, right? I have the auditd change ready and will
> add test shortly.

You can submit the audit-testsuite either as a GH PR or as a
patch(set) to the linux-audit mailing list, both work equally well.  I
believe has the same policy for his userspace tools, but I'll let him
speak for himself.

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 18925d924c73..c69d2776d197 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -358,8 +358,6 @@ static inline void audit_ptrace(struct task_struct *t=
)
>                 __audit_ptrace(t);
>  }
>
> -extern void audit_log_task(struct audit_buffer *ab);
> -
>                                 /* Private API (for audit.c only) */
>  extern void __audit_ipc_obj(struct kern_ipc_perm *ipcp);
>  extern void __audit_ipc_set_perm(unsigned long qbytes, uid_t uid, gid_t =
gid, umode_t mode);
> @@ -648,8 +646,6 @@ static inline void audit_ntp_log(const struct audit_n=
tp_data *ad)
>  static inline void audit_ptrace(struct task_struct *t)
>  { }
>
> -static inline void audit_log_task(struct audit_buffer *ab)
> -{ }
>  #define audit_n_rules 0
>  #define audit_signals 0
>  #endif /* CONFIG_AUDITSYSCALL */
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 9bf1045fedfa..4effe01ebbe2 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2545,7 +2545,7 @@ void __audit_ntp_log(const struct audit_ntp_data *a=
d)
>         audit_log_ntp_val(ad, "adjust", AUDIT_NTP_ADJUST);
>  }
>
> -void audit_log_task(struct audit_buffer *ab)
> +static void audit_log_task(struct audit_buffer *ab)

I'm slightly concerned that this is based on top of your other patch
which was NACK'ed.  I might not have been clear before, but with the
merge window set to open in a few days, and this change affecting the
kernel interface (uapi, etc.) and lacking a test, this isn't something
that I see as a candidate for the upcoming merge window.  *Please*
revert your original patch first; if you think I'm cranky now I can
promise I'll be a lot more cranky if I see the original patch in -rc1
;)

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index b51ecb9644d0..e3a7fa4d7a82 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1334,7 +1334,6 @@ static const char * const bpf_event_audit_str[] =3D=
 {
>
>  static void bpf_audit_prog(const struct bpf_prog *prog, enum bpf_event e=
vent)
>  {
> -       bool has_task_context =3D event =3D=3D BPF_EVENT_LOAD;
>         struct audit_buffer *ab;
>
>         if (audit_enabled =3D=3D AUDIT_OFF)
> @@ -1342,10 +1341,7 @@ static void bpf_audit_prog(const struct bpf_prog *=
prog, enum bpf_event event)
>         ab =3D audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_BPF);
>         if (unlikely(!ab))
>                 return;
> -       if (has_task_context)
> -               audit_log_task(ab);
> -       audit_log_format(ab, "%sprog-id=3D%u event=3D%s",
> -                        has_task_context ? " " : "",
> +       audit_log_format(ab, "prog-id=3D%u event=3D%s",
>                          prog->aux->id, bpf_event_audit_str[event]);

Other than the "op" instead of "event", this looks reasonable to me.
I would give Steve a chance to comment on it from the userspace side
of things.

>         audit_log_end(ab);
>  }

--=20
paul moore
www.paul-moore.com
