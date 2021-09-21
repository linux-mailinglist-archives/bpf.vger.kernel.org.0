Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB30413BCC
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 22:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhIUUzC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 16:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbhIUUzC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 16:55:02 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C07C061574
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 13:53:33 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id bk29so1839737qkb.8
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 13:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ukMMMqRqYmfo2UwtncXND6MNUb86kO2vp95O/RdULmA=;
        b=RvoOAKnzvupk7Q87O5HQF8/CyssWNahgv8U8UhckKBnoVLdq6WEn771V2w3M7BjAqv
         Oij999NlndOd7TKqMR2hbKDmeM3Gw1p5/khl/+r/6lsELAT07wjiPaxh9F6g3t7OOkR4
         OEQ6PTYj/iIyQAIHY0GjOa8KW1u2KITW/fXkPzAVv+QIyFOMLhGU9ON7HusSY4a2PsBP
         zqJhmX0DsQ5mHUVIVusGRvtqbrTRVMD9OUj17AGR4me57aPONKGVAySCcOZHolwSzvtL
         LbIOR3r3F/+Qe6O/WTnWeMvdnXCtrW8inbW1fZMBcsAWmfj7/9TVg5H8+wFQv6vKDHz/
         hjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ukMMMqRqYmfo2UwtncXND6MNUb86kO2vp95O/RdULmA=;
        b=zFhrav4CiDI4d7dqoMYVBipkkJKAD8H9Tgw/GlCFh+U0wHb1JVKN2/UCgUZFlBFTXG
         2yj5v4euSNQLH1xMddwHdR7eDas0draFn8VL2sd2cjKDvy56JeBZHKszXJju+BgHYU7C
         hHvHf/WFL6TtQrb1ZDxq4WC7r9122cKrefB1Hhhcy5mtjq9hfjWmqJYo0fpdtlbnyB44
         SMy4u26fyf0wONDvmlVDABtuXswjgQLbMVpUOSLUzxNE50MKs52oLW+Fdo+40YIKw75o
         VAT/FQZhM8giEtE+ronPoYqelAleNZd6ILofVaWE5IPpkH1M7ZNZxLqi2f9C8DpDZ0vV
         JnRA==
X-Gm-Message-State: AOAM532uXrsjLgVXnSzJTl5Ie5qXj7OauPhDjoOWTiEofu8gyRhDIBWG
        QDYZSmht9ByfpVCS1CyOroEfHSoXasgC7v9HagE=
X-Google-Smtp-Source: ABdhPJyntlvJuscDBJkraH/q4IPVNKlWI05Dl7y/DYCqhnwNatz+lhEbqA9Y+Q963mpUjZ2XuCGxUfqoQMnXRBSAqPs=
X-Received: by 2002:a25:1a44:: with SMTP id a65mr42262983yba.181.1632257612344;
 Tue, 21 Sep 2021 13:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210920231617.3141867-1-andrii@kernel.org> <20210920231617.3141867-3-andrii@kernel.org>
 <CAADnVQ+m+DCPBvHd0X_e=YGn+COKT79nCgSGzxCWAtN34xZevw@mail.gmail.com>
 <CAEf4BzZH1NP9n7H4vA1usoThrL8Zaa1_KdVQkAdE_88K+yOnfA@mail.gmail.com> <CAADnVQKs1gP8_+_uFps3L3ZHDX8yLCW3fyAm0FuZbkSAQ2EYfA@mail.gmail.com>
In-Reply-To: <CAADnVQKs1gP8_+_uFps3L3ZHDX8yLCW3fyAm0FuZbkSAQ2EYfA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Sep 2021 13:53:21 -0700
Message-ID: <CAEf4BzYUzJsR6iGrnemXmdfXGu=EgonEdbdAY0MPej31rw41SA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: adopt attach_probe selftest
 to work on old kernels
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 21, 2021 at 1:48 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Sep 21, 2021 at 1:47 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Sep 21, 2021 at 1:34 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Sep 20, 2021 at 4:18 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> > > >
> > > > Make sure to not use ref_ctr_off feature when running on old kernels
> > > > that don't support this feature. This allows to test libbpf's legacy
> > > > kprobe and uprobe logic on old kernels.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  .../selftests/bpf/prog_tests/attach_probe.c      | 16 ++++++++++++----
> > > >  1 file changed, 12 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > > > index bf307bb9e446..cbd6b6175d5c 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > > > @@ -14,6 +14,12 @@ void test_attach_probe(void)
> > > >         struct test_attach_probe* skel;
> > > >         size_t uprobe_offset;
> > > >         ssize_t base_addr, ref_ctr_offset;
> > > > +       bool legacy;
> > > > +
> > > > +       /* check is new-style kprobe/uprobe API is supported */
> > > > +       legacy = access("/sys/bus/event_source/devices/kprobe/type", F_OK) != 0;
> > > > +
> > > > +       legacy = true;
> > >
> > > What is the idea of the above?
> > > One of them is a leftover?
> >
> > Oh, sorry, `legacy = true` was me locally testing, forgot to remove
> > that. This will be properly tested in libbpf CI where we have 4.9
> > kernel, I was just trying to simulate this locally on modern kernel.
> > I'll re-submit with this removed.
>
> Got it.
> Could you explain how access() works to detect it?

Yeah, I'll expand the comment with this as well. The gist is that if
/sys/bus/event_source/devices/kprobe/type exists in the system, then
new FD-based kprobe attachment through perf system is supported,
because that file exposes a magic number that's passed to
perf_event_open() to create a kprobe event. So if access() is
successful, then it's a new enough kernel. Having said that, this is a
kprobe-specific file, while uprobe has its own (under
.../uprobe/type). Given we actually care about uprobe features for
this legacy check, I'll switch to an uprobe-specific one. But the idea
is the same.
