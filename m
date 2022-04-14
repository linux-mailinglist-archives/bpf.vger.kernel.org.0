Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4289C501D0C
	for <lists+bpf@lfdr.de>; Thu, 14 Apr 2022 23:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240289AbiDNVGB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Apr 2022 17:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346721AbiDNVF7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Apr 2022 17:05:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A4AD8F46;
        Thu, 14 Apr 2022 14:03:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 001FFB82B23;
        Thu, 14 Apr 2022 21:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D90C385AA;
        Thu, 14 Apr 2022 21:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649970211;
        bh=UkMQ4UMV4zIIjkvwR6WA9j7hHfaJIvKpNRMLcx2C8EQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m94A1dx0IP+EPc09O6usSPeuJVq+pXXLjnEfitt2q/KFXYI/hO/8d0eMZ1Lx8FSRK
         bs0YdH+jPjyX+vv5OqVG3IvuJCz7OxnRIQrsW30ZtumUL26J4Ad2E0/eGDxtsPBWvx
         RG78EDk0NOS6W3In0lQW5yE8t3qpz8f9i91VC2zhtKJCGutyshmekmemMg91q5ruyM
         OTwPg7tbB7o6TuLnFNnorq71dtfuvc8i86JpCPveAcNkOb7xuj9SrkZJhXZ3rov6rv
         sgGDYMFacmlsH05qRCeNm7VVArmpfN+FcGx2V72nCTI1uNdJU9l0eihS0tfK7oV3yc
         VweQTvwBhSk9A==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2ebd70a4cf5so68200427b3.3;
        Thu, 14 Apr 2022 14:03:31 -0700 (PDT)
X-Gm-Message-State: AOAM530jevJQYXKMvOOG9MZQfU9K+ybY9w8s4im/xcDcqdC8wIvCTu1c
        NOG2MyEIYTyzraj/FVEbh7o/7MxG6t/kj7qbvvM=
X-Google-Smtp-Source: ABdhPJzWj+86yGa1OXSzZVano7JEjnkCaOvqXeqGXSAQzAwOci0XM45nfY5+5dzQ/w3y1uC8uuJDMNPGXalm5AAcHMg=
X-Received: by 2002:a81:14c8:0:b0:2eb:eb91:d88f with SMTP id
 191-20020a8114c8000000b002ebeb91d88fmr3746888ywu.148.1649970210616; Thu, 14
 Apr 2022 14:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220414195914.1648345-1-song@kernel.org> <20220414195914.1648345-4-song@kernel.org>
 <YliFO2sDv31j5vLb@bombadil.infradead.org>
In-Reply-To: <YliFO2sDv31j5vLb@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 14 Apr 2022 14:03:17 -0700
X-Gmail-Original-Message-ID: <CAPhsuW42Dn2y9skhdJAK1fp9CFA06tpzG=6gMxeTobBj6xifPg@mail.gmail.com>
Message-ID: <CAPhsuW42Dn2y9skhdJAK1fp9CFA06tpzG=6gMxeTobBj6xifPg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf RESEND 3/4] module: introduce module_alloc_huge
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>, imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Luis,

On Thu, Apr 14, 2022 at 1:34 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Apr 14, 2022 at 12:59:13PM -0700, Song Liu wrote:
> > Introduce module_alloc_huge, which allocates huge page backed memory in
> > module memory space. The primary user of this memory is bpf_prog_pack
> > (multiple BPF programs sharing a huge page).
> >
> > Signed-off-by: Song Liu <song@kernel.org>
>
> See modules-next [0], as modules.c has been chopped up as of late.
> So if you want this to go throug modules this will need to rebased
> on that tree. fortunately the amount of code in question does not
> seem like much.
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next

We are hoping to ship this with to 5.18, as the set addresses some issue with
huge page backed vmalloc. I guess we cannot ship it via modules-next branch.

How about we ship module_alloc_huge() to 5.18 in module.c for now, and once
we update modules-next branch, I will send another patch to clean it up?

Thanks,
Song
