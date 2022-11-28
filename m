Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA89639FB7
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 03:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiK1CuA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Nov 2022 21:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiK1Ctz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Nov 2022 21:49:55 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A859AB1C
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 18:49:54 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id i10so22563825ejg.6
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 18:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pVqrpMDTHcro8/WoVy+BLF4z/zIhDj/qqz3TLDOuDPM=;
        b=oV4QfsNWPVnZgf7Yk0MeDi7JNTlE0/3Sh6PE+FLHiVuj44OIyDsu9Zf7WMH8d6WDWT
         aKlqXdrmGvCY4E7XX/N95uxtp3q1sA5QH6ABDfH6wL2vp+XcNgJKcDJwOryX+xFruo/L
         jwpnrPgHodOTRhAJVAr8J4Ruj77IkhCgye6agjQsXNr8ZdU3TFrhh6aF0IYok2Yt6i3r
         9U8rKVGlAOd9ZbSiOeHKaxPPVURE5iQDYFKh+uqrOwnKzsVDTLmGgUa6b3iU0hJQU0N0
         dlP2EtD9bNnZAiE5y3D+ew7eYzS29QDeJzky0LnXdKimwTILuehyqfmo1KTKZrtWdoEz
         DYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVqrpMDTHcro8/WoVy+BLF4z/zIhDj/qqz3TLDOuDPM=;
        b=w6E91e8q0sTpX4gA/LMdAqecWQ1iQjOLizSlbutXdvx1d/haXRK8vbBSUlOXIdwt2B
         8fh3Cl7coZRe9LHWsHAAxtVXOe3EICi0FQGlqcn4uZ4lBzK/Dy0egylNHcTQwLFxqEMB
         k7p2x0ObV+qfXAsahb0yQJRzIyPzBK7GfqdD/29BGoR4LVXeoGXhToaL8f746GmP3ZrW
         ATBgB4+UIT5jWow60GBiD9nryszzww8VK8othRttD4c/s4TOBQ8r+jiSwM7RDFdZH4Km
         OUwslOcZAtpL//8uldMHij/VcInhmcZi5IacQJdIAVsz7wt47LNDzH9npaZyEfy5hgQy
         cxmw==
X-Gm-Message-State: ANoB5pmuOxioL7mzcr5ckFWWtHIgBuLeWuMk+Ls7C7aSku9uGZcrK6Po
        F906Oh+rlsM70bv9EF5NMq1hCOhjhpYkPsFIpOI=
X-Google-Smtp-Source: AA0mqf6O7jT4ZAIsvg1mNzMzUrzq6t2MtCuYyaJEIox+2qPkSlfUaFi5erQR9tRjMNaH/1VvubEQHoMjIwUTWBN5vew=
X-Received: by 2002:a17:906:34d0:b0:78d:c16e:dfc9 with SMTP id
 h16-20020a17090634d000b0078dc16edfc9mr41788430ejb.327.1669603793177; Sun, 27
 Nov 2022 18:49:53 -0800 (PST)
MIME-Version: 1.0
References: <20221126105351.2578782-1-hengqi.chen@gmail.com>
 <20221126105351.2578782-2-hengqi.chen@gmail.com> <CAADnVQJ8B0oDss95P+qfQx7r0Xr8RmY-_9dAincqESzyD+ZG+w@mail.gmail.com>
 <94b5a28c-56dd-74a1-e4f5-5b5c2ffeca2a@gmail.com>
In-Reply-To: <94b5a28c-56dd-74a1-e4f5-5b5c2ffeca2a@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 27 Nov 2022 18:49:41 -0800
Message-ID: <CAADnVQJRjW+nWtj5Kd6pHCyjKkRnjLiMSG22vXBPCp41UbASag@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Check timer_off for map_in_map only when map
 value have timer
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 27, 2022 at 6:42 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Hi, Alexei:
>
> On 2022/11/28 08:44, Alexei Starovoitov wrote:
> > On Sat, Nov 26, 2022 at 2:54 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >>
> >> The timer_off value could be -EINVAL or -ENOENT when map value of
> >> inner map is struct and contains no bpf_timer. The EINVAL case happens
> >> when the map is created without BTF key/value info, map->timer_off
> >> is set to -EINVAL in map_create(). The ENOENT case happens when
> >> the map is created with BTF key/value info (e.g. from BPF skeleton),
> >> map->timer_off is set to -ENOENT as what btf_find_timer() returns.
> >> In bpf_map_meta_equal(), we expect timer_off to be equal even if
> >> map value does not contains bpf_timer. This rejects map_in_map created
> >> with BTF key/value info to be updated using inner map without BTF
> >> key/value info in case inner map value is struct. This commit lifts
> >> such restriction.
> >
> > Sorry, but I prefer to label this issue as 'wont-fix'.
> > Mixing BTF enabled and non-BTF inner maps is a corner case
>
> We do have such usecase. The BPF progs and maps are pinned to bpffs
> using BPF object file. And the map_in_map is updated by some other
> process which don't have access to such BTF info.
>
> > that is not worth fixing.
>
> Is there a way to get this fixed for v5.x series only ?
>
> > At some point we will require all programs and maps to contain BTF.
> > It's necessary for introspection.
>
> We don't care much about BTF for introspection. In production, we always
> have a version field and some reserved fields in the map value for backward
> compatibility. The interpretation of such map values are left to upper layer.

That "interpretation of such map values are left to upper layer"...
is exactly the reason why we will enforce BTF in the future.
Production engineers and people outside of "upper layer" sw team
has to be able to debug maps and progs.
