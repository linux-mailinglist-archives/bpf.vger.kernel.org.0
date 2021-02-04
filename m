Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8782B30FEED
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 21:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhBDU6B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 15:58:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:43524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhBDU6B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 15:58:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34F6364FA5
        for <bpf@vger.kernel.org>; Thu,  4 Feb 2021 20:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612472240;
        bh=wd+dZFxrefmDBfAsm7xbh0uT6Li4j5Pqr6G3+nUAz9Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fuMqx7cQgzVtXILVLwv2Ja5NXxeX3+JWpBl4TsKPRDBF6yLLBLt0TVo/X5Qw1XgtO
         zE+7HTW/cGT0zs198l5nMA5LV1FLRSCZLl9WEaN+Tg430WSSY+ewcmvmUW6QC6GHRB
         peKg4o0QSWeAbN5PAD7IQs35rJYo1zS5imqOf5V1VdaEaG0Vzb4mwHwLl+F2UfmpY2
         I9xmvYJDoA6wdZRtPDnt26uOH5hhRVhwZqitISJlaA30VuGGmprS7cY2GiMsyiVII1
         6SjqvOnybl2Ezdv82dyv7stDHTapNxJSzMv2F2+g9t9/vD6RK/u98B87j87uQduSqr
         M2RARQpU4DrmQ==
Received: by mail-lj1-f169.google.com with SMTP id s18so5111256ljg.7
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 12:57:20 -0800 (PST)
X-Gm-Message-State: AOAM530eNqiUnmA8VUanaDPPgDNvWgtxtAWZolAChNYbf/aBHLbK51/j
        tOwqtGRgj02X61HlW3K8nDpXkDS4O0TpjfrFWjc=
X-Google-Smtp-Source: ABdhPJwYECWE66cd2kzODOMkYpSozFqR+2ScaYDR1q3SGofibCBVgq23f+jy0DcMDDL1GO5iVSXs556l/dmaRAA2BSI=
X-Received: by 2002:a2e:9898:: with SMTP id b24mr700260ljj.344.1612472238348;
 Thu, 04 Feb 2021 12:57:18 -0800 (PST)
MIME-Version: 1.0
References: <20210204193622.3367275-1-kpsingh@kernel.org> <20210204193622.3367275-2-kpsingh@kernel.org>
In-Reply-To: <20210204193622.3367275-2-kpsingh@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 4 Feb 2021 12:57:06 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7faA0t+VjrzDcxv0mmvB7FVDVeKyfgU+P7N5Uz+S=98A@mail.gmail.com>
Message-ID: <CAPhsuW7faA0t+VjrzDcxv0mmvB7FVDVeKyfgU+P7N5Uz+S=98A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Allow usage of BPF ringbuffer in
 sleepable programs
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 4, 2021 at 11:39 AM KP Singh <kpsingh@kernel.org> wrote:
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
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
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

Shall we update this message?

Thanks,
Song

> --
> 2.30.0.365.g02bc693789-goog
>
