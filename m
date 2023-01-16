Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B0866D104
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 22:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjAPVjr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 16:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbjAPVji (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 16:39:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F8A2BEF7
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 13:39:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F57161155
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 21:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B006AC433F2
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 21:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673905175;
        bh=weET09a+ApawIsIatnvFTDnBOF/EDNC+WndN/Pj7sP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PI9/0VJhIuleRzqDyGxToT3hXqpP6NAczZ6JAe2nd9+m/ZG0RKcvwojVQDhuLxTzw
         88pwKlBU8AApOlfR5S7NIt/zsRdD71Zq4JyZTw9QOUgZMCldlB74ZhO0x96VAm2J0P
         rBcBUyf3Ki8qVCy+YG+GjX0+H/yvqsGGd1ffaTEUVbaexoM0QdO5rIqSUWRJzc/Avw
         jOhEh3L5G0mjKuBEsZpBidX8dwCRWRn4167xYTsAp8J7QzxeQ4pGkt7DTkbnPLXKWB
         HOXj8EW+DrekEd4HZ+idtCAUdiMztgcBOz+jc5ZiivqZScme2CZ7WGkbVpcsvdkR6B
         oWSS6bDCw5SmA==
Received: by mail-ed1-f47.google.com with SMTP id v10so41230710edi.8
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 13:39:35 -0800 (PST)
X-Gm-Message-State: AFqh2koeRbxHgLhlThryA1zNBul7LtPifqmf6HaJGM55eIkjedReGHj9
        S9fKcGHjL1YgKR7sdYODk2BzTn1BS0M090a2vSpXsw==
X-Google-Smtp-Source: AMrXdXsOFsLavQ9hyoAJhVqVxyprMYzeot7dXdv5Eh5PbuRKJO/EJOZYtAE1n+GMR/a/Ag0t9c05HK1eGxgP1uhaOWo=
X-Received: by 2002:a05:6402:194b:b0:49d:ba1:dc82 with SMTP id
 f11-20020a056402194b00b0049d0ba1dc82mr53839edz.312.1673905163253; Mon, 16 Jan
 2023 13:39:23 -0800 (PST)
MIME-Version: 1.0
References: <SJ0PR04MB7248C599DE6F006F94997CF180C39@SJ0PR04MB7248.namprd04.prod.outlook.com>
 <CAADnVQK4ucv=LugqZ3He9ubwdxDu6ohaBKr2E=TX0UT65+7WpQ@mail.gmail.com>
In-Reply-To: <CAADnVQK4ucv=LugqZ3He9ubwdxDu6ohaBKr2E=TX0UT65+7WpQ@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 16 Jan 2023 22:39:12 +0100
X-Gmail-Original-Message-ID: <CACYkzJ75aNbH4w_GzYjrNPKis1x24KOu_33DniY_ig5s3ycobg@mail.gmail.com>
Message-ID: <CACYkzJ75aNbH4w_GzYjrNPKis1x24KOu_33DniY_ig5s3ycobg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Add CONFIG_BPF_HELPER_STRICT
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Roland <kernel.pwn@outlook.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com,
        Mel Gorman <mgorman@suse.de>, bristot <bristot@redhat.com>,
        vschneid@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 15, 2023 at 10:32 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jan 13, 2023 at 11:53 PM Roland <kernel.pwn@outlook.com> wrote:
> >
> > In container environment, ebpf helpers could be used maliciously to
> >    leak information, DOS, even escape from containers.
> >    CONFIG_BPF_HELPER_STRICT is as a mitigation of it.
> >    Related Link: https://rolandorange.zone/report.html
>
> The link is arguing that a process with CAP_SYS_ADMIN permissions
> can read memory of user processes, leak kernel addresses, etc.
> And this is somehow an issue with bpf helpers?
> and your suggested "temporary mitigation" is to CONFIG_BPF=n ?
> While this patch is a "proper fix" ?
> Sorry, but please stay with your "temporary mitigation" forever.

100% agreeing with Alexei here, if you are running your containers
with CAP_SYS_ADMIN there are a lot of other things you need to worry
about than just BPF helpers. You need to revisit your threat model and
consider not using CAP_SYS_ADMIN and more fine grained policies using
Mandatory Access Control.
