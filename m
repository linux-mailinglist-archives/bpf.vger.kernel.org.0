Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C70564550
	for <lists+bpf@lfdr.de>; Sun,  3 Jul 2022 07:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiGCFgl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 01:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiGCFgk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 01:36:40 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A613B864
        for <bpf@vger.kernel.org>; Sat,  2 Jul 2022 22:36:40 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so10353170pjl.5
        for <bpf@vger.kernel.org>; Sat, 02 Jul 2022 22:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVr8Vk4GAOhRaHYEm3Y8nHzcxUH7utAsv7LSStpbs+Y=;
        b=AQ8i7b3OFDYTIRhiEK5trj0zo5NxQ0GDz7ouWneLDwy0T0gmEZsnoAStPve3q+/rvc
         lVSaaTyoYBBiT8/OCZBlNQR/Vl1a141ePOC/31890UZ0BQVd8xMhDzxDa2x7rDidTSUd
         wcSnTZ1DMspg4vR0DoBAV5LbOnC0eNBSUl8pbSwlryDpBOXb+D7Tyin2jKbn3K4Hav/h
         6bqasprsyu783PvPOlDTI3dGs3DBMD9D9QD/gsaNUz5a5U1EeuR2NtqM1mHN11iid8zO
         xKUuScbiJDpMxEqKjue9EB7w+d3Rgju1FI/haSDgfR2i51XF3oAmKTt+k6XpUEBjVYx/
         dZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVr8Vk4GAOhRaHYEm3Y8nHzcxUH7utAsv7LSStpbs+Y=;
        b=nV9/8lkC8wdNXC5uB9GmBI+i7OgnFHHrqWUdFtFEyp9miaTA1w0T07Nyg1GugxX4yv
         szKOoXDVhRRT2ALcoU0Ro9jc/hMGUSVmbWUqCPbHT4KvWFeUMj6foABlslpUkIgjXMIC
         pp1EH084KHjg7Z6Bi4J6Q2D+rg77NcWPg3+xsM37uibE1aXkzIzSRjWnUn7hthqBYZBT
         RWtTN+hSavBmm5p/mwPsqootsMvZnk1OL0oQg17TWD4dUfPwKyRufXlCAbP/00qO4U+2
         Ggqitim7P/fuTI+EtrkZaerQp+KTeRwv5pmDajLdLq/1+jTmfphgrAYz5eeGNyDygsAt
         R1ng==
X-Gm-Message-State: AJIora/EdVwPC5JSM3OOJCvSG13cvszqj88wZZqciKXFi+/zVqx93BLM
        bO8zijd3EhVW9Ctb+w1MDCgEuF30E4+o0TASaf0QMA==
X-Google-Smtp-Source: AGRyM1tWKgqPbepiX3xcnhlMyUGJPA2rGUmMSiEGWnzxx7mLpAnAFW+l21bb60+xCLUabPg0wy36hTfOHOSV9/FAOSY=
X-Received: by 2002:a17:90b:3b92:b0:1ec:b866:c398 with SMTP id
 pc18-20020a17090b3b9200b001ecb866c398mr26885526pjb.237.1656826599723; Sat, 02
 Jul 2022 22:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220702033521.64630-1-roman.gushchin@linux.dev>
 <CALvZod7TGhWtcRD6HeEx90T2+Rod-yamq9i+WbEQUKwNFTi-1A@mail.gmail.com> <YsBmoqEBCa7ra7w2@castle>
In-Reply-To: <YsBmoqEBCa7ra7w2@castle>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 2 Jul 2022 22:36:28 -0700
Message-ID: <CALvZod6zCHKyjd8Ewr02xcHRWrxR_82my6mmTgsRp3HceqsBcg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: do not miss MEMCG_MAX events for enforced allocations
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jul 2, 2022 at 8:39 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Fri, Jul 01, 2022 at 10:50:40PM -0700, Shakeel Butt wrote:
> > On Fri, Jul 1, 2022 at 8:35 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > >
> > > Yafang Shao reported an issue related to the accounting of bpf
> > > memory: if a bpf map is charged indirectly for memory consumed
> > > from an interrupt context and allocations are enforced, MEMCG_MAX
> > > events are not raised.
> > >
> > > It's not/less of an issue in a generic case because consequent
> > > allocations from a process context will trigger the reclaim and
> > > MEMCG_MAX events. However a bpf map can belong to a dying/abandoned
> > > memory cgroup, so it might never happen.
> >
> > The patch looks good but the above sentence is confusing. What might
> > never happen? Reclaim or MAX event on dying memcg?
>
> Direct reclaim and MAX events. I agree it might be not clear without
> looking into the code. How about something like this?
>
> "It's not/less of an issue in a generic case because consequent
> allocations from a process context will trigger the direct reclaim
> and MEMCG_MAX events will be raised. However a bpf map can belong
> to a dying/abandoned memory cgroup, so there will be no allocations
> from a process context and no MEMCG_MAX events will be triggered."
>

SGTM and you can add:

Acked-by: Shakeel Butt <shakeelb@google.com>
