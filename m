Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9E937B289
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 01:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhEKXZy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 19:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhEKXZy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 19:25:54 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2082AC061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 16:24:47 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id i4so28526042ybe.2
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 16:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1OeZQa3Uy4ogSrvwRmc8CG+TYkGdcLvuyVIpsJAdFSU=;
        b=DxDy5TMxziBnOnfMyTIUdmqqx2Yymi3XGPhCF0CeVlkUj3yGUKL8Di0eoPNtfxaDWG
         22jWJGAiXx2qY4zGQ0f0PL6SHUo/FPycXFu7hyKn99gleR7XyDwpw6v5ey2EDnz1YkRg
         weS+HNXwbOGgbG8hWLO0cLftAysg9v8Kzc+hdF2IFycTfcXK2FyZgXJ0+BdtlWOUzHEA
         REoh6RtPppFImVEB8A+F5YCLqpNH/6GeE6IQ2Iqu5J2W5+ewzkKlRoP13qmUxHB0gwBT
         3rPVm1zwzPFRoU0JhuLl++NYp8b2ULYaU+4LNonvMfTDhot+rGGCMWvMY1E/w7e+eNu2
         PnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1OeZQa3Uy4ogSrvwRmc8CG+TYkGdcLvuyVIpsJAdFSU=;
        b=TBZCAwwX+0qQbk5jzgQJH5VOwuhTW23/dav0RgW1U2GpGtiPJL+mcti0pk6d6dksZ8
         vlXeRL0qeoh9GCa641RNBm6WMZ3FcAM4t+2GElR72SO467UI812dWVtXkBu5XnGz3rok
         hr56epVp4mtboYZdlVQ4OAYjjs+pb8Vc/hBY3BZvVYMfEGBs0VDufXl5DrJokksmqoav
         Y3Pf/+ew8rUgGjyD/w0RxQ/V745TEWEWnT+g9Z/uT2L2+InvHlrUVMbJPHZij3PSeK+C
         B0hh1NhrveivVp+kYALgg7dd6lKU9TiE79sUXgUyJNjsraxmaYqmGfGfnutrhIiaGgxz
         Fo5w==
X-Gm-Message-State: AOAM532DTsdjseCeV71NKK4h0AZywAIHPrEdr7CfuTMbazVnYT235zxj
        U6lPhUY2tMtCbAa9PHESxHQh6Ygkb4Q52WvM7/c=
X-Google-Smtp-Source: ABdhPJylwNhtCSdjy6ZVft3be+IcrVkU7D2BNDz1XtSwwrCa43uwrx9szC79C8QR4NXo3NxEeodSuUANrCcGWnEixDE=
X-Received: by 2002:a25:9942:: with SMTP id n2mr46003044ybo.230.1620775486465;
 Tue, 11 May 2021 16:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-16-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-16-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 16:24:35 -0700
Message-ID: <CAEf4BzaBS4hhiSvsLcdZvSQv598+ODAyXstLcFgEhzEmzmj2yw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 15/22] libbpf: Use fd_array only with gen_loader.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 7, 2021 at 8:49 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Rely on fd_array kernel feature only to generate loader program,
> since it's mandatory for it.
> Avoid using fd_array by default to preserve test coverage
> for old style map_fd patching.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

As mentioned in the previous patch, this is almost a complete undo of
one of the earlier patches, but it also leaves FEAT_FD_IDX and
probe_kern_fd_idx() around. Can you please try to combine them?

>  tools/lib/bpf/libbpf.c | 24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)
>

[...]
