Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D962D66D1EC
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 23:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjAPWtw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 17:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjAPWtr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 17:49:47 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ECB244BC
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 14:49:46 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id a40so504673uad.12
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 14:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0IEpt49/65E0wGkbn3RYoaG0iQiOmclklQOb+UN4RXU=;
        b=kVs7w+0I28gjlBzuI/gIhfx+so8q2yysPSVzIWrNOGS9rqKYUMOU/8QVCBdFk3JBoW
         LqofLbwAC8DQpo0ItS0cDQNjxA/Q9qrX0YNuFVBWfUEM7PhL3HvxR1zdwzXLI1Sjxqhl
         uCPTIlucAzxhKmTP666Nh90oD+1B7ndvd1tjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IEpt49/65E0wGkbn3RYoaG0iQiOmclklQOb+UN4RXU=;
        b=T5BQQm22HFQOR8avNi9Ui8uWK2Ek159oX1P52Gqk95i6/o3nc1q9vdEGUoWgBRben1
         4wj2+y8UHKe3Pc+Wz+oDBRI6R439DySIeBRuXsDkkVtUssjpX6/I5Qfmdi8HHjgEF1NF
         QY2CTmscRzwHWmQEEwDM+rOetgePu2LOaTWvQAFu4MSQq9ZRME55UAQzuzh6Gisfl6Es
         Cjt3+gqARDsAoUV6tveUnT2fHTV3ccq0r/on9OKHf9Ha3NBTgQ3pX9YlfCWZ7E5qqQ0U
         191fsroFplp5IDKoz5DzDyPoV6oIuvFrGSCbEiMO3fwxThRGtLw9vjBnfc+FZC/yuWLf
         Kjig==
X-Gm-Message-State: AFqh2kqUBYEu4k7Odtm+JuUsaQtbJlMsZbW2jy7RZYLWXivIgxSTOR7t
        KhH4ARV9Sqf0ZWigEtnR5Y7i8mHiZH3R6HZ58k05JQ==
X-Google-Smtp-Source: AMrXdXtwfbujXEmrpHh1D8hu3UQ2BUu4tyjxDDaOO6XcpcdIsuLMlwUgNRJxCrVjED8qrBxFxcawcPiPC4YFDJP+sKM=
X-Received: by 2002:a9f:37c5:0:b0:60a:bb33:8267 with SMTP id
 q63-20020a9f37c5000000b0060abb338267mr48403uaq.47.1673909385284; Mon, 16 Jan
 2023 14:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20230114-bpf-v1-1-f836695a8b62@pefoley.com> <cb03b745-26b8-706c-de40-80ae991e29fd@isovalent.com>
 <194f38f2dc7d521375e5a660baaf1be31536be9a.camel@gmail.com>
In-Reply-To: <194f38f2dc7d521375e5a660baaf1be31536be9a.camel@gmail.com>
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Mon, 16 Jan 2023 14:49:34 -0800
Message-ID: <CAOFdcFOgAH1z7EKyM=Q4EvzLuKETOWWDMwuqp36SxV-X6PGP5Q@mail.gmail.com>
Subject: Re: [PATCH] tools: bpf: Disable stack protector
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 16, 2023 at 4:59 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> A bit tangential, but since BPF LLVM backend does not support the
> stack protector (should it?) there is also an option to adjust LLVM
> to avoid this instrumentation, WDYT?
>

That would probably be worth doing, yes.
But given that won't help already released versions of clang, it
should probably happen in addition to this patch.
