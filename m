Return-Path: <bpf+bounces-62307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37111AF7D53
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 18:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0845582CED
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 16:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAA6236A70;
	Thu,  3 Jul 2025 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="x0t8sl77"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697071AF0C1
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558725; cv=none; b=S77UOUMaCQ76ebCMnPKG7ChJyMjMBaGkAd5XoqzKaxa2x6iK5d6JhOsqG/WLb3K7s4rkiUOkjMJUzINO2Gw768A9npLuDoSXYBKRAVd8PrNiQosNAjsBYopKxJaya+lPVsBw31t1dBJdEIAcWztfElSQcjHDbX3WxIqYner3Djg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558725; c=relaxed/simple;
	bh=vHx1o5RhH6LRzCVKg+3Cuo4hjm+9NRT3R8a3a/haBC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VapLYj/PT+uqnoUaH6LoexfnPIpGlJDcClA3dzLkUN/UmND+N03BfVCCtlup17k8pGEEW0GHrT4mHiqCQUXanwjqw9eY1QI6AGKfm2eW7vwmvDGTfXadz5Vt81vc9bleAjfwi4MURver+fqo9rhYG4tvZBIcT6aqfB/DCCLyFrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=x0t8sl77; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e1d8c2dc2so58510257b3.3
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1751558722; x=1752163522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPqtuahNrv69D20FaiWaHuCBWUzgU+KM0mTLCb+Uth4=;
        b=x0t8sl77zzkc2EDPUdw00Y0O0QGTQahdVh1c8GyM7I5pnFYeoXDzVMLKB6L/xuabAa
         1rMlNxK8snbiTPztSBVnvevizn+87Wy6Lbw2ohM/uiKtG/vSG7xhbhdj+kg+41grSskd
         1eeoOFotJkRCeP5p/RIRWTtb0S6k4rDOx3DE23A3Famh0BGx02cdK3xz4HQfQjevqdbk
         iQ/GlM7dEnT37028uyu98LGrBVsE9hI3ye5ySkUuQ6wDE0nYoCv/Ptu1jQjYmIiMGOFz
         APMF7CxuKXkyej3cpqaJr9cSVOh0LV3scvMpPlGMCA91Y6Cz47CqRa2VG4LhfHyj/oqc
         Jo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751558722; x=1752163522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPqtuahNrv69D20FaiWaHuCBWUzgU+KM0mTLCb+Uth4=;
        b=UcDb0KiJB1cArXc+koXQhe7p98GwFnNps5FM+Kd5ccCyfP6GLYEKheGgzX+P5AFZTT
         6SBfuMKCJy5zA8mHmcysr2jvfwjQP9Z/O9l+4suSYVDI07uq+MY5gGY+89v4CJ/KcrGP
         AIkRDfobLEta9goTmBu9xrNb9OtSEvalC09N5JvkJP/OF3gJQfOy2czuFHZ9Q6sJZgC/
         FtOU2SOWscGgeAGXe8Y6AWaOPu2JfoPF0GWUd5Yugjj0btOHSaFNQUNynKEsBCEwHm9K
         oFe3EFj8DDP0xcyS5EKNl2SZaYLx+iRiHD9p6AJaJe3Owf8frvTLkdRMaRADJ5R1qEuD
         QbBg==
X-Gm-Message-State: AOJu0YxnR94FR3KhYJ7QK9WjUIdufRxV+gTAY6y+l0NS2STavdB0EQ9V
	nt4MRL50Q/1rywe0btZNbWccZRE+AB8VUnkzYjY9aO+dRlii0ohxZatoKliPJmFQ4JrsZWCs3be
	96aDrwUVTIJ9nj5s/Zth2CbvHP5csL9SrVstZmdvPQw==
X-Gm-Gg: ASbGncu0P5/5QYCeeoRfPkUgeCoOABN4gkPNxo+ftWH9HCxG1KyhyiBWNClGP/bozh1
	ur0Se0zxexgLthzigVr1M6xrA5Wc2IGhPOqzlKazVKIaEwyjTK5ojn0ib95+sZ3k21x16tsNpa6
	7J3g4x61jr3yUhptjrzgdfaP/+OHkvCRBFeXBF9kOg3bBB
X-Google-Smtp-Source: AGHT+IFtijseeaC8eESe1IMMDOf12pwhi3NTBdBrNFTJ7WgqzTOVmjnwbAAgUcBBpT3eDfmx3vc1+yK/w2UdnRdSf0Y=
X-Received: by 2002:a05:690c:4a0a:b0:711:4fbe:e475 with SMTP id
 00721157ae682-7164d2c9fabmr101489797b3.12.1751558722362; Thu, 03 Jul 2025
 09:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702031737.407548-1-memxor@gmail.com> <20250702031737.407548-5-memxor@gmail.com>
In-Reply-To: <20250702031737.407548-5-memxor@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Thu, 3 Jul 2025 12:05:11 -0400
X-Gm-Features: Ac12FXw33lCVvMH68e_gBRNKFAPewjf9yKneQIyQfITO6AuG1eQLLI_6NwxNZm8
Message-ID: <CABFh=a48pnuwOcNNy=13E50SD016G5+P=PGZC0vTLKFJ7X0cZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 04/12] bpf: Ensure RCU lock is held around bpf_prog_ksym_find
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 11:17=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Add a warning to ensure RCU lock is held around tree lookup, and then
> fix one of the invocations in bpf_stack_walker. The program has an
> active stack frame and won't disappear. Use the opportunity to remove
> unneeded invocation of is_bpf_text_address.
>
> Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/core.c    |  5 ++++-
>  kernel/bpf/helpers.c | 11 +++++++++--
>  2 files changed, 13 insertions(+), 3 deletions(-)
>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 5c6e9fbb5508..b4203f68cf33 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -782,7 +782,10 @@ bool is_bpf_text_address(unsigned long addr)
>
>  struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
>  {
> -       struct bpf_ksym *ksym =3D bpf_ksym_find(addr);
> +       struct bpf_ksym *ksym;
> +
> +       WARN_ON_ONCE(!rcu_read_lock_held());
> +       ksym =3D bpf_ksym_find(addr);
>
>         return ksym && ksym->prog ?
>                container_of(ksym, struct bpf_prog_aux, ksym)->prog :
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 61fdd343d6f5..659b5d133f3e 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2935,9 +2935,16 @@ static bool bpf_stack_walker(void *cookie, u64 ip,=
 u64 sp, u64 bp)
>         struct bpf_throw_ctx *ctx =3D cookie;
>         struct bpf_prog *prog;
>
> -       if (!is_bpf_text_address(ip))
> -               return !ctx->cnt;
> +       /*
> +        * The RCU read lock is held to safely traverse the latch tree, b=
ut we
> +        * don't need its protection when accessing the prog, since it ha=
s an
> +        * active stack frame on the current stack trace, and won't disap=
pear.
> +        */
> +       rcu_read_lock();
>         prog =3D bpf_prog_ksym_find(ip);
> +       rcu_read_unlock();
> +       if (!prog)
> +               return !ctx->cnt;
>         ctx->cnt++;
>         if (bpf_is_subprog(prog))
>                 return true;
> --
> 2.47.1
>

