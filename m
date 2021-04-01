Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8391C3522DF
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 00:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhDAWsI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 18:48:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233965AbhDAWsI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Apr 2021 18:48:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DEFB60FE4
        for <bpf@vger.kernel.org>; Thu,  1 Apr 2021 22:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617317287;
        bh=SFgT7a3v8PgbifVt3g22EUdrK0dTjjTxS+JZc332XPk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EIQhdBEZwS/eTdGR6o5sovXZh10ipyU65X/5cD8tVIaMPCDPavOXJIv1KpFh2Fl2b
         uY5s8uOF2AR8uhOByQJ3afB1SL4jqpdYGbErpTYHVp5VGHnzDNngayn+J7jdjkF7q/
         xaXNi0SmRz3HFkNN3+uo3CS0JNAzWDoUL7Yo3Unw2XxaHDtlfV8nJqte9j6od7K7io
         uycDMyj/OlSatwPgvh6ernsT20vEUEBlXeMX1bc8RHIHwyWIXjGUIBLYFmFRA75PcF
         3JddudhZIQjbEpEXRDaRF3nnvQRrwMzPEIPTv5bd5fL4POPKEIzHg/ZW8KB2nntfLt
         O60tMJvikHaCA==
Received: by mail-lf1-f52.google.com with SMTP id m12so5081534lfq.10
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 15:48:07 -0700 (PDT)
X-Gm-Message-State: AOAM530KMV3CHq7iNU6bybBvtqr9ngX1CpQQs2lSZh5AZE2PNf6iCIfK
        By1ybrzeBMZh4UcsKMWy4n/4u2suVxpXWRJiKKI=
X-Google-Smtp-Source: ABdhPJwUsPRGsNz6gOEZrxU1ZxCkdvKtTVW4Ekw0b0OXbFoEOyW6u6DedIqK2dGc5u33UUp6/MOP5i495nzaPZwq7Bw=
X-Received: by 2002:a05:6512:504:: with SMTP id o4mr6577535lfb.438.1617317285894;
 Thu, 01 Apr 2021 15:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <161731595664.74613.1603087410166945302.stgit@john-XPS-13-9370>
In-Reply-To: <161731595664.74613.1603087410166945302.stgit@john-XPS-13-9370>
From:   Song Liu <song@kernel.org>
Date:   Thu, 1 Apr 2021 15:47:54 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4RpdANPWwSv=VBTn+TS-1vF-oc1Xjm=2-baaivFC+_4Q@mail.gmail.com>
Message-ID: <CAPhsuW4RpdANPWwSv=VBTn+TS-1vF-oc1Xjm=2-baaivFC+_4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, selftests: test_maps generating
 unrecognized data section
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 1, 2021 at 3:28 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> With a relatively recent clang master branch test_map skips a section,
>
>  libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
>
> the cause is some pointless strings from bpf_printks in the BPF program
> loaded during testing. After just removing the prints to fix above
> error Daniel points out the program is a bit pointless and could
> be simply the empty program returning SK_PASS.
>
> Here we do just that and return simply SK_PASS. This program is used with
> test_maps selftests to test insert/remove of a program into the sockmap
> and sockhash maps. Its not testing actual functionality of the TCP sockmap
> programs, these are tested from test_sockmap. So we shouldn't lose in
> test coverage and fix above warnings. This original test was added before
> test_sockmap existed and has been copied around ever since, clean it up
> now.
>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>
