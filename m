Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A6A3BDFCE
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 01:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhGFXfj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Jul 2021 19:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229787AbhGFXfj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Jul 2021 19:35:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBE8E61CAD
        for <bpf@vger.kernel.org>; Tue,  6 Jul 2021 23:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625614379;
        bh=2A/iqbTmkdAizieLsPhAIeXb4cSMLlbN4lYgRl2C4Fk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C7ySQ9UOfrcwjyHKHT5XDHfwNu20nw601GefQwxwLFP14YyIuvWt2FMVbxVxDKuy4
         4YwWMjRp4H7fwD6/MfdZfEBwQqkIRMo2cGwgljL9X6WxVG7x6fc1MX/HojAw9Gk2tZ
         VapAtLGDbdmCLXo6tOAycblJxl2GDy0hqu9FaEyk2nrxQJsEQTKr2JzR0jtzHk1AX2
         EA+fjP7yNj0FC/iMRr1jROcos05v1rP5OIKzG4I2bKoA2nyRAye26yKdONdewYid6K
         1aL4l+09wRxy2ah6fXkDlONuRNgTVBpksuS4XaUlVpNI5sBgZUUpcQQR6TYaMMLADw
         7iasd1odsJVbQ==
Received: by mail-lj1-f170.google.com with SMTP id s18so264758ljg.7
        for <bpf@vger.kernel.org>; Tue, 06 Jul 2021 16:32:59 -0700 (PDT)
X-Gm-Message-State: AOAM530QRva0UT/SlPuuShwOsSwMhrlAb/Vg/0IRdFF7waVQT/vTTnpr
        tTW5Jpj6ae4Djt/cdzF3PIP5H4a0Qh7mdpd2KhU=
X-Google-Smtp-Source: ABdhPJwIH/NfAipLAJRdH0ktL0D8C9MCZuVhDjSdDvpVQYYXcsKmiTAJPZQnzMqq/vNwwdBdTKJE74ovJ2qQ/tmgycI=
X-Received: by 2002:a2e:b8ce:: with SMTP id s14mr5593349ljp.177.1625614378117;
 Tue, 06 Jul 2021 16:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210706172619.579001-1-m@lambda.lt>
In-Reply-To: <20210706172619.579001-1-m@lambda.lt>
From:   Song Liu <song@kernel.org>
Date:   Tue, 6 Jul 2021 16:32:46 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5nyaM5MNg=Q0ojLVQVsnyDrJNukB3WTQ+sk8t4etZiGA@mail.gmail.com>
Message-ID: <CAPhsuW5nyaM5MNg=Q0ojLVQVsnyDrJNukB3WTQ+sk8t4etZiGA@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: fix reuse of pinned map on older kernel
To:     Martynas Pumputis <m@lambda.lt>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 6, 2021 at 10:24 AM Martynas Pumputis <m@lambda.lt> wrote:
>
> When loading a BPF program with a pinned map, the loader checks whether
> the pinned map can be reused, i.e. their properties match. To derive
> such of the pinned map, the loader invokes BPF_OBJ_GET_INFO_BY_FD and
> then does the comparison.
>
> Unfortunately, on < 4.12 kernels the BPF_OBJ_GET_INFO_BY_FD is not
> available, so loading the program fails with the following error:
>
>         libbpf: failed to get map info for map FD 5: Invalid argument
>         libbpf: couldn't reuse pinned map at
>                 '/sys/fs/bpf/tc/globals/cilium_call_policy': parameter
>                 mismatch"
>         libbpf: map 'cilium_call_policy': error reusing pinned map
>         libbpf: map 'cilium_call_policy': failed to create:
>                 Invalid argument(-22)
>         libbpf: failed to load object 'bpf_overlay.o'
>
> To fix this, probe the kernel for BPF_OBJ_GET_INFO_BY_FD support. If it
> doesn't support, then fallback to derivation of the map properties via
> /proc/$PID/fdinfo/$MAP_FD.
>
> Signed-off-by: Martynas Pumputis <m@lambda.lt>

The code looks good to me. Except a checkpatch CHECK:

CHECK: Comparison to NULL could be written "!obj"
#96: FILE: tools/lib/bpf/libbpf.c:3943:
+ if (obj == NULL || kernel_supports(obj, FEAT_OBJ_GET_INFO_BY_FD))

Also, I think this should target bpf-next tree?

Thanks,
Song
