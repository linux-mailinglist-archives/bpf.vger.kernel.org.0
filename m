Return-Path: <bpf+bounces-13985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289577DF824
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57EB31C20F56
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28851DDCC;
	Thu,  2 Nov 2023 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+7Cj+9n"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D211DA52
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 16:58:14 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF52196
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 09:58:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9d2c54482fbso190683866b.2
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 09:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698944292; x=1699549092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPcRpgkJLKOqQjBSbWACjfbVfsa8e/UxzcPQ+su5uCE=;
        b=m+7Cj+9ng+WSE/W162q1dFn2wqAu79yHnDneztE8KocLVNOJnYyQUGsThUgwv8VtJ/
         mvH6vZPIhc80wpw36CQK7j0NCEJzwIIjokp4h5gWUYztqYW6vvXjZyTq/WYY5b37hM/v
         XoLAPiYDLanew2VJWdWUiLNpmb8DyeDK4URrin3YC2249RepMBDJhkHNRuxkUuRZzuX8
         0Qy0ILClD3qrwqRME1373d5HoUcjcbugHuV7XoGq5kEsaFqAgdzV77vMR7xnOQfkTvSq
         JRhNsYXWYkvgvIcqmoPqwzMT6R/4hJSB9mLCBpMdJkbehqdfUNchxNF+aK0ZfAO0O0mH
         FsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698944292; x=1699549092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPcRpgkJLKOqQjBSbWACjfbVfsa8e/UxzcPQ+su5uCE=;
        b=iu5zl/qrmoe/+ze1MTGMH3HPmHnCF0oEnxato1GZyGloXuImV0lFkEuUWfbSVjPp2p
         Bwu+PUjY9lIsVo4qxKS/vQv7pooJA9960H3065YkvjDpXm1/CRCL5uaUoq7OkE+nOtAD
         /SN8IK2wY6Zw+0EocQHeJiWCx/oy+MZC79FEm5OWsmQXYsOwOfFy61gALBcuLky5D/0M
         lC6m9wYsda5apMa42NSyzm0Pwqxylx0tbJV4lpOgY7od7G97IDcxXya3kMt9zWQDOvxR
         qExiOfMUi75o4QHvglDuvkvlmAmmHpMJgB5T2+x7AA6k3aqrsOMLinuX+TAXJfdKDFCg
         Pzgw==
X-Gm-Message-State: AOJu0YxpddtqyErNEZ/E/fgg2n8wXs9HEGIZSNmqtcUP1jofcDRW4GR3
	bdKCG6FRAGvJSdW8L/d0U6mk9qezbUMLPVHabzg=
X-Google-Smtp-Source: AGHT+IEOl8uRxKrYgDJKuvpCigDmSHVCjegPh7u1wjycTK+e5equPh7Upa8iuNdVIbj0RwvCSGko+7agxh66KK4Udas=
X-Received: by 2002:a17:907:6d06:b0:9b2:abb1:a4ab with SMTP id
 sa6-20020a1709076d0600b009b2abb1a4abmr4490629ejc.65.1698944291437; Thu, 02
 Nov 2023 09:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024235551.2769174-1-song@kernel.org> <20231024235551.2769174-3-song@kernel.org>
In-Reply-To: <20231024235551.2769174-3-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 09:58:00 -0700
Message-ID: <CAEf4BzaHm6zbPGAWVfLC9YAV8_w8A05nf7cWgQfd+uH4L7ZfmQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 2/9] bpf: Factor out helper check_reg_const_str()
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 4:56=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> ARG_PTR_TO_CONST_STR is used to specify constant string args for BPF
> helpers. The logic that verifies a reg is ARG_PTR_TO_CONST_STR is
> implemented in check_func_arg().
>
> As we introduce kfuncs with constant string args, it is necessary to
> do the same check for kfuncs (in check_kfunc_args). Factor out the logic
> for ARG_PTR_TO_CONST_STR to a new check_reg_const_str() so that it can be
> reused.
>
> check_func_arg() ensures check_reg_const_str() is only called with reg of
> type PTR_TO_MAP_VALUE. Add a redundent type check in check_reg_const_str(=
)
> to avoid misuse in the future. Other than this redundent check, there is
> no change in behavior.
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/bpf/verifier.c | 85 +++++++++++++++++++++++++------------------
>  1 file changed, 49 insertions(+), 36 deletions(-)
>

LGTM, I don't feel too strongly about that added WARN_ON_ONCE.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 857d76694517..238a8e08e781 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8571,6 +8571,54 @@ static enum bpf_dynptr_type dynptr_get_type(struct=
 bpf_verifier_env *env,
>         return state->stack[spi].spilled_ptr.dynptr.type;
>  }
>

[...]

