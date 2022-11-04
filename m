Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9809861A04C
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 19:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKDSvQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 14:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKDSvK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 14:51:10 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F1C45A3F
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 11:51:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k2so15625516ejr.2
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 11:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o4EnI9/Dwq2PBbCKtP8LVDnqIoBE2RyQNYcBVFGtkiE=;
        b=n3ZtutY5dFd66Qn8MKsc1Ub/W7P0UCQb2Lnt1Y7fsDC9fKNVma3lAWxvhKyn86ava+
         mquxgEtJ7rfYJ290OtUD5df7HZmBYgDBiEz9Dq+oaW4iKFxNjXf63BFSmq5vvuy2NWTX
         vByn19pBpYPRZIqku341WgxecGOTCaXGN303mnzl0UTwfLyuBpJvpo4lqeiKJbC3rF2Z
         s36scxf7DlKCGYWYw9N4GrmaratZtmU5IhtC+VjMPLCP4CJxvy1kCrkC3Fxfr0+oyVIM
         JCCJW2D6WAqBlEs9iB1mtMY8HokmnC09A/NaYMHkNZoLBp5d7baV4vTe429A/QrK/4Wd
         RPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4EnI9/Dwq2PBbCKtP8LVDnqIoBE2RyQNYcBVFGtkiE=;
        b=aXifGZhtpSjS3wwc4i3rByatilarOr6qJIliAWSSHsBu0FBpNkP7ducxrA92krju7n
         FDqUs6Dv7YrxK3A8ipvCfeesKZWvwWgljmOiDDFY2kjwt00pD68Qo1bfUs1lx40GJRIT
         0aHAXtemrtxzlc207F5KP51LujFmKoP8AxLOcdpP/nqN4LBAAVMlUPM4Rmy19QZZ/NyF
         WKAy4nj3n8zoX5J1BWK3Aa1ez1xQK3qCMSTdlzJ02ztHqVc3uzUpkNM8p3CWVbnzW7T3
         06lns+3FZHVWFJN+AEN3rFPgzx8nQjY6vFT6vgzY9f34WlrrDtlgMT+B1BUZy8Xvl7yb
         NuMg==
X-Gm-Message-State: ACrzQf020nINPmTsQc02wOLZ36i3zC2dl8pWE+K4tuEQ6A8J3hA0NyvE
        UXS8XITqEDw6TNHwKtAFpg6zVhUyLucGRtbLil4=
X-Google-Smtp-Source: AMsMyM7aOgpMKXY/Hw5VYXAmlv5gxeSYt8krb01MSsfBM8OfsKxVqVR9F5YOr9obF2rZ920mK1rkC++AKyehfdSsVfQ=
X-Received: by 2002:a17:906:99c5:b0:73d:70c5:1a4f with SMTP id
 s5-20020a17090699c500b0073d70c51a4fmr35322720ejn.302.1667587867331; Fri, 04
 Nov 2022 11:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221103033430.2611623-1-eddyz87@gmail.com> <20221103033430.2611623-3-eddyz87@gmail.com>
In-Reply-To: <20221103033430.2611623-3-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Nov 2022 11:50:55 -0700
Message-ID: <CAEf4Bza+W2Fom3JVkykjRNMjJtMoKwapP-hb7bvgJ5AeLSX4cQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: hashmap test cases updated
 for uintptr_t -> uintptr_t interface
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        alan.maguire@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 2, 2022 at 8:35 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Hashmap test cases require update after libbpf's hashmap interface
> update from void* -> void* to uintptr_t -> uintptr_t. No logical
> changes, types / casts updated to satisfy the type checker.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

We have to do this in patch #1 to ensure that selftests builds are
bisectable. Doing it in a separate patch/commit breaks build between
patch #1 and #2


>  .../selftests/bpf/prog_tests/hashmap.c        | 68 +++++++++----------
>  .../bpf/prog_tests/kprobe_multi_test.c        |  6 +-
>  2 files changed, 37 insertions(+), 37 deletions(-)
>

[...]
