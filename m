Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C5E64BB25
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 18:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiLMRco (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 12:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbiLMRcm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 12:32:42 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01822339C;
        Tue, 13 Dec 2022 09:32:36 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id h33so305712pgm.9;
        Tue, 13 Dec 2022 09:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLbyIcspMZxl6HBTRDQkf267Rsz5Ys467dIvn5ZxoM8=;
        b=fP4x3iPgsUpxDEoJQiyHQPZHPPf3lxIjOLR0ZrObQdhPFkhNoyjRJrLCKnCQVN1CkC
         xM795m3n+VHmIKMtrGlnSkKahFFoceTdQ4Z3hP/p6mqbvkscNTzR8XmPYZv69K7pD7NS
         LUSSjWJpOh4bBT/1jHbBUcqorFXZuZZHpcGw6dF8HmycAcKc3v3StemifZKLl2oXK9Dy
         Po6xeMbIVZtBKQJwNpnL17xn757dOd4X0yDIf/ZHw7yEAFdzMjKsdjKF65bMbNfkyttZ
         4GzscuN8uduOoZ5ucPGRgv0C2l69QwJinzwPgCSq8XHz36xSwj7xUTf0WlsK5kymcWp/
         Md3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLbyIcspMZxl6HBTRDQkf267Rsz5Ys467dIvn5ZxoM8=;
        b=Z2gUBwr7I7gH1o/mb/eckRIftghYHqegRjqjl/NLWwYB7ePxUT8tuopWF94bolgHiY
         jgPGViX28L3xIC56DjnYNMJxl3rrIYZL7VY0T2XXslGCq6PsSJngFlVhdL1aegae5kfc
         MNgniTK3I7OYrKTjyASHABRvzVGlI385NpeNVEnGEQbc5bM9i9ekPhGnyo/H6EgfOSHC
         NvW4CBKt1mlRudt13tnOt6tOmFTt8E5JXUMlTlEb1AoLPC++kZVAKZ2w2WPFqYtMfwQ2
         WfmPuo4rmtNDpzU+hlbWFr54ahKLIO+ZS9Wu8mm0ZsfJL8AHYxLMREmTBfm9eRlJVSh1
         IYZw==
X-Gm-Message-State: ANoB5plGZSkMa7tRPTQELbErkZjeEBVSDFa8JMg5Cah0vFsfs2Uip2bR
        388og9acC6z8mrwmWp7jjEs=
X-Google-Smtp-Source: AA0mqf7x1PvDozej5YPoq9WNb/oPtQ3KnJ/+Qc/sZGxsPH3ix7ZawMDcfaiQBNpWnjv0CCflrhXvqg==
X-Received: by 2002:aa7:828e:0:b0:574:6795:ff5e with SMTP id s14-20020aa7828e000000b005746795ff5emr18007523pfm.24.1670952755845;
        Tue, 13 Dec 2022 09:32:35 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y28-20020aa78f3c000000b005625d5ae760sm8184336pfr.11.2022.12.13.09.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:32:35 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 13 Dec 2022 07:32:33 -1000
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
Subject: Re: [PATCH 14/31] sched_ext: Implement BPF extensible scheduler class
Message-ID: <Y5i3MeVNe6gAJp85@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-15-tj@kernel.org>
 <Y5ckYyz14bxCvv40@hirez.programming.kicks-ass.net>
 <Y5eeGMpr/SuyGBQO@slm.duckdns.org>
 <Y5haiM8qx1eOLjIr@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5haiM8qx1eOLjIr@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Tue, Dec 13, 2022 at 11:57:12AM +0100, Peter Zijlstra wrote:
> > Given that UP doesn't need to transfer tasks across, it might be possible to
> > move the whole dispatch operation into ->pick_next_task() but the current
> > state would be different, so it's more complicated and will likely be more
> > brittle.
> 
> That sounds like something is amiss, you fundamentally hold all the
> right locks, there is only one.

Yeah, locking is not the problem on UP. It's more that balance() is before
put_prev_task() and pick_next_task() after, so the %current task state is
different between the two points. I'll see if I can sqaure that from SCX
side. I don't see a reason why it wouldn't be possible but it's likely more
complicated than adding a call in the same spot for UP.

Thanks.

-- 
tejun
