Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D288F67491A
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 03:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjATCAB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 21:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjATCAA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 21:00:00 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABCDA501D
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 17:59:59 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id lp10so835360pjb.4
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 17:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BGZwMeQbpKBq5CxV5IZkAj/iVbrKeiySBGRtOC3xzyA=;
        b=YdWGADE6EZD3Z8O5UAKqJri1QTnnM1sOtIceyBlxrmmf23bXDk1pBYJcSSPvSi3hyR
         C8zC3dZC5HjGQ5mhaDGtQC4zkv4P1sa6EQzO4ZojXnEdHCBaS7ORYZUEtEUovtztwh8j
         QaXfC3c0aHQF2mfszrjL0WnaaqKK3CBcsElg5Rr+pF51Gw5tEiBIUcSHYFejxI9mZBV3
         vxwfA0uW9BxygsnTlc3VwBMDzTC2WZOF6klff5Li7qkQOQt40/KEtAokiRIGC33Qcj+Q
         /XOw9n23q6tibQuhmlqgBcOapgalTy8uY7uMNqTwE7RNr84EQ9PpUakX8AlqwIy/ov+I
         ZGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGZwMeQbpKBq5CxV5IZkAj/iVbrKeiySBGRtOC3xzyA=;
        b=rRws7dzcGISmMjTUR50GSGKJinDXWx+OlpdVWBUnC85QuOlT+CIiSdyWTralxQtl/S
         UH/KZlVemcqHSnDT/BgEOpq/ke5shq5VmoIIBABShb+b+GCc22WI0uN97j1c6Yej8ET6
         d43BzgSoLduY2eJQZJ5651z4eNjqpnzNaJ31jKtmxQrFqrZFdbDXPqQiCjIu3XDJq6jP
         WlgLNfgEvD14gEGa/1pv0TPsnwDMjCgaLdTCrpKVSo0bcY4X60+PCvBAKzabkpWn8O5T
         179ARKsrJjkPcLwZ8eMhVkuJO7sfOiBxvJVxYuvN/2G3lqz2QI9Jo89w3dal4m7vfo0f
         6cAQ==
X-Gm-Message-State: AFqh2kpeHhfCr5Ht2Gq8vsw1u8dTA7OduMF0RRqZJKX/6C72eCT5Hfx7
        9HFO/Hs32d+pAXp+lter3Fw=
X-Google-Smtp-Source: AMrXdXtPtaijmD1yRW9D4IQ84d0T25NghrVd3aWZK6hlMNJrphY9lFsAluPziuZVij5mo39LNP/aNg==
X-Received: by 2002:a17:90b:4a91:b0:229:f8f3:6481 with SMTP id lp17-20020a17090b4a9100b00229f8f36481mr2693006pjb.31.1674179999026;
        Thu, 19 Jan 2023 17:59:59 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id n4-20020a17090a394400b0022698aa22d9sm303383pjf.31.2023.01.19.17.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 17:59:58 -0800 (PST)
Date:   Fri, 20 Jan 2023 07:29:56 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v2 09/11] selftests/bpf: Add dynptr var_off tests
Message-ID: <20230120015956.o5qhvrnq3bg4g7l5@apollo>
References: <20230119021442.1465269-1-memxor@gmail.com>
 <20230119021442.1465269-10-memxor@gmail.com>
 <CAJnrk1a9wTzo+hbkY9ivb8xCU6NTvbum7XAnWhn2ugSOBqRnOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1a9wTzo+hbkY9ivb8xCU6NTvbum7XAnWhn2ugSOBqRnOA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 04:19:31AM IST, Joanne Koong wrote:
> On Wed, Jan 18, 2023 at 6:15 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Ensure that variable offset is handled correctly, and verifier takes
> > both fixed and variable part into account. Also ensures that only
> > constant var_off is allowed.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  .../testing/selftests/bpf/progs/dynptr_fail.c | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > index 023b3c36bc78..063d351f327a 100644
> > --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > @@ -794,3 +794,43 @@ int dynptr_pruning_type_confusion(struct __sk_buff *ctx)
> >         );
> >         return 0;
> >  }
> > +
> > +SEC("?tc")
> > +__failure __msg("dynptr has to be at the constant offset") __log_level(2)
> > +int dynptr_var_off_overwrite(struct __sk_buff *ctx)
> > +{
> > +       asm volatile (
> > +               "r9 = 16;"
> > +               "*(u32 *)(r10 - 4) = r9;"
> > +               "r8 = *(u32 *)(r10 - 4);"
> > +               "if r8 >= 0 goto vjmp1;"
> > +               "r0 = 1;"
> > +               "exit;"
> > +       "vjmp1:"
> > +               "if r8 <= 16 goto vjmp2;"
> > +               "r0 = 1;"
> > +               "exit;"
> > +       "vjmp2:"
> > +               "r8 &= 16;"
> > +               "r1 = %[ringbuf] ll;"
> > +               "r2 = 8;"
> > +               "r3 = 0;"
> > +               "r4 = r10;"
> > +               "r4 += -32;"
> > +               "r4 += r8;"
> > +               "call %[bpf_ringbuf_reserve_dynptr];"
> > +               "r9 = 0xeB9F;"
> > +               "*(u64 *)(r10 - 16) = r9;"
> > +               "r1 = r10;"
> > +               "r1 += -32;"
> > +               "r1 += r8;"
> > +               "r2 = 0;"
> > +               "call %[bpf_ringbuf_discard_dynptr];"
> > +               :
> > +               : __imm(bpf_ringbuf_reserve_dynptr),
> > +                 __imm(bpf_ringbuf_discard_dynptr),
> > +                 __imm_addr(ringbuf)
> > +               : __clobber_all
> > +       );
> > +       return 0;
> > +}
>
> Thanks for adding these series of tests. From a readibility
> perspective, are we able to simulate these tests in C instead of
> assembly?

It should be possible, but I went with assembly for two reasons:
- In one of the tests extra instructions are emitted at a specific place in the
  program to trigger add_new_state heuristic of the verifier. I was having
  trouble making this work when initially trying to trigger the bug in C.
- Preventing compiler changes from changing the desired BPF assembly that should
  be produced over time. I'm mostly worried about these changes happening
  silently and the test becoming useless over time without being able to detect
  so. Right now you can take these ASM tests and run them on an unpatched kernel
  and it will successfully load the program (on running crash it).

In the last patch I still added C tests as those shouldn't need assembly.
