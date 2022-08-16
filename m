Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B79596503
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 23:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiHPV4A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 17:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbiHPV4A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 17:56:00 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517A68670E
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 14:55:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w3so15222077edc.2
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=fXKX027W2rKXVI5yjTLWPgg8XFeY4LZisVfhTYNuKGM=;
        b=pQGbJOWsj/9EOSD9IgtrlqYC16eakLaES7j2gL75t22BK1BApEIKI5LN0bUeTikTAt
         Kk0kaU6Pq6fQYPWjtT6p4VYpN4yFVYVJDMGviRXC3X5irDSHhv/E/mwc5Y4TJNn0JQtm
         CeUqT8Gvg2GqB83EyrbhEeyTozlBmMUu56WyIbOBGAjNaMGMi4mNcP7WfhYAbPKV8CT4
         QetgG9UgsaN2IBVuj8Foz1+iaUbl1+Dp7IwGo4fghBQ7oOY6f9OhaKXAzeYphyAguYh0
         +BkSbyurlgl6CYlOpqX+n/R8CPaDj4Kdg9ZYrsh1CVvk3kUjNN2mr65+WthE6zAZIL4V
         jywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fXKX027W2rKXVI5yjTLWPgg8XFeY4LZisVfhTYNuKGM=;
        b=C75ph2ok1Dx/0NzwtCvk70ByzjhGH8I2CC4yd5pwKtFi2bzKpgXm6YimCqXqJSFhKv
         ft80sT2wEvNSDkFQM1de4s0kJGRqMqKrRgS8MAolo79RdZA3sGw9WNLJtkD6pJkoZXu3
         de+i5Rb1JITZa+OyS8YqXVq6t7a6UOKyjXD8JzKorTL5fzDllryg0YXsVKYhdabZOtlZ
         JX4meHqzHkbrjaEqEMH0X7xN7ZLg5CvWSQJeyTDeksELNjeJDzPFuOCXc52D8lOZx8N5
         ocnq5h7BadyS218L18hVg+esRv5+Hsbp1w+8ZphLMV+/zhYtmoy5yVBpNCrDrNst0aPh
         9AOw==
X-Gm-Message-State: ACgBeo1sExDUr/eFBZsDs892KkfsTWHxJIlgViae33YsGJkubb7pxQnX
        PUXykj/hHH2QPsRBzsBboPBoxdu45wWaPdgfdIZFLSCp
X-Google-Smtp-Source: AA6agR6ogmtDMkUolGsZtiXCPazfkchymuKpwY/IoaFIKBQQi58F5fNeANb8pnaQz80GLoAt9HCL6OEBdFo3e/icX84=
X-Received: by 2002:aa7:de8c:0:b0:440:3516:1813 with SMTP id
 j12-20020aa7de8c000000b0044035161813mr21304021edv.260.1660686957876; Tue, 16
 Aug 2022 14:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220816001929.369487-1-andrii@kernel.org> <20220816001929.369487-4-andrii@kernel.org>
 <CA+khW7h1n1fA53B-2SDc2z-sVOCFVt8f9pBPT1D_sbJ4T63PdQ@mail.gmail.com>
In-Reply-To: <CA+khW7h1n1fA53B-2SDc2z-sVOCFVt8f9pBPT1D_sbJ4T63PdQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Aug 2022 14:55:46 -0700
Message-ID: <CAEf4BzbGLzD3oLGxCOvyRO4HWZf6Oz9-uyCZRTqi6OOcBYdT=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] libbpf: clean up deprecated and legacy aliases
To:     Hao Luo <haoluo@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
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

On Tue, Aug 16, 2022 at 2:34 PM Hao Luo <haoluo@google.com> wrote:
>
> On Mon, Aug 15, 2022 at 9:23 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Remove two missed deprecated APIs that were aliased to new APIs:
> > bpf_object__unload and bpf_prog_attach_xattr.
> >
>
> Three functions? Missing btf__load()?

Apparently I suck at counting, thanks for spotting. It doesn't seem
worth it to send v2 just for this, maybe Alexei or Daniel can fix it
up while applying.

>
> > Also move legacy API libbpf_find_kernel_btf (aliased to
> > btf__load_vmlinux_btf) into libbpf_legacy.h.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> The change itself looks good to me. Verified these functions are no
> longer used in the source file.
>
> Acked-by: Hao Luo <haoluo@google.com>
>
>
> >  tools/lib/bpf/bpf.c           | 5 -----
> >  tools/lib/bpf/btf.c           | 2 --
> >  tools/lib/bpf/btf.h           | 1 -
> >  tools/lib/bpf/libbpf.c        | 2 --
> >  tools/lib/bpf/libbpf_legacy.h | 2 ++
> >  5 files changed, 2 insertions(+), 10 deletions(-)
> >

[...]
