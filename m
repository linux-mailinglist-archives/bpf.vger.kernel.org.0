Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468FD5A2FF5
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 21:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbiHZTaf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 15:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344542AbiHZTac (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 15:30:32 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1267D1D4;
        Fri, 26 Aug 2022 12:30:28 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-11c896b879bso3300953fac.3;
        Fri, 26 Aug 2022 12:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MV9HcE+YotBWRk5ak3CDk3K3UaedF5Ak4KfOCBI4ruw=;
        b=Q1IBDWxe7glzGLQaqz80dDxtUuApYK3txsfzrYk3/R/0UJfZ10NjWG7kZ4hTR26O4D
         drY4U0oX/64Cqwr1vGk59j2YhWVk9geECng3MvDyB7LdSY/kadqjuuSgGm6uGRuPJG4+
         oJMamx6rQbXnBXCtDn0ueGzIK08QjLMwau8sUJaYj8erBjKxhwOpRm9n6OsdG0Hc65SM
         W01hiI9ixaBSv7ByNcMgU2OaTF90qA7N6EKqwVrlKUA5ekMX4FS54e/yNWXlFbDBL60D
         BZB43OAZLHMuwpBvtwFYRGCrg1wPpI9MKTSFSw0W1kJRESjyv8JaA9zBBy+kAR4XIs+p
         /sCw==
X-Gm-Message-State: ACgBeo0kAjRWLDjWWs1jUrT5H2uXsR73Jys5mYXShua6YcF9X5dyTFcV
        NokszhGLKZ0c4vXplV4DdZWHXf9xlpSKpRhPslo=
X-Google-Smtp-Source: AA6agR6DXr7+O59BUREt6M89pQSwVh0O7v7A9RIsu37vp0spLroF8GeEif5jjilIf6Lo22Zkmy/KWeoAzfVmMI3GnpY=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr2598612oab.92.1661542228280; Fri, 26
 Aug 2022 12:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220823210354.1407473-1-namhyung@kernel.org> <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
 <A9E2E766-E8A2-4E2E-A661-922400D2674D@fb.com> <CAEf4BzbGf6FuM7VcnA7HKb33HJeJjrDuydC4h1_tCUB8sPCW2g@mail.gmail.com>
 <E215461A-01E7-4677-A404-C4439D66A7AF@fb.com> <CAM9d7cgigkU8quUMpScL=Xt8+WLDVXKiF5xdKiz7BbDPibSNjg@mail.gmail.com>
 <CAPhsuW5V1U_UTHQw9E80vCTeP4Jqg9Ta8B+7o3pybKB=8CGRFA@mail.gmail.com>
 <CAM9d7cjTtOkRHLOosxHN8PcbVbhTK=uLDGjw8N5=1QiTHcd6rQ@mail.gmail.com>
 <C7F3F33B-4A8E-428C-9FED-FB635955C2B1@fb.com> <FCC75F8E-4C2F-42A4-B582-9BE3BB87E15A@fb.com>
In-Reply-To: <FCC75F8E-4C2F-42A4-B582-9BE3BB87E15A@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 26 Aug 2022 12:30:17 -0700
Message-ID: <CAM9d7cj6YNTL+u38PZjhPF2Qg_BYiJ1NMmDkPDx3N3Xe+ZTbyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <song@kernel.org>,
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

On Fri, Aug 26, 2022 at 11:45 AM Song Liu <songliubraving@fb.com> wrote:

> > And actually, we can just read ctx->data and get the raw record,
> > right..?
>
> Played with this for a little bit. ctx->data appears to be not
> reliable sometimes. I guess (not 100% sure) this is because we
> call bpf program before event->orig_overflow_handler. We can
> probably add a flag to specify we want to call orig_overflow_handler
> first.

I'm not sure.  The sample_data should be provided by the caller
of perf_event_overflow.  So I guess the bpf program should see
a valid ctx->data.

Also I want to control calling the orig_overflow_handler based
on the return value of the BPF program.  So calling the orig
handler before BPF won't work for me. :)

Thanks,
Namhyung
