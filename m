Return-Path: <bpf+bounces-62420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDCAAF9A49
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABBA6E335F
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 18:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D291F418D;
	Fri,  4 Jul 2025 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeIyfFIr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59D22E3713
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751652250; cv=none; b=hHgNYenLkM/hI57NQjk4bvUKrO91NTVtWjn8nQ+a+87FWdFCp0iUgt68KzL27SoD6XX2zG6TQUQfYDYlA8x2siJAk0ZK10TnvWGOeCYWqKHec1xXDNxdhLezgnmrpLAYpR/DrQF13HJV4CVqSpp2pMXjJHvbqF/SAz+nLK8mQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751652250; c=relaxed/simple;
	bh=nrL5/9FRehqnC9Iape9Q3MlBD3yh9/hpBNqnRHqtM64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAX0U+Rd/ybLex06cD/cUOsQo+EHqQG1AnuCDJt1i06JYAXtiJhQqEDIEztHJu14Sv2q2Q0wPN530gcWN+Rpnt7PmV1SPqT/5kXvEp4pitPdt57LfupAyuIs7z/des4dm2CC9ceP9LjT890cNIpK9LA8Jaf0X/nzKH91c1DUOmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeIyfFIr; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ae0de1c378fso174170466b.3
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751652247; x=1752257047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sUQFziBynd3mQMzNcuByCzHuLdrPpCwL3hAlHbQGvdU=;
        b=EeIyfFIrwZ1aBATdWs9Tqp0o733FnIPjIQ8Xo8OWXtKP+EWZcsaaNh4nNn6x04U9s8
         QoH5eTj80P6poOafddImnv6OX60DV8pEgaBkxxGzAPEnbwgjushzAXxBWgHVA/R6R3Fy
         3IjKRZtsywbCgdJPkXknBe3a2Eo+UKrFV/GfBrAP1ZZN1by4hk3mCRUcweQPoVL3zA9W
         LBFYPf7d892FmYGrm2QkvmRTxPWywj62jOawaIaeeMex0GIApP1ABTcm1inykKSWCq4i
         oPcbgrMKT0GrzAa/APOBZc+O+eOEKFPvNorbPOBcjLF8iMPFajnkXE9+KZLYIq/tNL3I
         VpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751652247; x=1752257047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUQFziBynd3mQMzNcuByCzHuLdrPpCwL3hAlHbQGvdU=;
        b=ZZo5OdY9WuPSGAV+PuRId1JjHofL/7rPLJzZMB70gmTSxG1L3ccwEI4AFnuHpvjAQ8
         QWDxTXZjt/C4pNEhfxF0AfvWS34P7L9QeG7woSbnYNnWGW73k+POjjRdzhOjIVsOAmNw
         z/TuzcBEyh8l+I77QAyklrv1OA0/i8DuYUe//xu3bilu2fGcNHo1zBR2A9PzkZt2dpSa
         FjxQPnke6SfvYudF2qYIdxGiooTGZVE6rUzIQg9YzWcOD8c+CvafYn7lfX/OERjZVpfN
         mriHETdbNiPoJHszxL4xp4GmgXNuQ4lf+HNYgcMb2A8TgRSoft0mkjLr7UUN1en7QXA7
         ViWQ==
X-Gm-Message-State: AOJu0YxbgmCQ/5TAyf44ab8PpbF1IBEUuMRmaAVL7qwSvBDUDD7JNUEr
	UuES3MwlHrt3WwPAfGU+TgTyf3m7Ds3sJvQbKB8QNNticCGwGtmIiG/XJqqYBymPBzky4Ci3xGU
	nUi1utc4gQgIf0IzK1DUPh3RuAp9zcT4=
X-Gm-Gg: ASbGncsysEhpdOPNHZEXuVg9txMpKqsIQcAcqBc2wQbgdnkwGoyDLQdYkAAHB2IpUA/
	FwzTFfV630tvDfCpscIUA8ka2d4MWmKDK++gnNVZs3Fxke5m5zIOWJAG5voRQHddPGdAXmB9ATq
	jbElJBapyJoiwemUgFcyVjSdjc8YneEE5SkllmR2Bo+3oA8FFut3uFFQnqAeFQY7kK2GbI0qx0I
	48=
X-Google-Smtp-Source: AGHT+IGZQGwM+x4LHc7uRxLoGFwBvEr0ZB4wiMW1VmXM6x95293b5OBRCUS6NFZWO3awukhdeCLROPBTM3UdvvX49/A=
X-Received: by 2002:a17:907:60cb:b0:ad8:87a0:62aa with SMTP id
 a640c23a62f3a-ae3fbc826a9mr397487466b.27.1751652246545; Fri, 04 Jul 2025
 11:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702224209.3300396-1-eddyz87@gmail.com> <20250702224209.3300396-5-eddyz87@gmail.com>
