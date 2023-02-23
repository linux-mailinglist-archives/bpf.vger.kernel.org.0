Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E6D6A0E10
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 17:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjBWQbg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 11:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjBWQbd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 11:31:33 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B79755063;
        Thu, 23 Feb 2023 08:31:32 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o12so44631819edb.9;
        Thu, 23 Feb 2023 08:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJiynkHcOYvpWdeg6eMjPakqPz+s/GM+Q1PI5yS7B8c=;
        b=BdsblZ9BX7Y/pc8NE++33YGUAoPexThAHO4nLvYIf+QRGEztKDMqtKlTBVlBWnnnZB
         MY/t5+lORQUJIwnifqLRMKy2kJFgD85blubqnnEIIhrg3u+bNzQNvOvLDLyZGupBrjWs
         o3AwKGNYmsLnprzqSVuGMsXhuuvkhNWE6nfCZqa79dTnv2ArMozm8eZ/ipZJ6Djg5lZ7
         uH4154PlZaY4MskKHO4DdDALP2QXFiFcGTiRoqb3nwKk0UoVOXIryozQJro9k/hduTVv
         0TDEbu6ok21NtJYqqS7LnbCnpMCrTRarmWLtGizxclCfO60h2FeSCkBqVCInQNwJP+nJ
         oITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJiynkHcOYvpWdeg6eMjPakqPz+s/GM+Q1PI5yS7B8c=;
        b=BMHzG1qTmcIWcZiMJUBNnmgtHm/DQ0TV2WvZzQnuDrTyTBNFHPzFWQP29s+t9tAsU0
         PiKjohKVFAp12fhH5X4CCDM8zLefWJCTNMhrGWBnJ8x07qatWkJDvjvrj5QFaD/CMhSp
         v+xbI6iOZa56oZErFB6LR0CJnNkjnIa/BfKE/fbKo2ZAr4zKDonKnP7sih0GZQmHt1Qt
         Lf5tfLVMVCvzLj7lU4R/qK43mPjd2qslN85R3MUbmrUO3zKNvBHG1ekIGl+oK49Y0snM
         Bxa5OxSBAnShp170eV83sQDCyHELy57HPPFULBHA5FWtYB55P7wv4PL41KwlaPqwZgMS
         b6Jw==
X-Gm-Message-State: AO0yUKW0+z3n2MNlOdW+SUZVQAXOS6zAN62fBa7gDq66tMH04492O2Eq
        d31nWtPy8QT7cD4ttztq/admdYYJq9SiN5lzOXo=
X-Google-Smtp-Source: AK7set9s1bUxaieJq5s1ZS+BG4ANOJQRUOUFQ9UbUfvNSbAfBygtZo/7vkmzGsioUpxTZdnozd9bVIK8y96BIvfyVz0=
X-Received: by 2002:a17:906:2495:b0:8b1:78b8:4207 with SMTP id
 e21-20020a170906249500b008b178b84207mr10774401ejb.3.1677169890461; Thu, 23
 Feb 2023 08:31:30 -0800 (PST)
MIME-Version: 1.0
References: <20230221151846.2218217-1-tero.kristo@linux.intel.com>
In-Reply-To: <20230221151846.2218217-1-tero.kristo@linux.intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 23 Feb 2023 08:31:19 -0800
Message-ID: <CAADnVQKmAEd3GTLC1GeP2hFtQUuaYZAkbV3Sk5-75x2jmmybLA@mail.gmail.com>
Subject: Re: [RESEND PATCH] bpf: Add support for absolute value BPF timers
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Feb 21, 2023 at 7:21 AM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>
> Add a new flag BPF_F_TIMER_ABS that can be passed to bpf_timer_start()
> to start an absolute value timer instead of the default relative value.
> This makes the timer expire at an exact point in time, instead of a time
> with latencies and jitter induced by both the BPF and timer subsystems.
> This is useful e.g. in certain time sensitive profiling cases, where we
> need a timer to expire at an exact point in time.

"certain time sensitive profiling cases" is too vague.

Please precisely describe the use case.

> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
>  include/uapi/linux/bpf.h | 15 +++++++++++++++
>  kernel/bpf/helpers.c     | 11 +++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 464ca3f01fe7..7f5b71847984 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4951,6 +4951,12 @@ union bpf_attr {
>   *             different maps if key/value layout matches across maps.
>   *             Every bpf_timer_set_callback() can have different callback_fn.
>   *
> + *             *flags* can be one of:
> + *
> + *             **BPF_F_TIMER_ABS**
> + *                     Start the timer in absolute expire value instead of the
> + *                     default relative one.
> + *
>   *     Return
>   *             0 on success.
>   *             **-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier
> @@ -7050,4 +7056,13 @@ struct bpf_core_relo {
>         enum bpf_core_relo_kind kind;
>  };
>
> +/*
> + * Flags to control bpf_timer_start() behaviour.
> + *     - BPF_F_TIMER_ABS: Timeout passed is absolute time, by default it is
> + *       relative to current time.
> + */
> +enum {
> +       BPF_F_TIMER_ABS = (1ULL << 0),
> +};
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index af30c6cbd65d..924849d89828 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1253,10 +1253,11 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
>  {
>         struct bpf_hrtimer *t;
>         int ret = 0;
> +       enum hrtimer_mode mode;
>
>         if (in_nmi())
>                 return -EOPNOTSUPP;
> -       if (flags)
> +       if (flags > BPF_F_TIMER_ABS)
>                 return -EINVAL;
>         __bpf_spin_lock_irqsave(&timer->lock);
>         t = timer->timer;
> @@ -1264,7 +1265,13 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
>                 ret = -EINVAL;
>                 goto out;
>         }
> -       hrtimer_start(&t->timer, ns_to_ktime(nsecs), HRTIMER_MODE_REL_SOFT);
> +
> +       if (flags & BPF_F_TIMER_ABS)
> +               mode = HRTIMER_MODE_ABS_SOFT;
> +       else
> +               mode = HRTIMER_MODE_REL_SOFT;
> +
> +       hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);

The patch looks fine, but please add a selftest for new functionality
in the 2nd patch and resend them together.
