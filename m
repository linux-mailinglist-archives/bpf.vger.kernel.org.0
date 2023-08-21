Return-Path: <bpf+bounces-8162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DD1782DB7
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 18:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28741C20952
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 16:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CF7882D;
	Mon, 21 Aug 2023 16:03:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E78460
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 16:03:48 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E59ADB
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 09:03:47 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so9500663a12.0
        for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 09:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692633826; x=1693238626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LnzFv0fGgC0HOEg93zs18bZhT3l7j5Cy537bKcur2Xo=;
        b=cz/gLmJQ5pjrQarJ9sDi4gcwijipnYRnEi+G/l+JN1LrWzKgDDJ7sjHjH4YMbecpCM
         Xw6ZIVgOkKgKo94lx3WZn2/oZeTesfktyntt4u761LV+UE0kEbCfLlQCR8/gONTFfihz
         i1S6RA3h4F6nheyLcmBtRSQeQZYIOPIr0yGqrYQwIfd3Lgmv5l6+nBB+OfW1VakLoIC6
         s6pAz/xh5rwOYRFL4vYQytEexl/S5Gza6Ir4lrEcriUHAAk1LxfSKdHRTn1vX8Lpjx4F
         FvZBqm2a433F1ATpypuYCFCJ/7ZPb4NM5MRX1BhknHAx9f0CtJPbzZGaeRiryerjvn1u
         B5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692633826; x=1693238626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnzFv0fGgC0HOEg93zs18bZhT3l7j5Cy537bKcur2Xo=;
        b=fpNDULC8bFetGkfWzhSxT4/l2DOz2xU2lsI5G70W/jEdKns8XBKN4UVgn0NP8sV5pD
         7vxiiIfab94x1b3Ro+wFCujZKK6fuXZyEsH09XtNQL/Y6VtGVGVkZCc6ikUVZdoA6cR5
         zJsVsIyDB14Cv+y89jXlShlUUU65yg4DVsx5bANKljcsOdMbgSwPmJzyV0p0jaZBxCK6
         P4Ua/UhAEnz1idzLyQgDT7By60Q+EOBZNm71kc5zQKu+VyXZi6zbDE8qGvyYNtRJPxGU
         e67GQ9VRFmfRI+wVwl0N3aoFoMVEEWyGNOrgM5K+GOefabssCKWYEnXTbXSniV96NEHh
         zUvw==
X-Gm-Message-State: AOJu0YwEtE22iC3K0jAlZq9MV7OMh+JoWnm/1tgL3vK6zVF+GlwrKG6X
	FlH2wGAAzpxlqbymS/yAWVmjNurG2JbcbXIZmyk=
X-Google-Smtp-Source: AGHT+IFjrUKtBnadMmUKlkzBOZgNvXDdHUEUSDhhqMxTCIeggdA2+YvPVwCWOINMhF2YQclB+5ouUd3waunXTFmzJwQ=
X-Received: by 2002:a05:6402:440f:b0:525:4696:336d with SMTP id
 y15-20020a056402440f00b005254696336dmr8379418eda.8.1692633825492; Mon, 21 Aug
 2023 09:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230821000230.3108635-1-yonghong.song@linux.dev>
 <CAP01T76hm=FBU3f9EePUsV525g=RFw0KPvSRn5BjHo=QGD_qEQ@mail.gmail.com> <4a5a4fbf-fd9d-2723-2a5f-9a9da162bd5b@linux.dev>
