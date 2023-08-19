Return-Path: <bpf+bounces-8110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E660C781675
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 03:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAB4281D7D
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 01:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C82A7EF;
	Sat, 19 Aug 2023 01:45:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEDB634
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 01:45:30 +0000 (UTC)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE5B30F5
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 18:45:28 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so1829620a12.0
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 18:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692409527; x=1693014327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bgvuX2eVa6E2JwnFIcbrEkymyN3NvERu2XX4ujhuOz8=;
        b=VODTepePLIpo3hDB4EB6w8lCKaOV+pqNWeX7/9HDofRdR+95vxFpA+2XMSD9P3zUPf
         XtX3UqxtHj5Jqo551iN4vgcyE+GPs+MbYZZXFCdswbAPC9M8ZDYBerZ5Wq/gC6F7/Ykz
         7IFo7o+dOMNrbvascaWE8Vx9SdMwQsj1MtOx3+Pu3c3CJYez/o05Ag45hO16gjFxfhl8
         D0h1rS7tCshdaREeaYxFAip0npTDo/WjH+XRY5UefjIwx5XoF3TY3dcMTj80gR+jMHBi
         tq+ffzXkII2W/AsHsieBda7IePtlHJHRp+2AGkarW8QwrSZ/sglmPCSvF6hNLfk+k6h5
         gqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692409527; x=1693014327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgvuX2eVa6E2JwnFIcbrEkymyN3NvERu2XX4ujhuOz8=;
        b=huWr7/3gRXhf2GWC4wvPLHAk2ko/Jgv974pB+fv5SRj382EAM/r1bTxnb7juHOy59F
         x51EGLnEx31wez3nWOX/W5uREVUZEmWv4QlYG3Wr2AW3BXTBDBbj/bkSCvUEYoEjtMF0
         gfyY61QJkpbeholK5Mkn8DnM/BxiwHfci7K3FwA3H7/s67Weu2iD8RqfvjJ+BqU2MhHb
         CXuS5k585YBiXN77axezbpAuqOTxialrtDVMUp3COtPHVF11r7bPtFkH/bxRRVLnrWYM
         TXA3oPyRMKjSKiBwuJoDdPuW0Rhca7XfHNay9OsGg4E7Zzdba1le66tkPJW3lLNbB57f
         a7jw==
X-Gm-Message-State: AOJu0YyAPuRlJwDmoOq0/hLNR10MhhipL/yHZjn7rsLjZgUD7H6xcRhx
	2GbHEXK598k2IV8xr1nELD4hFCnGinclcsSI71/vBg3EidolaQ==
X-Google-Smtp-Source: AGHT+IF01bOGa9jfrlKDpG2+5o0Lt3M9LLsEHk+/WFkEsMI/hRnFfkHaxnVFOOX6UZE0n36jX0ps/h+pG2KznP3Ln+k=
X-Received: by 2002:aa7:c3c3:0:b0:523:47b0:9077 with SMTP id
 l3-20020aa7c3c3000000b0052347b09077mr567848edr.38.1692409527013; Fri, 18 Aug
 2023 18:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814172809.1361446-1-yonghong.song@linux.dev> <20230814172857.1366162-1-yonghong.song@linux.dev>
In-Reply-To: <20230814172857.1366162-1-yonghong.song@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 19 Aug 2023 07:14:50 +0530
Message-ID: <CAP01T76BxK=OR8es4_GByNpZn_WVBDDQQELgSgkJwUh0=q_CYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/15] bpf: Mark OBJ_RELEASE argument as MEM_RCU
 when possible
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 14 Aug 2023 at 23:00, Yonghong Song <yonghong.song@linux.dev> wrote:
>
> In previous selftests/bpf patch, we have
>   p = bpf_percpu_obj_new(struct val_t);
>   if (!p)
>           goto out;
>
>   p1 = bpf_kptr_xchg(&e->pc, p);
>   if (p1) {
>           /* race condition */
>           bpf_percpu_obj_drop(p1);
>   }
>
>   p = e->pc;
>   if (!p)
>           goto out;
>
> After bpf_kptr_xchg(), we need to re-read e->pc into 'p'.
> This is due to that the second argument of bpf_kptr_xchg() is marked
> OBJ_RELEASE and it will be marked as invalid after the call.
> So after bpf_kptr_xchg(), 'p' is an unknown scalar,
> and the bpf program needs to reread from the map value.
>
> This patch checks if the 'p' has type MEM_ALLOC and MEM_PERCPU,
> and if 'p' is RCU protected. If this is the case, 'p' can be marked
> as MEM_RCU. MEM_ALLOC needs to be removed since 'p' is not
> an owning reference any more. Such a change makes re-read
> from the map value unnecessary.
>
> Note that re-reading 'e->pc' after bpf_kptr_xchg() might get
> a different value from 'p' if immediately before 'p = e->pc',
> another cpu may do another bpf_kptr_xchg() and swap in another value
> into 'e->pc'. If this is the case, then 'p = e->pc' may
> get either 'p' or another value, and race condition already exists.
> So removing direct re-reading seems fine too.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/verifier.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6fc200cb68b6..6fa458e13bfc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8854,8 +8854,15 @@ static int release_reference(struct bpf_verifier_env *env,
>                 return err;
>
>         bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
> -               if (reg->ref_obj_id == ref_obj_id)
> -                       mark_reg_invalid(env, reg);
> +               if (reg->ref_obj_id == ref_obj_id) {
> +                       if (in_rcu_cs(env) && (reg->type & MEM_ALLOC) && (reg->type & MEM_PERCPU)) {

Wouldn't this check also be true in case of bpf_percpu_obj_drop(p)
inside RCU CS/non-sleepable prog?
Do we want to permit access to p after drop in that case? I think it
will be a bit unintuitive.
I think we should preserve normal behavior for everything except for
kptr_xchg of a percpu_kptr.

> +                               reg->ref_obj_id = 0;
> +                               reg->type &= ~MEM_ALLOC;
> +                               reg->type |= MEM_RCU;
> +                       } else {
> +                               mark_reg_invalid(env, reg);
> +                       }
> +               }
>         }));
>
>         return 0;
> --
> 2.34.1
>
>

