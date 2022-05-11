Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FD1522BF8
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 08:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbiEKGCB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 02:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238865AbiEKGCA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 02:02:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92E136B6B
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 23:01:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so3953599pjb.3
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 23:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZKgMOPl4DNCZDtTlwKH7hDPn7zlx8l1pfe5wXN/VCIE=;
        b=V1UIwqHTuvTLO0TzIXa87BqSO8C46jqwDfCULmROa078Q14H1xJ3ClBAgBJ3f7G35d
         uwPG2JkSGv2oZ70oBHJX1S4dtBMC6/35aqb7h6bKfFDEHg5BmavoArbNE7Cj5V5yDy71
         uUD86xTaw0zm4SAmAOYnQ8vK+buHZ82rFv5yWF56+Nhj3omOMvUPn+ARMT6XA+uhwfSH
         PQt/sobSKzwuPH7huHtvw516yFrhS2LnUB9vF3/EVLf9/mRujDGAC+23VFqZxjdHFNnf
         W2uRmB+PS2h1tjPDPAJy/xDha8MORdzzwwhY04enSojJK8n6wbX/5psktqYV+vEzEi2g
         rzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZKgMOPl4DNCZDtTlwKH7hDPn7zlx8l1pfe5wXN/VCIE=;
        b=grn4sF1pLnNe5k8LIgCxfS2OcH4HxHnqzj31qIMfTh27wPPagjL37d7HdEOHYCkXLh
         pC+5JNfVDw2YMe8eV8X2xTECMYgqNKDK6N/pb6KDGtg//Ewy4/fmsePP0jeNmPiT76AG
         jbXcfrAPuWREongE44Dgl8+hFWSXmz2RBamIFAI/VB/AXn9krQ7OFOLHz3nNAjLrdfX3
         QNh+rEwtQGcFIjHm4ovsnbmRjSuIYdP4UcMf5/ti4/2WjzTKo05+utRPY2IV0rKo0ipE
         EtuvuI/BvMHiPIa7D1A+G4zphaOFX/GymtxxtQ8Nh73yPoR3UF3cZLdaiWLdFcAexpMu
         DEjg==
X-Gm-Message-State: AOAM532rfZjFsBsrg2uXRkCO67joAQUj9b1FhOn3+tlH50qsSOjbXJoi
        xBqvjc3MotLYG9UNxlaroA4=
X-Google-Smtp-Source: ABdhPJy8u5cQ3p0z6i8ToMyNE2N8jKJ6kGSG7z4QjsXLAIaqxD++UI6QGeiQRkWttAMmWKQl88ysPA==
X-Received: by 2002:a17:903:40c2:b0:15c:fd2a:7198 with SMTP id t2-20020a17090340c200b0015cfd2a7198mr23728502pld.0.1652248918178;
        Tue, 10 May 2022 23:01:58 -0700 (PDT)
Received: from localhost ([112.79.142.241])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902934c00b0015e8d4eb2a6sm704249plp.240.2022.05.10.23.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 23:01:57 -0700 (PDT)
Date:   Wed, 11 May 2022 11:32:33 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v1 2/4] bpf: Prepare prog_test_struct kfuncs for
 runtime tests
Message-ID: <20220511060233.x2ew422zqnoj2itc@apollo.legion>
References: <20220510211727.575686-1-memxor@gmail.com>
 <20220510211727.575686-3-memxor@gmail.com>
 <CAADnVQ+WFGc4yEAGVuxzbWkXsj2G+U2nN4YmEzMh7SHbHdknjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+WFGc4yEAGVuxzbWkXsj2G+U2nN4YmEzMh7SHbHdknjA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 11, 2022 at 10:07:35AM IST, Alexei Starovoitov wrote:
> On Tue, May 10, 2022 at 2:17 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > In an effort to actually test the refcounting logic at runtime, add a
> > refcount_t member to prog_test_ref_kfunc and use it in selftests to
> > verify and test the whole logic more exhaustively.
> >
> > To ensure reading the count to verify it remains stable, make
> > prog_test_ref_kfunc a per-CPU variable, so that inside a BPF program the
> > count can be read reliably based on number of acquisitions made. Then,
> > pairing them with releases and reading from the global per-CPU variable
> > will allow verifying whether release operations put the refcount.
>
> The patches look good, but the per-cpu part is a puzzle.
> The test is not parallel. Everything looks sequential
> and there are no races.
> It seems to me if it was
> static struct prog_test_ref_kfunc prog_test_struct = {..};
> and none of [bpf_]this_cpu_ptr()
> the test would work the same way.
> What am I missing?

You are not missing anything. It would work the same. I just made it per-CPU for
the off chance that someone runs ./test_progs -t map_kptr in parallel on the
same machine. Then one or both might fail, since count won't just be inc/dec by
us, and reading it would produce something other than what we expect.

One other benefit is getting non-ref PTR_TO_BTF_ID to prog_test_struct to
inspect cnt after releasing acquired pointer (using bpf_this_cpu_ptr), but that
can also be done by non-ref kfunc returning a pointer to it.

If you feel it's not worth it, I will drop it in the next version.

--
Kartikeya
