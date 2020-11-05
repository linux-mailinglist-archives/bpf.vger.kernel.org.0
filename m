Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D707F2A82F6
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 17:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgKEQE0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 11:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgKEQEZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 11:04:25 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DA8C0613CF
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 08:04:25 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id s14so1596126qkg.11
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 08:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tURLqj53bgxTZF38AE1KHeiSZCcGjzikfA/Ky/suCM=;
        b=EOjUmvVrxNsz5p6GVtZkhwOFEey0SrM9+/KmskwoTmlzcdTx9KzaS8jzsGajBvjYJG
         qpNWRkoQJECFyrfbs7J7iCKyiCrvZ9TJGlvZjXFBkihzDefwzX4o5mhKH9uB+JZv2VNZ
         GAYoJrzIxFGtRsiAhPjcsBoRy6mwJIHK7wvHoJ8HSe2fapbiu2xPbou+PNRcAXe3vx8R
         dMBUd2pd1fE5j8lzu4vnVXm7MZF/bgEmAkYqyKGxAQzGXp8Ln5cTfgV2Ifo9BtTQ09yy
         IND4bxdBqtP96tG3ikp0WOAABs1NgrQenSdCYUwabuTk9zpi1Yb9msEcKFwW7IV+U6aV
         qwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tURLqj53bgxTZF38AE1KHeiSZCcGjzikfA/Ky/suCM=;
        b=aqc59UYHVTkYhj3v8At0/SKGIv47m8YsK6JwTrPB6Cz19p977PV5vkaFt46gB/ZCnm
         KhkEL98em+u63Pl2rCtX9NNq6pa6UV6YtJtp8Pid1pd1oZEowF+vJ/CLrUDNPlJzqqLj
         aECv+QRz2ZIXBM2uJe1jlOGy0uwh3IJrTC/cXHWzT072S6+EpcaLWe/xBBEx6xt0xo8s
         CnFOFQ2lLc5XZvb2dhyuUTqA61iiyP4JxNET7pV+PqwhkXGgPZVpIq5Ylqh6Oz9pBmiC
         bFnh7ICBbD9+tdLz79uElnKSOBay1wcZ5AkhXmxVoIlqkpq5nER5oKbHA7RVAbrxBqec
         6dBQ==
X-Gm-Message-State: AOAM531gfmjnqK3JWhA3Zb6m3jZAuU9IFIDFw0FkPH9zocyDBnzdcF1g
        JKRvwfoLVEeQCOFFnwDbM1isJ+r0b1bdUPDKbAbEdA==
X-Google-Smtp-Source: ABdhPJyCifz3T1j3BRtl2nukRNSIx99Vhc4Zh8PrGcmWxY9uXOS8gyA/2vG7tOtX5fB67FH97jWNFUWwcLOg/Sx7Jl8=
X-Received: by 2002:a37:4d11:: with SMTP id a17mr2610960qkb.448.1604592264434;
 Thu, 05 Nov 2020 08:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20200629095630.7933-1-lmb@cloudflare.com> <20200629095630.7933-2-lmb@cloudflare.com>
 <20201104190808.417b9a4b@redhat.com> <CACAyw98rvXpcdQBE_XzFR0Y0s=rgtum-D0dcyE3DSZXUL-im=Q@mail.gmail.com>
 <20201105120821.07d8ee8c@redhat.com>
In-Reply-To: <20201105120821.07d8ee8c@redhat.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 5 Nov 2020 08:04:13 -0800
Message-ID: <CAKH8qBuvN28371CAdOq8mUik+Ds=qPW+TWRAMXYbNWVvU_Nc6g@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/6] bpf: flow_dissector: check value of unused
 flags to BPF_PROG_ATTACH
To:     Jiri Benc <jbenc@redhat.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 5, 2020 at 3:08 AM Jiri Benc <jbenc@redhat.com> wrote:
>
> On Thu, 5 Nov 2020 11:00:45 +0000, Lorenz Bauer wrote:
> > I had a cursory look at bpftool packaging in Debian, Ubuntu and
> > Fedora, it seems they all package bpftool in a kernel version
> > dependent package. So the most straightforward fix is probably to
> > change bpftool to use *mapfd = 0 and then land that via the bpf tree.
> >
> > What do you think?
>
> Apparently nobody is using bpftool for this (otherwise someone would
> notice), so I'd say go ahead.
Might be a good time to switch selftests to use bpftool to attach the
flow dissector.
I think right now we have a custom binary to do it (mainly because
bpftool wasn't available in the selftests when the flow dissector was
added).
