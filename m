Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C01045E850
	for <lists+bpf@lfdr.de>; Fri, 26 Nov 2021 08:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352718AbhKZHS1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 02:18:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344570AbhKZHQ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Nov 2021 02:16:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFA5E6113E
        for <bpf@vger.kernel.org>; Fri, 26 Nov 2021 07:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637910794;
        bh=o2v9fmDMOqpSdyggk6UD2TAwohOHz62w/y06jir1RaE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IKoXk4UJL/jsdVxoHTjI/7619gY4Ixk2JdVCzhIJz9G8cCDwpft9e0w3cVl9l+dU3
         XJB6v61qB1hMb+gfSuehryeJtY5BDzLuidCWpl7shmwAOR+FRGKCmevC6BIAq7ApRy
         9o40gC4o38QyyG82+tI4M5NnHInY9hWf1VY1t2ERiBDzxIgchmB2oSj87ouJp6TJMe
         MuqDPxv9mC8diynixqIm3gaL6n08/LLrul5+7EGmULzrzKI0MSOgK+g/+b3FJAw2gU
         X5GXD9SddBeqNv0sqG+Aubg2Ui3/WuUS+jvcGqeOBbyT5FNk6ZvX5brBSQPaA5IeuA
         A9rieUV5ok05g==
Received: by mail-yb1-f173.google.com with SMTP id f186so17786223ybg.2
        for <bpf@vger.kernel.org>; Thu, 25 Nov 2021 23:13:14 -0800 (PST)
X-Gm-Message-State: AOAM532ITj+EWj+EsOR91lIkeOShkZJ3btZa6OEKnPLjBps2DKIDq18g
        9PuaIjSskAOwF14AFOiEk69TwD1y1aZ/ayMtbwE=
X-Google-Smtp-Source: ABdhPJzaKaFQ9Uj9HZulWibqi/vYL5a1o0+bDjIgpdjNnr5hjOeyzdObbfL7NRv/jN8DlkGJ3RiXzieEFBKlwFpzuj8=
X-Received: by 2002:a25:348b:: with SMTP id b133mr12247661yba.251.1637910794152;
 Thu, 25 Nov 2021 23:13:14 -0800 (PST)
MIME-Version: 1.0
References: <20211122144742.477787-1-memxor@gmail.com> <20211122144742.477787-3-memxor@gmail.com>
In-Reply-To: <20211122144742.477787-3-memxor@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 25 Nov 2021 23:13:03 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5EhPbLasFXA=DA5TD2AN5yNYpd3cyaNr6au2_nLFwhXw@mail.gmail.com>
Message-ID: <CAPhsuW5EhPbLasFXA=DA5TD2AN5yNYpd3cyaNr6au2_nLFwhXw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/3] bpf: Fix bpf_check_mod_kfunc_call for built-in modules
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 22, 2021 at 6:47 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> When module registering its set is built-in, THIS_MODULE will be NULL,
> hence we cannot return early in case owner is NULL.
>
> Fixes: 14f267d95fe4 ("bpf: btf: Introduce helpers for dynamic BTF set registration")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>
