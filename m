Return-Path: <bpf+bounces-29885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29F68C7F0E
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 01:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6ABBB20F5F
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 23:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95DD2D044;
	Thu, 16 May 2024 23:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTHq0uEc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17B26ACA;
	Thu, 16 May 2024 23:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715903984; cv=none; b=PS/YSBXF/uPmN4tmtwon2wh/Jc+7ZW8wF+m0ZQyZhRYzWLIjf1qChTlErnMEgB52+eyr2Ku5Ycr94/eBwXkQ3kf0aRMgjqFln4+44lOabC36rN3qyfeOX2Q+k5JqGHAO7rVPtHyUW3hN4Ymit0rvpzNEZWCseRwrYz3pvuv7s1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715903984; c=relaxed/simple;
	bh=vsTAJLgn0Aw+1Gn7tUkmLI/IKAnVplLG5kJIbyo2ttc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cm9JPBWQkF3zuGy89A4Yhwap8wBUNjnp+AXMVLEaI3TDw4b1KGq7wUSccrtNisN8CwvF8qbWz9SyHkKZxQhto2+td/J8KIEru5yTCpG/aWzSsymBRoNKa8QFHXjI4j/QIz+CAadZa1Jlw7pQ6/r/T9HeMt/JrSBOWmhXYH+sRTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTHq0uEc; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-5b2dec569e3so460194eaf.2;
        Thu, 16 May 2024 16:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715903982; x=1716508782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fz6RmsEwx3AwXnWUdb6ulkkNrl2/ZtgWyyiD7BamxFA=;
        b=aTHq0uEcR6tIAJs0Jmk1rhEHetGplI2sm+M9ruUnyZbGETooE/OyC5xOaioOb0o68Q
         SRPfwQ3+ezaplsTYsxMr6nIwekenkJcX6UBC7NzbS6urf7FfCtSVBwjYnD44qOGljQVr
         jPMABbdNiJQf7jo2+I7xmJh7pqgLsQAIKaDpL+kpsch5/hBRKTP0xV/Qtszr+0snt4Wz
         40wVoqgxCHUfkywR0LAw93PNdY0HT3A+g8b8QVxH5S82RgLggAO8Y+sGnt+mD29cw3rj
         nlUMThNqfXlg1iFfn3yMzSopalMB6ipnoogS3k/Kk4P1bL9vplqW/7sZq2u6NjTJ4fVD
         BBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715903982; x=1716508782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fz6RmsEwx3AwXnWUdb6ulkkNrl2/ZtgWyyiD7BamxFA=;
        b=PcITT3f6qLoZXuCm0maZPOZeXSrSs9mZ/GSSwmmF/sKnWAvo/ndlrWbTa8cJT9nGdu
         yBhlM/v0+5gZDSbkO79PM6up2rYW5LiwF1LvYyb1+Tpg3QmVJyNxMmcDIOFeTmLYIHy/
         CcJv9WJycr09rRx9H0KLlfmx5K5bXYOCvpWK0Ku1Lleqs63QQ6s8x7PfnDH+eDayztb2
         wGtNt6FZ/q/GgVbDAwtt/NVyqzsxGVdKgNTSx0TvqVn3MCyRHytjYb4ymeMIUE7E04hF
         ic47TlAb1se8errLLIOMyjKsIdOPYLQR93nqXDWPsvSZFN0NwWaf2c0dO3tMaRdVWabA
         dD4w==
X-Forwarded-Encrypted: i=1; AJvYcCWy+j5Plx+u24DE3l6uXCaS6iw0zlBP5+RB2F/E12YAgGB3ZDsAljUIoEE7KFRzL5lF6rCT487cJ3SzT1oM8Q7JOuxS
X-Gm-Message-State: AOJu0YzgTSTlIUYA+mKndw3HF8VoxlepNjUPjUuTBY5993BVtfFaOeO4
	hiBv4wNd1ofVGj3/Cv9kD8ASstEbR9opYMWjqXidoVGRZb9VmGGZqj95/EngAACZ25OSL5tQeAO
	qwrsm3OwgwtUL1ZLPu9tWy084OKQ=
