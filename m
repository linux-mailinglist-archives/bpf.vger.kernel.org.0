Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB536BA25F
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 23:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjCNWUP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 14 Mar 2023 18:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjCNWTy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 18:19:54 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66655982D;
        Tue, 14 Mar 2023 15:19:02 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id y12so5190611ilq.4;
        Tue, 14 Mar 2023 15:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678832309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPZTCSB32HgHrGjZFH1xoB6eZ90jYrey11CwQEaUEl0=;
        b=5EIYrGmdnEadF88fVXvuFWdKRLbbEWaXLriADNpRdObFJibp2Y+NmbCQjNXVOlvxdG
         rQf/9DK7GXaJ2io/FI50yzknXAcWplwCeQrudzd3EehysxjM5xFa88BN2FZ4sBTm2zq6
         6DpKPloU42UoK507nyOiayg3b1sqy1XtW4bUh+u3D6DqfpI8F+Gk1MlS+5Qc77xFWk7+
         tZj/T6qmGrcuhzhqUa2srJMXCn5XPc8o6+LhM7XdBXoHEa8mz82z//4x9gG/SiYUAGuA
         on8iamXAGKZ9HrN+15kF1GT2U5cz31Mnc61RXN5X3fer/PXfqTLCf6x/IJ0PwEKhR5Fs
         LJwQ==
X-Gm-Message-State: AO0yUKVKryZUkmWPojZoJYaLGPYFj2NdIfeSzbjr8sL7rcuQeV6LF7tm
        Yr6wx5B/lAUD8Tx2oNfdFFbH+iMkZRqui0t8bOY=
X-Google-Smtp-Source: AK7set/JQKxCtANK+YIfmUt9b6P3zJiolpQ3U0xQgrdj9DjQATLIegZgQAdifTUpEaqZKmPJfuKV49knGE4SktWnlMc=
X-Received: by 2002:a92:d346:0:b0:313:fad9:a014 with SMTP id
 a6-20020a92d346000000b00313fad9a014mr2295090ilh.5.1678832308739; Tue, 14 Mar
 2023 15:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230307233309.3546160-1-namhyung@kernel.org> <20230307233309.3546160-5-namhyung@kernel.org>
 <ZBDqOMJexe7Cq3eM@kernel.org>
In-Reply-To: <ZBDqOMJexe7Cq3eM@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 14 Mar 2023 15:18:17 -0700
Message-ID: <CAM9d7citrt7tLF6VkjmBSnM2vCB8vjEqcYcrycZT_R66XNwkyg@mail.gmail.com>
Subject: Re: [PATCH 4/9] perf record: Record dropped sample count
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 14, 2023 at 2:42 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Mar 07, 2023 at 03:33:04PM -0800, Namhyung Kim escreveu:
> > When it uses bpf filters, event might drop some samples.  It'd be nice
> > if it can report how many samples it lost.  As LOST_SAMPLES event can
> > carry the similar information, let's use it for bpf filters.
> >
> > To indicate it's from BPF filters, add a new misc flag for that and
> > do not display cpu load warnings.
>
> This one isn't applying, can you please refresh on top of
> acme/tmp.perf-tools-next ?

Sure, I'll send v5 with documentation update.

Thanks,
Namhyung
