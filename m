Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA496F1C38
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 18:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjD1QGE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 12:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjD1QGC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 12:06:02 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D442709
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 09:06:00 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b8f51500a82so14867307276.2
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1682697960; x=1685289960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5lwLxqW5VKmY2A43cr9IwcGLbMR5CgyRtASHDDCzvw=;
        b=Kgk4Eae1aP7UAuXMG2GCAySB2r0ZPNhQeU0yBcvJXJ6/0PIs4s7Ld+qmjhc7YMDJK8
         3CHZHe+bkXTnnwKbXaypBSa9guGEx3TJDS/789EPghQfEh2m3QBTGkLfeX9kYi8F6i9i
         YkrJ8FfhMdQbI0+Z1N3DpVbQ/F0NpEgDwHZcaFwC7KEEbTIKjW2hiUGxXwD/4ydBuAC6
         A55pwq8Txjyp/zqzRvmxQpvZb3mWtxi2BlSAgQTmHbdrD0rqISv9QNCKGLB83iOOjzsw
         /4GiOStfqQptBAeQmBGlX493AGsDpxdF2NASt1uCp/5ZLIJDbqt3D7sqalAc0gop2J75
         wtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682697960; x=1685289960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5lwLxqW5VKmY2A43cr9IwcGLbMR5CgyRtASHDDCzvw=;
        b=c4oMMvPX5dyAUwymS5r49JUNK+RvnvI8neIYpLmwL7Zma4as7xMlL9G8lvR3jZ8VFI
         MSA9Y3j0O0+sju44lItOn7Z6q3IxRcbzLtWRsX/hpntDyAmXvr+5SPRtS6VufnT/LYsB
         wJTZlHqlRV2wCMT9WGsDewIM8tpfmfIhvsgvjqBdCFp6Ybwu+/pXzJSydq15tGeA0L+x
         S8IwsqEcFq0qxg4EY+EqF/P7yl7h6ezzpgmEhdupx3AG1XBzUV/UWkuhAj/fp4lNvVOZ
         n7Lku1M1WBPwRB41sYgEOD+sRixPaRFje9fnwN3UWLycDaSSdp9FT1Kt3/To/6/AUZRY
         Jf8g==
X-Gm-Message-State: AC+VfDwDOqCejx/X0A8mcNg9U9lvnrrfapTVXo77zAzTGUJsgk/RLz6t
        Pr+/W6s6RLZ1vttevjRg0kYe+fxF8bxhSHzpJGh6
X-Google-Smtp-Source: ACHHUZ6FGZWVLRbJ0Vtr4MD2R/979p76yJnZwYUUc8G4bL5ujRwJBt2UCfCS3wLLk3W8UDR0BgoH5jCuz8afYiz+U5A=
X-Received: by 2002:a25:34c7:0:b0:b8e:e918:33ac with SMTP id
 b190-20020a2534c7000000b00b8ee91833acmr4602032yba.1.1682697959947; Fri, 28
 Apr 2023 09:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230428030916.2966-1-rdunlap@infradead.org> <CAHC9VhQoa5yw2e1jiN844pxNXXT+CosJn9ip7ysFnsnUbQUi2Q@mail.gmail.com>
 <7a8df04e-ee81-8b4a-152f-1588b8d6cb42@infradead.org>
In-Reply-To: <7a8df04e-ee81-8b4a-152f-1588b8d6cb42@infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Apr 2023 12:05:49 -0400
Message-ID: <CAHC9VhS0KjFRjamDZsUCZHDRk1bg08JH0iFJi9SN3ZqMOg2+xQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: move hook comments docs to security/security.c
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 28, 2023 at 10:46=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
> On 4/28/23 07:43, Paul Moore wrote:
> > On Thu, Apr 27, 2023 at 11:09=E2=80=AFPM Randy Dunlap <rdunlap@infradea=
d.org> wrote:
> >>
> >> Fix one kernel-doc warning, but invesigating that led to other
> >> kernel-doc movement (lsm_hooks.h to security.c) that needs to be
> >> fixed also.
> >>
> >> include/linux/lsm_hooks.h:1: warning: no structured comments found
> >>
> >> Fixes: e261301c851a ("lsm: move the remaining LSM hook comments to sec=
urity/security.c")
> >> Fixes: 1cd2aca64a5d ("lsm: move the io_uring hook comments to security=
/security.c")
> >> Fixes: 452b670c7222 ("lsm: move the perf hook comments to security/sec=
urity.c")
> >> Fixes: 55e853201a9e ("lsm: move the bpf hook comments to security/secu=
rity.c")
> >> Fixes: b14faf9c94a6 ("lsm: move the audit hook comments to security/se=
curity.c")
> >> Fixes: 1427ddbe5cc1 ("lsm: move the binder hook comments to security/s=
ecurity.c")
> >> Fixes: 43fad2821876 ("lsm: move the sysv hook comments to security/sec=
urity.c")
> >> Fixes: ecc419a44535 ("lsm: move the key hook comments to security/secu=
rity.c")
> >> Fixes: 742b99456e86 ("lsm: move the xfrm hook comments to security/sec=
urity.c")
> >> Fixes: ac318aed5498 ("lsm: move the Infiniband hook comments to securi=
ty/security.c")
> >> Fixes: 4a49f592e931 ("lsm: move the SCTP hook comments to security/sec=
urity.c")
> >> Fixes: 6b6bbe8c02a1 ("lsm: move the socket hook comments to security/s=
ecurity.c")
> >> Fixes: 2c2442fd46cd ("lsm: move the AF_UNIX hook comments to security/=
security.c")
> >> Fixes: 2bcf51bf2f03 ("lsm: move the netlink hook comments to security/=
security.c")
> >> Fixes: 130c53bfee4b ("lsm: move the task hook comments to security/sec=
urity.c")
> >> Fixes: a0fd6480de48 ("lsm: move the file hook comments to security/sec=
urity.c")
> >> Fixes: 9348944b775d ("lsm: move the kernfs hook comments to security/s=
ecurity.c")
> >> Fixes: 916e32584dfa ("lsm: move the inode hook comments to security/se=
curity.c")
> >> Fixes: 08526a902cc4 ("lsm: move the filesystem hook comments to securi=
ty/security.c")
> >> Fixes: 36819f185590 ("lsm: move the fs_context hook comments to securi=
ty/security.c")
> >> Fixes: 1661372c912d ("lsm: move the program execution hook comments to=
 security/security.c")
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Paul Moore <paul@paul-moore.com>
> >> Cc: James Morris <jmorris@namei.org>
> >> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> >> Cc: linux-security-module@vger.kernel.org
> >> Cc: Jonathan Corbet <corbet@lwn.net>
> >> Cc: linux-doc@vger.kernel.org
> >> Cc: KP Singh <kpsingh@kernel.org>
> >> Cc: bpf@vger.kernel.org
> >> ---
> >>  Documentation/bpf/prog_lsm.rst             |    2 +-
> >>  Documentation/security/lsm-development.rst |    6 +++---
> >>  Documentation/security/lsm.rst             |    2 +-
> >>  3 files changed, 5 insertions(+), 5 deletions(-)
> >
> > Thanks Randy.  Did you want to take this via the doc tree, or would
> > you prefer if I pulled this into the LSM tree?
>
> I think that the LSM tree would be appropriate for it.

Fair enough, I just merged this into the lsm/stable-6.4 branch and
I'll send this up to Linus shortly.

--=20
paul-moore.com
