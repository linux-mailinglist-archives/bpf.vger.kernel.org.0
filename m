Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4404A5448
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 01:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiBAAts (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 19:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiBAAts (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 19:49:48 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB13C061714
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 16:49:48 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id s18so19187273ioa.12
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 16:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLBXYymEM/P+FZSH9vQLdgt3o4PyYW6A4SO0qdwldk4=;
        b=FdiQ0UN6j5QeSf5wigTLjgwZD7YjewSt9In3bPDDWGOh5blXirhmq2Ogm1IOCTkth6
         V9covuHkmEPcE8Zj8IxQJ2qcNLxBRZT/Nh4OwES5rvJHShmSYayE1XcgkH+KxLSyPcBQ
         vJ6OqCDz/jts0azYXZQZCdKBNQMBDN7L/lPgWw8BTBeKUQvHB7SCKG3MgX7Kxypf1kGY
         Z3KUZ73sJcGUpp2MQmsgEyBuEvXBjDlcLOUp/SZ8Q3zGSDhCN/G2Q8aBgMPZgDC0OJ8L
         K2FBhT8xc4/UmxTMRs2B0tm23vjQVX3EhMDZ/i2aNvRrlpT0G6MZWytWHUlEXj3NnoHk
         qkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLBXYymEM/P+FZSH9vQLdgt3o4PyYW6A4SO0qdwldk4=;
        b=NioNm1wCmYS27WnGXZ5AY/4HrGzt1zu/Ei6wdH7zQmKsH14z/H/XlFMiXVMVAKDuJl
         +jVUZ24kJNg6V0MFatgDO+343vjOnIgYYjd1Z73T+/w49aRHckTgcokl1vyd1aJO0p0V
         6u08HQS++xuiU+XR+mt3a4BelUsxHsIb8zenPrX41QxVNpTSoOBOPOGvG4F77MUVYDCF
         GsSAFAI0H7xKm9hRqiyNIQmJ+raTF4yT9eEauXBkvl1F6IeY2U0IkYBMVu30IzBai9WQ
         IqOB1MCevOfHSe6tXYNjvysAdm6K2SZ+SfIQlenSio2gU7uIPo8rBPota9SiiYP2zmz6
         4f+w==
X-Gm-Message-State: AOAM533PR/VdMAMi6aEvUGFESn85pDfC8qnnYkXuG7ebOwSvw0Qa1Y+M
        GIyF/G9UTh0WAvnTcCpz8j3zNUORN37na3mZ8EdPLVnT
X-Google-Smtp-Source: ABdhPJxvXf0it9g0S7ctfzLYLQeBdBsOkLroT2ED9ttGvhUes52M1mVSMjvB7wRdT/4tnKGZ9n21FVI0G54WWx91T/M=
X-Received: by 2002:a5e:8406:: with SMTP id h6mr12636264ioj.144.1643676587407;
 Mon, 31 Jan 2022 16:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20220127082649.12134-1-9erthalion6@gmail.com>
In-Reply-To: <20220127082649.12134-1-9erthalion6@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 31 Jan 2022 16:49:36 -0800
Message-ID: <CAEf4BzbZHm8c=eeMTx=tLHKSddvH-fKQ5qkuULymQnZqd2DgtQ@mail.gmail.com>
Subject: Re: [RFC PATCH] bpftool: Add bpf_cookie to perf output
To:     Dmitrii Dolgov <9erthalion6@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 27, 2022 at 12:27 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
>
> Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> BPF perf links") introduced the concept of user specified bpf_cookie,
> which could be accessed by BPF programs using bpf_get_attach_cookie().
> For troubleshooting purposes it is convenient to expose bpf_cookie via
> bpftool as well, so there is no need to meddle with the target BPF
> program itself.
>
>     $ bpftool perf
>     pid 83  fd 9: prog_id 5  bpf_cookie: 123  tracepoint  sched_process_exec
>

I think a more natural place to expose this would be in `bpftool link
show` output, as bpf_cookie is actually per attachment (i.e., link)
information (not a per-program). We'll need to anticipate multi-attach
use cases (e.g., multi-attach kprobe and fentry programs we are
discussing at the moment).

> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
>  include/linux/trace_events.h                  |  4 ++--
>  kernel/bpf/syscall.c                          | 13 +++++++------
>  kernel/trace/bpf_trace.c                      |  3 ++-
>  samples/bpf/task_fd_query_user.c              | 16 ++++++++--------
>  tools/bpf/bpftool/perf.c                      | 19 +++++++++++--------
>  tools/lib/bpf/bpf.c                           |  3 ++-
>  tools/lib/bpf/bpf.h                           |  2 +-
>  tools/lib/bpf/libbpf.map                      |  1 +
>  .../bpf/prog_tests/task_fd_query_rawtp.c      | 10 +++++-----
>  .../bpf/prog_tests/task_fd_query_tp.c         |  4 ++--
>  10 files changed, 41 insertions(+), 34 deletions(-)
>

[...]

> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 079cc81ac51e..80bd705eca59 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -315,7 +315,7 @@ LIBBPF_API int bpf_load_btf(const void *btf, __u32 btf_size, char *log_buf,
>                             __u32 log_buf_size, bool do_log);
>  LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
>                                  __u32 *buf_len, __u32 *prog_id, __u32 *fd_type,
> -                                __u64 *probe_offset, __u64 *probe_addr);
> +                                __u64 *probe_offset, __u64 *probe_addr, __u64 *bpf_cookie);

can't do this, it breaks source code compatibility.
bpf_task_fd_query() API isn't extendable.

>
>  enum bpf_stats_type; /* defined in up-to-date linux/bpf.h */
>  LIBBPF_API int bpf_enable_stats(enum bpf_stats_type type);

[...]
