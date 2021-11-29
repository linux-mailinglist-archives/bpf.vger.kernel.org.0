Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9E84627F5
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 00:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbhK2XQa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 18:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbhK2XQJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 18:16:09 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F43C0C2344
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 14:55:48 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id v64so46854399ybi.5
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 14:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6Mnx4w0akf050BCbAHxNmiCQz+3Stwvv6BMamywb1U=;
        b=VQ4uYqqtVyKHBsaBZju/e8/Uykb4qSxwti4KAO5SGdQH12zBkIscCtX68IqrMRfJ43
         062mQmafOTBF0ymxTYEdzEta1s/JrBl4Cr8iSpLjkIDIC6RdfDipimYged6/GRDPmE9y
         cT6y9iZT1U9EFDJG/lf0Ioobe4WdcWAF0lPRi2nk9fTusiYOQBM+lc0rm0ujMWbKbSPq
         sMZGDrTo01uhHTqD5K7X8H+HbKHpfsupHl5sGxjIQM15FK7UBYKotL8hrXs6WI7MKmks
         LNo4Qyia3EwSvpsOH7IGpyHsSP2yDXQ+yTYj2MUYRHodvDcopUqW4cIW7ACECe+gXCm6
         iwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6Mnx4w0akf050BCbAHxNmiCQz+3Stwvv6BMamywb1U=;
        b=A916WlIueRMvDmZuq0QmcwtYtjukdBS5CrXZkj7KCoJGb42UADL5KzwB4geglOvcVE
         p0fmK9R7LWfcJ+QJzvZNuwCo3tlpkVEen4vJ/Z9OdyCzoENBdXMZv1L21D6dhenVhzjg
         PfoWLFCcTogswrLnyRuMmAxY6eFbBpVN1OfVZkf464dvkxDBTYLA/HwKLB9xqADOMrB7
         ISujH8YetU+wECwWzXJpkYE5mevhJhR4/+dqZ2bqOv6lBMrMajKgXLyHuKkYr7ZWWAhF
         k+6lc4vdxXyPDtaZ1DhUIkh1j6I3wvKkjhM6JCewSwrvMVwARgqhGffKT0GlcKRfPB+k
         yuQQ==
X-Gm-Message-State: AOAM531hpqH/+YnVKf51waVO+Ss/ZodQGQJQ5MjNJvGbAelDj4Srxpr+
        +G5XfV2EyfZ8B13obbcBpHNSdx4+bh0RLGearxc=
X-Google-Smtp-Source: ABdhPJyW18fNPyGcZv4tbcNJn2OtK3HBaBFUelqg3wfS9HAJTtx+U/lCj2jpYHBvRwC2ddJ5BncL8n68CQwihyH2Rew=
X-Received: by 2002:a25:54e:: with SMTP id 75mr36255536ybf.393.1638226547813;
 Mon, 29 Nov 2021 14:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20211129223725.2770730-1-joannekoong@fb.com> <20211129223725.2770730-4-joannekoong@fb.com>
In-Reply-To: <20211129223725.2770730-4-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Nov 2021 14:55:36 -0800
Message-ID: <CAEf4BzbSbYow+SmiggZtd0sD32zV0xA+b6itv-aOprKpmDiZgw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/4] selftests/bpf: measure bpf_loop verifier performance
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 29, 2021 at 2:39 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> This patch tests bpf_loop in pyperf and strobemeta, and measures the
> verifier performance of replacing the traditional for loop
> with bpf_loop.
>
> The results are as follows:
>
> ~strobemeta~
>
> Baseline
>     verification time 6808200 usec
>     stack depth 496
>     processed 554252 insns (limit 1000000) max_states_per_insn 16
>     total_states 15878 peak_states 13489  mark_read 3110
>     #192 verif_scale_strobemeta:OK (unrolled loop)
>
> Using bpf_loop
>     verification time 31589 usec
>     stack depth 96+400
>     processed 1513 insns (limit 1000000) max_states_per_insn 2
>     total_states 106 peak_states 106 mark_read 60
>     #193 verif_scale_strobemeta_bpf_loop:OK
>
> ~pyperf600~
>
> Baseline
>     verification time 29702486 usec
>     stack depth 368
>     processed 626838 insns (limit 1000000) max_states_per_insn 7
>     total_states 30368 peak_states 30279 mark_read 748
>     #182 verif_scale_pyperf600:OK (unrolled loop)
>
> Using bpf_loop
>     verification time 148488 usec
>     stack depth 320+40
>     processed 10518 insns (limit 1000000) max_states_per_insn 10
>     total_states 705 peak_states 517 mark_read 38
>     #183 verif_scale_pyperf600_bpf_loop:OK
>
> Using the bpf_loop helper led to approximately a 99% decrease
> in the verification time and in the number of instructions.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../bpf/prog_tests/bpf_verif_scale.c          | 12 +++
>  tools/testing/selftests/bpf/progs/pyperf.h    | 71 +++++++++++++++++-
>  .../selftests/bpf/progs/pyperf600_bpf_loop.c  |  6 ++
>  .../testing/selftests/bpf/progs/strobemeta.h  | 75 ++++++++++++++++++-
>  .../selftests/bpf/progs/strobemeta_bpf_loop.c |  9 +++
>  5 files changed, 169 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/pyperf600_bpf_loop.c
>  create mode 100644 tools/testing/selftests/bpf/progs/strobemeta_bpf_loop.c
>

[...]

>                 /* Unwind python stack */
>                 for (int i = 0; i < STACK_MAX_LEN; ++i) {
>                         if (frame_ptr && get_frame_data(frame_ptr, pidData, &frame, &sym)) {
> @@ -251,6 +319,7 @@ int __on_event(struct bpf_raw_tracepoint_args *ctx)
>                                 frame_ptr = frame.f_back;
>                         }
>                 }
> +#endif /* USE_BPF_LOOP */
>                 event->stack_complete = frame_ptr == NULL;
>         } else {
>                 event->stack_complete = 1;
> diff --git a/tools/testing/selftests/bpf/progs/pyperf600_bpf_loop.c b/tools/testing/selftests/bpf/progs/pyperf600_bpf_loop.c
> new file mode 100644
> index 000000000000..bde8baed4ca6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/pyperf600_bpf_loop.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2021 Facebook

nit: should be /* ... */

> +
> +#define STACK_MAX_LEN 600
> +#define USE_BPF_LOOP
> +#include "pyperf.h"

[...]

> diff --git a/tools/testing/selftests/bpf/progs/strobemeta_bpf_loop.c b/tools/testing/selftests/bpf/progs/strobemeta_bpf_loop.c
> new file mode 100644
> index 000000000000..e6f9f920e68a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/strobemeta_bpf_loop.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +// Copyright (c) 2021 Facebook

same

> +
> +#define STROBE_MAX_INTS 2
> +#define STROBE_MAX_STRS 25
> +#define STROBE_MAX_MAPS 100
> +#define STROBE_MAX_MAP_ENTRIES 20
> +#define USE_BPF_LOOP
> +#include "strobemeta.h"
> --
> 2.30.2
>
