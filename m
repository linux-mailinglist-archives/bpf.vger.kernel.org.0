Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6500D5964CB
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 23:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbiHPVka (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 17:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbiHPVk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 17:40:26 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5950674E19;
        Tue, 16 Aug 2022 14:40:24 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id n21so9162981qkk.3;
        Tue, 16 Aug 2022 14:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=OFB+vwmFlMkdVZ/s3bOlcrdQ4LPF6bvFIAzYn5YHwNY=;
        b=EnDfbsKJaP+d1KRnlYL77BU3Zy5ZiFNGu+gvx3abe9Jrh9lJP4Rxztj32WzA/YFbsa
         ScrGh++vYTDlsti6GcT1zFf7k5YEglO2Hc8EZ0kjBTJ9Ulp1oJGnz4MoSE3oWu7e+qmX
         7viTkp4izlmp2pxyYcbdX0v3c5k40O5kG4eHCyB+rqvggLgMt8ta3XdnfWaZDb94fefU
         RE1Cxa5T+7gM69JrXsD9g6QPcVnTGjjkmHxd/Jo6/mLAHcpt9qLVnIw5D2pPmX6fE5kA
         NKryUQwdotsQOF/lpGbgz8X9AtDVkNQ64i4d2tIIwv3eYhR1+ItSOX0eifLwBG45R6Z9
         jGSg==
X-Gm-Message-State: ACgBeo0xjt5E2pa1VjzArhtnh8tFDttttRb8uMsJttuB6J11CuKMV6yW
        2jwocqanCQBRRAxpwP3C5eQq4dAFKEIFGcOr
X-Google-Smtp-Source: AA6agR4vvHHI+nXguuQhR5xp//MAHKz9RZ36QS2CX4onFjNpwreJWXlVrI2q6gClSAmuKS+SWLiHNg==
X-Received: by 2002:a05:620a:4441:b0:6bb:6034:f1d4 with SMTP id w1-20020a05620a444100b006bb6034f1d4mr3791255qkp.451.1660686023322;
        Tue, 16 Aug 2022 14:40:23 -0700 (PDT)
Received: from maniforge.DHCP.thefacebook.com ([2620:10d:c091:480::a5ed])
        by smtp.gmail.com with ESMTPSA id br20-20020a05620a461400b006b8619a67f4sm2454118qkb.34.2022.08.16.14.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:40:23 -0700 (PDT)
Date:   Tue, 16 Aug 2022 16:39:59 -0500
From:   David Vernet <void@manifault.com>
To:     Hao Luo <haoluo@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, tj@kernel.org, joannelkoong@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] bpf: Add user-space-publisher ringbuffer map type
Message-ID: <YvwOr11K4VjNsNzJ@maniforge.DHCP.thefacebook.com>
References: <20220808155248.2475981-1-void@manifault.com>
 <CA+khW7iuENZHvbyWUkq1T1ieV9Yz+MJyRs=7Kd6N59kPTjz7Rg@mail.gmail.com>
 <20220810011510.c3chrli27e6ebftt@maniforge>
 <CA+khW7iBeAW9tzuZqVaafcAFQZhNwjdEBwE8C-zAaq8gkyujFQ@mail.gmail.com>
 <YvuzNaam90n4AJcm@maniforge.dhcp.thefacebook.com>
 <CA+khW7gXXEtRg-m5NY16PG1hCMJb2-Bnfrp7rkedAz8JHC5HWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7gXXEtRg-m5NY16PG1hCMJb2-Bnfrp7rkedAz8JHC5HWA@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 16, 2022 at 10:01:38AM -0700, Hao Luo wrote:
> On Tue, Aug 16, 2022 at 8:10 AM David Vernet <void@manifault.com> wrote:
> >
> > On Mon, Aug 15, 2022 at 02:13:13PM -0700, Hao Luo wrote:
> > > >
> > > > Iters allow userspace to kick the kernel, but IMO they're meant to enable
> > > > data extraction from the kernel, and dumping kernel data into user-space.
> > >
> > > Not necessarily extracting data and dumping data. It could be used to
> > > do operations on a set of objects, the operation could be
> > > notification. Iterating and notifying are orthogonal IMHO.
> > >
> > > > What I'm proposing is a more generalizable way of driving logic in the
> > > > kernel from user-space.
> > > > Does that make sense? Looking forward to hearing your thoughts.
> > >
> > > Yes, sort of. I see the difference between iter and the proposed
> > > interface. But I am not clear about the motivation of a new APis for
> > > kicking callbacks from userspace. I guess maybe it will become clear,
> > > when you publish a concerte RFC of that interface and integrates with
> > > your userspace publisher.
> >
> > Fair enough -- let me remove this from the cover letter in future
> > versions of the patch-set. To your point, there's probably little to be
> > gained in debating the merits of adding such APIs until there's a
> > concrete use-case.
> >
> 
> Yep, sounds good. I don't mean to debate :) I would like to help. If
> we could build on top of existing infra and make improvements, IMHO it
> would be easier to maintain. Anyway, I'm looking forward to your
> proposed APIs.

Don't worry, I did not take it that you were debating. I very much
appreciate your thoughts and help. If and when I send out that RFC
patchset, I'll be sure to cc you (if not reach out beforehand as well to
discuss).
