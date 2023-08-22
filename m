Return-Path: <bpf+bounces-8239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6AB784152
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 14:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38AD0281059
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 12:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF53E1C2B6;
	Tue, 22 Aug 2023 12:56:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7117F
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 12:56:25 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5107CD1
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 05:56:19 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-52a0856b4fdso2814503a12.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 05:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692708978; x=1693313778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zKLJ6dBpcS6ScofRWsJdDDUCBZmsVrM/AyKgjUbF2rI=;
        b=N/CRmqAVbKWYULAjgok/IroOhlBF592pVNFdzMiFlXfQcwDsO14twkWrPa3sqWfOkd
         L8LiJNQdopblo0u6K1Wm07Mc3rzVHpYllT3cu12qR+xcaT7qJx9VRQVQ1kw/MSI+lsfz
         FKMYSIyjH3vL2SL78ZGa8834skjLWBs4xpkWZG3574GRGV5S0buzg0ez8uFWinne1SIw
         vD2ouU51BWK9xgn87DTmkTdl8Tev/3PSGePo1ecMLKT0B5JHkeZ2i1Uz1tUQKGDKhxnd
         fS8vT5RIQIayKnvv4ayIAzSGT3wogfKfqNc2+blHyDrupsYiRxng8ED0r0YLvpBajAaD
         UVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692708978; x=1693313778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKLJ6dBpcS6ScofRWsJdDDUCBZmsVrM/AyKgjUbF2rI=;
        b=N6cmC/l91gntQK8kjrM3r4WSUIX46Kvf5/KbzcSlRZMBe7BZZzjVCRFFeRC44sx0QE
         gbaAWkNqvyGWMvM76tvwF7nnSswk00+4fnIEvQVK7jexXzNq217PYnQI7QrR7wGfpk0m
         WPi54445Nr2wTCE2h+xeajsGNZInkgBNsbdeCKYLSDqjxVVCaV5S8uTKQ+tV5O8rtHxl
         e5EYrCm/U2I+MyQaTDIlnnCkrhW+3YJ38pEqvkx6MbDDiMopqrlRXUr/eFkOb9iyYkdM
         sW/VYDvigdrthSvHSGnKe8RR77KQjpq0GZUp2VL3eKwiSRSxuYK/k78SBmQ//6/x0rcv
         Y9/A==
X-Gm-Message-State: AOJu0YwbTQYuOx+GwY45tCheR2tA/As5NQyS05oYJTHAAqKOE03632NO
	ZJCHlzzghYzogzyqhovQ3nhQSt7Hmvx7UJumgko=
X-Google-Smtp-Source: AGHT+IEpGmqYrOX9q5NTkEtwTy5CCbyP4xl37ennR6MklevlC5NUSnkQy+KkbICp7hZcDFFouwFiN2ZSPn4MAmghlcc=
X-Received: by 2002:aa7:cd50:0:b0:525:4471:6b5d with SMTP id
 v16-20020aa7cd50000000b0052544716b5dmr6598437edw.19.1692708977904; Tue, 22
 Aug 2023 05:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230821000230.3108635-1-yonghong.song@linux.dev>
 <CAP01T76hm=FBU3f9EePUsV525g=RFw0KPvSRn5BjHo=QGD_qEQ@mail.gmail.com> <c7ce55e7-b462-5d02-768c-f817212d0194@linux.dev>
In-Reply-To: <c7ce55e7-b462-5d02-768c-f817212d0194@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Aug 2023 18:25:41 +0530
Message-ID: <CAP01T76N2_7bfz20sq_zM3u0WwKhKaqYSkCxbLYqOJB-nRN_sA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix a bpf_kptr_xchg() issue with local kptr
To: David Marchevsky <david.marchevsky@linux.dev>
Cc: Yonghong Song <yonghong.song@linux.dev>, Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 22 Aug 2023 at 10:45, David Marchevsky
<david.marchevsky@linux.dev> wrote:
>
> On 8/21/23 4:36 AM, Kumar Kartikeya Dwivedi wrote:
> > On Mon, 21 Aug 2023 at 05:33, Yonghong Song <yonghong.song@linux.dev> wrote:
> >>
> >> When reviewing local percpu kptr support, Alexei discovered a bug
> >> wherea bpf_kptr_xchg() may succeed even if the map value kptr type and
> >> locally allocated obj type do not match ([1]). Missed struct btf_id
> >> comparison is the reason for the bug. This patch added such struct btf_id
> >> comparison and will flag verification failure if types do not match.
> >>
> >>   [1] https://lore.kernel.org/bpf/20230819002907.io3iphmnuk43xblu@macbook-pro-8.dhcp.thefacebook.com/#t
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
> >>  kernel/bpf/verifier.c | 13 ++++++++++++-
> >>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 02a021c524ab..4e1ecd4b8497 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -7745,7 +7745,18 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> >>                         verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
> >>                         return -EFAULT;
> >>                 }
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
> I think you're correct, that's probably leftover from when
> helpers were tagged KF_RELEASE in earlier rbtree impl revisions.
>
> I also think it's reasonable to delete the hunk as you've done
> in attached patches.
>

Ok, then I'll submit it as a patch after Yonghong's patch is accepted
(since both will conflict trying to add local_kptr_stash_fail test
cases) and you can give your Acked-by on it.

