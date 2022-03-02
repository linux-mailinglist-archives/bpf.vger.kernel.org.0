Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6464CB36F
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 01:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiCCAPa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 19:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiCCAPa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 19:15:30 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80714123BD4
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 16:14:42 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id b8so3234755pjb.4
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 16:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u+hSFdPquIDh1hAr5cadhAVy5fk3tVc/MLPiS0CMTZk=;
        b=VA+W3mY1Ev9tU2QoRwL87D/+v4g4bliaCN3CjkUMYvFW2b5AD/iKV2WU2fP4oQ51wS
         cbs8uVNylhiPvCbeFQ4DpXnG+LG53QbrE+WBNChmpePjfGPtXC0mAXa8APgh8rtDQ3yi
         7fWyOgBlDri402SAGs7VQ80iCAtqC9zrrm2KmfSzOgnCVAJx8TmPmpf0Z+Mt23uTRgC6
         8BK80sUb86ViJsu/AGOJV2/W49LQgb1hmf7/mtU4nPcipUkDQhcaDrX6QKigd0g9FPAi
         /iGAHdPV5B/uoKKpPhrc+Cnf+QY7UGHJMGeQKplCCd/5V6FIxsOTI/f5+l80HuJv1ATy
         gVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u+hSFdPquIDh1hAr5cadhAVy5fk3tVc/MLPiS0CMTZk=;
        b=GxIGvDWVyGL+nF+jhNVrQoBmfyMnFLu3BGxUKRhR9iQp0T3ZY7+ZsUywOz6Xr1JH+H
         doUBPVfTPEO2a6uS7aQey+x+Zs+pfxEXW6kOvdA+zleNyRWLgTkEX2NdBvkDMn1P+oHz
         IvdK7EGhxQtyhWtSdz/5mAQHxC3qOeIOV05nU2hyxTOXANz4Y5QglZINpC0m+XVojENl
         cNgAesouy4+JB5Oa/UrRPI/HQggW/99R3ISaQTW/SFKg5v5d4fgwZ/ZeANQJ0e0CcvfO
         MvY7Gdty3Pa/HLaFsymU0klNc1xAG7rDqUm2CojUhrsjpRWOlRjWIO7A67AbxrB7/EL5
         S2Ow==
X-Gm-Message-State: AOAM530DuHwYfckR6LmUFDJr45YCHt5NMfqF3vMwhhDwOP1FjNO7lR5D
        /dVZQSJ7qGO9q7AlP0Nr2G9606bFP5g=
X-Google-Smtp-Source: ABdhPJxyHioizbgH7bOpBUIdc7vYbFzkI2//a5pScJbe8il0nN7SORl6sroUXp7xzwmndCpcy9y2mw==
X-Received: by 2002:a17:903:2346:b0:151:60f4:84ee with SMTP id c6-20020a170903234600b0015160f484eemr19591188plh.27.1646262128504;
        Wed, 02 Mar 2022 15:02:08 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id a15-20020a637f0f000000b00372e075b2efsm190620pgd.30.2022.03.02.15.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 15:02:08 -0800 (PST)
Date:   Thu, 3 Mar 2022 04:32:05 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v1 5/6] selftests/bpf: Update tests for new
 errstr
Message-ID: <20220302230205.k6nlssi4ulfqpnr4@apollo.legion>
References: <20220301065745.1634848-1-memxor@gmail.com>
 <20220301065745.1634848-6-memxor@gmail.com>
 <CAADnVQKXrPu4DB_5MnzC+E2aiebex9CqLD=rOUdGd0mKo_szBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKXrPu4DB_5MnzC+E2aiebex9CqLD=rOUdGd0mKo_szBA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 03, 2022 at 04:15:06AM IST, Alexei Starovoitov wrote:
> On Mon, Feb 28, 2022 at 10:58 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Verifier for negative offset case returns a different, more clear error
> > message. Update existing verifier selftests to work with that.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/verifier/bounds_deduction.c | 2 +-
> >  tools/testing/selftests/bpf/verifier/ctx.c              | 8 ++++----
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/verifier/bounds_deduction.c b/tools/testing/selftests/bpf/verifier/bounds_deduction.c
> > index 91869aea6d64..3931c481e30c 100644
> > --- a/tools/testing/selftests/bpf/verifier/bounds_deduction.c
> > +++ b/tools/testing/selftests/bpf/verifier/bounds_deduction.c
> > @@ -105,7 +105,7 @@
> >                 BPF_EXIT_INSN(),
> >         },
> >         .errstr_unpriv = "R1 has pointer with unsupported alu operation",
> > -       .errstr = "dereference of modified ctx ptr",
> > +       .errstr = "negative offset ctx ptr R1 off=-1 disallowed",
>
> Should this be a part of patch 3 to avoid breaking bisect?

Right, will squash into patch 3 in v2.

--
Kartikeya
