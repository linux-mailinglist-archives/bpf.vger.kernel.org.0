Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9676E6B55BF
	for <lists+bpf@lfdr.de>; Sat, 11 Mar 2023 00:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjCJXiE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 18:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjCJXiC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 18:38:02 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6228CCA03
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:37:59 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-53d277c1834so127541977b3.10
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678491478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAsl0x71H/TTZvG/oR3VnRExXsP3bWi1hx0WaLiiJtE=;
        b=JRXQCPq5zg4qTSmdgtUN7OP9NuAGsnrIjn54cqLJRcwrqbHTRa18hfGhrk/xDG+ZXr
         EVxMsV2iDJDu2udOakivT+l6gvHAkZuGLkaXpFsa7orCJki3sp8dk00C7WIUAp1I1Tl6
         eYGsqZ/lew99fWvKU9ppRH7LM+kJoQbS9q2mW4mvk6Rp61nklzhL/Fbw5YMfdkexBJkq
         fSCpscmBOOej+qEb2mL2mBfgHgJtTKFIZT0oFbWGQ6ab9vOfOj6+viJwmDEBl31kjUVO
         yxNKRwXF2NjkunG1GCdwbUmwZ4YKcNDU/e9PEAfHA9Mi/Ir2gGOpdzMNxshxh9dVnKcB
         I4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678491478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAsl0x71H/TTZvG/oR3VnRExXsP3bWi1hx0WaLiiJtE=;
        b=p6Oz2PV1iWXhbSk2iDFmONOiO3Vvo08N0UK378l5Zv+0Q9b8jRzwqRshPXO8xLVWTO
         d5rT6B6p2ndOARp6Ftenr1whjrs7CSBRlFwIj3s34pDuKqCec5p6mVmPUE9z+E+ZkRYP
         QSDkkb6jskDi5oKvDmrSK+PhYNi3AUiq+oX96VqFVqzAb5KhqvRqigY0FIwjPzozQxgh
         CEME0WYat7Uyonglz2lLQ0P5dvYCDWp2BbAfPAj1wEEYnCtbtOEgP/bgYQ4cDQFw3DEZ
         B6agpqjjQdVR2OgKMTteKHXx40lTKF/3to4Yt7t4kXvY8G2HBfr1D/erKBP/JYuK9rRI
         K+jQ==
X-Gm-Message-State: AO0yUKV3LynPCUvOrV23iWvBLemYOhn1Fb3U8nR8O4Nt8dUsPzUPcQbY
        Fd8rtKYaztDTkC15QZGPwi/BG0hSgFT2T0WnGBDB
X-Google-Smtp-Source: AK7set/UM/hEEMUK6bVRDLfraDarPiY+xljrjjvUO83Jh4wDTGJ/dbydMv2X6EqZ1OFoJoykot/hNCtL+11T2bdzWew=
X-Received: by 2002:a0d:dbca:0:b0:533:9d13:a067 with SMTP id
 d193-20020a0ddbca000000b005339d13a067mr2648739ywe.3.1678491478514; Fri, 10
 Mar 2023 15:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20230310085401.1964889-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230310085401.1964889-1-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Mar 2023 18:37:47 -0500
Message-ID: <CAHC9VhR=Kv7U2ERqVadFx4Gu5zR2VJeEb1m4UAD-im-ef4_aVQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] security: Always enable integrity LSM
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 10, 2023 at 3:54=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Since the integrity (including IMA and EVM) functions are currently alway=
s
> called by the LSM infrastructure, and always after all LSMs, formalize
> these requirements by introducing a new LSM ordering called LSM_ORDER_LAS=
T,
> and set it for the 'integrity' LSM (patch 1).
>
> Consequently, revert commit 92063f3ca73a ("integrity: double check
> iint_cache was initialized"), as the double check becomes always verified
> (patch 2), and remove 'integrity' from the list of LSMs in
> security/Kconfig (patch 3).
>
> Changelog
>
> v3:
> - Remove Signed-off-by tag by Mimi (suggested by Paul)
> - Clarify that an LSM with order LSM_ORDER_FIRST or LSM_ORDER_LAST is
>   always enabled if it is selected in the kernel configuration (suggested
>   by Paul)
>
> v2:
> - Fix commit message in patch 1 (suggested by Mimi)
> - Bump version of patch 2 (v1 -> v3) to make one patch set
> - Add patch 3 (suggested by Mimi)
>
> v1:
> - Add comment for LSM_ORDER_LAST definition (suggested by Mimi)
> - Add Fixes tag (suggested by Mimi)
> - Do minor corrections in the commit messages (suggested by Mimi and
>   Stefan)
>
> Roberto Sassu (3):
>   security: Introduce LSM_ORDER_LAST and set it for the integrity LSM
>   Revert "integrity: double check iint_cache was initialized"
>   security: Remove integrity from the LSM list in Kconfig
>
>  include/linux/lsm_hooks.h |  1 +
>  security/Kconfig          | 16 +++++++++-------
>  security/integrity/iint.c |  9 +--------
>  security/security.c       | 12 +++++++++---
>  4 files changed, 20 insertions(+), 18 deletions(-)

I just merged the full patchset into the lsm/next branch, thanks everyone!

--=20
paul-moore.com
