Return-Path: <bpf+bounces-65474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8F0B23C03
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170FA1AA3828
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8852253FE;
	Tue, 12 Aug 2025 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTLauqxA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451CE2F0661
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 22:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755039084; cv=none; b=H/8RU3UItP/ALy2OpNAphMscJaZxUbkTTaAe7A4DYvh9jeVtCuHQpS2mD6EgPpcIyqznZDGNzSAUdxQjrNSj0HDM1LWsJRigUZsSR0sBEt7JJt4zdOQaNVRBAuvNTq3N1Q/KVIe+dGXuBK3k5EPAP7A8rxKyRVRd66hd0sQTaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755039084; c=relaxed/simple;
	bh=nIhICFYZV96YJLAfePFwkF0LL3nTncggnJ3qzr6Yn8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auWXE9+Na6wPJ3nHWQDFdEzyQdEKtT7EyWDXyTXhKWBkx1fPm2J4kjgkH8Oa93JF0qPTR/2CoN/+C+ElUXsuU3yHLtRMJ3sb2lyZFF0t26Mft0EjzwHFW99MmhRhrPfL5nWWELJGPsFRFGfdIT54LPowsxkGyiVlTqgpvdZTtNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTLauqxA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31ee880f7d2so6785237a91.0
        for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 15:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755039082; x=1755643882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rscLN99lZI2H2ORwai3qyRzSkpvZJiFeiFnTC0prHoo=;
        b=lTLauqxA17rm3FC5+pBsLhKreBGiNfL3byolegNDuFMozkK9YUp44q3yl02+LEEzeY
         19U/pZz99P+6Q9IRptMsriBGhGdfFmTY3xeXvPv4Jv7qdd4g1bVwml6soHDjLa9iPKwd
         1kxvv2FMerNEFFlOWY74XJniJD2TJwRaoJttlRDOlMzUP5+IaU4Rl//OnpsHFDwghYT5
         MHkO3y295rffNtIH6c93Qtdn7yXgLOuxA2Wfw/24jwobT+NKGU7fEF30fIXeTp6LsSt5
         T+kx2JTea2vXd0FOQZzsPQHvNZqOeMm85seNOJoxwzxwV7Kb/xHOYfwWnDKWklsdjOvr
         H3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755039082; x=1755643882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rscLN99lZI2H2ORwai3qyRzSkpvZJiFeiFnTC0prHoo=;
        b=uJfvEgp5EIPCoeXMQs0ArgAO0r+u9q6BuDNsmxPrge35Gaca4YQq6ygxmzoVhz/tPo
         76kmtEFUfyEnJrIX3TJHT1JlZSyfrZ/HJl4kXFLCPyJXKIsmR4vJ/uNlStpyWBmwCU6Y
         TnKqddP9YQJym2tiKbeiKs04sWdqB7++2Zn/GCVe9vTz3qOYmUQ8lgdLcojIm0Y3jZj4
         BTg2Y9DD2JHx02a76R8eY5HimDlfarbt+rqAoBRfT8kWPakahhOSRrVXIPD8VN4meM0A
         ffU7Z4XoQ/nsOqBSbfvRKsSriI2JvwVxl8gr4xao7UDR5yLnpqeyKhUmdoKh+qQIrBm8
         oyyg==
X-Gm-Message-State: AOJu0YxjKT4d54REiHMT/9zMj4XkoOdY4nXDD1t13NCD6ouQtEQ2avfP
	sWBEZ2AIFkB3xqxzrgCKgZdUYVGz+8Yub+R8unmxVqIPj/rIjrEjEDHhwTINX9FOMkQiWLnUhRl
	7Bqc9qs4PqafJrHMwouvgWEhHwNl8Wi+ubA==
X-Gm-Gg: ASbGncvQK2SeQ3qSa+k8BrwU8A1iIH7QWTgHHC3/bmTLqGLanBUrEYfa7AVFw+IAuQO
	cTusqnV7mN/mi6UGiawalsfBXsVzmMfq9sujMcUs9P1942ai4GbsQ4vN4PSTjwKJOm4JjcHlpmc
	LHIwRuEJ6/0t5KywZm5BNL1zn2C6XnUf6MH+xS/MLxWI9A/q1wUjPJhPU7fGT2KuDD3V/PkCre3
	4qkQ2W6/rNCNMg2gAIkg6k=
X-Google-Smtp-Source: AGHT+IHIK7AMq3HssPrvAmr7hGObGaX3wvlma7a6r6o4uHaEjsCEdPq5mpQkvR8cltWhk5p2icEMCHekqiWXzSPuBRE=
X-Received: by 2002:a17:90a:d650:b0:31f:3c3:947c with SMTP id
 98e67ed59e1d1-321d0d8b1c6mr1053628a91.10.1755039082321; Tue, 12 Aug 2025
 15:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJo9THBrzo8jFXsh@mail.gmail.com>
In-Reply-To: <aJo9THBrzo8jFXsh@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Aug 2025 15:51:06 -0700
X-Gm-Features: Ac12FXyuRgu5g7rkf8YBr4oWvyVqc7uJIn26BgwRs3xnDFuF39da87BjejtMg8I
Message-ID: <CAEf4BzbMGmXn54sR1z1OX-am3gAsZy8LAwqeEg+iotkvK2bB1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Tidy verifier bug message
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 11:58=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail=
.com> wrote:
>
> Yonghong noticed that error messages for potential verifier bugs often
> have a '(1)' at the end. This is happening because verifier_bug_if(cond,
> env, fmt, args...) prints "(" #cond ")\n" as part of the message and
> verifier_bug() is defined as:
>
>   #define verifier_bug(env, fmt, args...) verifier_bug_if(1, env, fmt, ##=
args)
>
> Hence, verifier_bug() always ends up displaying '(1)'. This small patch
> fixes it by having verifier_bug_if conditionally call verifier_bug
> instead of the other way around.
>
> Fixes: 1cb0f56d9618 ("bpf: WARN_ONCE on verifier bugs")
> Reported-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>  include/linux/bpf_verifier.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c823f8efe3ed..d38b5ac6a191 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -876,12 +876,15 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifi=
er_env *env,
>         ({                                                               =
                       \
>                 bool __cond =3D (cond);                                  =
                         \
>                 if (unlikely(__cond)) {                                  =
                       \
> -                       BPF_WARN_ONCE(1, "verifier bug: " fmt "(" #cond "=
)\n", ##args);         \
> -                       bpf_log(&env->log, "verifier bug: " fmt "(" #cond=
 ")\n", ##args);       \
> +                       verifier_bug(env, fmt " (" #cond ")", ##args);   =
                       \
>                 }                                                        =
                       \

dropped now unnecessary {}

>                 (__cond);                                                =
                       \
>         })
> -#define verifier_bug(env, fmt, args...) verifier_bug_if(1, env, fmt, ##a=
rgs)
> +#define verifier_bug(env, fmt, args...)                                 =
       \
> +       ({                                                              \
> +               BPF_WARN_ONCE(1, "verifier bug: " fmt "\n", ##args);    \
> +               bpf_log(&env->log, "verifier bug: " fmt "\n", ##args);  \
> +       })

shifted those ending \ to align with verifier_buf_if's ones.

Applied to bpf-next, thanks.


>
>  static inline struct bpf_func_state *cur_func(struct bpf_verifier_env *e=
nv)
>  {
> --
> 2.43.0
>

