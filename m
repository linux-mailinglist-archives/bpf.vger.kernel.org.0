Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26550432B97
	for <lists+bpf@lfdr.de>; Tue, 19 Oct 2021 03:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhJSBtW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Oct 2021 21:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhJSBtW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Oct 2021 21:49:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5701FC06161C
        for <bpf@vger.kernel.org>; Mon, 18 Oct 2021 18:47:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id f21so12566876plb.3
        for <bpf@vger.kernel.org>; Mon, 18 Oct 2021 18:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pvr3FaBzSOwhyafBtpkgZ1TUmdMuGYW8Movpdp0PmZ4=;
        b=aTN2/4adLIIxK54UTh+kmx02QR6DbwIvmOlGLeJuI9sI+3LDPvTCpOsjC3kdqUglo7
         MVmN5fM92IqloY2icqFB2zjfVxk4pfsD0gFoBnxWNqVgwwTYKl31PEeQeYsWLGlK4y9m
         23Zpecxv5WUL0EIhBrq7I+XgDx3Yf7t8CZVVyWpBkSfxnR0ym9PkiDz5K+oLIAkvtUVV
         PcUcHCE94mGLDF4RyjsYhG/d+rlUr11Rn6zyXrCwc7RoGhDKAu0OAbr1CkJGPPW1e5wp
         Z5dd+1Nbc7NUeAkmd+p1xj/kPRRpvoCMbwC4Ig50u3j5PI2ix/Xh0Qr8VYc43331cPNN
         MPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pvr3FaBzSOwhyafBtpkgZ1TUmdMuGYW8Movpdp0PmZ4=;
        b=JyW520pJdH0pxUVfhjeybyG1yYKDykH4iHbqsqWqR+6tf3zvAZg6jA9GvVvbJebaoX
         R0KPmsFVNk4jE1SVb3sUymO+/vBjjJ8xlIDHAiDi9py862jrZTkSGzUzFy825NGacU4u
         maGFU5PlVSiWKw74ZHOi41ryR6/K+1ALoJt/AsWtfxZ3GdsJl9cnwW2PkeQem51qfD2U
         ny4Nv2hQDwwqL6pPCB0Qs8VTbcruf6B2S1InnlF/khWP60zWpBqRotzfKkN4vKLEG+dH
         m+jdb1gvVcC7rPw3SBK3MYLlk2IjEXvlpjzTQjOvZy7KjUvKlWBkxFtW5DLh2GeSzUGH
         b0tQ==
X-Gm-Message-State: AOAM533OHguFTQnRCS5m0kVjrbnqekiNIW6Ig6RIyxdSjFOHvHiA8FL8
        VZzwIl/Q36cM91+S28O88VJ25j+V0isygIEjduI=
X-Google-Smtp-Source: ABdhPJxkmFnTsH4eWusZdr+RLEwhG0wACSmr8thB/XB+K2HejI43NAnLA5Cdav4J45cNWIVGYSDp4vNCCUsCuMJ4LN0=
X-Received: by 2002:a17:902:7246:b0:138:a6ed:66cc with SMTP id
 c6-20020a170902724600b00138a6ed66ccmr31594535pll.22.1634608029876; Mon, 18
 Oct 2021 18:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211007141331.723149-1-hengqi.chen@gmail.com> <20211007141331.723149-3-hengqi.chen@gmail.com>
In-Reply-To: <20211007141331.723149-3-hengqi.chen@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 18 Oct 2021 18:46:58 -0700
Message-ID: <CAADnVQLGfg=iMUi4oQtMzY9Y+j_pZtAAHQ_b8zO6wPaL6C0ooA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2 v2] selftests/bpf: Test bpf_skc_to_unix_sock()
 helper
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 7, 2021 at 7:14 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> +
> +       sockaddr.sun_family = AF_UNIX;
> +       strcpy(sockaddr.sun_path, sock_path);

please use strncpy.

> +       len = sizeof(sockaddr);
> +       unlink(sock_path);

please use abstract socket to avoid unlink and potential race.
