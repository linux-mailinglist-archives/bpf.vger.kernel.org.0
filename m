Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7DB6CFD7A
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 09:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjC3H4K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 03:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjC3H4C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 03:56:02 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A454E6195
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 00:55:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id cn12so73100341edb.4
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 00:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680162954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anbj3k8bVreIFvoy5ezWKZvlLhuV6pERZy1Bnx+kNns=;
        b=ZD9aj6n0GX26RjIgVcV8XWHXeXxhiTySnXtfLlIh2Y4ULsYer620/o/Gxai5NDEyx0
         U9cLhrKkIyrcXCb9H0C1LsSrI3aYqgf3GO6P4vMGibxu+NJs5rV7tQbNe7/BuzZ9ngD4
         QlTJGq/55WJCvX0baHxwlbOU546xXFXX3rhwhxfTlPe1DtgL+SZFj+3v/M/zynT9IjDn
         ZyadAB66teMDMbs9xKwieRC4GEnlOFheMYpz1xGF7yvvoKjAofsoTZMoVDKAnSS6/+pv
         n2YA0BsqSmXP4EqjlRt/DgekBF6qWk4ejPD+mZWis8RRK9kN76WGkT00+z0dkPShQagp
         7beQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680162954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anbj3k8bVreIFvoy5ezWKZvlLhuV6pERZy1Bnx+kNns=;
        b=EHF1By9+JdczKNmV3Z79rlEd8F2Bm1o5/yE7d1HM8E+vkTH1k8NO/J3vO4ruwdvwwy
         +rPwEfOiSjh2UVCKW5PZ+4G3Wg81T8u9ogEmCZBf6EDXFfhehDjuE9XcKSqXCtowqNuu
         KTDxplpUmIWO0MXSE/IW3ciDasmtLLx+QfFU0a7XOE/mXespINTf5F32oew+zg0Ugd7N
         C3gk4i0PjvcKezAXbRudKfgRZIzRD5wtPFxCQ4Ym3NP4m5Vr+KiNBRgclDr4B/aG0dY3
         8mxsFJC83ThgrAl0HZ0XluegyFVWIWkIQ22nNWX3Yk+rDJ+Pyp8wRrENpI0RKJeubYTp
         3hyA==
X-Gm-Message-State: AAQBX9d5WxDie0tGQ5U+FjB5q1synPCgyxa6d+AE54VpQnOL5UgQH/U2
        Gcr7rxbfzzYVf8qtnJdE/9mb/5XaNC6ybPS7rKGWQA==
X-Google-Smtp-Source: AKy350ZKBVchKo8yL5qnCRGOKj6HMXymGhCHv0sbs5xG5akH53sSrKAZcQmbeW6Sz+oAWJWB2Er2VE8WUpb+CRjLT3s=
X-Received: by 2002:a17:906:eec7:b0:93e:186f:ea0d with SMTP id
 wu7-20020a170906eec700b0093e186fea0dmr10952473ejb.15.1680162953989; Thu, 30
 Mar 2023 00:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-8-yosryahmed@google.com> <ZCU8tjqzg8cDbobQ@dhcp22.suse.cz>
 <CAJD7tkZLBs=A8m5u=9jGtMeD0ptOgtCTYUoh2r4Ex+fCkvwAXg@mail.gmail.com> <ZCU/SMr5gC9C0U+R@dhcp22.suse.cz>
In-Reply-To: <ZCU/SMr5gC9C0U+R@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 30 Mar 2023 00:55:17 -0700
Message-ID: <CAJD7tkZfexGoyZx0ormVzp_KkYmOczxBPfFaffKqd_TD4gvGCg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] workingset: memcg: sleep when flushing stats in workingset_refault()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
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

On Thu, Mar 30, 2023 at 12:50=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Thu 30-03-23 00:42:36, Yosry Ahmed wrote:
> > On Thu, Mar 30, 2023 at 12:39=E2=80=AFAM Michal Hocko <mhocko@suse.com>=
 wrote:
> > >
> > > On Tue 28-03-23 22:16:42, Yosry Ahmed wrote:
> > > > In workingset_refault(), we call
> > > > mem_cgroup_flush_stats_atomic_ratelimited() to flush stats within a=
n
> > > > RCU read section and with sleeping disallowed. Move the call above
> > > > the RCU read section and allow sleeping to avoid unnecessarily
> > > > performing a lot of work without sleeping.
> > >
> > > Could you say few words why the flushing is done before counters are
> > > updated rather than after (the RCU section)?
> >
> > It's not about the counters that are updated, it's about the counters
> > that we read. Stats readers do a flush first to read accurate stats.
> > We flush before a read, not after an update.
>
> Right you are, my bad I have misread the intention here.
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

>
> --
> Michal Hocko
> SUSE Labs
