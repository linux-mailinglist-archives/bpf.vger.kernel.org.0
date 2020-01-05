Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40DF7130552
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2020 02:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgAEBT1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Jan 2020 20:19:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33483 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgAEBT1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Jan 2020 20:19:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so44681727otp.0;
        Sat, 04 Jan 2020 17:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rjpqbK93O/iu5o//OmgzmyGJYgPRsECTez5RhFbPj4o=;
        b=Hqpa6/nFMt1k6Gacb/LNwp7rvTpRgL96QMH2uL2Mvi2jOAk1KerRRAvklfHVZvReYD
         91VPWQLdhtrbwEw10Mg0bO3VH9jI7Sk9vhp4Qh8YKHQx+wU/rVwfrrzhekSIVl+GJ4MW
         ET8Vv/SmK6dxspqTTZR8JPpr3Li1VFK8p54X3xa6ucd23uiJlW8TCvXE8h4EJMeplk7z
         jQARTTMTedqp+AREiD/XcaUjKVk72yu90lWgxzUWoyt8c46jYSvvmZQBy7hizMz6/4rt
         fuXdHhIkcAihhYErtRKj993KME6Ci+shJVKflL5hiAYDcJ0mTYCc3ev+GvbVkOlXerTW
         v0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rjpqbK93O/iu5o//OmgzmyGJYgPRsECTez5RhFbPj4o=;
        b=rfV5sYzqAbE1a/jtkhRe4GScWpVqjIJcnpBa6gExZVb3xisD6P3HRXl/BV+e5FLVks
         9HevBcV+8qsyFTFxGrm/eyhhC4mvQIOttdLQS3vG4qnixKdjsZYExq922uUMHvBINDTk
         MX36mVeWL1bMJePGQpNEuIYd4XS2d529Ykv7W9QgILyNz9B9R3g5/KKu3XqSXCST2w7Z
         WgrhV+yGg52OPveWMgs/wkTSfwuEGAAF+dpCUWYWbfFD+rtE+LUQTcX2tqYAJl8qm1fi
         gCQ/LQIbaEjZArz+p0iD+F7l98RTT8riXJNZC0vQqS+mFVC3+/q8F50RhCprbUO7RxN9
         6CbA==
X-Gm-Message-State: APjAAAXZspQbUyst6OHgBluq/42CFYA1AYWR7BgCayYKjUH036+5v/yZ
        0adEicJw8l5KZhh0W8fVVKOD1Oi8jqCtbKmStTE=
X-Google-Smtp-Source: APXvYqwP+k+lkGBdLKIyu1Aozce9RaFYCdw7nnPyhgRnq8iNFacAvNb58GSAazI6o1ej8726b6Y9SX3w9f4jODeLw/M=
X-Received: by 2002:a9d:6c92:: with SMTP id c18mr92355757otr.157.1578187166437;
 Sat, 04 Jan 2020 17:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20200103234725.22846-1-kpsingh@chromium.org> <F25C9071-A7A7-4221-BC49-A769E1677EE1@amacapital.net>
In-Reply-To: <F25C9071-A7A7-4221-BC49-A769E1677EE1@amacapital.net>
From:   Justin Capella <justincapella@gmail.com>
Date:   Sat, 4 Jan 2020 17:19:14 -0800
Message-ID: <CAMrEMU-8KizWmgmYHzu8B++HOyfvC-2LF4KP7ibZki_q-_JrxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Make trampolines W^X
To:     KP Singh <kpsingh@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        x86@kernel.org, linux-security-module@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Thomas Garnier <thgarnie@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Michael Halcrow <mhalcrow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm guessing 2 pages are used to allow for different protections? Does
only the first page's protections need to be changed? Is that
"old_image"?

+       set_memory_nx((unsigned long)image, 1);
+       set_memory_rw((unsigned long)image, 1);

+       set_memory_ro((unsigned long)new_image, 1);
+       set_memory_x((unsigned long)new_image, 1);

Because

+       void *old_image =3D tr->image + ((tr->selector + 1) & 1) * PAGE_SIZ=
E;
+       void *new_image =3D tr->image + (tr->selector & 1) * PAGE_SIZE


> > - Mark the memory as read-only (set_memory_ro)
> > - Mark the memory as executable (set_memory_x)
>
> No, thanks. There=E2=80=99s very little excuse for doing two IPI flushes =
when one would suffice.

If there were checks between these steps to verify the trampoline
wasn't tampered with while the page was writable it would make sense
to do so before enabling execution.

Could some of these int's be unsigned to be extra cautious?

One last thought, if the extra checks are implemented, maybe comparing
against the old image prior to setting rw would be worthwhile?
