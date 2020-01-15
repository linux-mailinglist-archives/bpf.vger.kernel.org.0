Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98E6413B97E
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 07:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgAOGXB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 01:23:01 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34640 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAOGXB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 01:23:01 -0500
Received: by mail-qk1-f194.google.com with SMTP id j9so14720130qkk.1
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 22:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6kXsttBJF8NRX6Il8q8x+MiRaD6ZTas5L0xvuDQ/jOI=;
        b=uIo8tjCugf+Mpdo7KVPthS4iFx8NNyrsrb75V8wHfJGO6mXJjPN2TO+s3EKFH3HK1o
         XpYcTBSTC6FIj5ZbstN48846BlG+W8s8JElBW+pcmiwwFU2Ig7YV60VqYjkYVuE1vMzz
         H4BUzUWUANJRahBFeDY1c7pgd0pe5n2cFQpJrt2dPMvazOjKfSHky7XJssZej9S68N5B
         mOOOtRVwyde3O7p/vRq8KUqwYOVIqKLYqyG18jbOTxxCCLv38EJhu6f+ZPJtH8KMpxVs
         aO/o4/HbgKei6QnI5EwJegVLcwTxCs9ctJQX6/bvURrP5WOPZ+QxDovghcuxurpxr8tS
         WLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6kXsttBJF8NRX6Il8q8x+MiRaD6ZTas5L0xvuDQ/jOI=;
        b=hYaxSoruc9tBeLYl1MzAur5Re0qOGuhRjJIj4gqD+MeDxHb2TrlCCIT9O4mWoPIAji
         +kBOhNpm7BT2Q4bAcGIKaaZuxzgtbe9ADLAD2KCHUs7n3wZpoE62xAwUYGgXkKfugER3
         1ePWRXp3n9kOFbXWJgldlEFXW8CYkv23eLwT8jwgXEYDXAELsTqFOOroSRz1TcmNSCI0
         e0PO7AI6ljhNbB8GQoDkrfKZbeoGYygIRO8hZ7ETn5HPLMJiccIg/VheZ6nw0MxtqmOI
         qszu2G3Oj/EZWm0F+T9HWJ/lkr1cRlaCZSk+E9h5gmO3TynJixDAIdCgtvYCgc5Xcadu
         iLhg==
X-Gm-Message-State: APjAAAVarut13+NzGQAoJG/hkd+IDaVDQyQ6n3qxeJzw+quHOjQG5bR9
        V3twhaV7gMOlNPy4O4LZidfmGvdVGkj4194TRywgzg==
X-Google-Smtp-Source: APXvYqxTCZYTt6BOvaHrAJzpLqUV7fe+nZMBx4Z/5alaq1BgxTbxmDe/95BeQm5A7OaLq4RPB1C0keTgomT/TORt3v0=
X-Received: by 2002:ae9:e809:: with SMTP id a9mr9497545qkg.92.1579069380308;
 Tue, 14 Jan 2020 22:23:00 -0800 (PST)
MIME-Version: 1.0
References: <20200115035002.602280-1-yhs@fb.com>
In-Reply-To: <20200115035002.602280-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Jan 2020 22:22:49 -0800
Message-ID: <CAEf4BzYi7PuQsnn-fL4O4xFBu+kQKwBObyS6_2vzvUEi7607CQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/2] bpf: add bpf_send_signal_thread() helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 14, 2020 at 7:50 PM Yonghong Song <yhs@fb.com> wrote:
>
> Commit 8b401f9ed244 ("bpf: implement bpf_send_signal() helper")
> added helper bpf_send_signal() which permits bpf program to
> send a signal to the current process. The signal may send to
> any thread of the process.
>
> This patch implemented a new helper bpf_send_signal_thread()
> to send a signal to the thread corresponding to the kernel current task.
> This helper can simplify user space code if the thread context of
> bpf sending signal is needed in user space. Please see Patch #1 for
> details of use case and kernel implementation.
>
> Patch #2 added some bpf self tests for the new helper.
>
> Changelogs:
>   v2 -> v3:
>     - More simplification for skeleton codes by removing not-needed
>       mmap code and redundantly created tracepoint link.
>   v1 -> v2:
>     - More description for the difference between bpf_send_signal()
>       and bpf_send_signal_thread() in the uapi header bpf.h.
>     - Use skeleton and mmap for send_signal test.
>
> Yonghong Song (2):
>   bpf: add bpf_send_signal_thread() helper
>   tools/bpf: add self tests for bpf_send_signal_thread()
>
>  include/uapi/linux/bpf.h                      |  19 ++-
>  kernel/trace/bpf_trace.c                      |  27 +++-
>  tools/include/uapi/linux/bpf.h                |  19 ++-
>  .../selftests/bpf/prog_tests/send_signal.c    | 128 +++++++-----------
>  .../bpf/progs/test_send_signal_kern.c         |  51 +++----
>  5 files changed, 131 insertions(+), 113 deletions(-)
>
> --
> 2.17.1
>

For the series:

Acked-by: Andrii Nakryiko <andriin@fb.com>
