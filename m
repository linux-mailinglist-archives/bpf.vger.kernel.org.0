Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5807E2AE7BE
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 06:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgKKFLR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 00:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKFLR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 00:11:17 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C2EC0613D1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 21:11:17 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id f140so804310ybg.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 21:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HEUdA+hzZsZRFLkQ31iaZLvbZPLntZnIMy9hK7wG9k0=;
        b=DaUP8xRorNt4Yw45ulkjxYOW6uy8OR6WBbQkhXqAqTRvQp8D9fXKISTu+eDq9x4C3a
         m6cxNfHpIoqS8xz+0lctS9kHSFcQ83aSX5A9kVyOFopQ2pbfL80qubWQQYjQrp443lpN
         NUGSj8E87X2Mx4aJjlnEl2lEwq/s2bUoYujvRSAH7unQFXZVahrkzTUgnVIuzFWgzgz6
         FcOBac8XJnLRMwM5jGqKNCKHBChTJW3ItcA2bECUSUbMydsUFH/vNJZ29s6O7Pu0UNdj
         X0Qzf1eKEOi9vkku83a6MDLwuX3dY5gRmbHUO4vLm0dEkqenEl1iegt1D8AnAHwbdLyH
         +DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEUdA+hzZsZRFLkQ31iaZLvbZPLntZnIMy9hK7wG9k0=;
        b=GgRKuvltpJwATf25Zliz6lXJmrreQw8swa0mZfA9GsmJNv4tgZ+F0coNVxP8MP3SoO
         dvEPc3B3vP6XFoNrxSF326CvoiCu7my3ueA9VPykxJPNhVibBakLHm3NRlmZrvo2FgLe
         cXA5avKSaiFL7T1d/6IsmZCG7s0JN14z+5L6NZERMzoLuIIUF027j1nbVZ45R30C4QUk
         SnHD8nN7mavU1M9YySzQpvaaMji04mfLsnOl/za6PZly1C7qjlbnwLgot6WymyZKRs0Y
         xQ0qeCEwk55SeKV/WWkKoIJ5m7vAAeE974Nde763BD0OPB0v+jZ2ePuuGSMI3gRTZLOZ
         IM/A==
X-Gm-Message-State: AOAM530Dd808diQcD6A4i1OI/I3JR0oJsfN06WFYbmoOaOiTaAAkLt74
        znszxzpvhLLh3b++Tn6TlXz7eLOq5vwwtruIAEk=
X-Google-Smtp-Source: ABdhPJwBPuOcAttDD5LOnnt5Ybj9olWmqmaUpLQ3J40qFtJd05NLjOjg4I5lBfm9B1iqO0bqmgTUype9EqYzQQAXyls=
X-Received: by 2002:a25:3d7:: with SMTP id 206mr19349339ybd.27.1605071476322;
 Tue, 10 Nov 2020 21:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20201110164310.2600671-1-jean-philippe@linaro.org> <20201110164310.2600671-6-jean-philippe@linaro.org>
In-Reply-To: <20201110164310.2600671-6-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Nov 2020 21:11:05 -0800
Message-ID: <CAEf4BzYs998tBbeSAkoSvw1bYCnx7sG9s2gat=rNHsdUprrfjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/7] tools/runqslower: Enable out-of-tree build
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 10, 2020 at 8:46 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Enable out-of-tree build for runqslower. Only set OUTPUT=.output if it
> wasn't already set by the user.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v3:
> * Drop clean recipe for bpftool and libbpf, since the whole output
>   directories are removed by the clean recipe.
> * Use ?= for $(OUTPUT)
> ---
>  tools/bpf/runqslower/Makefile | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>

[...]

>  clean:
>         $(call QUIET_CLEAN, runqslower)
> -       $(Q)rm -rf $(OUTPUT) runqslower
> +       $(Q)$(RM) -r $(BPFOBJ_OUTPUT) $(BPFTOOL_OUTPUT)
> +       $(Q)$(RM) $(OUTPUT)*.o $(OUTPUT)*.d
> +       $(Q)$(RM) $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
> +       $(Q)$(RM) $(OUTPUT)runqslower
> +       $(Q)$(RM) -r .output

hard-coding .output here doesn't seem right, didn't all the other
lines clean up everything already?

>
>  $(OUTPUT)/runqslower: $(OUTPUT)/runqslower.o $(BPFOBJ)
>         $(QUIET_LINK)$(CC) $(CFLAGS) $^ -lelf -lz -o $@
> @@ -59,8 +65,8 @@ $(OUTPUT)/%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
>  $(OUTPUT)/%.o: %.c | $(OUTPUT)
>         $(QUIET_CC)$(CC) $(CFLAGS) $(INCLUDES) -c $(filter %.c,$^) -o $@
>

[...]
