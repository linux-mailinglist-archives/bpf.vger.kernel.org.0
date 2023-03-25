Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704456C8AED
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 05:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjCYEhs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 00:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCYEhr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 00:37:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130DEBDFC
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 21:37:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id er18so4132951edb.9
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 21:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679719064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMuWO+eqM4F8nQZaJRTjXyqs2/5MQPRiPwC4jEGB2Rs=;
        b=L+/JPY/0iREVQLvI7pggvIU85qKWyZuwLse9KHVQy00x8LnQk15zEqQ2dItfbkf8Xc
         jinjmlAjwTxba/K+cbeiot0mNiIF15Oi4eDBVwxanGDJjspzMRs/QEKZhb3nTnGG20Qk
         VCIX3A1iKO2CtSUq+wB+uKNxtSvCDACGv/ulf6pILtz7hI/K1gI6rhNEP0DsLW0t3JSg
         AzhYalbZFDACojW1EW0rFcfP25ejlhpDyTw+3o3AN5EoMcU49k0QrbmBymzShyxBd/Kn
         HTBVcaYssSwFsoVs2gUZS47oZ5CUrOJQR6m1EZ/9EUrtjdiIBWvfQH4XA7Ier1JLOUtr
         7ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679719064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMuWO+eqM4F8nQZaJRTjXyqs2/5MQPRiPwC4jEGB2Rs=;
        b=fj8/gfCv1dv4jtxyXTQr/kiNnb0qxrrGXdEs3nyeLDlUXkUNARUtNpOCG0L/7am5bR
         hj38TqFD+KJs1GrtsL98qisiZfHFvYF3hcfTFZoBIDNB7mGtXSnbteqOP2R73RmvVqPD
         A0mjzCXGReIQ1s7JKIklD4xXqAMUwZNfs+eA3r5XbW8tkGCFJ47iZ8V0gRNRUFU555+b
         WoSjlZE66ireqqXeTNkH2fFws9edOcf9b/vJZqNOWXTUXJSMVlwLUhMdXVkpYREyiyyD
         93NOXWx2txZjD2fcjiKE9WWIU5E3XLW9KNvm8Ptf40kGJ1+JQl5AyoH6cC+Fi3ajyVdC
         6wPQ==
X-Gm-Message-State: AAQBX9fWuKzLOVKSSPcj3pXu8B0kfPcipLACjVvfZgObqoqlz8ES2zuH
        EkwR+wpynprOacflebYdvbh43hxbsOpvxNVqN/iYOg==
X-Google-Smtp-Source: AKy350ajeVEN1YL/A5LyBT3MNx+S9894fnEde+UlgHop0XZQuymsxOUauOZsMlfyTFFYpSAYAe/0Nmd3XOqUQC3RIck=
X-Received: by 2002:a17:907:1c09:b0:92f:b329:cb75 with SMTP id
 nc9-20020a1709071c0900b0092fb329cb75mr3153111ejc.5.1679719064436; Fri, 24 Mar
 2023 21:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <ZBz/V5a7/6PZeM7S@slm.duckdns.org>
 <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com>
 <ZB5UalkjGngcBDEJ@slm.duckdns.org> <CAJD7tkYhyMkD8SFf8b8L1W9QUrLOdw-HJ2NUbENjw5dgFnH3Aw@mail.gmail.com>
 <CALvZod6rF0D21hcV7xnqD+oRkn=x5NLi5GOkPpyaPa859uDH+Q@mail.gmail.com>
In-Reply-To: <CALvZod6rF0D21hcV7xnqD+oRkn=x5NLi5GOkPpyaPa859uDH+Q@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 24 Mar 2023 21:37:08 -0700
Message-ID: <CAJD7tkY_ESpMYMw72bsATpp6tPphv8qS6VbfEUjpKZW6vUqQSQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
To:     Shakeel Butt <shakeelb@google.com>
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

On Fri, Mar 24, 2023 at 9:31=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Fri, Mar 24, 2023 at 7:18=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> [...]
> > Any ideas here are welcome!
> >
>
> Let's move forward. It seems like we are not going to reach an
> agreement on making cgroup_rstat_lock a non-irq lock. However there is
> agreement on the memcg code of not flushing in irq context and the
> cleanup Johannes has requested. Let's proceed with those for now. We
> can come back to cgroup_rstat_lock later if we still see issues in
> production.

Even if we do not flush from irq context, we still flush from atomic
contexts that will currently hold the lock with irqs disabled
throughout the entire flush sequence. A primary purpose of this reason
is to avoid that.

We can either:
(a) Proceed with the following approach of making cgroup_rstat_lock a
non-irq lock.
(b) Proceed with Tejun's suggestion of always releasing and
reacquiring the lock at CPU boundaries, even for atomic flushes (if
the spinlock needs a break ofc).
(c) Something else.

I am happy to proceed with any solution, but we need to address the
fact that interrupts are always disabled throughout the flush. My main
concern about Tejun's suggestion is atomic contexts having to contend
cgroup_rstat_lock much more than they do now, but it's still better
than what we have today.

>
> Tejun, do you have any concerns on adding WARN_ON_ONCE(!in_task()) in
> the rstat flushing code?
