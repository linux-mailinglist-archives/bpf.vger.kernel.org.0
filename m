Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4087563B9B1
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 07:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiK2GMs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 01:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbiK2GMq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 01:12:46 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D3CBF79
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 22:12:44 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vp12so30019314ejc.8
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 22:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rw2L27fTFv3BJQdmjgGJwuzbAl9kRaNKsjeSn9lWESU=;
        b=Y5YOrxnn2xBGUQhDkTQOTYDLWO7A3Pnq8n8skJShqKLKjQyEvuR8HQ+cI+JZjaW1YF
         ng3d9kSPrShlQnK0N2iYOKPzt/7pcLuexdm7A2EoDd9NZesfXr1tjV7aujoNwAzOlfnD
         MmZFkTE+dnnaKYLZoZmRYxWRFNOKkSqbJoNYPHmqn66mtQOWpRs/ae0dwBG65i3kAR6A
         q9cHbr5TOztNYHREW0Cre4pGzA6DWU+T2uDLxjQPP5++RQWIj4PhHMCHXh1SnuMtxXd8
         aftjLTHAwGC59pf7w49l+OC6TIMJmZzi3HgZXEsHxtAfWqmLdf8WeusYCUwuGG+oPJPV
         tslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rw2L27fTFv3BJQdmjgGJwuzbAl9kRaNKsjeSn9lWESU=;
        b=rUiP/PvuHp/N3gNTcHDVIr4Dq6UCG6ojtNYe2H9Pa/13z00GDifYEcYFwKs3qQJhp6
         UaeB9321Xzd3N0URhmvc5tlnwoyZpOtnQI9Ojwz82z53t9r8xxIu8LED50x5TOPtBs4C
         qebInLt1FuZyGI7BExlm+8NEbedrvkkPLVv9VzqQVIg2ulkxWF8boC5W3ldCwKiawLKU
         6jEgtwTSrr9XmtzUPuoOntrz2kGQY6Hi7W+XbpP7J6mLRK+utN2ZCqgi/k1Qf99LNSbb
         VOWjVO7EmYkULHn6/RMMxsqgV2+2JvtzxnxV39EQyB1Vh8DUoOV/8LVyzGyt/QKKMA0q
         PynA==
X-Gm-Message-State: ANoB5pnCZ/jsTKNVPB6vT5jtbjiokWLj78QW7Iwc39Mt7WXAL4nG9E7W
        Ya5+dNp5ID13cp+XIqp0UdhSg7kZZX6kYGcW4g0=
X-Google-Smtp-Source: AA0mqf5/VC9y5ZecYtjHODK2jl5/+KAWhPRaT5Zg0ZWDJeuCADKGTbd7SHFtrBId1/V4cftuHfqzY4t72RtIOslnhRc=
X-Received: by 2002:a17:906:6403:b0:7b2:9667:241e with SMTP id
 d3-20020a170906640300b007b29667241emr47590413ejm.115.1669702362780; Mon, 28
 Nov 2022 22:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20221126105351.2578782-1-hengqi.chen@gmail.com>
 <20221126105351.2578782-2-hengqi.chen@gmail.com> <CAADnVQJ8B0oDss95P+qfQx7r0Xr8RmY-_9dAincqESzyD+ZG+w@mail.gmail.com>
 <94b5a28c-56dd-74a1-e4f5-5b5c2ffeca2a@gmail.com>
In-Reply-To: <94b5a28c-56dd-74a1-e4f5-5b5c2ffeca2a@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 28 Nov 2022 22:12:31 -0800
Message-ID: <CAEf4BzbcPdkmRieXeym5zJWWMj7PadsX_H1AWvzJzHQbUkejjw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Check timer_off for map_in_map only when map
 value have timer
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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

All the BTF stuff aside, wouldn't this be the best and most minimal
fix? It seems to define correct semantic meaning: no timer is found
(because no BTF in this case). Easy to backport, solves the immediate
problem. This code seems to be completely reworked in bpf-next,
though, so I don't know what the situation is there.

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7b373a5e861f..9e38cc1e136c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1118,7 +1118,7 @@ static int map_create(union bpf_attr *attr)
        spin_lock_init(&map->owner.lock);

        map->spin_lock_off = -EINVAL;
-       map->timer_off = -EINVAL;
+       map->timer_off = -ENOENT;
        if (attr->btf_key_type_id || attr->btf_value_type_id ||
            /* Even the map's value is a kernel's struct,
             * the bpf_prog.o must have BTF to begin with




>
> > The maps as blobs of data should not be used.
> > Much so adding support for mixed use as inner maps.