In-Reply-To: <4a5a4fbf-fd9d-2723-2a5f-9a9da162bd5b@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 21 Aug 2023 21:33:09 +0530
Message-ID: <CAP01T77R=sKccHMc5jrEF2vGyPpAGM25+ompTcT+W8W-mZCk+Q@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix a bpf_kptr_xchg() issue with local kptr
To: yonghong.song@linux.dev
Cc: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 21 Aug 2023 at 19:52, Yonghong Song <yonghong.song@linux.dev> wrote:
>
>
>
> On 8/21/23 1:36 AM, Kumar Kartikeya Dwivedi wrote:
> > On Mon, 21 Aug 2023 at 05:33, Yonghong Song <yonghong.song@linux.dev> wrote:
> >>
> >> When reviewing local percpu kptr support, Alexei discovered a bug
> >> wherea bpf_kptr_xchg() may succeed even if the map value kptr type and
> >> locally allocated obj type do not match ([1]). Missed struct btf_id
> >> comparison is the reason for the bug. This patch added such struct btf_id
> >> comparison and will flag verification failure if types do not match.
> >>
> >>    [1] https://lore.kernel.org/bpf/20230819002907.io3iphmnuk43xblu@macbook-pro-8.dhcp.thefacebook.com/#t
> >>
> >> Reported-by: Alexei Starovoitov <ast@kernel.org>
> >> Fixes: 738c96d5e2e3 ("bpf: Allow local kptrs to be exchanged via bpf_kptr_xchg")
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >
> > Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >
> > But some comments below...
> >
> >>   kernel/bpf/verifier.c | 13 ++++++++++++-
> >>   1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 02a021c524ab..4e1ecd4b8497 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -7745,7 +7745,18 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> >>                          verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
> >>                          return -EFAULT;
> >>                  }
> >> -               /* Handled by helper specific checks */
> >> +               if (meta->func_id == BPF_FUNC_kptr_xchg) {
> >> +                       struct btf_field *kptr_field = meta->kptr_field;
> >> +
> >> +                       if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> >> +                                                 kptr_field->kptr.btf, kptr_field->kptr.btf_id,
> >> +                                                 true)) {
> >> +                               verbose(env, "R%d is of type %s but %s is expected\n",
> >> +                                       regno, btf_type_name(reg->btf, reg->btf_id),
> >> +                                       btf_type_name(kptr_field->kptr.btf, kptr_field->kptr.btf_id));
> >> +                               return -EACCES;
> >> +                       }
> >> +               }
> >
> > The fix on its own looks ok to me, but any reason you'd not like to
> > delegate to map_kptr_match_type?
> > Just to collect kptr related type matching logic in its own place.  It
> > doesn't matter too much though.
>
>  From comments from Alexei in
>
> https://lore.kernel.org/bpf/20230819002907.io3iphmnuk43xblu@macbook-pro-8.dhcp.thefacebook.com/#t
>
> =====
> The map_kptr_match_type() should have been used for kptrs pointing to
> kernel objects only.
> But you're calling it for MEM_ALLOC object with prog's BTF...
> =====
>
> So looks like map_kptr_match_type() is for kptrs pointing to
> kernel objects only. So that is why I didn't use it.
>

That function was added by me. Back then I added this check as we were
discussing possibly supporting such local kptr and more thought would
be needed about the design before just doing type matching. Also it
was using kernel_type_name which was later renamed as btf_type_name,
so as a precaution I added the btf_is_kernel check. Apart from that I
remember no other reason, so I think it should be ok to drop it now
and use it.

But as I said, it is up to you, it will in effect do the same thing as
this patch, so it is ok as-is.

> >
> > While looking at the code, I noticed one more problem.
> >
> > I don't think the current code is enforcing that 'reg->off is zero'
> > assumption when releasing MEM_ALLOC types. We are only saved because
> > you passed strict=true which makes passing non-zero reg->off a noop
> > and returns false.
> > The hunk was added to check_func_arg_reg_off in
> > 6a3cd3318ff6 ("bpf: Migrate release_on_unlock logic to non-owning ref
> > semantics")
> > which bypasses in case type is MEM_ALLOC and offset points to some
> > graph root or node.
> >
> > I am not sure why this check exists, IIUC rbtree release helpers are
> > not tagged KF_RELEASE, and no release helper can type match on them
> > either. Dave, can you confirm? I think it might be an accidental
> > leftover of some refactoring.
>
> I am sure that Dave will look into this problem. I will take
> a look as well to be sure my local percpu kptr won't have
> issues with what you just discovered. Thanks!
>

It should be a problem for anything that has the MEM_ALLOC flag set,
including percpu_kptr.

