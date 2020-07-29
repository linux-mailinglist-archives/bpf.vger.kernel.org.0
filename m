Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BED4231858
	for <lists+bpf@lfdr.de>; Wed, 29 Jul 2020 06:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgG2EGp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jul 2020 00:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgG2EGp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jul 2020 00:06:45 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9577C061794
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 21:06:44 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k18so16657923qtm.10
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 21:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjrbHIDB0P43Mp+lVQv4PTBHvpGc15RBv1/D+/lG1LA=;
        b=TQb1SkBVpQBJHYYCSrB+T9wvBmBhWC7kgxTwGkVlgw9UBQkhO0Tj7thQdnl/lZrCIh
         3S8aA/N5Q+7vSeESNw3I3Eb71RzQkUpU0McUth7+KCDZPJ5ZvUeocbGv20D3hQ6Np6jD
         53WENDSD3ESvruymPIvzQ7Azb5rH+bLa+ximCm0xllO19oDozpjtPv1witwLETjDRKLn
         xgXzruepHgf1RbFdDnWBsip9byCJIJ2wQ+REAHg31Z6/0+Wr+My2pt6KvvyvNliizLic
         LYZkCrvENXR13/e6OIu/CXXrE6K7ZX3VuY2FSaw3xc+98N9xBSpua6SFoAp89YMWwe5f
         RKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjrbHIDB0P43Mp+lVQv4PTBHvpGc15RBv1/D+/lG1LA=;
        b=KJCi7o4/XKHQS2SOxBb7A50k/plgidbUfc8K2J5glDQAnLNGiytXmcZnr7DZa4oTw6
         l0RAGI4WIkkDEy6aTXdLGD7WLvLb1otfJkrvIi0laPyo3BOErmnsx6IExY2WHYnAlmKz
         yNzOGa0V55FPhPEUYNSyufdlmhNgLcnDacgK+HNODKgbjFthqAxqy2Iu52oQK7C+VMkH
         BetBtE4QFk03IbAYMSMTCR/dc/UYyAHhIx4/0PVdCSh6qmB/IPzbMAaIAmDKO80tCQYd
         h+Agv1JyK2ZzRyPs+hOi4+F12qnZNXhYuN7WS8TuR9FKX6NiKiIg6cctBvJm/04rZTrk
         I76Q==
X-Gm-Message-State: AOAM531MXA8dFSF8qyXv+vtD1Wucc6heGmI40yO3Wi+0sOVjO7o/eJ4c
        krhmzNYIgUICRLij87bXpL8YHeGUYqXa0qQsw04=
X-Google-Smtp-Source: ABdhPJwZq/72DNwDsMrif/tgbWw3UNYuBLbY9Nwm40NPi+kECX1pUpJ0M5f+d6TL04GRnQBl3REeREub8lJADJWP4wQ=
X-Received: by 2002:aed:2ae2:: with SMTP id t89mr13847899qtd.171.1595995603760;
 Tue, 28 Jul 2020 21:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200728120059.132256-1-iii@linux.ibm.com> <20200728120059.132256-4-iii@linux.ibm.com>
 <CAEf4BzaSJp-fOn2MG_8Fc2mo9ji5gZBLn2xCGyCiAmPbHkqSQQ@mail.gmail.com> <bea74a32-746c-c310-67c8-477dcd442fb3@iogearbox.net>
In-Reply-To: <bea74a32-746c-c310-67c8-477dcd442fb3@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Jul 2020 21:06:32 -0700
Message-ID: <CAEf4BzZtsOF0iuWrtBn7Up2zZFv79PvF5TC1RukBxQBxpN4pFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] libbpf: Use bpf_probe_read_kernel
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 28, 2020 at 2:16 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 7/28/20 9:11 PM, Andrii Nakryiko wrote:
> > On Tue, Jul 28, 2020 at 5:15 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >>
> >> Yet another adaptation to commit 0ebeea8ca8a4 ("bpf: Restrict
> >> bpf_probe_read{, str}() only to archs where they work") that makes more
> >> samples compile on s390.
> >>
> >> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> >
> > Sorry, we can't do this yet. This will break on older kernels that
> > don't yet have bpf_probe_read_kernel() implemented. Met and Yonghong
> > are working on extending a set of CO-RE relocations, that would allow
> > to do bpf_probe_read_kernel() detection on BPF side, transparently for
> > an application, and will pick either bpf_probe_read() or
> > bpf_probe_read_kernel(). It should be ready soon (this or next week,
> > most probably), though it will have dependency on the latest Clang.
> > But for now, please don't change this.
>
> Could you elaborate what this means wrt dependency on latest clang? Given clang
> releases have a rather long cadence, what about existing users with current clang
> releases?

So the overall idea is to use something like this to do kernel reads:

static __always_inline int bpf_probe_read_universal(void *dst, u32 sz,
const void *src)
{
    if (bpf_core_type_exists(btf_bpf_probe_read_kernel))
        return bpf_probe_read_kernel(dst, sz, src);
    else
        return bpf_probe_read(dst, sz, src);
}

And then use bpf_probe_read_universal() in BPF_CORE_READ and family.

This approach relies on few things:

1. each BPF helper has a corresponding btf_<helper-name> type defined for it
2. bpf_core_type_exists(some_type) returns 0 or 1, depending if
specified type is found in kernel BTF (so needs kernel BTF, of
course). This is the part me and Yonghong are working on at the
moment.
3. verifier's dead code elimination, which will leave only
bpf_probe_read() or bpf_probe_read_kernel() calls and will remove the
other one. So on older kernels, there will never be unsupoorted call
to bpf_probe_read_kernel().


The new type existence relocation requires the latest Clang. So the
way to deal with older Clangs would be to just fallback to
bpf_probe_read, if we detect that Clang is too old and can't emit
necessary relocation.

If that's not an acceptable plan, then one can "parameterize"
BPF_CORE_READ macro family by re-defining bpf_core_read() macro. Right
now it's defined as:

#define bpf_core_read(dst, sz, src) \
    bpf_probe_read(dst, sz, (const void *)__builtin_preserve_access_index(src))

Re-defining it in terms of bpf_probe_read_kernel is trivial, but I
can't do it for BPF_CORE_READ, because it will break all the users of
bpf_core_read.h that run on older kernels.


>
> >>   tools/lib/bpf/bpf_core_read.h | 51 ++++++++++++++++++-----------------
> >>   tools/lib/bpf/bpf_tracing.h   | 15 +++++++----
> >>   2 files changed, 37 insertions(+), 29 deletions(-)
> >>
> >
> > [...]
> >
>
