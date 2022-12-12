Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B2164A651
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 18:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiLLRyn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 12:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiLLRyf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 12:54:35 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16E5F582;
        Mon, 12 Dec 2022 09:54:34 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id jl24so12851402plb.8;
        Mon, 12 Dec 2022 09:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkdjsvPgqxKR73VJHLqvP078yN+SDLhJiOmjXgSxuGU=;
        b=czUBBfdHEMmFcIEfKniLOTtppvUCoqrj5ht6TV3hC/Ip3jO8YW/6jHtR5RWf2rYhmF
         SBFeFkB6gBKD/CwW+F++AuJE/44ocdS6VkeIIQYNoCAbJW8qgxgVje46JNpcJZVbcImK
         u0OOg82SnC71laBpKsFsVrHFvMxITg3Pe9ILbXHMUS14vjpHvmkjsDcuo4bsvqVtO4nF
         Onh3HxXcm6/GyhxAwcMAkvfiX27sQY4FTnVqwj9aB2Y4ZAS/4yvi5MKvOJ3X5/AUlIpJ
         uQwqL5dkgECvxPkP0soXnqzJZbLyC5ELfpI4jO5ic3BfBZfzFOr3nw3V1K0VDdiVXVjL
         OfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkdjsvPgqxKR73VJHLqvP078yN+SDLhJiOmjXgSxuGU=;
        b=PAHsBWWbM3Ic7O3xmpB2NDzT5uZwQTCjVqqooqhyEZEfKLdzsTa+D4bJAr/7sUYBT9
         Z0rA8R2ZBrp4sTARSFVkrWu5jOPoxptCX7liLkBNDtcKqUS5jO82I0nU8uXib4iWn3nx
         G1MwBN/plTvBKf46cAdQlhXFbP4vtqZueJzsJ1mQUERgYDQuGeP7KKt4/gw9ejue1OSB
         7asCOOKCl1j5dcS7hAln28/wcV7U3tvbZx2nNiQ8QYHxn9YyR20ZnKChsxTkao2u7DaB
         ummuJyrmMaPFOT9oGRZvDoR69UnmULvhwZIjvaHiEwnryloK8GPaOV9feqKLXL6DK9wC
         Rl5g==
X-Gm-Message-State: ANoB5pkqsrOFM3U32YS4DaM67GC4fXxHnNG74TTzbr+rBq6srzablmiO
        thUihec0MqVbgD6ZNc39W1M=
X-Google-Smtp-Source: AA0mqf5H+IfHm3DlWEV3FhXkk5wQWlewv2qAVgPSb3xz7lOr4KAsccYc8oHy1L7dNFmUo9dDR1gMmw==
X-Received: by 2002:a05:6a21:9991:b0:a4:5f8d:805a with SMTP id ve17-20020a056a21999100b000a45f8d805amr25677184pzb.53.1670867674085;
        Mon, 12 Dec 2022 09:54:34 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:9159])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b00186b1bfbe79sm6693732plh.66.2022.12.12.09.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:54:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 07:54:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
        riel@surriel.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 11/31] sched: Add @reason to sched_move_task()
Message-ID: <Y5dq2FVT1aQ5lwbt@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-12-tj@kernel.org>
 <Y5cX45wE7Wn0FlkE@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5cX45wE7Wn0FlkE@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 01:00:35PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 29, 2022 at 10:22:53PM -1000, Tejun Heo wrote:
> > sched_move_task() can be called for both cgroup and autogroup moves. Add a
> > parameter to distinguish the two cases. This will be used by a new
> > sched_class to track cgroup migrations.
> 
> This all seems pointless, you can trivially distinguish a
> cgroup/autogroup task_group if you so want (again for unspecified
> raisins).

Lemme add better explanations on the patches. This one, sched_ext just wants
to tell cgroup moves from autogroup ones to decide whether to invoke the BPF
scheduler's cgroup migration callback. But, yeah, you're right. It should be
able to tell that by looking at the task_group itself. Will try that.

Thanks.

-- 
tejun
