Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1BD49AD36
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 08:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442392AbiAYHKk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 02:10:40 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54032 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442405AbiAYHIP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 02:08:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BFE87CE1764;
        Tue, 25 Jan 2022 07:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D93C340E6;
        Tue, 25 Jan 2022 07:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643094477;
        bh=u4sZb43o6v9pvDvs7BsPPpiWoB/VBKMPiOOl3tPLaEs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GftWM3c1oIqLFALD23owKTErEZfdczcMT8uVPxGLP1FOkBmR1KtCfQlDYB8d6riL8
         DPO4fVeV5rN4oKIV/NGuFFriOPq0d9MNMXrycCIeRnZtIDSC888/FqYqeJAd1loBtA
         hXx+UyrWJRWu5z0Liq3idU4Acw4Krc4kyOXxUymIUCtW2CeSt/my0j5CtcpE11hz82
         efA+jIDbZ5nwan6om754XfkbxhyZ1x7WanhNeGUoHS6K4izmm/GuBYsh/FFkJyAM+d
         4eJsnOwPf+hR2epbDvchWReD02znUZ4KI+EtbSobJIn5nlYbvmni6AuNhx6MRAVv3e
         3cd7v/zi0KY/A==
Received: by mail-yb1-f169.google.com with SMTP id r65so55267861ybc.11;
        Mon, 24 Jan 2022 23:07:57 -0800 (PST)
X-Gm-Message-State: AOAM532Eymuk8g76qQJeJ6llUNBNDzuA8/8PA7ajb2YILHgMD/VEIpmI
        9+2GPoYApt17FypcDiJAlIx31dcZcOAgMwd6Ajk=
X-Google-Smtp-Source: ABdhPJxhRopogeep+UB2H+4fwzAnBfxW+obMKHyynYJuQjl+/u9U0011KEHGoECdFaAAZ+09H1f4CSH4mTvEV+mXA4s=
X-Received: by 2002:a25:fd6:: with SMTP id 205mr29018898ybp.654.1643094475930;
 Mon, 24 Jan 2022 23:07:55 -0800 (PST)
MIME-Version: 1.0
References: <CA+khW7gh=vO8m-_SVnwWwj7kv+EDeUPcuWFqebf2Zmi9T_oEAQ@mail.gmail.com>
In-Reply-To: <CA+khW7gh=vO8m-_SVnwWwj7kv+EDeUPcuWFqebf2Zmi9T_oEAQ@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 24 Jan 2022 23:07:45 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7F4KritXPXixoPSw4zbCsqpfZaYBuw5BgD+KKXaoeGxg@mail.gmail.com>
Message-ID: <CAPhsuW7F4KritXPXixoPSw4zbCsqpfZaYBuw5BgD+KKXaoeGxg@mail.gmail.com>
Subject: Re: [Question] How to reliably get BuildIDs from bpf prog
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Blake Jones <blakejones@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Namhyung Kim <namhyung@google.com>,
        Ian Rogers <irogers@google.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 24, 2022 at 2:43 PM Hao Luo <haoluo@google.com> wrote:
>
> Dear BPF experts,
>
> I'm working on collecting some kernel performance data using BPF
> tracing prog. Our performance profiling team wants to associate the
> data with user stack information. One of the requirements is to
> reliably get BuildIDs from bpf_get_stackid() and other similar helpers
> [1].
>
> As part of an early investigation, we found that there are a couple
> issues that make bpf_get_stackid() much less reliable than we'd like
> for our use:
>
> 1. The first page of many binaries (which contains the ELF headers and
> thus the BuildID that we need) is often not in memory. The failure of
> find_get_page() (called from build_id_parse()) is higher than we would
> want.

Our top use case of bpf_get_stack() is called from NMI, so there isn't
much we can do. Maybe it is possible to improve it by changing the
layout of the binary and the libraries? Specifically, if the text is
also in the first page, it is likely to stay in memory?

> 2. When anonymous huge pages are used to hold some regions of process
> text, build_id_parse() also fails to get a BuildID because
> vma->vm_file is NULL.

How did the text get in anonymous memory? I guess it is NOT from JIT?
We had a hack to use transparent huge page for application text. The
hack looks like:

"At run time, the application creates an 8MB temporary buffer and the
hot section of the executable memory is copied to it. The 8MB region in
the executable memory is then converted to a huge page (by way of an
mmap() to anonymous pages and an madvise() to create a huge page), the
data is copied back to it, and it is made executable again using
mprotect()."

If your case is the same (or similar), it can probably be fixed with
CONFIG_READ_ONLY_THP_FOR_FS, and modified user space.

Thanks,
Song
