Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CF54C21B9
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 03:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiBXCb7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 21:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiBXCb6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 21:31:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0572325F3;
        Wed, 23 Feb 2022 18:31:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 129A86159E;
        Thu, 24 Feb 2022 02:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEBCC340F1;
        Thu, 24 Feb 2022 02:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645669887;
        bh=35h6CX91aZ4xLwAScKOmp4ZeUdk2iLJq6vdPAvKxmQU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CS5MrlX3vvqBeU1jrlmDo+KtjGv6TsJEeSuC3LeP7tq+l1Pc4pZb9EhlHzdfj5LqT
         WeprXJkAlSe/Z9lBpoijYWpVWEj/nQ+FKl/8CaU4MpqZl7bzYjHwoBZ74Gu0wgx9yZ
         xTVd181hQTK01u3e9pYKQOsZ7LPVm+miTsij595/Ot/ULHHRDRC2uXvN4lOsyYGSaB
         /RiDfO1t5qsnDjyi0r4wBiLBOdeq3NVMusGw1tFm+VhEPCkZiI0wOvhLuMxMB4cqgb
         4dZyxJJahoZzcHl+hGSJGammk1clFDzaXfxahc4yOzmlel8OL3SeA7l5LFCyFsSyOn
         MWjvcsfNP9c0Q==
Received: by mail-yb1-f173.google.com with SMTP id b35so1030387ybi.13;
        Wed, 23 Feb 2022 18:31:27 -0800 (PST)
X-Gm-Message-State: AOAM532F/Y7tV+UkUd++sXF8x/98F8fNLEBVthxe7Wyc8V9ggDN5lubg
        Wim/z86Nibwqn1faxUoyV/Uv2ENDpHNwAswAIYk=
X-Google-Smtp-Source: ABdhPJwFL7h3B+Zvv1jvG93XoCCvjbqIrwW6XjyAFDlqlgFFcJ7A1MijTz/S/kHyGJdWE9E8o/v52xIS/rizIqLK1h4=
X-Received: by 2002:a05:6902:1ca:b0:624:e2a1:2856 with SMTP id
 u10-20020a05690201ca00b00624e2a12856mr571208ybh.389.1645669886532; Wed, 23
 Feb 2022 18:31:26 -0800 (PST)
MIME-Version: 1.0
References: <20220224000531.1265030-1-haoluo@google.com>
In-Reply-To: <20220224000531.1265030-1-haoluo@google.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 23 Feb 2022 18:31:15 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6BqEn8azap_zcWq0Zkvv8mRFg6g0UX2fPQXwzT+F6V=A@mail.gmail.com>
Message-ID: <CAPhsuW6BqEn8azap_zcWq0Zkvv8mRFg6g0UX2fPQXwzT+F6V=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Cache the last valid build_id.
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 23, 2022 at 4:05 PM Hao Luo <haoluo@google.com> wrote:
>
> For binaries that are statically linked, consecutive stack frames are
> likely to be in the same VMA and therefore have the same build id.
> As an optimization for this case, we can cache the previous frame's
> VMA, if the new frame has the same VMA as the previous one, reuse the
> previous one's build id. We are holding the MM locks as reader across
> the entire loop, so we don't need to worry about VMA going away.
>
> Tested through "stacktrace_build_id" and "stacktrace_build_id_nmi" in
> test_progs.
>
> Suggested-by: Greg Thelen <gthelen@google.com>
> Signed-off-by: Hao Luo <haoluo@google.com>

Nice optimization!

Acked-by: Song Liu <songliubraving@fb.com>
