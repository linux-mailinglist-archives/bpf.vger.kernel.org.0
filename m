Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B766187CD
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 19:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiKCSlb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 14:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiKCSl3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 14:41:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB55313DC4;
        Thu,  3 Nov 2022 11:41:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7715FB81F9B;
        Thu,  3 Nov 2022 18:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4F5C43144;
        Thu,  3 Nov 2022 18:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667500886;
        bh=+x0WEovETjX96nWQFwOLkbvYF0kQ4DTi71pRIT1th6o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sk/BhSI8QNzqciRrw9XBNYN9knhXD9DdOeneUlayCBRtzammb7jhAAzW6DfJns8DO
         G2RQpa8pFrb80OQ9TNrZzaJxR0FNtvaNGzREmplYDIvGdT/G9wMDUkmBReIO4kibec
         cqPzdRHmnXbzh1ndHNfqvgD8T7jSAbzafTLjByx5n8sI+RmfA6xB3zc8RN/9whgc9w
         nQo2lCfzkda5pjhmCCcw0X3fcT9B4D8oTClXhbhHrzy37CX7/eEe5CYbJDQvAxAYrm
         1ufC2U7Q1KNupRmJxVm1YRAvXzPDU/Cs5bIdy5gkz9kB4n+F1PP1o3748w+02tE6VQ
         qUqCd3Sg2Ftog==
Received: by mail-ej1-f47.google.com with SMTP id d26so7656421eje.10;
        Thu, 03 Nov 2022 11:41:25 -0700 (PDT)
X-Gm-Message-State: ACrzQf3OQDYQNusxAojeaPtxMFmbAXsJUnq6RqD4yPJ1/DoWiqECBeGT
        iUbk2K8Qr7dXYpD/woMoJJ9/KPANRRsjaWJZVIg=
X-Google-Smtp-Source: AMsMyM7kNiALwBf+N4zPiSLgTQINbawgVQLHjgjL/zWoVwnkkJZFP1vwl80lcs5vCupd7qkj0oC6t32XAe6s1eOZBx4=
X-Received: by 2002:a17:907:b602:b0:7ad:e82c:3355 with SMTP id
 vl2-20020a170907b60200b007ade82c3355mr17171451ejc.3.1667500884319; Thu, 03
 Nov 2022 11:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221101052340.1210239-1-namhyung@kernel.org> <20221101052340.1210239-3-namhyung@kernel.org>
 <Y2DuzmnUm6NIh25a@krava> <CAADnVQJ6+N6vQ=ZUgUjoB_M2RoTGGPXpLwz81mNDmLWrGYKetw@mail.gmail.com>
 <CAPhsuW6iuEZCCYJk-cra8DkEWNtdin8GyJDZ6Y8zd4ecfd1gQA@mail.gmail.com>
 <CAADnVQ+SYv5O+UxnGaBAvxptopWyANdbQRg=e2GXiRBPyJMGgA@mail.gmail.com>
 <CAPhsuW55zAYCipf1P4dM8Cu9QFewnyZE+SOquKhSbdqUWG_EKg@mail.gmail.com>
 <CAM9d7chKunyZX=-9gANZ2BKZTzQXuWYCgPQU46jCHkqsjsoGUg@mail.gmail.com>
 <CAPhsuW70GMFfzvgp__GOhebPu9bXnG7PzEby6xEExFgg+JmeTQ@mail.gmail.com> <CAM9d7chq+Y5M-4S1HWwxBkL+aRysGt8griGbo_jXG4g+EQK_gg@mail.gmail.com>
In-Reply-To: <CAM9d7chq+Y5M-4S1HWwxBkL+aRysGt8griGbo_jXG4g+EQK_gg@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 3 Nov 2022 11:41:12 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7ri8gUdhQkk=VWHRWvJGd3MjZk+PMfJ0d-hXFKb=Z8Eg@mail.gmail.com>
Message-ID: <CAPhsuW7ri8gUdhQkk=VWHRWvJGd3MjZk+PMfJ0d-hXFKb=Z8Eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add bpf_perf_event_read_sample() helper
To:     Namhyung Kim <namhyung@kernel.org>
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
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 2, 2022 at 3:18 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Nov 1, 2022 at 5:13 PM Song Liu <song@kernel.org> wrote:
> >
> > On Tue, Nov 1, 2022 at 3:17 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > IIUC we want something like below to access sample data directly,
> > > right?
> > >
> > >   BPF_CORE_READ(ctx, data, ip);
> > >
> >
> > I haven't tried this, but I guess we may need something like
> >
> > data = ctx->data;
> > BPF_CORE_READ(data, ip);
>
> Ok, will try.
>
> >
> > > Some fields like raw and callchains will have variable length data
> > > so it'd be hard to check the boundary at load time.
> >
> > I think we are fine as long as we can check boundaries at run time.
>
> Sure, that means it's the responsibility of BPF writers, right?

Right, the author of the BPF program could check whether the data
is valid.

Song

>
> >
> > > Also it's possible
> > > that some fields are not set (according to sample type), and it'd be
> > > the user's (or programmer's) responsibility to check if the data is
> > > valid.  If these are not the concerns, I think I'm good.
> >
> > So we still need 1/3 of the set to make sure the data is valid?
>
> Of course, I'll keep it in the v2.
>
> Thanks,
> Namhyung
