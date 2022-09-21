Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944135E56C4
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 01:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIUXde (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 19:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIUXdd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 19:33:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1529A5980;
        Wed, 21 Sep 2022 16:33:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y17so17236519ejo.6;
        Wed, 21 Sep 2022 16:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wcBwRfOcQ0aBAEAgR2fCpIMAURfzSlApHm2GvjuJp+I=;
        b=QiG5+P5UyRh+xcWeHuWwWXVwsmEl3xKYP0TkikiZvurzaYzDbNmEEVLI5FmB0MIfgt
         pag5jJepynQEHN/+t3aUVs8GmXMtDDoUIyRovTtXxTof7TqA13a95FH2Lg7xUDuxM/2A
         jvbbKgQ5dTvOGhDsMsJgIwtvNCpiRKLheP9tYl3q/i3lXbHqNiXNm7IWceL+AlyE3sCt
         dcnPBkaIMA8I6M0gJN8+1/2LoNCO9GpbQE+tptun9J+iwWlrcUZWjIH+s9iRKRnh/3l3
         JsjLxEIOk5lvQQ+uWgbaDiv6ha8angSfIc8MqQZ1gVA1YmsZN/GJ771kyqelJPqwDDZV
         adRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wcBwRfOcQ0aBAEAgR2fCpIMAURfzSlApHm2GvjuJp+I=;
        b=pMypRiL1wX1XzOFNbID3R1jti4nxHDHmfDKQso3d+pxi3f1O9a3XpGSxbckyu8lLg6
         R4K1P8iYQDX5I2guiVuZvrBcHZk0jPv2KfL/KV+tH3Qz2x3txiNamponG7yn/GgbHG2Y
         kgvvxcrH/qNMCqf0GQNTC0NkjUsCigRfpg5tKMmPwvVogyv1NIpJXPxRWShotBHqKI+j
         4pF6zwjasJbvZW6PZNur7gMNeccHx8VwdYHSj4QjwdmsCw6cqu8BhBpNiTy/TZW4n2Fz
         u+DgTba/bib5MgkHnaH6LHmH06k8JHo+/RfPTzhe9kOQWCg612ou0Omdpgh57/Yu+kdP
         WxSA==
X-Gm-Message-State: ACrzQf2ajeVNFAgq2uR1fAEf4pXqSGz9/lW3JiBgymKFLgZ2QBKs0YQ4
        nxWHfK5j7/6xfQ8u4J4VUVys6LSOlggj9ydHLuk=
X-Google-Smtp-Source: AMsMyM6+QFIVTHOS3tuB+2McWRGJl9t/4olnCXq9ndUaWJsvK03ifHsJOjfhEbmrLu4hk1RTx4Bbe8/G2z1OgAYZJC4=
X-Received: by 2002:a17:906:99c5:b0:73d:70c5:1a4f with SMTP id
 s5-20020a17090699c500b0073d70c51a4fmr529596ejn.302.1663803210145; Wed, 21 Sep
 2022 16:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220920000100.477320-1-void@manifault.com> <20220920000100.477320-3-void@manifault.com>
In-Reply-To: <20220920000100.477320-3-void@manifault.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 21 Sep 2022 16:33:18 -0700
Message-ID: <CAEf4Bzb1AHvn1=P=1_P84r35NyFtAN1B=zNtJ13po_JORjqBvA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] bpf: Add bpf_user_ringbuf_drain() helper
To:     David Vernet <void@manifault.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, kernel-team@fb.com, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org,
        brho@google.com, joshdon@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 19, 2022 at 5:01 PM David Vernet <void@manifault.com> wrote:
>
> In a prior change, we added a new BPF_MAP_TYPE_USER_RINGBUF map type which
> will allow user-space applications to publish messages to a ring buffer
> that is consumed by a BPF program in kernel-space. In order for this
> map-type to be useful, it will require a BPF helper function that BPF
> programs can invoke to drain samples from the ring buffer, and invoke
> callbacks on those samples. This change adds that capability via a new BPF
> helper function:
>
> bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void *ctx,
>                        u64 flags)
>
> BPF programs may invoke this function to run callback_fn() on a series of
> samples in the ring buffer. callback_fn() has the following signature:
>
> long callback_fn(struct bpf_dynptr *dynptr, void *context);
>
> Samples are provided to the callback in the form of struct bpf_dynptr *'s,
> which the program can read using BPF helper functions for querying
> struct bpf_dynptr's.
>
> In order to support bpf_ringbuf_drain(), a new PTR_TO_DYNPTR register
> type is added to the verifier to reflect a dynptr that was allocated by
> a helper function and passed to a BPF program. Unlike PTR_TO_STACK
> dynptrs which are allocated on the stack by a BPF program, PTR_TO_DYNPTR
> dynptrs need not use reference tracking, as the BPF helper is trusted to
> properly free the dynptr before returning. The verifier currently only
> supports PTR_TO_DYNPTR registers that are also DYNPTR_TYPE_LOCAL.
>
> Note that while the corresponding user-space libbpf logic will be added
> in a subsequent patch, this patch does contain an implementation of the
> .map_poll() callback for BPF_MAP_TYPE_USER_RINGBUF maps. This
> .map_poll() callback guarantees that an epoll-waiting user-space
> producer will receive at least one event notification whenever at least
> one sample is drained in an invocation of bpf_user_ringbuf_drain(),
> provided that the function is not invoked with the BPF_RB_NO_WAKEUP
> flag. If the BPF_RB_FORCE_WAKEUP flag is provided, a wakeup
> notification is sent even if no sample was drained.
>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  include/linux/bpf.h            |  11 +-
>  include/uapi/linux/bpf.h       |  38 +++++++
>  kernel/bpf/helpers.c           |   2 +
>  kernel/bpf/ringbuf.c           | 181 ++++++++++++++++++++++++++++++++-
>  kernel/bpf/verifier.c          |  61 ++++++++++-
>  tools/include/uapi/linux/bpf.h |  38 +++++++
>  6 files changed, 320 insertions(+), 11 deletions(-)

[...]

>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5599,6 +5636,7 @@ union bpf_attr {
>         FN(tcp_raw_check_syncookie_ipv4),       \
>         FN(tcp_raw_check_syncookie_ipv6),       \
>         FN(ktime_get_tai_ns),           \
> +       FN(user_ringbuf_drain),         \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 41aeaf3862ec..66217b1857ca 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1627,6 +1627,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>                 return &bpf_dynptr_write_proto;
>         case BPF_FUNC_dynptr_data:
>                 return &bpf_dynptr_data_proto;
> +       case BPF_FUNC_user_ringbuf_drain:
> +               return &bpf_user_ringbuf_drain_proto;

In light of [0], where we now allow dynptr only with CAP_BPF, I've
moved this lower behind CAP_BPF check while applying. Thanks!

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20220921143550.30247-1-memxor@gmail.com/

>         default:
>                 break;
>         }

[...]
