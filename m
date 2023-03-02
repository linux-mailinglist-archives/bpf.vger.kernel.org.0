Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADAC6A8D50
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCBXu7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 18:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCBXu4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:50:56 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6082732524
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:50:55 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id l13so1194656qtv.3
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677801054;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSH140VYPg5AWwEfY6V4NkekDNmzVNCaiBxSFsMhKb0=;
        b=dQ1bcAPqvqwStNcVljUahQCnJVi5bCDz8kFjvb86NH54ktMwK5RlgwfrlLMcs86TVv
         u0hozga3fN2XADiBhmyjG+qTGBbnZ+JN1DrmCke/XUKjFy/Ah5iW3m5bNIEg460L79Ln
         UVy9IBmmjepGPmLJ5lK5n1kgBDzAQPu4P7iujEkZ5kGpyb1YQTT8vU3bJfk4t/eyK/hN
         ckXgMO7Ii2Z4n5TvxRmEG4qmDVcDPBSVN3SKB0Q5oP8YLrCutUxgDlNZNW+vBzJBUV8d
         Q6qbi8qmaBPgGuPb++26jTaudp+roRerjfEGcIOh/WseLv/ZNKO+cVxpQLXCtOSst3w3
         cV9g==
X-Gm-Message-State: AO0yUKUn9FyvNpEI4Q5l8+L+4s7PkHJ+GyIqbZcAOYq/LqbqRWMhw2hC
        ayzqykgPp3L4Ia8CiRDUsCg=
X-Google-Smtp-Source: AK7set9HgnCGDjUtQI+U5N0bh9BiS5GAE42kSHG/vU/jKqQzaPyU5BaxJmiPjqGDE++GlDdvTYJD+w==
X-Received: by 2002:ac8:5cc6:0:b0:3b8:5f26:e81f with SMTP id s6-20020ac85cc6000000b003b85f26e81fmr6975455qta.26.1677801054364;
        Thu, 02 Mar 2023 15:50:54 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:5ba])
        by smtp.gmail.com with ESMTPSA id k7-20020ac80207000000b003bf9f9f1844sm613923qtg.71.2023.03.02.15.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 15:50:53 -0800 (PST)
Date:   Thu, 2 Mar 2023 17:50:51 -0600
From:   David Vernet <void@manifault.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add -Wuninitialized flag to bpf
 prog flags
Message-ID: <ZAE2W68Iw74A0xpK@maniforge>
References: <20230302231924.344383-1-davemarchevsky@fb.com>
 <CAADnVQJV_yQ23EeFuuHC+AvoxgVLVKZvaYkWfzhk=z3kxWHmHA@mail.gmail.com>
 <ZAExU+aiCmOt2Flp@maniforge>
 <1e35323c-0383-4d5a-0027-83b9e7d1e57b@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e35323c-0383-4d5a-0027-83b9e7d1e57b@meta.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 02, 2023 at 06:41:55PM -0500, Dave Marchevsky wrote:
> On 3/2/23 6:29 PM, David Vernet wrote:
> > On Thu, Mar 02, 2023 at 03:23:22PM -0800, Alexei Starovoitov wrote:
> >> On Thu, Mar 2, 2023 at 3:19 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >>>
> >>> --- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
> >>> +++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
> >>> @@ -232,8 +232,9 @@ long rbtree_api_first_release_unlock_escape(void *ctx)
> >>>
> >>>         bpf_spin_lock(&glock);
> >>>         res = bpf_rbtree_first(&groot);
> >>> -       if (res)
> >>> -               n = container_of(res, struct node_data, node);
> >>> +       if (!res)
> >>> +               return -1;
> >>
> >> The verifier cannot be ok with this return... I hope...
> > 
> > This is a negative testcase which correctly fails, though the error
> > message wasn't what I was expecting to see:
> > 
> > __failure __msg("rbtree_remove node input must be non-owning ref")
> > 
> > Something about the lock still being held seems much more intuitive.
> > 
> 
> It's necessary to call bpf_rbtree_remove w/ lock held. This test expects
> to fail because non-owning ref "n" is clobbered after the critical
> section where it's returned by bpf_rbtree_first ends.

Oh, I see. I think that would arguably be a bit more clear if we added a
bpf_spin_unlock() to that return case then. Ideally for a negative test
we can keep the number of bugs being tested to 1. I assume that was
Alexei's point, which clearly went over my head.

> 
> >>
> >>> +       n = container_of(res, struct node_data, node);
> >>>         bpf_spin_unlock(&glock);
