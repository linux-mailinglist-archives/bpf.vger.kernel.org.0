Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D6F44B902
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 23:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242068AbhKIWya (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 17:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345702AbhKIWyI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 17:54:08 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B27EC0432D5
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 14:25:52 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id o4so724203pfp.13
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 14:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kmoy5rAGgZZp57wgnePj16rJ2xiDfWmZHrxezWo+FSE=;
        b=jQ1azQAntPbNJVZqOChZ68OM8heGfYh1USRovJKbmbDY7W2SZDOCXBDxobuEPSGbZM
         jgfe5l0QFx80u8z9nF1Z07YpWmWeWqSi3GisCaC6jxz5uVNeFO4Rk2vrd2JASlsqvz/w
         S3EVvH1gi75QUWg1bnG7SaiklFHzUDc+yxRFeJ4pLLiN5uMPpRgRcRlZdL8thqMLAVrH
         jFGHEa2bOOggerIXr3S2KzsdhD1ek6afsUV06DEN2brpKSEVs0GL2ERrNI1VGbU/s6rO
         WVHZcatLmQCq+rBY4o1pFdQZuPm7K51oZ2ZYiAXwryGD4k1gOU8vPvVlqn/bv5hVG22V
         7frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kmoy5rAGgZZp57wgnePj16rJ2xiDfWmZHrxezWo+FSE=;
        b=fSji/UVG4fiyQhMW5WHqTRGgUGrt6/yxH4wej8FqVC3bTc4r5L5/a2IlanzOuqOu5u
         kSt84OfSq1Ca3+OCKYX8NjPvInwVanBeIibxgGlSXbC0ehEvYpbXB1m34E56fIlKC0d/
         /usN4BnSglU4ilK7Nw2wrh9SFLWuApCIrPI+8Olw1qDENX1PGUY2RcX9OmHdcJNlO5Rl
         0W3f6YS58CuuvHceXimmOSZrkJ2fjmWcTVC4LolgZ9KVHFfGY2/ml0Ue2WYmevq2JnFO
         ourieWVSzENHp2129Tqp4t44rdivutx5f69X+RffAoGLcKA5sPB7xON0BC7wGdRNqyRC
         MrtA==
X-Gm-Message-State: AOAM532/7vQq0rYLXqgcLU+qW5HfaYf7C8dsnR3z8SUP/2tq25tDyBgb
        GKIYzixnNyUTIsEvXyrUEi0h7qkrePHlQ0O0TAg=
X-Google-Smtp-Source: ABdhPJwZTGQs+kgd3gCos8OB+AV0a2Cu4kU/JvPskynfBf3T5r2UGP4gMHnba7DcT1z7Ds3wQb2XDA==
X-Received: by 2002:a05:6a00:1350:b0:49f:e389:8839 with SMTP id k16-20020a056a00135000b0049fe3898839mr11654263pfu.51.1636496751888;
        Tue, 09 Nov 2021 14:25:51 -0800 (PST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com. [209.85.214.178])
        by smtp.gmail.com with ESMTPSA id t13sm8563697pfl.98.2021.11.09.14.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 14:25:51 -0800 (PST)
Received: by mail-pl1-f178.google.com with SMTP id o14so1213207plg.5;
        Tue, 09 Nov 2021 14:25:51 -0800 (PST)
X-Received: by 2002:a17:90b:1bcb:: with SMTP id oa11mr11254969pjb.140.1636496750801;
 Tue, 09 Nov 2021 14:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20211105221904.3536-1-quentin@isovalent.com>
In-Reply-To: <20211105221904.3536-1-quentin@isovalent.com>
From:   Joe Stringer <joe@cilium.io>
Date:   Tue, 9 Nov 2021 14:25:40 -0800
X-Gmail-Original-Message-ID: <CAOftzPinVTm3rfVFE-OQ5rtxOAamiJXfyanE7XPr6zNqPgrqsg@mail.gmail.com>
Message-ID: <CAOftzPinVTm3rfVFE-OQ5rtxOAamiJXfyanE7XPr6zNqPgrqsg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Fix SPDX tag for Makefiles and .gitignore
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, Peter Wu <peter@lekensteyn.nl>,
        Roman Gushchin <guro@fb.com>, Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Tobias Klauser <tklauser@distanz.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 5, 2021 at 3:19 PM Quentin Monnet <quentin@isovalent.com> wrote:
>
> Bpftool is dual-licensed under GPLv2 and BSD-2-Clause. In commit
> 907b22365115 ("tools: bpftool: dual license all files") we made sure
> that all its source files were indeed covered by the two licenses, and
> that they had the correct SPDX tags.
>
> However, bpftool's Makefile, the Makefile for its documentation, and the
> .gitignore file were skipped at the time (their GPL-2.0-only tag was
> added later). Let's update the tags.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andriin@fb.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Joe Stringer <joe@cilium.io>
> Cc: Peter Wu <peter@lekensteyn.nl>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>

Acked-by: Joe Stringer <joe@cilium.io>
