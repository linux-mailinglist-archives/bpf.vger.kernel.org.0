Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8206C5DCC
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 05:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjCWEKg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 00:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjCWEKe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 00:10:34 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F38B10CA
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 21:10:33 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id b18so4379412ybp.1
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 21:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679544632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lcSWN3GyBfovXV1vZTMtcIYaPrkreWXQ9n4Cq5J+k0=;
        b=rsH6Q3RSuOVN3v4OApWCK2fKM+hkdBWgfdvhHyQzW5Pw+plPTNi9t2m+UBHsGzWBhv
         Pk3rTZw8S6erq7968367WPneS5lOiBB263QMPQIVZosoB7XgLrX5yK+4fD9eP3bHitsO
         uvxzf7qEvXAmJrFSpdvQ60LIHlUll8cmFnmqKpFZ1USUIBElYfXVEPUVMOIKgSNihg2n
         nslvhDFRmKyaFgWa0Y1XYP6jxLvfUtJtMY/+Q2dg//gD1t2dlL7SklCJpgAJluQNrVEh
         IC06YYalM2n8mMSw7nA8J/qZlHYoX/dOLHyJZPURTxp1XDJGlwr9WTpY2AlVLpaX4gxi
         gAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679544632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lcSWN3GyBfovXV1vZTMtcIYaPrkreWXQ9n4Cq5J+k0=;
        b=0PDvpO5/u1B37tZnhfJKitpdDfe1Yq9n40t6AOw0fJ4CLJsH7nWlTKSSn1+cukGFVv
         Ej1zSQ/+uNRgdcd2mNXvhvh7rbN0C/HVZXyNS+FSwePBkxkXV0UF90A6MUPS2AjoxfGQ
         caXcAKHnvH0WnSgy3/EBo4V3xQ6tBaU+HomLHF2YEzTDePp8e7oMkRtBegGF+tmkHtrN
         dovMAMKfnbVH/7+/O49DOyGOG90YsmZgIcyXuWthBUlTzXKjIP2/Won9eAJdrfcrRZYu
         V/9YK/6wYlvmBLX0Eo1BLnuycaq8JPBX4nkkqFZgbPRjWfoYZOq43wM1DiCJ/8kucPsZ
         3maw==
X-Gm-Message-State: AAQBX9dbP6enh6dUpynj+1zeAHU9U3nhMGhxpNNUsVOHucmrbwFXDmxw
        2z8hD3GigRbvfP/u3BvJT8csBycTV/7Ig8u9jOxzPQ==
X-Google-Smtp-Source: AKy350aqC2PVmbH/EfzdkoR2G9mhoQxC8Y2WiV+NG8rw6zMdlkFRbTKRx4Laq0LGQE/avEssQ3AobpebGV9qYqZK2AM=
X-Received: by 2002:a25:800d:0:b0:b3b:6576:b22b with SMTP id
 m13-20020a25800d000000b00b3b6576b22bmr1346202ybk.12.1679544632180; Wed, 22
 Mar 2023 21:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
In-Reply-To: <20230323040037.2389095-1-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 22 Mar 2023 21:10:21 -0700
Message-ID: <CALvZod5uyZRsvA5ntw0jSBXUNa1_HzB9zOabsGKsndyA5KCYnQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Make rstat flushing IRQ and sleep friendly
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
> Currently, if rstat flushing is invoked using the irqsafe variant
> cgroup_rstat_flush_irqsafe(), we keep interrupts disabled and do not
> sleep for the entire flush operation, which is O(# cpus * # cgroups).
> This can be rather dangerous.
>
> Not all contexts that use cgroup_rstat_flush_irqsafe() actually cannot
> sleep, and among those that cannot sleep, not all contexts require
> interrupts to be disabled.

Too many negations in the above sentence is making it very confusing.
