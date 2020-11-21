Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC5B2BBAB8
	for <lists+bpf@lfdr.de>; Sat, 21 Nov 2020 01:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgKUANv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 19:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgKUANv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 19:13:51 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA7DC0613CF
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 16:13:50 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id s30so15910686lfc.4
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 16:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aw1h99jPDQe/6TOVAJhjAG6iMelLYm16MqfYmIDPDPI=;
        b=VLPDB9MROoKGlTf965IdLvuhLwy9WbOxPtEyf2fG8/dob+NNDhYJ69CthAiNd+OdUf
         341GaBNiZU7VT+POpLUxn8HDlaAj54iiak5VnRd2ErQU+tHYUwpawQmii7qM4xYhdKyG
         27eJ/F+WI/+k5LJSDqYYhKlmCoPS0P2g9HIZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aw1h99jPDQe/6TOVAJhjAG6iMelLYm16MqfYmIDPDPI=;
        b=HCjCbgx0FUOlYtKuLT/JEJ31QiejcFxTAHC93vN9hqLY05JVsFCl9PV62cfvDUR0Cq
         DkiFeZVtJd31xr9Hi9WL1wFi6hMairnsslT7Pq+oBz+2+OXM8DPpLwNK74xevvD1Ltbh
         Rcgt4ZpGKXAFXRxrjZ4j7l61FgxA63w0vht9Ll6OPCpODNqHLowbXUwXG7dWvnJ1esxg
         Y3Pao8y6su74oXa7WICChclVM2gx7jrOetve2f7orDqsFF9lmhb3dagkyM0dt633SS1D
         VeH6kcYKsFK3nE52tbEA91xuGPAgvGUxzGg7S6t5unGgajDVvskE73MAvL1sO8qFtRWK
         vaIQ==
X-Gm-Message-State: AOAM5335nnZDw/d3XbCpfENKvwvaU/m1T9rlDcMC2XZFqjdcgIVzfB8V
        OJg6D01idmCkUUTMGDfD28ZiRzphbBm/aw==
X-Google-Smtp-Source: ABdhPJwVsyTm2c6DJCM8vB1GSjIUFG6MX08sntnFXzG2Dw+XWdklaoGQz8ZFVyFQMtV5csmaaUjtgA==
X-Received: by 2002:a19:c3c9:: with SMTP id t192mr9793958lff.154.1605917629088;
        Fri, 20 Nov 2020 16:13:49 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id y18sm510412lfg.28.2020.11.20.16.13.48
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 16:13:48 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id d17so15863581lfq.10
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 16:13:48 -0800 (PST)
X-Received: by 2002:a19:ae06:: with SMTP id f6mr9766930lfc.133.1605917163430;
 Fri, 20 Nov 2020 16:06:03 -0800 (PST)
MIME-Version: 1.0
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Nov 2020 16:05:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wge0oJ3fbmNfVek101CO7hg1UfUHnBgxLB3Jmq6-hWLug@mail.gmail.com>
Message-ID: <CAHk-=wge0oJ3fbmNfVek101CO7hg1UfUHnBgxLB3Jmq6-hWLug@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] exec: Move unshare_files and guarantee
 files_struct.count is correct
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, criu@openvz.org,
        bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 20, 2020 at 3:11 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> This set of changes cleanups of the code in exec so hopefully this code
> will not regress again.  Then it adds helpers and fixes the users of
> files_struct so the reference count is only incremented if COPY_FILES is
> passed to clone (or if io_uring takes a reference).  Then it removes
> helpers (get_files_struct, __install_fd, __alloc_fd, __close_fd) that
> are no longer needed and if used would encourage code that increments
> the count of files_struct somewhere besides in clone when COPY_FILES is
> passed.

I'm not seeing anything that triggered me going "that looks dodgy". It
all looks like nice cleanups.

But that's just from reading the patches (and in some cases going and
looking at the context), so I didn't actually _test_ any of it. It all
looks sane to me, though, and the fact that it removes a fair number
of lines of code is always a good sign.

It would be good for people to review and test (Al? Oleg? others?),
but my gut feel is "this is good".

             Linus
