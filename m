Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58AE28563E
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 03:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgJGBXz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Oct 2020 21:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgJGBXz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Oct 2020 21:23:55 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB42C061755
        for <bpf@vger.kernel.org>; Tue,  6 Oct 2020 18:23:55 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id h6so576687ybi.11
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2020 18:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dv6nXxobwCCqg5Yo0dV5u0tu+8+rd/oKwCpH77FyR3U=;
        b=BSxrZJvY38IwDpeuy0XXNWrjUIBvRBtXS4/sxQuUpFgbmJNfRaQfIkdQ6goa0lbLPO
         K6w7hQO04Clq12xmCZ3MasO8J5QKypTwKpPjHWI3Lc3NdqvOHn+mNh33dx40G7R9rZjV
         lm7NXNftIASQZzoFQqVO21ON7Q5VH7WtohB+xk27822t0AE87cyUK0FfMUjK/YNynzfO
         L0zD60B0fBzZT2/j2uyLVazI5VpWSUebxsX11ubjo1x95PAWiHTh+j5BFMPSc06zdVdb
         arnda04MhGUsAvEkDHXUo6hg4RLLqWlAY4O3WUICFohMcN+0tDdwdfwJEWd6Xjs0BBBL
         P76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dv6nXxobwCCqg5Yo0dV5u0tu+8+rd/oKwCpH77FyR3U=;
        b=SQkCcxvvMMfaVozyExF76IEukG8kproaFwnvSFxANpU/Hl6Qeez5akb9lDztX/aqpp
         5fCkWdQpjaJWq33FpwI4ZioM+qznsHisW0UvZB3LaV21BAWFXrgUwHJi6qgfwJTv4/aN
         Mnkvofet6z96zVFt+DCjn44ofwUMBzNw2J+PcPRDgC+9pHNP/IYNrTu7ghIRIMXzqsNE
         kIoYFuVAx91nmV11a59UCtiw8TkIBc18u+mgtlWgluWFB9vhKziwlq/rLckOHJ6HScVp
         sqMOtmOc/iqvSWyoK5pTK/WNnjppj7oPDNCS9l7KYHaehDJKlGTz7D+SdoMO7N/+cXVY
         Y0kA==
X-Gm-Message-State: AOAM531CnKW0/+1V4EURDgotNJhmIcv5OGh6aCdey03clmpq+MCUL5a2
        VQF5fZPCuOnxV6+CiMY7jyuQmmtzwgsJfjuY8mE=
X-Google-Smtp-Source: ABdhPJw/8ds1mmyxZvaiNLRYg0K+fNJxHIjBkZmbaG8gVEgUKG9gm3Wrd3y76hZOQArAE25+HlRFNRNEpYwhBGtb5Vc=
X-Received: by 2002:a25:2f43:: with SMTP id v64mr1218907ybv.27.1602033834416;
 Tue, 06 Oct 2020 18:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <CACYkzJ7AfZ4HMEzt7OV_T4N8RO4SJcFbyEVxCgVrkKS4uiOD=g@mail.gmail.com>
In-Reply-To: <CACYkzJ7AfZ4HMEzt7OV_T4N8RO4SJcFbyEVxCgVrkKS4uiOD=g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 6 Oct 2020 18:23:43 -0700
Message-ID: <CAEf4BzbrF9C27gX5JaAq--Ex7+cJe0yz0QKVo9fov2voiiWwtA@mail.gmail.com>
Subject: Re: Failure in test_local_storage at bpf-next
To:     KP Singh <kpsingh@chromium.org>, Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 6, 2020 at 5:31 PM KP Singh <kpsingh@chromium.org> wrote:
>
> I noticed that test_local_storage is broken due to a BTF error at
> bpf-next [67ed375530e2 ("samples: bpf: Driver interrupt statistics in
> xdpsock")]
>
> ./test_progs -t test_local_storage
> libbpf: prog 'socket_post_create': relo #0: parsing [28] struct socket + 0:0.1 2

This line is truncated, btw, please make sure you post the entire
output next time.

But, this seems like a bug in Clang, it produced invalid access index
string "0:0.1", there shouldn't be any other separator except ':' in
those strings.

Yonghong, can you please take a look? This seems to be a very recent
regression, I had to update to
6c7d713cf5d9bb188f1e73452a256386f0288bf7 sha from not-too-outdated
version to repro this.

> libbpf: prog 'socket_post_create': relo #0: failed to relocate: -22
> libbpf: failed to perform CO-RE relocations: -22
> libbpf: failed to load object 'local_storage'
> libbpf: failed to load BPF skeleton 'local_storage': -22
> test_test_local_storage:FAIL:skel_load lsm skeleton failed
>
> by changing it to use vmlinux.h with:
>

[...]

>
> clang --version
> clang version 12.0.0 (https://github.com/llvm/llvm-project.git
> 6c7d713cf5d9bb188f1e73452a256386f0288bf7)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
>
> pahole --version
> v1.18
>
> This error goes away if I comment out the lsm/socket_post_create or
> the lsm/socket_bind which makes me think that something in
> bpf_core_apply_relo does not like two programs in the same object
> having the same BTF type in its signature (but this just a guess, I
> did not investigate more).  I was wondering if anyone has any ideas
> what could be going on here.
>
> PS: While working on task local storage, I noted that some of the
> checks in this test were buggy and will send a patch to fix them as
> well.
>
> - KP
