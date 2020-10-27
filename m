Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2330B29CD67
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 02:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgJ1BiR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 21:38:17 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34493 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832983AbgJ0XN7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 19:13:59 -0400
Received: by mail-yb1-f195.google.com with SMTP id o70so2696614ybc.1;
        Tue, 27 Oct 2020 16:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvzvO7UkHoLp6bkIPJxnSFNtgIvr1KOH0hJqM4unTfU=;
        b=qUkPq7ZFhFzs5LR9U3fMl8D2fYy1FHRHMtvMek7LFrY+nt102d/1MLVT+ef0GeuHV/
         FmFlKDpPHWtKi37j/2IZMn+onQjR+pe1+pNCyjeCGMhgeadkHn90/PRwUHCooF4qYhBA
         LW/PKmeSMqm/bhlITIvyprPKCzr/n+l+fmmLgBmOQIY3G2FrghvcgFHtSI43lzEQ0WLI
         29yixOV8iPE69GCUQh+JPEqvGiSLaVrK6xjsol0xIMQ2XoTFbNZdLC90/l9rrrRLs35W
         zb4THAplZ8HwP2ORjBy9/uev8EEOKt1qY6kgagJWpGw6V4dJCS8CJdZclrOD+f0XfLmr
         +HAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvzvO7UkHoLp6bkIPJxnSFNtgIvr1KOH0hJqM4unTfU=;
        b=AtIvAuwO3gBUytTnbUb+c3QyNX535Ay+QjA8i39qHPcrh2C//fR6EUJmP9Lw3Ifk6U
         gCXBVYZswJSIbfnhUxYrrAJVVtKkv5HF5drA4Mwd/b+tOhyxmWUlSYr7lY8ESHex4jgC
         VMfQ9Ge8auLKmnpI33I3n5IGfIlKdlX0/97nyUw10c2kfQPDiwaj1vLVD/FGnad9kfur
         ZfwFeFc+b9ZwmdPG3oDtqn7jbNgPra11BunH6zZuz0kwy43qd3kQrLgxPfqEcn7eJ8rV
         2mfdBXotaKSEFS2TzOCeNRPo08OY+dwcFUO6eE1WC95ObtAsk8Q3alQOK84sNzugZFCH
         meAQ==
X-Gm-Message-State: AOAM53131wqJz+OKZX5fduZ0mlsOx5CR1kKvL9BB9SZkpvRuTLlsw+de
        3RDNEqKgZoihAE2V0zQmN0OiMs8TiC8PvP9pfB9ruvhTlnY=
X-Google-Smtp-Source: ABdhPJwDgezAymWsWLijEuobwRZR53nnskYQalpDevRQvH5gaTo0V6JQUBYQv20WtCWPbcH9GYaIjYsaU/t4Z/ShYfk=
X-Received: by 2002:a25:cb10:: with SMTP id b16mr6836946ybg.459.1603840437584;
 Tue, 27 Oct 2020 16:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201026223617.2868431-1-jolsa@kernel.org>
In-Reply-To: <20201026223617.2868431-1-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Oct 2020 16:13:46 -0700
Message-ID: <CAEf4Bzav_WF3duq4JYmaPvyUXdREkXJMPAb+ASUxAxq_mqXd5Q@mail.gmail.com>
Subject: Re: [RFC 0/3] pahole: Workaround dwarf bug for function encoding
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 26, 2020 at 5:07 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> because of gcc bug [1] we can no longer rely on DW_AT_declaration
> attribute to filter out declarations and end up with just
> one copy of the function in the BTF data.
>
> It seems this bug is not easy to fix, but regardless if the
> it's coming soon, it's probably good idea not to depend so
> much only on dwarf data and make some extra checks.
>
> Thus for function encoding we are now doing following checks:
>   - argument names are defined for the function
>   - there's symbol and address defined for the function
>   - function is generated only once
>
> These checks ensure that we encode function with defined
> symbol/address and argument names.
>
> I marked this post as RFC, because with this workaround in
> place we are also encoding assembly functions, which were
> not present when using the previous gcc version.
>
> Full functions diff to previous gcc working version:
>
>   http://people.redhat.com/~jolsa/functions.diff.txt
>
> I'm not sure this does not break some rule for functions in
> BTF data, becuse those assembly functions are not attachable
> by bpf trampolines, so I don't think there's any use for them.

What will happen if we do try to attach to those assembly functions?
Will there be some corruption or crash, or will it just fail and
return error cleanly? What we actually want in BTF is all the
functions that are attachable through BPF trampoline, which is all the
functions that ftrace subsystem can attach to, right? So how does
ftrace system know what can or cannot be attached to?

>
> thoughts?
> jirka
>
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060
> ---
> Jiri Olsa (3):
>       btf_encoder: Move find_all_percpu_vars in generic config function
>       btf_encoder: Change functions check due to broken dwarf
>       btf_encoder: Include static functions to BTF data
>
>  btf_encoder.c | 221 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
>  elf_symtab.h  |   8 +++++
>  2 files changed, 170 insertions(+), 59 deletions(-)
>
