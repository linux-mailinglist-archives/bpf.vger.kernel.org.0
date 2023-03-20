Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3256C20C2
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 20:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCTTED (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 15:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjCTTDj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 15:03:39 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A96298F3
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 11:56:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cn12so5133350edb.4
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679338548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbMIE9klfZQoGqNb+/ls66kJ7RQs2bHykSzSis+7wpo=;
        b=VNGFfXF8ogMADH28CEgrnC8CUbP9k7QxRJrbwR3zqoDFA5RFwOOE42xajuDU22eIaI
         7EAkdPNzxYuL1x+f+FxoNYmc860rYmvfgh7cC9epAeD5GVJY3vvGqheuXmgeLVV8XMQG
         qm8Mptc6wqH/QiWI+RlncoWRIZ4Vbx6+4IrsNhyMuCz7iQJo716r5B7UFqvkdvNMeVkT
         Rn0ny6umKzBWSmKTZiOX/6lmn8qVJygukayjLouwN/GjoiyZxnVTe6D5i4gUNKmkijlk
         ZkPAwdlAAbBARPYJtGyytD7/FlHP/Otl29ZoBSdvBreZAfD0IlMsM5uN0IfvSKlGo4p1
         vKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679338548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbMIE9klfZQoGqNb+/ls66kJ7RQs2bHykSzSis+7wpo=;
        b=q+kW2F3Yf65yHPpOC4N/FhYtDt/Fx+AeqvCFVp9xBvhCEb6ZdxF/egYDfKQprKvpO9
         0+svgm4uNW+yZ+WYk492w2ySkL6wVzC5O6y8zGAU9ILeNdRdc5ABMAN/g5ipQnrgSi2t
         I+appNdBEwHTxDbCvB5PZLhGXYMjuH25an3wynqwRp6IjK0dNrUq6kH4qVhOR25Dwc6g
         iqGzzPHZsxxi1nIikL+6hBRcyvyPeZv/rWUBKwOjY8iJ1Y3V5CUnBWVN4XifGwpVJ8es
         Mtap4beCO0TtKTuwYqcxphqjJhf588uFlFOra/a4xXrBOnCEIZmW6EFeFijZ9CtH254x
         zirQ==
X-Gm-Message-State: AO0yUKV7wXeSYif+3r4Cemrj88/aYncHIVy8312IukuF1S3n3M1GOLP7
        lA8XkOnOXBWLs0pW0QVaQRQUIMZ2dmuZLn3yU28=
X-Google-Smtp-Source: AK7set+XdQ7q75aXk1q6+8RfQEgzbC4fYLPXugvC7Ch/E9Hd6OIf66i8KKG7OSDnYy2xyVRps2M9Oj2JbWNWyWVxg8c=
X-Received: by 2002:a50:951e:0:b0:4fc:1608:68c8 with SMTP id
 u30-20020a50951e000000b004fc160868c8mr340332eda.1.1679338548265; Mon, 20 Mar
 2023 11:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230317220351.2970665-1-andrii@kernel.org> <20230317220351.2970665-4-andrii@kernel.org>
 <bb0b7006-9a22-df8e-f623-d8a9d3069fc1@iogearbox.net> <CAEf4BzYM8Z1gp4x+tRLE2BFFi9idmuRiTSrHB7cGFA94E2hLmw@mail.gmail.com>
 <CAN+4W8j4Xi2zNx-0QgkRDgyzLFCP+-TqX3NzD=_nuJrD44TK0A@mail.gmail.com>
In-Reply-To: <CAN+4W8j4Xi2zNx-0QgkRDgyzLFCP+-TqX3NzD=_nuJrD44TK0A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 20 Mar 2023 11:55:36 -0700
Message-ID: <CAEf4BzYR4snO+-ntszFj-2kitAzJVi2j+O4+-KOa38g=0YS7cQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: switch BPF verifier log to be a
 rotating log by default
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@kernel.org, kernel-team@meta.com,
        i@lmb.io, timo@incline.eu, alessandro.d@gmail.com,
        Dave Tucker <dave@dtucker.co.uk>,
        =?UTF-8?B?Um9iaW4gR8O2Z2dl?= <robin.goegge@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 20, 2023 at 9:10=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> Hi Andrii!
>
> This is a great idea. Preserving the end of the log is the right thing
> to do, and I agree that it would've been nice to do this from the
> start. Some thoughts on the approach below, based on a discussion I
> had with Robin and Timo.
>
> On Fri, Mar 17, 2023 at 11:13=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > Libbpf by default uses 16MB right now, I didn't touch that part yet,
> > but it might be good to reduce this size if the kernel supports this
> > new behavior. Go library seems to be using 64KB, which probably would
> > be adequate for a lot of cases, but yeah, maybe Go library would like
> > to use slightly bigger default if rotating log behavior is supported
> > by kernel?
>
> cilium/ebpf relies on ENOSPC to figure out if the verifier log has
> been truncated, and makes that information available in the API via
> VerifierError.Truncated [0]. This happens so that cilium can retry the
> program load with successively larger log buffers to capture the full
> verifier log. The full log is very valuable to us since we don't
> operate on our own infrastructure, so reproducing an error that a
> customer has on our own hardware is not always straightforward.
> Instead we include the full log in sysdumps. We want to preserve this
> as much as possible.
>
> Arguably 64KB might already be on the large side! The library
> currently does the "execute PROG_LOAD with log disabled first, get
> debug output later" trick (which libbpf also does I think?). It'd be
> nice if we could right-size the buffer on the retry.
>
> > Alternative would be to make this rotating behavior opt-in, but that
> > would require active actions by multiple libraries and applications to
> > actively detect support. Given the rotating behavior seems like a good
> > default behavior I wish we had from the very beginning, I went for
> > making it default.
>
> Given the above, taking away ENOSPC is problematic because an old
> cilium/ebpf on a new kernel doesn't know how to get the full log. I
> think it's better to make this opt in, since it also makes it easier
> to reason about from user space. Working with UAPI that changes
> behaviour based on kernel version is harder than doing feature
> probing.
>
> I do agree that ENOSPC is not a great API however and that it doesn't
> make sense for the rotated log to return it. It's a really big hammer
> that doesn't actually give us a key bit of information: how big should
> the buffer have been to obtain the full log. To recap, cilium/ebpf
> needs to know when the log was truncated and would like to know how
> big the buffer should be. How about the following:
>
> - To avoid breaking old libs on new kernels we make the behaviour opt
> in via BPF_LOG_TRUNCATE_HEAD or similar.
> - We add a field log_size_full to bpf_attr for PROG_LOAD. In the
> kernel we populate it with the buffer size that is required to
> retrieve an untruncated log for the given flags. log_size_full must be
> 0 when entering the syscall.
> - If BPF_LOG_TRUNCATE_HEAD is specified, we enable rotation and never
> return ENOSPC.
>
> From the user space side, we can use the API as follows:
>
> - If errno =3D ENOSPC or log_size < log_size_full we can deduce that the
> log was truncated.
> - If log_size_full > 0, we can use it to right-size the log buffer and
> retry only once instead of the increase-buf-size-and-retry loop.
>

Great feedback. Let me address all of it in one place.

Let's start with right-sizing the buffer. Curiously, with existing
(fixed) log behavior, verifier doesn't and can't know the full size of
the buffer it needs, as we stop producing log after -ENOSPC condition
was detected. log->ubuf is set to NULL, after which
bpf_verifier_log_needed() will start returning false. So in existing
"logging mode" it's impossible to support this without major changes.

On the other hand, with rotating log, we could determine this very
easily! We can just maintain max(log->end_pos, last_max_end_pos)
throughout the verification process (we need max due to log reset: it
still might need bigger buffer than final log length).

So, to get the full size, we need rotating log behavior.

What if we just make rotating log still return -ENOSPC, and set this
new "log_buf_max_size" field to actual required full size. That will
keep existing retry/resize logic intact and would be backwards
compatible, right?

As for feature detecting this change. Yes, there is no UAPI change
(unless we add extra field, of course), but as I implemented it right
now it's trivial to detect the change in behavior: set small buffer
(few bytes), try load trivial program. If you get -EINVAL, then we
have old kernel that enforces >=3D128 bytes for buffer. If you specify a
bit bigger buffer, you should get -ENOSPC. If you get success, it's
the new behavior.

So feature detection is not hard for library.

What I'm worried with switching this to opt-in
(BPF_LOG_TRUNCATE_HEAD), is that for various application that would
want to use log_level 1/2 for some diagnostics in runtime, *they*
would need to perform this feature detection just to know that it's
safe to provide BPF_LOG_TRUNCATE_HEAD. So I decided that it's better
use experience to do opt-out. Just to explain my reasoning, I wanted
to make users not care about this and just get useful log back.

But in summary, what do you think about just returning -ENOSPC even
with new behavior and keep rotating log behavior default?
Additionally, for rotating mode we can return required max log buffer
size in a new UAPI field.

Would this address all your concerns?


> FWIW, BTF_LOAD would benefit from the same improvements!

Heh, it actually does automatically as it uses bpf_verifier_log struct
as well. So all the BPF_PROG_LOAD changes for log apply to BPF_BTF_LOG
command.

>
> Best
> Lorenz
>
> 0: https://pkg.go.dev/github.com/cilium/ebpf@v0.10.0/internal#VerifierErr=
or
