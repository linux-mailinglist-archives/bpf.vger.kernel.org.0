Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D5563A003
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 04:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiK1DOi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Nov 2022 22:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiK1DOh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Nov 2022 22:14:37 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F2A10554
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 19:14:35 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ud5so22672189ejc.4
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 19:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c5slu4v/r1aKONhhxnSvoJM/3WW84hWinZJmkgmeRq0=;
        b=gTFH5t/9I/a0YDJRGaF0BF0wLFuDNJnf8/H7myWf4iPHeF5RwpbIG2IbO/A5tyP+zu
         lqALWVGicNrZNT1OCWJxqWSK6iJUnbJdTGOnmcg3K6s95pQyUxd4uv2FKdCImfXbcDIR
         RBwGaFbByoUL9PO9gwO8MzzyZc1SOl4DSufISMCXjmZwms5XuJzI648AmlpVG2FuLHUp
         QZyJOA31CwqF+oz6lQCxevJbndPCN1Zn9wubGejDdLQXPYV5lpEpq7iYQUrGIDfvOQLE
         rLyvgzFZjia3aByvmeTy/eokl1wm3Q7yoW+66MRye+0Ml/kF76LAcIRbltUrhcwtq81e
         ewWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5slu4v/r1aKONhhxnSvoJM/3WW84hWinZJmkgmeRq0=;
        b=fmdYtSfmeGLQufPrvLbsMkeFJFGx57xyNy8GpMBwo+a9q7/u30OAJYlGhFO4bAevtw
         Pb4yR6KS/vmBxH+0+XlFtuwPiaEVS4Vc4NvYHgqlgfBkKKNR5lfc6nSFMaS+MjIoVJ6y
         ZkoigEnq4Vmy1oYluq0671VwZkwftffVimQbqq75CdUIDt5HhoS8k5U9plmfQtCdnSD1
         r1WDmRlZ6vujJv2RQl+1wRCnByPNqLh0QQuS2QyHhpfmqDrCLet1xAtm1HYRW9cnxjOB
         Zkq/7kIQpdrCkeTtoqIWTdQFNRsyP6ENPYigDN0MBkQQ/LNhzUFLsb+4KjFlQClJ5XYR
         dHvw==
X-Gm-Message-State: ANoB5pmDqC+sg9D5tuV2SmN9dc3EvCEyLv4IIT21ymPsR/KFzlEcaPz6
        0WDj7tbnHX7bIRpBM5uRzlnov93ZXmRTdaiGbNI=
X-Google-Smtp-Source: AA0mqf4g4acgf/eqlqmPB+A19Ln8pYyeMbVbqgOSuWlboi4Hhk+mX09g7jzFYv3mV7M2gvSA2cMa2YmcKiriKdVA8bM=
X-Received: by 2002:a17:906:cd10:b0:7bc:571f:88be with SMTP id
 oz16-20020a170906cd1000b007bc571f88bemr814846ejb.502.1669605273868; Sun, 27
 Nov 2022 19:14:33 -0800 (PST)
MIME-Version: 1.0
References: <20221126105351.2578782-1-hengqi.chen@gmail.com>
 <20221126105351.2578782-2-hengqi.chen@gmail.com> <CAADnVQJ8B0oDss95P+qfQx7r0Xr8RmY-_9dAincqESzyD+ZG+w@mail.gmail.com>
 <94b5a28c-56dd-74a1-e4f5-5b5c2ffeca2a@gmail.com> <CAADnVQJRjW+nWtj5Kd6pHCyjKkRnjLiMSG22vXBPCp41UbASag@mail.gmail.com>
 <f6d20c9c-a411-92aa-798a-27e1bc341b1a@gmail.com>
In-Reply-To: <f6d20c9c-a411-92aa-798a-27e1bc341b1a@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 27 Nov 2022 19:14:22 -0800
Message-ID: <CAADnVQJp-GHNCbGCJENZvnA70Hwy=-5OUHTQxx+iEK5D=hDmsQ@mail.gmail.com>
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

On Sun, Nov 27, 2022 at 7:07 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
>
>
> On 2022/11/28 10:49, Alexei Starovoitov wrote:
> > On Sun, Nov 27, 2022 at 6:42 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >>
> >> Hi, Alexei:
> >>
> >> On 2022/11/28 08:44, Alexei Starovoitov wrote:
> >>> On Sat, Nov 26, 2022 at 2:54 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >>>>
> >>>> The timer_off value could be -EINVAL or -ENOENT when map value of
> >>>> inner map is struct and contains no bpf_timer. The EINVAL case happens
> >>>> when the map is created without BTF key/value info, map->timer_off
> >>>> is set to -EINVAL in map_create(). The ENOENT case happens when
> >>>> the map is created with BTF key/value info (e.g. from BPF skeleton),
> >>>> map->timer_off is set to -ENOENT as what btf_find_timer() returns.
> >>>> In bpf_map_meta_equal(), we expect timer_off to be equal even if
> >>>> map value does not contains bpf_timer. This rejects map_in_map created
> >>>> with BTF key/value info to be updated using inner map without BTF
> >>>> key/value info in case inner map value is struct. This commit lifts
> >>>> such restriction.
> >>>
> >>> Sorry, but I prefer to label this issue as 'wont-fix'.
> >>> Mixing BTF enabled and non-BTF inner maps is a corner case
> >>
> >> We do have such usecase. The BPF progs and maps are pinned to bpffs
> >> using BPF object file. And the map_in_map is updated by some other
> >> process which don't have access to such BTF info.
> >>
> >>> that is not worth fixing.
> >>
> >> Is there a way to get this fixed for v5.x series only ?
> >>
> >>> At some point we will require all programs and maps to contain BTF.
> >>> It's necessary for introspection.
> >>
> >> We don't care much about BTF for introspection. In production, we always
> >> have a version field and some reserved fields in the map value for backward
> >> compatibility. The interpretation of such map values are left to upper layer.
> >
> > That "interpretation of such map values are left to upper layer"...
> > is exactly the reason why we will enforce BTF in the future.
> > Production engineers and people outside of "upper layer" sw team
> > has to be able to debug maps and progs.
>
> Fine.
>
> In libbpf, we have:
>
>   if (is_inner) {
>         pr_warn("map '%s': inner def can't be pinned.\n", map_name);
>         return -EINVAL;
>   }
>
>
> Can we lift this restriction so that we can have an easy way to access BTF info
> via pinned map ?

Probably. Note that __uint(pinning, LIBBPF_PIN_BY_NAME)
is the only mode libbpf understands. It's simplistic.
but why do you want to use that mode?
Just pin it directly with bpf_map__pin() ?
Or even more low level bpf_obj_pin() ?
