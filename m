Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496A731F1D4
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 22:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBRVyU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 16:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBRVyQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Feb 2021 16:54:16 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D43FC061786
        for <bpf@vger.kernel.org>; Thu, 18 Feb 2021 13:53:36 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id p2so6144587edm.12
        for <bpf@vger.kernel.org>; Thu, 18 Feb 2021 13:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lJX+ZMsQFOWh/ba1+WgKu7gSDHan7w+sAnp5mRPqmFs=;
        b=qxyeTiuy22RCnVh8B19E2C3WJe4/GAfIMEcFal09Vr1R8jkF0fcS7iuRfE12SLBhJS
         1kM3pIULy7nR1fcTOyrXbdtaOn+gEd2dtEW2ViCVHBFv14wYkMyE5gOB5h3L2fJhJiZX
         +UyDApjyx3GIoxWko3xfy1wK9IJ0nr2fyYYZy1Uwaf6X9AS5D0UTFiO6TRICdNvj6G1q
         PCg0lQl2soAgeX1Ill+R846955emmLqOHz1HSDytr+Hkn2YxhVwRhzwvUxRLKum89ZPf
         Y/aZOqp6E6n8O5BF8sy9qli56bHWzdQ1VullT3oV8XKmlEssf77LSatV3EjTji5sjZpe
         lErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lJX+ZMsQFOWh/ba1+WgKu7gSDHan7w+sAnp5mRPqmFs=;
        b=Sn/5jApZoQZS6iLJGqGvWEo3gSTNC0LdA2O0FrqJQnq5gpN+yW0jViW6SXGcpSS78v
         etEIZMbdkhULSLppXn9qZebnGaPRg1/JfTfOa1/fxVFSfJcKGJx7ljSn1v0soLm8gBu9
         QarODVdvM+2aw5/jMfheHQLu/r2/4AlmV/tOYSzZkmc1QW8hMie0UOABbaFTN0m2zpAL
         eqgh9/Jh/4PpDAEb3JYFhtpHYvtswJ5h2jfonlUXC/wbFp3BM7KgUNEDnSjfbz04hA9Z
         TA5rcEiCtinbj5gE5yNjVP0WnZ6yCnFmGwWKV5A07jR5wrppUiIqABK+pQHcC0cNgC01
         ZOxQ==
X-Gm-Message-State: AOAM532KesNh2C9Y0hJT9pfOAQbcu3c6XhT0Z/tuGTOvyD4O5zQNMUmj
        00gsfNjjWmYL6kokCNqFCzK/nQDBfslRhv6F1cEk6A==
X-Google-Smtp-Source: ABdhPJx6esC1ykZG4JP73jw6Pk1PfFUrMY6GFvDJ8ibNbSS+w6Ax6Wqo4wCqt4+6thT9SEHL4Y5IFA==
X-Received: by 2002:a05:6402:34c1:: with SMTP id w1mr6149934edc.147.1613685214256;
        Thu, 18 Feb 2021 13:53:34 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id da12sm877418edb.52.2021.02.18.13.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 13:53:33 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id x4so5220421wmi.3;
        Thu, 18 Feb 2021 13:53:33 -0800 (PST)
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr5313193wmc.136.1613685213123;
 Thu, 18 Feb 2021 13:53:33 -0800 (PST)
MIME-Version: 1.0
References: <20210217010821.1810741-1-joe@wand.net.nz> <871rdewqf2.fsf@meer.lwn.net>
 <CADa=RyzDXeJeW7jAVce0zfGX2zN5ZcAv5nwYsX7EtAz=bgZYkg@mail.gmail.com> <878s7lrxcc.fsf@meer.lwn.net>
In-Reply-To: <878s7lrxcc.fsf@meer.lwn.net>
From:   Joe Stringer <joe@cilium.io>
Date:   Thu, 18 Feb 2021 13:53:21 -0800
X-Gmail-Original-Message-ID: <CAOftzPjMCpkvbTddgv_BFCLsN33m=LENMzxa-VA_18sbnch=+g@mail.gmail.com>
Message-ID: <CAOftzPjMCpkvbTddgv_BFCLsN33m=LENMzxa-VA_18sbnch=+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/17] Improve BPF syscall command documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     bpf <bpf@vger.kernel.org>, linux-man@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, mtk.manpages@gmail.com,
        Alexei Starovoitov <ast@kernel.org>,
        Brian Vazquez <brianvv@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Mack <daniel@zonque.org>,
        john fastabend <john.fastabend@gmail.com>,
        Petar Penkov <ppenkov@google.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Sean Young <sean@mess.org>, Yonghong Song <yhs@fb.com>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 18, 2021 at 11:49 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Joe Stringer <joe@cilium.io> writes:
> > * The changes in patch 16 here extended Documentation/bpf/index.rst,
> > but to assist in improving the overall kernel documentation
> > organisation / hierarchy, you would prefer to instead introduce a
> > dedicated Documentation/userspace-api/bpf/ directory where the bpf
> > uAPI portions can be documented.
>
> An objective I've been working on for some years is reorienting the
> documentation with a focus on who the readers are.  We've tended to
> organize it by subsystem, requiring people to wade through a lot of
> stuff that isn't useful to them.  So yes, my preference would be to
> document the kernel's user-space API in the relevant manual.
>
> That said, I do tend to get pushback here at times, and the BPF API is
> arguably a bit different that much of the rest.  So while the above
> preference exists and is reasonably strong, the higher priority is to
> get good, current documentation in *somewhere* so that it's available to
> users.  I don't want to make life too difficult for people working
> toward that goal, even if I would paint it a different color.

Sure, I'm all for it. Unless I hear alternative feedback I'll roll it
under Documentation/userspace-api/bpf in the next revision.

> > In addition to this, today the bpf helpers documentation is built
> > through the bpftool build process as well as the runtime bpf
> > selftests, mostly as a way to ensure that the API documentation
> > conforms to a particular style, which then assists with the generation
> > of ReStructured Text and troff output. I can probably simplify the
> > make infrastructure involved in triggering the bpf docs build for bpf
> > subsystem developers and maintainers. I think there's likely still
> > interest from bpf folks to keep that particular dependency in the
> > selftests like today and even extend it to include this new
> > Documentation, so that we don't either introduce text that fails
> > against the parser or in some other way break the parser. Whether that
> > validation is done by scripts/kernel-doc or scripts/bpf_helpers_doc.py
> > doesn't make a big difference to me, other than I have zero experience
> > with Perl. My first impressions are that the bpf_helpers_doc.py is
> > providing stricter formatting requirements than what "DOC: " +
> > kernel-doc would provide, so my baseline inclination would be to keep
> > those patches to enhance that script and use that for the validation
> > side (help developers with stronger linting feedback), then use
> > kernel-doc for the actual html docs generation side, which would help
> > to satisfy your concern around duplication of the documentation build
> > systems.
>
> This doesn't sound entirely unreasonable.  I wonder if the BPF helper
> could be built into an sphinx extension to make it easy to pull that
> information into the docs build.  The advantage there is that it can be
> done in Python :)

Probably doable, it's already written in python. One thing at a time
though... :)

Cheers,
Joe
