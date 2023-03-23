Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D0C6C5E02
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 05:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCWEac (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 00:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCWEaM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 00:30:12 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43B72ED4F
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 21:29:58 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id z83so23448202ybb.2
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 21:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679545798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6Z12Yl5nLSsOMl2fi1BiOi6Pl2TD3G32jOrqzC3mL0=;
        b=ONDvFP8aiDe7lC9ChfSlJwxuZjUc2taO1V0gqzpNaWPq+3DUFbaJ6fBfqtYS6UBhPl
         +twFVu1wV8x5fCbwTn5V1Lihx3V6LjQiFhqoVRf026zxNZNYI0wCxZtvkrzwBlnJAHlw
         phT88TX9S6JJn8R+sNaPoepfNJXosdRUbxC7lr2EzAr2CeMtN0FpfSHp9qIwVrUphpt2
         ezZgnwr14FxwMXpOon5ciF0R3aTW1OqjXNqoit8Tl9YPD6dL6OGJbccfeA3XifU87yLl
         C6wTyQGFhHUUnuiz9u9pd87A1uzmMozyDMjNWHjTHYCARyEkS5DvcWOsJEwZLLtgBqq7
         TEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679545798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6Z12Yl5nLSsOMl2fi1BiOi6Pl2TD3G32jOrqzC3mL0=;
        b=KRqJsmrffpxD6OOLmYDIe0DK/aFLx/XgGH2GgtZs5dyIDz3vHv4JKukrUlkWIQZ8Mi
         RuNow0ZNXvQOpnl0lnZH+Lt+eXgpErjTOSfcJldJbZT1/0HGE3VouIugKQaa3W0dELB2
         iU1HhtR3T3iEB3CP1BAlftL7ZUeuf81MHJPG/12YwbyWgDxXTl+8HuRDRMNsr+VHNjDO
         ImSjRAExiqZ9ClC2mks17fhVIVw4HMC+/K2pTsuBK+1jLk5ih2JxaR8yfXD5qWxy7Mug
         K20ta4lSNl1rz1LTcb6wQVLxAXEs1JQ6np2POTgE4UcEVN+aSP/7IqJBnEjfYJdaFkGV
         3drA==
X-Gm-Message-State: AAQBX9e9KVVuXesgRkZCzHbrL0MdFOks5E62Ikp9VAH4OCkhdalkilpj
        /RjuYbaQo6ZDoNvW6GgP2VbOoAhuxtr8wxgPw4ZGfA==
X-Google-Smtp-Source: AKy350bvwKoDkJz6NowkzaLkZ6zdvv58voUujnekZCAaEex+6m5KQIjcFDWtppcsLgvYhWvL25kRP9zzUCztYKjXjB4=
X-Received: by 2002:a25:a28f:0:b0:a99:de9d:d504 with SMTP id
 c15-20020a25a28f000000b00a99de9dd504mr1328635ybi.12.1679545797854; Wed, 22
 Mar 2023 21:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com> <20230323040037.2389095-2-yosryahmed@google.com>
In-Reply-To: <20230323040037.2389095-2-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 22 Mar 2023 21:29:46 -0700
Message-ID: <CALvZod7e7dMmkhKtXPAxmXjXQoTyeBf3Bht8HJC8AtWW93As3g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Mar 22, 2023 at 9:00=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Currently, when sleeping is not allowed during rstat flushing, we hold
> the global rstat lock with interrupts disabled throughout the entire
> flush operation. Flushing in an O(# cgroups * # cpus) operation, and
> having interrupts disabled throughout is dangerous.
>
> For some contexts, we may not want to sleep, but can be interrupted
> (e.g. while holding a spinlock or RCU read lock). As such, do not
> disable interrupts throughout rstat flushing, only when holding the
> percpu lock. This breaks down the O(# cgroups * # cpus) duration with
> interrupts disabled to a series of O(# cgroups) durations.
>
> Furthermore, if a cpu spinning waiting for the global rstat lock, it
> doesn't need to spin with interrupts disabled anymore.
>
> If the caller of rstat flushing needs interrupts to be disabled, it's up
> to them to decide that, and it should be fine to hold the global rstat
> lock with interrupts disabled. There is currently a single context that
> may invoke rstat flushing with interrupts disabled, the
> mem_cgroup_flush_stats() call in mem_cgroup_usage(), if called from
> mem_cgroup_threshold().
>
> To make it safe to hold the global rstat lock with interrupts enabled,
> make sure we only flush from in_task() contexts. The side effect of that
> we read stale stats in interrupt context, but this should be okay, as
> flushing in interrupt context is dangerous anyway as it is an expensive
> operation, so reading stale stats is safer.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Couple of questions:

1. What exactly is cgroup_rstat_lock protecting? Can we just remove it
altogether?
2. Are we really calling rstat flush in irq context?
3. The mem_cgroup_flush_stats() call in mem_cgroup_usage() is only
done for root memcg. Why is mem_cgroup_threshold() interested in root
memcg usage? Why not ignore root memcg in mem_cgroup_threshold() ?
