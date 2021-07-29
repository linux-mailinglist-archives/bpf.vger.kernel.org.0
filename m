Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5103DAE6A
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 23:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhG2ViH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 17:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbhG2ViG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 17:38:06 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1BCC0613C1
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 14:38:02 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id x192so12608076ybe.0
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 14:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/I14GSqYWrlRi4K7zUzKjIoZ3XiSZaEjWt9YPDMb008=;
        b=Bn/9PKS7gzaKE/YI5wyzPkKM4wfVKqGjhJBL3HhR2OuGSlGwHt4iDcxsR5gQCrNqUq
         V0YdaKLSDVvYA05A8D9uMVjMhASrMMgauqaqgd2DPnBbNeuqBoPdygkZhGx2yq6LLZp5
         ghP8cLUL4j1yqlkG3U/y6RJ4z5v3GLnbNx0SnZ9yI07gj6fc5OlcfNiRf453rZ2ZexIp
         gdR8znJcNlvGWhpI22HQGGshfWeQezaWn7b8K6iEvuMjpg3Ky36AvxddI+APmh2EspFP
         kHhuiAXLdbkyE2get1gouw9ojYfglybyqcjicxRvhJr4lD+BqLsGz7+NbHL6XxgizRGi
         5tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/I14GSqYWrlRi4K7zUzKjIoZ3XiSZaEjWt9YPDMb008=;
        b=mSKEw3MgL75J4WqhGZGkydKBpLzfSNw+C4BNMXDW+EbDwJBwQQMCdqs9LEB2blTgUb
         rDnV4qtRM9ObloUhb+OWL9lB9PqxmrIWP5O+o0WE9hjAtIMgS++yKlInrgG9nrVej/vs
         1EDx39yNENbA96aaFcv4/U7h+bK8xKDK/BR83GkhMkJqdgKsE4CcLJGuFw+1XWP6D5+z
         33RdIKmM6eT7AkyZYh6GRHuK+NrnU6ywPC7Lt2wzEMZy7BOFujGG0WH6L+hABwxOHAF8
         UJJ9r2vA+AB+H2ZbdDqRomLH9yDwH5YMS6+xp+BxpVySpHtGba7WOo8Haxg94VdL0ifp
         AkyA==
X-Gm-Message-State: AOAM532asDN2ml9NMG9xkJwlDTJHZ+k8ml5ODGks/rOPvSw8A7JI6ypw
        /hf+2LDMDte6Op4EeJlNrNWrkXs6va5MJo9mKNnylA==
X-Google-Smtp-Source: ABdhPJyGiWhlBfq2qUuOTOlOgsi8ogDzY5x+zO9VRFu2wMV++7NdSiZ1346y6LusZh1+k8Hiwo5XLfXWLKeb9CZprKI=
X-Received: by 2002:a25:380c:: with SMTP id f12mr9859379yba.208.1627594682295;
 Thu, 29 Jul 2021 14:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <5afe26c6-7ab1-88ab-a3e0-eb007256a856@iogearbox.net>
 <20210728164741.350370-1-johan.almbladh@anyfinetworks.com> <1503e9c4-7150-3244-4710-7b6b2d59e0da@fb.com>
In-Reply-To: <1503e9c4-7150-3244-4710-7b6b2d59e0da@fb.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Thu, 29 Jul 2021 23:37:51 +0200
Message-ID: <CAM1=_QTQeTp7LF-XdrOG_qjKpPJ-oQ24kKnG_7MDSbA7LX+uoA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix off-by-one in tail call count limiting
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tony Ambardar <Tony.Ambardar@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 28, 2021 at 9:13 PM Yonghong Song <yhs@fb.com> wrote:
> I also checked arm/arm64 jit. I saw the following comments:
>
>          /* if (tail_call_cnt > MAX_TAIL_CALL_CNT)
>           *      goto out;
>           * tail_call_cnt++;
>           */
>
> Maybe we have this MAX_TAIL_CALL_CNT + 1 issue
> for arm/arm64 jit?

That wouldn't be unreasonable. I don't have an arm or arm64 setup
available right now, but I can try to test it in qemu.
