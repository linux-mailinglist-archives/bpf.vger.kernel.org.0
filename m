Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53442B0F37
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 21:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgKLUtt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 15:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgKLUts (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 15:49:48 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67972C0613D1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 12:49:48 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id i17so6785156ljd.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 12:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UDDtr3a9TDYeq7NhppmGXW7X+tH2xYzT3dZK8AfhIz0=;
        b=VbqI9rl6FUKSVXACb5pQgvcimBZsiBxQw1lVG4mSyqcKX6eUsDpt/Jqt31ZNnaOQXC
         9h4NkV8DI/oT6TnzsDqJvI3fdYR5+5yuL0MVfmGdxLc4uj2z2YA3iXy0dIQ80tHgcAVz
         UUshqNoOJCB3bdSooKfPeB9e6yOj43WTGQ1gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UDDtr3a9TDYeq7NhppmGXW7X+tH2xYzT3dZK8AfhIz0=;
        b=VgA4lsfquEFy+rr9WvDPDFd7qdzH1e7hwY0lJoSXiOOq7GrEi5SPJZbVRh1g8wFZVH
         nVesL2zW5XhWrexAFaC8U6MCsAzph3HS3/xrmLvLrQ37KM2BzNoZmlkKHRdDkEKG5KMG
         DZXmCNAaeObHzLpIEDULxN/3Wx6lN1vGYvazkMPoPiWEL/nfeLNMCnTr7MbrszkxodWS
         6ss1DiM0JF87jywjOIhfCLR89CfYNO0dfrh/bBcQQzI1fBMnVLgUQPpMCwpt0HC7ZsKr
         X2+jabRgUiu/ROJQivyc4Uko0jCtQKp33iVqyebL3iNqMhvQ3AsRGPA9IXEu5KcdUtqr
         uvtg==
X-Gm-Message-State: AOAM5311zJsx9DSij5n+KTVQSjDLudQEp5+LcWVG77iquqxERrsaRYhH
        gKtB5PHMFihGlPCjfY2FS9Gp/T1sqI1y1ayaRlLwNg==
X-Google-Smtp-Source: ABdhPJwlPKjHN36fiZaW5Zy43yaBFcAGHnCrZ+1sxsKXvWmW6G9hiR3PMDOIczZgVSqnj7d1uXWfr/z7Yy3yeXAsoFM=
X-Received: by 2002:a2e:85c6:: with SMTP id h6mr640460ljj.110.1605214186951;
 Thu, 12 Nov 2020 12:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20201112180340.45265-1-alexei.starovoitov@gmail.com>
 <8d6d521d-9ed7-df03-0a9b-d31a0103938c@iogearbox.net> <87lff68hbm.fsf@toke.dk>
In-Reply-To: <87lff68hbm.fsf@toke.dk>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 12 Nov 2020 21:49:36 +0100
Message-ID: <CACYkzJ4miC2x4dAyn0N0pSMbVQF+sLNhaHD7ypgjdPzTC5zzkA@mail.gmail.com>
Subject: Re: [PATCH bpf] MAINTAINERS/bpf: Update Andrii's entry.
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 9:13 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Daniel Borkmann <daniel@iogearbox.net> writes:
>
> > On 11/12/20 7:03 PM, Alexei Starovoitov wrote:
> >> From: Alexei Starovoitov <ast@kernel.org>
> >>
> >> Andrii has been a de-facto maintainer for libbpf and other components.
> >> Update maintainers entry to acknowledge his work de-jure.
> >>
> >> The folks with git write permissions will continue to follow the rule
> >> of not applying their own patches unless absolutely trivial.
> >>
> >> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >
> > Full ack, thanks for all the hard work, Andrii!
>
> +1 :)
>
> -Toke
>

+1 Thanks for all the work Andrii!!
