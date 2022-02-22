Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA994BEFA2
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 03:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiBVCfe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Feb 2022 21:35:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiBVCfb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Feb 2022 21:35:31 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5523D25C63
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 18:35:07 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id y5so10516999pfe.4
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 18:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P/jBqfWNRTmZ46UtmaKuhxemc4wjmTS5aXcahnSlwRU=;
        b=g4yiXcli/jtsps3wa10szEe1prpQXvjIoupTAUmyQ0CfOFwzNXJPy8NckS7cF8Hd7H
         +yERlKUSLbG5Q3iqRd9bZQ1lpyX2n979aN5xyVoAj5r2i3Xq8Db1DhxQcPL34yKgE6Bb
         vynsxuKzG5ClWcraUqjM8Rvy4zGlOEw3DygKE1wZ1al6pQFPA6fN0AUQoGqcp0Gfx6v2
         v6d449MT9GCLsLKgr1+x6lUtuRK2x+RJTjBC+TEsR6jQsbcXnsibBgtXRgqAPlZGRb8M
         I0KCHraktxdLSjNqkIRuJoDin6okiy5mBbx38Y9upK3PkZj5Upa1rDFpF+lQvwTbNJkS
         fSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P/jBqfWNRTmZ46UtmaKuhxemc4wjmTS5aXcahnSlwRU=;
        b=yCYGakbivQlArhmoD0PXEGb4Y1+X/gumyFa8Og0ccAPkMKOtUPMbOCYUPy2+ImTuFW
         g8FMjeRRfF4Ci6GszUG7xwgzz0n/TOwa2dpocttThFl+l1IoQoQDnGyJNHacsuFzcIHC
         9Kdg9i/Y79BTvaK0O9NuaPM2NMsuQz1xODe9/cECkUVQUVZbNBJfM8Tbksm7Y2AeYuPI
         JpImhaISEhlhh+daTcLlDbRLji8wsYy8hOKWRxAe7Oz00lxUMlV28lyj/v/UarCJ5ZHo
         r9yGQnWHz+2ca4WPbwQfb8npwVIFMv/6MmCrxPk4E0H/aLqn01QFf8HNCwp2iM+3FSH4
         Z9UQ==
X-Gm-Message-State: AOAM533t9Dp4hsFRrAU4tCK/cR0Fb4fMpgA2DfC1QEPB5hpWn6x+WL0T
        9pRd64RG/OFna4lSa6VHhHc=
X-Google-Smtp-Source: ABdhPJyZtHZblQ8Q5JwRLkxDjMngQjpCdQ9ZuiJ7amqEH/uGOjzouTMEwWZPE3gfmGILdbg8lV373Q==
X-Received: by 2002:a62:e917:0:b0:4e0:1646:3b82 with SMTP id j23-20020a62e917000000b004e016463b82mr22825854pfh.57.1645497306767;
        Mon, 21 Feb 2022 18:35:06 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id q4sm14543867pfj.113.2022.02.21.18.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 18:35:06 -0800 (PST)
Date:   Tue, 22 Feb 2022 08:05:03 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add test for reg2btf_ids out of
 bounds access
Message-ID: <20220222023503.xucetwvdj2q7wux3@apollo.legion>
References: <20220220023138.2224652-1-memxor@gmail.com>
 <CAPhsuW6Y=4dSgu=Ax+4YL7ED_yXm4y7P04rxG3PfzD7mU_=8jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW6Y=4dSgu=Ax+4YL7ED_yXm4y7P04rxG3PfzD7mU_=8jw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 22, 2022 at 07:53:33AM IST, Song Liu wrote:
> On Sat, Feb 19, 2022 at 6:31 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > This test tries to pass a PTR_TO_BTF_ID_OR_NULL to the release function,
> > which would trigger a out of bounds access without the fix in commit
> > 45ce4b4f9009 ("bpf: Fix crash due to out of bounds access into reg2btf_ids.")
> > but after the fix, it should only index using base_type(reg->type),
> > which should be less than __BPF_REG_TYPE_MAX, and also not permit any
> > type flags to be set for the reg->type.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/verifier/calls.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> > index 829be2b9e08e..0a8ea60c2a80 100644
> > --- a/tools/testing/selftests/bpf/verifier/calls.c
> > +++ b/tools/testing/selftests/bpf/verifier/calls.c
> > @@ -96,6 +96,25 @@
> >                 { "bpf_kfunc_call_test_mem_len_fail1", 2 },
> >         },
> >  },
> > +{
> > +       "calls: trigger reg2btf_ids[reg->type] for reg->type > __BPF_REG_TYPE_MAX",
> > +       .insns = {
> > +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
> > +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
> > +       BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
> > +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> > +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> > +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> > +       BPF_EXIT_INSN(),
> > +       },
> > +       .prog_type = BPF_PROG_TYPE_SCHED_CLS,
> > +       .result = REJECT,
> > +       .errstr = "arg#0 pointer type STRUCT prog_test_ref_kfunc must point",
>
> Why do we stop errstr at "must point"?
>

The complete string is too long, I think it matches using strncmp.

> > +       .fixup_kfunc_btf_id = {
> > +               { "bpf_kfunc_call_test_acquire", 3 },
> > +               { "bpf_kfunc_call_test_release", 5 },
> > +       },
> > +},
> >  {
> >         "calls: basic sanity",
> >         .insns = {
> > --
> > 2.35.1
> >

--
Kartikeya
