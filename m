Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D648413BB4
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 22:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhIUUsj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 16:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbhIUUsj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 16:48:39 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F0EC061575
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 13:47:10 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id t4so1632886qkb.9
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 13:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZBnmxuW3jp7WGvpXnoixNTOBR4tA3o5FF2NE7RNXqA=;
        b=kjBBkC7nBa3uTLiiLHOpf82TU7PDkVZDg2qmZJaki1hfd5KR905RSgR4qxyURfFiv9
         ZbONrYKtlTbqvS3LbNe+2oCRvv/L0g90SvHwkX8d/EzbPXX5pxv/jWS69sjzoGhaZ+AN
         6gLn8KR7my+p+kvRka0/2hwRuALJRh8loglDH4YkKNTxVXC8/7x6zPr0Y3/EaL0eQ6Mt
         3zDhSiZFSSeDQC8k2U83k3XcSBKioOUo4867di1bHMIyAieOkmQOqxGmMcSlOgHfYx7N
         IXArI5v+XWRI5fuZOezoly1SqAIuLTsu5mAZgNvr38l9BYZ2fAqzqpP7j0dDkzrTPGGc
         0jDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZBnmxuW3jp7WGvpXnoixNTOBR4tA3o5FF2NE7RNXqA=;
        b=S5ZyMX0lv72+f5xWd46LtOELXVTClSfgyQPzuA17OesiQ1nPPd7HROuWdClVJnp+Os
         WfTlU/gEEh3an6tDMhX3UVGy0tFLb/AWwPakNMuggsiiazS2al7dcgnYYukEkojIj9vO
         IXAAaq9q4bJj5lZxoyJUtkAFtCylgQv4Unk6nWELNXPvpWrFLBrdi2+5EC9t9RzLF4gE
         5xwMqXDWYvsK8iX2JwzSG6VXZMKp3WZMQ9dUtAnxQgpox92OI6Tk1OXT7bJRVsO2NNFE
         nV0va4cxyvShGpYiGBLQ/JLDJ3XCo/RR/1sahA03nXyW+Rl4RIBx7a38atSFKtqzWsnl
         poGw==
X-Gm-Message-State: AOAM532jclwpcfS/bn3DkJcwzoKqEAKWw+CCKnmTcxeXK0gtAV7/xKY3
        xSAX6ziiBfCiNYDO3qs45wXbGAD5NfFGW9nCIpLIqzfU
X-Google-Smtp-Source: ABdhPJyZuJvCrWgJPLpqqtOUHZZFE5tmbUDV3p6KNQpgDTko35PNSQdQDBEskh2zbBNyuC+LUlm4Pos01OxPJb+GlgA=
X-Received: by 2002:a25:fc5:: with SMTP id 188mr39171230ybp.51.1632257229828;
 Tue, 21 Sep 2021 13:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210920231617.3141867-1-andrii@kernel.org> <20210920231617.3141867-3-andrii@kernel.org>
 <CAADnVQ+m+DCPBvHd0X_e=YGn+COKT79nCgSGzxCWAtN34xZevw@mail.gmail.com>
In-Reply-To: <CAADnVQ+m+DCPBvHd0X_e=YGn+COKT79nCgSGzxCWAtN34xZevw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Sep 2021 13:46:58 -0700
Message-ID: <CAEf4BzZH1NP9n7H4vA1usoThrL8Zaa1_KdVQkAdE_88K+yOnfA@mail.gmail.com>
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

On Tue, Sep 21, 2021 at 1:34 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 20, 2021 at 4:18 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Make sure to not use ref_ctr_off feature when running on old kernels
> > that don't support this feature. This allows to test libbpf's legacy
> > kprobe and uprobe logic on old kernels.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  .../selftests/bpf/prog_tests/attach_probe.c      | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > index bf307bb9e446..cbd6b6175d5c 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > @@ -14,6 +14,12 @@ void test_attach_probe(void)
> >         struct test_attach_probe* skel;
> >         size_t uprobe_offset;
> >         ssize_t base_addr, ref_ctr_offset;
> > +       bool legacy;
> > +
> > +       /* check is new-style kprobe/uprobe API is supported */
> > +       legacy = access("/sys/bus/event_source/devices/kprobe/type", F_OK) != 0;
> > +
> > +       legacy = true;
>
> What is the idea of the above?
> One of them is a leftover?

Oh, sorry, `legacy = true` was me locally testing, forgot to remove
that. This will be properly tested in libbpf CI where we have 4.9
kernel, I was just trying to simulate this locally on modern kernel.
I'll re-submit with this removed.
