Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6636DBB8D
	for <lists+bpf@lfdr.de>; Sat,  8 Apr 2023 16:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDHOXd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Apr 2023 10:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDHOXb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Apr 2023 10:23:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2DCC148
        for <bpf@vger.kernel.org>; Sat,  8 Apr 2023 07:23:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id g18so14309241ejj.5
        for <bpf@vger.kernel.org>; Sat, 08 Apr 2023 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680963809; x=1683555809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/3BCEZA9eTx8N47TMw8V79/mrf/b8ewnS3dR3GQxIQ=;
        b=kN6BndqwsJspxAnHXikxRayITMbmayhXFEmrOhY/sgRFKn85i+GJ40bj+TfdBDwPUU
         1npf4w0nXL6JU1BssCIe9y/6CGuwGasQR1std83FrrdhPLErzLM9Bvs8VK2uYNDsvJuF
         kKo3s1zvOum9pNUDyLZJAdT+EdynBHeDe9qO0jo3N8SVOpFCEvAI5reDRH/pI6BQjD2a
         3C3i3NDiMGFEn+Py/Z2rJLwpFUAC+BlsCzX0Xt6e5uP9bZ9VYWsMBn5WxtUUI0NCResT
         DnYZWTJzK78MTeCEXwysXA8usw+JHPP2mKJnW5zqKxm/2OAJ64jubwD3ar21CMA7kAIN
         zIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680963809; x=1683555809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/3BCEZA9eTx8N47TMw8V79/mrf/b8ewnS3dR3GQxIQ=;
        b=Pi6xZ3bNVy+QgJV03DbnyKWp/6CzYnkVnErZRZ8ktLxw3lhikopKnCORVsNuBHE1dM
         0GsYBUoNZsqrqSzQxM5yHpFS4bHr9TxZil+2KZIZbVwsXsjxTBL8xyfdNchaim0u30XT
         EoaLzNVl6vUxmP/B4bp41soRcktrhmajDBTKbZHoytb0O+B86QQe/XJHGuOGSoR+CUiu
         iEu+jDCaWDjPeco3F0txTW5EgibGI6dnBPHq4I3AitL1cZp7IRndbmf0PNc7W/Wm+zVH
         uXXLm92hW8hCvjx2GrjP2PCCOR7RQu716CBJIkwQHGsc49yvCS33TVItrLaNpprjL/a9
         DljA==
X-Gm-Message-State: AAQBX9cwMG+aJlOQPT3wnp0QIw8MPNQ+F7bflV5uT4tombXDHmzhzHd3
        2SA+0C37GCV8MdVCaRW7Y5TaSP10dFjNHyrXKT5M8dfq
X-Google-Smtp-Source: AKy350YEusPxZWIIRKxqFfcqFUo368VlB8eocEEHdZmEiEenrbWxvSlGiiTiDWX9BwgW/1qCXm86AaSuwg9zSSg0i00=
X-Received: by 2002:a17:907:7f0c:b0:94a:5b44:e645 with SMTP id
 qf12-20020a1709077f0c00b0094a5b44e645mr5585ejc.13.1680963808896; Sat, 08 Apr
 2023 07:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAGQdkDuC9Cu2tvy1nnnaDvEhuE7c68KUUr+t8xi5BzipKis8_g@mail.gmail.com>
 <CAEf4BzZvDfyYQb+h09V-PAgc_5mT-TKVH0uqNiJL6y0eoFcBHQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZvDfyYQb+h09V-PAgc_5mT-TKVH0uqNiJL6y0eoFcBHQ@mail.gmail.com>
From:   andrea terzolo <andreaterzolo3@gmail.com>
Date:   Sat, 8 Apr 2023 16:23:17 +0200
Message-ID: <CAGQdkDs8e0_o0uHpcUF_ZbG=isa_GjJcTr8=Ykwy0jJek=e=4w@mail.gmail.com>
Subject: Re: [QUESTION] BPF trampoline limits
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 5 Apr 2023 at 00:33, Andrii Nakryiko <andrii.nakryiko@gmail.com> wr=
ote:
>
> On Fri, Mar 31, 2023 at 4:32=E2=80=AFAM andrea terzolo <andreaterzolo3@gm=
ail.com> wrote:
> >
> > Hello! If I can I would like to ask one question about the BPF
> > trampoline. Reading the description of this commit [0] I noticed the
> > following statement:
> >
> > - Detach of a BPF program from the trampoline should not fail. To avoid=
 memory
> > allocation in detach path the half of the page is used as a reserve and=
 flipped
> > after each attach/detach. 2k bytes is enough to call 40+ BPF programs d=
irectly
> > which is enough for BPF tracing use cases. This limit can be increased =
in the
> > future.
> >
> > Looking at the kernel code, I found only this limit
> > BPF_MAX_TRAMP_LINKS. If I understood correctly, this limit denies us
> > the use of the same trampoline for more than 38 bpf programs. So my
> > question is, does the commit description refer to another limit or
> > does this "call 40+ BPF programs" refer to the BPF_MAX_TRAMP_LINKS
> > macro?
>
> No, it's BPF_MAX_TRAMP_LINKS, which got reduced a bit down from its
> 40+ limit to current 38.
>
Thank you very much for the quick answer!
> >
> > Thank you in advance for your time,
> > Andrea
> >
> > 0: https://github.com/torvalds/linux/commit/fec56f5890d93fc2ed74166c397=
dc186b1c25951
