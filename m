Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C784235D6B0
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 06:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhDME6N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 00:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhDME6N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 00:58:13 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19686C061574
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 21:57:54 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id d12so15806057oiw.12
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 21:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YeYL4MyjUd4CWDaf9+JGZ6F/8oQtuaCytvXoBgj2iXg=;
        b=Y7FaWhAR9mwcU/Axl4khfrL6cxrsd5CdHcQ6oGp3AQ/iD6pTe+26giWMUpi35+hR3N
         eBbuIJzRxsVj7xPY6ubBniAxqfn+8lG7v55Eoh00mmMeaQjpTuQp/sfEb+m4TVeeOczO
         XqbuqUGCqbM/I2eko014qrmzY3OzDqWARRkHB8sb7cq62kiHYeQ5SA2mBvC8HUiv/ksU
         s9p2oC5ef0Qd4tsOQvNBuz/ZaYkDAkawSty/VNEC48bqvT4vItnJtWqmsDQDvIDmFdi9
         NdckUHNiM3E5z5+M+aQBxE/YyHYmOFQiEMDsezeio6svktXwn6H1Nah8VAk54MJWKE3D
         lHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YeYL4MyjUd4CWDaf9+JGZ6F/8oQtuaCytvXoBgj2iXg=;
        b=pLTkDCH6OGtzphDR8FooOyyyzchvg6m5VsveDcV22DV7pt3HCAJTBz//ZcOIj/rGlv
         z7uCt5PxvDZjaozSAfPh96qqS/6WjTGKSdhnfUaOEFb4jIjriplkqYu6eEAgvtfz/AkG
         UfdlHtBCkjvJt7um5uIc90dnv3poBsAd9W90BNH0Mz0NV+MQSrV5wxHfKfYyvd/zJjdm
         S0DwWPQTc14dDbcgMTcUfUKC9DYc25Y3n0xKbGyGrR7MjyLJODxJeHUDEq7qe1b3A8vI
         bEDu6fBXQRI2STiZ0PdpHH5uF7gZIwWCkbTzd/lVoqdMzoY+/O8dNM6+qUVCced7AZxT
         B+Sw==
X-Gm-Message-State: AOAM532mrRPljcEtAfQ6XEURjUxclF56wt814Tgyr1P5kc2i7UIca+7f
        huw44n9WL2lZg2NIpPza2fBGZkEhMcOGUwh41x4HuGyta6Zu8g==
X-Google-Smtp-Source: ABdhPJwKjw3hgEVONNTCBabLnc0T34RWFM13pLbe/TJclv1U4Q4AQ4SxdUgII1VWGR/YujQU4RcrHxh0EQKCuLfuIxg=
X-Received: by 2002:aca:4e0b:: with SMTP id c11mr1303728oib.83.1618289873347;
 Mon, 12 Apr 2021 21:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210410175601.831013-1-joe@cilium.io> <CAEf4BzYKVR78gug7UYNb53jvgJ-xvxccjpiTWEgWjccQyUay6w@mail.gmail.com>
In-Reply-To: <CAEf4BzYKVR78gug7UYNb53jvgJ-xvxccjpiTWEgWjccQyUay6w@mail.gmail.com>
From:   Joe Stringer <joe@cilium.io>
Date:   Mon, 12 Apr 2021 21:57:38 -0700
Message-ID: <CADa=RyzeF8KOAzo4O8jHauCbtdPYNb_Amqg28qUjxC-gi+Um3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Make docs tests fail more reliably
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joe Stringer <joe@cilium.io>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 12, 2021 at 8:51 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Apr 10, 2021 at 10:57 AM Joe Stringer <joe@cilium.io> wrote:
> >
> > Previously, if rst2man caught errors, then these would be ignored and
> > the output file would be written anyway. This would allow developers to
> > introduce regressions in the docs comments in the BPF headers.
> >
> > Additionally, even if you instruct rst2man to fail out, it will still
> > write out to the destination target file, so if you ran the tests twice
> > in a row it would always pass. Use a temporary file for the initial run
> > to ensure that if rst2man fails out under "--strict" mode, subsequent
> > runs will not automatically pass.
> >
> > Tested via ./tools/testing/selftests/bpf/test_doc_build.sh
> >
> > Signed-off-by: Joe Stringer <joe@cilium.io>
> > ---
> >  tools/testing/selftests/bpf/Makefile.docs     | 3 ++-
> >  tools/testing/selftests/bpf/test_doc_build.sh | 1 +
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile.docs b/tools/testing/selftests/bpf/Makefile.docs
> > index ccf260021e83..a918790c8f9c 100644
> > --- a/tools/testing/selftests/bpf/Makefile.docs
> > +++ b/tools/testing/selftests/bpf/Makefile.docs
> > @@ -52,7 +52,8 @@ $(OUTPUT)%.$2: $(OUTPUT)%.rst
> >  ifndef RST2MAN_DEP
> >         $$(error "rst2man not found, but required to generate man pages")
> >  endif
> > -       $$(QUIET_GEN)rst2man $$< > $$@
> > +       $$(QUIET_GEN)rst2man --strict $$< > $$@.tmp
> > +       $$(QUIET_GEN)mv $$@.tmp $$@
>
> if something goes wrong this .tmp file will be laying around, so we
> should at least add it to .gitignore?

Right, doesn't look like it's there yet. Will fix it.

I also received out-of-band feedback to use --exit-status rather than
--strict so I'll fix that up as well for a v2.

Cheers,
Joe
