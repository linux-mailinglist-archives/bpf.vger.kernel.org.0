Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4E32DBFA5
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 12:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgLPLpi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 06:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgLPLph (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 06:45:37 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD27C061794
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 03:44:57 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id x15so22300150ilq.1
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 03:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/ZlIpaN8xcDIn8bKlAdp8paf+KXXpCzF6s0NyTWF14=;
        b=Q5nIWr6CT1PZPxyJY/xL1sS1xFuq6P0IzKI6Z9O7GmIiB8h1m50Uu+t+wXFBSLDo0u
         s9xyHUenf6wNTYgM8d1q1RMdhUpskmaHxhw+W9HgrUoyOBlMYzRXlYlhWOPUVOkWOo54
         gLBg57k2BPlObdfH2ltq08SZ6e8NpAS/CCoC4wJ7GUWeYAcP8RGjutaTvLUnXOMV5x13
         1gEdOfqMwp5GCLTynmkplYKdsUHwtWQ+Za8oHWl/zts0CV2HdZo94WKXUNk9oZIU5Osx
         I/1jhuYrkUd4Vn83v5tYUHqun4rA9JQIdU6o+dFtCxuGHbcqNAGzuz+0BNzrnV3l5Zmq
         BqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/ZlIpaN8xcDIn8bKlAdp8paf+KXXpCzF6s0NyTWF14=;
        b=RjXFLhhMIdL8vA3VJtXtV2wsEC0+7xIzR41WVXSmfFNRXdcs9faEKXxz+ZbsHtiZMB
         6JHzXE7kAN9GubBUj1RdEQcgfRfmcvQie60jnJ/1YD+gTsaI7v8H0tLvUwMNzgPLm26D
         1TjeERGA5v8To+okbor6467PPWOkiHihaNzc0mRYnvRHjR/Y6mowJMkvVjofA0NsW1AQ
         MiPs/QnY/606WGYm5RLDvcqoHO6Sl9sXWbE4KJDji5KQvT+mIJTvAPL495C1F1Jw4y52
         ddG9u8dcx6teA4b1sGx3wfHjPGSx8uv9jAPD1kzvmTVsuNNYJb1AYqBdIRjsdY2fSQ+7
         W2Fg==
X-Gm-Message-State: AOAM531qZMMa/5vtZ8B9IPNjk6leLM31IQOoIoD0pgEFyT/2W/RFBtxk
        WsyNI8jkeDGmbBR7iFz5sv8qVnLsRB9RHeFEr7gDdg==
X-Google-Smtp-Source: ABdhPJzSCCI6malJksUrOeoVx3K8oV4+R7HDqCAN1A4vRRuK3ZhyjuVf8l2fvI0ancEoOyCP7rpuj78xsGiQRcfJ4S8=
X-Received: by 2002:a92:c26c:: with SMTP id h12mr39048784ild.165.1608119096598;
 Wed, 16 Dec 2020 03:44:56 -0800 (PST)
MIME-Version: 1.0
References: <20201215121816.1048557-1-jackmanb@google.com> <20201215121816.1048557-13-jackmanb@google.com>
 <fcb9335c-000c-0097-7a70-983de271a3b7@fb.com>
In-Reply-To: <fcb9335c-000c-0097-7a70-983de271a3b7@fb.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Wed, 16 Dec 2020 12:44:45 +0100
Message-ID: <CA+i-1C2ddNES0DXoO1L_nrqpK5EtA9xKE1yRGrqSVv0dECZozQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 11/11] bpf: Document new atomic instructions
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 16 Dec 2020 at 08:08, Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 12/15/20 4:18 AM, Brendan Jackman wrote:
> > Document new atomic instructions.
> >
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
>
> Ack with minor comments below.
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---
> >   Documentation/networking/filter.rst | 26 ++++++++++++++++++++++++++
> >   1 file changed, 26 insertions(+)
> >
> > diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
> > index 1583d59d806d..26d508a5e038 100644
> > --- a/Documentation/networking/filter.rst
> > +++ b/Documentation/networking/filter.rst
> > @@ -1053,6 +1053,32 @@ encoding.
> >      .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) += src_reg
> >      .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
> >
> > +The basic atomic operations supported (from architecture v4 onwards) are:
>
> Remove "(from architecture v4 onwards)".

Oops, thanks.

> > +
> > +    BPF_ADD
> > +    BPF_AND
> > +    BPF_OR
> > +    BPF_XOR
> > +
> > +Each having equivalent semantics with the ``BPF_ADD`` example, that is: the
> > +memory location addresed by ``dst_reg + off`` is atomically modified, with
> > +``src_reg`` as the other operand. If the ``BPF_FETCH`` flag is set in the
> > +immediate, then these operations also overwrite ``src_reg`` with the
> > +value that was in memory before it was modified.
> > +
> > +The more special operations are:
> > +
> > +    BPF_XCHG
> > +
> > +This atomically exchanges ``src_reg`` with the value addressed by ``dst_reg +
> > +off``.
> > +
> > +    BPF_CMPXCHG
> > +
> > +This atomically compares the value addressed by ``dst_reg + off`` with
> > +``R0``. If they match it is replaced with ``src_reg``, The value that was there
> > +before is loaded back to ``R0``.
> > +
> >   Note that 1 and 2 byte atomic operations are not supported.
>
> Adding something like below.
>
> Except xadd for legacy reason, all other 4 byte atomic operations
> require alu32 mode.
> The alu32 mode can be enabled with clang flags "-Xclang -target-feature
> -Xclang +alu32" or "-mcpu=v3". The cpu version 3 has alu32 mode on by
> default.

Thanks, I've written it as:

Except ``BPF_ADD`` _without_ ``BPF_FETCH`` (for legacy reasons), all 4
byte atomic operations require alu32 mode. Clang enables this mode by
default in architecture v3 (``-mcpu=v3``). For older versions it can
be enabled with ``-Xclang -target-feature -Xclang +alu32``.

> >
> >   You may encounter BPF_XADD - this is a legacy name for BPF_ATOMIC, referring to
> >
