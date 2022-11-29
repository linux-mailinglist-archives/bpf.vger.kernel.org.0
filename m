Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B8363C673
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 18:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiK2Rbq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 12:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbiK2Rbo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 12:31:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE39697CC
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 09:31:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC5FFB817B0
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 17:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE2BC433C1
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 17:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669743098;
        bh=Yno0ZxK35GmnvzREU6S3ysILrgeflHC9VnPjoSzS2DU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Awiz+hSZURBI5omZVEKnoxLLR9UVJbDwX3biufxrp9qkyRK2SWhNnw2G/44dJ1Kid
         lhZ3HZzKdmlBW4CfpPDTdboB0oj61HLAaP8eHW1nwno8giiOqmyOX1exVYzQkyVR7I
         vsmKwpz01TVmRJwqggNLaPVi9DM4biy1zIVAGNLdOIIECBX+SSbzKn1SBFGnvrIgwi
         Co3TsX0tgbupPhG1pPMlq++9Niikdn4IxIn2lp7aVTOUg85nbrlojJKy1v0qW7du9G
         VTzrnjuIA19eOpm+BEcOCzzn8nxHwO3DqIAg17/MDGSF0grO0G2ON6btYC8LjAiJWD
         RIiECzbDfGPMQ==
Received: by mail-ej1-f53.google.com with SMTP id n20so35626666ejh.0
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 09:31:38 -0800 (PST)
X-Gm-Message-State: ANoB5pkRBIkMYy50jovxy+xrBvTmDo+wZFiSiwGoAf7SRXoECAIf6vS4
        nBEnlkC4ueuH2mZsMcsxEcedwFZUbYAAaB9jjeU=
X-Google-Smtp-Source: AA0mqf6RHc1/36W/jxdBSx0RZAihVEbLrSdyD8D/ebu3l7C/w8q/wyMkS3Y4sDv3+KvliSjU+6T8HSI302tlJhjQURw=
X-Received: by 2002:a17:906:9f09:b0:7bc:db1b:206f with SMTP id
 fy9-20020a1709069f0900b007bcdb1b206fmr18827668ejc.719.1669743096731; Tue, 29
 Nov 2022 09:31:36 -0800 (PST)
MIME-Version: 1.0
References: <20221128190245.2337461-1-song@kernel.org> <20221128190245.2337461-4-song@kernel.org>
 <20221129083518.GA25167@lst.de>
In-Reply-To: <20221129083518.GA25167@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Tue, 29 Nov 2022 09:31:24 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6zOVjK5bvS_A=RNUAExeepSPrpE7xWOOAq6W5qJ3m=vA@mail.gmail.com>
Message-ID: <CAPhsuW6zOVjK5bvS_A=RNUAExeepSPrpE7xWOOAq6W5qJ3m=vA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/6] selftests/vm: extend test_vmalloc to test
 execmem_* APIs
To:     Christoph Hellwig <hch@lst.de>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, rick.p.edgecombe@intel.com,
        rppt@kernel.org, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 12:35 AM Christoph Hellwig <hch@lst.de> wrote:
>
> > +#if DEBUG_TEST_VMALLOC_EXEMEM_ALLOC
> > +EXPORT_SYMBOL_GPL(execmem_alloc);
> > +#endif
>
> > +#if DEBUG_TEST_VMALLOC_EXEMEM_ALLOC
> > +EXPORT_SYMBOL_GPL(execmem_fill);
> > +#endif
>
> > +#if DEBUG_TEST_VMALLOC_EXEMEM_ALLOC
> > +EXPORT_SYMBOL_GPL(execmem_free);
> > +#endif
>
> Still NAK.  These symbols never have any business being exported
> ever.  Just force the test to be built-in if you want to test this
> functionality.

OK. I knew this was really ugly. I just want to know your thoughts on it.

I guess we can just drop 3/6 of the set, and everything else would just work.

Thanks,
Song
