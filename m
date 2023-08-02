Return-Path: <bpf+bounces-6726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F2D76D30D
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 17:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4801C212D0
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 15:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF09D308;
	Wed,  2 Aug 2023 15:55:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79FD505
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 15:55:47 +0000 (UTC)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCE32D78
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 08:55:38 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-447762a1be6so416685137.1
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 08:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690991738; x=1691596538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wy7gA3f8tSty9rabtDHKjMdRr3IA4wpn79L1F8L4sQI=;
        b=Ij02ILf2HfIwI8IR3X4pUC3pOQs/sVaMb2oSPVep0MTYlCLL4qEs/YcG6fArf5wni2
         phVEnXP5Ubvkbu6TgDO6rV834TN+Ew05pZbCC0gDFxdgNtlrDY1o64nZvns3AesZxEaJ
         t+HA3dR6abqWNeytM1doeTde/hZpRUnKjouZYErXXH63tdNLAFtGQBtWyibMSAygyk42
         uSqAJwSlpjbVSLeJtZnLpiGtOeUkeL1aka0Vl5rxdhk3IwurcCeujvjbYZuZDXL9pHhs
         evcHIzhbDGi1JyNL4pWdQUX2yviGOVNKOeiJ4SUIyojH8kc/TI0OWi4dA6sveNP14Uiu
         oyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690991738; x=1691596538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wy7gA3f8tSty9rabtDHKjMdRr3IA4wpn79L1F8L4sQI=;
        b=eKQGwTBIM2RIvY/57NlVX+D0oHlwkEvB58nS8RacUVow80gyq7fbY2uQrV3PkejT0o
         2J8GpaNdH2yyEKk7Dh09UjA1hB8nVbcO+xfA7I0etgGPgthiMbEHJsmV65SbbCTyN5q5
         goqp9lyIWjPuZtoEoNYDeaRPKKupy99FDEvmYSKh9hraJRMOCDs8zNyjDbBwAXlYdEG+
         lR/je3iZHhYGRVdy1vNTT9qDqzyTfNvXvFqGGynR6GkMdGnlwmyTAQQEVNrVq1DGJj9B
         MlkrPkqLWbDLjkgwHf2TswDp160VhcCX9fkdrc6F15L7krrf2oHVkIpxE4ptdHv5Vbqm
         WgFA==
X-Gm-Message-State: ABy/qLao7dJe3qoNjLf2ZZrzav1l7a3eBsgQVSYysL8PYfCBgD5AxEXr
	wFWldO/TscxlcORQAYV4qpn5tgmYAN1yDAwGv6E=
X-Google-Smtp-Source: APBJJlGXL2LgO6xBUD0gr5uYtEv8b1k2uBvruqoIeblVkEM0tCXaH3pjHB6ckrgsxPp1RoCLmwTomuPV737bqAB+bTU=
X-Received: by 2002:a05:6102:374b:b0:445:b56:2f3d with SMTP id
 u11-20020a056102374b00b004450b562f3dmr5916244vst.3.1690991737833; Wed, 02 Aug
 2023 08:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJVhQqW6nvWFozMOVQ=_sUTRwVjsQL+G2yCyd91c0bjsc7PcGA@mail.gmail.com>
 <2e44382b-13a0-5346-c914-be0ae0c7edcd@linux.dev>
In-Reply-To: <2e44382b-13a0-5346-c914-be0ae0c7edcd@linux.dev>
From: Sergey Kacheev <s.kacheev@gmail.com>
Date: Wed, 2 Aug 2023 18:55:26 +0300
Message-ID: <CAJVhQqXQfcO8Y_uZK-9ShEjQp9RTEZtHndHBoWdeb_d9qLBzrg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: Use local includes inside the library
To: yonghong.song@linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In our monrepo, we try to minimize special processing when importing
(aka vendor) third-party source code. Ideally, we try to import
directly from the repositories with the code without changing it, we
try to stick to the source code dependency instead of the artifact
dependency. In the current situation, a patch has to be made for
libbpf to fix the includes in bpf headers so that they work directly
from libbpf/src.
I made this patch only because I believe that it will not harm the
quality of the library code in any way and will not break current
users, if this is not the case, please tell me what I'm missing and
what can break?

Thanks!

On Wed, Aug 2, 2023 at 5:44=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 8/2/23 1:05 AM, Sergey Kacheev wrote:
> > This patch makes it possible to import the header files of the bpf
> > part directly from the source tree.
>
> Could you describe more about your workflow why this patch
> is necessary? I would like to understand whether this is a bug
> fix for your workflow or something else.
>
> >
> > Signed-off-by: Sergey Kacheev <s.kacheev@gmail.com>
> > ---
> > Changes from v1:
> > - Replaced the patch for github/libpf with a patch for bpf-next Linux
> > source tree
> > Reference:
> > - v1: https://lore.kernel.org/bpf/CAJVhQqXomJeO_23DqNWO9KUU-+pwVFoae0Xj=
=3D8uH2V=3DN0mOUSg@mail.gmail.com/
> > ---
> >   tools/lib/bpf/bpf_tracing.h | 2 +-
> >   tools/lib/bpf/usdt.bpf.h    | 4 ++--
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> > index be076a404..3803479db 100644
> > --- a/tools/lib/bpf/bpf_tracing.h
> > +++ b/tools/lib/bpf/bpf_tracing.h
> > @@ -2,7 +2,7 @@
> >   #ifndef __BPF_TRACING_H__
> >   #define __BPF_TRACING_H__
> >
> > -#include <bpf/bpf_helpers.h>
> > +#include "bpf_helpers.h"
> >
> >   /* Scan the ARCH passed in from ARCH env variable (see Makefile) */
> >   #if defined(__TARGET_ARCH_x86)
> > diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> > index 0bd4c135a..f6763300b 100644
> > --- a/tools/lib/bpf/usdt.bpf.h
> > +++ b/tools/lib/bpf/usdt.bpf.h
> > @@ -4,8 +4,8 @@
> >   #define __USDT_BPF_H__
> >
> >   #include <linux/errno.h>
> > -#include <bpf/bpf_helpers.h>
> > -#include <bpf/bpf_tracing.h>
> > +#include "bpf_helpers.h"
> > +#include "bpf_tracing.h"
> >
> >   /* Below types and maps are internal implementation details of libbpf=
's USDT
> >    * support and are subjects to change. Also, bpf_usdt_xxx() API helpe=
rs should
> > --
> > 2.39.2
> >

