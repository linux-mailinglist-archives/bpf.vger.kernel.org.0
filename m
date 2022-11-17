Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CB762E461
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 19:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiKQShK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 13:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240517AbiKQShC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 13:37:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB9F58
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 10:37:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDE86B82179
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 18:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1A4C43145
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 18:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668710218;
        bh=y0a1kN4E5U0xytB8/wQI0e7kakRSff/1znGiKB5P4Wg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YJxUT7Vp3UpMOzZPJu18YZ95Hr7LIR5Kqoz34Peav3wlBXYgz9HIGFg4dkiV43NXl
         bl9cocWQ3rcxYBjP59q9vDjJLFiAIRXPqgH0RZeaOKme9S7i2LuUcSWst+abDx6p4g
         sYAB/n9wUuMabvNRwt+UkcSYsRt957zan381tn+81yuD8ekgLYqLgHccEdwyKbYlsR
         bd5eZnrrDmm3/6AdlQ2OlEjxHtk9rN/nQhes5pbuApWNOCCkx3HzDJxoK6O6Nr4Iwy
         9JQOsTjad+aYdgbQyJ2NCFYsjo8a3fJjr3NJCdTvev/dYQjTuDX1V1GJkYx27d1tsD
         3T3Ep0IiasY5A==
Received: by mail-ej1-f53.google.com with SMTP id gv23so7322527ejb.3
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 10:36:58 -0800 (PST)
X-Gm-Message-State: ANoB5pmWnfmnBSE5PqG54yoBAPTv9yZlvJ3coS/Y7lhjTlCgdKz6A1s9
        NzmvGZOa0+OmCROcC2g0safoVmTFYm0OeUcqKSY=
X-Google-Smtp-Source: AA0mqf63XWB6A2beNTXDEGscspG5MQwfkBCrXrsXgU82FReayLSaj84K1iKmzbMRIoVtueFgTBl2PEVd7cYhql9qtEw=
X-Received: by 2002:a17:906:c34f:b0:78e:17ad:ba62 with SMTP id
 ci15-20020a170906c34f00b0078e17adba62mr3175838ejb.719.1668710216515; Thu, 17
 Nov 2022 10:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <Y2o9Iz30A3Nruqs4@kernel.org>
 <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
 <Y2uMWvmiPlaNXlZz@kernel.org> <bcdc5a31570f87267183496f06963ac58b41bfe1.camel@intel.com>
 <Y3DITs3J8koEw3Hz@kernel.org> <CAPhsuW4zKABHC_Stwnkac05Lvww4C_tz-T4JfALDcQusRmsCEw@mail.gmail.com>
 <Y3X1uHNTLQJxmJnm@kernel.org>
In-Reply-To: <Y3X1uHNTLQJxmJnm@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 17 Nov 2022 10:36:43 -0800
X-Gmail-Original-Message-ID: <CAPhsuW51j8P+DNXvFh4uf5Mem7=egHyYMVK7-Zq2qeFoArYREQ@mail.gmail.com>
Message-ID: <CAPhsuW51j8P+DNXvFh4uf5Mem7=egHyYMVK7-Zq2qeFoArYREQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 17, 2022 at 12:50 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Nov 14, 2022 at 12:30:49PM -0800, Song Liu wrote:
> > On Sun, Nov 13, 2022 at 2:35 AM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > My concern is that the proposed execmem_alloc() cannot be used for
> > > centralized handling of loading text. I'm not familiar enough with
> > > modules/ftrace/kprobes/BPF to clearly identify the potential caveats, but
> > > my gut feeling is that the proposed execmem_alloc() won't be an improvement
> > > but rather a hindrance for moving to centralized handling of loading text.
> >
> > I don't follow why this could ever be a hindrance. Luis is very excited about
> > this, and I am very sure it works for ftrace, kprobe, and BPF.
>
> Again, it's a gut feeling. But for execmem_alloc() to be a unified place of
> code allocation, it has to work for all architectures. If architectures
> have to override it, then where is the unification?
>
> The implementation you propose if great for x86, but to see it as unified
> solution it should be good at least for the major architectures.

As I mentioned earlier, folks are working on using bpf_prog_pack for BPF
JIT on powerpc. We will also work on something similar for ARM. I guess
these are good enough for major architectures?

>
> > > It feels to me that a lot of ground work is needed to get to the point
> > > where we can use centralized handling of loading text.
> >
> > Could you please be more specific on what is needed?
>
> The most obvious one to implement Peter's suggestion with VM_TOPDOWN_VMAP
> so that execmem_alloc() can be actually used by modules.

Current implementation is an alternative to VM_TOPDOWN_VMAP. I am
very sure it works for modules just like VM_TOPDOWN_VMAP solution.

Thanks,
Song
