Return-Path: <bpf+bounces-44894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7104A9C9680
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 01:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFFC283ADB
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36CC190067;
	Fri, 15 Nov 2024 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrjcIdjJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68733FE
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731628828; cv=none; b=CFrwwpu8K23u9YZ3RJ/EJhdilTi/Ic7FCuN2QyLUxn+kY6coA4cIXihFeEMuMXL3ZPH9fRVH/3NG+u7gLXcTRSO0tHSNDaz014ACnfvf1gbJEnfT56nAyhAaDlwXFTi052sq8WJA/IVbiMSiyg/y380FBNrBEhqcgyFKqvezhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731628828; c=relaxed/simple;
	bh=ixe4OJVrNlmtP6X2rh1iMz9JE4Fy7XD2uZvxSgKHfVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnpDXhiy3+pPCR2M81JIWGVKdEuQS4/HO+sG0LR3ugiczqPY9hQjJvhYgq5D9yC3GhvVNkxkmkZ9Nt+cc8UqtHTkAwOSbQrSLth+er1gzZUdtN1zic88bjnu5lHAQkOkAvjO/tjcTfVl7G0YG4YYWvMyAwqUout5txQkV7OKJgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrjcIdjJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-720c286bcd6so1075746b3a.3
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 16:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731628826; x=1732233626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRlyEsHN8yXxEjc7jBIGiNQI68VqBDkZorP1qMsqZQM=;
        b=RrjcIdjJmwEgbi5OjHeaKT2HJMwTz3MGJaMDqkmXzdPDIDmDRvPM0MlUSC8JyVOU6H
         PLnDZXj+qw9SisBZJhy7AWQvNlidnSFZe3eICaDkH/+upNogsJ9vKAyRY8TQ9syUXf+N
         kjzEOR7HkUOqY2ZyOnwlFzBdcNcfFIr46MGj6//rLey9ipRgS1cMbDOiwBlbj/ehkf1M
         AE4QHAmuUIutS6SJcFfg2trot0dfeeA7pJCkq9H1JTK5NHsGxXC0LwXbmDLEoxS5zqcw
         CWN50xlMATwOREVYfHsObDC/3xVSL721tCmMKd7Z2JHbphcyHabfYZ5DF0RUoRNQuGT4
         iPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731628826; x=1732233626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRlyEsHN8yXxEjc7jBIGiNQI68VqBDkZorP1qMsqZQM=;
        b=aGlKLBymXgIwWKM6V7w+62yL6+EVYVqMGZemmOA99X0bVoNkR9lXo/mJ/PpSgezJF6
         OgbNYvl7i8yr96ahRGQo7VEBNRR6M+g6vK8KTUCFUTg4FrkoBld8AW9S1QvXxqwm92od
         5idpdga+nMgKXKXUNJHCvsUGGLTT2QYZe8+gIBZ/Gt4qZ+pmtwlk7YZ05lRjvCsplsDR
         YU2BAvw+e2t/jFkoBsJ8RQOPRwc57jhpH9/sz7WM9NDWDj4Kq+hRVRWhbClq1N5vCo8O
         v912bPVsBJ6Rx4mrHv4OhhDtZghHSoYWR5+ry+yqVTKY+d4QFMxlfy7VBT5YCMGRUP8a
         bKaA==
X-Forwarded-Encrypted: i=1; AJvYcCWGNU6uyrgNvAmBeOYn/NCRUNYthyJ/hvazt8BwUOr2f2NW6TBO6uuSQ9rKvtovaJQ5OXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1gyofvDNKS4os4ApFOIYFHh6VWEida5CfWUxu8L80ica9N+qc
	Yn3IX8xBM7O9CDlaumzA6Fbs5MaxbmsA+RlttOCjKu2zC3ZWHiiJhVNwGo3TjY23+U8q/6Cia10
	vGMgHmCdYJej4sfm2I0S7+dLUnQjHyA==
X-Google-Smtp-Source: AGHT+IEf1P0aREmTFPXJ3cau0yMSmpPQXnZC8XDtbGU3ItmXDUUZCvrutr+HgA+b2bt78F5gkMX/RdSwlHJttaRa6+0=
X-Received: by 2002:a17:90b:4a0f:b0:2e2:c835:bc31 with SMTP id
 98e67ed59e1d1-2ea154cc1d2mr1054259a91.7.1731628826350; Thu, 14 Nov 2024
 16:00:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107214736.347630-1-tao.lyu@epfl.ch> <20241107214736.347630-2-tao.lyu@epfl.ch>
In-Reply-To: <20241107214736.347630-2-tao.lyu@epfl.ch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Nov 2024 16:00:14 -0800
Message-ID: <CAEf4BzaE+iMJJbMyGifOvZwaxm-W8s45cZToteWXENcNSy_beA@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Check if iter args are stack pointers
To: Tao Lyu <tao.lyu@epfl.ch>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, song@kernel.org, 
	yonghong.song@linux.dev, haoluo@google.com, martin.lau@linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 1:48=E2=80=AFPM Tao Lyu <tao.lyu@epfl.ch> wrote:
>
> The verifier misses the type checking on iter arguments,
> so any pointer types (e.g., map value pointers) can be passed
> as iter arguments.
>
> We fix this issue by adding a type check to ensure the passed
> iter arguments are in the type of PTR_TO_STACK.
>
> Fixes: 06accc8779c1 ("bpf: add support for open-coded iterator loops")
> Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
> ---
>  kernel/bpf/verifier.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 797cf3ed32e0..98afdcecefbc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12234,6 +12234,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>                                         return -EINVAL;
>                                 }
>                         }
> +                       /* Ensure the iter arg is a stack pointer */
> +                       if (reg->type !=3D PTR_TO_STACK) {
> +                               verbose(env, "arg#%d expected pointer to =
the iterator\n", i);
> +                               return -EINVAL;
> +                       }

For process_dynptr_func() we do PTR_TO_STACK check inside the
processing function, maybe let's move this check there for consistency
and to minimize a chance of forgetting to do this check in some new
place from which process_iter_arg() might be called?


And while you are at it, maybe fix process_dynptr_func() to report
zero-based argument number, which seems to be what we do for other
cases? Right now we'll print arg#1 for first argument inside
process_dynptr_func().

pw-bot: cr



>                         ret =3D process_iter_arg(env, regno, insn_idx, me=
ta);
>                         if (ret < 0)
>                                 return ret;
> --
> 2.34.1
>

