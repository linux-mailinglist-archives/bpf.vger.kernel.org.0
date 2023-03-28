Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C867E6CCAAB
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 21:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjC1Te6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 15:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjC1Tez (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 15:34:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A405EA
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 12:34:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eh3so54068966edb.11
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 12:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680032092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCcvIywQQCX7FP21Q6hk+wcOp0VhtxDKF+8JhJGEAfQ=;
        b=dHoOF8rNOSkdjd1rnnf8XC6IGb6FKwmM7Ivdvjk2GQi/EbVyThzjBYyHQXopuJULIg
         3p1bzuC4gKKNl6Fqhda2du3Rr+s6FdBcg4aXKrD1ycu2zktIM3FTOAoGmv4pZHnjujsT
         rvqc9SbA4NjhcACriIJnLeYfMpWyuhW0j5mUqMiEJuGYX3I6Vm1bge9vyTRqSfTQ+kFD
         hcNKe+61X/fdB+69ZT/PWtpn27JcWOnhGjSUdRlOVudULYhr4IE9KPo4WrZdFpVOufcb
         x3G5vlvhcJZuXWJ1jNnDtE5NmkzFKju+dq8flQe22Sd56znLfGyB2CeL5tXa6i93FNYi
         J7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680032092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCcvIywQQCX7FP21Q6hk+wcOp0VhtxDKF+8JhJGEAfQ=;
        b=EQKl7plxkTTynrUTNwWgNfMRDiFDkZYM7k1CDNwnBlgXTrot0pF950BuUPL+b4zO71
         QWQnPqnDoyX9b3xlz1fjqPLK5xLQ5QgPilweSL0bAWHpRWUlqcKhCW7WHBW0TYbng5Sd
         9UO+Z6Vli4fjwzeZFj/stRVpBnri12IUTs+7U/Y/oLFdGtcjHHJJuHVN1LI5sWrlOBGU
         /VJS/bjFENQ6EOs+gySQNWqRpCyyOSJW2drGaPeNGL7vJkZw6/doJo7RZvtX32ENp/lL
         WVTnrlPfEyUt/hdzr4wnd3KpW+uDKfL+MbaCbOFUZlfKadKeIvCLn6Bl+ioUDYb5JgsB
         Xgow==
X-Gm-Message-State: AAQBX9ds3/Jt11vdIHvNKSZVuLs+U10a0DyimuLeYQEDRXce2XSzZgg4
        6M9+pn8mfGCAsKO03JLCdY001DQY4umdOC4WG+AQ8g==
X-Google-Smtp-Source: AKy350YOd+MIycwAtui+juLEs+/XeA1BayeLMmg6/SLyZm36OoLT9BnRDKlngVlZ55Qf5nONmzBspfNUTrbsKzLJWs4=
X-Received: by 2002:a50:d581:0:b0:502:1d1c:7d37 with SMTP id
 v1-20020a50d581000000b005021d1c7d37mr8497378edi.8.1680032091630; Tue, 28 Mar
 2023 12:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-6-yosryahmed@google.com> <20230328141523.txyhl7wt7wtvssea@google.com>
 <CAJD7tkYo=CeXJPUi_KxjzC0QCxC2qd_J2_FQi_aXh7svD8u60A@mail.gmail.com> <CALvZod4Gsngc6MjXdk4s5+ePVjsgcVppdRmsQovN6gSrxzdbfA@mail.gmail.com>
In-Reply-To: <CALvZod4Gsngc6MjXdk4s5+ePVjsgcVppdRmsQovN6gSrxzdbfA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 28 Mar 2023 12:34:15 -0700
Message-ID: <CAJD7tkb_YA3fvo3LgCzR+X-b-r-AmAR68hNR=xT7B6TJfBa54A@mail.gmail.com>
Subject: Re: [PATCH v1 5/9] memcg: replace stats_flush_lock with an atomic
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
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

On Tue, Mar 28, 2023 at 12:28=E2=80=AFPM Shakeel Butt <shakeelb@google.com>=
 wrote:
>
> On Tue, Mar 28, 2023 at 11:53=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> [...]
> > > > +     if (atomic_xchg(&stats_flush_ongoing, 1))
> > >
> > > Have you profiled this? I wonder if we should replace the above with
> > >
> > >         if (atomic_read(&stats_flush_ongoing) || atomic_xchg(&stats_f=
lush_ongoing, 1))
> >
> > I profiled the entire series with perf and I haven't noticed a notable
> > difference between before and after the patch series -- but maybe some
> > specific access patterns cause a regression, not sure.
> >
> > Does an atomic_cmpxchg() satisfy the same purpose? it's easier to read
> > / more concise I guess.
> >
> > Something like
> >
> >     if (atomic_cmpxchg(&stats_flush_ongoing, 0, 1))
> >
> > WDYT?
> >
>
> No, I don't think cmpxchg will be any different from xchg(). On x86,
> the cmpxchg will always write to stats_flush_ongoing and depending on
> the comparison result, it will either be 0 or 1 here.
>
> If you see the implementation of queued_spin_trylock(), it does the
> same as well.

Interesting. I thought cmpxchg by definition will compare first and
only do the write if stats_flush_ongoing =3D=3D 0 in this case.

I thought queued_spin_trylock() was doing an atomic_read() first to
avoid the LOCK instruction unnecessarily the lock is held by someone
else.
