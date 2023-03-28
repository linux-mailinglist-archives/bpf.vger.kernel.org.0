Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0886CCD23
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 00:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjC1WXC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 18:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC1WXB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 18:23:01 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6D61711
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 15:22:57 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id j7so17114651ybg.4
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 15:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680042177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCAIkG55HtgTgeeRyM2LPLIQ+aIh7Nh2hkiAa5cCBwg=;
        b=QsUgxmdBFjx2fggMQtn27q0RRdVCUWYTz0i8+FCXIwK619aGEY1TrTPQymvbtyhREC
         ulFrGxVcn+Mdri8CO5Vmk6crLqOUAorpKswBROxrwle1iw1uQ6WpKcJWTJUVAMtftAcB
         AWVR+dBiE0aGGYSwZpoZ4qJqN7I1FLHpPFQcf+BioiGM7rGzBqBU/XqQluJyGEojr9Rh
         hY2pfUC6Tns+O+LNv2vbD/ySNyRGURK5DiICFII7AA+4Gv9BQ+JJiDNqf0a3mKpZcEf7
         SAb92ZuKhQ31A9ZhQ+Z4wXQP0xmz5JO2NoTYAV+KhShjxhwp0KuOnFyMuKBkdyU0yMzx
         Ujzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680042177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCAIkG55HtgTgeeRyM2LPLIQ+aIh7Nh2hkiAa5cCBwg=;
        b=HYCvXRTuO50LhNB7M8mFODco8i9I4Yk/AY1UzT1bMZNoNj8OGjx/OakfBrWYksgBN0
         YAcuFZh7rveYpPdGEFTkKWkJPMyKS4RpKEJ6cz0QL9jRm7sdYjGSfgWdhtc+RTv13pvY
         7MOF1KcOx/zGi9aOmAZfnePZP8GkJv4LmojDNw07XZqVsZf2+1/V1okj3ae0r7o+aWmd
         bUx/TtQPD3Uh9WEZfCO1jhLPdR8rhU6XbutcaPh5viFOd/ZC3Qayj7ycGA+IBb1vtfqL
         1L1d48zx/f7f57KNzTWm5yjyuJkXWwUz39UK+PwoOdI4LHr+GZP/wdUboxQ3j27jGXGP
         DbAg==
X-Gm-Message-State: AAQBX9cP9eLPWHXrVXSwLNlcZy92zfaQk0Vhfqi3kfD+wrGmkEnrw7Wz
        KEYrn3kpu7ipFP2HlzeUQO4ymfwH6DGPVBGFC6WKgg==
X-Google-Smtp-Source: AKy350aoG+jK7qyYPrrVsFs4V0N6g0oJyyWp8eU9DabORQutHFSpWAR4vhPbWNBm3as/7sFanvTp2tRpXvyRUA4JyeM=
X-Received: by 2002:a25:2749:0:b0:a99:de9d:d504 with SMTP id
 n70-20020a252749000000b00a99de9dd504mr11082903ybn.12.1680042177044; Tue, 28
 Mar 2023 15:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com> <20230328221644.803272-6-yosryahmed@google.com>
In-Reply-To: <20230328221644.803272-6-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 15:22:45 -0700
Message-ID: <CALvZod66XSX0Y-xRXE4MQ6cjC4j8q-Et4jz0q405RDG6AarS2g@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] memcg: replace stats_flush_lock with an atomic
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 28, 2023 at 3:17=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> As Johannes notes in [1], stats_flush_lock is currently used to:
> (a) Protect updated to stats_flush_threshold.
> (b) Protect updates to flush_next_time.
> (c) Serializes calls to cgroup_rstat_flush() based on those ratelimits.
>
> However:
>
> 1. stats_flush_threshold is already an atomic
>
> 2. flush_next_time is not atomic. The writer is locked, but the reader
>    is lockless. If the reader races with a flush, you could see this:
>
>                                         if (time_after(jiffies, flush_nex=
t_time))
>         spin_trylock()
>         flush_next_time =3D now + delay
>         flush()
>         spin_unlock()
>                                         spin_trylock()
>                                         flush_next_time =3D now + delay
>                                         flush()
>                                         spin_unlock()
>
>    which means we already can get flushes at a higher frequency than
>    FLUSH_TIME during races. But it isn't really a problem.
>
>    The reader could also see garbled partial updates, so it needs at
>    least READ_ONCE and WRITE_ONCE protection.
>
> 3. Serializing cgroup_rstat_flush() calls against the ratelimit
>    factors is currently broken because of the race in 2. But the race
>    is actually harmless, all we might get is the occasional earlier
>    flush. If there is no delta, the flush won't do much. And if there
>    is, the flush is justified.
>
> So the lock can be removed all together. However, the lock also served
> the purpose of preventing a thundering herd problem for concurrent
> flushers, see [2]. Use an atomic instead to serve the purpose of
> unifying concurrent flushers.
>
> [1]https://lore.kernel.org/lkml/20230323172732.GE739026@cmpxchg.org/
> [2]https://lore.kernel.org/lkml/20210716212137.1391164-2-shakeelb@google.=
com/
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
