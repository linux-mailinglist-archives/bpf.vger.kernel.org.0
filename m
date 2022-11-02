Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818CA615675
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 01:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKBANs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 20:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKBANp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 20:13:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D998510E0;
        Tue,  1 Nov 2022 17:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30F656176B;
        Wed,  2 Nov 2022 00:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91186C43470;
        Wed,  2 Nov 2022 00:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667348023;
        bh=W5/aHpfTqxwv/nvrlYsLGEOlpYa6t8S/FHMPfvIzJRE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fEBWQV/wl4DU9DFj2+ZEZUI4vaK9IP/j4G7WaF+BE7GxJkRZ6+yeT/Wf1rlvRTE7g
         mJOM0L8AfgapMJTu93I+EtxXmPNuqHJQv5Fb3L4Koh+nsFucg0kZB7rRkf6TFWHpyV
         p636ijFY1A9DUkg+5EMdDhEIJtwXM5naKTD+TP4QKccTJry6ft57Nwa3i2l1fj+bNd
         /fxrFg/XPOAtxidb4SPJAZZ4WEMKJNbAquEiyAhnL9oMO9zoMxASkB7/g3Do6Z74I/
         ka0graJ7VYk0JeYxJ9OERlR/jqB4W/UtBLegTsZh4JgfPR+7NPQwnnoyLnqA6PJ92b
         OYxnkmD9P81Qw==
Received: by mail-ed1-f51.google.com with SMTP id 21so24120980edv.3;
        Tue, 01 Nov 2022 17:13:43 -0700 (PDT)
X-Gm-Message-State: ACrzQf1jaBaVaX0Teo1z2jnSVc9Fh4hpg2bjOwUaQnjRj9YHlfjgb9rC
        YXdQHvJol0G8lHPobBDvxKx3dJAgexDRM/fUrUQ=
X-Google-Smtp-Source: AMsMyM7fpo1hygNW+WdKPt/ClXuTcf4KPITZbkTdR2Sawerz1XlnjPSfwaJrORCbCZuB4o0IUEG4PJbWKDwncFhKS8I=
X-Received: by 2002:aa7:d710:0:b0:463:bd7b:2b44 with SMTP id
 t16-20020aa7d710000000b00463bd7b2b44mr4877227edq.385.1667348021818; Tue, 01
 Nov 2022 17:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221101052340.1210239-1-namhyung@kernel.org> <20221101052340.1210239-3-namhyung@kernel.org>
 <Y2DuzmnUm6NIh25a@krava> <CAADnVQJ6+N6vQ=ZUgUjoB_M2RoTGGPXpLwz81mNDmLWrGYKetw@mail.gmail.com>
 <CAPhsuW6iuEZCCYJk-cra8DkEWNtdin8GyJDZ6Y8zd4ecfd1gQA@mail.gmail.com>
 <CAADnVQ+SYv5O+UxnGaBAvxptopWyANdbQRg=e2GXiRBPyJMGgA@mail.gmail.com>
 <CAPhsuW55zAYCipf1P4dM8Cu9QFewnyZE+SOquKhSbdqUWG_EKg@mail.gmail.com> <CAM9d7chKunyZX=-9gANZ2BKZTzQXuWYCgPQU46jCHkqsjsoGUg@mail.gmail.com>
In-Reply-To: <CAM9d7chKunyZX=-9gANZ2BKZTzQXuWYCgPQU46jCHkqsjsoGUg@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 1 Nov 2022 17:13:29 -0700
X-Gmail-Original-Message-ID: <CAPhsuW70GMFfzvgp__GOhebPu9bXnG7PzEby6xEExFgg+JmeTQ@mail.gmail.com>
Message-ID: <CAPhsuW70GMFfzvgp__GOhebPu9bXnG7PzEby6xEExFgg+JmeTQ@mail.gmail.com>
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
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 1, 2022 at 3:17 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > >
> > > > > +1
> > > > > Let's avoid new stable helpers for this.
> > > > > Pls use CORE and read perf_sample_data directly.
> > > >
> > > > We have legacy ways to access sample_period and addr with
> > > > struct bpf_perf_event_data and struct bpf_perf_event_data_kern. I
> > > > think mixing that
> > > > with CORE makes it confusing for the user. And a helper or a kfunc would make it
> > > > easier to follow. perf_btf might also be a good approach for this.
> > >
> > > imo that's a counter argument to non-CORE style.
> > > struct bpf_perf_event_data has sample_period and addr,
> > > and as soon as we pushed the boundaries it turned out it's not enough.
> > > Now we're proposing to extend uapi a bit with sample_ip.
> > > That will repeat the same mistake.
> > > Just use CORE and read everything that is there today
> > > and will be there in the future.
> >
> > Another work of this effort is that we need the perf_event to prepare
> > required fields before calling the BPF program. I think we will need
> > some logic in addition to CORE to get that right. How about we add
> > perf_btf where the perf_event prepare all fields before calling the
> > BPF program? perf_btf + CORE will be able to read all fields in the
> > sample.
>
> IIUC we want something like below to access sample data directly,
> right?
>
>   BPF_CORE_READ(ctx, data, ip);
>

I haven't tried this, but I guess we may need something like

data = ctx->data;
BPF_CORE_READ(data, ip);

> Some fields like raw and callchains will have variable length data
> so it'd be hard to check the boundary at load time.

I think we are fine as long as we can check boundaries at run time.

> Also it's possible
> that some fields are not set (according to sample type), and it'd be
> the user's (or programmer's) responsibility to check if the data is
> valid.  If these are not the concerns, I think I'm good.

So we still need 1/3 of the set to make sure the data is valid?

Thanks,
Song
