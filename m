Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCCD31D5E4
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 08:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhBQHww (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 02:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhBQHwu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 02:52:50 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC39C061574
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 23:52:04 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id y15so10482345ilj.11
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 23:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCP2pMlxw/m8K2kxtjw9v1AkINyw4fBxpsjibYuDB9A=;
        b=Di+mD5IGMbgNQVafBwIEMK35LYDTbNP/21Ru6SLubzeQck8NvDzuT87cKm31rKUR1k
         0zKVXC+aL68RulfCCpFOBbriCY2be4zQvdyVvwTQ/CE5P4u9kvmlqW/j9ZGbISjPiDaD
         CZX44QxYtqfqmgrsrlO3G83vICNB9ooJ6y807aESFh0bRWh4uZhU5QN2YDldZnLrCrPZ
         r87c4tItY3wD1RZ48DtXKH3gxfygy6SX7H9uJDhLrcKvErQgko04S/cv28CDpnaL4EUX
         nE3EzuRdY1QmXIryAdi+0ZGyWkuKiU2QIacGO4q/R06+TsvQS+PTcAswQDY3fkvatJR0
         fYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCP2pMlxw/m8K2kxtjw9v1AkINyw4fBxpsjibYuDB9A=;
        b=pB5+bR4Cb9gun7B7vtGrAVnorlh+OZKcw9x3bSK210vcXO9URbWMt1VTfQo8ZIY0EX
         SM7ZBwetH84uAvKS385sEbeq6DGeaSY3QDz8O5Fb8KhvB7y8CM1E2KKlrV3nWiFzj9Ig
         U6ZlcLIbIT8dQWRQeWp7+euKZFCL0YsgY6SYlxfwGu8TDq2+qcKR/Zazyn4FGgqf/p5+
         t43gArykRLi6KC9kOU/1Q4E7ZTUXshhm2btwEfDX8Ycz2p0m+JdSYMKOedYKqsiLi6Vu
         XB2cpmtmYXCt4FxYfjPp2hbUNkFUHLQfu6BGHsdydX2eO0aPeZTUhH5MCWnnENdBYq3r
         fQHQ==
X-Gm-Message-State: AOAM531NEa2G9cBTyocXyQnH40yIhPehBTgt+Q7IUDLAeQCImhZa25P4
        Q8yhvvSE8fa3WakaajDwbjik3rRNoASli3buO9iIQA==
X-Google-Smtp-Source: ABdhPJyhqLBcKIYzBqsZD/kMT8jCtpevgsSv2DLyDd//IaABYCiBa/rcDOnY0UyaiAefJ9Bh84VmQcU/DJpW2IeLXbM=
X-Received: by 2002:a92:d245:: with SMTP id v5mr19597975ilg.52.1613548323231;
 Tue, 16 Feb 2021 23:52:03 -0800 (PST)
MIME-Version: 1.0
References: <20210216141925.1549405-1-jackmanb@google.com> <7bcfe4bfd5a2c4768fb07908b709e10ec089903b.camel@linux.ibm.com>
In-Reply-To: <7bcfe4bfd5a2c4768fb07908b709e10ec089903b.camel@linux.ibm.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Wed, 17 Feb 2021 08:51:52 +0100
Message-ID: <CA+i-1C2SFnR6=qEazJ66NkhgNYMaSCa3YTRqj6vdvEyMgjEg+A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit cmpxchg
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 16 Feb 2021 at 20:55, Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Tue, 2021-02-16 at 14:19 +0000, Brendan Jackman wrote:
> > As pointed out by Ilya and explained in the new comment, there's a
> > discrepancy between x86 and BPF CMPXCHG semantics: BPF always loads
> > the value from memory into r0, while x86 only does so when r0 and the
> > value in memory are different. The same issue affects s390.
> >
> > At first this might sound like pure semantics, but it makes a real
> > difference when the comparison is 32-bit, since the load will
> > zero-extend r0/rax.
> >
> > The fix is to explicitly zero-extend rax after doing such a
> > CMPXCHG. Since this problem affects multiple archs, this is done in
> > the verifier by patching in a BPF_ZEXT_REG instruction after every
> > 32-bit cmpxchg. Any archs that don't need such manual zero-extension
> > can do a look-ahead with insn_is_zext to skip the unnecessary mov.
> >
> > Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> >
> > Difference from v1[1]: Now solved centrally in the verifier instead
> > of
> >   specifically for the x86 JIT. Thanks to Ilya and Daniel for the
> > suggestions!
> >
> > [1]
> > https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t
> >
> >  kernel/bpf/verifier.c                         | 36
> > +++++++++++++++++++
> >  .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25 +++++++++++++
> >  .../selftests/bpf/verifier/atomic_or.c        | 26 ++++++++++++++
> >  3 files changed, 87 insertions(+)
>
> I tried this with my s390 atomics patch, and it's working, thanks!
>
> I was thinking whether this could go through the existing zext_dst
> flag infrastructure, but it probably won't play too nicely with the
> x86_64 JIT, which doesn't override bpf_jit_needs_zext().

Ah right, I actually didn't understand what the
opt_subreg_zext_lo32_rnd_hi32 was doing until now so didn't consider
this.

But yeah I think cmpxchg is properly special here because the zext is
sometimes (e.g. on x86_64) needed even on architectures that don't
_generally_ need explicit zext.

I think I'll update some comments to reflect these learnings, thanks.

> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
>
> [...]
>
