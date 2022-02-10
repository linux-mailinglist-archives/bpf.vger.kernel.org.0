Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245844B193A
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 00:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345536AbiBJXOb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 18:14:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243041AbiBJXOa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 18:14:30 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6775F44
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 15:14:31 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id y9so6542650pjf.1
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 15:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4TxChZvsJTnEbkj4WQeGTd1MYKuyEAaFeWT2/0Tbl8=;
        b=W6gy5CE7FTL/JmmLeLkrZ4VIR9ZS+F2DxRWfZe/4hgqHpv2NtmOo+F+lK6EfJ/I3JU
         rxSk/OG5Bmm0pXSo6NmfG3srLo1K1ja/R5tFT6p1/nW1+Nd6RdvPXMAapjUSZgodGDWP
         OMzmvL58sufmsYhXns7cNvmeAcVplEd91BF/PAOKSTF65e8HZqezTpEvu6C22ZuGl5nB
         LCd7r2qY+LJ4zLhgBrdc2+IQ9oDXXuMLCQKb18zWMVyWyLAj4R2s3vgismxxo/OlGa8k
         Zq8R2VnPividOA+nWnawvMV1nZ+KaTovNML3fklsClTkWsIXznuWBAf5k9typ8sdqMnt
         GrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4TxChZvsJTnEbkj4WQeGTd1MYKuyEAaFeWT2/0Tbl8=;
        b=11Y+E/9d5YFktqp2Md5KJgBWalQTgnJQek1Y8vt0zQRVLh2/VU7CnAm4ME+S4wFfXd
         Lbx2I8qfGJxb1KKdBHNM6NqXCM4bZQaHd0sjkUqkzVKkA7f8j4RRfH82wjmZUPVzFBs9
         hbtks802phGhaIHneOlNX5ZrdLnRaXUIlMuLv3rFTXN1h39zkHaOB8N110hLRYy1TUB1
         wr9pEVqFTlKr7o3Y9iXu0tk3SQXz4HYqLixFpHDFRUvjjKPiGy45Wd1h/Ctr2sXISvYa
         WfaWztPBNl2M2uhMNVw5zLl/tXkftxj8/9YIGXLHFxpvFOS2cis/HqHJNczokHPHNoO9
         jAgQ==
X-Gm-Message-State: AOAM532YxCCz61yOL8NaR6XBrSjb3O5BAqNGdMxXmmHXeRvNBomaeIXW
        ALaA+erwGffL9TotSZHijuGacFBUxCKioDFOkvg=
X-Google-Smtp-Source: ABdhPJyLaAvi8mZZN34NtqPdVQrMiuKdPI2U0ilkUbU5Eh28m2GjAwXazC0ucYSaERni0Za3WJkvl0CfVW17N8eIhds=
X-Received: by 2002:a17:90a:d203:: with SMTP id o3mr5166616pju.122.1644534870540;
 Thu, 10 Feb 2022 15:14:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644453291.git.delyank@fb.com> <78216409-5892-6410-a82c-0ebf5fdb1504@fb.com>
In-Reply-To: <78216409-5892-6410-a82c-0ebf5fdb1504@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 10 Feb 2022 15:14:19 -0800
Message-ID: <CAADnVQKk-uOEkEiPuBu7W_oYx=gTGpruK6Kc0ShTcFYEAbCczA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] Avoid typedef size mismatches in skeletons
To:     Yonghong Song <yhs@fb.com>
Cc:     Delyan Kratunov <delyank@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 10, 2022 at 2:51 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/9/22 4:36 PM, Delyan Kratunov wrote:
> > As reported in [0], kernel and userspace can sometimes disagree
> > on the definition of a typedef (in particular, the size).
> > This leads to trouble when userspace maps the memory of a bpf program
> > and reads/writes to it assuming a different memory layout.
>
> I am thinking whether we can do better since this only resolved
> some basic types. But it is totally possible some types in vmlinux.h,
> who are kernel internal types, happen in some uapi or user header
> as well but with different sizes.
>
> Currently, the exposed bpf program types (in skeleton) are all
> from global variables. Since we intend to ensure their size
> be equal, and bpf program itself provides the size of the type.
>
> For example, in bpf program, we have following,
>     TypeA    variable;
>
> Since TypeA will appear in the skel.h file, user must define it
> somehow before skel.h. Let us say TypeA size is 20 from bpf program
> BTF type.
>
> So we could insert a
>    BUILD_BUG_ON(sizeof(TypeA) != 20)
> in the skeleton file to ensure the size match and this applies
> to all types.
>
> In the skel.h file, we can have
> #ifndef BUILD_BUG_ON
> #define BUILD_BUG_ON ...
> #endif
> to have BUILD_BUG_ON to cause compilation error if the condition is true.
>
> User can define BUILD_BUG_ON before skel.h if they want to
> override.
>
> This should apply to all types put in bss/data/rodata sections
> by skeleton.
>
> If this indeed happens as in [0], user can detect the problem
> and they may look at vmlinux.h and use proper underlying types
> to resolve the issue.
>
> WDYT?

Going back to https://github.com/iovisor/bcc/pull/3777 issue..
The user space part that included skel.h might have used
dev_t in other places in the code.
When bpftool automagically replaces dev_t in skel.h with int32_t
to match the kernel it only moves the problem further into
the user space where dev_t would still mismatch.
So adding
_Static_assert(sizeof(type_in_skel) == const_size_from_kernel);
to skel.h would force users to pick types that are the same
both in bpf prog and in corresponding user space part.
I think that's a better approach.
Maybe we don't need to add static_assert for all types,
but that's a minor tweak.
