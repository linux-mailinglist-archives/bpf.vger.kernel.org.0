Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123C16CFE10
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 10:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjC3IUY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 04:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjC3IUM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 04:20:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCDD6EB2
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 01:20:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w9so73344184edc.3
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680164406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rE+Nd7UYDrEpMLZdSjUiKej18eXol1/TN8rz8IxWo74=;
        b=GyiWHmVq+FRfL2cjm01ZTknwA6vfgE0p1ya77Ct3yJ2fB3E9yTJDYO2DG1GztDRNr1
         mgqcDehwuGMzQozTkhWOck0f+hbdMLCW22Oz0H2Hw6ub0AxgTKvO7NZZd8kar0iXPa0I
         w1fR0oirsZVe2itG6Xr3UFIcRF4dGKzDyt2lNU2VwbqP6oVlYOxkUSoEnJivS8rNs64x
         VZVdjxryxpTbjqXXWbrRaMthVoEUjQbg6RENFAeilc95gCV/uc5zz8ndmctFE1QXVkv2
         tyHZExil1HMZFY3eIbGsSr2E+zht6bWEo8TR5K8rxCHL18BXfX+/+YVs+jZNksasf9f2
         oklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680164406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE+Nd7UYDrEpMLZdSjUiKej18eXol1/TN8rz8IxWo74=;
        b=SXnayLzpFeHyU6AsbkZl67K+kxSldVRvcFAvOZVtKM4klEB0teLA3hJ68TcoS0n8hv
         yZ+XrTAkeC07c28s7oz/5kKdKpQ5NdqOFAAVHEV1tADwYrl6nfBEd/56tJPb2cNyX745
         +hcBMzLTMPAkjhyXhoi3WptcnVSCXBG2yIXyIWWjzcu8Rz7u1E0jrm/rKgOXRTbna4DH
         y098Z7lt38WKzEOA941iqELXL8Yh7jaNUS6q1L0sida1E6qyuXUSpdX799qUM5RLlZvU
         LKrhZ7O+8tWPRpaGG9mkJEDz8C2e+pSqGa5QqdnpvpNgnBCbD911UopNfELzRERjLeze
         6k3g==
X-Gm-Message-State: AAQBX9f790ZzgEc+xC+jejMUSf91Y903LgBKCAqQjA639E1Sua9Gsuj0
        hMzEQn9QGrraD34hRPBopAJQ7JldrOH3xHHXn/WXjQ==
X-Google-Smtp-Source: AKy350bAhrh9NHy4UYkmG2jHp+l/1C2NvOUI9U59l2Zu/qbpFVbWrn1FsDF2AI+0/W7DKu39i6IFvDYFuiBiBzY6SzU=
X-Received: by 2002:a50:8e0d:0:b0:4fc:473d:3308 with SMTP id
 13-20020a508e0d000000b004fc473d3308mr11186298edw.8.1680164405731; Thu, 30 Mar
 2023 01:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-5-yosryahmed@google.com> <ZCQfZJFufkJ10o01@dhcp22.suse.cz>
 <CAJD7tkb-UpKm2QbjYzB=B=oGk6Hyj9cbUviZUPC+7VsvBecH7g@mail.gmail.com>
 <20230329192059.2nlme5ubshzdbpg6@google.com> <ZCU1Bp+5bKNJzWIu@dhcp22.suse.cz>
 <CAJD7tka0CmRvcvB0k8DZuid1vC9OK_mFriHHbXNTUkVE7OjaTA@mail.gmail.com>
 <ZCU+8lSi+e4WgT3F@dhcp22.suse.cz> <CAJD7tkaKd9Bcb2-e83Q-kzF7G+crr1U+7uqUPBARXWq-LpyKvw@mail.gmail.com>
 <ZCVFA78lDj2/Uy0C@dhcp22.suse.cz>
In-Reply-To: <ZCVFA78lDj2/Uy0C@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 30 Mar 2023 01:19:29 -0700
Message-ID: <CAJD7tkbjmBaXghQ+14Hy28r2LoWSim+LEjOPxaamYeA_kr2uVw@mail.gmail.com>
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

On Thu, Mar 30, 2023 at 1:15=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 30-03-23 01:06:26, Yosry Ahmed wrote:
> [...]
> > If we achieve that, do you think it makes sense to add
> > WARN_ON_ONCE(irqs_disabled()) instead to prevent future users from
> > flushing while disabling irqs or in irq context?
>
> WARN_ON (similar to BUG_ON) will not prevent anybody from doing bad
> things. We already have means to shout about sleepable code being
> invoked from an atomic context and there is no reason to duplicate that.
> As I've said earlier WARN_ON might panic the system in some
> configurations (and yes they are used also in production systems - do
> not ask me why...). So please be careful about that and use that only
> when something really bad (yet recoverable) is going on.

Thanks for the information (I was about to ask why about production
systems, but okay..). I will avoid WARN_ON completely. For the
purposes of this series I will drop this patch anyway.

Any idea how to shout about "hey this may take too long, why are you
doing it with irqs disabled?!"?

>
> --
> Michal Hocko
> SUSE Labs
