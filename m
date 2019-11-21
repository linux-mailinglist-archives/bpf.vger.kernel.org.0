Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE30105D38
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2019 00:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfKUXlq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Nov 2019 18:41:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38542 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKUXlp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Nov 2019 18:41:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id v8so5202202ljh.5
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2019 15:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U/NYMVfpDgcrOYIDYMCLg/PUSAirJCRUEzzkMLwO8gM=;
        b=t5GfUg8zWrh4YJAAGa/KaUUK9Pht0QAEJloqyFP8qFqMlaRsKMGUl8I4Vl0rGX2S11
         PYnLdmYcHz9Psz0K/NQq34DywjFEt+m8YT4Ybogtey46HS006vSF3dxh/ObWngTq9laC
         T7imTTq2odEanAz97fEMljz/TJHm6pftBM5UucdDon6bP+1mMgFKt8iHBVJsHS10IJ45
         r9jgCb1ARzIHxc+mjnu1zLYu9/PCQhkiWS4ojOlwlyOwagsdeE3JNSTtoDoy3QvmTDxP
         IPigRaKrGnUuWG0fuZq/Z9pzg3sHNtgphbqxk7cwl2FyHzJKJlqtrCeMnvEO7T4xvo9v
         Zu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U/NYMVfpDgcrOYIDYMCLg/PUSAirJCRUEzzkMLwO8gM=;
        b=p1CLgOHduDixIUoT3/1tEJR1CqWngue0OyQy4HHsLTaRVNMfoLzgJbJcvn8/2Ecf2P
         CsF2Ruerr4+j0gN7euNXYTaxTdNbNmauSDdx2a9/gZb8jWcV8CS4gJI4jkmTI8eYQ7D5
         kAQsW0HcdPX9gx4T8GNYS47Ffl7EjbjxSNPa37EO+P1GoFAmme5bcpOvDMGT4URSHXZ+
         fhT/zO0KVXdC565s7Hp/CWM5Cy84ZXlbXjJNnO87g1psZmU3mi18bw090Sl3Gw5O5V4F
         K18lIFdkGA8ZyZFEudeRS/8FYtv9o0x3XP4mKPfXFCbKLkVKUrsz9LyglmEqOH8Bxx4a
         UCyA==
X-Gm-Message-State: APjAAAXbMb8hNT6N/FVChNzmnIvJPyy3zTac6aXj9pvFJ0UsZ2TOz2iS
        Wp6qryDUZQ7mMnYS0pU6xRLs2Scv2zWrmhezeSNf
X-Google-Smtp-Source: APXvYqxoUOb+MFtHuWPh2qjo1P+X41fELBJVqTXNUG/wLBCaYpO1NPnnOFQCyDl7kzwpTvntD7FtzWhs00nttRX4zTM=
X-Received: by 2002:a2e:970e:: with SMTP id r14mr9565457lji.57.1574379702619;
 Thu, 21 Nov 2019 15:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20191120213816.8186-1-jolsa@kernel.org> <8c928ec4-9e43-3e2a-7005-21f40fcca061@iogearbox.net>
 <CAADnVQKu-ZgFTaSMH=Q-jMOYYvE32TF2b2hq1=dmDV8wAf18pg@mail.gmail.com>
In-Reply-To: <CAADnVQKu-ZgFTaSMH=Q-jMOYYvE32TF2b2hq1=dmDV8wAf18pg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 21 Nov 2019 18:41:31 -0500
Message-ID: <CAHC9VhQbQoXacbTCNJPGNzFOv30PwLeiWu4ROQFU46=saTeTNQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: emit audit messages upon successful prog load and unload
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-audit@redhat.com, Jiri Olsa <jolsa@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
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

On Wed, Nov 20, 2019 at 4:49 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Wed, Nov 20, 2019 at 1:46 PM Daniel Borkmann <daniel@iogearbox.net> wr=
ote:
> > On 11/20/19 10:38 PM, Jiri Olsa wrote:
> > > From: Daniel Borkmann <daniel@iogearbox.net>
> > >
> > > Allow for audit messages to be emitted upon BPF program load and
> > > unload for having a timeline of events. The load itself is in
> > > syscall context, so additional info about the process initiating
> > > the BPF prog creation can be logged and later directly correlated
> > > to the unload event.
> > >
> > > The only info really needed from BPF side is the globally unique
> > > prog ID where then audit user space tooling can query / dump all
> > > info needed about the specific BPF program right upon load event
> > > and enrich the record, thus these changes needed here can be kept
> > > small and non-intrusive to the core.
> > >
> > > Raw example output:
> > >
> > >    # auditctl -D
> > >    # auditctl -a always,exit -F arch=3Dx86_64 -S bpf
> > >    # ausearch --start recent -m 1334
> > >    [...]
> > >    ----
> > >    time->Wed Nov 20 12:45:51 2019
> > >    type=3DPROCTITLE msg=3Daudit(1574271951.590:8974): proctitle=3D"./=
test_verifier"
> > >    type=3DSYSCALL msg=3Daudit(1574271951.590:8974): arch=3Dc000003e s=
yscall=3D321 success=3Dyes exit=3D14 a0=3D5 a1=3D7ffe2d923e80 a2=3D78 a3=3D=
0 items=3D0 ppid=3D742 pid=3D949 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0=
 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3Dpts0 ses=3D2 comm=3D"test_veri=
fier" exe=3D"/root/bpf-next/tools/testing/selftests/bpf/test_verifier" subj=
=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=3D(null)
> > >    type=3DUNKNOWN[1334] msg=3Daudit(1574271951.590:8974): auid=3D0 ui=
d=3D0 gid=3D0 ses=3D2 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c=
0.c1023 pid=3D949 comm=3D"test_verifier" exe=3D"/root/bpf-next/tools/testin=
g/selftests/bpf/test_verifier" prog-id=3D3260 event=3DLOAD
> > >    ----
> > >    time->Wed Nov 20 12:45:51 2019
> > > type=3DUNKNOWN[1334] msg=3Daudit(1574271951.590:8975): prog-id=3D3260=
 event=3DUNLOAD
> > >    ----
> > >    [...]
> > >
> > > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >
> > LGTM, thanks for the rebase!
>
> Applied to bpf-next. Thanks!

[NOTE: added linux-audit to the To/CC line]

Wait a minute, why was the linux-audit list not CC'd on this?  Why are
you merging a patch into -next that adds to the uapi definition *and*
creates a new audit record while we are at -rc8?

Aside from that I'm concerned that you are relying on audit userspace
changes that might not be okay; I see the PR below, but I don't see
any comment on it from Steve (it is his audit userspace).  I also
don't see a corresponding test added to the audit-testsuite, which is
a common requirement for new audit functionality (link below).  I'm
also fairly certain we don't want this new BPF record to look like how
you've coded it up in bpf_audit_prog(); duplicating the fields with
audit_log_task() is wrong, you've either already got them via an
associated record (which you get from passing non-NULL as the first
parameter to audit_log_start()), or you don't because there is no
associated syscall/task (which you get from passing NULL as the first
parameter).  Please revert, un-merge, etc. this patch from bpf-next;
it should not go into Linus' tree as written.

Audit userspace PR:
* https://github.com/linux-audit/audit-userspace/pull/104

Audit test suite:
* https://github.com/linux-audit/audit-testsuite

Audit folks, here is a link to the thread in the archives:
* https://lore.kernel.org/bpf/20191120213816.8186-1-jolsa@kernel.org/T/#u

--=20
paul moore
www.paul-moore.com
