Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15705A17E5
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 19:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbiHYRVt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 13:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbiHYRVs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 13:21:48 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC0FB6D53;
        Thu, 25 Aug 2022 10:21:48 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id x10-20020a4a410a000000b004456a27110fso3536877ooa.7;
        Thu, 25 Aug 2022 10:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pIaFX7FOhc6SEse0A5HU4oVIh1kC+/gRQ73p0g/SARw=;
        b=V4wljWRxkpMeMklXrPALxaAEWMsp2xB2QpeuYH1YcekgZme3uXSNp/ay8wwa+O6m6J
         1JY8mQtcSdNf4aTnMplJRDcdzV9DYmR5RefpytKvyVrHRbdwaU+sz2U7XdTEataEeP5J
         7Kbpq6leJLAVxCaIWc8gS4QKgtT1gPOuQ7GycGDfUfYz7C7lGBRJrcTlUj///jOiZnTD
         U9Z5hif6+77UOtXH1qaB2Cp3lRUoW48wZHT/7BFO9Nqr+ODPxHZkFI6cI1sUh7ykA7RM
         E5BN5r4TS3D1u+qcENUv5/9V/gruxMbcaUim3jiegWv6zcZEcNkG1DRTVjQ89KRs6h6o
         3i7Q==
X-Gm-Message-State: ACgBeo0ISG+IAAH1l2W9PjyazY8AL93kL0jQEtDpNIUQDVSe+1zfVCWk
        gqh/cGKi+rX48whijs/CwRckFVOaGxHdjPzYkXU=
X-Google-Smtp-Source: AA6agR5ZmpJMQBU65hMdiP7J5QTW5fuPW8UduG71Bsipmy13Jnmaqz5KFoCB1hHPKATJW+0eWI46qFnF/BR35N4+sZo=
X-Received: by 2002:a4a:aa81:0:b0:44a:da30:274e with SMTP id
 d1-20020a4aaa81000000b0044ada30274emr43396oon.97.1661448107475; Thu, 25 Aug
 2022 10:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220823210354.1407473-1-namhyung@kernel.org> <95708205-66EA-4622-A580-FD234E6CE2DA@fb.com>
 <CAM9d7cgxP6+R2BkVZfRAVvFUaJcknu8wAvKa_b1TBnTdKKiQvw@mail.gmail.com>
 <6305b7e7c7709_6d4fc20869@john.notmuch> <CAM9d7chYaeHvEkq2zCKeA6FiO0wfC2LCGc-1Sj=KdS8oU-2iFw@mail.gmail.com>
 <E6872BF2-8DB9-4D42-957B-E57EAE28AA65@fb.com>
In-Reply-To: <E6872BF2-8DB9-4D42-957B-E57EAE28AA65@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 25 Aug 2022 10:21:36 -0700
Message-ID: <CAM9d7cijLEKmBMs5M6A02GpsEPJoqxOj6+VCuaE=ae8R4VseWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
To:     Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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

On Thu, Aug 25, 2022 at 10:05 AM Song Liu <songliubraving@fb.com> wrote:
>
> > On Aug 25, 2022, at 9:57 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Aug 23, 2022 at 10:32 PM John Fastabend
> > <john.fastabend@gmail.com> wrote:
> >> Namhyung Kim wrote:
> >>> Ok, now I think that I can use a bpf-output sw event.  It would need
> >>> another BPF program to write data to the event and the test program
> >>> can read it from BPF using this helper. :)
> >>
> >> Ah good idea. Feel free to carry my ACK to the v2 with the test.
> >
> > Hmm.. it seems not to work because
> > 1. bpf_output sw event doesn't have the overflow mechanism and it
> >   doesn't call the bpf program.
> > 2. even if I added it, it couldn't run due to the recursion protection by
> >   bpf_prog_active.
>
> How about we enable some raw record for a software event? Something not
> controlled by BPF?

Only for the test?  It'd be nice if we could have meaningful data from software
events but I don't have an idea what data it could carry on which event.

Peter, what do you think?

>
> If this doesn't work, a self test that only runs on some hardware is also
> helpful.

Yep, makes sense.

Thanks,
Namhyung
