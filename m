Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA252FA74D
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 18:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405768AbhARRTX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 12:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393592AbhARRSO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jan 2021 12:18:14 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B816BC061574;
        Mon, 18 Jan 2021 09:17:31 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id q2so32525962iow.13;
        Mon, 18 Jan 2021 09:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dn0ytLTJxb3OwEjsd6jBPmWuzBnw0hCPCVvXeaDxuoM=;
        b=bW39eLT1IHoKEwm6HWNf9AYzqhTi/mZ9+2fxn14xHZqSISYUhPG1T66wiuaCyBA5DN
         TsxjDHxI1/md/D5Vn382HXRXKk+Oor2cGSuvMbp2TipohpXJBBMci3xyospVygPn2qvM
         1YyQIjDJOWKuVi+ZjAjRAXwFSmBVQETa1X7gyWxH+AwL3NR+bVyt2AbZJgOnboAZYMBa
         LMKD+74Jd0g5KLEbU0Dn2gc/ffGbyfvQ1mhI0p98o/5EXRmTpkHr+i7vWNQsdoEY1vZR
         9f9wn0byiDn5oWYBZVCKVKaaZjpWlJ0qFqN85xE3Zhsei9aGBvffUyTJHm9hQJeWETXe
         B79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dn0ytLTJxb3OwEjsd6jBPmWuzBnw0hCPCVvXeaDxuoM=;
        b=Q+vZSqtFBgXAc47OOcTXWDblnlyciCr/PqgvngM082aTSmgkE/92DlFd5T8RqpZJA4
         gKmOyDBX3iIxFqi1XhUVJ7qYnFm9TznZcJy/9C5hhv/NfMHjg/p1buQn96M5plGhK6u6
         cNOU0Z/x37R2lpI46grC4j4J+za1tuioNsh1Mm95iZvZvOPamHzFxj/nVJWSoADEx645
         yRSsbyb04e1hn7OpvStK/LHuwqT+Yp6cMAfplLXq3kAjvq6KS1Le7k9kTrZrlmSqZT+d
         pDiCliHz5wPKxgIwaagj2TLv8GSAFJZlQgch3OgqwQVrRPeeAEzR1XOOFqq97A0FOGfs
         /n+A==
X-Gm-Message-State: AOAM533+8sUCy8XhUGWNKOEyXmEjlvfVBuxXNI2WWzV/gQkCrnW79g8X
        FeocVw5W2lmQH1sfvPx9wBFIesoQfiZONnXc8YU=
X-Google-Smtp-Source: ABdhPJzcUMSmuR1YTHcA+Buc14hJEvL+YlCWjM0Gogttu3Wpgh2Gp6wGvuB6yNeYTHq3jV0fZ9BgCoRq8ApZ56Cy1m0=
X-Received: by 2002:a05:6e02:1aa8:: with SMTP id l8mr192128ilv.251.1610990250995;
 Mon, 18 Jan 2021 09:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20210118155735.532663-1-jackmanb@google.com> <20210118155735.532663-2-jackmanb@google.com>
In-Reply-To: <20210118155735.532663-2-jackmanb@google.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 18 Jan 2021 18:17:20 +0100
Message-ID: <CAKXUXMytdMUT5FVtn=L4naMmbq14FXUEFqRTu3323ARKomJRJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] docs: bpf: Fixup atomics markup
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 18, 2021 at 4:59 PM Brendan Jackman <jackmanb@google.com> wrote:
>
> This fixues up the markup to fix a warning, be more consistent with

s/fixues/fixes/ ?

> use of monospace, and use the correct .rst syntax for <em> (* instead
> of _).
>

> NB this conflicts with Lukas' patch at [1], which just fixes the
> warning. The scope of this one is a little broader.
>
> [1] https://lore.kernel.org/bpf/CA+i-1C3cEXqxcXfD4sibQfx+dtmmzvOzruhk8J5pAw3g5v=KgA@mail.gmail.com/T/#t
>
As I wrote in my patch, I did minimal changes. Your bit more extensive
changes make sense.

I suggest dropping this comment above starting from NB and the link;
it is not relevant for the history. You can of course move it below
the "---"; so it is not picked up into the git history.

Other than that:

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>


> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  Documentation/networking/filter.rst | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
> index f6d8f90e9a56..4c2bb4c6364d 100644
> --- a/Documentation/networking/filter.rst
> +++ b/Documentation/networking/filter.rst
> @@ -1048,12 +1048,12 @@ Unlike classic BPF instruction set, eBPF has generic load/store operations::
>  Where size is one of: BPF_B or BPF_H or BPF_W or BPF_DW.
>
>  It also includes atomic operations, which use the immediate field for extra
> -encoding.
> +encoding::
>
>     .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) += src_reg
>     .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
>
> -The basic atomic operations supported are:
> +The basic atomic operations supported are::
>
>      BPF_ADD
>      BPF_AND
> @@ -1066,12 +1066,12 @@ memory location addresed by ``dst_reg + off`` is atomically modified, with
>  immediate, then these operations also overwrite ``src_reg`` with the
>  value that was in memory before it was modified.
>
> -The more special operations are:
> +The more special operations are::
>
>      BPF_XCHG
>
>  This atomically exchanges ``src_reg`` with the value addressed by ``dst_reg +
> -off``.
> +off``. ::
>
>      BPF_CMPXCHG
>
> @@ -1081,18 +1081,19 @@ before is loaded back to ``R0``.
>
>  Note that 1 and 2 byte atomic operations are not supported.
>
> -Except ``BPF_ADD`` _without_ ``BPF_FETCH`` (for legacy reasons), all 4 byte
> +Except ``BPF_ADD`` *without* ``BPF_FETCH`` (for legacy reasons), all 4 byte
>  atomic operations require alu32 mode. Clang enables this mode by default in
>  architecture v3 (``-mcpu=v3``). For older versions it can be enabled with
>  ``-Xclang -target-feature -Xclang +alu32``.
>
> -You may encounter BPF_XADD - this is a legacy name for BPF_ATOMIC, referring to
> -the exclusive-add operation encoded when the immediate field is zero.
> +You may encounter ``BPF_XADD`` - this is a legacy name for ``BPF_ATOMIC``,
> +referring to the exclusive-add operation encoded when the immediate field is
> +zero.
>
> -eBPF has one 16-byte instruction: BPF_LD | BPF_DW | BPF_IMM which consists
> +eBPF has one 16-byte instruction: ``BPF_LD | BPF_DW | BPF_IMM`` which consists
>  of two consecutive ``struct bpf_insn`` 8-byte blocks and interpreted as single
>  instruction that loads 64-bit immediate value into a dst_reg.
> -Classic BPF has similar instruction: BPF_LD | BPF_W | BPF_IMM which loads
> +Classic BPF has similar instruction: ``BPF_LD | BPF_W | BPF_IMM`` which loads
>  32-bit immediate value into a register.
>
>  eBPF verifier
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
