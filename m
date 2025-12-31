Return-Path: <bpf+bounces-77626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5393CCEC77B
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC46B3001194
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE632FFDDE;
	Wed, 31 Dec 2025 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+5SmOBH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F07BE5E
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767205237; cv=none; b=QZgqJEm6vOquPpB8eWQ4ydVVJncF+xHcuIG9xXL3G1oZKJTe3G/ZnyvVKmhXl17cxL0kqy+CUAJeRb0BOUkHundv6VMJWPiMymMGWcFKKSZgLX7wt9trCkHh+2rLa/X76rWvpVAcJC7ebAgeY9JrOJduv0/PEbi39TY08v4+vfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767205237; c=relaxed/simple;
	bh=z5Qtb1+uZjEzSgK7NXfCHCGYaeIM6TZnQ51qs5Lkpos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTdLk9/xorxQkF3FNjTQkPHD2XLZwNPAQasb18BOZJFHqMMaU7xEPaI78fCrEKPD5YVr0/9DhKBAaA79r07Mu9ubghGhrplLnoAW9WaoFN2kn+w9XxUotgahMbReGiZCkBVeLZek1L62cSw3wOV4U7pAiLbXbPSrEps2oDF48+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+5SmOBH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so5492499f8f.0
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 10:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767205234; x=1767810034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok9f6MAxhtySFdX4ilDN1MFDZoOgEM6PsYKr0jxI6Ys=;
        b=U+5SmOBHRcGuUdXQ2DJb5oi3GjYWxgNAxUbtqUe51ORSY1jH90JEhjpy6f7cdJWhkS
         iyus2dkwB+w7WST3ctg3KVLdj04cEZej5GtjN+X8qu5y3uM5dhLkPqsK3X6aNjuTsMV3
         TMQwINtRU9gK0tMHWAmMJtS05a2JkcSR4pHFeWFRrVPTLqf4BCvOpITl3cxl88AHpBjy
         4dImCzaArU3UoM7imIftSn+z/hcEQCw6im8hW2ogn6GwXiwrBI59Ys7Vdd/G5PjWvicY
         9H9Z93D9SCcs2XQDSuCZgRmTSSniA8SOM5VQuhZ7QpnKC3y2bsKEoAxAh2zV1+baSMBo
         qcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767205234; x=1767810034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ok9f6MAxhtySFdX4ilDN1MFDZoOgEM6PsYKr0jxI6Ys=;
        b=EdBfATpdHFh1zu1fsxfNccD6BrWC9n4HATwqTgjKCV1JGGFV94WMnoZsk6FC87cZa2
         0ozJRIfvRtZVgTm9Wle7lFTE0MuTOauLhEJNuyxrX6OuP/8BrT0s/dFSL8Eq5Q/FTA/k
         O5KjSYB7HmJwBTAXQTti3u/tVkOcBvGnVLnKCsXxgpNao4Jug6RcGXKCJahs75vhNdo/
         r7lRn8t5UmKevunUwCeke8TDkpG+3IfLY+fshfBu7QN5qMI3CJMmaQX2QOeotqPq2cNR
         m0a/j1nK91aH2u/AGdJUv1HMnasYX6E1Fqsz1QjrLner500nBpCkmR4z+d9HgYsK5b8F
         FHhw==
X-Gm-Message-State: AOJu0YxpMCac7vSfd+PkAjcPNrrFDGn4SZJxFqpbdmWZR7iu65MLoNHe
	tCMqERQcm8J7JUR1/jMh9c23/G+vMpYBgy8QsexFQq9JLGP1qWF++QyZ9KjKtBWDPjjBZjeByTC
	xaRykK1+/8m5prfd/mFEiZgtLwH+wIPY=
X-Gm-Gg: AY/fxX7Ne/fLAna6B7o/hdcsCIs7ZrCPBObdFPujU3Kr6pSJQUvUphF81yTn8DsOg5H
	8cf75hugOiVgkgpmY7IH03ktei8pMeuFxOEmkdHEfbhpay/Fh1RYwn9Kc6AvuZ8IURsDhqoSwWZ
	Qc34dS8HPmvbZ1HQEowjyCzZ5KdmFCfFgJE+YKCC1rnYHioyC1sPKFJLv59BuTRYsfa9FM2T0Nd
	Ythl3j4blLRhngWs4YLI/Bphm8GsotERRBxsE+obLEdCDBCFJRAK+eO9G3LvPE9NTmdoNhXCkxL
	D4wYvSz4kCJPEjwP26EfW1oZvnghAUpghU3MDsI=
X-Google-Smtp-Source: AGHT+IHQsDLRVI5TrjlHljVBHzdgFnS4LiwBIK80PT/Iq55/r32LHL+4ZM+ULIxpCDyTFuxFdDs+TiyDqGpKjgbFi2A=
X-Received: by 2002:a05:6000:186e:b0:432:4c01:db00 with SMTP id
 ffacd0b85a97d-4324e4cff0dmr49269584f8f.27.1767205234200; Wed, 31 Dec 2025
 10:20:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231171118.1174007-1-puranjay@kernel.org> <20251231171118.1174007-10-puranjay@kernel.org>
In-Reply-To: <20251231171118.1174007-10-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Dec 2025 10:20:23 -0800
X-Gm-Features: AQt7F2qiIiLYdy2JXTuEEF0us2Bbwn1TKakTM_NChUdpZq0-vdwPKO1ONGrE3a0
Message-ID: <CAADnVQ+nK7bF6rTZJ=yF1L4+wifS0KN1bCNbOo7j7OJZRPaDNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 9/9] HID: bpf: drop dead NULL checks in kfuncs
To: Puranjay Mohan <puranjay@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 9:12=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> As KF_TRUSTED_ARGS is now considered default for all kfuns, the verifier
> will not allow passing NULL pointers to these kfuns. These checks for
> NULL pointers can therefore be removed.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  drivers/hid/bpf/hid_bpf_dispatch.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Benjamin,

please run this patch set through your testsuite.
We don't expect breakage, but please double check and ack.

> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index 9a06f9b0e4ef..892aca026ffa 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -295,9 +295,6 @@ hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned in=
t offset, const size_t rdwr
>  {
>         struct hid_bpf_ctx_kern *ctx_kern;
>
> -       if (!ctx)
> -               return NULL;
> -
>         ctx_kern =3D container_of(ctx, struct hid_bpf_ctx_kern, ctx);
>
>         if (rdwr_buf_size + offset > ctx->allocated_size)
> @@ -364,7 +361,7 @@ __hid_bpf_hw_check_params(struct hid_bpf_ctx *ctx, __=
u8 *buf, size_t *buf__sz,
>         u32 report_len;
>
>         /* check arguments */
> -       if (!ctx || !hid_ops || !buf)
> +       if (!hid_ops)
>                 return -EINVAL;
>
>         switch (rtype) {
> --
> 2.47.3
>

