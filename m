Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469296C6F2B
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 18:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjCWRfC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 13:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjCWRe7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 13:34:59 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A46199C5
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 10:34:35 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id bz27so15718666qtb.1
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1679592825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CZLXBmA41bOiDNyv2hz7XrEIq6hNyBHTJSZ1wV7jb+Y=;
        b=kqP1eE1tL+wzCUnNqIYAlvN8tJmINyAiPen+kx5VrAY4oKGNxvQ2ayaV5CBTOH244L
         wSwev4CFWIXuiAIp5ed+/xowiomE7u/QDssFht8UY98/sZfqfi1/IV7aogEUqbnf1lLu
         n9zP+g0UuDb1eJIEACMFT1Ehij4gm/nLjZ9hYqaV8hMSV4pLbzoOiPzomoGhbIC8c436
         OVk+Aq3xUTZkCRsAI+b/2Pu9kd/r1FSfr3GrCG8qsKEAzLRt4Op45wJCxou54rFiV1wS
         vYtAKT5xhifZ6zNpwwlYm5VHESq+Sd0jNHWKiIIERy7uTrHrl3bTT55XUNKACw86m7+J
         6YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679592825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZLXBmA41bOiDNyv2hz7XrEIq6hNyBHTJSZ1wV7jb+Y=;
        b=cwM5WFjg/T26VLzl+Cotz8XiHQ8zxAk2OU1nuMevJEm01ag0iRYFn4Kgyauvkmqy5D
         cub8GAIN8fNsrsUdNkPHRyyaRlll5YRg5DFY8O7jLKqSgOSZqYiSZ/g3dlZ4Qn0H57Zi
         r+x4vFOulgX2TYiXVeZFy2MOKxKGCvo/Suyp2EmQnszrVHiXIuV8gz6rZX3sEMB4WuIs
         arQiOKwwOFDeVVRedJHpPfTlCSSv5fa6WKIwBOzkiFgQcGjcYWTDTOW4kZbw/7C/rR+T
         uCIRwIepwQ4ipD7OxDfYz8SJpIwc1aIF/tch+NeW/ogoEutfT5ifWxp+uwN9AzUnjRwh
         f9Vg==
X-Gm-Message-State: AO0yUKWnssdyFROGIZzAPLTNhs/qZVrL7YPTb9U+xNEKf/lZhe+joHZd
        Ypr3adT19m17kyevIqOq7CreCQ==
X-Google-Smtp-Source: AK7set8xtnTqAdTFnGSiN2Htn9NjFRZXFckL22JLDWTFvLdbaXRXU6d+bQQm+F6Bjwd83f2G1P4quw==
X-Received: by 2002:a05:622a:5cf:b0:3e3:3941:d175 with SMTP id d15-20020a05622a05cf00b003e33941d175mr172725qtb.38.1679592824854;
        Thu, 23 Mar 2023 10:33:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:62db])
        by smtp.gmail.com with ESMTPSA id 66-20020a370b45000000b0071eddd3bebbsm5237213qkl.81.2023.03.23.10.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:33:44 -0700 (PDT)
Date:   Thu, 23 Mar 2023 13:33:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
Message-ID: <20230323173343.GF739026@cmpxchg.org>
References: <20230323040037.2389095-2-yosryahmed@google.com>
 <CALvZod7e7dMmkhKtXPAxmXjXQoTyeBf3Bht8HJC8AtWW93As3g@mail.gmail.com>
 <CAJD7tkbziGh+6hnMysHkoNr_HGBKU+s1rSGj=gZLki0ALT-jLg@mail.gmail.com>
 <CALvZod5GT=bZsLXsG500pNkEJpMB1o2KJau4=r0eHB-c8US53A@mail.gmail.com>
 <CAJD7tkY6Wf2OWja+f-JeFM5DdMCyLzbXxZ8KF0MjcYOKri-vtA@mail.gmail.com>
 <CALvZod5mJBAQ5adym7UNEruL-tOOOi+Y_ZiKsfOYqXPmGVPUEA@mail.gmail.com>
 <CAJD7tkYWo_aB7a4SHXNQDHwcaTELonOk_Vd8q0=x8vwGy2VkYg@mail.gmail.com>
 <CALvZod7f9Rejb_WrZ+Ajegz-NsQ7iPQegRDMdk5Ya0a0w=40kg@mail.gmail.com>
 <CALvZod7-6F84POkNetA2XJB-24wms=5q_s495NEthO8b63rL4A@mail.gmail.com>
 <CAJD7tkbGCgk9VkGdec0=AdHErds4XQs1LzJMhqVryXdjY5PVAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbGCgk9VkGdec0=AdHErds4XQs1LzJMhqVryXdjY5PVAg@mail.gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 23, 2023 at 09:17:33AM -0700, Yosry Ahmed wrote:
