Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6267B44B9DF
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 02:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbhKJBQx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 20:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhKJBQw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 20:16:52 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE98C061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 17:14:06 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id q74so2054006ybq.11
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 17:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qUKrNmyIPBecifrVK80yxMa6omthfe44uuxQK1aJOtY=;
        b=C5+Gvmr5XSy4aMV8lDklFJwb6cLsrEzWBjPkRqqSDanccAqyq6Sy9wqjq/6gEKCkW7
         Wj/Zo3qqnba3TzSCGy1hPgRFkx/cVvma9hxeoADGWFuC3Vt+Tfex8Gpr/h8y/ncdbcgp
         qrZ3vtj7r1ATDL+CCLATYXbVnBy6nHVaySs7727FtGHnw2ka9rDFLJd94Rpd/8RVd0Zq
         ZBv1L9wm/BhIXMOwQE5HTMrGNAKXTxBBqtpM+Wnfu86VrreBpR7wAFfsXF3iJ1IWrY+E
         PqQDaS/v/gZnIZKKN3MH0O7JollmVYGHKDdwikoN3YlIkEHf+/qz++mUhsDV47Obk9SO
         LqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qUKrNmyIPBecifrVK80yxMa6omthfe44uuxQK1aJOtY=;
        b=c7ylLjUTwhoYcHHzLjScuHqxhaFYXbLqsnZVCoRsFc3JqxkX+9vV1GRvpZ0VmBX7XF
         wtPM7A3KWz0/u8WE4LQmsqnkAX49q3xt63k/vi46LxUjaL7jLxqJ6sW+ztTTMa/0+1jU
         6paheXpp4+x4XBv6wxd6lHBWISsNraw3+hREdJ8TYAwTMHfeR3C3keXGNpm5RMLEcKun
         aaxWvrdJHn8seO96CWZMiHGUY19LlP8o9flBjAyYFMREPY336RHPiAtGjun0zdVoI+/t
         6eMUwrM7OwgEneNcCdh9wCyWM74lGimXLPR44z6M1Uv1GdiRIqGlYS6LEZFQDAl218Qj
         pn6Q==
X-Gm-Message-State: AOAM531Kzlpe5kJA7WTpT/p4xjHaJ4t+oJXRBQ5EY/YZRUXrGVpzBqM+
        Gd/X49tyMczQycreUSoiO97BOThrqOhfcpGJkgM=
X-Google-Smtp-Source: ABdhPJxm4hwEaorWIXW24mfD6gZxC1GXeKKOrBSR9lVTKn9gR66zN+LebYOBYnpBCnI08rAO34wYRIvU8rHKP6Imx4E=
X-Received: by 2002:a25:cec1:: with SMTP id x184mr13719903ybe.455.1636506845261;
 Tue, 09 Nov 2021 17:14:05 -0800 (PST)
MIME-Version: 1.0
References: <20211104122911.779034-1-toke@redhat.com> <CAEf4BzYGjV5DQB7tqRkSKz6pz-3QtU7uSWQVNJMW4eSjnpF98A@mail.gmail.com>
 <87a6iismca.fsf@toke.dk> <CAEf4BzY9WxjBX65sa=8SJh4XGLGfHgxGKciRGiSUMJAxbQWWYg@mail.gmail.com>
 <87pmrargfc.fsf@toke.dk>
In-Reply-To: <87pmrargfc.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Nov 2021 17:13:53 -0800
Message-ID: <CAEf4BzbysA058zK8wvnxeA=rrqCb+x3bP2X7wOqCj90tAHeFXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: demote log message about unrecognised
 data sections back down to debug
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Ciara Loftus <ciara.loftus@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 8, 2021 at 4:16 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Fri, Nov 5, 2021 at 7:34 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
> >>
> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >>
> >> > On Thu, Nov 4, 2021 at 5:29 AM Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@redhat.com> wrote:
> >> >>
> >> >> When loading a BPF object, libbpf will output a log message when it
> >> >> encounters an unrecognised data section. Since commit
> >> >> 50e09460d9f8 ("libbpf: Skip well-known ELF sections when iterating =
ELF")
> >> >> they are printed at "info" level so they will show up on the consol=
e by
> >> >> default.
> >> >>
> >> >> The rationale in the commit cited above is to "increase visibility"=
 of such
> >> >> errors, but there can be legitimate, and completely harmless, uses =
of extra
> >> >> data sections. In particular, libxdp uses custom data sections to s=
tore
> >> >
> >> > What if we make those extra sections to be ".rodata.something" and
> >> > ".data.something", but without ALLOC flag in ELF, so that libbpf won=
't
> >> > create maps for them. Libbpf also will check that program code never
> >> > references anything from those sections.
> >> >
> >> > The worry I have about allowing arbitrary sections is that if in the
> >> > future we want to add other special sections, then we might run into=
 a
> >> > conflict with some applications. So having some enforced naming
> >> > convention would help prevent this. WDYT?
> >>
> >> Hmm, I see your point, but as the libxdp example shows, this has not
> >> really been "disallowed" before. I.e., having these arbitrary sections
> >> has worked just fine.
> >
> > A bunch of things were not disallowed, but that is changing for libbpf
> > 1.0, so now is the right time :)
> >
> >>
> >> How about we do the opposite: claim a namespace for future libbpf
> >> extensions and disallow (as in, hard fail) if anything unrecognised is
> >> in those sections? For instance, this could be any section names
> >> starting with .BPF?
> >
> > Looking at what we added (.maps, .kconfig, .ksym), there is no common
> > prefix besides ".". I'd be ok to reserve anything starting with "."
> > for future use by libbpf. We can allow any non-dot section without a
> > warning (but it would have to be non-allocatable section). Would that
> > work?
>
> Not really :(
>
> We already use .xdp_run_config as one of the section names in libxdp, so

Are any of those sections allocatable? What if libbpf complains about
allocatable ones only?

Also, how widely libxdp is used so that it's already impossible to
change anything?

> if libbpf errors out on any .-prefixed section, we'll no longer be able
> to load old BPF files. While we can update the calling code to deal with
> any compatibility issues by detecting the libbpf version at compile-time
> we don't have control over the BPF files we load. So there has to be a
> way to opt out of any new stricter libbpf behaviour when loading BPF
> files; I believe we had a similar discussion around map section names.
>
> Any application using libbpf to load BPF files that wants to stay
> compatible with old programs will have the same issue, BTW. iproute2
> comes to mind as one...
>
> -Toke
>
