Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65306A5179
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 03:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjB1Cxx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 21:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjB1Cxx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 21:53:53 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3062AD528
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 18:53:44 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id g25so1773046qki.9
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 18:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677552823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uJcyXJLAJwr9StdHvxyCyijuHGW7stJNSfv/Xd9eZlw=;
        b=Atl6ZivqdR3bkgwvNPf5ivX7HJRf1arlwlWwQK0WMYKp8VsMCxDMFrXe3NeJzRhZLw
         rKaToXwv/O+RPdFqV4RMxayyrPhgNh5fgPL2CeVgVJw4HGrYq8AQPvjcPTqGAT84m9jH
         +q3Ho2WXYzOPGNEXc8WGrfRKIoo4DSGbEZjOYLMAX2TLx/m6/v3i3krHrW85gPxmQOls
         6C+wIEPRy5aFGWvA7BUL9G7Ztm++cwv5xLex5X0Q01Zj1aEWSG4uPpqWdAqNcMUMQctG
         fWNDGWOuRW7Ek9B/TXpgj8nkgwGTxXqp08ipaSnUJ7GrsHrquzyQuLFw2D5LGn9CwcJ6
         7jFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677552823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJcyXJLAJwr9StdHvxyCyijuHGW7stJNSfv/Xd9eZlw=;
        b=z0VIZ3ei26OoDNOdlMUFRoZEsmkrfQfqEcNLQGTdsMys+KN99HEJA9QDJN/JZbMrce
         X3fOCJPXkspdSW18f0Cxfd5CFcDagLxqHUrsTKJJBTqF6Z2Gl/1K7pnOC6Fsv5q8BUZ5
         rp5AylFEAt+LBdJevXT1DcaTSV+bqBZCHhr5sgPeoIw3NAsHH1pXAHEZm8vAY4pcKCZ9
         noapZEW7j1tfs++jcOlH2OKP97dYRUV5CwkTAPkkI9QH+GYCT4Ee7BxxIKKgN0JiwnTv
         aHk8FL5lInj9lA/nNSfjLuYWpv6JZbMc7pcacsbHCTlGcNmxVpJSJzQnpinwJlKadTee
         V3yg==
X-Gm-Message-State: AO0yUKVpCbwWID/js+ayJ9Lur+bLJM8WUcpEkK5APwUsxkcaninaH8O6
        ktcUN5LJa/5qxbqxZHUtB5mqE17FG5ao8KAmf7U=
X-Google-Smtp-Source: AK7set/l4WFySaNp3Hqh5RCstOT77yV11cqW+7W5t/dDRa7Ttq3xbq3RZtoLu4kchI5KgHkwswndykMvQbfff64F0h8=
X-Received: by 2002:a05:620a:4447:b0:71f:b8f8:f3db with SMTP id
 w7-20020a05620a444700b0071fb8f8f3dbmr696760qkp.1.1677552823113; Mon, 27 Feb
 2023 18:53:43 -0800 (PST)
MIME-Version: 1.0
References: <20230227152032.12359-1-laoar.shao@gmail.com> <24b8a412-6be5-7590-acbd-4ff3990bf812@iogearbox.net>
In-Reply-To: <24b8a412-6be5-7590-acbd-4ff3990bf812@iogearbox.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 28 Feb 2023 10:53:07 +0800
Message-ID: <CALOAHbC80oroSt=Rn5nA7445X9o4ttssHtxrzFAhwK3jy1TPZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/18] bpf: bpf memory usage
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, horenc@vt.edu, xiyou.wangcong@gmail.com,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 28, 2023 at 6:37 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 2/27/23 4:20 PM, Yafang Shao wrote:
> > Currently we can't get bpf memory usage reliably. bpftool now shows the
> > bpf memory footprint, which is difference with bpf memory usage. The
> > difference can be quite great in some cases, for example,
> >
> > - non-preallocated bpf map
> >    The non-preallocated bpf map memory usage is dynamically changed. The
> >    allocated elements count can be from 0 to the max entries. But the
> >    memory footprint in bpftool only shows a fixed number.
> >
> > - bpf metadata consumes more memory than bpf element
> >    In some corner cases, the bpf metadata can consumes a lot more memory
> >    than bpf element consumes. For example, it can happen when the element
> >    size is quite small.
> >
> > - some maps don't have key, value or max_entries
> >    For example the key_size and value_size of ringbuf is 0, so its
> >    memlock is always 0.
> >
> > We need a way to show the bpf memory usage especially there will be more
> > and more bpf programs running on the production environment and thus the
> > bpf memory usage is not trivial.
> >
> > This patchset introduces a new map ops ->map_mem_usage to calculate the
> > memory usage. Note that we don't intend to make the memory usage 100%
> > accurate, while our goal is to make sure there is only a small difference
> > between what bpftool reports and the real memory. That small difference
> > can be ignored compared to the total usage.  That is enough to monitor
> > the bpf memory usage. For example, the user can rely on this value to
> > monitor the trend of bpf memory usage, compare the difference in bpf
> > memory usage between different bpf program versions, figure out which
> > maps consume large memory, and etc.
>
> Now that there is the cgroup.memory=nobpf, this is now rebuilding the memory
> accounting as a band aid that you would otherwise get for free via memcg.. :/

No, we can't get it for free via memcg, because there's no such a
"bpf" item in memory.stat, but only "kmem", "sock" and "vmalloc" in
memory.stat. With these three items we still can't figure out the bpf
memory usage, because the bpf memory usage may be far less than kmem,
for example, the dentry may consume lots of kmem.
Furthermore,  we still can't get the memory usage of each individual
map with memcg, but we can get it with bpftool. As Alexei explained in
another thread [1], "bpftool map show | awk" can show all cases.

I have tried to add the bpf item into memory.stat earlier[2], but it
seems we'd better add "memcg_id" or "memcg_path" into
bpftool-{map,prog}-show[3] instead.

[1]. https://lore.kernel.org/bpf/CAADnVQJGF5Xthpn7D2DgHHvZz8+dnuz2xMi6yoSziuauXO7ncA@mail.gmail.com/
[2]. https://lore.kernel.org/bpf/20220921170002.29557-1-laoar.shao@gmail.com/
[3]. https://lore.kernel.org/bpf/CALOAHbCY4fGyAN6q3dd+hULs3hRJcYgvMR7M5wg1yb3vPiK=mw@mail.gmail.com/


> Can't you instead move the selectable memcg forward? Tejun and others have
> brought up the resource domain concept, have you looked into it?
>

I will take a look at the resource domain concept and try to move
selectable memory forward again, but it doesn't conflict with this
series.

-- 
Regards
Yafang
