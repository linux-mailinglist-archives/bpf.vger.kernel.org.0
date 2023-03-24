Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A0D6C8288
	for <lists+bpf@lfdr.de>; Fri, 24 Mar 2023 17:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjCXQkR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 12:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjCXQkQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 12:40:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B476A1B2DF
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 09:40:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cn12so10300032edb.4
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 09:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679676013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkqrrrBli7iwioLLpZaqx7X4Cp1aCl3V92ectHxHlRw=;
        b=P8fF38dqC7mw9gR50t3xfU0Ct4Nh3npY6bKtO0d0nGq8Nl8Rv6ETrQVG9oxcsQiDCP
         CHDU/FOdQ20gQdHBZQNU62irjEaj0204Jf2AYW5kuTzmAVqDaXXNkR0/h9D8HhgrPbrL
         yfrespfSxEuMuSQRx27xgZNMt1QigBMmFwVF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679676013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkqrrrBli7iwioLLpZaqx7X4Cp1aCl3V92ectHxHlRw=;
        b=7i4W93nKCWiT4B0ziFM2AGGoWf3MhHB2N2tIvDmER5+7JfOaTF9Tn/LWMMwsbFCYn0
         qgDRrN8k21bo6ofqjZM7P5xKJjiyuysdq/9PB2zCr9gWzvGS3WjeR/MAJ2DwBJSl8pve
         W0AZXmuFE9KICcFtvjg7C4JG9YcLvu+Yio49tmcJ+F/9pmg4x8/HKC1LJ3sm44ADdUrW
         PJDn5IOFaGejx6Fg91vrqYqaDofb5jH9tKM+ZREtlWZdUzUvjBss39cOueTycRh3Lby5
         ldFKNdH62we7C86+4yjGY3k1JJf0xDBQR7wE33n1wl1s0FdDhIWBQvJNLWgCTNrecZm7
         2mVg==
X-Gm-Message-State: AAQBX9eiVhknGdd1NfjAjn3Nm67CWR4Z1SxG1a6Z+clZZXA+TDWVvWlP
        J5yBE3xIkEsAZYSB39eknLVRmp0evxdxjzWiHkHs0g==
X-Google-Smtp-Source: AKy350aMH0lq2FhHvvqohi1LRgMjgVe8Oul8w9DbX5oNBbf5n4CXyar01OzTUjhlh4fPneOAgRcelw==
X-Received: by 2002:a17:906:3ac2:b0:8af:3b78:315d with SMTP id z2-20020a1709063ac200b008af3b78315dmr3489770ejd.23.1679676012952;
        Fri, 24 Mar 2023 09:40:12 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a16-20020a170906245000b0093a6e9c2634sm5075234ejb.192.2023.03.24.09.40.12
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 09:40:12 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id t10so10153957edd.12
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 09:40:12 -0700 (PDT)
X-Received: by 2002:a17:906:7846:b0:933:1967:a984 with SMTP id
 p6-20020a170906784600b009331967a984mr1673964ejm.15.1679676012002; Fri, 24 Mar
 2023 09:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230324123626.2177476-1-sashal@kernel.org>
In-Reply-To: <20230324123626.2177476-1-sashal@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Mar 2023 09:39:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmKqvUrKx6+N6NzKJuQn0OY2xrDApzHAdJj23ztjzcBw@mail.gmail.com>
Message-ID: <CAHk-=wgmKqvUrKx6+N6NzKJuQn0OY2xrDApzHAdJj23ztjzcBw@mail.gmail.com>
Subject: Re: [PATCH] capability: test_deny_namespace breakage due to
 capability conversion to u64
To:     Sasha Levin <sashal@kernel.org>
Cc:     andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 24, 2023 at 5:36=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> Commit f122a08b197d ("capability: just use a 'u64' instead of a 'u32[2]'
> array") attempts to use BIT_LL() but actually wanted to use BIT_ULL(),
> fix it up to make the test compile and run again.

This got fixed differently by e8c8361cfdbf ("selftests/bpf: Fix
progs/test_deny_namespace.c issues").

I wonder what drugs made me think BIT_LL() was ok. Maybe my wife puts
something in the coffee?

                Linus
