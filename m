Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B17D1DC4C7
	for <lists+bpf@lfdr.de>; Thu, 21 May 2020 03:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgEUBf6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 21:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgEUBf6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 21:35:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABA3C061A0E;
        Wed, 20 May 2020 18:35:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m12so3850597ljc.6;
        Wed, 20 May 2020 18:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DBXqwKTEH0usNMAOL2knpjnVZkttIoOBxjdC17LmPt8=;
        b=hFq9PfTp6ZKUNMw34kdmwEWtIXWlBiNKDXc7O3jysTUWP+QFv5W5rHKIGcV1I4WFv8
         oj7l0RA3eNUJulWO5OJZpJ5ZzcEJM5WEW21Ol9W6WHngmiLkotRIh4u5lfMwAO0YQUEV
         4/lWD0LmCbqgJdj/xgZ7nNGpamSMMRaHwof3FTSm4dtXMJUBA2zWHJd2dBBcfpMgWQEw
         bGqfMXGLUiQtw6PJaauYGTxz8+gqsY7w3bVjBXibo8E6JSQlmL41uf9r+CHdhWhb4twK
         cAmWSYpWkxVxJXsW94Ftv93goSGYcENpsWoQRL0f4BbMIjAZdaPPiUsH6bGy8HHIr/9R
         oMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DBXqwKTEH0usNMAOL2knpjnVZkttIoOBxjdC17LmPt8=;
        b=ZMNkNA8qTGCjRTWzvD7T0paWVOOzDMKx0QiLNSrDF6wcqZjwjQkmAQbwZh3FS3i63A
         5L9fpPbm+sm0q1bzBO2sWTB9FAKoHErn5VukeL99xpLOiy0HuCQPSZrrY/dMfUR2TvDg
         RBifFKV+Y+3kywn1YTXP2V6NXVlP7kc212UbFTukzsjJyUg1xer0VZrCUlGfTUH+EWuM
         Ps70VmBbSet8fomqBBLTggvz0TnvpHLa+sucSko/tNHZcitDeuinbywvMseJuCYL/L0K
         jZpeShOiIz1CLl8p/uqKsFSK/uOxtU/n1l0nb7htooBWkHdt6KNPB95TZ6oQNqJrLYKw
         56Lw==
X-Gm-Message-State: AOAM531wF3O2EYS84/89IhoWro919UXWoxoibK0SfKnr1hJktBlkXHi1
        mgiYxGAvb4Xs3IMN9774h2bQMpeTpgx9iRtryWg=
X-Google-Smtp-Source: ABdhPJx7Glj/HRsh2o+4FWApar+dgeAElNXoR/1B3L5SLLz77k8TaMhbflVYHtGdwtDg6GhYttrztYhTd6LbmtAyDMs=
X-Received: by 2002:a2e:81d1:: with SMTP id s17mr3977253ljg.91.1590024955958;
 Wed, 20 May 2020 18:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200520125616.193765-1-kpsingh@chromium.org> <5f540fb8-93ec-aa6b-eb30-b3907f5791ff@schaufler-ca.com>
In-Reply-To: <5f540fb8-93ec-aa6b-eb30-b3907f5791ff@schaufler-ca.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 20 May 2020 18:35:44 -0700
Message-ID: <CAADnVQL_j3vGMTiQTfKWOZKhhuZxAQBQpU6W-BBeO+biTXrzSQ@mail.gmail.com>
Subject: Re: [PATCH bpf] security: Fix hook iteration for secid_to_secctx
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 20, 2020 at 8:15 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>
> On 5/20/2020 5:56 AM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > secid_to_secctx is not stackable, and since the BPF LSM registers this
> > hook by default, the call_int_hook logic is not suitable which
> > "bails-on-fail" and casues issues when other LSMs register this hook and
> > eventually breaks Audit.
> >
> > In order to fix this, directly iterate over the security hooks instead
> > of using call_int_hook as suggested in:
> >
> > https: //lore.kernel.org/bpf/9d0eb6c6-803a-ff3a-5603-9ad6d9edfc00@schaufler-ca.com/#t
> >
> > Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> > Fixes: 625236ba3832 ("security: Fix the default value of secid_to_secctx hook"
> > Reported-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: KP Singh <kpsingh@google.com>
>
> This looks fine.

Tested. audit works now.
I fixed missing ')' in the commit log
and applied to bpf tree.
It will be on the way to Linus tree soon.

Thanks!
