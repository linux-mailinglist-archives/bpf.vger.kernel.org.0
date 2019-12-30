Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B22412D3A8
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2019 19:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfL3S6d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Dec 2019 13:58:33 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39179 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3S6d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Dec 2019 13:58:33 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so30209995qtm.6;
        Mon, 30 Dec 2019 10:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5FEFjcDA8my2bZUcNbRJBtP3FywoOl3HIIG/fCfRCk8=;
        b=qIcOHgQE/kFeG8KW1Bro9BqC2MpHkT38jV/nN2KAZKOlKu/8HJF6RN+2ph/7kT5+PC
         1ShG3xUCBcWJIwdnc+MM2FVNhOoEIjmoaVtAimxNTr4bHkXhMJwOPLMqS3v5iek4o9JB
         A9uEUtZZv0cN1+xBtp6jKlcCHHXF13TTradNTenhhtPjhkcf3ygy+YUyrAfJFf6qGoyu
         FSQjbtnE9QEZ1QXADvxW9ThuFT/nfSwnoAMsLndWqAfzLqa0s6R7oYgkvU7/otjk/Am/
         reGPr4gtJM5OMI3FoCSCgwUrFODtmbZUvp4u+sGMXm1nq+QZgHKzSxgoVtvG+/twM2Ic
         shQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5FEFjcDA8my2bZUcNbRJBtP3FywoOl3HIIG/fCfRCk8=;
        b=dNcQaYVajEAUakcnATlo/+OZoDekyDMgXMXrObH2zASGNY/JXX2InRfew7wTNWPDln
         sXx7Qta+LVfyTVMIKrL5HqHufNiVo6AkEHTMnrtlhJsDv0vWsvpdV0kIImfc+A5Q1x/i
         DSgOvEPWi5EmqkoWjZR25csFVL1a+jbGchaPWhAq7PcfG2JRU87ZOMgKmCZkdb+0pLdp
         6ONXLr03ksjTEW1kd3grERP3oOihRyw5xF7g9lfbrKiGcENXbdQ20kyZfx1/RmzVeMhU
         PC1dlpQ+ckW8Fbl2p9QlOtG+sdTZjnFwl6QOmBY6laCymnnnG3ncm6My+4k7zzLoOpwl
         cEdg==
X-Gm-Message-State: APjAAAXh8eabrpYThMIk40OGQFrqPTiC113etoF9rfqASP1pDAL1h2Xk
        aSXBg8Dd/F2L/59smP2fNVy8gqosWSW5IQWv7FM=
X-Google-Smtp-Source: APXvYqwDOsS9YHgxCCyXTdNdnNrfhZNvB4d4/wICLKJ0+mcEO1l7YflLkp1qWW8s03+qMMjRRC7UCvLeTeQvZ2v/pUk=
X-Received: by 2002:ac8:7b29:: with SMTP id l9mr17344101qtu.141.1577732311882;
 Mon, 30 Dec 2019 10:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20191220154208.15895-1-kpsingh@chromium.org> <CAEf4BzYiUZtSJKh-UBL0jwyo6d=Cne2YtEyGU8ONykmSUSsuNA@mail.gmail.com>
 <20191230150424.GB70684@google.com>
In-Reply-To: <20191230150424.GB70684@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Dec 2019 10:58:20 -0800
Message-ID: <CAEf4Bzbi8sTvwOnRDDjfDLi7Qzw-=Wq=mqja01OKQW08k7TdFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 30, 2019 at 7:04 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On 23-Dec 22:51, Andrii Nakryiko wrote:
> > On Fri, Dec 20, 2019 at 7:42 AM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > This patch series is a continuation of the KRSI RFC
> > > (https://lore.kernel.org/bpf/20190910115527.5235-1-kpsingh@chromium.org/)
> > >
> >
> > [...]
> >
> > > # Usage Examples
> > >
> > > A simple example and some documentation is included in the patchset.
> > >
> > > In order to better illustrate the capabilities of the framework some
> > > more advanced prototype code has also been published separately:
> > >
> > > * Logging execution events (including environment variables and arguments):
> > > https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_audit_env.c
> > > * Detecting deletion of running executables:
> > > https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_detect_exec_unlink.c
> > > * Detection of writes to /proc/<pid>/mem:
> > > https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_audit_env.c
> >
> > Are you planning on submitting these examples for inclusion into
> > samples/bpf or selftests/bpf? It would be great to have more examples
> > and we can review and suggest nicer ways to go about writing them
> > (e.g., BPF skeleton and global data Alexei mentioned earlier).
>
> Eventually, yes and in selftest/bpf.
>
> But these examples depend on using security blobs and some non-atomic
> calls in the BPF helpers which are not handled as a part of the
> initial patch-set.
>
> Once we have the initial framework finalized, I will update the
> examples and the helpers they are based on and send these separate
> patch-sets on the list for review.

Great! The reason I was asking is that once they are in selftests, it
would be nice to switch them to use all the latest BPF usability
improvements to make code cleaner and have it as another good example
of modern BPF program. Like use BTF-defined maps, BPF skeleton,
vmlinux.h, etc. We can go over this when the time comes, though :)


>
> - KP
>
> >
> > >
> > > We have updated Google's internal telemetry infrastructure and have
> > > started deploying this LSM on our Linux Workstations. This gives us more
> > > confidence in the real-world applications of such a system.
> > >
> > > KP Singh (13):
> > >   bpf: Refactor BPF_EVENT context macros to its own header.
> > >   bpf: lsm: Add a skeleton and config options
> > >   bpf: lsm: Introduce types for eBPF based LSM
> > >   bpf: lsm: Allow btf_id based attachment for LSM hooks
> > >   tools/libbpf: Add support in libbpf for BPF_PROG_TYPE_LSM
> > >   bpf: lsm: Init Hooks and create files in securityfs
> > >   bpf: lsm: Implement attach, detach and execution.
> > >   bpf: lsm: Show attached program names in hook read handler.
> > >   bpf: lsm: Add a helper function bpf_lsm_event_output
> > >   bpf: lsm: Handle attachment of the same program
> > >   tools/libbpf: Add bpf_program__attach_lsm
> > >   bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
> > >   bpf: lsm: Add Documentation
> > >
> >
> > [...]
