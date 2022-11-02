Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0B161708B
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 23:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiKBWS0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 18:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiKBWS0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 18:18:26 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C841760FF;
        Wed,  2 Nov 2022 15:18:24 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id t62so175051oib.12;
        Wed, 02 Nov 2022 15:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dR8uIufVFmQcFdrcHJYjIkFyqVjcm0qVXvQv/HVwRjc=;
        b=d3Zn6YxfLie56/O3Wm2JZwzO7nurUYi3rOmteRFj5pU5/sqXUvu9pCJgwBeEdjCTXU
         ASCas664Uy5cxV3PTPTXwvHUjET1a3ng3mcZkgoOPcPVeFqxvfRFCr48GW811T+DZyDZ
         heQ9LOspNpCuprPXhn87gcUP7pqNsYDXiL/t2N+pFyFXc/QOl0BM+bPFu4ORvCeBSmOR
         op4oy7y5TMbQEEP9bPqzlo/tHIXDvQl1DX+8Ok5SzB7SHDnw6F3gKR8NQOgYqfqOIh4A
         yOckmqIgBkQ6XS2q3WusM24dbvhmiDUnFZfAm3Cz070cWk+kF2CPnPUerVvr3LSmFKtH
         mGgg==
X-Gm-Message-State: ACrzQf1gpglYoPNsHx2oZMQZIAYGPzHkI73Q1erRB+MjiM2SyVx0uADd
        29cE/P9k4+mRk5Cy6h7cTBE4YOGu0YGyJR0HMYU=
X-Google-Smtp-Source: AMsMyM6q7R3EyYUPkk/AzDCYX0Ctf96X0PBm7eOp29CIWSHbiGQPUh1ET5i4QdZWILZLdwuEtKSd+kLveoPLddfA/Dk=
X-Received: by 2002:aca:ac82:0:b0:359:d662:5bfb with SMTP id
 v124-20020acaac82000000b00359d6625bfbmr15283796oie.218.1667427504100; Wed, 02
 Nov 2022 15:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221101052340.1210239-1-namhyung@kernel.org> <20221101052340.1210239-3-namhyung@kernel.org>
 <Y2DuzmnUm6NIh25a@krava> <CAADnVQJ6+N6vQ=ZUgUjoB_M2RoTGGPXpLwz81mNDmLWrGYKetw@mail.gmail.com>
 <CAPhsuW6iuEZCCYJk-cra8DkEWNtdin8GyJDZ6Y8zd4ecfd1gQA@mail.gmail.com>
 <CAADnVQ+SYv5O+UxnGaBAvxptopWyANdbQRg=e2GXiRBPyJMGgA@mail.gmail.com>
 <CAPhsuW55zAYCipf1P4dM8Cu9QFewnyZE+SOquKhSbdqUWG_EKg@mail.gmail.com>
 <CAM9d7chKunyZX=-9gANZ2BKZTzQXuWYCgPQU46jCHkqsjsoGUg@mail.gmail.com> <CAPhsuW70GMFfzvgp__GOhebPu9bXnG7PzEby6xEExFgg+JmeTQ@mail.gmail.com>
In-Reply-To: <CAPhsuW70GMFfzvgp__GOhebPu9bXnG7PzEby6xEExFgg+JmeTQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 2 Nov 2022 15:18:12 -0700
Message-ID: <CAM9d7chq+Y5M-4S1HWwxBkL+aRysGt8griGbo_jXG4g+EQK_gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add bpf_perf_event_read_sample() helper
To:     Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 1, 2022 at 5:13 PM Song Liu <song@kernel.org> wrote:
>
> On Tue, Nov 1, 2022 at 3:17 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > IIUC we want something like below to access sample data directly,
> > right?
> >
> >   BPF_CORE_READ(ctx, data, ip);
> >
>
> I haven't tried this, but I guess we may need something like
>
> data = ctx->data;
> BPF_CORE_READ(data, ip);

Ok, will try.

>
> > Some fields like raw and callchains will have variable length data
> > so it'd be hard to check the boundary at load time.
>
> I think we are fine as long as we can check boundaries at run time.

Sure, that means it's the responsibility of BPF writers, right?

>
> > Also it's possible
> > that some fields are not set (according to sample type), and it'd be
> > the user's (or programmer's) responsibility to check if the data is
> > valid.  If these are not the concerns, I think I'm good.
>
> So we still need 1/3 of the set to make sure the data is valid?

Of course, I'll keep it in the v2.

Thanks,
Namhyung
