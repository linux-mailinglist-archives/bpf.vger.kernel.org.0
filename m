Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30E26EFF51
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 04:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbjD0CVy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 26 Apr 2023 22:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242731AbjD0CVx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 22:21:53 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9489040C8
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 19:21:51 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-b8f5121503eso11785304276.1
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 19:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682562111; x=1685154111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvnAVeNcRKqdKnyB1uAj6sbx4Y0HtMVrJHqDP260jiY=;
        b=imKUZ/K2gea0Y0qOsy/v+CmurfcjMUiD1Sr7Ks68snwOK6kmagZcDyDcxqcHmhbu/v
         7506To9DlM49hAfdeVZdBMz59M/7tMjsk1EiDIblHf1nz31rtKUlbHGY8d4cKFXzDZj5
         LsO0GcksVLtlkEF91EmCXi9m7oMYRAm9Vy1hTqRb4P6gz2Fo7kzB6O/YALyNAAB6Jz75
         biRZVBBjwzn/diD84B2g5k3eH6KpZaXRMFNEbScN8HijwmdCFRlL72KTTNVmCFehxncf
         r/nsQrBLZC2r3teCNc+0oW9ufNdFy5kiWmtBQiyLdHYKHQFXCp4Vd5aIl9Pg6HiugJRn
         FWoA==
X-Gm-Message-State: AAQBX9ev8Uk/p6cD3f4FAbT6YIZaCPcHZh7xtTYChXZqX6OV+VphE+PK
        gI3pNeetI+g37WoycGsw4PpgFlaU0+UB5QJ5P/Y=
X-Google-Smtp-Source: AKy350YlPgosgB72PquVWyfTw3EtXji4daFRZyTGuFqUau24VPwlVxr/7+4xpoKhaUQWwEgDm4bq780q/LkdYG8zLrE=
X-Received: by 2002:a25:dbc8:0:b0:b92:3bbf:f22b with SMTP id
 g191-20020a25dbc8000000b00b923bbff22bmr18695928ybf.0.1682562110645; Wed, 26
 Apr 2023 19:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230427001425.563232-1-namhyung@kernel.org> <CAEf4BzYs6iD+iE4RZnXTKHhBHCOr9r7AdhsBWWDpivy7sshPKw@mail.gmail.com>
In-Reply-To: <CAEf4BzYs6iD+iE4RZnXTKHhBHCOr9r7AdhsBWWDpivy7sshPKw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 26 Apr 2023 19:21:39 -0700
Message-ID: <CAM9d7ci3xAcnqdkpb-J4rv7yfiB2Trb-e2h7gfj6Wu5N_V7a-Q@mail.gmail.com>
Subject: Re: [HELP] failed to resolve CO-RE relocation
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Andrii,

On Wed, Apr 26, 2023 at 6:19 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 26, 2023 at 5:14 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > I'm having a problem of loading perf lock contention BPF program [1]
> > on old kernels.  It has collect_lock_syms() to get the address of each
> > CPU's run-queue lock.  The kernel 5.14 changed the name of the field
> > so there's bpf_core_field_exists to check the name like below.
> >
> >         if (bpf_core_field_exists(rq_new->__lock))
> >                 lock_addr = (__u64)&rq_new->__lock;
> >         else
> >                 lock_addr = (__u64)&rq_old->lock;
>
> I suspect compiler rewrites it to something like
>
>    lock_addr = (__u64)&rq_old->lock;
>    if (bpf_core_field_exists(rq_new->__lock))
>         lock_addr = (__u64)&rq_new->__lock;
>
> so rq_old relocation always happens and ends up being not guarded
> properly. You can try adding barrier_var(rq_new) and
> barrier_var(rq_old) around if and inside branches, that should
> pessimize compiler
>
> alternatively if you do
>
> if (bpf_core_field_exists(rq_new->__lock))
>     lock_addr = (__u64)&rq_new->__lock;
> else if (bpf_core_field_exists(rq_old->lock))
>     lock_addr = (__u64)&rq_old->lock;
> else
>     lock_addr = 0; /* or signal error somehow */
>
> It might work as well.

Thanks a lot for your comment!

I've tried the below code but no luck. :(

        barrier_var(rq_old);
        barrier_var(rq_new);

        if (bpf_core_field_exists(rq_old->lock)) {
            barrier_var(rq_old);
            lock_addr = (__u64)&rq_old->lock;
        } else if (bpf_core_field_exists(rq_new->__lock)) {
            barrier_var(rq_new);
            lock_addr = (__u64)&rq_new->__lock;
        } else
            lock_addr = 0;


; int BPF_PROG(collect_lock_syms)
0: (b7) r8 = 0                        ; R8_w=0
1: (b7) r7 = 1                        ; R7_w=1
2: <invalid CO-RE relocation>
failed to resolve CO-RE relocation <byte_off> [381] struct
rq___old.lock (0:0 @ offset 0)
processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read

Thanks,
Namhyung
