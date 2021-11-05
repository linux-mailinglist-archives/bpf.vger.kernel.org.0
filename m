Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2C4446894
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 19:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhKESoV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 14:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhKESoU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 14:44:20 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D354EC061714
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 11:41:40 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id e136so21771769ybc.4
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8lafwY9HLFroXJZTyoZZ+4j86I42togXPYiisKD3oWU=;
        b=NmtlWTEj6lksa1QzxAyKUcl8vc04w793+x8oIrHsxs22aFN7Nv8SXWRuCJUmedH9cD
         8k28o8iOVXXle7fW2lisY0UTobTXy6GjCWWgsFL0q8awRBxtjIS0iutWtGF5gvb7Jehx
         Q4CA5b+3g2mUTPWsuFmc0+9oXui9OfnBjGl7zh2deW0ZLTwDwkG+ixkq9m+dxX+AQ0Ph
         F7EieLFVIzeV5p0OXJk/f/M/g/JEEAFV1ryoeMowgTN/+yAS/JWdX+zTmoNHbNxTxB5A
         7MHjsg1hOLrP18skEVVvdUJJJqpoKP8WQKPKGhlAk+x2qM26Y/XVplzGC42uuvhLyzm/
         V4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8lafwY9HLFroXJZTyoZZ+4j86I42togXPYiisKD3oWU=;
        b=343TWyNu+1f8X2/H4qpAVtK17BqCXP+5QD70WOI1SCUnMELV0jU2kvJo5WA0dCU4H1
         /U8ppmki4xXeQCLsBsJdvMAelANXWucFKzBJk2Ek7JQ3qVhLyF9wEo9pbIEm4ZQuSF5Y
         SNYzhilTrhagu5OiXQinJeBT0js1hviwlQEQDQeWOYguldEVUNEXkEVSyBlCCANvF4if
         3uAZQPfUvlz3eVWhcpnQ1ST1kBbj++njYk0OEBpb07AXs5hBvDrUs5mjPIlDqYmP6sfm
         bJiWGqr5cOvatXmH4QH4w8zpsta4mJ+bUiMr9IBBQsT4nv6p086vIxFd78eZ2UtbdhYX
         zJlw==
X-Gm-Message-State: AOAM532RFoPZj9Ydrhu94xGEKo+KOCPV7G65Cy2MqnTCRHHFdgx5eiOW
        uT2mHfoDuHNAD/b6nSLSrQGIIvwAkIuBE71wL6c=
X-Google-Smtp-Source: ABdhPJyI9992aWI1Fr2W/ZPoOu36+4lN9RQani6hyiOboZRbTEnbZawUztt1PxX4DDEN9D/iSu968Kb7r/G2bFV8Io4=
X-Received: by 2002:a25:d010:: with SMTP id h16mr59106958ybg.225.1636137700136;
 Fri, 05 Nov 2021 11:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211104122911.779034-1-toke@redhat.com> <CAEf4BzYGjV5DQB7tqRkSKz6pz-3QtU7uSWQVNJMW4eSjnpF98A@mail.gmail.com>
 <87a6iismca.fsf@toke.dk>
In-Reply-To: <87a6iismca.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 5 Nov 2021 11:41:28 -0700
Message-ID: <CAEf4BzY9WxjBX65sa=8SJh4XGLGfHgxGKciRGiSUMJAxbQWWYg@mail.gmail.com>
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

On Fri, Nov 5, 2021 at 7:34 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Thu, Nov 4, 2021 at 5:29 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
> >>
> >> When loading a BPF object, libbpf will output a log message when it
> >> encounters an unrecognised data section. Since commit
> >> 50e09460d9f8 ("libbpf: Skip well-known ELF sections when iterating ELF=
")
> >> they are printed at "info" level so they will show up on the console b=
y
> >> default.
> >>
> >> The rationale in the commit cited above is to "increase visibility" of=
 such
> >> errors, but there can be legitimate, and completely harmless, uses of =
extra
> >> data sections. In particular, libxdp uses custom data sections to stor=
e
> >
> > What if we make those extra sections to be ".rodata.something" and
> > ".data.something", but without ALLOC flag in ELF, so that libbpf won't
> > create maps for them. Libbpf also will check that program code never
> > references anything from those sections.
> >
> > The worry I have about allowing arbitrary sections is that if in the
> > future we want to add other special sections, then we might run into a
> > conflict with some applications. So having some enforced naming
> > convention would help prevent this. WDYT?
>
> Hmm, I see your point, but as the libxdp example shows, this has not
> really been "disallowed" before. I.e., having these arbitrary sections
> has worked just fine.

A bunch of things were not disallowed, but that is changing for libbpf
1.0, so now is the right time :)

>
> How about we do the opposite: claim a namespace for future libbpf
> extensions and disallow (as in, hard fail) if anything unrecognised is
> in those sections? For instance, this could be any section names
> starting with .BPF?

Looking at what we added (.maps, .kconfig, .ksym), there is no common
prefix besides ".". I'd be ok to reserve anything starting with "."
for future use by libbpf. We can allow any non-dot section without a
warning (but it would have to be non-allocatable section). Would that
work?

>
> -Toke
>
