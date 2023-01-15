Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C317F66B428
	for <lists+bpf@lfdr.de>; Sun, 15 Jan 2023 22:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjAOVcT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 15 Jan 2023 16:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjAOVcS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 15 Jan 2023 16:32:18 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4213616314;
        Sun, 15 Jan 2023 13:32:17 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s3so237810edd.4;
        Sun, 15 Jan 2023 13:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n8tWmcU0b5fCDaTVTd0CKviDtOIBj5n4E8it6ot+1cI=;
        b=TnPnt5c8/Jxn0HmkGujuci8y99eMOvK2OVIftaWvvJuOWqhCg8YjnmsNLbND6/+vrs
         GvzmsgA2ngiwH4jsor1Z9w0Z8nJ4rF7BWGB2MsZ9EhMQs788nssIibehk9I7yTVuPvOK
         R1IU+jgxwrzFQvKsNLUHzst3njireRs7Y8hueO8bpnjM0uT9D66ilYq+y7m37+lI4MBL
         UmBfbN7voygoayetVOYG16v4lGgiPiNM8B1TFLUyLdiGpNMHr5p1LZQJ3IX6dOMJHaMR
         x5RP6eJLTFYAE6nRmVDlFCkXwObdDkhyRePtO150uCZOM3qTrm8PKub0FAlpon6k5Ce6
         0Jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8tWmcU0b5fCDaTVTd0CKviDtOIBj5n4E8it6ot+1cI=;
        b=yV8DMNI9bn9Hm9/MuyJxwDDoEOtHiJfUljO5QWWCy/qHymylgDqbURnOaXrp5UntbP
         ODY3NuhoKOrY/yE+kQdJaOThHIxLZtahW8fSpZlF8CsYVkQ22IjnunhDLkm8fmI/xKCC
         H8uvVt0yLOoQhDCemaV3znpzgvMjmNNLQjX0FrVAHXxHfb8O3Qj1TiGHbBXRQE3vMxNq
         hEj9NwtFZcioN/znIJl4XYOiiPrSiQ65shjiEj6GYFFEySP71MKzBUKQ84IIgvKvvUQB
         +jrgT56/V1dWc057yD+2PVwimlmMPw2VeAlPqwsadTrUdq68eQrcZYZWU6PSYPisssQG
         C7PQ==
X-Gm-Message-State: AFqh2krZxPTDBXkxnLqiJYWaGKLzOUhDQB1JtiG6HbJra2I+3ue0TmN+
        k5JyRkQXzTc0eaonfmlwX80E/e+NgfTorx5tZJo=
X-Google-Smtp-Source: AMrXdXv790MuohmN6lXSu7rpoy1rkJOw+qexGvmcpLTKtvZcaUhi+wGOcbwOLtPLIrpsbU0CwiDLwqI5Ok8kiBznSck=
X-Received: by 2002:a05:6402:500f:b0:46a:e6e3:b3cf with SMTP id
 p15-20020a056402500f00b0046ae6e3b3cfmr8470722eda.333.1673818335737; Sun, 15
 Jan 2023 13:32:15 -0800 (PST)
MIME-Version: 1.0
References: <SJ0PR04MB7248C599DE6F006F94997CF180C39@SJ0PR04MB7248.namprd04.prod.outlook.com>
In-Reply-To: <SJ0PR04MB7248C599DE6F006F94997CF180C39@SJ0PR04MB7248.namprd04.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 15 Jan 2023 13:32:04 -0800
Message-ID: <CAADnVQK4ucv=LugqZ3He9ubwdxDu6ohaBKr2E=TX0UT65+7WpQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Add CONFIG_BPF_HELPER_STRICT
To:     Roland <kernel.pwn@outlook.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
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
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
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

On Fri, Jan 13, 2023 at 11:53 PM Roland <kernel.pwn@outlook.com> wrote:
>
> In container environment, ebpf helpers could be used maliciously to
>    leak information, DOS, even escape from containers.
>    CONFIG_BPF_HELPER_STRICT is as a mitigation of it.
>    Related Link: https://rolandorange.zone/report.html

The link is arguing that a process with CAP_SYS_ADMIN permissions
can read memory of user processes, leak kernel addresses, etc.
And this is somehow an issue with bpf helpers?
and your suggested "temporary mitigation" is to CONFIG_BPF=n ?
While this patch is a "proper fix" ?
Sorry, but please stay with your "temporary mitigation" forever.
