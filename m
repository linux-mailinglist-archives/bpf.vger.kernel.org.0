Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2B664A932
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 22:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiLLVG0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 16:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiLLVGU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 16:06:20 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739122CD
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 13:06:19 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 191-20020a6214c8000000b00577ab8701b0so662926pfu.0
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 13:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWaneeqryBcsAibeUpKRK42zErCwxGtVc4ofyyE72VA=;
        b=iiWQpPuS8bWorh2jY+GSNXDDTP/zWKGKu1g1aADANQb/ront41FGJrPwGEj68n7oTH
         JhLcefPChU+DBSf2eitc6qktGBJiykCzFlFheFQzAFHq70qjy9RzppsKWe8Dfnxug0zb
         Q70m9u3uwa7SLcJteyOUz8XU2FUlLoA43iPv+mmQbKtdVYqNvB8eEU+SXnuoaPXL2gAA
         OsmvYR+38wi7kUJLbbH5jiWoUIZcCK0U+wYlnvmuzm7BEri1PuYsZEh4F2BPf6h56Hzp
         k6XF9LkHKgoGIe5yEiQbrINaKmhnNn24a1Io2T9K0dn29gAD0I9+Y2uFyE5U5/AA3BK4
         lsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWaneeqryBcsAibeUpKRK42zErCwxGtVc4ofyyE72VA=;
        b=fM+DinSf4JezevuyGvmeDkQEQl+fHQIzJRGZoNlFwOljh3auxwMTXMmHVV8Zq486IU
         lnWV7TITA5G+xm4WopHgqImzxfSL0BJ22FeUxS+A9BSq5/0RKFQwOT52zMwyittWrPAA
         +o30DM/53TspsLTHRZzsURRv72FZVGRZWMGYuQfwykq4CfxgeZSEEBfoTMOItWgafJ3O
         k97YOP/NoUl17KcR4oSctGxhJbSm/fka88XLE9kAwpBMj1SqnPTrO6BTrYUQ43NuhZ4v
         DDN3qjFQyroSsALsnDMeGcsjD+MbGfc1NAnElitMU0DIEsmcsbn8IOZjXHd/UhavZJQE
         tuIA==
X-Gm-Message-State: ANoB5pnBAiyDWs2y2mk7eJsDZHpO+nbI4gcFbgm8Ad/3ZwbVoqC4ezsQ
        CxLL68/v9tB5pPVxy46nS+01ScJm
X-Google-Smtp-Source: AA0mqf61TWGE3RV1QXljruCCMvtFtyrrtg1uTsEuaU+YxacSMmfGKi7aD7kEbD/zTJXdj0TabOoKiPtG
X-Received: from posk.svl.corp.google.com ([2620:15c:2d4:203:669:babb:2ed:33de])
 (user=posk job=sendgmr) by 2002:a05:6a00:26e3:b0:576:1b46:3ff6 with SMTP id
 p35-20020a056a0026e300b005761b463ff6mr35339034pfw.1.1670879178937; Mon, 12
 Dec 2022 13:06:18 -0800 (PST)
Date:   Mon, 12 Dec 2022 13:05:47 -0800
In-Reply-To: <Y5c0qEuyn8cAvLGQ@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
References: <Y5c0qEuyn8cAvLGQ@hirez.programming.kicks-ass.net>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221212210547.1105894-1-posk@google.com>
Subject: Re: [PATCH 31/31] sched_ext: Add a rust userspace hybrid example scheduler
From:   Peter Oskolkov <posk@google.com>
To:     peterz@infradead.org
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        brho@google.com, bristot@redhat.com, bsegall@google.com,
        daniel@iogearbox.net, derkling@google.com,
        dietmar.eggemann@arm.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, dvernet@meta.com, haoluo@google.com,
        joshdon@google.com, juri.lelli@redhat.com, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, martin.lau@kernel.org,
        mgorman@suse.de, mingo@redhat.com, pjt@google.com,
        riel@surriel.com, rostedt@goodmis.org, tj@kernel.org,
        torvalds@linux-foundation.org, vincent.guittot@linaro.org,
        vschneid@redhat.com, posk@posk.io
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Peter Zijlstra wrote:

> I long for the UMCG patches -- that
> at least was somewhat sane and trivially composes, unlike all this
> madness.

A surprise, to be sure, but a welcome one!

We are in the process of finalizing UMCG internally, and I plan
to post the patches here once all reviews/testing and some preliminary
rollouts are done.

Thanks,
Peter
