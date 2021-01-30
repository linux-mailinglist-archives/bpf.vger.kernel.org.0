Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40663309374
	for <lists+bpf@lfdr.de>; Sat, 30 Jan 2021 10:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhA3JfR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Jan 2021 04:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbhA3DVf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jan 2021 22:21:35 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D374C061793
        for <bpf@vger.kernel.org>; Fri, 29 Jan 2021 19:13:41 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id i187so15234980lfd.4
        for <bpf@vger.kernel.org>; Fri, 29 Jan 2021 19:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VIpF+PbaHraNBTaBA2nhbf4llFtewHGcpC0aXFC+UY=;
        b=IqDwv5WYIZk1wjEDO2VyhbkzZvQXPaZg1nfPpQl/UHEOUIhJ9Pl4YOzr7GlnhBgYnA
         gQcRuRPkNEFbRUc2gFSkPPnct+pPmACr87KYwfEZVvgAj6ORu+25QZq+OI10+028U4zw
         IDkYHiq0+1IyJfImiypb6KKQdt2WJd+QqYEAEBQ7yVRn6azVRL0a4kmEoiMue5H+nQzO
         lEFUruTwmEwNF85WpvcBfwzdvefr3NuBgQYZ+nurAFZiGPOY7MK+V0d7NSkx1FXnY+KC
         v0/dc1N7I/5Xk+thez/Y4Y8PXrl0CCerKbT6+oT414cRtqv7StHVZkyLZbB0O2DaNArk
         WRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VIpF+PbaHraNBTaBA2nhbf4llFtewHGcpC0aXFC+UY=;
        b=rp9VSQzJm7F8qPRyAhLh0SQzP0nvOXHgV0y23DbnKxzfXnn62EtkEguzRHhw7gk7Md
         8+bmxZr5/ACrwDVRDDoXU0V+qsFs6moDZ9D0tsafKUpd2cBw6Hai2VvIJHxBrNn/vjaf
         sIGK7OThmyK/hRY9iSmzIF7j2IMatYpiQL6m294TmCpT0ZxNDN7/aADkXdeJU+ZdhruL
         NwQo+ayk/jYTtMwoc4QbRHW5TvpcmSSoO0WY5gmegbITUF9BQYiIgoN8T+MqY6gv51jS
         WjqCrJjoHWY5DsUH8rVzukoROazWSW9Ssv4e9buM4NFAkknUGFo/bguSj1UiLhN+SnFl
         hk4g==
X-Gm-Message-State: AOAM5329lGU/W4N0yUfti03uyJHK2n35xzQgQptBmkv8I8LMFi5cQ39p
        sfTggFhhrC+9zCesgPSlXMztXYR5zeeeRJPWLZ8Drigc
X-Google-Smtp-Source: ABdhPJzV5CAdQEnkO5fTe00ZwSp1WoecpzNvdOjcas13WRcJXzdjLAKE3+Cc9WWf849GpVhFg+i4+IDwqYkRV7oR14U=
X-Received: by 2002:a05:6512:2254:: with SMTP id i20mr3598833lfu.534.1611976412644;
 Fri, 29 Jan 2021 19:13:32 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhQgy959hkpU8fwZnrTqGphVSA+ONF99Yy4ZQFyjQ_030A@mail.gmail.com>
 <CAADnVQJaJ0i2L2k-dM+neeT61q+pwEd+F6ASGh4Xbi-ogj0hfQ@mail.gmail.com> <CAHC9VhSTJ=009hsXm=8jtQ_ZL-n=+tzKPbWj2Cnoa5w3iVNuew@mail.gmail.com>
In-Reply-To: <CAHC9VhSTJ=009hsXm=8jtQ_ZL-n=+tzKPbWj2Cnoa5w3iVNuew@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 29 Jan 2021 19:13:21 -0800
Message-ID: <CAADnVQKbku+Mv++h2TKYZfFN7NjPgaeLHJsw0oFNUhjUZ6ehSQ@mail.gmail.com>
Subject: Re: selftest/bpf/test_verifier_log fails on v5.11-rc5
To:     Paul Moore <paul@paul-moore.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 2:15 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Jan 25, 2021 at 5:42 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Mon, Jan 25, 2021 at 12:54 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > Hello all,
> > >
> > > My apologies if this has already been reported, but I didn't see
> > > anything obvious with a quick search through the archives.  I have a
> > > test program that behaves very similar to the existing
> > > selftest/bpf/test_verifier_log test that has started failing this week
> > > with v5.11-rc5; it ran without problem last week on v5.11-rc4.  Is
> > > this a known problem with a fix already, or is this something new?
> > >
> > > % uname -r
> > > 5.11.0-0.rc5.134.fc34.x86_64
> > > % pwd
> > > /.../linux/tools/testing/selftests/bpf
> > > % git log --oneline | head -n 1
> > > 6ee1d745b7c9 Linux 5.11-rc5
> > > % make test_verifier_log
> > >   ...
> > >   BINARY   test_verifier_log
> > > % ./test_verifier_log
> > > Test log_level 0...
> > > Test log_size < 128...
> > > Test log_buff = NULL...
> > > Test oversized buffer...
> > > ERROR: Program load returned: ret:-1/errno:22, expected ret:-1/errno:13
> >
> > Thanks for reporting.
> > bpf and bpf-next don't have this issue. Not sure what changed.
>
> I haven't had a chance to look into this any further, but Ondrej
> Mosnacek (CC'd) found the following today:
>
> "So I was trying to debug this further and I think I've identified what
> triggers the problem. It seems that the BTF debuginfo generation
> became broken with CONFIG_DEBUG_INFO_DWARF4=n somewhere between -rc4
> and -rc5. It also seems to depend on a recent (Fedora Rawhide) version
> of some component of the build system (GCC, probably), because the
> problem disappeared when I tried to build the "bad" kernel in F33
> buildroot instead of Rawhide."

I see. There were fixes for dwarf and btf, but I lost the track.
I believe it was a combination of gcc bug that was worked around in pahole.
Arnaldo, Jiri, Andrii,
what is the status? Did all fixes land in pahole?
