Return-Path: <bpf+bounces-45020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 677299D0065
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 19:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30FC1F22E24
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 18:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C58F19048F;
	Sat, 16 Nov 2024 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMdPJ1K/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141F118EFD4
	for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731780746; cv=none; b=B6qMVZQj7+xuzPJ4cPPmXH8H3emuPWYqZjq9Uqovw8HIODLKDlgiJqpwTYbpP9IGNJSN8jnd0f9i0+6fdCscMX2ftKQGQuf2YwwlmKPXVxqmamz/6zb2TE9sVfRhmWGmNeAKYulk/5KyEXMN1ODX+H2CvKhYy+2EFTdNQRZXDHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731780746; c=relaxed/simple;
	bh=CGIRTC1oWZn3gu/hgW1koUeHKf5SKhrY3GCheVD8Rf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/nzXW/o2QMBoCPFRnAHAzhXDU+kWpoh/zWzJWQKaL4hDCDqj95eULpLLEALoGPwg7bgUjKHV4I7wwMZgzido0X0607GdGR9Oc/6LNm8lElIeJs/cFcznIpeyMA4AF9Q1zWs9KfdDlM/my9ujnBaZWOOe3vOMpXap9stvOoajoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMdPJ1K/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3822b77da55so800332f8f.1
        for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 10:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731780743; x=1732385543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2/KifS3X5X1zmvrnJii/e9K20OL3Gq8ADl2mExOQuU=;
        b=iMdPJ1K/M1fo2nuo1fMDy/gWOB2wDPPOtgrOeEp+VTGvREnt1dYfCtKYfsPZrNGfHi
         V49RbfrNu9f0u7XjdDx6xE/uZKlg449d1ADI+FSGaIwUituWCUDKsjle/lJhClq9AqeL
         WyAMGsnHdBFc161kaY5ME9XNjBdoetFzYksEjo9OLrTuiGNXR5K+59S1/CgMeU3+lSe2
         JwnPh8GL8XYVgY0BbgXaa04pgd3nhKCs8XkrkROz3G56o/054Sm9wn+9CMUy7pD4VZ7b
         PThrqUQjvE1nuRiW3IeBDHD6tUJC7szg5yXubWryxuGAW/Q2jF9uUS2X9ACjRSsOtOYA
         sNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731780743; x=1732385543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2/KifS3X5X1zmvrnJii/e9K20OL3Gq8ADl2mExOQuU=;
        b=LudZDW4Rq3cZZlKQPu1d1SWIonE+69vtsrtbJyk7s+tRTPip320ieX4fXOewGG/eLO
         p3hgaty88/3+hs1Ue/TlbrXP5XY9fa/95cjSY/Th7ER4qPkOl5f9T1GTK8FZptuke3Gt
         ZMgZBKz4wi79p63ahsTXPDng7LL6CuvaC4muarwu0UMpNAJjIC0gTN41/ZJqm8a7JK8t
         TnyzbHz2lP57BqU0LLIEU2yesCj7lyJmj4QA1LGTt+eQkN0C+ddG/MbuH5WlRX1O+TzJ
         81HkO2fpTR8VpmvtLuOPeorNutDa/3yMeQF+Njh43jy5hM8zKuNYNU4PEe+dCuvNy/V5
         2R6w==
X-Gm-Message-State: AOJu0YyqO2zY4vefMlT27+6BPLecP/TAS1hhUB127XOh7RQT2erCqc1R
	NcX2m0whC4V1WDEA+aZ2iEFKCXaAfApHptEKz6AXTUSrwJxwrxfu3JGPFSw6jtFfo4LHR2c43Lq
	0F/h2MfOU87Jptynfa5IzWhmuZdYu+Q==
X-Google-Smtp-Source: AGHT+IHm2yq1FqwxOFieDGO9S+/tYQgnVmieYaw7Gms/KRAlCnSv0EFl7tPNtYQ/BPLtUaSUjZJ9y7W+i7h6dTKU6kA=
X-Received: by 2002:a5d:5f43:0:b0:37d:5251:e5ad with SMTP id
 ffacd0b85a97d-38213fe93femr9751634f8f.2.1731780743075; Sat, 16 Nov 2024
 10:12:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104200452.2651529-1-minipli@grsecurity.net> <20241104200452.2651529-4-minipli@grsecurity.net>
