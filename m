Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1706466E34D
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 17:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjAQQVS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 11:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjAQQVN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 11:21:13 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A8C3F2A7;
        Tue, 17 Jan 2023 08:21:10 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x36so11141212ede.13;
        Tue, 17 Jan 2023 08:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kivy3jjwYzn/JSNdHib7sOuDADuWRA8LRyBLPMjZpsw=;
        b=lhzHuEISQLNBnbnHTdwp8z0zhTajtQGyI9rlUAHOK2/dHfdisep4Uryyj0ATZc77i/
         /OODhNip16HPrLO7yMjA1HnKAovGCLpMCxpLNO2eFXMqaaY9o7yKTxafqt6qPsDcap0y
         kfZvsMjgyAJpVtfv8wC4iVmfzWKU73T9YgXJY/2DV2689Qc1sDlM/N6m/lyDLZ/a+sK2
         qDWkKqaGXsFLZSOrOYlCbgS+9hObrEjpnuFdo1LjyBwi6m4UGl5zvUdy0VNjlgqEEfH4
         P6Tlwm7y0kawyQli3EKqE24h6KX2hh2TudreAR+NHUsQDYDxHvduGNjJbSJG6DRWBlg9
         ERZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kivy3jjwYzn/JSNdHib7sOuDADuWRA8LRyBLPMjZpsw=;
        b=MjV+OSitMrdKTsD83gge0RG8pWdgEhB6oKnbFqNAoYZJAX7EjNVU5qBYIxmo2wka1p
         ff5/mXib66XngxIHdQd5ChHyhy46IV+eK8uZd6+8/o7NRvvLSLCszcWodw0/PQ9OyCIE
         9K4u9s4DPmPZlV+thDnKppFeS+ZfYaeoSidIzok9I/nXJy+o1brAz122LwDfeQnzbgH3
         VKA+7Bn7cI2/EXn7C4uIln4I0Hez33+PmEkO6XtEb1QP+AL3FOv7G1JieESZm/UsA8Mx
         EBknDW8uj8goj5z9hc31ggf1Vbzr3bUfSCYddO/DyGZxYk6Am0UBJoDMadB1jnUnDuQm
         vSsg==
X-Gm-Message-State: AFqh2ko03b2Y5F0qI5PKNFEH7J3P92BYiIaP6QcDsQmwHyy1EDVEQvvv
        IrXac6IsYE2yxtVE4Ro4TSggndpBolJGPikp/L8=
X-Google-Smtp-Source: AMrXdXubGYZD7aTuuhUm2OVgI5EY37JQNqhACjZ7vVZCoKjTFv0ui636JHLvkUs2+m+OPe9YPBXbALJzyat2gtiWImM=
X-Received: by 2002:aa7:cac6:0:b0:46a:e6e3:b3cf with SMTP id
 l6-20020aa7cac6000000b0046ae6e3b3cfmr379150edt.333.1673972468743; Tue, 17 Jan
 2023 08:21:08 -0800 (PST)
MIME-Version: 1.0
References: <SJ0PR04MB7248C599DE6F006F94997CF180C39@SJ0PR04MB7248.namprd04.prod.outlook.com>
 <CAADnVQK4ucv=LugqZ3He9ubwdxDu6ohaBKr2E=TX0UT65+7WpQ@mail.gmail.com>
 <CACYkzJ75aNbH4w_GzYjrNPKis1x24KOu_33DniY_ig5s3ycobg@mail.gmail.com> <SJ0PR04MB724883C0DC180E3A45CBB36780C69@SJ0PR04MB7248.namprd04.prod.outlook.com>
In-Reply-To: <SJ0PR04MB724883C0DC180E3A45CBB36780C69@SJ0PR04MB7248.namprd04.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 17 Jan 2023 08:20:57 -0800
Message-ID: <CAADnVQKvoy9L9es=YAr7JkcKR2GGn_uH=Q1Cp89N2KkwB4jgAg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Add CONFIG_BPF_HELPER_STRICT
To:     Pwn Kernel <kernel.pwn@outlook.com>
Cc:     KP Singh <kpsingh@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, bristot <bristot@redhat.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 16, 2023 at 10:25 PM Pwn Kernel <kernel.pwn@outlook.com> wrote:
>
> Thank you for your suggestion so much, we understand it.
>
> In the other hand, Do you think if add several lockdown reasons like LOCKDOWN_BPF_SEND_SIGNAL and  LOCKDOWN_BPF_OVERRIDE_RETURN will be better or acceptable for this?
>
> Thanks for your advice!

Please do not top post and don't use html in your replies.
Please learn the process first:
https://docs.kernel.org/process/development-process.html