> On Thu, Mar 23, 2023 at 9:10 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Thu, Mar 23, 2023 at 8:46 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Thu, Mar 23, 2023 at 8:43 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > > On Thu, Mar 23, 2023 at 8:40 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > > >
> > > > > On Thu, Mar 23, 2023 at 6:36 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > > >
> > > > > [...]
> > > > > > > >
> > > > > > > > > 2. Are we really calling rstat flush in irq context?
> > > > > > > >
> > > > > > > > I think it is possible through the charge/uncharge path:
> > > > > > > > memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_usage(). I
> > > > > > > > added the protection against flushing in an interrupt context for
> > > > > > > > future callers as well, as it may cause a deadlock if we don't disable
> > > > > > > > interrupts when acquiring cgroup_rstat_lock.
> > > > > > > >
> > > > > > > > > 3. The mem_cgroup_flush_stats() call in mem_cgroup_usage() is only
> > > > > > > > > done for root memcg. Why is mem_cgroup_threshold() interested in root
> > > > > > > > > memcg usage? Why not ignore root memcg in mem_cgroup_threshold() ?
> > > > > > > >
> > > > > > > > I am not sure, but the code looks like event notifications may be set
> > > > > > > > up on root memcg, which is why we need to check thresholds.
> > > > > > >
> > > > > > > This is something we should deprecate as root memcg's usage is ill defined.
> > > > > >
> > > > > > Right, but I think this would be orthogonal to this patch series.
> > > > > >
> > > > >
> > > > > I don't think we can make cgroup_rstat_lock a non-irq-disabling lock
> > > > > without either breaking a link between mem_cgroup_threshold and
> > > > > cgroup_rstat_lock or make mem_cgroup_threshold work without disabling
> > > > > irqs.
> > > > >
> > > > > So, this patch can not be applied before either of those two tasks are
> > > > > done (and we may find more such scenarios).
> > > >
> > > >
> > > > Could you elaborate why?
> > > >
> > > > My understanding is that with an in_task() check to make sure we only
> > > > acquire cgroup_rstat_lock from non-irq context it should be fine to
> > > > acquire cgroup_rstat_lock without disabling interrupts.
> > >
> > > From mem_cgroup_threshold() code path, cgroup_rstat_lock will be taken
> > > with irq disabled while other code paths will take cgroup_rstat_lock
> > > with irq enabled. This is a potential deadlock hazard unless
> > > cgroup_rstat_lock is always taken with irq disabled.
> >
> > Oh you are making sure it is not taken in the irq context through
> > should_skip_flush(). Hmm seems like a hack. Normally it is recommended
> > to actually remove all such users instead of silently
> > ignoring/bypassing the functionality.

+1

It shouldn't silently skip the requested operation, rather it
shouldn't be requested from an incompatible context.

> > So, how about removing mem_cgroup_flush_stats() from
> > mem_cgroup_usage(). It will break the known chain which is taking
> > cgroup_rstat_lock with irq disabled and you can add
> > WARN_ON_ONCE(!in_task()).
> 
> This changes the behavior in a more obvious way because:
> 1. The memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_usage()
> path is also exercised in a lot of paths outside irq context, this
> will change the behavior for any event thresholds on the root memcg.
> With proposed skipped flushing in irq context we only change the
> behavior in a small subset of cases.

Can you do

	/* Note: stale usage data when called from irq context!! */
	if (in_task())
		mem_cgroup_flush_stats()

directly in the callsite? Maybe even include the whole callchain in
the comment that's currently broken and needs fixing/removing.
