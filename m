Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981B330EBB3
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 06:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhBDFDS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 00:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhBDFDR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 00:03:17 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FC2C061573
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 21:02:37 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id g9so1488662ilc.3
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 21:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fSSQn60vWBaWXLJ61oy8EmRJ7mfSIUVBhzenGVreTM=;
        b=jB4yFdcDfojgMqRVernkW50mVxDWdlQYV2x0s4qsQ9dSdrFw8miM07fIQmonvuVLuN
         64VaiDzybc7DQCRdCS/qgNICNykGSHkTDp5jcBtEja8Zr1H13ya2J1czqiPJeCBz5cMk
         uDtw+HqbI51nIN8zHVeh1ArlBQu3BTexYP84JmWgImIkmFTW6eF7YOcDegLPT5qohk74
         G/kJkFD5Ga+M2WAsvYhnP1x5GpCkaiN/lbBGS16PYuBVwbxvFpzA8GWr81EYKJzuvZpa
         6b1dbQSvF9oFVgPz8mNQyzDST1+ob0T50+lEwiwBptGHTq39DxBKJG9gT5W+4lDb8yPb
         1tTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fSSQn60vWBaWXLJ61oy8EmRJ7mfSIUVBhzenGVreTM=;
        b=cY5IK/hWaSCLqUdQ5RYmNvQgPIvB+1x3glM71Mcp4uJRYzm/9EHdNrFpjKx2Sgm72d
         GeLipP/AZ5eEZQJWoJm+Dc3H4Lut7cG+gRfVq2jllKX2fWhKiVSwquKi+t4ByS28EnxK
         qkhixckUo1KIhaPkYEnRUF+zs4s4QPvFscaPRttFi5BMdV3L9x09Bhpg19lPEIbSW4rV
         5vmDDRtEcQyS9fbJ2zQrUR0067zYEL+aBkClmfrOkOC17J4ey8AF/BixXtU5pT1sA+VS
         pl75Iphxl1dSU7BfBg3ZE7oo02Hsa0fundQCBhC1TBGhNwmGHGqpb6Iuaiah+8s4GOpO
         Bdzg==
X-Gm-Message-State: AOAM531IMJjkgG7nOJb5SRchAgfRE6mAbQRRvORLQ/KdQyB/4h6d0u5S
        IGuqPpTIMICcNxCcH6+FNtVPHlABpGVrbWAkMlM=
X-Google-Smtp-Source: ABdhPJypz8XhO2m2Nu/XIies4PZ9Ue0sILVUOp22F5EBPg/I1xh8n0a7QJ/4QnoJbsmhugwoebdpMrJzUVqSiuk7KaQ=
X-Received: by 2002:a92:cd8e:: with SMTP id r14mr5308071ilb.77.1612414956821;
 Wed, 03 Feb 2021 21:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20210203232331.2567162-1-kpsingh@kernel.org> <20210203232331.2567162-2-kpsingh@kernel.org>
In-Reply-To: <20210203232331.2567162-2-kpsingh@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Feb 2021 21:02:26 -0800
Message-ID: <CAEf4BzYkUTqTghp0J4qhwaS-fCr=koYwn1f9Jd10412vZF7DUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow usage of BPF ringbuffer in
 sleepable programs
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

On Wed, Feb 3, 2021 at 3:23 PM KP Singh <kpsingh@kernel.org> wrote:
>
> The BPF ringbuffer map is pre-allocated and the implementation logic
> does not rely on disabling preemption or per-cpu data structures. Using
> the BPF ringbuffer sleepable LSM and tracing programs does not trigger
> any warnings with DEBUG_ATOMIC_SLEEP, DEBUG_PREEMPT,
> PROVE_RCU and PROVE_LOCKING and LOCKDEP enabled.
>
> This allows helpers like bpf_copy_from_user and bpf_ima_inode_hash to
> write to the BPF ring buffer from sleepable BPF programs.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---

Yes, I believe ringbuf is ready for sleepable BPF as is. Its commit()
implementation is racing with other CPUs anyways, so it doesn't matter
if reserve and commit happen on the same CPU or different ones.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/verifier.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5e09632efddb..4c33b4840438 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10024,6 +10024,8 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
>                                 return -EINVAL;
>                         }
>                         break;
> +               case BPF_MAP_TYPE_RINGBUF:
> +                       break;
>                 default:
>                         verbose(env,
>                                 "Sleepable programs can only use array and hash maps\n");
> --
> 2.30.0.365.g02bc693789-goog
>
