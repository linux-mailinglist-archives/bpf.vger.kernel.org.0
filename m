Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84362310572
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 08:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhBEHHj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 02:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhBEHHX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 02:07:23 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A323C06178B
        for <bpf@vger.kernel.org>; Thu,  4 Feb 2021 23:06:43 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id s61so5808429ybi.4
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 23:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJsChTwdN37E5x3lJmKg+KnIek7b6/CxdmRZQ1BCeM0=;
        b=hHzhhLYqpWik1JeCXTlOlEpu8qdyhHJq/ae6emC4ouvDT8gR3VhveBpaSGc2T0KLRM
         kO6RhOAaOATvaUiCJc5s/T2YxOu1+UD4nbqJRRWcFNJ3aGV5JTOienVn8H7N/31WcJeh
         NEBFtI3oO21J22rUMC7FXwL5evwOkWstzJWt8R4oWfOv/KDcgm8BQqjnoG2zT88ERwHu
         my0w2I87Tn6e0tYtIC0LRGASJWp5H7b0s1r9EG37mKIBP63lEITkzyUJvHbbolSNd0bx
         XI2pOJJuGNNCKrfiVjfaAYUeNNE7XFnpy2eB+wCUR68ey9OhLPY7osmaeMOAP3zCqJEI
         5m4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJsChTwdN37E5x3lJmKg+KnIek7b6/CxdmRZQ1BCeM0=;
        b=InSrox4iz2dNBcFDxs/FazeJI9usGnff5XJ+L+/YPK04OQLgeN2fXRc4xmKJB1PYbr
         4HddVAlJ8zZ7BXVJAxmVhJdETXUkfudwRtozqnYnDrUq/7XsDRwIpgeqHr9Q7f0uY9/4
         rfXwsKVwLN77WEo8C3WB5gp+OcFKmoEfNePZ2WZmCHlwpr7cLvm3AqrDbDfXMwEa0weB
         f3awBfRVHYW8ka/XAg4YzKx9gf8rjCxqVpmEDY3zqnzU84pVkqndhZNQdibp1JlpD3sT
         iO7DHIh1p6HOnfRGLHoLt+okV3BCpGdWK7Za+mmD2kunISJKbWlfnmoOohmghWFMqdea
         f6Nw==
X-Gm-Message-State: AOAM533/2FaXDf+aurKW2xg6P55J9upoWNRfYxF9uWKKtlWfsIlblJ+1
        SiQ1cES8xK5MeEVYtppD//BfkB6MuKOIqurYJ8I=
X-Google-Smtp-Source: ABdhPJwrpc5aX1zB7Z08UVtL8DKGHVhvnw9EVpbiHyfKh3R5PO9a2vKZuN3DH2e3va/TR8fYY/eERW7XWRTfX7gVs6A=
X-Received: by 2002:a5b:3c4:: with SMTP id t4mr4120096ybp.510.1612508802880;
 Thu, 04 Feb 2021 23:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20210204193622.3367275-1-kpsingh@kernel.org>
In-Reply-To: <20210204193622.3367275-1-kpsingh@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 4 Feb 2021 23:06:32 -0800
Message-ID: <CAEf4BzaJ6Pt5UAEoD9pOMKbmz+n=tV7gvZus59bSDNExQc3F8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] BPF Ringbuffer + Sleepable Programs
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 4, 2021 at 11:36 AM KP Singh <kpsingh@kernel.org> wrote:
>
> # v1 -> v2
>
> - Use ring_buffer__consume without BPF_RB_FORCE_WAKEUP as suggested by
>   Andrii
> - Use ASSERT_OK_PTR macro
>
> Sleepable programs currently do not have access to any ringbuffer and
> since the perf ring buffer is a per-cpu map, it would not be trivial to
> enable for sleepable programs. Our specific use-case is to use the
> bpf_ima_inode_hash helper and write the hash to a ring buffer from a
> sleepable LSM hook.
>
> This series allows the BPF ringbuffer to be used in sleepable programs
> (tracing and lsm). Since the helper prototypes were already exposed
> the only change required was have the verifier allow
> BPF_MAP_TYPE_RINGBUF for sleepable programs. The ima test is also
> modified to use the ringbuffer instead of global variables.
>
> Based on dicussions we had over the BPF office hours and enabling all
> the possible debug options, I could not find any issues or warnings when
> using the ring buffer from sleepable programs.
>
>
>
> KP Singh (2):
>   bpf: Allow usage of BPF ringbuffer in sleepable programs
>   bpf/selftests: Update the IMA test to use BPF ring buffer
>
>  kernel/bpf/verifier.c                         |  2 ++
>  .../selftests/bpf/prog_tests/test_ima.c       | 23 ++++++++++---
>  tools/testing/selftests/bpf/progs/ima.c       | 33 ++++++++++++++-----
>  3 files changed, 45 insertions(+), 13 deletions(-)
>
> --
> 2.30.0.365.g02bc693789-goog
>

Bot didn't send a notification. This was applied to bpf-next.
