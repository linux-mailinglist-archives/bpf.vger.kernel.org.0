Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFFB6DD82F
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 12:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjDKKpC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 06:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjDKKon (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 06:44:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FB14691
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:44:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id f26so13028388ejb.1
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681209855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaNim1vkIq70qfok9J48U1lgUwBWuqXh+PidwyA+EeI=;
        b=bjSUvquY3C9IhjkcolYeRiVvxpCdlGbE7EhbeSbdxT7spL7vAi33UMk2kVV3zjHrOf
         ipSYO0F7VxpaHTO4Kr9JoutSV8LDcs0M2e5y+m5e6YVHuYStOxEwEKgnkUMhUt9Bk2Xv
         rxwf63FDfVwZfRWZA/Y+7UDbG4tHEQoDMdmt0EeI20RJjDnhAEgF869sIRsRT9Ut+/q7
         eIWCB+K21EUz5yhMpxcpagjdBFiigJCJ/pIRT0C/DBEOQhvNow2KkkiGtRHvA2jrYd3X
         EJWLlu8Pe0wUyQhG3Q1MFJ4247F5zKQncnLajQkPVquJWPb0JQ54y00pmKO7v+0BrHNS
         A7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681209855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaNim1vkIq70qfok9J48U1lgUwBWuqXh+PidwyA+EeI=;
        b=IaZEVL9q3Fno48thaTsxDMlZMN+4CM0np5atTtbrEXFipa3S4S8T+KV3oc/NYMYtrI
         0+ERRUOtDfWl554KR/qqIZDjQxVZ41YzcUvCeKDUSekEEhBjPYYR0YMf9BC4qfmEY3D3
         V+Flu1NLipOwt/4BVCQMkyJ0ipFhuKkUbRB0G2pJhGRN+1ueS2JYGkq11sfIlYlNPYEv
         cJaFiBE+ywgYixmJ1VpQ5Yr2Kjm468fp68bFP9bpagDGZwc1eZwY3MMZpCSIJ5plVdmp
         qjUdKWx9DTgqwwZSUpRN5db1gd3uZVR3dPez2QkfuVbWOVJpaRCA94ffJLPKmEska9BN
         NKXw==
X-Gm-Message-State: AAQBX9fHP1nyovbLi0cMbL8ijcdIQlm6hSWeaCcn3HjOP9kZk2lgT9Gi
        +z/+Kv1izWiaFOzyWDTVG2FflaWLYipcsQG1kCr9kw==
X-Google-Smtp-Source: AKy350Yv9Azwo2/6BouEnzoDykkakhn2acFaFmIRPdpvt9HXxNKRk6cFOu2pagxNd+6FExJLbAglWnDEJG7l91bEyZo=
X-Received: by 2002:a17:907:7f23:b0:94a:8300:7246 with SMTP id
 qf35-20020a1709077f2300b0094a83007246mr3032847ejc.14.1681209855418; Tue, 11
 Apr 2023 03:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230406234205.323208-1-andrii@kernel.org> <20230406234205.323208-5-andrii@kernel.org>
In-Reply-To: <20230406234205.323208-5-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 11 Apr 2023 11:44:03 +0100
Message-ID: <CAN+4W8jhOVSxO145mhk4Sf5wE=zGsP53tv2JA55apXDaELMJ-g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 04/19] libbpf: don't enforce unnecessary
 verifier log restrictions on libbpf side
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, timo@incline.eu, robin.goegge@isovalent.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 7, 2023 at 12:42=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> This basically prevents any forward compatibility. And we either way
> just return -EINVAL, which would otherwise be returned from bpf()
> syscall anyways.
>
> Similarly, drop enforcement of non-NULL log_buf when log_level > 0. This
> won't be true anymore soon.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Lorenz Bauer <lmb@isovalent.com>
