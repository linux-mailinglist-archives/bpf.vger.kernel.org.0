Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33F65F144C
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 23:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiI3VDV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 17:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiI3VDU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 17:03:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEA61739EA
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 14:03:19 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lh5so11430094ejb.10
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 14:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rw+PPnX3kXcvVuPklHlAl/N8VVs81TWXBbenWxcvC44=;
        b=gcduFyyOQ3xvSCIg0hOx2/UwCqOvssovZWPU9oklRg1TYAgqXbUV/gTYRRztc5Qaao
         GGl+4LYyZVbnMGyxcVMM5mVaj/vsiwaW5rQ436H/41MfCalLl0hr4e+jJhtExi9xUjIu
         T9UH2BSLMgV14ygqnrcctowoXKJhEeVqj21iNknQpHF8zOMZHXatufyNZzGni4ovmT7h
         /Sw0RP8BBKIEbEfsnWnaKWdD6BSAsrzGi/zGTnIMo/+veE+8ZeIc1tX1pRBAtEyWNzrb
         4BucvXG64gWCtvkU4aOjB5b0fy2Bjcrxl+MPfO9MtMeLY0Dyz0xg9oNe+sWTBDtBySlu
         uAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rw+PPnX3kXcvVuPklHlAl/N8VVs81TWXBbenWxcvC44=;
        b=gnTGb8lbBe2aV02S0qAFAuiFzXaPGPB2wo3T7D9rJBUk2mIiloyD4YjAYx/OrRvYwB
         XZdQSzoKj0izvXrmBSFeDcsl4kmIm+VT1fISzdoh655e0S0McmdKb1nNVyLFr8IYi7QZ
         wbZzpkxLVpC5bqJuG4/WH+bUEseNbYzT6ziAydu3yascdjeTqJ3UJXgjP1Apgd0XWKLq
         C4plXR77P43j6OSnn2VGApxuCWOX1e/lWBQCd+tN1xerB/dlfIXyw+7Adx93fUpftYzK
         DyZrX57yh/yVpyXyso7CPkACqBYlmRSs5BI7yCCW5pkCJ/4hK8w73lfpNUtRyAs7zTyL
         jdUQ==
X-Gm-Message-State: ACrzQf10OzFc9QBSAqn6qbJ8l66eMM/F/7USlPhO0jnU+h4+UxCUK9Wx
        2BiwVyS2YDk9ZlnolPWxV858ZEL1Bs8PKk0MRAk=
X-Google-Smtp-Source: AMsMyM58qUMexAcDLIrfP+AlR+X2ESe4/PPx+HMS1L6sh8kfJr0RoerudW/N59XjRniPx24m5YB6sjN3LI4j9jf2Zio=
X-Received: by 2002:a17:907:2bd8:b0:770:77f2:b7af with SMTP id
 gv24-20020a1709072bd800b0077077f2b7afmr7643165ejc.545.1664571797574; Fri, 30
 Sep 2022 14:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220927182345.149171-1-pnaduthota@google.com>
 <20220927182345.149171-2-pnaduthota@google.com> <d6f272a6-020e-6a46-d86a-72c2dcc15264@linux.dev>
In-Reply-To: <d6f272a6-020e-6a46-d86a-72c2dcc15264@linux.dev>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Sep 2022 14:03:05 -0700
Message-ID: <CAEf4BzZC553QJNVuTxLGWDcvoo8y5iwqXrjdjG2R-OTo+QWddA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] Ignore RDONLY_PROG for devmaps in libbpf to allow
 re-loading of pinned devmaps
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Pramukh Naduthota <pnaduthota@google.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf <bpf@vger.kernel.org>
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

On Tue, Sep 27, 2022 at 5:40 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 9/27/22 11:23 AM, Pramukh Naduthota wrote:
> > Ignore BPF_F_RDONLY_PROG when checking for compatibility for devmaps. The
> > kernel adds the flag to all devmap creates, and this breaks pinning
> > behavior, as libbpf will then check the actual vs user supplied flags and
> > see this difference. Work around this by adding RDONLY_PROG to the
> > users's flags when testing against the pinned map
> >
> > Fixes: 57a00f41644f ("libbpf: Add auto-pinning of maps when loading BPF objects")
> > Signed-off-by: Pramukh Naduthota <pnaduthota@google.com>
> > ---
> >   tools/lib/bpf/libbpf.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 50d41815f4..a3dae26d82 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -4818,6 +4818,7 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
> >       char msg[STRERR_BUFSIZE];
> >       __u32 map_info_len;
> >       int err;
> > +     unsigned int effective_flags = map->def.map_flags;
> >
> >       map_info_len = sizeof(map_info);
> >
> > @@ -4830,11 +4831,16 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
> >               return false;
> >       }
> >
> > +     /* The kernel adds RDONLY_PROG to devmaps */
> > +     if (map->def.type == BPF_MAP_TYPE_DEVMAP ||
> > +         map->def.type == BPF_MAP_TYPE_DEVMAP_HASH)
> > +             effective_flags |= BPF_F_RDONLY_PROG;
>
> May be set BPF_F_RDONLY_PROG in effective_flags only when map->def.map_flags
> does not have both BPF_F_RDONLY_PROG and BPF_F_WRONLY_PROG set?  Just in case
> the devmap may support setting them during map creation in the future.
>

Would it be sane to just ignore
BPF_F_RDONLY|BPF_F_WRONLY|BPF_F_RDONLY_PROG|BPF_F_WRONLY_PROG flags
during this comparison? Those flags don't really change compatibility
of two maps in terms of their definition, right? Just that for some
combination of those flags BPF program load might fail (e.g., if it is
trying to modify BPF_F_RDONLY_PROG map). But that will be pretty
obvious from BPF the verifier log?


> > +
> >       return (map_info.type == map->def.type &&
> >               map_info.key_size == map->def.key_size &&
> >               map_info.value_size == map->def.value_size &&
> >               map_info.max_entries == map->def.max_entries &&
> > -             map_info.map_flags == map->def.map_flags &&
> > +             map_info.map_flags == effective_flags &&
> >               map_info.map_extra == map->map_extra);
> >   }
> >
>
