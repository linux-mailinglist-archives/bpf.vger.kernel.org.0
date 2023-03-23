Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F606C6CDA
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 17:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCWQCu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 12:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjCWQCt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 12:02:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428A82E81D
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 09:02:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b20so55896374edd.1
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679587366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdxCtHk5BHFsSI7nCxtLNI5LUnK63CNxiy4dYgR/sK4=;
        b=QlTme/lFyoVDGKhtIAPxITQZffC97/l2oat44BkhKOQXnc7z5W55mV5A44zPZ8OGX6
         ieCQS9QJJe04JPyGxmvKoxYcb/6gQvd8J2I8xk4kzIExvTBSFeUJ3fpgJT80yPCg0j3n
         KVOa+0j43EavuVRfPpI2YeoOpHD2sYJ8JORlybIjrlpmdZq0xNZpet1HPVPAsNx1EyNw
         imyiMcCNDyrct+tw5WnnPBMwbfXgBSsHluGWQ9dzfC5g79d1pB3qvkF5UzSptGRUNLx2
         RqDfaKK3gyCo40qWY0d2X7soZJSq46RP/P8uVQRQH4A39erkept9iI80vCztx4p5iEEi
         K1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679587366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdxCtHk5BHFsSI7nCxtLNI5LUnK63CNxiy4dYgR/sK4=;
        b=IaCLEng35yfeYIW6T24/JZZMzGi1fcnSvGco9SncFhQ/DBrdyO97/nWCfUpRX3SKSo
         /Yk0rrwF4dvsw68RpyMl5lLXDhkltux+omcBseGQrPdw2xz9K+BNgqp2Gd/pzJBYfHGS
         6Pn4Igl6P/777o4CiTrnZhxPVWSeKwtoNkKkIilLxWZmoBh9nsDfgmgajUE8E3jvh9bn
         ivhfU9W+Vf4kJn08AdF+OhWdBJ2b+IMwUKr06+GwiPE8cgOfGmwm8yhdprbBjGtCsVgQ
         HSrkokjP9BTf2Vn5zRk0euQBjnQNgmJplzZpFZ7S2F2kqmWYleLsYiwtnNy8TJqiOhtI
         AdQw==
X-Gm-Message-State: AO0yUKWry53a74m3WRDyojk/fz3Fd9uxhZ/BMxLkYNNuMQ3qXrnTCbu4
        XpwJ8w644vZIF1Mv+j2YrE4qqO937pmYSz1b5DGCgg==
X-Google-Smtp-Source: AK7set990Oll8W/SXU/i0j17c5vuX4anYSeMLFlhYksbJJFOfM6VZxj2yzvlsoVTIsqgNYyJr8BxTWFke55LyxTw83E=
X-Received: by 2002:a17:906:34cd:b0:8e5:411d:4d09 with SMTP id
 h13-20020a17090634cd00b008e5411d4d09mr5207317ejb.15.1679587365591; Thu, 23
 Mar 2023 09:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-7-yosryahmed@google.com> <20230323155040.GB739026@cmpxchg.org>
In-Reply-To: <20230323155040.GB739026@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 23 Mar 2023 09:02:09 -0700
Message-ID: <CAJD7tkZ7d_ZFdcfOdZGSeL9i46cyEV+p2rPm0gotvRT8u8atpw@mail.gmail.com>
Subject: Re: [RFC PATCH 6/7] workingset: memcg: sleep when flushing stats in workingset_refault()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
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

On Thu, Mar 23, 2023 at 8:50=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Mar 23, 2023 at 04:00:36AM +0000, Yosry Ahmed wrote:
> > In workingset_refault(), we call mem_cgroup_flush_stats_delayed() to
> > flush stats within an RCU read section and with sleeping disallowed.
> > Move the call to mem_cgroup_flush_stats_delayed() above the RCU read
> > section and allow sleeping to avoid unnecessarily performing a lot of
> > work without sleeping.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >
> > A lot of code paths call into workingset_refault(), so I am not
> > generally sure at all whether it's okay to sleep in all contexts or not=
.
> > Feedback here would be very helpful.
>
> Yes, it's safe.

Thanks! That's very helpful!
