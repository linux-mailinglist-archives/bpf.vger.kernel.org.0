Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F1F2F1C23
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 18:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbhAKRUZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 12:20:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729496AbhAKRUY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 12:20:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9FAD22B30
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 17:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610385584;
        bh=b0SRj+b4lLKqj36q8bZB3iVso9InQRVtTa5b2Kmjiek=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IsNJPFKuPKxMcmrxHExMN/x0MebTWBPZON49tVGNSFGxZZjjeaRlNeCKt6qK2bqHh
         EQOp1Za0nEZGIVtQTyetkRqJJbGJ2OgtUBfduX/v/F2Mx5rhXUXduHFUbKhTRENQB+
         Z5jHOex3T2r5s6oGm8YAZlXr65AUBA0Y8vqIJyNDy+F6g8DFult/N8bSaOZFI3KdZX
         uUX6cd4z6YDCM6yVHB6TzyzJtu9pomVFS5r9yJ43t1DHI19VauU59EUKRLz6fbBqOC
         uMkg+OvotJ0ng2JGrSI9hnPUNDfWQ0OPDlD7gbaM5sylB5ll/xe+sEw8a3e2+OXhYm
         2kUfQWUCoplbg==
Received: by mail-lj1-f180.google.com with SMTP id x23so16254lji.7
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 09:19:43 -0800 (PST)
X-Gm-Message-State: AOAM530Dtb5vrduzNtvV95R0B0ux2KX5PX8aJOp6os5AMk8du8P5iScQ
        tdkIK7hcOjvazQ9SGaVBGrUzJJazZL/VJQTujqCbFg==
X-Google-Smtp-Source: ABdhPJzvfcrKxYLpgrV8pFFkJ0ybwSH80rbbHJZOCXZn3Fm7CQQKiUVhFdlFc3xt0qFEhlz69GD23FA31l+7S+9dbps=
X-Received: by 2002:a2e:870d:: with SMTP id m13mr214810lji.136.1610385581902;
 Mon, 11 Jan 2021 09:19:41 -0800 (PST)
MIME-Version: 1.0
References: <20210107173729.2667975-1-kpsingh@kernel.org> <CAEf4BzbxVtR+kaTFyHiH0tz3npr_vnpOidmG=t4sQAtaNE95UA@mail.gmail.com>
 <CAEf4BzYjSYBTocYAWv1FDiyRFTmy_XqcE-DvZfZw5K2qoL9Z+Q@mail.gmail.com>
 <CACYkzJ7OCLAfg2OAnvpvexHpaQ8MzntibE79Gf18V++Nc1O0PA@mail.gmail.com> <281d55ae-984d-5a40-e0be-3a3480564379@iogearbox.net>
In-Reply-To: <281d55ae-984d-5a40-e0be-3a3480564379@iogearbox.net>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 11 Jan 2021 18:19:31 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4_J=A9mDnaxZhNtDYSawW8g5cqfKHHVQjD-MmF89Q=nw@mail.gmail.com>
Message-ID: <CACYkzJ4_J=A9mDnaxZhNtDYSawW8g5cqfKHHVQjD-MmF89Q=nw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: local storage helpers should check nullness of
 owner ptr passed
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Gilad Reti <gilad.reti@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 11, 2021 at 3:07 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 1/7/21 9:25 PM, KP Singh wrote:
> > On Thu, Jan 7, 2021 at 8:15 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >> On Thu, Jan 7, 2021 at 11:07 AM Andrii Nakryiko
> >> <andrii.nakryiko@gmail.com> wrote:
> >>> On Thu, Jan 7, 2021 at 9:37 AM KP Singh <kpsingh@kernel.org> wrote:
> >>>>
> >>>> The verifier allows ARG_PTR_TO_BTF_ID helper arguments to be NULL, so
> >>>> helper implementations need to check this before dereferencing them.
> >>>> This was already fixed for the socket storage helpers but not for task
> >>>> and inode.
> >>>>
> >>>> The issue can be reproduced by attaching an LSM program to
> >>>> inode_rename hook (called when moving files) which tries to get the
> >>>> inode of the new file without checking for its nullness and then trying
> >>>> to move an existing file to a new path:
> >>>>
> >>>>    mv existing_file new_file_does_not_exist
> >>>
> >>> Seems like it's simple to write a selftest for this then?
> >
> > Sure, I will send in a separate patch for selftest and also for the typo.
>
> If it's small or trivial to add a selftest for the fix, I'd suggest to add it
> as part of this series for 'ease of logistics' as it would otherwise be a bit
> odd to i) either have a stand-alone patch against bpf tree with just a selftest
> or ii) having to wait until bpf syncs into bpf-next and then send one against
> bpf-next where for the latter there's risk that it gets forgotten in meantime
> as it might take a while.

Sounds good, I completely missed the fact the fix would take some time to
sync from bpf to bpf-next and until then the selftest will keep crashing.

I updated the selftest and will send in a v2 and while we are at it,
will also fix
the typo Andrii found.

- KP

>
> Thanks,
> Daniel
