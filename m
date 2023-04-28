Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB696F1AAA
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 16:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345847AbjD1Onw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 10:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345616AbjD1Onw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 10:43:52 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E3926A5
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 07:43:50 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54fb9b1a421so80944847b3.1
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1682693030; x=1685285030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENY4FP1NqCXozMR3NGmRVnsIVYYqkrTXbZLhDqjIH9U=;
        b=BUX2oPD1DAJUi92Gw0HP/uZjQmQQJmuVAw3YE4wWmEIxvQVRM0VgB5ydbi1KrO+1N7
         kd31GUw8NSJWm+eyF4CjGTBca786e4SFPdeVfC/WvQjvXO0YEAyNTsboDc5BGA01TH0o
         Ai/64JfopJNcphbmJ1ncSJo22IrvWjiToyqq51fiBIbZl1/VbaZh9pu/JdQQCPJGD67v
         qd2zLf2j4XT4nby/ArIqLu5O7zxXrwMAXkTdfEtO/C/BXJChOrA6iftl6QhYavvpHguj
         W6A/I22+ybtPp5ouI+2ysRxf/Mepei3hdGIsrL4ZM1uyTKCsXgjtS2vH0lsvgBCt+iVh
         w9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682693030; x=1685285030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENY4FP1NqCXozMR3NGmRVnsIVYYqkrTXbZLhDqjIH9U=;
        b=HORrUgZBi2pZPbpZ29F0XHnnvSe4Zr2KopH/eTd5mmk0pRcPK/yoR8m1ZMGmjPaLlf
         KYqEVFC9b1zLhgdST9FxXNxccjEtkqOcarg9uauV7DAtyCR7xezpH9Ins3NZ1NVL26e2
         sh8HTpEKhhdf8YHvzwO5LF8NIIu87mflRf10nKS1W0H499Q/wc2LyNFC7GhaBKCW15rn
         EoEa49ign9OLRbQj04Q0LsGAxHRhojTFhz+bW9mgBZTEeFhhlFh/XpZW3sqdspeweNhp
         S68iBXGNpaTtJGMDvdlYRv4lWbpew0UxzyHdhHmvDaIeKCQARoG6HUzHCcgHGqvTigsF
         BDLA==
X-Gm-Message-State: AC+VfDzztqtAwfZbJXRNsfL9htz+UvmW2+E9hXOwbCB2rbXzmdmpaqTT
        5zrvviigUz8nNcsVxSA1X4eIl6BcF06HVV2uV18Q
X-Google-Smtp-Source: ACHHUZ5nGGXZLBgK3Mv6Fgxuoin7FjVgfDs4dvEZYUJUffdOyZPqoBviwFPv23h1xj96UnnWXRz0l6ajrzD2puwsPI8=
X-Received: by 2002:a0d:e28b:0:b0:533:1853:9a1f with SMTP id
 l133-20020a0de28b000000b0053318539a1fmr4032243ywe.39.1682693029791; Fri, 28
 Apr 2023 07:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230428030916.2966-1-rdunlap@infradead.org>
In-Reply-To: <20230428030916.2966-1-rdunlap@infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Apr 2023 10:43:39 -0400
Message-ID: <CAHC9VhQoa5yw2e1jiN844pxNXXT+CosJn9ip7ysFnsnUbQUi2Q@mail.gmail.com>
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

On Thu, Apr 27, 2023 at 11:09=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Fix one kernel-doc warning, but invesigating that led to other
> kernel-doc movement (lsm_hooks.h to security.c) that needs to be
> fixed also.
>
> include/linux/lsm_hooks.h:1: warning: no structured comments found
>
> Fixes: e261301c851a ("lsm: move the remaining LSM hook comments to securi=
ty/security.c")
> Fixes: 1cd2aca64a5d ("lsm: move the io_uring hook comments to security/se=
curity.c")
> Fixes: 452b670c7222 ("lsm: move the perf hook comments to security/securi=
ty.c")
> Fixes: 55e853201a9e ("lsm: move the bpf hook comments to security/securit=
y.c")
> Fixes: b14faf9c94a6 ("lsm: move the audit hook comments to security/secur=
ity.c")
> Fixes: 1427ddbe5cc1 ("lsm: move the binder hook comments to security/secu=
rity.c")
> Fixes: 43fad2821876 ("lsm: move the sysv hook comments to security/securi=
ty.c")
> Fixes: ecc419a44535 ("lsm: move the key hook comments to security/securit=
y.c")
> Fixes: 742b99456e86 ("lsm: move the xfrm hook comments to security/securi=
ty.c")
> Fixes: ac318aed5498 ("lsm: move the Infiniband hook comments to security/=
security.c")
> Fixes: 4a49f592e931 ("lsm: move the SCTP hook comments to security/securi=
ty.c")
> Fixes: 6b6bbe8c02a1 ("lsm: move the socket hook comments to security/secu=
rity.c")
> Fixes: 2c2442fd46cd ("lsm: move the AF_UNIX hook comments to security/sec=
urity.c")
> Fixes: 2bcf51bf2f03 ("lsm: move the netlink hook comments to security/sec=
urity.c")
> Fixes: 130c53bfee4b ("lsm: move the task hook comments to security/securi=
ty.c")
> Fixes: a0fd6480de48 ("lsm: move the file hook comments to security/securi=
ty.c")
> Fixes: 9348944b775d ("lsm: move the kernfs hook comments to security/secu=
rity.c")
> Fixes: 916e32584dfa ("lsm: move the inode hook comments to security/secur=
ity.c")
> Fixes: 08526a902cc4 ("lsm: move the filesystem hook comments to security/=
security.c")
> Fixes: 36819f185590 ("lsm: move the fs_context hook comments to security/=
security.c")
> Fixes: 1661372c912d ("lsm: move the program execution hook comments to se=
curity/security.c")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: bpf@vger.kernel.org
> ---
>  Documentation/bpf/prog_lsm.rst             |    2 +-
>  Documentation/security/lsm-development.rst |    6 +++---
>  Documentation/security/lsm.rst             |    2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Thanks Randy.  Did you want to take this via the doc tree, or would
you prefer if I pulled this into the LSM tree?

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
