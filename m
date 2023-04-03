Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8216D52B0
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 22:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjDCUkM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 16:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjDCUkK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 16:40:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C6226B1
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 13:40:07 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y4so122399300edo.2
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 13:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680554406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98lpmjVP03rasH0aUw5Or4NqpKX/eDyfmYvak2z+XQY=;
        b=aOrySHi+L5aBtQhD9CMl2wIUewhWyIyQQXGmhw67rG4aYB/0VxtLJJdx4JKcjr4/Su
         CKHv3ZrfEko2du/9DiJPnmJgfyM9NzFrN9wGLJLRnVWtCv6yd58ea0gAc1LIGcNps8aF
         iQTbr3AocnQwqVN0vRpZPBqysYDShbz/ZYTddqaS5BtXq0sVascssl+jkJwncPNANTjk
         LRdvan3ZAUekClGuJ3S02i2YGWuAiDNHkJMii0Y/083m5jLXpgQg8MobYoyssOoaX1B9
         uxV+Z9IvmlmsJ8Y4QsY7pkdlMNW7ukQiPmVap2uSl7WIEp0ptj20puF/FpeYyuTT9zI9
         0ZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680554406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98lpmjVP03rasH0aUw5Or4NqpKX/eDyfmYvak2z+XQY=;
        b=W8AURalWVbwUa7Z+lUyrAAOcDsRk9wLQKK7uJJVP2QoW0v9PULgU7X6KmhTEXnsH+K
         TNWLFqOGpvvPfB2tNW4w0dbXG8hnYuGyWCjWn07Lm/XJlhxLs1bYvtYKquTBjO8+9QwH
         lK3BK1XSSQBKrsBy+5D6dSISyDUuTN6apoZ4u3Ak+jlHZjmVLFW/Y6Scu+5o4cp0KY8A
         tqs1E/B2323cYVGbvZ6+/cQ6z/mUUSqvx4r/xj2LxhCmGSWL3CP2MYu05MPDSXtbSbOT
         HT2nRF7aVgxM5dZfz7FKQmsOv+WJi2xgycHzVh3v9kfvE1gzHi6KMjJNPAzylJ0qDIax
         SzJw==
X-Gm-Message-State: AAQBX9eFeVv7ZgNPIoCGe4Lae40ccNUFpWj6tsVp/VVMy4l+19GgU9xj
        JqL99NA66F60bz8wyC4JdgLYObIBk7NTsyv3I0lC9w==
X-Google-Smtp-Source: AKy350Zgaw5pQ0oWUtuZqoGHW8zTg36m0ZFKQebBTrdHG4AMl+dpXooPrkU+eTMNeuZDA0kcJZZ9arc1xcfhu4d3GZg=
X-Received: by 2002:a50:bac2:0:b0:502:1d1c:7d37 with SMTP id
 x60-20020a50bac2000000b005021d1c7d37mr259671ede.8.1680554406118; Mon, 03 Apr
 2023 13:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <ZCU1Bp+5bKNJzWIu@dhcp22.suse.cz> <CAJD7tka0CmRvcvB0k8DZuid1vC9OK_mFriHHbXNTUkVE7OjaTA@mail.gmail.com>
 <ZCU+8lSi+e4WgT3F@dhcp22.suse.cz> <CAJD7tkaKd9Bcb2-e83Q-kzF7G+crr1U+7uqUPBARXWq-LpyKvw@mail.gmail.com>
 <ZCVFA78lDj2/Uy0C@dhcp22.suse.cz> <CAJD7tkbjmBaXghQ+14Hy28r2LoWSim+LEjOPxaamYeA_kr2uVw@mail.gmail.com>
 <ZCVKqN2nDkkQFvO0@dhcp22.suse.cz> <CAJD7tkYEOVRcXs-Ag3mWn69EwE4rjFt9j5MAcTGCNE8BuhTd+A@mail.gmail.com>
 <ZCa9sixp3GJcjf8Y@dhcp22.suse.cz> <CAJD7tka-2vNn25=NdrKQoMf4ntdbWtojY0k4eAa-c9D+v7J=HQ@mail.gmail.com>
 <ZCqQfuprGreGYwFA@dhcp22.suse.cz>
In-Reply-To: <ZCqQfuprGreGYwFA@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 3 Apr 2023 13:39:29 -0700
Message-ID: <CAJD7tkZF+rCNW4pctjOfAetoAQRq7-exV-j-nRc_xYMkMBGY_A@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing
 outside task context
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
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

On Mon, Apr 3, 2023 at 1:38=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Fri 31-03-23 12:03:47, Yosry Ahmed wrote:
> > On Fri, Mar 31, 2023 at 4:02=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Thu 30-03-23 01:53:38, Yosry Ahmed wrote:
> > > [...]
> > > > Maybe we can add a primitive like might_sleep() for this, just food=
 for thought.
> > >
> > > I do not think it is the correct to abuse might_sleep if the function
> > > itself doesn't sleep. If it does might_sleep is already involved.
> >
> > Oh, sorry if I wasn't clear, I did not mean to reuse might_sleep() --
> > I meant introducing a new similar debug primitive that shouts if irqs
> > are disabled.
>
> This is circling back to original concerns about arbitrary decision to
> care about IRQs. Is this really any different from spin locks or preempt
> disabled critical sections preventing any scheduling and potentially
> triggereing soft lockups?

Not really, I am sure there are other code paths that may cause
similar problems. At least we can start annotating them so that we
don't regress them (e.g. by introducing a caller that disables irqs --
converting them into hard lockups).

> --
> Michal Hocko
> SUSE Labs
