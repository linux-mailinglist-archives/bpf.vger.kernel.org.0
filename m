Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EE845E83A
	for <lists+bpf@lfdr.de>; Fri, 26 Nov 2021 08:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhKZHME (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 02:12:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359024AbhKZHKD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Nov 2021 02:10:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7400261151
        for <bpf@vger.kernel.org>; Fri, 26 Nov 2021 07:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637910411;
        bh=pHayoCo7loPqoZDIPNtSXTuDh3L+aWnAmB0K7ZxF1R4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OtJWVzMawFrftIsXzdSYwUjIOpxDXs0ycnE8uujs8u0dtAjMz4YZeCNtGWZvXWba3
         V9GP002twFGO5Ah9u6wKjDlAzdud2bq5F45u1pYQTqoJ8+R/326gNlnLHzg09yGUWD
         issuOTda7hsZSIuRtC+N3tk1CXa7CvbOPmeMODndYIo7inhJk7nu4YC6Sz3Dg61w+W
         l5B9MEmgjXlujilLJ3fTdZbpz3MT6kN4+uf+L7elBahZ/vlc1K4rlN0SVnQQu6qXR2
         RbN40L4QjQ/fmFsOPR0tHEsTj1voPCfxQaWiFTsLqY9ArA/I85ll1s8YcBhlvanrYN
         VzYdk2JMOQz/w==
Received: by mail-yb1-f171.google.com with SMTP id v203so17746878ybe.6
        for <bpf@vger.kernel.org>; Thu, 25 Nov 2021 23:06:51 -0800 (PST)
X-Gm-Message-State: AOAM531MaoTP606iLXAQ1yDWP/dr37uQoNz3mBW/535kabM0666eTyVs
        yixhBRBMSql9bw5v+MCyKq0HUko6ePI98YsBnCU=
X-Google-Smtp-Source: ABdhPJyZUvI3O9KisqCnBEGzz/gpjYy3w3udl5wF52s++WpMINibIaIZP9odLhL8WnzmuqWzIblTJ31S9kGTGpq6u3o=
X-Received: by 2002:a25:bfca:: with SMTP id q10mr13355545ybm.68.1637910410658;
 Thu, 25 Nov 2021 23:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20211122144742.477787-1-memxor@gmail.com> <20211122144742.477787-2-memxor@gmail.com>
In-Reply-To: <20211122144742.477787-2-memxor@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 25 Nov 2021 23:06:39 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6z5Mh6vsEqzcrujftK+=HRPz-b1H-Yni25G9zVutiG7A@mail.gmail.com>
Message-ID: <CAPhsuW6z5Mh6vsEqzcrujftK+=HRPz-b1H-Yni25G9zVutiG7A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/3] bpf: Make CONFIG_DEBUG_INFO_BTF depend upon CONFIG_BPF_SYSCALL
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 22, 2021 at 6:47 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Vinicius Costa Gomes reported [0] that build fails when
> CONFIG_DEBUG_INFO_BTF is enabled and CONFIG_BPF_SYSCALL is disabled.
> This leads to btf.c not being compiled, and then no symbol being present
> in vmlinux for the declarations in btf.h. Since BTF is not useful
> without enabling BPF subsystem, disallow this combination.
>
> However, theoretically disabling both now could still fail, as the
> symbol for kfunc_btf_id_list variables is not available. This isn't a
> problem as the compiler usually optimizes the whole register/unregister
> call, but at lower optimization levels it can fail the build in linking
> stage.
>
> Fix that by adding dummy variables so that modules taking address of
> them still work, but the whole thing is a noop.
>
>   [0]: https://lore.kernel.org/bpf/20211110205418.332403-1-vinicius.gomes@intel.com
>
> Fixes: 14f267d95fe4 ("bpf: btf: Introduce helpers for dynamic BTF set registration")
> Reported-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>