In-Reply-To: <20241104200452.2651529-4-minipli@grsecurity.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 16 Nov 2024 10:12:11 -0800
Message-ID: <CAADnVQLdUnUfzDxAJc_0RR_8pSgF+8SLANv23c=EBHq8VU-qVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf/tests: Make staggered jump tests
 constant blinding compatible
To: Mathias Krause <minipli@grsecurity.net>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Johan Almbladh <johan.almbladh@anyfinetworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 12:05=E2=80=AFPM Mathias Krause <minipli@grsecurity.=
net> wrote:
>
> The "staggered jumps" tests currently fail with constant blinding
> enabled as the increased program size makes jump offsets overflow.
>
> Fix that by decreasing the number of jumps depending on the expected
> size increase caused by blinding the program.
>
> As the test for JIT blinding makes use of bpf_jit_blinding_enabled(NULL)
> and test_bpf.ko is a kernel modules, 'bpf_token_capable' and
> 'bpf_jit_harden' need to be exported.
>
> Fixes: a7d2e752e520 ("bpf/tests: Add staggered JMP and JMP32 tests")
> Cc: Johan Almbladh <johan.almbladh@anyfinetworks.com>
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> ---
>  kernel/bpf/core.c  |  3 +++
>  kernel/bpf/token.c |  3 +++
>  lib/test_bpf.c     | 19 +++++++++++++++++--
>  3 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 233ea78f8f1b..fe7eada54d4b 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -570,6 +570,9 @@ int bpf_jit_kallsyms __read_mostly =3D IS_BUILTIN(CON=
FIG_BPF_JIT_DEFAULT_ON);
>  int bpf_jit_harden   __read_mostly;
>  long bpf_jit_limit   __read_mostly;
>  long bpf_jit_limit_max __read_mostly;
> +#if IS_MODULE(CONFIG_TEST_BPF)
> +EXPORT_SYMBOL_GPL(bpf_jit_harden);
> +#endif
>
>  static void
>  bpf_prog_ksym_set_addr(struct bpf_prog *prog)
> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> index dcbec1a0dfb3..aed98a958c73 100644
> --- a/kernel/bpf/token.c
> +++ b/kernel/bpf/token.c
> @@ -26,6 +26,9 @@ bool bpf_token_capable(const struct bpf_token *token, i=
nt cap)
>                 return false;
>         return true;
>  }
> +#if IS_MODULE(CONFIG_TEST_BPF)
> +EXPORT_SYMBOL_GPL(bpf_token_capable);
> +#endif

I don't like the extra exports and hack in patch 2
just to test jit blinding.

In general lib/test_bpf is there for testing JITs
path that are impossible to do with normal asm/c from selftests.

I don't think jit blinding false into this category.
The current code coverage is good enough.

pw-bot: cr

>  void bpf_token_inc(struct bpf_token *token)
>  {
> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> index c1140bab280d..3469631c0aba 100644
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c
> @@ -2700,10 +2700,25 @@ static int __bpf_fill_staggered_jumps(struct bpf_=
test *self,
>                                       u64 r1, u64 r2)
>  {
>         int size =3D self->test[0].result - 1;
> -       int len =3D 4 + 3 * (size + 1);
>         struct bpf_insn *insns;
> -       int off, ind;
> +       int len, off, ind;
>
> +       /* Constant blinding triples the size of each instruction making =
use
> +        * of immediate values. Tweak the test to not overflow jump offse=
ts.
> +        */
> +       if (bpf_jit_blinding_enabled(NULL)) {
> +               int bloat_factor =3D 2 * 3;
> +
> +               if (BPF_SRC(jmp->code) =3D=3D BPF_K)
> +                       bloat_factor +=3D 3;
> +
> +               size /=3D bloat_factor;
> +               size &=3D ~1;
> +
> +               self->test[0].result =3D size + 1;
> +       }
> +
> +       len =3D 4 + 3 * (size + 1);
>         insns =3D kmalloc_array(len, sizeof(*insns), GFP_KERNEL);
>         if (!insns)
>                 return -ENOMEM;
> --
> 2.30.2
>

