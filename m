Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69122163DAB
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2020 08:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBSHea (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Feb 2020 02:34:30 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46275 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbgBSHe3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Feb 2020 02:34:29 -0500
Received: by mail-qk1-f194.google.com with SMTP id u124so21644944qkh.13
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2020 23:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hHsI7MOCCKl5QBPgBe8NW7G5OUlzsFWWyufHJc8ohB4=;
        b=FhrsIxj+EbyUY+MML+4ZXWqQIPsMkUSv0B25EsWZJRBrTlcJS8szdStvEXxcRMsIvx
         hGflT0/RttOGLCzHnJWtoLySDkTYf99X5RT3soG+3mqqCpXw8kokObticDiWRqLmNX2S
         xYKxpbSYUXlKWF4dB5ljDZBsG29l9TfB4amH6oE2z0TMkKXVdMc6eh80JdvuNyUS7Npt
         QeAv9w+iYdnHfm2gbWVPj2v+Uz2XgYmhAeu833Gjv3iZJLQAZg7kNLKZO+cTJG1U0nHN
         /IOslywMSxTNvMEzLXKSaq2JskQ0KJ0T9z9PJ6UnaDTnLR/nHFRiHHPFASlJGawsBBZ3
         mBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHsI7MOCCKl5QBPgBe8NW7G5OUlzsFWWyufHJc8ohB4=;
        b=Ns2TcAoSUXLXMqGKcopwmcbxW524SVhkv3S4RtjPRkZnl6rh44QaOeS8eQqxzq7m9R
         m/qrreTd2nTzqZFcCVxW1cNRQYir42qKVEAcdJmIV3hLSSIzr6TjMlVlSaJ5OgFuCqk9
         0JB88dqWzm9jUm51y9PeY7qiEi7vE8FKwFOcdzxSTBqNR4hPw8oYmnsT953SFwylbn8b
         8d3vCIOEaiAjeOKdF+ryWmL5X04IWqqA2/Ho60AQ1QZije+oaiGyLTNj5h0m7t6aN/JS
         8dX1x0QI/w2Xs6NjeDImMMCB0RX1URAT97o0YryU/UX21xZ1Y4pg7jggd8RINWlZzPEz
         yslw==
X-Gm-Message-State: APjAAAXXAmbAZSIzCgxGLzY8V2yDqtPr7XiUbUak6Z97lplp4TcIfuF2
        W06D54rtSlMPdUEcoaDTjiz+BeK+g7PVBFu4HrI=
X-Google-Smtp-Source: APXvYqy0zj1w2wQplH+ZCbg3RMPmKZir7w2bmzanyZ+oXmSe8Q4hKrghDrJmwVZ76VxELPb560GccXXnXOP+dkmJwrQ=
X-Received: by 2002:a37:9fcf:: with SMTP id i198mr7440951qke.36.1582097668532;
 Tue, 18 Feb 2020 23:34:28 -0800 (PST)
MIME-Version: 1.0
References: <20200219004236.2291125-1-yhs@fb.com>
In-Reply-To: <20200219004236.2291125-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 18 Feb 2020 23:34:17 -0800
Message-ID: <CAEf4BzagQu2ecGBP8jiOOkSz39pBzGBPuTcF48yzpfnzwKehdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: change llvm flag -mcpu=probe to -mcpu=v3
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 18, 2020 at 4:44 PM Yonghong Song <yhs@fb.com> wrote:
>
> The latest llvm supports cpu version v3, which is cpu version v1
> plus some additional 64bit jmp insns and 32bit jmp insn support.
>
> In selftests/bpf Makefile, the llvm flag -mcpu=probe did runtime
> probe into the host system. Depending on compilation environments,
> it is possible that runtime probe may fail, e.g., due to
> memlock issue. This will cause generated code with cpu version v1.
> This may cause confusion as the same compiler and the same C code
> generates different byte codes in different environment.
>
> Let us change the llvm flag -mcpu=probe to -mcpu=v3 so the
> generated code will be the same regardless of the compilation
> environment.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

[...]
