Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69FB41A69D
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 06:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhI1EcP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 00:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhI1EcO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 00:32:14 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C90C061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 21:30:35 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 71so3032919ybe.6
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 21:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jVsunK0nvT4bmDE6cvD+WpEqam0x/JRaupqx5uD0RMk=;
        b=HYiWyi6yjUEJtnat2DBAZOmsUrjtzyevP7OtNs+Wq/VC07pBxZNi1eR7NeIKEfhRcJ
         f8tKQ4CdQrol+Fm6SUKXeExNMFPn9H/sR/04JI3mD3Cv9dIY3j0ssl96OQRxHstj4LxX
         0OYHXcsyjB481vA+1L/7Bfr34FZuVEQeKMAeWDNz+MoRlBwrilJvCd9PllxIU1F4hZA1
         QvlPPIYBb/sEK67y7hL/mqisaI/Kg+xeBPQK+VqXoONgUS7nwhW1nHJky8CeOSi24KBZ
         Cqa9fVSiHNBLT47acbOUBKLTUJicY5q+APNRMrUbt1QIERznmg81O1HnDlKI/QqTPU3w
         KJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jVsunK0nvT4bmDE6cvD+WpEqam0x/JRaupqx5uD0RMk=;
        b=e6sNGWHHcUNASMjbr0nMdBB8TXxdmLSgLad37aORko+bY14/tbenvZCPwTh5HAsadK
         UPCMRv4cv3PugF2Lkma//7VjYbkYKBiSBE0hUVMdgWW3eoYbqFcz/bDzE1toQaiK3qJ0
         7nlIHXFaisIl8YYnysor7p3kZRxrVelYt1+m14yBD9L6S0Z5jR8+AY/oNfgqRUrva/SN
         0774cX3NzVshHSj5sCHZhkSlj7pt3y/bufuzv3pRvlMLlL5gHOEM7O+NkKCPF2W+QkMI
         fAKUImAhKpw5x/iVDeTTaxLPU5fVaz2LmFz5acR61ZhKDzTgvt3j880VIfgc9fbJMGLA
         ds5g==
X-Gm-Message-State: AOAM5330emumZNfewCD0IWeSGV6kB2bjG10ZcsOHd77flSXrMj3HUbvG
        Gx4I+gBG2aHHG8+cPUktqac6G0cCacGJ9LaUKHw=
X-Google-Smtp-Source: ABdhPJxDwTy7zQkTlCGGQVq33B90UbSW6takVEnkd6ESzfOTKSXVEl8NLdxsV0d27g4xmihXbrLR4XoNQK1FlnSmfFs=
X-Received: by 2002:a25:2d4e:: with SMTP id s14mr4048530ybe.2.1632803435205;
 Mon, 27 Sep 2021 21:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210927205810.715656-1-toke@redhat.com>
In-Reply-To: <20210927205810.715656-1-toke@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Sep 2021 21:30:24 -0700
Message-ID: <CAEf4BzbmOKTm1qoOU0kfOjnv0AJxYgqFyu8+Yt-aJ57_E=-Dmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: ignore STT_SECTION symbols in 'maps' section
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 27, 2021 at 1:58 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> When parsing legacy map definitions, libbpf would error out when
> encountering an STT_SECTION symbol. This becomes a problem because some
> versions of binutils will produce SECTION symbols for every section when
> processing an ELF file, so BPF files run through 'strip' will end up with
> such symbols, making libbpf refuse to load them.
>
> There's not really any reason why erroring out is strictly necessary, so
> change libbpf to just ignore SECTION symbols when parsing the ELF.
>
> Cc: Jiri Benc <jbenc@redhat.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---

Applied to bpf-next, thanks.

[...]
