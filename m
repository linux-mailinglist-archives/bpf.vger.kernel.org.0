Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0243662D105
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 03:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiKQCKk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 21:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKQCKi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 21:10:38 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1376B237
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 18:10:37 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i21so536746edj.10
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 18:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lKnBO6So9impXfpSbxyKIhxd4m9bOycIy3EvQ3SnKPk=;
        b=Wrhjlk62iCtO7UsdZi/wo/EV0n8pYX/cPcJFLfzlfINkD6fD+swsB4T1WfKYKKDN7m
         OL0VnOWwnlYkYp6KyySe/4/6RHTq5PhzgDpvaWv8uzN8y0qsK6rStL6w0irYNjPlXS4M
         0JOhQSY9yDHZuwveSC5fu4RRPmXMXOpF6KQCsYOS1Sqj8P6tfNUUc+UxMl9BiC3Wxg1g
         s0zNtZhP8Lns9PgnHWKRIC0iu9UADTFi/zerm/fFu8q7LSTcTmeqw7Z5T6eehScDygXF
         1dCF7aPCmctU4aTsx922TLvLsUvHA8E7wHCYH8bXLd6GwPO9FoNFTcXZw8zLVdi5YzMC
         sh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKnBO6So9impXfpSbxyKIhxd4m9bOycIy3EvQ3SnKPk=;
        b=A3rHru3am4zNE6yLPaoLqPIgTSefLH7+3YZLAjljVu7nmLEADuGyA63g6YL8U3tRq3
         cHYp99M5dd1Gw1oxUkI5Wvcdf0J3XRrQ4wL62faLKnjK8PU9Xy4+tkmxXxw4nsEZFudU
         6/L6pDsp4r5NK146coBm6inOdULdn2REYzDH6usCa3esKQpg+spzkH03dMYpAAaAsL1h
         QEMjR1KiBXFGn+CJ/irhyETSqaTz1bu6n4DdpCYi2eKj7U/Vbg2AMFPIDh0dILTBuZI5
         lbCi8JbPBUWUzF6pHTu0p7SM9JmA3bhlvDcIpaTzPQoqWU6H1pO7FnvWwMrv8N9zY3VG
         xZsA==
X-Gm-Message-State: ANoB5pmaA9fSBwXN5PQuB7hPpBCHq5vE8MC0rgBdQb6xjNxMPLCIs/wc
        MeUZSVGqQ4EymdOzKVwx+vnx00ObLVAnLImRivo=
X-Google-Smtp-Source: AA0mqf5UeAy87zYM3LMDJcOjB6wfm+vldAPFIXzpcL3/Qtvt/0u+Vu/rUCQ4Wc4PqsQAoNMdPW+N7bg06h+wlRh0jmY=
X-Received: by 2002:aa7:c2d5:0:b0:467:8fb6:d11 with SMTP id
 m21-20020aa7c2d5000000b004678fb60d11mr352590edp.421.1668651035314; Wed, 16
 Nov 2022 18:10:35 -0800 (PST)
MIME-Version: 1.0
References: <20221117010621.1891711-1-song@kernel.org> <20221117010621.1891711-5-song@kernel.org>
 <Y3WT6rwrM78sqkR5@bombadil.infradead.org>
In-Reply-To: <Y3WT6rwrM78sqkR5@bombadil.infradead.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 16 Nov 2022 18:10:23 -0800
Message-ID: <CAADnVQL6AiQLaURNbchVtUNK2nGFUYCSPZk5dZbScW=iKp1bYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] bpf: use execmem_alloc for bpf program
 and bpf dispatcher
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        aaron.lu@intel.com, Mike Rapoport <rppt@kernel.org>
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

On Wed, Nov 16, 2022 at 6:04 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 16, 2022 at 05:06:19PM -0800, Song Liu wrote:
> > Use execmem_alloc, execmem_free, and execmem_fill instead of
> > bpf_prog_pack_alloc, bpf_prog_pack_free, and bpf_arch_text_copy.
> >
> > execmem_free doesn't require extra size information. Therefore, the free
> > and error handling path can be simplified.
> >
> > There are some tests that show the benefit of execmem_alloc.
> >
> > Run 100 instances of the following benchmark from bpf selftests:
> >   tools/testing/selftests/bpf/bench -w2 -d100 -a trig-kprobe
> > which loads 7 BPF programs, and triggers one of them.
> >
> > Then use perf to monitor TLB related counters:
> >    perf stat -e iTLB-load-misses,itlb_misses.walk_completed_4k, \
> >            itlb_misses.walk_completed_2m_4m -a
> >
> > The following results are from a qemu VM with 32 cores.
> >
> > Before bpf_prog_pack:
> >   iTLB-load-misses: 350k/s
> >   itlb_misses.walk_completed_4k: 90k/s
> >   itlb_misses.walk_completed_2m_4m: 0.1/s
> >
> > With bpf_prog_pack (current upstream):
> >   iTLB-load-misses: 220k/s
> >   itlb_misses.walk_completed_4k: 68k/s
> >   itlb_misses.walk_completed_2m_4m: 0.2/s
> >
> > With execmem_alloc (with this set):
> >   iTLB-load-misses: 185k/s
> >   itlb_misses.walk_completed_4k: 58k/s
> >   itlb_misses.walk_completed_2m_4m: 1/s
>
> Wonderful.
>
> It would be nice to have this integrated into the bpf selftest,


No. Luis please stop suggesting things that don't make sense.
selftest/bpf are not doing performance benchmarking.
We have the 'bench' tool for that.
That's what Song used and it's only running standalone
and not part of any CI.
