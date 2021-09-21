Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6187A413BBA
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 22:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhIUUuB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 16:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhIUUuB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 16:50:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3DEC061574
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 13:48:32 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k23so501106pji.0
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 13:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7rrOi78e/EAhxH78yRuBl4cqpyea2TLuPBKAclxaKg=;
        b=MG3M5hE9OqAjCJDDIL+4b5H2oOB8+Go21pEFmmxMBc8uk8kTUlQRpEY32InEh2Zwmf
         QrTSjolTXZl6uheBtxapgYOVgWEa71T3jmycza0O5eluqKEPmqQKIyyJ0aUNmSLSqXhR
         qUdGa1RZqDAt7S/cZReY8ybRArvH8WR5ppggsKW43dF6ti3ZPbpX9x87tWsEgsuxLooT
         cHfC2IXTxGBk1AfMuy4INrIMAozFk7S3exN+Qe+10JhnbJJXYYiUYOFVXN/XnndBnnXO
         BDifNg8KhWaVa4egLq3Z8+SVEYo/kR2wR5TNjLo6WGlrSyR2raTgojxJXeA67Dgrobsm
         wctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7rrOi78e/EAhxH78yRuBl4cqpyea2TLuPBKAclxaKg=;
        b=ZeNAqaXWPZo7eTyq5lybtkRq2zgdK8LtglLW2msh3+bJBvIfrL5hKQB2HSwQEyQXuX
         pQhXfu9cn6z8JDIaskUMUT6S2b4TcXJf0+ClNjU5U7Er8Kr9C4D3AtynWFxErD8Vq3Cq
         BZBk8cyfxESnqUZIGUv6+vvwwy4OIMkl3ZKuRcYMXUV4cYJm7GQ5JDbJRpJISZ3Nnoxy
         oaHwsWcLkjZiIqQolAOGBN+JTFyeMxD4SHEHmdxbutbOtlL7HOVNeX8xy47T3cLcQNUf
         UFg+cGTPpduiPNw5Rli+hkYUPfk3WbsGZ7AQYebM8aztjDW0sWxAC6hYUIxFtNp1rA5N
         WAgA==
X-Gm-Message-State: AOAM533SB8HoYn8kG/6tOlsctmxep+zMPqkn1f8UyBf5+HMOBSbNo3Cn
        XeYU6E4j9mPs0SAH9FW8bw8bLlWO9c5eix9g578=
X-Google-Smtp-Source: ABdhPJzODq1nP5VFATuCPyTvb+tNShb5ZI4kHX+EL2DsVdDhztTfllk1c1rfHtY9McTaxylzRLgJ4HXxzvYNpGa4Swc=
X-Received: by 2002:a17:90a:19d2:: with SMTP id 18mr7402182pjj.122.1632257311841;
 Tue, 21 Sep 2021 13:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210920231617.3141867-1-andrii@kernel.org> <20210920231617.3141867-3-andrii@kernel.org>
 <CAADnVQ+m+DCPBvHd0X_e=YGn+COKT79nCgSGzxCWAtN34xZevw@mail.gmail.com> <CAEf4BzZH1NP9n7H4vA1usoThrL8Zaa1_KdVQkAdE_88K+yOnfA@mail.gmail.com>
In-Reply-To: <CAEf4BzZH1NP9n7H4vA1usoThrL8Zaa1_KdVQkAdE_88K+yOnfA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 21 Sep 2021 13:48:20 -0700
Message-ID: <CAADnVQKs1gP8_+_uFps3L3ZHDX8yLCW3fyAm0FuZbkSAQ2EYfA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: adopt attach_probe selftest
 to work on old kernels
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 21, 2021 at 1:47 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 21, 2021 at 1:34 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Sep 20, 2021 at 4:18 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> > >
> > > Make sure to not use ref_ctr_off feature when running on old kernels
> > > that don't support this feature. This allows to test libbpf's legacy
> > > kprobe and uprobe logic on old kernels.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  .../selftests/bpf/prog_tests/attach_probe.c      | 16 ++++++++++++----
> > >  1 file changed, 12 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > > index bf307bb9e446..cbd6b6175d5c 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > > @@ -14,6 +14,12 @@ void test_attach_probe(void)
> > >         struct test_attach_probe* skel;
> > >         size_t uprobe_offset;
> > >         ssize_t base_addr, ref_ctr_offset;
> > > +       bool legacy;
> > > +
> > > +       /* check is new-style kprobe/uprobe API is supported */
> > > +       legacy = access("/sys/bus/event_source/devices/kprobe/type", F_OK) != 0;
> > > +
> > > +       legacy = true;
> >
> > What is the idea of the above?
> > One of them is a leftover?
>
> Oh, sorry, `legacy = true` was me locally testing, forgot to remove
> that. This will be properly tested in libbpf CI where we have 4.9
> kernel, I was just trying to simulate this locally on modern kernel.
> I'll re-submit with this removed.

Got it.
Could you explain how access() works to detect it?
