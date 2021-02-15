Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECF631C463
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 00:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBOXbq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 18:31:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhBOXbq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Feb 2021 18:31:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5416264DF0
        for <bpf@vger.kernel.org>; Mon, 15 Feb 2021 23:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613431865;
        bh=CAt0WvZc794t+xPloZixv4ufm0P+v8nmw4Pf4Mw460o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JrFNhpVncxENYNjFv8KYEvnncM53waWnzear6Mni+io+OcmiiaufDoOXoOhjA80xt
         CSDPB3Ab5HuqhtZe6Ud5tNzojMMGARgDuTaQbVJp5SppEeQ2BFazbJG0U1JG5nEgcg
         VZ9uCAcvUUOJnzTSfpF3sImDfDqGDFgz5iswjZlc0uZ2x55vLD8gh5ReX3DRHhpAa3
         FTxCy4xTb4o7p27s/x7iJbu4zjrJvnG1CRLNRKBwY4rqIVl5ibxPM+Wa19ddeDD+OZ
         85g1KRQLjhijXKHC1LQXF+lNWIE/DGa50eRiI1WN8xGaxWsxz7sjcqRn6LS/uFta6Q
         O3O/P/MzEu5mw==
Received: by mail-lf1-f51.google.com with SMTP id m22so13102802lfg.5
        for <bpf@vger.kernel.org>; Mon, 15 Feb 2021 15:31:05 -0800 (PST)
X-Gm-Message-State: AOAM533LkkwanAALR5EpqZ4TvzRUknWj9LJjD0AWSIuIHTLfbhKN6XAC
        MtVM3WH2etLpudHTtf3lzZGuWRXcHQLOcrdJfx8xKA==
X-Google-Smtp-Source: ABdhPJz7BJJRN9xPfZ2d76AkoJg41KRjNIMmtxTPF7fRjV+KWxJHVeghptWWhvHxBkROi1FOqCezYBIOyS31r0+zmDs=
X-Received: by 2002:a19:48c2:: with SMTP id v185mr9946260lfa.375.1613431863636;
 Mon, 15 Feb 2021 15:31:03 -0800 (PST)
MIME-Version: 1.0
References: <20210215171208.1181305-1-jackmanb@google.com> <44912664-5c0b-8d95-de01-c87b1e8a846c@iogearbox.net>
 <b4b116fd53ac14a3006d81ed90069600b3abae4f.camel@linux.ibm.com>
 <725b73b5-be08-f253-165d-e027ec568691@iogearbox.net> <5f7b836cc07980352215a5ad9a959c7e7c47f1cf.camel@linux.ibm.com>
In-Reply-To: <5f7b836cc07980352215a5ad9a959c7e7c47f1cf.camel@linux.ibm.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 16 Feb 2021 00:30:53 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7-P4E71G-Ek_Hm5YQmvmYL_--K1dkm8pUZWbChgdjrfg@mail.gmail.com>
Message-ID: <CACYkzJ7-P4E71G-Ek_Hm5YQmvmYL_--K1dkm8pUZWbChgdjrfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: x86: Explicitly zero-extend rax after
 32-bit cmpxchg
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Brendan Jackman <jackmanb@google.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 15, 2021 at 11:42 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>

[...]

> > > >
> > > > How does the situation look on other archs when they need to
> > > > implement this in future?
> > > > Mainly asking whether it would be better to instead to move this
> > > > logic into the verifier
> > > > instead, so it'll be consistent across all archs.
> > >
> > > I have exactly the same check in my s390 wip patch.
> > > So having a common solution would be great.
> >
> > We do rewrites for various cases like div/mod handling, perhaps would
> > be
> > best to emit an explicit BPF_MOV32_REG(insn->dst_reg, insn->dst_reg)
> > there,
> > see the fixup_bpf_calls().

Agreed, this would be better.

>
> How about BPF_ZEXT_REG? Then arches that don't need this (I think
> aarch64's instruction always zero-extends) can detect this using
> insn_is_zext() and skip such insns.
>

+1
