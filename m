Return-Path: <bpf+bounces-52287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AC2A41182
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 21:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E5A3AD997
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 20:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1800E23A984;
	Sun, 23 Feb 2025 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgK2l6ZY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DB21FFC6F
	for <bpf@vger.kernel.org>; Sun, 23 Feb 2025 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740342249; cv=none; b=C7eg/IhV3KA6m5ozXmSyNS3Q4myJ8w3P7z2DwNo9xeN+yzU+UL7JRiUChlCT1vOpHsUy9w9NEYCeuPUExyxkpTh4QsSZF9d3sPuyCd+kI7aZCGbDckf5ef4wvuCeAwNl3ix31+9aVjO12YCGDPIOPXTqcGy+Bkd5k+bhPASHZUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740342249; c=relaxed/simple;
	bh=QunztCzhk1rZ384ROqaExlboXwCM7FegyLfEubSSCoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlPzW20AlmZd0T9KKxpf1rTuhw4PzFQf9ABm8KPwa8u9W094+jtfLZtCsu9+nC0GqC9T2D7GvjSdRlIX/cGYSXYSOB4XlKEJnIkrasvy4Y7FqBYwh5TGn4IMobypASzLYKFLDV/BrYZhYhoRAMsiXS2qHHhH9q7yzQmggq3slB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgK2l6ZY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4398738217aso32837085e9.3
        for <bpf@vger.kernel.org>; Sun, 23 Feb 2025 12:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740342246; x=1740947046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyvNqghh/CYl2vB9CsAA52nb6qB8uX9QYqPTNMq3vZY=;
        b=hgK2l6ZYaWzmqMMpNYH4SjU/kBmD1qfXETbEXH76wXZ2T5CMUMhMNisjA2jWYIGe+b
         gz68P43Xy30nQEkXx5BjhVtFGxcL5wGd6pgKQwGZHj0YllEi+P+Xqr6VAaNoDz5O7Ysb
         2iUvagKjoQKe/okq+u1kZ/h72/b/qiRfYRFKsAWHIP/vlE+WjG3UCvdx2648Q1jPzPhV
         kTvHmIy9ug+UK9eKtmN1VlEaG3wd6VDwE1SxuRT1AJ+KipG6rh4YwYWLZu6BmS06wIxy
         JBvJ71eF/U8zSvjbEV4KC+1bzbO2GzvqhqJHg3tuNQAZAe8J1mBn3qGiRJQ/pNzWuLUi
         0T7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740342246; x=1740947046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyvNqghh/CYl2vB9CsAA52nb6qB8uX9QYqPTNMq3vZY=;
        b=nFQvAI/e0WLu6hCTuydl6874qfn05DcF5bNDRjAXtjsQDo4al2YeYmvDB5PcSFiLnJ
         xUDrqkALpZLhDNCWrvgvuVmONsLRrtkcP99VJEn8lqNES7JUMbFCDtX7MnAQSXr+o8YM
         NBbdGITR4PFBc9JiUff6Gq5qrqsmVmB7Temh4MmUW0iQg0S5wE1Cbh6wwZETXg3wdfVx
         psbhVEq8fgpW7Wqprg/5Yj5wmbgMD7dnmKZtUeklNOnSKjqkEYmcjiL7DHhdirD22Q0C
         J01pizX8xIpSESThaA4NriiAQfn1qnxc3V3bThAcCSN8cfmTcNdPWADOO+JPq1z3mTy9
         uUmg==
X-Gm-Message-State: AOJu0Yyw8aJKMXHIDNrxQso3eOQzgcOpKErwj00Gnbi0nUCIs7rRYlz9
	zUF42FEHhVvAz0/Ab5HULmJfiRR7YrT+WmKRGcRKlw+TDuAKujW7fTCLN8z3ZxPSJ47wpQRnfMv
	+erHCrqzkQcf1Hu9osXFhidPMsEI=
X-Gm-Gg: ASbGnctLQMSfaHqKALNaWEV2IWpoXn2kXnh7WtPh5aa4KfiAo0wkXqt7ibKboqNtz4z
	gEEp17qij6aG9g1OsBhCLodorNJhjiDxLxBlys02mhvcAaGtV1evgHrLJocnlFH9UCn4R7CS0Rx
	P5VioIbG+GMat0nPfzxUW+wMA=
X-Google-Smtp-Source: AGHT+IE9mQsasdVU3svEPN9SokizAin3DFwj8m7pumaA29ydLMFRZjvMEt1z6TPOSKaUPEzTqsQHDNbnmQttNh+HmVo=
X-Received: by 2002:a05:600c:4590:b0:439:95b9:91fc with SMTP id
 5b1f17b1804b1-439ae1e6e9emr88004475e9.12.1740342246176; Sun, 23 Feb 2025
 12:24:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221175644.1822383-1-ameryhung@gmail.com>
In-Reply-To: <20250221175644.1822383-1-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 23 Feb 2025 12:23:55 -0800
X-Gm-Features: AWEUYZmO2DBElBkcyQQQ30vtt04MItlmJjxdsHk95-Rn8OgH87wDghVq9fx9-L0
Message-ID: <CAADnVQKdfKS2e_BS6krLvf6KUBDbtB=jvXic59DQ3G_YRwSY7A@mail.gmail.com>
Subject: Re: [PATCH] bpf: Refactor check_ctx_access()
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 9:57=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Reduce the variable passing madness surrounding check_ctx_access().
> Currently, check_mem_access() passes many pointers to local variables to
> check_ctx_access(). They are used to initialize "struct
> bpf_insn_access_aux info" in check_ctx_access() and then passed to
> is_valid_access(). Then, check_ctx_access() takes the data our from
> info and write them back the pointers to pass them back. This can be
> simpilified by moving info up to check_mem_access().
>
> No functional change.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/verifier.c | 56 ++++++++++++++++---------------------------
>  1 file changed, 20 insertions(+), 36 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 212b487fd39d..98a376bd7287 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6006,19 +6006,10 @@ static int check_packet_access(struct bpf_verifie=
r_env *env, u32 regno, int off,
>
>  /* check access to 'struct bpf_context' fields.  Supports fixed offsets =
only */
>  static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, =
int off, int size,
> -                           enum bpf_access_type t, enum bpf_reg_type *re=
g_type,
> -                           struct btf **btf, u32 *btf_id, bool *is_retva=
l, bool is_ldsx,
> -                           u32 *ref_obj_id)
> +                           enum bpf_access_type t, struct bpf_insn_acces=
s_aux *info)

Nice cleanup! Thanks, applied.

