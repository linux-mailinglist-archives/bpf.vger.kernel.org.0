Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990B841FE11
	for <lists+bpf@lfdr.de>; Sat,  2 Oct 2021 22:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhJBUmL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Oct 2021 16:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJBUmL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Oct 2021 16:42:11 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D93C061714
        for <bpf@vger.kernel.org>; Sat,  2 Oct 2021 13:40:25 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id s137so5941059vke.11
        for <bpf@vger.kernel.org>; Sat, 02 Oct 2021 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LNIVK0kO4OyLgbBlEEKag1wUjDkN0DCQynWh6c8ag18=;
        b=A1H3NecD+cHXG6G5gXmA+fxHVmmvx5TKaiI04gPvAbZvfC7HyeSnYzl6xADuqhHIeC
         XAuZKbBYqFMpbukQMPtggToY+uLmrPujXELFglVjFNuJLUzH3Gn/WZMAY2cF/epQWsYt
         m5k3nVCb5f04t8HtUyUBo7zPw4MpIgJ7pWgkAsoFTJ0VvjEgIpKLdNi5Wneouf3YHEBe
         QhPOIx7AJaJtWbrTCeCqhPOVY5XXF3bgBDYeRqvNBjAvN7RJqhrUOSOGG2ifE2zrd2gl
         zev+LDAYc+oO45zrcrsX7RfQI0nd4I9tlsbn5fEflJSF1tFZMZoUjkhz30tLud6azDg7
         GeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LNIVK0kO4OyLgbBlEEKag1wUjDkN0DCQynWh6c8ag18=;
        b=HKHsx3AIBvLLr5EmQN5s4yA9VUaycb7CS7ZRyYOnyx9zJ6VN3yg051ape8LwbYzGUN
         vzfi3TPyBzetrNauHXRP5k2o/eSQscCJmUEkD0qL13p+IeElZuKxdxj25rZ1Au7ZsCTi
         PmE1kRge1AASDkyqdueojWwlXmMDWcAV/qjNg/AeIQPcAckMqqb6kwHgqgPtfLHNTQVp
         O0crNFdhnwS6ooIUV+HrUoit1rwiawDvIQj3OvJv44XsdI1ozYICytaJbXfs4dqRcou4
         oGSz+T/8i1Z7RCXBhcHfAbeOzMfDHzDD0oIjQZfDnIp+bA7MUMehv8GUpgY2j9PiT7Mx
         o3fA==
X-Gm-Message-State: AOAM530hV4eghsKQM1oY6bpSzSYEt63R5WgzRomB48wStfKFI+gkypuS
        gTv9bEB6yX4uOwucGvihu9jZy/+w8ABeCOU9OgyBWIHjfR2OaQqb
X-Google-Smtp-Source: ABdhPJzsEm7guaAFJZfKI6JguP01/GHgS5JO3A/evzbqNymBFJ96bMKuppzMcQHHKqZkFoGUH6x93zvuV+dE2/9RkDk=
X-Received: by 2002:a1f:cdc7:: with SMTP id d190mr5318066vkg.1.1633207224300;
 Sat, 02 Oct 2021 13:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211001110856.14730-1-quentin@isovalent.com> <CAEf4Bza+C5cNJbvw_n_pR_mVL0rPH2VkZd-AJMx78Fp_m+CpRQ@mail.gmail.com>
In-Reply-To: <CAEf4Bza+C5cNJbvw_n_pR_mVL0rPH2VkZd-AJMx78Fp_m+CpRQ@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Sat, 2 Oct 2021 21:40:13 +0100
Message-ID: <CACdoK4LU-uigbtQw63Yacd_AOzv+_fWuhL-ur20GyqFbE4doqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/9] install libbpf headers when using the library
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 2 Oct 2021 at 00:05, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Oct 1, 2021 at 4:09 AM Quentin Monnet <quentin@isovalent.com> wrote:
> >
> > Libbpf is used at several locations in the repository. Most of the time,
> > the tools relying on it build the library in its own directory, and include
> > the headers from there. This works, but this is not the cleanest approach.
> > It generates objects outside of the directory of the tool which is being
> > built, and it also increases the risk that developers include a header file
> > internal to libbpf, which is not supposed to be exposed to user
> > applications.
> >
> > This set adjusts all involved Makefiles to make sure that libbpf is built
> > locally (with respect to the tool's directory or provided build directory),
> > and by ensuring that "make install_headers" is run from libbpf's Makefile
> > to export user headers properly.
> >
> > This comes at a cost: given that the libbpf was so far mostly compiled in
> > its own directory by the different components using it, compiling it once
> > would be enough for all those components. With the new approach, each
> > component compiles its own version. To mitigate this cost, efforts were
> > made to reuse the compiled library when possible:
> >
> > - Make the bpftool version in samples/bpf reuse the library previously
> >   compiled for the selftests.
> > - Make the bpftool version in BPF selftests reuse the library previously
> >   compiled for the selftests.
> > - Similarly, make resolve_btfids in BPF selftests reuse the same compiled
> >   library.
> > - Similarly, make runqslower in BPF selftests reuse the same compiled
> >   library; and make it rely on the bpftool version also compiled from the
> >   selftests (instead of compiling its own version).
> > - runqslower, when compiled independently, needs its own version of
> >   bpftool: make them share the same compiled libbpf.
> >
> > As a result:
> >
> > - Compiling the samples/bpf should compile libbpf just once.
> > - Compiling the BPF selftests should compile libbpf just once.
> > - Compiling the kernel (with BTF support) should now lead to compiling
> >   libbpf twice: one for resolve_btfids, one for kernel/bpf/preload.
> > - Compiling runqslower individually should compile libbpf just once. Same
> >   thing for bpftool, resolve_btfids, and kernel/bpf/preload/iterators.
>
> The whole sharing of libbpf build artifacts is great, I just want to
> point out that it's also dangerous if those multiple Makefiles aren't
> ordered properly. E.g., if you build runqslower and the rest of
> selftests in parallel without making sure that libbpf already
> completed its build, you might end up building libbpf in parallel in
> two independent make instances and subsequently corrupting generated
> object files. I haven't looked through all the changes (and I'll
> confess that it's super hard to reason about dependencies and ordering
> in Makefile) and I'll keep this in mind, but wanted to bring this up.

I'm not sure how Makefile handles this exactly, I don't know if it can
possibly build the two in parallel or if it's smart enough to realise
that the libbpf.a is the same object in both cases and should be built
only once. Same as you, I didn't hit any issue of this kind when
testing the patches.

> I suspect you already thought about that, but would be worth to call
> out this explicitly.

Ok, how would you like me to mention it? Comments in the Makefiles for
runqslower, the samples, and the selftests?

I'll post a new version addressing this, your other comments, and an
issue I found for the samples/bpf/ while doing more tests.

Thanks for the review and testing!
Quentin
