Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB466D26BF
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 19:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjCaRfR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 13:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjCaRfQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 13:35:16 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983DC1EA02;
        Fri, 31 Mar 2023 10:35:15 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id e13so10038344ioc.0;
        Fri, 31 Mar 2023 10:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680284115; x=1682876115;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmAd51Y+ttNDm2R+z3V6OoZ1kWfxjPOXI/NUw5T50wo=;
        b=7GdVU6c5ikHiNaxPu6qb8A1ej7lXLH8Bv+jdN54tO3WYS+JQQCKAe0A6J8qmf1ekas
         gZIob9VAU8eFrsnLUnF8IrdFhtppQAzR/awnSyqUxWMGZ1cRUiv1BTcY2o51mkSYwFm4
         dirMW2bBx3iSV7USlh72om72YCN2eWCV7JEAVFY0fdkMUMDou7aqpvbMaG9T/6YTA2YW
         2X1JaAtqiEUfKMT+C8aCnvwYFTenRd1VHE2ic4HLiNnMta3AEp9/KzX0veh3x9pZQElU
         0UNi8L/9BDMwDZc1BYxWyvaJNiOEtBpATYjkEjkFR9otFZj5UlLbCU52TMDJY9/lM+Bn
         cDjg==
X-Gm-Message-State: AO0yUKVV7iFov00o6jJG+wpGN6iRGjGVzf4VcUCreIQAcuh8Te98SAaJ
        JBkG4WsDpY2LRzbKgtTr6/s=
X-Google-Smtp-Source: AK7set8LrV2pGgMYyFOBqnSjIW7DGGxm0YtrgMth1DhCtfcTP7/p4auquK2in1H3sHAezz6U6WtQrQ==
X-Received: by 2002:a05:6602:228a:b0:71f:8124:de52 with SMTP id d10-20020a056602228a00b0071f8124de52mr22199494iod.9.1680284114646;
        Fri, 31 Mar 2023 10:35:14 -0700 (PDT)
Received: from maniforge ([2600:380:6723:ddae:45b1:2b5a:bf57:b36b])
        by smtp.gmail.com with ESMTPSA id s21-20020a5eaa15000000b00752f62cd3bdsm699861ioe.12.2023.03.31.10.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:35:13 -0700 (PDT)
Date:   Fri, 31 Mar 2023 12:35:11 -0500
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Make struct task_struct an RCU-safe
 type
Message-ID: <20230331173511.GA417548@maniforge>
References: <20230331005733.406202-1-void@manifault.com>
 <20230331005733.406202-2-void@manifault.com>
 <20230331170504.umr5zmcraburmtkg@dhcp-172-26-102-232.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331170504.umr5zmcraburmtkg@dhcp-172-26-102-232.dhcp.thefacebook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 31, 2023 at 10:05:04AM -0700, Alexei Starovoitov wrote:
> On Thu, Mar 30, 2023 at 07:57:31PM -0500, David Vernet wrote:
> >  kernel/bpf/helpers.c                          | 11 ++-
> >  kernel/bpf/verifier.c                         |  1 +
> >  .../selftests/bpf/prog_tests/task_kfunc.c     |  2 +
> >  .../selftests/bpf/progs/task_kfunc_common.h   |  5 +
> >  .../selftests/bpf/progs/task_kfunc_failure.c  | 98 +++++++++++++++++--
> >  .../selftests/bpf/progs/task_kfunc_success.c  | 52 +++++++++-
> >  6 files changed, 153 insertions(+), 16 deletions(-)
> 
> See CI failures on gcc compiled kernel:
> https://github.com/kernel-patches/bpf/actions/runs/4570493668/jobs/8068004031

Thanks for the heads up, I'll take a look and resubmit v2 with fixes for
gcc. In general it seems like a good idea to test both gcc and clang
selftest builds; I'll do that from now on.

> >  __bpf_kfunc struct task_struct *bpf_task_acquire(struct task_struct *p)
> >  {
> > -	return get_task_struct(p);
> > +	if (refcount_inc_not_zero(&p->rcu_users))
> > +		return p;
> > +	return NULL;
> >  }
> 
> I wonder whether we should add a bit of safety net here.
> Like do not allow acquire of tasks with PF_KTHREAD | PF_EXITING

That's certainly an option, though I don't think it buys us much. It
doesn't prevent the task from being pinned if it's acquired a bit
earlier, and others in the kernel can acquire a task with
get_task_struct() regardless of whether it's PF_EXITING (or an idle
task, etc). IMO it's a better UX to provide a complementary API to
get_task_struct(), but with RCU protection. On the other hand, it's
already KF_RET_NULL, and I doubt needing to acquire a task that's
PF_EXITING would be a common occurrence. We could always go the more
restrictive route, and then loosen it if there's a valid use case? My
only concern is that this safety net arguably doesn't really protect us
from anything (given that you can just acquire the task before it's
exiting), but maybe I'm wrong about that.

> or at least is_idle_task ?

Hmm, this one I'm really not sure about. On the one hand I can't think
of a reason why anyone would need to acquire a reference to an idle
task. On the other hand, it seems pretty benign to pin an idle task. I
guess my sentiment is the same as above. I'm fine with adding a
restriction and then loosening it later if there's a valid reason (and I
can add a comment explaining this).
