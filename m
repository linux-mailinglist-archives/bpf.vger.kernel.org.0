Return-Path: <bpf+bounces-62720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041CFAFDBC7
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5365A16E793
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 23:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BF222D9E6;
	Tue,  8 Jul 2025 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbS14QhQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234BE218EB7
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 23:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016693; cv=none; b=Jc4b6QYea4qyJes8fKvH77WW8KBb8ARV4bqIVwrTKNxbLHj5/iKCXn9GWkf0krkfNNqLEgxhUbmRx6GKQkXvmRw64RiERgzcUwvOTcsI1sc55kjrTkL5++PFIGcKt0T8vnG05DsNQQiGmQBh9JpUnGSv/D5rtMf542gkf47TduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016693; c=relaxed/simple;
	bh=/AoemliFBUPjs26PJBOxt7CbZYbZimvvJd9g1i1Phk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kS62glQfJ8Vu2ZauMrEQ8gIvfYOBd3hIrWguthmia/uwpQBaI//P4ddv/bZvTOgcPQ02HIjBodQ7nndJVgXXslY1ynfO0M79vmMMuNPAI/23ALCd5uBhJkH9ncfiWyFr2ybwXu4MOIRFA0hs/wSAePHK7Nd/fXRsiR41C1vmTQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbS14QhQ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-710f39f5cb9so44482747b3.3
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 16:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752016691; x=1752621491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRB5Ldy0QXYpx/N6LWw6jSjPrjsPmkEJ22moqozh7zk=;
        b=MbS14QhQhvfnKS6Yen9oGXsd9tUj9H1Yv3v/Z6Mwh7AGSE/3Ywf3I9koDTFy2JChWG
         2hgcx4hmn1sPejljUXXKyHIRiBuvMz/+DBlf+E7737OAQJQBJeAMNVgcoRaAzD5CaTHH
         7+zl/zVfI4rVYbfovHkXj+tu01aAktl5P7qPdsSk3DPO4b3Giu6ndr5qEd/q4YUd3eHT
         Z/1IpLRG1CG90DFJWVPnWYmYTxaoAvTDG1ObAh7mSXep+dg7gSUK7Ua6lL0pjmAkq/Qs
         iXfE1e9+ZPFAVvV4II0uDTyMbIzUXoxeaQsUXaTIPZF8XM1/Eut5soANE+Dh9sav9pv9
         Hxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752016691; x=1752621491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRB5Ldy0QXYpx/N6LWw6jSjPrjsPmkEJ22moqozh7zk=;
        b=oJ9NRFdIQY7oGY/PQmkp/P6OVZ9JX94u8Pxtc4IFAVCayr/iA8OpFTFyvEN6iYDQDq
         Tu+xnl60bGDHsqsUpHIBps5uMyoRTNyJx3fBKg00Y5Br88E53CEi3IGXOq7yKXIyzOS8
         g2k9HgYD84pTc2eb7iigziuhaPbi186O8oLOU6mtd5Ki5Yu/nICk6qwsMWOBa5qbCTbY
         javFlH3wBu94JsDHexA/HdCZE+MqBZHrAwcAVy9jr9Wbwz0oeURmonLrnCQvMAhatI94
         hyNQscfI4MZsPu0BJF+fpKLJ8NHrcTMHJ0cD0bgZ1tZh/pmzBVrND5FFsKVboi7dMuVV
         qssg==
X-Gm-Message-State: AOJu0Yw5bEdkSE5/wZh466IhMz/6+eC9LCJVNFNDXSL239v7HNdI4nMU
	xgu6GWiC7WkrQyurPBpjMNEC3XgO+6JYYdYDgf25JSBQQARzv05ztIAzn2BcWx2Q5DjS57svxy3
	grwrmj3J9NhY0/atBmiJzctlmPP0pG10=
X-Gm-Gg: ASbGnctOelY9a+0Ebvd6M8Ny6/JNgWp40TLzlzD8niYSgc1aLd8m1Z9G8ruMtcR3Ioa
	4DGWYi/nTb1jXs46Yk77zsQhEk26xfqlzvbuc3VYr8+bV4+3y48AaqLqBeuCw5v5k6QuUo9/NTg
	wR1vVcaQPF0I5h0Tdri4NsyUHpmkAkT+pQxdDim63N5gQBCSZ3O4V6DI1irh8=
X-Google-Smtp-Source: AGHT+IH3LFNheKBe2akqh6dOQsNOEwqcoIiYa86vXmnPAbTkbR+hBJAbUlpg3u2Amgm/qF90010REK8vz0GVM1izryc=
X-Received: by 2002:a05:690c:450d:b0:715:1696:aafc with SMTP id
 00721157ae682-717b17d1848mr9030517b3.12.1752016690953; Tue, 08 Jul 2025
 16:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708220856.3059578-1-eddyz87@gmail.com>
In-Reply-To: <20250708220856.3059578-1-eddyz87@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 8 Jul 2025 16:17:58 -0700
X-Gm-Features: Ac12FXx4vzyMr-or-sY0CP3jY1Kfyjcza7ixnBFo6vbVB_tRUffqox2LK2nGXFc
Message-ID: <CAMB2axP8Xoz4xu1RxS4C7Jr0N1xyUywcCY4qM3bFdO477sntTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: remove enum64 case from
 __arg_untrusted test suite
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 3:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> The enum64 type used by verifier_global_ptr_args test case requires
> CONFIG_SCHED_CLASS_EXT. At the moment selftets do not depend on this
> option. There are just a few enum64 types in the kernel. Instead of
> tying selftests to implementation details of unrelated sub-systems,
> just remove enum64 test case. Simple enums are covered and that should
> be sufficient.

Can confirm that selftests now compile without the issue.

Tested-by: Amery Hung <ameryhung@gmail.com>

>
> Fixes: 68cca81fd57 ("selftests/bpf: tests for __arg_untrusted void * glob=
al func params")
> Reported-by: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/progs/verifier_global_ptr_args.c        | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c=
 b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
> index b346f669d159..181da86ba5f0 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
> @@ -275,11 +275,6 @@ __weak int subprog_enum_untrusted(enum bpf_attach_ty=
pe *p __arg_untrusted)
>         return *(int *)p;
>  }
>
> -__weak int subprog_enum64_untrusted(enum scx_public_consts *p __arg_untr=
usted)
> -{
> -       return *(int *)p;
> -}
> -
>  SEC("tp_btf/sys_enter")
>  __success
>  __log_level(2)
> @@ -306,10 +301,9 @@ int anything_to_untrusted_mem(void *ctx)
>         subprog_void_untrusted((void *)mem + off);
>         /* variable offset to untrusted mem (trusted) */
>         subprog_void_untrusted(bpf_get_current_task_btf() + off);
> -       /* variable offset to untrusted char/enum/enum64 (map) */
> +       /* variable offset to untrusted char/enum (map) */
>         subprog_char_untrusted(mem + off);
>         subprog_enum_untrusted((void *)mem + off);
> -       subprog_enum64_untrusted((void *)mem + off);
>         return 0;
>  }
>
> --
> 2.47.1
>

