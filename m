Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EF5427389
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243591AbhJHWSO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:18:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231830AbhJHWSN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:18:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCB2961058
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 22:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633731376;
        bh=T6CukmJRHLNGI6QoRqmzqqYhRmb4FNNOIASpMwLQWIg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tZUyYgpL6dxAAduxSPq6HcFWCB947U+v+a/rFH/szNlvS30CzVs4oa1MPSRS83VN8
         M2nJvzJG5JZLp6WXIeZHSZJlRwugAd45ckUPD51wBFbVXEFWtf9XylNpvNjb4WNI4E
         zByiTi9UpDzwbw2YKRHNN2mw9wLXXL4f38dsRFSMXxHWpPZmcTByZzcRTexR32hbzA
         j4mWNE5fldgvl0Abicbo5etuXPgKOrsJrN8S7GcUflzwwVueijgFubsQdb0qkp8Wsz
         r4/QiwoqLCuQQxmpNAZH3ubxXKa9sWugmq9IPEJfav6+g5QKZwdHDmtjet93IOS2cI
         Xm34FBQHlk1IQ==
Received: by mail-lf1-f52.google.com with SMTP id b20so45334277lfv.3
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:16:16 -0700 (PDT)
X-Gm-Message-State: AOAM530rFesDKt+eprY0HO+23TWXinpGUFLxb47HqhCGVWQsE4jMrpve
        EVzsZUcFg5SQ8JBkA/R1srgVpNCKrsiZwzRl0fE=
X-Google-Smtp-Source: ABdhPJyqF94c/Ik5iNAKGz1iPRc5OgNxtfFUPkLY/OlVvrix5cxq6WGlWMhmNCXoCkvlATRwytu5Ki2foPXvqiKGXyg=
X-Received: by 2002:a05:651c:907:: with SMTP id e7mr6306077ljq.457.1633731374576;
 Fri, 08 Oct 2021 15:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-10-andrii@kernel.org>
In-Reply-To: <20211008000309.43274-10-andrii@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Oct 2021 15:16:03 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5M87F=770RALd2-nZ-uaypR-JsTTbOTX9vLx7N-t4wgQ@mail.gmail.com>
Message-ID: <CAPhsuW5M87F=770RALd2-nZ-uaypR-JsTTbOTX9vLx7N-t4wgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/10] libbpf: simplify look up by name of
 internal maps
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 7, 2021 at 5:05 PM <andrii.nakryiko@gmail.com> wrote:
>
[...]
>
> With such set up, we get the best of both worlds: leave small bits of
> a clue about BPF application that instantiated such maps, as well as
> making it easy for user apps to lookup such maps at runtime. In this
> sense it closes corresponding libbpf 1.0 issue ([0]).
>
> BPF skeletons will continue using full names for lookups.
>
>   [0] Closes: https://github.com/libbpf/libbpf/issues/275
>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Cc: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>
