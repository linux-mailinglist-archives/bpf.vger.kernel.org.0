Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D98A3FF43A
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 21:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347390AbhIBTeH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 15:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347257AbhIBTeC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 15:34:02 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBEEC061575
        for <bpf@vger.kernel.org>; Thu,  2 Sep 2021 12:33:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mj9-20020a17090b368900b001965618d019so2218392pjb.4
        for <bpf@vger.kernel.org>; Thu, 02 Sep 2021 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D6dXM1zqlE0MENMsvVQ3PcT3IxW10/PVhM7LHbjLuGU=;
        b=Fu7c7jNxBB7EJL4NNBvLLmwivdZkkfAhGl+FYzsr9M/hjnHLdgTpri3+r+KFxNBqqd
         AAmk9Llwh0z+gt+Cd0bBg7upfhmYL5q5qcAVGInNKBWsmzj5XC6RSd9ad4NmHOeLoBLN
         Y6BIPJgwMHXmgugL22pJ8I5kVs36MchRbNHviwmwRxdOtfT7UiLo+GcetW3lM+KloSkO
         xFYN8YKTjj++qzY31NkEqRzS5MKMru0gPA/ZMx6iVJ9CbZKl9t+Ax/XVBCYZxZ6neBX2
         aYhgF4YlsHV1n5+zvq3Yr6gX6+TxngnRrueEL9+yWLM5qWZW/ZTN9WcMxvrUIbrdOeKW
         zm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D6dXM1zqlE0MENMsvVQ3PcT3IxW10/PVhM7LHbjLuGU=;
        b=Pbh6JLHqMb/R+pfXbWMp/z7nefBwAeRL8ZmHy387NOc+QgDcjJE+L4XzfiAC0VeSkh
         Pq7yBb/39PrRXP/GID/98SlD8qmJdZFEIjS3ig0Gv8KyYzNzOZT1zuovn1IVgPPLpTHQ
         ylTB92VS4I3vM1XVDbMF7Ypv/UEQHcEL0Nut8YhP6HQaadabn74IbtFEbSjfAc88mm6K
         YhWakgMyFlls/e0n5W5eldXx0Q/uXhhqZ3BqYWpArn/w4iwVRrb9cVHLjV02VPN7uktm
         xEs/0CMxasdEg9V0i/rE5QcF3qDx7+S1lhlP5Lj/IaUSS6sKDpYdkraV26szs/zOLD6z
         nepw==
X-Gm-Message-State: AOAM532wF4LdJhbBYu/rYtdUGe6y7tt3NFiL0X97gIEPMC6WpZE7YkAW
        zmSWB7u8n9fSEotgdBVLGS2JehPM7l9QLkJXWwk=
X-Google-Smtp-Source: ABdhPJwTRSaF6mGeZwmeUAqtyg4phufyLCDYO69JFFYOvBcNuBHoesVQIwyVGIPnyKFx8vdb+jA/O+MNsvFCHX1mmmA=
X-Received: by 2002:a17:902:82c6:b0:136:59b0:ed17 with SMTP id
 u6-20020a17090282c600b0013659b0ed17mr4340258plz.61.1630611183389; Thu, 02 Sep
 2021 12:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210826120953.11041-1-toke@redhat.com> <CAEf4BzZ7dcYrGRgOczk-mLC_VcRW3rucj3TRgkRqLgKXFHgtog@mail.gmail.com>
 <87lf4hvrgc.fsf@toke.dk> <a65e20f9-d554-761e-9a9e-8a9dfcf13919@fb.com> <87wnnysy6k.fsf@toke.dk>
In-Reply-To: <87wnnysy6k.fsf@toke.dk>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 2 Sep 2021 12:32:52 -0700
Message-ID: <CAADnVQKYdjFR+LvnQFdKF=TJ2fSRdG7B0L+Au9KchBsV+dCr5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: ignore .eh_frame sections when
 parsing elf files
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 2, 2021 at 10:08 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Yonghong Song <yhs@fb.com> writes:
>
> > On 8/31/21 3:28 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >>
> >>> On Thu, Aug 26, 2021 at 5:10 AM Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@redhat.com> wrote:
> >>>>
> >>>> When .eh_frame and .rel.eh_frame sections are present in BPF object =
files,
> >>>> libbpf produces errors like this when loading the file:
> >>>>
> >>>> libbpf: elf: skipping unrecognized data section(32) .eh_frame
> >>>> libbpf: elf: skipping relo section(33) .rel.eh_frame for section(32)=
 .eh_frame
> >>>>
> >>>> It is possible to get rid of the .eh_frame section by adding
> >>>> -fno-asynchronous-unwind-tables to the compilation, but we have seen
> >>>> multiple examples of these sections appearing in BPF files in the wi=
ld,
> >>>> most recently in samples/bpf, fixed by:
> >>>> 5a0ae9872d5c ("bpf, samples: Add -fno-
/to BPF Clang invocation")
> >>>>
> >>>> While the errors are technically harmless, they look odd and confuse=
 users.
> >>>
> >>> These warnings point out invalid set of compiler flags used for
> >>> compiling BPF object files, though. Which is a good thing and should
> >>> incentivize anyone getting those warnings to check and fix how they d=
o
> >>> BPF compilation. Those .eh_frame sections shouldn't be present in BPF
> >>> object files at all, and that's what libbpf is trying to say.
> >>
> >> Apart from triggering that warning, what effect does this have, though=
?
> >> The programs seem to work just fine (as evidenced by the fact that
> >> samples/bpf has been built this way for years, for instance)...
> >>
> >> Also, how is a user supposed to go from that cryptic error message to
> >> figuring out that it has something to do with compiler flags?
> >>
> >>> I don't know exactly in which situations that .eh_frame section is
> >>> added, but looking at our selftests (and now samples/bpf as well),
> >>> where we use -target bpf, we don't need
> >>> -fno-asynchronous-unwind-tables at all.
> >>
> >> This seems to at least be compiler-dependent. We ran into this with
> >> bpftool as well (for the internal BPF programs it loads whenever it
> >> runs), which already had '-target bpf' in the Makefile. We're carrying
> >> an internal RHEL patch adding -fno-asynchronous-unwind-tables to the
> >> bpftool build to fix this...
> >
> > I haven't seen an instance of .eh_frame as well with -target bpf.
> > Do you have a reproducible test case? I would like to investigate
> > what is the possible cause and whether we could do something in llvm
> > to prevent its generatin. Thanks!
>
> We found this in the RHEL builds of bpftool. I don't think we're doing
> anything special, other than maybe building with a clang version that's
> a few versions behind:
>
> # clang --version
> clang version 11.0.0 (Red Hat 11.0.0-1.module+el8.4.0+8598+a071fcd5)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
>
> So I suppose it may resolve itself once we upgrade LLVM?

That's odd. I don't think I've seen this issue even with clang 11
(but I built it myself).
If there is a fix indeed let's backport it to llvm 11. The user
experience matters.
It could be llvm configuration too.
I'm guessing some build flags might influence default settings
for unwind tables.

Yonghong, can we make bpf backend to ignore needsUnwindTableEntry ?
