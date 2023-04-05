Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D195A6D7630
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 10:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbjDEIDC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 04:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbjDEIDB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 04:03:01 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5824EED
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 01:02:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eg48so138863837edb.13
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 01:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680681758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEwjzYcWs+Nq2B13OiqxRc4o61ZYX+Tx79hgu5r8M58=;
        b=RPHLXw9sSgwpHJr/+l3qfC5nPoEvslH4Vlvp7ZohRVeJUYUwEgpmuvPKwY6/LAXZ4c
         UOr2vNt2IlvzNfCaVQTdzSrG/5hklqwq4qvvOX5tzuKA2xdV4XLARc3NBhi1qSAOQjD1
         cAmoZtTp54aqHRdSbkkOPSuSe2DuJuiQ60d3rrjhRuEDjbeDCiCtdJofsgfVpbUXlEjX
         CQZYdJCMd59NPSp5JXIV8SyRsgFDebBJEr+pQBUnYDWZ3fuQ/FuyH+8DnTaPmUf7AJD/
         oDSYlI8G38WcKprwnEqQcqTjojvsHbIsQB/2aZR84YGGUdCVPwVqmG5BIFmMQrVLugm6
         fcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680681758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEwjzYcWs+Nq2B13OiqxRc4o61ZYX+Tx79hgu5r8M58=;
        b=DU5gLUr+tCYcrzxHfcstKPnjDcKkptHsCym0vr9akOS3PnuhtOt+7QgRTKvF7gFHkP
         v726BYTE4OqDmNQZu/JRNsbI3vZI0/m+wioJfo2IKqQUs7hbivC6b8qjFs6XvvkA+Z3P
         MLo1JjkzgiWAlUBSEXI4yGC99V0LwGygfI/f6+kQFlpiJ9Bhife9pkRjK3Ts4G4PaazQ
         RpPMEIVAy2dsXB/vfr0UMiPlBuFKh0d3Ev/+oeS/aSgXCtVKDTPgLh977zF5YdbBBBcE
         x9H0PAxNyWXwV75FfyTVn7HSu7M9/ni9JhSAUlxpXoPUwt/W8Wh3KH5GwQyl0BcPb67i
         goPQ==
X-Gm-Message-State: AAQBX9fcml7tbAKVlPGDRM06XPFGK7qOr0dE6YmxcJt3+26icgfHJei6
        V6LkOudh2L9GEXszOqYwn+foxVeaUqgahAwBmVemTQ==
X-Google-Smtp-Source: AKy350bXpxYlvw6dqDC/3+ZE/o8/JBMCNfQUvuJlpr105khYN6b3g46OQoameMWIodO45GVOZYCuDafAJ9j07z3+Rb4=
X-Received: by 2002:a17:907:2075:b0:947:72cd:9325 with SMTP id
 qp21-20020a170907207500b0094772cd9325mr1212514ejb.15.1680681758108; Wed, 05
 Apr 2023 01:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230330191801.1967435-1-yosryahmed@google.com>
 <20230330191801.1967435-7-yosryahmed@google.com> <20230404165305.ffs7uscqpndnfytn@blackpad>
 <CAJD7tkb-0rXL9V2TX-Ax-3OkwJPYx_GaOT4D=VCA60riit+dOw@mail.gmail.com> <20230405080047.5omnatjbwz46f3y5@blackpad>
In-Reply-To: <20230405080047.5omnatjbwz46f3y5@blackpad>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 5 Apr 2023 01:02:01 -0700
Message-ID: <CAJD7tkZ=o42N_45LxRPg=oOg56Lqn-wqT_0JJUPPoKOB+ig2JQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] workingset: memcg: sleep when flushing stats in workingset_refault()
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>
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

On Wed, Apr 5, 2023 at 1:00=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> On Tue, Apr 04, 2023 at 11:09:02AM -0700, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > IIUC there are multiple places where we can sleep in this path, we can
> > sleep waiting for a page to be read from disk, we can sleep during
> > allocating the page to read into, and IIUC the allocations on the
> > fault path can even run into reclaim, going into the vmscan code. So
> > there are precedents, but I am not sure if that's enough argument.
>
> I expect it'd depend on the proportion of the slow/fast paths.
> OK, let's see how it turns out in wider population.

Agreed. It also depends on the number of memcgs and how much the
periodic flusher is keeping up. I think no amount of testing will
cover all or even most workloads.

>
> Thanks,
> Michal
