Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CAC443A5A
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 01:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhKCAVS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 20:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbhKCAVR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Nov 2021 20:21:17 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5740AC061714
        for <bpf@vger.kernel.org>; Tue,  2 Nov 2021 17:18:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id r5so1356461pls.1
        for <bpf@vger.kernel.org>; Tue, 02 Nov 2021 17:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDUEIcdOvRAPLieAxDVPZgN+IYQ6GWa/YmuMVIb8ER4=;
        b=ZTHu7vRX8K/yh7cGvV12R0B6HBm46YdBYci2qG745FK2rdAXzMICx/prw0h3qBuXJx
         Wl4l1Bh8Ucqy1agWlZtSBtJXsiuD559sSMxvYWC5geMlTkFi71oDb4zXZ7sZFYZ8bAV8
         6QQdg07QFl3WZky7P2PQb1Euwnwuyc6+r98H8H6XEsaLcw6I3CrndJejMSFSJtetQZER
         iT2KFaH4EqgxZmvy2a0IV6ffrNGrYfzwgGkjFYLmyyvjSVzLVzAR/gLB7pvjZTektn7y
         1La6lhOeAYW2XRxDCakbLKr2vOeCX2kkIT95wr9Ef33faonvvqdT2tDYBiUQaRUYURm1
         n7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDUEIcdOvRAPLieAxDVPZgN+IYQ6GWa/YmuMVIb8ER4=;
        b=3YiBehoEI1Ew4Ce3/ggrH1WbZdm5/vX3owFbjQ0U3geawLTJMIGlClEsqbZpkwTNK4
         8QFSg5mcJ8oe15yGv8OGCWRWZ3mS3S7jYaDoYZvdCwbDzD5k3vYfTMT69Y/QHuVpNPqE
         Wrp7q7V4N4dM7o0XuRQLTlHvo465KOE9zP++jy+8cikjqsTcB54m9/VoofB28TK1aeap
         m6F/GklIc8K3FhfPhGJakAkt36PZ8EphuA0HO7bk/hSm0NaDIfv6WPwkqLnudl8/GtvL
         +nICulgyPRmMZmhPpJCx12+iiblhf04QRkHo0MKXRWAkDcJ+ZkyEGxLUVPW6MTHkXPSN
         +O0w==
X-Gm-Message-State: AOAM533CBSWLDVWBmbyzE3HIsRvoYuR1tkhyCVaS8VRjNp4X2FR/ZE3d
        s+zdzmj3PB7WLuDIgNzesvsDBQInd5qLm5Y95VE=
X-Google-Smtp-Source: ABdhPJx4PpPL5nuNMY2LVzl+6/SB5Eg9uqt+Qv8aNhkvSQs5errr5krTI5AXS4YS7iNvoU/mI2a4+8BSimFuGWrKlS4=
X-Received: by 2002:a17:902:f542:b0:141:fa0e:1590 with SMTP id
 h2-20020a170902f54200b00141fa0e1590mr12118189plf.20.1635898721897; Tue, 02
 Nov 2021 17:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <269c70c6c529a09eb6d6b489eb9bf5e5513c943a.1635196496.git.lorenzo@kernel.org>
 <CAADnVQLG-T-7mLgVY9naMKGog-Qcf3yoZRvZLJqm55iAPhFEhQ@mail.gmail.com> <YYHUabJ5TedbUsd/@lore-desk>
In-Reply-To: <YYHUabJ5TedbUsd/@lore-desk>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 2 Nov 2021 17:18:30 -0700
Message-ID: <CAADnVQKAX-6mFBXWDDjF3Hdi-KbAzhTHtiNa2ePHSTb+3SVGDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: introduce bpf_map_get_xdp_prog utility routine
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 2, 2021 at 5:14 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >
> > 1. it's tweaking __cpu_map_load_bpf_program()
> > to pass extra 'map' argument further into this helper,
> > but the 'map' is unused.
>
> For xdp multi-buff we will need to extend Toke's bpf_prog_map_compatible fix
> running bpf_prog_map_compatible routine for cpumaps and devmaps in
> order to avoid mixing xdp mb and xdp legacy programs in a cpumaps or devmaps.
> For this reason I guess we will need to pass map pointer to
> __cpu_map_load_bpf_program anyway.
> I do not have a strong opinion on it, but the main idea here is just to have a
> common code and avoid adding the same changes to cpumap and devmap.
> Anyway if you prefer to do it separately for cpumap  and devmap I am fine
> with it.

None of that information was in the original commit log.
Please make sure to provide such details in the future and make it
part of the series.
That patch alone is unnecessary.
