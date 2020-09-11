Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE83A2662B5
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 17:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgIKP6I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 11:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgIKP5t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 11:57:49 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8575AC061786
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 08:57:49 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id h1so5425702qvo.9
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 08:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7EL5QIMCol+nNuuhHrYx3NpBAz3xMq+uHFMPEPZUHdY=;
        b=rLp1NySzNWm5L4jWo+hY0vSfl0/xqBuHjKQVwf1WDpdwjdJGu9skxJVSHfNRONDd93
         L5E5R/usjyvzxijBipEXLFNLPt3qmHFasqjd3+Xsn+NIggx/Et6Z1oGCA/hbhTO9YVeL
         +VS0Nv8c5s69q4OTqKMh+hYiQQFY5RkcvplUV5xeL6SlCupRhLqqc+cT/s6U/MLlbLoO
         XbxbDzDGDwiLlOse0Y2lryfCcNSXigxKe3q/bG+tJ7o4fddNC2pV1FMf++YPCGyBywuy
         eTfxn81+HM1asfkTRTxjn2wmjAQrGpJH6KXtFXYjb7k+etQ7fotosxILtlgQwX3ybBcv
         qCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7EL5QIMCol+nNuuhHrYx3NpBAz3xMq+uHFMPEPZUHdY=;
        b=aW6eiTe9Aa1p2Yo9WYPPcxk6D9cn1U3fvMBRaDyF68hiILd0F11Rb+ZygiOgyTbj/k
         jvzpR2gb+K547yUSXD9wQBgvrlp8K8JhaHEJFwVKgNP0s2jSC/am6JV6sVBEmbDzzJjR
         PYZlm3TmTDvCRK3+un6+ggGThALdMuTgXVx07ZAl6RZxwv54rF5YHMB4zMmu8jf/OL2e
         OhePIWMAbhTvx4gmVJr37cnFwCf/sonjm9gtuE6MOLT3uc0EtngxQMdYuQvwcCHLZrnl
         4Z239JNZD6NgL1TP/stfneEBQZ8N9cyJcIWkWOGxgXaxRzEXqZBBUkd7U/NKISc/zH+i
         buTw==
X-Gm-Message-State: AOAM531+IH/GHdBmnLrhi/xP7ra/FMG+25rOuDIJT2BLBlt+AFzq/Js/
        ClpM0G5/yoplf9KbC/Et8KGFKHe8A1qz3nKWeo5YEQ==
X-Google-Smtp-Source: ABdhPJwzpIi715JRPFgu5PGIdnTrR5aO+y3zA2nI0tnr33CzB4RLydg7fngEbyQDu3GTloB40l4orxrYchhLrB3iztA=
X-Received: by 2002:a0c:f48e:: with SMTP id i14mr2598321qvm.5.1599839868533;
 Fri, 11 Sep 2020 08:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200909182406.3147878-1-sdf@google.com> <20200909182406.3147878-6-sdf@google.com>
 <CAEf4BzY7Ca9ZpL3x_EkjxM4tZXtNJV5kV=MPGTbibkv_bSFB9w@mail.gmail.com>
In-Reply-To: <CAEf4BzY7Ca9ZpL3x_EkjxM4tZXtNJV5kV=MPGTbibkv_bSFB9w@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 11 Sep 2020 08:57:37 -0700
Message-ID: <CAKH8qBvikNYe31NdGin=QYEVt=0LhRg6cDX725mL3D0E_3Jt0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/5] selftests/bpf: Test load and dump
 metadata with btftool and skel
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        YiFei Zhu <zhuyifei@google.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 10, 2020 at 12:59 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Sep 9, 2020 at 11:25 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > From: YiFei Zhu <zhuyifei@google.com>
> >
> > This is a simple test to check that loading and dumping metadata
> > in btftool works, whether or not metadata contents are used by the
> > program.
> >
> > A C test is also added to make sure the skeleton code can read the
> > metadata values.
> >
> > Cc: YiFei Zhu <zhuyifei1999@gmail.com>
> > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
>
> It would be good to test that libbpf does bind .rodata even if BPF
> program doesn't use it. So for metadata_unused you can get
> bpf_prog_info and check that it does contain the id of .rodata?
Good idea, will add that.

> > +const char bpf_metadata_a[] SEC(".rodata") = "foo";
> > +const int bpf_metadata_b SEC(".rodata") = 1;
>
> please add volatile to ensure these are not optimized away
Ack, ty!
