Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F495A2C5A
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiHZQdk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiHZQdi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:33:38 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08875DD4CA;
        Fri, 26 Aug 2022 09:33:38 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-11c4d7d4683so2690565fac.8;
        Fri, 26 Aug 2022 09:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0Z6D6Sxti99F+xj/7ip2qq8AUtDFfJQ2ASh7JTCA1fk=;
        b=0FcXjLK8i88mcU8YSLU1TRPk3bTiIVSTyWApKA8aFk8mor7T747r0+bU1nagKfUxQZ
         iY5HOWVHzAo+K7A2VD93MzO7VQvIqSxAJbsereKT3XQz+kPJWfi0MDgSQZOA1nua6rfD
         FetadJzGE2LvfYLvz/wLVGyFiaCYMKxS9E+nPJV9ILC6H6thwUYfOeoren67EdRXTLz2
         lHwvctrBNh3XHE35uuNzXxkS8fewjXlXh/Qc0XCOjrA4oD/eo+SMIH7TwGVr+9s5KtFM
         OiDQPAE6orOP8DjXpfhZvScX+6Ba3AuY2hDIMmiGuzQbN9OVCIv5l9mxvu3Z4YNHnh3u
         abXg==
X-Gm-Message-State: ACgBeo0MSw/+4ncB4yRpZnfZXTVUkKjmrVccGqOq11xTsc/4476Cg0eQ
        2vsJVh2Z0CA74YL0NqfHiPlNwj1YeFhcG2CIr4w=
X-Google-Smtp-Source: AA6agR6F/9j3KM54tAzy1q1X/e0Z9RZWqhaOlTYQgbBz89iya844tMqeldk2hWWg+XoB7bof2FNdOgetqdnGN7pQ9dc=
X-Received: by 2002:a05:6870:a184:b0:116:bd39:7f94 with SMTP id
 a4-20020a056870a18400b00116bd397f94mr2261698oaf.5.1661531617282; Fri, 26 Aug
 2022 09:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220823210354.1407473-1-namhyung@kernel.org> <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
 <A9E2E766-E8A2-4E2E-A661-922400D2674D@fb.com> <CAEf4BzbGf6FuM7VcnA7HKb33HJeJjrDuydC4h1_tCUB8sPCW2g@mail.gmail.com>
 <E215461A-01E7-4677-A404-C4439D66A7AF@fb.com> <CAM9d7cgigkU8quUMpScL=Xt8+WLDVXKiF5xdKiz7BbDPibSNjg@mail.gmail.com>
 <CAPhsuW5V1U_UTHQw9E80vCTeP4Jqg9Ta8B+7o3pybKB=8CGRFA@mail.gmail.com>
In-Reply-To: <CAPhsuW5V1U_UTHQw9E80vCTeP4Jqg9Ta8B+7o3pybKB=8CGRFA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 26 Aug 2022 09:33:26 -0700
Message-ID: <CAM9d7cjTtOkRHLOosxHN8PcbVbhTK=uLDGjw8N5=1QiTHcd6rQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
To:     Song Liu <song@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 25, 2022 at 10:53 PM Song Liu <song@kernel.org> wrote:
>
> On Thu, Aug 25, 2022 at 10:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Aug 25, 2022 at 7:35 PM Song Liu <songliubraving@fb.com> wrote:
> > > Actually, since we are on this, can we make it more generic, and handle
> > > all possible PERF_SAMPLE_* (in enum perf_event_sample_format)? Something
> > > like:
> > >
> > > long bpf_perf_event_read_sample(void *ctx, void *buf, u64 size, u64 flags);
> > >
> > > WDYT Namhyung?
> >
> > Do you mean reading the whole sample data at once?
> > Then it needs to parse the sample data format properly
> > which is non trivial due to a number of variable length
> > fields like callchains and branch stack, etc.
> >
> > Also I'm afraid I might need event configuration info
> > other than sample data like attr.type, attr.config,
> > attr.sample_type and so on.
> >
> > Hmm.. maybe we can add it to the ctx directly like ctx.attr_type?
>
> The user should have access to the perf_event_attr used to
> create the event. This is also available in ctx->event->attr.

Do you mean from BPF?  I'd like to have a generic BPF program
that can handle various filtering according to the command line
arguments.  I'm not sure but it might do something differently
for each event based on the attr settings.

Thanks,
Namhyung
