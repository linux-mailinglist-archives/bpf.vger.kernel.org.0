Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B143431C365
	for <lists+bpf@lfdr.de>; Mon, 15 Feb 2021 22:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhBOVGM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 16:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhBOVGM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Feb 2021 16:06:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 209D264DEC
        for <bpf@vger.kernel.org>; Mon, 15 Feb 2021 21:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613423131;
        bh=A20PgnnuCMhnn2Truneu7uwbSyHxh2baTg/cQ48ZEZE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r4Mgb+czvTDsK6uujmUID8xq6utiaIBdH0lKvcNkL9IgPwhIdb6rq6awsMLAwxCCG
         Wk5H936k4i2lmafxCFVG/Wndad3PTRHJ1gTSy+DtIBa6mNS6qmvbTb7Iw92a6EDijW
         plsG/BwB8y7eDBoWb3YGAbxvKu2fp+z2UtfnoIt4XBrQb7secvWoaJFFClcfIo8om5
         ks4DkT6ToiEaKb/mnGhyhaqerh2uf3Q4P2W6tEb3Q2ODJiVRwJZp20YpCiD0swU0mK
         Q7z6DsRT8pkxzSIege9r0VwFdlsavn9RtfFlO+iXZOHFbi6qKIKsZsdGn1Onx+qKvo
         NaStSka3ExWRg==
Received: by mail-lf1-f54.google.com with SMTP id u25so12661166lfc.2
        for <bpf@vger.kernel.org>; Mon, 15 Feb 2021 13:05:31 -0800 (PST)
X-Gm-Message-State: AOAM533n6XBHF/Ux2zQI3fR41p8sP2e2NVxm3b72iVsbzo1yrx/YjxZ/
        xs8+MET22jB4BmRFEG3iTG5x5mOFS2vL0ZS8MJmjYg==
X-Google-Smtp-Source: ABdhPJwN0yuMpVrt1WujdmZTZ9oY4OBFDb703sE26vAlASLdTMSQ8pudm+5IvyZpCiR3ODOZp7j4rISNHI6bpI54u9Q=
X-Received: by 2002:a19:48c2:: with SMTP id v185mr9667287lfa.375.1613423129499;
 Mon, 15 Feb 2021 13:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20210215171208.1181305-1-jackmanb@google.com>
In-Reply-To: <20210215171208.1181305-1-jackmanb@google.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 15 Feb 2021 22:05:18 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5GEj7BsGe=s=LkL4ySnvjPP0Sa6P6eEvuQFB+0HDHR8Q@mail.gmail.com>
Message-ID: <CACYkzJ5GEj7BsGe=s=LkL4ySnvjPP0Sa6P6eEvuQFB+0HDHR8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: x86: Explicitly zero-extend rax after
 32-bit cmpxchg
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 15, 2021 at 6:12 PM Brendan Jackman <jackmanb@google.com> wrote:
>
> As pointed out by Ilya and explained in the new comment, there's a
> discrepancy between x86 and BPF CMPXCHG semantics: BPF always loads
> the value from memory into r0, while x86 only does so when r0 and the
> value in memory are different.
>
> At first this might sound like pure semantics, but it makes a real
> difference when the comparison is 32-bit, since the load will
> zero-extend r0/rax.
>
> The fix is to explicitly zero-extend rax after doing such a CMPXCHG.
>
> Note that this doesn't generate totally optimal code: at one of
> emit_atomic's callsites (where BPF_{AND,OR,XOR} | BPF_FETCH are

I think this should be okay and was also suggested by Alexei in:

https://lore.kernel.org/bpf/CAADnVQ+gnQED7WYAw7Vmm5=omngCKYXnmgU_NqPUfESBerH8gQ@mail.gmail.com/

> implemented), the new mov is superfluous because there's already a
> mov generated afterwards that will zero-extend r0. We could avoid
> this unnecessary mov by just moving the new logic outside of
> emit_atomic. But I think it's simpler to keep emit_atomic as a unit
> of correctness (it generates the correct x86 code for a certain set
> of BPF instructions, no further knowledge is needed to use it
> correctly).
>
> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Thanks for fixing this!

Acked-by: KP Singh <kpsingh@kernel.org>
