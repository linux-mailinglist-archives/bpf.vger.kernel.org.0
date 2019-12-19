Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59BB21270B6
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 23:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLSWbe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 17:31:34 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43910 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSWbd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 17:31:33 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so3762334qtj.10
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 14:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WRmjgvRXXtrecsTaJUTpUzCif6AuCUxamXG4t0OZisM=;
        b=HoWY0wufXd1koTuZq/G8C9oyCZsi+dWyB/NUmfNVSE4vJNketejfuVKzcLHK/5BfVf
         xWJTyRZUtdo48/hoAmwzuQIp+xCKpeaRfctf6FMTT3VSigeHCkHctKe4fgmr4l+zb2hI
         mGUuR+vqGcV880enSaPBZ1p6ZKy6JyW3cw0HEX7+TlMsMLwVd5oz+bVQ23hsyHsoF3ld
         JlalL7QHBHFuPyAnITLng604zGugjYKA4A8sVBE4xtjoCcous6nVucuaoGNEpml0UqhN
         Yd9pFU8v8X6exd5V2IuhR+NrTuSYBg/ZciRcnci03XcESjfNLuz9zTrnQAsgD/HA9buX
         EbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WRmjgvRXXtrecsTaJUTpUzCif6AuCUxamXG4t0OZisM=;
        b=jLx4TgVfpgOkSgmaisdqNjPjygWG847FiSw0CbddO8EI9lwqV8R0/D3y9JjghKVavQ
         2GaPPMpMcydia0nydUP0kxY2gPbWi5Z9I2sa+XXaaUd3BeRlSqcENtEUW5sXIJyEdeaK
         drhEqRzfVOEp36eaiHy+5gtJN7BTHPM6jZjdRRo/nLEbfWQVAPhEeQzHgtVQEmGo7foZ
         dejMnAbhU7qJPpqL9WbrbwW4eQxRk48In5Zmf5W6VYiGY8I8m1YHmdMtvzWI7J3cgZfi
         mxy5eqKH3vchzPyJHzY3oQu1ja13JoDJiFCzscaa3nVFiOB53/fjgUwdFLPSFFkLW3wv
         x6BQ==
X-Gm-Message-State: APjAAAVFgzIM+gtFuWwHvw24JFOCQfjl/HiwGQeLfUx268kR1FayoU9i
        4W0sYVuQLdUHvXlT0NOAkMWYOj1CK6NCdMHI8XI=
X-Google-Smtp-Source: APXvYqzXEOAyMNzsMeTg2eSzMWJ/AneDPp6+pPP5W11h69Q84aB2BtPs6TIphE0twyP890iglRrXLj0GKqOjvytkB7o=
X-Received: by 2002:ac8:1385:: with SMTP id h5mr9089247qtj.59.1576794692869;
 Thu, 19 Dec 2019 14:31:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576741281.git.rdna@fb.com> <c6193db6fe630797110b0d3ff06c125d093b834c.1576741281.git.rdna@fb.com>
In-Reply-To: <c6193db6fe630797110b0d3ff06c125d093b834c.1576741281.git.rdna@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 19 Dec 2019 14:31:21 -0800
Message-ID: <CAEf4BzbmtTgYPi94Exipu_c=nsuTp01oAURtFYgmM6C43O-V+w@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/6] bpf: Simplify __cgroup_bpf_attach
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 18, 2019 at 11:45 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> __cgroup_bpf_attach has a lot of identical code to handle two scenarios:
> BPF_F_ALLOW_MULTI is set and unset.
>
> Simplify it by splitting the two main steps:
>
> * First, the decision is made whether a new bpf_prog_list entry should
>   be allocated or existing entry should be reused for the new program.
>   This decision is saved in replace_pl pointer;
>
> * Next, replace_pl pointer is used to handle both possible states of
>   BPF_F_ALLOW_MULTI flag (set / unset) instead of doing similar work for
>   them separately.
>
> This splitting, in turn, allows to make further simplifications:
>
> * The check for attaching same program twice in BPF_F_ALLOW_MULTI mode
>   can be done before allocating cgroup storage, so that if user tries to
>   attach same program twice no alloc/free happens as it was before;
>
> * pl_was_allocated becomes redundant so it's removed.
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> ---

lgtm

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  kernel/bpf/cgroup.c | 62 +++++++++++++++++----------------------------
>  1 file changed, 23 insertions(+), 39 deletions(-)
>

[...]
