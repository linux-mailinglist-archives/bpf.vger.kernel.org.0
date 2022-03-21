Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A324E2E9E
	for <lists+bpf@lfdr.de>; Mon, 21 Mar 2022 17:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351521AbiCUQ7u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348165AbiCUQ7s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 12:59:48 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F715C85E
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 09:58:23 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id c23so17428633ioi.4
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 09:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/wPEbJL6m+uWl+5mudt8nNZ3yd+qwRNRk6wCxn4EEus=;
        b=JDYqPM4Cb+nE7NVZVTvNE80KbDjzND3WBTrQNTMxKn2iFYyUG0nLYcaPgJi5RKY7KC
         CXNMIKQA8++W8eGHC/9fqKJ7oC1yublSUfiMpCCgPqV7K0ZiEn4eCKgoSYFvFUeWMWgr
         /WpiVkL1+AD5q2NOHvq6gG+vw6P2vuU/ldeXSF9NHo3Z7ugGFkF8dQ1E9hf65KfL+ap8
         ox5ub4N3haRs8xOJ8d3suYNBbBTK1GF3TGApMd47YcsxiwwUEjreyMwFv2ZIQoJ2SB3C
         tFklC32r6uKniVQCg4pALgOaJvGYRb9DEaD9k9MmY3tMZ655jtq8N2PJQE4tIL/YoDeM
         3hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wPEbJL6m+uWl+5mudt8nNZ3yd+qwRNRk6wCxn4EEus=;
        b=Ua6blNQLg0QuNX9JvUW9Upep+W3RDHOpskeiL9JmR6PE0O+8yAC3mVpxTo1IanZEmO
         AOnYkwTr7sm6igUEyyyQbi7NMZuFR57l9NSEWes0a/EOMx3S4tP3eFNv/q9d9n/Cvq/v
         k97sY2zdAXmxEXMiHqDGViuzsVtjMwMrKZqmmE0HkLO+3d3MacBcMZHYEqJ/Qambaekb
         odeAfCGsACxvymjCj1cWHdtvWGWS8kAIeNAzPPEkZg88J21QJMzDA+x3FVDXIhAEmRJt
         d3aSaqTCopPPX/fx9yngOCEhiIxD/WlkB+4Yo8vj5z2kGQ6sa/bi78pTbjCDh9gBS01w
         T/Xw==
X-Gm-Message-State: AOAM530u0qoh9tMkoovvnGh/0TDdUUP05DSVcSNq9+/WRDMU9+d7ZcyX
        FM6fnz175QFKK+AGylOV0CVBrL8pqjZNPWh1/bUM+P5u
X-Google-Smtp-Source: ABdhPJy122RFMtFv366bKetvHsG5FQf51Ybyo0rCa9WZXU1am3XTXF99QRhywkDC9tq0bTlF8RaVm9r3Yy15PsFOvHg=
X-Received: by 2002:a05:6638:33a8:b0:319:cb5c:f6d9 with SMTP id
 h40-20020a05663833a800b00319cb5cf6d9mr11214533jav.93.1647881902925; Mon, 21
 Mar 2022 09:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220320001911.3640917-1-andrii@kernel.org> <3f326c74-f86d-abac-998b-427ff9c4bffa@fb.com>
In-Reply-To: <3f326c74-f86d-abac-998b-427ff9c4bffa@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 21 Mar 2022 09:58:11 -0700
Message-ID: <CAEf4BzZuS9P0o7UM=hHuAYmnauVwxb4rXX-VoNGZF_8RMD=FRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: avoid NULL deref when initializing map
 BTF info
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 19, 2022 at 8:37 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 3/19/22 5:19 PM, Andrii Nakryiko wrote:
> > If BPF object doesn't have an BTF info, don't attempt to search for BTF
> > types describing BPF map key or value layout.
> >
> > Fixes: 262cfb74ffda ("libbpf: Init btf_{key,value}_type_id on internal map open")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> So without this patch, we may have segfault or other errors, right?
> It would be good to specify that in the commit message.
>
> The code change looks good to me.
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---
> >   tools/lib/bpf/libbpf.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 7526419e59e0..2efe9431c1ba 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -4197,6 +4197,9 @@ static int bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map *map)
> >       __u32 key_type_id = 0, value_type_id = 0;
> >       int ret;
> >
> > +     if (!obj->btf)
> > +             return -ENOENT;
> > +

yeah, it was SIGSEGV, which I only saw in libbpf CI on old 5.5 kernel.
I'll include a bit more specifics for future fixes, sorry.

> >       /* if it's BTF-defined map, we don't need to search for type IDs.
> >        * For struct_ops map, it does not need btf_key_type_id and
> >        * btf_value_type_id.
