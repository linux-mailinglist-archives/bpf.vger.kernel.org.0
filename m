Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C5D6CCA90
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 21:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjC1T0l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 15:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC1T0k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 15:26:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BD52D72
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 12:26:38 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r11so54085950edd.5
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 12:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680031597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXQXsZqlBT+IvrC1SlejLvJwmsFqvbFWj1xTrESNOYw=;
        b=CknRXyRUtdGTwn5BeQWmVKT7SMD2819Xs8pLx5U4MGjre+MnImaICr8wSz9TGbOWC9
         mVV1DZsNNCBwQc7YRWY/4N5hWGHjFAG4IBa2FO35XMRs2SQWu406qZl/OOAMaxMO3pqF
         UvlmTwbzzKtXz4FgENrQqQ1zWe3cDhXwJOwPFHqAfE1Vk2R9GD+1j3doH0DabaJ8EwPs
         kEMdmTlfozsQAlMhCy8ia1T3+1fUt8rGhUogVpJR+7XhEyMrvUiyCF3WtjzuSe3DyYnx
         IEBXT1pgM8v+EXEXYeb2OBk7LR1PCsjNlNs5qRde5KW9n23G6cBqdlRh0qNxHsDqBnGd
         cFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680031597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXQXsZqlBT+IvrC1SlejLvJwmsFqvbFWj1xTrESNOYw=;
        b=mxIlMciFm13+1BBIfYrsONokxOIFRem3et28ZUUG91S3XSRI4GJsLOE/2JuTAKFHzm
         UNlNMmK4Ry9gn+yiYbuQKRJW9KgAadXx5JCJKilPL6af5X2znNUXZ232XVuh5XUgqw5b
         5pCQh6g/lVmvWeun5GWIw9dt+zoerzI/5cR/+IEqdkKNgOtihuPG1pHIbh8B+GAsXlkU
         ty1lO1A/VdFy73/z1eDlPvFj2FdH1ThcoXDQ2WzmNNuvgKJmMQSsnOiKdJeJ3WhUvwxG
         SsXcSwnOXiuGm008AU7qZN7+HzFlw3hMuOZVTyJP4UvNTXgNw2etWzwmrx6DGiPYGrNH
         17VA==
X-Gm-Message-State: AAQBX9euJPXNDRsVZHTsW5mDGvAGf3tOY6Wk0PoX/DOv2ie4//wc3kmL
        XJkCSy6Ttl6t4cCYptq+YSZ3KAfa4QdaFuTO4OeSPw==
X-Google-Smtp-Source: AKy350Y15CHiF3XZEyYixnG3XWfoohx4e33btQn5O+nCfog4xzLUMdHlH7uP37UZu/RUcOVbWgF0F7ux1hUz7IYTzVE=
X-Received: by 2002:a17:907:1c09:b0:92f:b329:cb75 with SMTP id
 nc9-20020a1709071c0900b0092fb329cb75mr10558404ejc.5.1680031597358; Tue, 28
 Mar 2023 12:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-7-yosryahmed@google.com> <ZCMzfQuo9IhWVzRA@cmpxchg.org>
 <CAJD7tkZxEEcVZ9G7NSM56q_uOyL7e353NT06kD0mY5DyNmKTpw@mail.gmail.com> <ZCM6m/4ujEqvFVsn@cmpxchg.org>
In-Reply-To: <ZCM6m/4ujEqvFVsn@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 28 Mar 2023 12:26:01 -0700
Message-ID: <CAJD7tkYBO9QNZOyMt8WC0bd=wB9m1H3PHdxqPpWBx5HpUAS4Ug@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] memcg: sleep during flushing stats in safe contexts
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
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

On Tue, Mar 28, 2023 at 12:06=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Tue, Mar 28, 2023 at 11:45:19AM -0700, Yosry Ahmed wrote:
> > On Tue, Mar 28, 2023 at 11:35=E2=80=AFAM Johannes Weiner <hannes@cmpxch=
g.org> wrote:
> > > On Tue, Mar 28, 2023 at 06:16:35AM +0000, Yosry Ahmed wrote:
> > > >  void mem_cgroup_flush_stats_ratelimited(void)
> > > >  {
> > > >       if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
> > > > -             mem_cgroup_flush_stats();
> > > > +             mem_cgroup_flush_stats_atomic();
> > > > +}
> > >
> > > This should probably be mem_cgroup_flush_stats_atomic_ratelimited().
> > >
> > > (Whee, kinda long, but that's alright. Very specialized caller...)
> >
> > It should, but the following patch makes it non-atomic anyway, so I
> > thought I wouldn't clutter the diff by renaming it here and then
> > reverting it back in the next patch.
> >
> > There is an argument for maintaining a clean history tho in case the
> > next patch is reverted separately (which is the reason I put it in a
> > separate patch to begin with) -- so perhaps I should rename it here to
> > mem_cgroup_flush_stats_atomic_ratelimited () and back to
> > mem_cgroup_flush_stats_ratelimited() in the next patch, just for
> > consistency?
>
> Sounds good to me. It's pretty minor churn.

Ack. Will do so for v2. Thanks!

>
> > > Btw, can you guys think of a reason against moving the threshold chec=
k
> > > into the common function? It would then apply to the time-limited
> > > flushes as well, but that shouldn't hurt anything. This would make th=
e
> > > code even simpler:
> >
> > I think the point of having the threshold check outside the common
> > function is that the periodic flusher always flushes, regardless of
> > the threshold, to keep rstat flushing from critical contexts as cheap
> > as possible.
>
> Good point. Yeah, let's keep it separate then.

Agreed.

>
> > > > @@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgd=
at, struct scan_control *sc)
> > > >        * Flush the memory cgroup stats, so that we read accurate pe=
r-memcg
> > > >        * lruvec stats for heuristics.
> > > >        */
> > > > -     mem_cgroup_flush_stats();
> > > > +     mem_cgroup_flush_stats_atomic();
> > >
> > > I'm thinking this one could be non-atomic as well. It's called fairly
> > > high up in reclaim without any locks held.
> >
> > A later patch does exactly that. I put making the reclaim and refault
> > paths non-atomic in separate patches to easily revert them if we see a
> > regression. Let me know if this is too defensive and if you'd rather
> > have them squashed.
>
> No, good call. I should have just looked ahead first :-)
