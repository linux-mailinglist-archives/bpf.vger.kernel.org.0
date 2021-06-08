Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DF53A04AC
	for <lists+bpf@lfdr.de>; Tue,  8 Jun 2021 21:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhFHTxn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Jun 2021 15:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbhFHTxm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Jun 2021 15:53:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F918C061574
        for <bpf@vger.kernel.org>; Tue,  8 Jun 2021 12:51:35 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j2so6382928lfg.9
        for <bpf@vger.kernel.org>; Tue, 08 Jun 2021 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTxSgb3gi2PZWbjWpSxCHsEpbjkztd2v/4Lf1c7oMZ0=;
        b=uueKSCzTCVBCjLiO9vis+j3anKBUaRYZ1UUONLegVz3deSy+pSN8L8OH3XG0ptmRQw
         LKmd/9mTojdBVZfQG6+shXMF3WRdSPpmAOBxjxXJl9eN2bVCsvEJnuwMjaAgCB/hwVFw
         D7ifBtwMClWw6NLLQD4koouJhtpQmetqghGZgdZ5MJY9vxbnB/1ZYrb1pvnw+fgoTpw6
         CpcSBbkMmmN7g9GiNqKvAXiLcAt2RL2Uht4Pdb1rGYFD8NdzCb6CLnX02Xie8qhq0jkS
         RiPhWT2irPAKBx73wvSRTvwN17H/FHXavYhOOIx3FX+T1u8mqCqThwvPKOTeMUTtVE0o
         2UcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTxSgb3gi2PZWbjWpSxCHsEpbjkztd2v/4Lf1c7oMZ0=;
        b=gdTrLTIP+fzYd5BvoVOEkwep9lu3WO3OWGG/03tyPfP246MQcrybVoS1avFg7bf6yQ
         hSA+YqK/R9AOzoGFLrhODsKdItvYx1EJ1BgPtkC7xsfQ8egd6yzE7gaft0nKE9uXVY6V
         rPuswKqSYd2AO6waSr/MdEeFevy+izSt28LFTNJHVmlz6Z0ISM+mVfsBI+k9h+k7IWwM
         airpmluI0qy9owzC3XDytROZTjaHDbKp9MFzoAtap1tUILzI9xX4+8VO/w9pvIf1DfIo
         z47dbW8Vj2bzbXpfo6mvhdb6GaBVG9tVzBJKNET/2N0pBhTDc3USxFrjYXJxdM2gy4p7
         T5kA==
X-Gm-Message-State: AOAM5316TGOFqHgPakUExJQZawnWLTHJnTvDKEFpktZ8kwImFc9oXMEQ
        P8Ut4HgayGLstvoHwvCVDpR8v/NoKTbIhlDXLIc=
X-Google-Smtp-Source: ABdhPJwkeFSv6yrUhKz5v1yYw1QXWd7XVAKmvtXL+ovBCf0hpY/0fVYTwERAyunwFMKlyKLN9NtL2KYqui3dINydBn0=
X-Received: by 2002:a19:8c58:: with SMTP id i24mr16392673lfj.121.1623181893755;
 Tue, 08 Jun 2021 12:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAOWid-drUQKifjPgzQ3MQiKUUrHp5eKOydgSToadW1fNkUME7g@mail.gmail.com>
 <20210604061303.v22is6a7qmlbvkmq@kafai-mbp> <f08f6a20-2cd6-7bf0-c680-52869917d0c7@fb.com>
 <CAOWid-f_UivcZ1zW5qjPJ=0wD1NM+s+S9qT6nZuvtpv0o+NMxw@mail.gmail.com>
In-Reply-To: <CAOWid-f_UivcZ1zW5qjPJ=0wD1NM+s+S9qT6nZuvtpv0o+NMxw@mail.gmail.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Tue, 8 Jun 2021 15:51:22 -0400
Message-ID: <CAOWid-eXi36N7-qPHT0Or9v5OBbhYx6J5rX3uVbVQWJs_90LOg@mail.gmail.com>
Subject: Re: Headers for whitelisted kernel functions available to BPF programs
To:     Yonghong Song <yhs@fb.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 4, 2021 at 4:47 PM Kenny Ho <y2kenny@gmail.com> wrote:
>
> On Fri, Jun 4, 2021 at 12:11 PM Yonghong Song <yhs@fb.com> wrote:
> > On 6/3/21 11:13 PM, Martin KaFai Lau wrote:
> > >
> > > Making the kfunc call whitelist more accessible is useful in general.
> > > The bpf tcp-cc struct_ops is the only prog type supporting kfunc call.
> > > What is your use case to introspect this whitelist?
> >
> > Agree. It would be good if you can share your use case.
>
> At the high level, I am trying to see if we can use bpf in the drm
> subsystem and gpu drivers which are kernel modules.  My initial
> motivation was to use bpf for dynamic/run-time reconfiguration of the
> drm/gpu driver (for experimentation.)  But now that I learned more
> about bpf, I think there are quite a few more things I can do with it.
> (Debugging during GPU hw bring-ups, profiling driver performance in
> live system, etc.)  I have been looking into bpf with kprobe and
> struct_ops.
>
> In terms of kernel module support for bpf/btf, Andrii told me about it
> last year and I see that his feature is in (I was able to do a btf
> dump file for /sys/kernel/btf/amdgpu, /sys/kernel/btf/drm_ttm_helper,
> for example.)  The next thing I thought about was having helper
> functions from kernel modules and Toke pointed me to Martin's patch
> around "unstable helpers"/calling whitelisted kernel functions and
> this is where we are at.

Yonghong and Martin, does the use case make sense?  Or am I trying to
do something stupid?

Kenny
