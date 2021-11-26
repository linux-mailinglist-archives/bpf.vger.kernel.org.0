Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962DE45E890
	for <lists+bpf@lfdr.de>; Fri, 26 Nov 2021 08:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359300AbhKZHnB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 02:43:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:48644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244165AbhKZHlB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Nov 2021 02:41:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0542161153
        for <bpf@vger.kernel.org>; Fri, 26 Nov 2021 07:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637912269;
        bh=nrs5ypmRjBq49jVUOTKuSotKgSuiWhGmNAKsUJJC8WU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tIcAVxB+fWrCf/RM9auzCjCGl0xLSJtT7VoTE37Z/pOg0bkALirsUGbjyR1fTwJnO
         hi1ghGn1Qqm16+bZGW6iT0+zqI6iTaSdCU4nGfjXoNJ3mCdpiyIuG2jXohs7d16oK9
         UraIJvL3y9GhQxv7oqP5zwm1rLN2/N5tHmT7F7S8SOkFm8cXn4r+6QUv3n8P5TdsvO
         4HqGAwHSY3OrKTaUTmJHkyvap91k5v/rwLd5Jry14He4KzrxICv0BC5D5bso/pHWPK
         QaY4ILfheW2cdfG6ejYl0LzIKJscHRuSWFDdvrGQzfpDV/sn1TLN3jDaazkacfNUd+
         ktNGjQfL4qUSw==
Received: by mail-yb1-f171.google.com with SMTP id v138so17898145ybb.8
        for <bpf@vger.kernel.org>; Thu, 25 Nov 2021 23:37:48 -0800 (PST)
X-Gm-Message-State: AOAM533g014RKLaSZSn+jyaQHr+UBS60tSDEQO9aZxZBjwJgwa5NukLj
        uK0kRFFq/nRos3a7UH/71sDHxhN8GkijcbReHF4=
X-Google-Smtp-Source: ABdhPJzN7wVByynntTNv/aE6ZeMezUcunyEtlf2QN+yaAbOkL+3QWm/7ZUioqWe/fpH7yJB8khfiMXByO5VdNAe2MrY=
X-Received: by 2002:a25:660d:: with SMTP id a13mr13254154ybc.460.1637912268231;
 Thu, 25 Nov 2021 23:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20211122144742.477787-1-memxor@gmail.com> <20211122144742.477787-4-memxor@gmail.com>
In-Reply-To: <20211122144742.477787-4-memxor@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 25 Nov 2021 23:37:37 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7xSdStywDboiQs6HHLmwreSCd9xfJDPOeb9ZUCSvyfHg@mail.gmail.com>
Message-ID: <CAPhsuW7xSdStywDboiQs6HHLmwreSCd9xfJDPOeb9ZUCSvyfHg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 3/3] tools/resolve_btfids: Skip unresolved symbol
 warning for empty BTF sets
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
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
> resolve_btfids prints a warning when it finds an unresolved symbol,
> (id == 0) in id_patch. This can be the case for BTF sets that are empty
> (due to disabled config options), hence printing warnings for certain
> builds, most recently seen in [0].
>
> The reason behind this is because id->cnt aliases id->id in btf_id
> struct, leading to empty set showing up as ID 0 when we get to id_patch,
> which triggers the warning. Since sets are an exception here, accomodate
> by reusing hole in btf_id for bool is_set member, setting it to true for
> BTF set when setting id->cnt, and use that to skip extraneous warning.
>
>   [0]: https://lore.kernel.org/all/1b99ae14-abb4-d18f-cc6a-d7e523b25542@gmail.com
>
> Before:
>
> ; ./tools/bpf/resolve_btfids/resolve_btfids -v -b vmlinux net/ipv4/tcp_cubic.ko
> adding symbol tcp_cubic_kfunc_ids
> WARN: resolve_btfids: unresolved symbol tcp_cubic_kfunc_ids
> patching addr     0: ID       0 [tcp_cubic_kfunc_ids]
> sorting  addr     4: cnt      0 [tcp_cubic_kfunc_ids]
> update ok for net/ipv4/tcp_cubic.ko
>
> After:
>
> ; ./tools/bpf/resolve_btfids/resolve_btfids -v -b vmlinux net/ipv4/tcp_cubic.ko
> adding symbol tcp_cubic_kfunc_ids
> patching addr     0: ID       0 [tcp_cubic_kfunc_ids]
> sorting  addr     4: cnt      0 [tcp_cubic_kfunc_ids]
> update ok for net/ipv4/tcp_cubic.ko
>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Fixes: 0e32dfc80bae ("bpf: Enable TCP congestion control kfunc from modules")
> Reported-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>
