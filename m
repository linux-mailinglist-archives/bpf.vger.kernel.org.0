Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E51666847
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 02:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjALBJA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 20:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbjALBIm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 20:08:42 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE1A43E75
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 17:08:25 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 7so11759832pga.1
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 17:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5FR2WY2s+D3KmozmheNpto7Oa+kCLHOpjzqbNKyYPIg=;
        b=G51cDDPoeFnYCZnouEd6tCMilPjO2+MifJTPco9Iw2mKp0cjYgRI23Yu88yzV6EybV
         pLPYAJ2E6WObyscNU3woE6NajtPAkSJVYENz+3zSu1ZDAEtsnt87tMB+vFeTfnjk7V++
         c2CFqC0E6X3rg79ZFVP4EAoIk7RGrXMEOL9lbUEuCOsXcwc5IPEoVHAb/4wvchcPI/t/
         5DBp+SwDXrc3D4YXL8UrZDU26Q8F9nViKcMnmnEth2I23kUsPoktcnERZUgBB0YoO6kW
         ihaapO7b/ILqNbF4GY4Zijpb7PBUt1ZZXeW/5T5Xq0ZQVmt3IXcvVv0kQCYPM5VjIews
         Pzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FR2WY2s+D3KmozmheNpto7Oa+kCLHOpjzqbNKyYPIg=;
        b=rTOr9cVfzcHKNPc/sFBxYKo4bFvgRXgwzAYvIt5R0OZHYDnLpnX1h77LUAm9DpL2Lv
         S4jS3zFozapwf1OZgG3cLJ5tzWd3BJsP2EzMLm5xy7Vhpc4791K9RTOMaRRqcCU9HxCG
         pU7b09meX+JSZ+CgwkhVMDOVxkZuadiJ2LrMI0ABse4Rumon616ItYaYqnJ+6ATTTbwZ
         CHj4D1VSU9S1x0GSXmuAm8T5TXR6ultKg9ub89Dw4Q3njzPe5sVYUaWKM7CKNZXYZ1Zm
         I3n3ZgG/Zx2kF8hqHluzRAMZW+nBGagwKuaoM2WArbuP1vfrgGqIjR8ggFbm9vFsx6Rb
         jETQ==
X-Gm-Message-State: AFqh2kq6VLhVnzIC1awJ8KR3Qgf2qnXE80icqUGYWCY11FF5JC6Lpanb
        XbJe1af/rOuH24B/eRCBK44=
X-Google-Smtp-Source: AMrXdXvCr4tM+PDIG7JaRvEofNwukZb/IxkJYX5MOijqYR8wGnGBwF1QlNcojG2btheRvWHhSYohhQ==
X-Received: by 2002:a05:6a00:722:b0:587:f436:6ea8 with SMTP id 2-20020a056a00072200b00587f4366ea8mr12038600pfm.16.1673485705182;
        Wed, 11 Jan 2023 17:08:25 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:9b3b:bf9a:81d0:48c5])
        by smtp.gmail.com with ESMTPSA id i6-20020aa796e6000000b005884d68d54fsm6947085pfq.1.2023.01.11.17.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 17:08:24 -0800 (PST)
Date:   Thu, 12 Jan 2023 06:38:21 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/8] Dynptr fixes
Message-ID: <20230112010821.bous4eprkyaikkzu@apollo>
References: <20230101083403.332783-1-memxor@gmail.com>
 <CAEf4BzaZuCWq5KrO-NPZjAya1etM4_zCFxWgva4zVDYaWJ89iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaZuCWq5KrO-NPZjAya1etM4_zCFxWgva4zVDYaWJ89iw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 05, 2023 at 04:21:27AM IST, Andrii Nakryiko wrote:
> On Sun, Jan 1, 2023 at 12:34 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Happy New Year!
> >
> > This is part 2 of https://lore.kernel.org/bpf/20221018135920.726360-1-memxor@gmail.com.
> >
> > Changelog:
> > ----------
> > Old v1 -> v1
> > Old v1: https://lore.kernel.org/bpf/20221018135920.726360-1-memxor@gmail.com
> >
> >  * Allow overwriting dynptr stack slots from dynptr init helpers
> >  * Fix a bug in alignment check where reg->var_off.value was still not included
> >  * Address other minor nits
> >
> > Kumar Kartikeya Dwivedi (8):
> >   bpf: Fix state pruning for STACK_DYNPTR stack slots
> >   bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
> >   bpf: Fix partial dynptr stack slot reads/writes
> >   bpf: Allow reinitializing unreferenced dynptr stack slots
> >   selftests/bpf: Add dynptr pruning tests
> >   selftests/bpf: Add dynptr var_off tests
> >   selftests/bpf: Add dynptr partial slot overwrite tests
> >   selftests/bpf: Add dynptr helper tests
> >
>
> Hey Kumar, thanks for fixes! Left few comments, but I was also
> wondering if you thought about current is_spilled_reg() usage in the
> code? It makes an assumption that stack slots can be either a scalar
> (MISC/ZERO/INVALID) or STACK_SPILL. With STACK_DYNPTR it's not the
> case anymore, so it feels like we need to audit all the places where
> we assume stack spill and see if anything should be fixed. Was just
> wondering if you already looked at this?
>

I did look at its usage (once again), here are some comments:

For check_stack_read_fixed_off, the else branch for !is_spilled_reg treats
anything apart from STACK_MISC and STACK_ZERO as an error, so it would include
STACK_INVALID, STACK_DYNPTR, and your upcoming STACK_ITER.
For check_stack_read_var_off and its underlying check_stack_range_initialized,
situation is the same, anything apart from STACK_MISC, STACK_ZERO and
STACK_SPILL becomes an error.

Coming to check_stack_write_fixed_off and check_stack_write_var_off, they will
no longer see STACK_DYNPTR, as we destroy all dynptr for the stack slots being
written to, so it falls back to the handling for the case of STACK_INVALID.
With your upcoming STACK_ITER I assume dynptr/iter/list_head all such objects on
the stack will follow consistent lifetime rules so stray writes should lead to
their destruction in verifier state.

The rest of the cases to me seem to be about checking for spilled reg to be a
SCALAR_VALUE, and one case in stacksafe which looks ok as well.

Are there any particular cases that you are worried about?

> >  kernel/bpf/verifier.c                         | 243 ++++++++++++++++--
> >  .../bpf/prog_tests/kfunc_dynptr_param.c       |   2 +-
> >  .../testing/selftests/bpf/progs/dynptr_fail.c |  68 ++++-
> >  tools/testing/selftests/bpf/verifier/dynptr.c | 182 +++++++++++++
> >  4 files changed, 464 insertions(+), 31 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/verifier/dynptr.c
> >
> >
> > base-commit: bb5747cfbc4b7fe29621ca6cd4a695d2723bf2e8
> > --
> > 2.39.0
> >