X-Google-Smtp-Source: AGHT+IGbKvyVuycrGqAoF1bwXogfCfG4GGEXE4+nouQ6+WZwG1rWqYKAMx7Gewamu8yZiGUxAlxAy5qpElR/32C5TCo=
X-Received: by 2002:a05:6871:2894:b0:22e:d40f:e4e2 with SMTP id
 586e51a60fabf-24172a3dddfmr21908687fac.5.1715903981566; Thu, 16 May 2024
 16:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510192412.3297104-1-amery.hung@bytedance.com> <20240510192412.3297104-2-amery.hung@bytedance.com>
In-Reply-To: <20240510192412.3297104-2-amery.hung@bytedance.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 17 May 2024 01:59:03 +0200
Message-ID: <CAP01T74iSVPnRsAbdNfzXYYS7GsdCSgp3QiaPSzex6d+3J5AAA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 01/20] bpf: Support passing referenced kptr to
 struct_ops programs
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	sdf@google.com, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 May 2024 at 21:24, Amery Hung <ameryhung@gmail.com> wrote:
>
> This patch supports struct_ops programs that acqurie referenced kptrs
> throguh arguments. In Qdisc_ops, an skb is passed to ".enqueue" in the
> first argument. The qdisc becomes the sole owner of the skb and must
> enqueue or drop the skb. This matches the referenced kptr semantic
> in bpf. However, the existing practice of acquiring a referenced kptr via
> a kfunc with KF_ACQUIRE does not play well in this case. Calling kfuncs
> repeatedly allows the user to acquire multiple references, while there
> should be only one reference to a unique skb in a qdisc.
>
> The solutioin is to make a struct_ops program automatically acquire a
> referenced kptr through a tagged argument in the stub function. When
> tagged with "__ref_acquired" (suggestion for a better name?), an
> reference kptr (ref_obj_id > 0) will be acquired automatically when
> entering the program. In addition, only the first read to the arguement
> is allowed and it will yeild a referenced kptr.
>
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>  include/linux/bpf.h         |  3 +++
>  kernel/bpf/bpf_struct_ops.c | 17 +++++++++++++----
>  kernel/bpf/btf.c            | 10 +++++++++-
>  kernel/bpf/verifier.c       | 16 +++++++++++++---
>  4 files changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 9c6a7b8ff963..6aabca1581fe 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -914,6 +914,7 @@ struct bpf_insn_access_aux {
>                 struct {
>                         struct btf *btf;
>                         u32 btf_id;
> +                       u32 ref_obj_id;
>                 };
>         };
>         struct bpf_verifier_log *log; /* for verbose logs */
> @@ -1416,6 +1417,8 @@ struct bpf_ctx_arg_aux {
>         enum bpf_reg_type reg_type;
>         struct btf *btf;
>         u32 btf_id;
> +       u32 ref_obj_id;
> +       bool ref_acquired;
>  };
>
>  struct btf_mod_pair {
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 86c7884abaf8..bca8e5936846 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -143,6 +143,7 @@ void bpf_struct_ops_image_free(void *image)
>  }
>
>  #define MAYBE_NULL_SUFFIX "__nullable"
> +#define REF_ACQUIRED_SUFFIX "__ref_acquired"
>  #define MAX_STUB_NAME 128
>
>  /* Return the type info of a stub function, if it exists.
> @@ -204,6 +205,7 @@ static int prepare_arg_info(struct btf *btf,
>                             struct bpf_struct_ops_arg_info *arg_info)
>  {
>         const struct btf_type *stub_func_proto, *pointed_type;
> +       bool is_nullable = false, is_ref_acquired = false;
>         const struct btf_param *stub_args, *args;
>         struct bpf_ctx_arg_aux *info, *info_buf;
>         u32 nargs, arg_no, info_cnt = 0;
> @@ -240,8 +242,11 @@ static int prepare_arg_info(struct btf *btf,
>                 /* Skip arguments that is not suffixed with
>                  * "__nullable".
>                  */
> -               if (!btf_param_match_suffix(btf, &stub_args[arg_no],
> -                                           MAYBE_NULL_SUFFIX))
> +               is_nullable = btf_param_match_suffix(btf, &stub_args[arg_no],
> +                                                    MAYBE_NULL_SUFFIX);
> +               is_ref_acquired = btf_param_match_suffix(btf, &stub_args[arg_no],
> +                                                      REF_ACQUIRED_SUFFIX);
> +               if (!(is_nullable || is_ref_acquired))
>                         continue;
>
>                 /* Should be a pointer to struct */
> @@ -269,11 +274,15 @@ static int prepare_arg_info(struct btf *btf,
>                 }
>
>                 /* Fill the information of the new argument */
> -               info->reg_type =
> -                       PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
>                 info->btf_id = arg_btf_id;
>                 info->btf = btf;
>                 info->offset = offset;
> +               if (is_nullable) {
> +                       info->reg_type = PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
> +               } else if (is_ref_acquired) {
> +                       info->reg_type = PTR_TRUSTED | PTR_TO_BTF_ID;
> +                       info->ref_acquired = true;
> +               }
>
>                 info++;
>                 info_cnt++;
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 8c95392214ed..e462fb4a4598 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6316,7 +6316,8 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>
>         /* this is a pointer to another type */
>         for (i = 0; i < prog->aux->ctx_arg_info_size; i++) {
> -               const struct bpf_ctx_arg_aux *ctx_arg_info = &prog->aux->ctx_arg_info[i];
> +               struct bpf_ctx_arg_aux *ctx_arg_info =
> +                       (struct bpf_ctx_arg_aux *)&prog->aux->ctx_arg_info[i];
>
>                 if (ctx_arg_info->offset == off) {
>                         if (!ctx_arg_info->btf_id) {
> @@ -6324,9 +6325,16 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>                                 return false;
>                         }
>
> +                       if (ctx_arg_info->ref_acquired && !ctx_arg_info->ref_obj_id) {
> +                               bpf_log(log, "cannot acquire a reference to context argument offset %u\n", off);
> +                               return false;
> +                       }
> +
>                         info->reg_type = ctx_arg_info->reg_type;
>                         info->btf = ctx_arg_info->btf ? : btf_vmlinux;
>                         info->btf_id = ctx_arg_info->btf_id;
> +                       info->ref_obj_id = ctx_arg_info->ref_obj_id;
> +                       ctx_arg_info->ref_obj_id = 0;
>                         return true;

I think this is fragile. What if the compiler produces two independent
paths in the program which read the skb pointer once?
Technically, the program is still reading the skb pointer once at runtime.
Then you will reset ref_obj_id to 0 when exploring one, and assign as
0 in the other one, causing errors.
ctx_arg_info appears to be global for the program.

I think the better way would be to check if ref_obj_id is still part
of the reference state.
If the ref_obj_id has already been dropped from reference_state, then
any loads should get ref_obj_id = 0.
That would happen when dropping or enqueueing the skb into qdisc,
which would (I presume) do release_reference_state(ref_obj_id).
Otherwise, all of them can share the same ref_obj_id. You won't have
to implement "can only read once" logic,
and when you enqueue stuff in the qdisc, all identical copies produced
from different load instructions will be invalidated.
Same ref_obj_id == unique ownership of the same object.
You can already have multiple copies through rX = rY, multiple ctx
loads of skb will produce a similar verifier state.

So, on entry, assign ctx_arg_info->ref_obj_id uniquely, then on each load:
if reference_state.find(ctx_arg_info->ref_obj_id) == true; then
info->ref_obj_id = ctx_arg_info->ref_obj_id; else info->ref_obj_id =
0;

Let me know if I missed something.

