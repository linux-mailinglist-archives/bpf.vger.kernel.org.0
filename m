Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795386AB3A3
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 01:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjCFAOM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 19:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCFAOL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 19:14:11 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D98FF24
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 16:14:10 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id y19so4523436pgk.5
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 16:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/iNSjGt4LvBwBTzqEDDmcGmSc5TGNN1AZh+JJ+IE0Ic=;
        b=DNQ9qaIIWgAxe4guOyPunuX8j7iHLWSJWLBVRay4ORsmbeaDp6KtelaAdL2iPt4QyN
         fhjeLw/s8RWSt0+ENdXHY904TzVP1VES5Zp/Lltdpu0PTbuRs8ZXDif/SXU38wZxCml7
         sn5i0wwFpH/6od7fpL9G8IGkDBUofIEDrIQH2kMcSSqkeSh4bzWm7dmGsnv9ohpdPW0O
         MjJT8M+cMt7sKp2OY/hiN30yOwZWW7r9uR/FqmPDw0IBlHMPPLUdQP6hl3TbWbmvzmKV
         rzl4ZLl3Ot5x+R/+vCb8Wo5frBJH98HF3lfvqNtVRhcLNX1al/WELVRgRUIVqSOagvYf
         4eLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/iNSjGt4LvBwBTzqEDDmcGmSc5TGNN1AZh+JJ+IE0Ic=;
        b=aIlgZjEfILi+IZMEr38m2pMy5kqCsXd8hdSXtPEoD0UL1DjSDvO0bh9scJgD2VAdXn
         6XbTZUU5bIsx5tebzIUE4N/Bpaoh4/RSQPPEGPve/S9A6n3oCNXvbRC5rRSfK488Cd8g
         elEEco/sO0Z3MxGtlSM/upD1na3UYdw3qJM3+Ujwljg7fGdBKEM4dz5mvGEBRQtV5u57
         U1YJjwe0wE7YaE1w+OVaiiP5NMVXclEtAtzrbPB9CR2S0Dm2U8PiRXU7qmhe8Kw/ijwr
         ko9qYVcAj01ooIDzOIxZMLKD5ZZx1IlH2JcVCFVVeHbA4fbHvWA6oaceqnMBw2LiUkoz
         PFjQ==
X-Gm-Message-State: AO0yUKWX+k9NTG/5dOn32rpgQZlgsZD6vgaX/lYxJdF24qeA6w4egKm6
        1tkX+MiQAjc27gkpcHDNnWQ=
X-Google-Smtp-Source: AK7set//18Jav4ADAqzsXejvpUmcuz8bPcOUpWMUQRVAahhVQVia58f/5gH9yeaO0goOjhiKvZHBQA==
X-Received: by 2002:a62:1c58:0:b0:5e3:16fc:b58e with SMTP id c85-20020a621c58000000b005e316fcb58emr8117962pfc.21.1678061649569;
        Sun, 05 Mar 2023 16:14:09 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:59fc])
        by smtp.gmail.com with ESMTPSA id n4-20020a62e504000000b005a8c92f7c27sm4997375pff.212.2023.03.05.16.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 16:14:09 -0800 (PST)
Date:   Sun, 5 Mar 2023 16:14:07 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 16/17] selftests/bpf: add iterators tests
Message-ID: <20230306001407.lreqhdvdwitdb63v@MacBook-Pro-6.local>
References: <20230302235015.2044271-1-andrii@kernel.org>
 <20230302235015.2044271-17-andrii@kernel.org>
 <20230304203900.2eowyut62ptvgcsq@MacBook-Pro-6.local>
 <CAEf4BzbrPGPKZSxen4AKc9WDXM0+mutOSR7xeHOtENsFT7JM4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbrPGPKZSxen4AKc9WDXM0+mutOSR7xeHOtENsFT7JM4g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 04, 2023 at 03:29:23PM -0800, Andrii Nakryiko wrote:
> On Sat, Mar 4, 2023 at 12:39 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Mar 02, 2023 at 03:50:14PM -0800, Andrii Nakryiko wrote:
> > > +
> > > +#ifdef REAL_TEST
> >
> > Looks like REAL_TEST is never set.
> >
> > and all bpf_printk-s in tests are never executed, because the test are 'load-only'
> > to check the verifier?
> >
> > It looks like all of them can be run (once printks are removed and converted to if-s).
> > That would nicely complement patch 17 runners.
> >
> 
> Yes, it's a bit sloppy. I used these also as manual tests during
> development. I did have an ad-hoc test that attaches and triggers
> these programs. And I just manually looked at printk output in
> trace_pipe to confirm it does actually work as expected.
> 
> And I felt sorry to drop all that, so just added that REAL_TEST hack
> to make program code simpler (no extra states for those pid
> conditions), it was simpler to debug verification failures, less
> states to consider.
> 
> I did try to quickly extend RUN_TESTS with the ability to specify a
> callback that will be called on success, but it's not trivial if we
> want to preserve skeletons, so I abandoned that effort, trying to save
> a bit of time. I still want to have RUN_TESTS with ability to specify
> callback in the form of:
> 
> static void on_success(struct <my_skeleton_type> *skel, struct
> bpf_program *prog) {
>     ...
> }
> 
> but it needs more thought and macro magic (or something else), so I
> postponed it and wrote simple number iterator tests in patch #17.

Sounds good to me. Follow up is fine.

> > It can be a follow up, of course.
> 
> yep, let's keep bpf_printks, as they currently serve as consumers of
> variables, preventing the compiler from optimizing loops too much.
> This shouldn't be a problem for verification-only kind of tests. And
> then with RUN_TESTS() additions, we can actually start executing this.

+1
