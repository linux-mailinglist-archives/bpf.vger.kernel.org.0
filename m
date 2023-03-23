Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5276C5FC5
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 07:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCWGeI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 02:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCWGeC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 02:34:02 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD442B9D0
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 23:33:58 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-541a05e4124so379285197b3.1
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679553238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4npRT0ZBm4ONH6zdpwhBbu8AXu0dsqmRu8iUAcRhwn4=;
        b=Jz1+PRu0n2E15Vf/qVjLQyMAiMh0wcsZxyHdXjjLSylh8kOTYeud4m+r7TyiYDDIwY
         AxsoBwLqHysKwhK8ZhCrxd++CTHeifnZx2H/a7f6897A8184FcTnA8nkSly0zpDgPi8l
         TKdXhZ2aJZmAatpzBOs+lBb7LUlbNYb+axNHN1pnyDXlerc97Ur9a03S8UXOF+Zd74k4
         gqkj6iLTsEnSJQbd2l4qo+JewrHaebREOudXM1ZFKVj+/O7sw5rZ7K4qyVJ/GRsIz6X7
         YYb2KoWhc8MlSNAC5BHhIQEHo2dus1NCcP6Sq5RMpw3G+MhaBbrd5GDjSKW2etMYFYuA
         FiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679553238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4npRT0ZBm4ONH6zdpwhBbu8AXu0dsqmRu8iUAcRhwn4=;
        b=bkEGv43pbWpDtfo3Gm3L2gqY+lwcw85Q7yEyvYxLpU34smx7KvvlUGC4lK2PWzPTIl
         zXtoLC8ZbFb/8eUGecRh1pIr8X0dbhppLZV+pAjXBNtaRHWbgsYfe7cuphSY74p37tV0
         xGW/g07+iw2Caf0sewCOc3pjo8L/2i5Y2G308rqRV2EtDX7jZ6r2anFyJphcXNYUAts9
         Fk2Shdx7sFR1qC6DrqkRhqrX9mb62Bzvr/QzZ3tdP3f4H9yh9My78uUsET/UydWq34Le
         xDZ8VmHg4q/synoJuTkrfbA1ktYotuk6lpZMs5bba+7F8N8njy9T+gBt0aOKtq3faED7
         biKA==
X-Gm-Message-State: AAQBX9c8lhpapaOgeLzcSRQ6OiztVzr/kdU83iotNp4PgxlwtTXH9UBZ
        9pN2OIKCvgYzv4SncERVkwukATuE7kJo5KxflQ2NvA==
X-Google-Smtp-Source: AKy350aHHQKdZp4F3yh5LRMUAbDOYYx+U8YW/TWmS88VUzuhypP1degkbjLzws2GkQD3eUT2N+VpjDY6LDIYMpAhu5A=
X-Received: by 2002:a81:ae1c:0:b0:52e:e095:d840 with SMTP id
 m28-20020a81ae1c000000b0052ee095d840mr1330885ywh.0.1679553237698; Wed, 22 Mar
 2023 23:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <CALvZod7e7dMmkhKtXPAxmXjXQoTyeBf3Bht8HJC8AtWW93As3g@mail.gmail.com>
 <CAJD7tkbziGh+6hnMysHkoNr_HGBKU+s1rSGj=gZLki0ALT-jLg@mail.gmail.com>
In-Reply-To: <CAJD7tkbziGh+6hnMysHkoNr_HGBKU+s1rSGj=gZLki0ALT-jLg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 22 Mar 2023 23:33:46 -0700
Message-ID: <CALvZod5GT=bZsLXsG500pNkEJpMB1o2KJau4=r0eHB-c8US53A@mail.gmail.com>
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

On Wed, Mar 22, 2023 at 10:15=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
[...]
> > Couple of questions:
> >
> > 1. What exactly is cgroup_rstat_lock protecting? Can we just remove it
> > altogether?
>
> I believe it protects the global state variables that we flush into.
> For example, for memcg, it protects mem_cgroup->vmstats.
>
> I tried removing the lock and allowing concurrent flushing on
> different cpus, by changing mem_cgroup->vmstats to use atomics
> instead, but that turned out to be a little expensive. Also,
> cgroup_rstat_lock is already contended by different flushers
> (mitigated by stats_flush_lock on the memcg side). If we remove it,
> concurrent flushers contend on every single percpu lock instead, which
> also seems to be expensive.

We should add a comment on what it is protecting. I think block rstat
are fine but memcg and bpf would need this.

>
> > 2. Are we really calling rstat flush in irq context?
>
> I think it is possible through the charge/uncharge path:
> memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_usage(). I
> added the protection against flushing in an interrupt context for
> future callers as well, as it may cause a deadlock if we don't disable
> interrupts when acquiring cgroup_rstat_lock.
>
> > 3. The mem_cgroup_flush_stats() call in mem_cgroup_usage() is only
> > done for root memcg. Why is mem_cgroup_threshold() interested in root
> > memcg usage? Why not ignore root memcg in mem_cgroup_threshold() ?
>
> I am not sure, but the code looks like event notifications may be set
> up on root memcg, which is why we need to check thresholds.

This is something we should deprecate as root memcg's usage is ill defined.

>
> Even if mem_cgroup_threshold() does not flush memcg stats, the purpose
> of this patch is to make sure the rstat flushing code itself is not
> disabling interrupts; which it currently does for any unsleepable
> context, even if it is interruptible.

Basically I am saying we should aim for VM_BUG_ON(!in_task()) in the
flush function rather than adding should_skip_flush() which does not
stop potential new irq flushers.
