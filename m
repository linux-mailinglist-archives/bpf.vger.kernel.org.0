Return-Path: <bpf+bounces-62219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17775AF689E
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 05:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3183B104F
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 03:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A138722CBF1;
	Thu,  3 Jul 2025 03:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbeIXn86"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C82288EE
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 03:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751512841; cv=none; b=ZfOHgT6JJrzQ+Ys+84W61w7W3Lng1gH1zbEwVHV1cOY9CCwFzdFV5BFXTcHYE8MXdemqZnaxTLABEd51LY9mIx084EO7PXARRHfW/735+t2Ja2e88dnz5CI49QbpRfmknz/tCo6atevzw6uk+3vtn/Jz8Xt6P9fQsBc0eXuXGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751512841; c=relaxed/simple;
	bh=oW0kG0hew/gW8dFfOg+gEHPKuwc29D5pVc8XiMEVlaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntEVb8xJ+RJRWi9SxhW7sEKgiAi9wwNKpNEjwItMOpYcbPPPs04aO4ITwBCQoLcpxztoSCkDArDqUM3VKyXjik8EayPergjYdcT8qliZf12c+KnnEVfpFvO+n98+vMGF3smcsptJeaNsUdVunlc5+4LV3hG+AsE2i5IS46Ka5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbeIXn86; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso5287454f8f.1
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 20:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751512838; x=1752117638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7sFJv2z89/N4mG9LC3egTcbkwCYGr99MLqeDwVVOGQ=;
        b=DbeIXn86I7ECLHwhlDIW4PM9/QpKYYzgh3PCU51l5n7y9VEv/3w5fDjEgiKanwuKbq
         gSdFt0m2aABJL6gcGoj2/ADTCpWGX++XzHjosaGPsuLlq671yGx4wDRGYl1PAnbz3nua
         8QkT9GksaOmUNw3+YcMFFnLsTcvtbhUak3Vs1ETRkHhi+yqISw3glUvW8gJBrj3Rq+7s
         i/JO+SgidD/x8qndToDJmzpc463PXOb/diY9jd61AAcLufYQW+HMh69etP4SZNzej2O9
         1BVmuvpmyB0h3PmzGw5Xm40einxmQVy+W/EuuZg5eXPE/FuryqOlSwPh8PbKb9vVPw4T
         ZElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751512838; x=1752117638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7sFJv2z89/N4mG9LC3egTcbkwCYGr99MLqeDwVVOGQ=;
        b=Ch8ci3qDnIqV0UAS4SnO/Lx7/CM/Dfsv0rS9bOhpn7BwhhwGCijM2qkS7U/TVQ91gV
         N0SUpdogFz3BYsqiizt1gbctVrmy8awXWptm4/3PlXZ4mdYXOZwk5bMxO/JrVj8GNOV4
         VPtN+1g98BgaYq60FdvX/TD1Z2mvB4McDkw3WmRxs6i8jgVtb26JdWRtPp8JuU6mRSTU
         S9OiQqig91agj3jWuqzBnOmyBOuSDrZhP0NV5RDp4TzGnCTi9eRFqeCjwFWo4jumUdCG
         cQvCv0+mT4DSvtuRV70bFfw6Y8RLLAVnh7shaEGRCZfz5pqYVW0x+KE96wdz7caTGFDR
         oW5g==
X-Gm-Message-State: AOJu0YzBXgd4LwPaevPNcEBsSAH98Hv3IfkfIGBGaG1axH/RFi2OLWYR
	3RkSXdHLWBWu1Y8dXA/PUNi1oaj8nSTC7su38csnvfKIjydV+AhHRR7BvfF71uwBwm0YX3zsUCs
	rr7gyFt1AUZjnR6csjrjOVsFJ40xGDbo=
X-Gm-Gg: ASbGnctyyz5Fs0wmY/W/Wazjxy1Ee2rkJn9VHd0iTm5uZDHQgRKloM3TKfB9OaBpLm/
	LFKKlN9yapfLyz5fGMtFYmoWvgGiuahWKEV3bYT1BZsRE9kldD69X5dGRcpoKMMgcIF1w84CtjB
	MLeD03hOHZFU3AKXJFM6NsZ5zKh7Vls6OEtLnoVIDG2FhvwIXBhXr1Iz3S5tuLbeOQm11yDfCI
X-Google-Smtp-Source: AGHT+IGBjf0qWnN2iwLhja/Vjnzu8dwSeex68GQ02mhOn4L/ecMtLXZW+75pc9O71ynm/vJsM7ZshWubxIzMz+65Fw8=
X-Received: by 2002:a05:6000:4408:b0:3a4:ef36:1f4d with SMTP id
 ffacd0b85a97d-3b20067c8a8mr3118922f8f.38.1751512837619; Wed, 02 Jul 2025
 20:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702224209.3300396-1-eddyz87@gmail.com> <20250702224209.3300396-8-eddyz87@gmail.com>
In-Reply-To: <20250702224209.3300396-8-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Jul 2025 20:20:26 -0700
X-Gm-Features: Ac12FXxna10hRidWBab3_ZncP1Vs5RGIjddD2ZhzEW6hhGezHYTZ4dkpLTcrqU8
Message-ID: <CAADnVQKRigoGjm+jeKY-nGHi=_5pVr+Yjs_MnRDXNbf09AP8kg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] bpf: support for void/primitive
 __arg_untrusted global func params
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 3:42=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Allow specifying __arg_untrusted for void */char */int */long *
> parameters. Treat such parameters as
> PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED of size zero.
> Intended usage is as follows:
>
>   int memcmp(char *a __arg_untrusted, char *b __arg_untrusted, size_t n) =
{
>     bpf_for(i, 0, n) {
>       if (a[i] - b[i])      // load at any offset is allowed
>         return a[i] - b[i];
>     }
>     return 0;
>   }

...

> +bool btf_type_is_primitive(const struct btf_type *t)
> +{
> +       return (btf_type_is_int(t) && btf_type_int_is_regular(t)) ||
> +              btf_is_any_enum(t);
> +}

Should array of primitive types be allowed as well ?
Since in C
   int memcmp(char a[] __arg_untrusted, char b[] __arg_untrusted, size_t n)=
 {
     bpf_for(i, 0, n) {
       if (a[i] - b[i])      // load at any offset is allowed
         return a[i] - b[i];

will work just like 'char *'.

