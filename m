Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C4A6C8AD9
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 05:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCYEbI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 00:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjCYEbH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 00:31:07 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A6314215
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 21:31:02 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54184571389so70111777b3.4
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 21:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679718661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGXkNVqKc7W3NTjCcHQcK32QEBD4ibnmet17kfhhRaI=;
        b=PHAZU2Rd9Fp65snbdneP5IXYTtAFunJK2mfV2/pfOyuB8dkyTMfzLLe7Dl3igKadFa
         9se6SnVK1wDMGZrmKj4em9x05vBVwT9dWKvwg8pfB+2xddz8jQLLd8c3dXTvTi5HoOEM
         2GmUtVmBPiPdjr12BNA1afc7hYkVEBk1ABclJR45XULgq8DAuovm6lEt8UxThY/ahIWw
         /3+c8DXYKZwbijUtJPP5HW0j6XNHzjMvdaTMuYjuMYSA5o4nA0vJqIFNgoPtwVjvftrU
         rmoy1A9rEEka+aR2qVX1FnFd+1ObOumqDzWfDhM4lQCmdSGzsAXwwcTSY0Qcql8kFfYk
         X7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679718661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGXkNVqKc7W3NTjCcHQcK32QEBD4ibnmet17kfhhRaI=;
        b=xFjbdn1ylr3yOZN33ig+dVP6JeHSBKgLQsDd1XurHXbwZMUU71s/bsU+9f0gcw2dFY
         6QI4fIpKHMt+iFCMA5y2ChI6usZTLKHqajio/MeEwYEhl8hIpfp1oSFYejHTI/ARO4yW
         lDnLCpTkQOEpFtZBaMDvC/jFIDzzIDKOSq9/nPl3v6tNqkLIHfmH9dh7qPY/iqQm6/gW
         9+DcQ1KQnpGnYuilM5GkVpIPbe9XEbxsI0WZHaDH1gpr5ZzJbqgbAcBfs47Y24F0wE1X
         9xApyvTNli1SFHgiEPkyo9WMz+DHshdhHJcWh6LcXmfKIIMmsLsnoOdLbmjBmJjL4I4t
         Jcew==
X-Gm-Message-State: AAQBX9cfCvAxPmxtzJPuE7K1oTA5yfNrYl/HGtaHnX7AmlSdteGNIC6A
        SMp3TY+ZJf4JGn+S94xRxvZA8PFxyj5RhXrkhOWOAw==
X-Google-Smtp-Source: AKy350ZELBPdnNH9RPXKXKnO784dLdfbc+FayCnRhRX2loqVW8hP2461hi+p6RkMJbrBPkX0+F1XATk0SQY/rmWNXHA=
X-Received: by 2002:a81:4517:0:b0:545:343b:ecba with SMTP id
 s23-20020a814517000000b00545343becbamr1799325ywa.0.1679718661454; Fri, 24 Mar
 2023 21:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <ZBz/V5a7/6PZeM7S@slm.duckdns.org>
 <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com>
 <ZB5UalkjGngcBDEJ@slm.duckdns.org> <CAJD7tkYhyMkD8SFf8b8L1W9QUrLOdw-HJ2NUbENjw5dgFnH3Aw@mail.gmail.com>
In-Reply-To: <CAJD7tkYhyMkD8SFf8b8L1W9QUrLOdw-HJ2NUbENjw5dgFnH3Aw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 24 Mar 2023 21:30:49 -0700
Message-ID: <CALvZod6rF0D21hcV7xnqD+oRkn=x5NLi5GOkPpyaPa859uDH+Q@mail.gmail.com>
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

On Fri, Mar 24, 2023 at 7:18=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
[...]
> Any ideas here are welcome!
>

Let's move forward. It seems like we are not going to reach an
agreement on making cgroup_rstat_lock a non-irq lock. However there is
agreement on the memcg code of not flushing in irq context and the
cleanup Johannes has requested. Let's proceed with those for now. We
can come back to cgroup_rstat_lock later if we still see issues in
production.

Tejun, do you have any concerns on adding WARN_ON_ONCE(!in_task()) in
the rstat flushing code?
