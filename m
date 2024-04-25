Return-Path: <bpf+bounces-27865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3E18B2D8F
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 01:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E39FB21150
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 23:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8026D15666A;
	Thu, 25 Apr 2024 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvHPIs9e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BE0155728
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714087494; cv=none; b=bP5gCIKnrsvia1cfW6r0hSQmVu7L4hrVW7IyrsgN2YUQR3V4A/MJIRmp73Kz5IBUxDfpf/OU4IigVkyJfWY4SRDnMhSbIcWxIbMfjsNGxDMKenu5ZFEyiVKB7iyiuCnoGWGogkBqPaKalueMQ/xqgSEvv+3hJ1KQeCZq8ToiNlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714087494; c=relaxed/simple;
	bh=nvi6nzIJbTw/0x0NBU04Qo6CsucLtWUuMuHYfcfyvEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnkRs4ypBnMjSPSjEB9/1KVGZVp9hgKUvU+reswtPruw7Lf2+tcMmWi6guHVjFvyu+Jl4te+b9DY2+Fo/X3EAZltrLH6/Rvk4N7VWm8STVB6sKOrdH/FdnqXl5qVWRBugPEbuf5ZLxy3XzFoLvH9x9Xfs4w0nt7U1Mxg40n1Gps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvHPIs9e; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a68a2b3747so1167577a91.3
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 16:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714087492; x=1714692292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdcumHcP39bmvf4xGHLNRJvmPGlFPbsKehcAvOULNzE=;
        b=gvHPIs9epNThEqKyLKSrOOOhWjGE41G7CCpfLJhVELypJKmtrwpPdpN/xSuGXd7gFW
         Ww1vptDXC8XXW0OVx+nQr3sHiVCdYI/YXu792knahBTJ3JF/0BOLYzVkz/P5V4s2RU8p
         bzfIupXWawRRnuNmRNSFxnsutCRLL81l4mS2xFL9XiHcbsGQuA8bd3DbcRKIUU8mN4V7
         JJKkuRxWFchJU8oFSKahxbdCyA7Z0w2GDMi8o3PShtu98C3oIJzGTFhOH/1ha3BQS9vB
         6lULHNHKJ8OuULOHRN5NITlpGm+6AXLe49dtSM7JuUw27wZw8ivEJgSkL9cCl9qIclDJ
         1Lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714087492; x=1714692292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdcumHcP39bmvf4xGHLNRJvmPGlFPbsKehcAvOULNzE=;
        b=h71qsARcb68wzH8+7yIgLWrAenJdNKgoX+xh+AavOV/0XSzbz4hI9eHVpH+PGzaT2Y
         L9i1qhR8BGaOqY2VgFXFATa9vl6UAunl9n6cHkII6Ceen5SaOYnVLpaOdLKBMt2PVb5A
         lsgHh1qZ4metjR87BR4hi8YitSgc7gaBFcLfheIBLfdM40KVUIdkFkOjj68pJNecxb1R
         BC5J4SJoxTV4fvGfIAuAbd/dTctgqu6twOp8Nh3EWZvoTANFE+/+VktSpkuVb31hugfC
         05DcsX24pD7YK/Bmpyh00769oySsoqGWUdyg0yUKeinF+CvlbKi1lmY7vl9qY0bnbH8t
         AZow==
X-Gm-Message-State: AOJu0YylOWeWM9lgbwcxINKxO3jOetRAROBjykn8vZVQama/2I70xgZ2
	PW5TJd9t7W4X6KsxV3l0llS0frozmZ8RDPH2OtYEXFQjg/8YdVf7cRQ7DRs0patjNmyw7TFosgf
	TBiqqLzctKrk38uO56Mltj6R8MyT2YjCd
X-Google-Smtp-Source: AGHT+IEYN7UDP5fBHqj3P+bf+OHTqfqyriBKPCI7LghQC371IbM5icRurW98r/2qGO/RdR6CKorjZ1t93wXfK+8IU3w=
X-Received: by 2002:a17:90b:f18:b0:2ad:dd1c:6dc2 with SMTP id
 br24-20020a17090b0f1800b002addd1c6dc2mr1042394pjb.29.1714087491966; Thu, 25
 Apr 2024 16:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424224053.471771-1-cupertino.miranda@oracle.com> <20240424224053.471771-6-cupertino.miranda@oracle.com>
In-Reply-To: <20240424224053.471771-6-cupertino.miranda@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Apr 2024 16:24:40 -0700
Message-ID: <CAEf4BzY5p0k1ywRdUXvkyxazZy8u+x-5FCmbUWcMuF3WCG9+ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/6] bpf/verifier: relax MUL range computation check
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, 
	Jose Marchesi <jose.marchesi@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 3:41=E2=80=AFPM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> MUL instruction required that src_reg would be a known value (i.e.
> src_reg would be a const value). The condition in this case can be
> relaxed, since the range computation algorithm used in current code
> already supports a proper range computation for any valid range value on
> its operands.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> ---
>  kernel/bpf/verifier.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6f956c0936d0..760193dac85e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13749,12 +13749,8 @@ static bool is_safe_to_compute_dst_reg_range(str=
uct bpf_insn *insn,
>         case BPF_AND:
>         case BPF_XOR:
>         case BPF_OR:
> -               return true;
> -
> -       /* Compute range for the following only if the src_reg is known.
> -        */
>         case BPF_MUL:
> -               return src_known;
> +               return true;
>

scalar_min_max_mul() and scalar32_min_max_mul() could be implemented
just a touch smarter without becoming non-obvious. E.g., we
pessimistically limit both arguments to U16_MAX, but really we care
about their multiplication not overflowing U32_MAX, which can be
checked very easily (just multiply two max values and check they are
still < U32_MAX; similar checks could be done for 64-bit case). All
this is still trivially provable because we restrict arguments to be
non-negative.

So please consider some follow ups, if you are interested in improving
these parts of verifier.

But this change itself looks good to me:

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>         /* Shift operators range is only computable if shift dimension op=
erand
>          * is known. Also, shifts greater than 31 or 63 are undefined. Th=
is
> --
> 2.39.2
>
>

