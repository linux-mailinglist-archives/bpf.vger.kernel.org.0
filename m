Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5ED23D402
	for <lists+bpf@lfdr.de>; Thu,  6 Aug 2020 00:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgHEWof (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Aug 2020 18:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgHEWod (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Aug 2020 18:44:33 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCEBC061574
        for <bpf@vger.kernel.org>; Wed,  5 Aug 2020 15:44:32 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v9so15073135ljk.6
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2020 15:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RK4Dh9MzXllVAsIzPhhNVGuL+AKnrfAiQk8g/AWSVEA=;
        b=IufJS9lZIWH7OVNoy8hDmBx+z6QQCQx/HOP5Nav7Du8b8g8TlElB1rdKsGJ3gjp25g
         YlYQaXDZGs0ecpOedPHQnE0AAJXdw9zQngipDE7b25H4gJP/UtwN5lrls1t0PqqVenN9
         +nRhBdsDWuA6Cc6Is5Sk/7XOIV5zZsfYRiu3qHFNK97e+Cu+RxRv0XgW0dMzte+Fj6je
         9L7UbQT/xF5XGV1v7g3CAzWcUVkI/ATDmq+7kY1yjHoCL2rbFmJfnu7wrsSeD2IxQC50
         1h5TKKpYUxNMFww/hW2E0Ix3ykDcQw5LZX8AJVFuCBbl8S87a68qiEW75XwUviGWPBeC
         6OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RK4Dh9MzXllVAsIzPhhNVGuL+AKnrfAiQk8g/AWSVEA=;
        b=olt087FIc8GI+9WBzw1aAsOebNJyrGP6Csya4kO5+WXzKtBUM8QYz+BoXgRU9tlI2v
         l5M4cb8XHCVjHJkWEsvrjw68H/ghoxNGhjSuJCqUvrheNRNv6NUi06Wy/C3+3AhrHEdx
         mnfOrqwj0jhwoX3S04UVoJ77pciDUDXAJ/K39jdzBRV1Sr33L3rC+3z6tXz70KHz+5l1
         J5d3XWB5TRHPfgG73cL9q+dBlQgiMKMbXWiPxhiftwzEC44WZ8CioHsGes/ItLrhPHGx
         CMz26k/Zq5623KmvTqwr4/0/j5KiUB8zUFu9CwtEHYdbzP4dwebh01FSHcxc/z3NF/rq
         wc9g==
X-Gm-Message-State: AOAM5313CLzhnwBqcJOIODMDDLCjtu+JjGxKuaIvY2cCURwSGBzPMvuZ
        eu7VJrbYVmgv3dnOHhyCBZn+wmhFXWFNXrmuHOc=
X-Google-Smtp-Source: ABdhPJwPi6n+Hj3kBQuf7sDnU6nQlNb9At9vcnYxqcpPPRzso05gTaSRGHJ46r8qKSOXZoVwNVNS8DH8ajRmAdC6Mqk=
X-Received: by 2002:a2e:a489:: with SMTP id h9mr2489566lji.121.1596667470866;
 Wed, 05 Aug 2020 15:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200729162751.GC184844@google.com> <20200804194251.GE184844@google.com>
In-Reply-To: <20200804194251.GE184844@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 5 Aug 2020 15:44:19 -0700
Message-ID: <CAADnVQJ-usRjX20KBuCot3NNmrsVZ5oN3c+cZ86Hbr5a9F7n3g@mail.gmail.com>
Subject: Re: BPF program metadata
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        YiFei Zhu <zhuyifei@google.com>,
        Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 4, 2020 at 12:42 PM <sdf@google.com> wrote:
>
> On 07/29, sdf@google.com wrote:
> > As discussed in
> > https://docs.google.com/presentation/d/1A9Anx8JPHl_pK1aXy8hlxs3V5pkrKwHHtkPf_-HeYTc
> > during BPF office hours, we'd like to attach arbitrary auxiliary
> > metadata to the program, for example, the build timestamp or the commit
> > hash.
>
> > IIRC, the suggestion was to explore BTF and .BTF.ext section in
> > particular.
> > We've spent some time looking at the BTF encoding and BTF.ext section
> > and we don't see how we can put this data into .BTF.ext or even .BTF
> > without any kernel changes.
>
> > The reasoning (at least how we see it):
> > * .BTF.ext is just a container with func_info/line_info/relocation_info
> >    and libbpf extracts the data form this section and passes it to
> >    sys_bpf(BPF_PROG_LOAD); the important note is that it doesn't pass the
> >    whole container to the kernel, but passes the data that's been
> >    extracted from the appropriate sections
> > * .BTF can be used for metadata, but it looks like we'd have to add
> >    another BTF_INFO_KIND() to make it a less messy (YiFei, feel free to
> >    correct me)
>
> > So the question is: are we missing something? Is there some way to add
> > key=value metadata to BTF that doesn't involve a lot of kernel changes?
>
> > If the restrictions above are correct, should we go back to trying to
> > put this metadata into .data section (or maybe even the new .metadata
> > section)? The only missing piece of the puzzle in that case is the
> > ability to extend BPF_PROG_LOAD with a way to say 'hold this map
> > unconditionally'.
> Should we have a short discussion about that this Thu during the office
> hours?

Of course. That's what office hours are for.
Since google folks have trouble with zoom I've added google meets link
to the spreadsheet. Let's try it tomorrow.
