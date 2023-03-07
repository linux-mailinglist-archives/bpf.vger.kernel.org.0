Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F66C6AFA0E
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 00:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCGXG7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 18:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjCGXG6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 18:06:58 -0500
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A417D8F72D;
        Tue,  7 Mar 2023 15:06:57 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id i6so13020133ybu.8;
        Tue, 07 Mar 2023 15:06:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678230417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yfbgy4/53TVUheE3EKP7pKuvoMRFVrai8Lon5jzydys=;
        b=Eta0EtyF4eLVdLYsQxi7EBrC8gUdjrUAi3l6gHl3GgEsXS1sf1CCojuy3J1xPoXkNO
         iYYvLbbw4/su+2Vcg39RveNpkyN5evgT2wR3bieG3MpnMmQpt9EEIYFCr6tgGPrssXrl
         /lPRZaCGA/vYalTDKMS8AAD9q5E8Nz+cwXFbjUZ/3QwhXywKDukiaPbCLv3pdqMuUOoz
         UVPkZe7itm/aggrxxdn8BdgpXjbx+WvQM2Tf54AXzJeEpXPagCHq0AiNeEfIoYhMHV6c
         O580yNB4FYd4kIuyNyDlbG3NkBzPLkdubnB3fHSrHcELddwCMb4PXr+5a8WLjCu1I4tD
         mjXQ==
X-Gm-Message-State: AO0yUKWaLuq9RSjHkaLB1+5OYBCApiB93dqaC2E2hnHkArgEQR9rCNqu
        rgHDIu2kzbZZcgaLy0sW96x/0AEPBSnnugXhTY4=
X-Google-Smtp-Source: AK7set/y7HOGFf/imfe+d3JadToLv4g54mK9yDdHOSmuyKTaoW74P82ryDmTF9K3ZaAooAg406WVX0dFlpb32HDUcXI=
X-Received: by 2002:a5b:647:0:b0:932:8dcd:3a13 with SMTP id
 o7-20020a5b0647000000b009328dcd3a13mr9729297ybq.5.1678230416706; Tue, 07 Mar
 2023 15:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20230222230141.1729048-1-namhyung@kernel.org> <ZAe71eOx6GpzTBUB@krava>
In-Reply-To: <ZAe71eOx6GpzTBUB@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 7 Mar 2023 15:06:45 -0800
Message-ID: <CAM9d7cgNuhHJn8LZFk8WMSXaxstucz3gX_e9HYxP_P2N_VLnBA@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 0/8] perf record: Implement BPF sample filter (v3)
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jiri,

On Tue, Mar 7, 2023 at 2:34 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Wed, Feb 22, 2023 at 03:01:33PM -0800, Namhyung Kim wrote:
> > Hello,
> >
> > There have been requests for more sophisticated perf event sample
> > filtering based on the sample data.  Recently the kernel added BPF
> > programs can access perf sample data and this is the userspace part
> > to enable such a filtering.
> >
> > This still has some rough edges and needs more improvements.  But
> > I'd like to share the current work and get some feedback for the
> > directions and idea for further improvements.
> >
> > v3 changes)
> >  * fix build error on old kernels/vmlinux  (Arnaldo)
> >  * move the logic to evlist__apply_filters  (Jiri)
> >  * improve error message for bad input
>
> had same issue to compile it without BUILD_BPF_SKEL=1 as Adrian
> reported, but with that fixed it looks good
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Great!  Thanks for your review!

Namhyung
