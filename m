Return-Path: <bpf+bounces-64829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1352FB17614
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 20:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81893B22C5
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 18:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8422C1798;
	Thu, 31 Jul 2025 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="mL53blYd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4835C1E5B6A
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753986422; cv=none; b=ou+VS2AaocuAKaDA6kJcHodJfZSJEKh2K1hRLwI8pVsu+9xPov8sJUBgM9uK9/Os5eqc30cD0ZdBCxZIg2+m+0cLiV7tJxcZPNVi2ggzCYuxvgj15fkLQma8gYDf+FoZnzEqC6EbOMgIippLyB5Y9MZPDtPtlGlqpqO0Ybaf25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753986422; c=relaxed/simple;
	bh=GtQWjKEQkJYyltX8RlHLbxytlYr9I4EyRg78uDyghu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnr1b7b4LQqqXtCRjKC4fLZFSRPlhQvGKdU8F+piLpxHlyoU8FHdSmsCu6v4c0Py8l/yNcINfn3F2XWCHBGpANmh3dQHZXXJE96R40Srlkg2Snetzfddcva5sRzia2tibS6eKrBdbi9uSOgJt9GJCjF/7n6G/D4ndXljZpjLx/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=mL53blYd; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8e16c3c14bso2084922276.1
        for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 11:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1753986419; x=1754591219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rctzM9XOdIgWPvckF/hUJbH10KJkz+9ckzak4WdBlMM=;
        b=mL53blYd8RLZXGYKMYfa3zf2xWFllIcpCMt9gWnfumv6WJLGLXZxJqnsKIs0t19Dw2
         GwUr4eoY6eNHActDSyBnlgHNImBaXS9YPntdUjIcOs6sTL4/QY+f9qKynjjD8nq+6auG
         u3vIH6aN6mOYkKqDk9A72YGvZX366W8xMaHFM62M0ttIbPEXpOYprvmeOZixJ7bNzd2u
         6jLhEzIlfRmjOEUspM/rIC3uye5FL8lCOHFW8HPgyE9PQyu5ggy3/zu0PxhCgcZtMLIx
         /bmhdltoAk1AwIzQz2/y8UdSikK0T3aovF8vMVIPicSLh39CtHGzPZYDOjqxo0StKu5t
         e1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753986419; x=1754591219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rctzM9XOdIgWPvckF/hUJbH10KJkz+9ckzak4WdBlMM=;
        b=fCRoQ9zq8uN7b+pVXnPemlyo+IqRRt2LDxUeEdBV6YMe5aGk6K6kc6osXVwWlnfZ+E
         sH2jNu8cwBr5/yie5UKXSJvIQTwrVEfPl5PC/R+omEdQx3lIykKQom5XqvZ72Nm2u4UB
         Z8dk73cxaamfQhN67Bach6uFiez46pXfHBhPEZw7dY5udmTrHllUak3DRzvfYwee3oVm
         gdpNiEzmj8Jsdn7jTX6ulOheECYaa8NR8lMCsotIY/DJrXieyCFRO9MlnKzKxS1MyRyO
         DJ7HLWpDT1IPdR55wFZRumLBOmVMo9wklRvot9zWVyjrPJ9dQuuYoqGzaJW8yj/7fvx1
         svIQ==
X-Gm-Message-State: AOJu0YzzvMPLD85af/PwYjkU4hf1OJdzoYkEDa3StFlNP2BSlQbvFsTK
	Bcmv2CaizcYC72CCD2ya/gAjZEElm7viVTH+Si/ImAludLTf+CHo3E+OltxEXEMXXaCNREoxZae
	iE1iunHBINxSoIU6avqKL7+HZ95YZGLfDIW8ufFjzWQ==
X-Gm-Gg: ASbGncu5gk8hds2NKIXPap/Ei+GI1riFcyOLsyazSqzw29Lh0Ko3l60XvuHEUzxEY5W
	c34BrCUNYwnOcjKk2w0mS4NMPCMRe7RLH11U3Lt0rxpNWwDm1T/a+WLLHEGk0SnSRCL3GcEEo9q
	oS9zjCmMtcPpbFKhd0IyEjhIL0DaYjI7YAU7caRdA8pPbwCSVmLsRPiP+6kM6/tcKPVBuh+rM3m
	jaaYywvSYfiq78CAXc=
X-Google-Smtp-Source: AGHT+IFG6fDK9T6W8TpYKJCImcVlplfmZYZw/KMAbds0PdGq99TTcgxL3cQbYZfufBSMxlbkOTaWT04+xyaAhyuyrmY=
X-Received: by 2002:a05:690c:338d:b0:71a:1c70:c221 with SMTP id
 00721157ae682-71b5a823421mr35905197b3.15.1753986419093; Thu, 31 Jul 2025
 11:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730185903.3574598-1-ameryhung@gmail.com> <20250730185903.3574598-2-ameryhung@gmail.com>
In-Reply-To: <20250730185903.3574598-2-ameryhung@gmail.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Thu, 31 Jul 2025 14:26:47 -0400
X-Gm-Features: Ac12FXzEUt5j5FHYWw2iZkDfKdpLCJ23nZOiCCRLp6iQ9aXG30xgzvXB8Qi95KM
Message-ID: <CABFh=a7FGM--6M+TKZbx17MydEW5zTksrdfwWQ9dTHnrG=C3zQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/4] bpf: Allow syscall bpf programs to call
 non-recur helpers
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 2:59=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Allow syscall programs to call non-recur helpers too since syscall bpf
> programs runs in process context through bpf syscall, BPF_PROG_TEST_RUN,
> and cannot run recursively.
>
> bpf_task_storage_{get,set} have "_recur" versions that call trylock
> instead of taking the lock directly to avoid deadlock when called by
> bpf programs that run recursively. Currently, only bpf_lsm, bpf_iter,
> struct_ops without private stack are allow to call the non-recur helpers
> since they cannot be recursively called in another bpf program.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Re-adding the tags in the case this is the final version, as we
discussed off-list.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/linux/bpf_verifier.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 94defa405c85..c823f8efe3ed 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -962,6 +962,7 @@ static inline bool bpf_prog_check_recur(const struct =
bpf_prog *prog)
>         case BPF_PROG_TYPE_STRUCT_OPS:
>                 return prog->aux->jits_use_priv_stack;
>         case BPF_PROG_TYPE_LSM:
> +       case BPF_PROG_TYPE_SYSCALL:
>                 return false;
>         default:
>                 return true;
> --
> 2.47.3
>