In-Reply-To: <20250702224209.3300396-5-eddyz87@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 4 Jul 2025 20:03:30 +0200
X-Gm-Features: Ac12FXy1S9rd0ztFgpYzqX_Yz_sVMuLWyqL5NioJZPt9Fgnm8l2It0lgZbpbzxw
Message-ID: <CAP01T74AYNX5ARJ5YXryUyKvn5o0Dv0JBoq3CCKcD8rh==uKQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: attribute __arg_untrusted for global
 function parameters
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 00:42, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Add support for PTR_TO_BTF_ID | PTR_UNTRUSTED global function
> parameters. Anything is allowed to pass to such parameters, as these
> are read-only and probe read instructions would protect against
> invalid memory access.
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

Some comments below, but logic looks correct.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  kernel/bpf/btf.c      | 29 ++++++++++++++++++++++++-----
>  kernel/bpf/verifier.c |  7 +++++++
>  2 files changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index b3c8a95d38fb..28cb0a2a5402 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7646,11 +7646,12 @@ static int btf_get_ptr_to_btf_id(struct bpf_verifier_log *log, int arg_idx,
>  }
>
>  enum btf_arg_tag {
> -       ARG_TAG_CTX      = BIT_ULL(0),
> -       ARG_TAG_NONNULL  = BIT_ULL(1),
> -       ARG_TAG_TRUSTED  = BIT_ULL(2),
> -       ARG_TAG_NULLABLE = BIT_ULL(3),
> -       ARG_TAG_ARENA    = BIT_ULL(4),
> +       ARG_TAG_CTX       = BIT_ULL(0),
> +       ARG_TAG_NONNULL   = BIT_ULL(1),
> +       ARG_TAG_TRUSTED   = BIT_ULL(2),
> +       ARG_TAG_UNTRUSTED = BIT_ULL(3),
> +       ARG_TAG_NULLABLE  = BIT_ULL(4),
> +       ARG_TAG_ARENA     = BIT_ULL(5),
>  };
>
>  /* Process BTF of a function to produce high-level expectation of function
> @@ -7758,6 +7759,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>                                 tags |= ARG_TAG_CTX;
>                         } else if (strcmp(tag, "trusted") == 0) {
>                                 tags |= ARG_TAG_TRUSTED;
> +                       } else if (strcmp(tag, "untrusted") == 0) {
> +                               tags |= ARG_TAG_UNTRUSTED;
>                         } else if (strcmp(tag, "nonnull") == 0) {
>                                 tags |= ARG_TAG_NONNULL;
>                         } else if (strcmp(tag, "nullable") == 0) {
> @@ -7818,6 +7821,22 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>                         sub->args[i].btf_id = kern_type_id;
>                         continue;
>                 }
> +               if (tags & ARG_TAG_UNTRUSTED) {
> +                       int kern_type_id;
> +
> +                       if (tags & ~ARG_TAG_UNTRUSTED) {
> +                               bpf_log(log, "arg#%d untrusted cannot be combined with any other tags\n", i);
> +                               return -EINVAL;
> +                       }
> +
> +                       kern_type_id = btf_get_ptr_to_btf_id(log, i, btf, t);

So while this makes sense for trusted, I think for untrusted, we
should allow types in program BTF as well.
This is one of the things I think lacks in bpf_rdonly_cast as well, to
be able to cast to types in program BTF.
Say you want to reinterpret some kernel memory into your own type and
access it using a struct in the program which is a different type.
I think it makes sense to make this work.

When I needed it in the past I just added a local new
bpf_rdonly_cast_local variant that uses prog->btf for btf_id and moved
on.

Supporting bpf_core_cast for both prog BTF and kernel BTF types is not
trivial because we cannot disambiguate local vs kernel types.
IIRC module BTF types probably don't work either but that's a different story.


> +                       if (kern_type_id < 0)
> +                               return kern_type_id;
> +
> +                       sub->args[i].arg_type = ARG_PTR_TO_BTF_ID | PTR_UNTRUSTED;
> +                       sub->args[i].btf_id = kern_type_id;
> +                       continue;
> +               }
>                 if (tags & ARG_TAG_ARENA) {
>                         if (tags & ~ARG_TAG_ARENA) {
>                                 bpf_log(log, "arg#%d arena cannot be combined with any other tags\n", i);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index cd2344e50db8..dfb5a2f8e58f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10436,6 +10436,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
>                                 bpf_log(log, "R%d is not a scalar\n", regno);
>                                 return -EINVAL;
>                         }
> +               } else if (arg->arg_type & PTR_UNTRUSTED) {
> +                       /*
> +                        * Anything is allowed for untrusted arguments, as these are
> +                        * read-only and probe read instructions would protect against
> +                        * invalid memory access.
> +                        */
> +                       continue;
>                 } else if (arg->arg_type == ARG_PTR_TO_CTX) {
>                         ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
>                         if (ret < 0)
> --
> 2.47.1
>
>

