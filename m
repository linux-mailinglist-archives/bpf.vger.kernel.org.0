Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9133051E357
	for <lists+bpf@lfdr.de>; Sat,  7 May 2022 03:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348216AbiEGBwC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 21:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243749AbiEGBv7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 21:51:59 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718DF703FB
        for <bpf@vger.kernel.org>; Fri,  6 May 2022 18:48:14 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id o18so7269584qtk.7
        for <bpf@vger.kernel.org>; Fri, 06 May 2022 18:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ogBFsD7up1GIjgEfK8y7bcN1Ut8kh3dUHAoi/AvVnJA=;
        b=EPqEZGL1q7Yndlw5Co88v35DaMW5BV2XQ/3IPdoMugcsn8rYKccs4SbyseqjgvtN+K
         Tjf+4JsBqf4bUavrYCa8rjDLhzakAZ7kxDzo6wHSWY/N8VnVzq4GlkOFKzzzyecyNp0B
         i42jeEagQK8SMTpicOysTlnKYlY0oMZDaBY16AiBKK23QWYMKves2dbjeGhrCGvMhDvG
         S5TfOvlrL1w+hsPhi0tPOsW/AqUVn2H5t21jd0D+Od2nW3Wjj69ZWAME6oj9SOWufEoH
         MK2HSJPwGvy9WatwFikvZtrVTm5qf+dDxwjIrGAYFZfp3oNHrxVJ1JqxYehpjKZo09v8
         +1fw==
X-Gm-Message-State: AOAM531rlKzWdxZY91nhDshHJiOTelnWsmzLFG/LmyJOLv2G12HQh53n
        RXW+Uy6YsjTFvFbu4f0UcmY=
X-Google-Smtp-Source: ABdhPJxaM0kJI6pnLB2SGvUppMXP9fWNX8RmIPMkBP9heqKE94sSSmsKZF8giOntp0aOg5u7BKjDYw==
X-Received: by 2002:a05:622a:606:b0:2f3:9740:d80b with SMTP id z6-20020a05622a060600b002f39740d80bmr5434223qta.166.1651888093460;
        Fri, 06 May 2022 18:48:13 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-010.fbsv.net. [2a03:2880:20ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id z6-20020ac84546000000b002f39b99f6b4sm3439251qtn.78.2022.05.06.18.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 18:48:13 -0700 (PDT)
Date:   Fri, 6 May 2022 18:48:10 -0700
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Add MEM_UNINIT as a bpf_type_flag
Message-ID: <20220507014810.j2fckhhumdjn5b3x@dev0025.ash9.facebook.com>
References: <20220428211059.4065379-1-joannelkoong@gmail.com>
 <20220428211059.4065379-2-joannelkoong@gmail.com>
 <20220506150727.73dvaiyf5rerggj3@dev0025.ash9.facebook.com>
 <CAJnrk1Yc7G9BamfcNDGXvhMbHcrebROxN97GPPNENJ9_vGF5XA@mail.gmail.com>
 <20220506203224.e7pdw3jk6kqpe7dh@dev0025.ash9.facebook.com>
 <CAEf4BzavPM8o2OnYB3zSj_wfQp5us4rBjjKXzW4q-m-HARSZ1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzavPM8o2OnYB3zSj_wfQp5us4rBjjKXzW4q-m-HARSZ1Q@mail.gmail.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 06, 2022 at 03:46:19PM -0700, Andrii Nakryiko wrote:
> You meant
> 
> - [ARG_PTR_TO_UNINIT_MEM]         = &mem_types,
> 
> parts as stand-alone patch? That would be invalid on its own without
> adding MEM_UNINT, so would potentially break bisection. So no, it
> shouldn't be a stand-alone patch. Each patch has to be logically
> separate but not causing any regressions in behavior, compilation,
> selftest, etc. So, for example, while we normally put selftests into
> separate tests, if kernel change breaks selftests, selftests have to
> be fixed in the same patch to avoid having any point where bisection
> can detect the breakage.

Thanks for clarifying, Andrii. I misunderstood the existing verifier code
while I was reviewing the diff and mistakenly thought it was safe to remove
these lines without MEM_UNINIT.  Apologies for the noise / confusion.
