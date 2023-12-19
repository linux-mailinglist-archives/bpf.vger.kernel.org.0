Return-Path: <bpf+bounces-18261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EB5818052
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 04:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35532284326
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 03:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA45953B4;
	Tue, 19 Dec 2023 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PZjvlTjF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E8EC132
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 03:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50c222a022dso4845327e87.1
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 19:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702958281; x=1703563081; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QFMDBuRI0yIhgu5G0f945foLHQ4bi+M6kOncymn8N3c=;
        b=PZjvlTjF9Qo99wE18FhwaD/EImCzUcU4B64KC6ysvXc15qD8FepPBos1CS0LACRSNq
         Zh0IwV2Ft3sb9R07D/tpnxTkjz68hVwI51g0a2SK6mC8ohog0ZNHaA6iM99QPDfl+3wm
         R0mVajHSYpnAO1CjWjTAFUMyiWlB4cELZwrJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702958281; x=1703563081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFMDBuRI0yIhgu5G0f945foLHQ4bi+M6kOncymn8N3c=;
        b=PiAh9ph+rRWtVi+AeS+xMzcRI1SCuKfnHuamrIRdCt46Kbb4xQakn08Sgb4Cl36YZn
         cpvJ3HzpO//+yKPMS0bqcWnXzNY+pxvd8TBObsHxb94/0HIDpUH+Y1X03Lh/b8XT70Tn
         R3qQricV3DLfMVktOrgeY2ZkduRgwvX77B6oyWZdjnsZ/tDR0x3yifbkdBkXXfW5kMb1
         g//nUfCnQf0VSBEHFloiTYSEwAd6Hzi+T+yX0LVw1EkSHKU8bQVO/iNOA8SRA/tXUEby
         +qRoY12q+la5H1SJnKXiLMvLz4MYFyHbkUy+0/gPs11w4s6oYNKl4xt2SM2t1/jr8s4c
         iDEQ==
X-Gm-Message-State: AOJu0Yzr3GvKj7cejg1V/puQ+gFlIvRnyeQulg52wkzLsWVTaE9Ny9Yq
	5hMr5kqX9cbyD+Zp6uS3cC4WP5XK1+EbHMDiZ6Jz6xCd
X-Google-Smtp-Source: AGHT+IEs68fG6azM+hmYgnh/5g7YIslL/cMnBAE0n8GwvaMLBbO+RIb7fGJmP9zn5XLQg7c2lNOvNQ==
X-Received: by 2002:a05:6512:3d08:b0:50b:f0de:621a with SMTP id d8-20020a0565123d0800b0050bf0de621amr9795177lfv.22.1702958281328;
        Mon, 18 Dec 2023 19:58:01 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id dw11-20020a0565122c8b00b0050d12f2a97asm3046171lfb.177.2023.12.18.19.58.00
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 19:58:00 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50c222a022dso4845313e87.1
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 19:58:00 -0800 (PST)
X-Received: by 2002:a05:6512:220f:b0:50e:44a4:f7e3 with SMTP id
 h15-20020a056512220f00b0050e44a4f7e3mr233393lfu.81.1702958280178; Mon, 18 Dec
 2023 19:58:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
 <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com> <CAADnVQJfyfbpEVHnBy2DDGEJvUm8K25b9NHCzu08Uv96OS8NaA@mail.gmail.com>
In-Reply-To: <CAADnVQJfyfbpEVHnBy2DDGEJvUm8K25b9NHCzu08Uv96OS8NaA@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 18 Dec 2023 19:57:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5qvbPDXUxnawwVWvoRi6fSwFM6h5rYkKmetovmOxjOg@mail.gmail.com>
Message-ID: <CAHk-=wh5qvbPDXUxnawwVWvoRi6fSwFM6h5rYkKmetovmOxjOg@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-12-18
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Dec 2023 at 17:48, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
>
> Point taken.
> We can do s/__u32 token_fd/__u64 token/
> and waste upper 32-bit as flags that indicate that lower 32-bit is an FD
> or
> are you ok with __u32 token that is 'fd + 1'.

No, you make it follow the standard pattern that Unix has always had:
file descriptors are _signed_ integer, and negative means error (or
special cases).

Now, traditionally a 'fd' is literally just of type "int", but for
structures it's actually good to make it be a sized entity, so just
make it be __s32, and make any special cases be actual negative
numbers.

Because I'll just go out on a limb and say that two billion file
descriptors is enough for anybody, and if we ever were to hit that
number, we'll have *way* more serious problems elsewhere long long
before. And in practice, "int" is 32-bit on all current and
near-future architectures, so "__s32" really is the same as "int" in
all practical respects, and making the size explicit is just a good
idea.

You might want to perhaps pre-reserve a few negative numbers for
actual special cases, eg "openat()" uses

    #define AT_FDCWD -100

which I don't think is a great example to follow in the details: it
should have parenthesis, and "100" is a rather odd number to choose,
but it's certainly an example of a not-fundamentally-broken "not a
file descriptor, but a special case".

Now, if you have a 'flags' or 'cmd' field for *other* reasons, then
you can certainly just use one of the flags for "I have a file
descriptor". But don't do some odd "translate values", and don't add
32 bits just for that.

That's also a perfectly fine traditional unix use (example: socket
control messages - "struct cmsghdr" with "cmsg_type = SCM_RIGHTS" in
unix domain sockets).

But if you don't have some other reason for having a separate flag for
"I also have a file descriptor you should use", then just make a
negative number mean "no file descriptor".

It's easy to test for the number being negative, but it's also just
easy to *not* test for, ie it's also perfectly fine to just do
something like

        struct fd f = fdget(fd);

without ever even bothering to test whether 'fd' is negative or not.
It is guaranteed to fail for negative numbers and just look exactly
like the "not open" case, so if you don't care about the difference
between "invalid" and "not open", then a negative fd also works just
as-is with no extra code at all.

                   Linus

                     Linus

