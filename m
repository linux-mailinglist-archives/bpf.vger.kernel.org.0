Return-Path: <bpf+bounces-56716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B79A9D06D
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 20:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76829E13BE
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C409217666;
	Fri, 25 Apr 2025 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gViF1IKi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BEB1E32D9
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745605344; cv=none; b=A4seYy5TfSHDS18gnegaUAYWdV29ymq3TkQbH7m/ekKbzyNvJ65/+ZgTaNM03pVI7sp6SmfW4QCCtPS1SlVZrLpxhHsUyV8SdrAJmsLRKi9F7N7y1wgEgSLwFJnIDMGJkGv7BmUQ3GsfLsQEB2w7TUJ3Ad12PyypDWztWuGdk9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745605344; c=relaxed/simple;
	bh=tdX4aYJnAqSKTaGfRI2Nj5HwkmcFKt/ba8ib263B1C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdkuI7bH+vNKYnILkPPdoVm1Q1RXjgEL5GVQhRD2J2Saof07X9XXaabhPSDTEBJwRJaCm0/qBjO8ISZQ3in2q21/t/pAfu3spDmG+a6wKJUYnPveaHg4MJM5EKWau8RREtBxChplYaRYJAMsiIEFHtsuP3dTzOd5VcwuHDuX5qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gViF1IKi; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-73712952e1cso2917100b3a.1
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 11:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745605342; x=1746210142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0CFm6F2YPNhR1rPw3qEjWaJvvNjuWgmilw+n/Ab+mA=;
        b=gViF1IKi6TZekgnQ0tuCTq8cwbSynrHiYVuV8Yb6ESzpMPTxvn47rlPVs4b55YbWB8
         37TIRPVfMf/Gm1DHw5JAb9W6rgwRyqRkPwZIxAZzgQ3Hhvx2uR0e8u7kQ8ZHeYMCWCv0
         igmtxMoKhbRJDsXd0CnAjkuTDwIvYyw7oMuXDOYctmo5eNdWQLaH7IOOkfvIuecJTZvr
         pDRxpHJE92j2SbVRsh4l+sAabV3n6YFFGGSyS0aKgkW5KHReTqUwOAaKGkerjk5aODqd
         Y6lREqwkVzV4enwFmGD4RYogDAXBDOSxxlji0wW5PlPj7IWAKhwFDmEozVXqRepXA77N
         u/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745605342; x=1746210142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0CFm6F2YPNhR1rPw3qEjWaJvvNjuWgmilw+n/Ab+mA=;
        b=DKusG7qO99hYGN4fdoF/dVRTJ1kG5RFXdcJq2S869GGUhDYXRsiQUtCtbx9GGP8egA
         yzYaVBP03oKZWEaEILjRf7EHFCBnqR9+UZzmNGIjgKM7oe52wxOr+YSk2MkViyzgI9P8
         am7SEQRKqyQQYF2jWJxeFS+DYVHxczSBbQzTe2P3xbN4d7p42qW+TNxLqJsPcualMwNz
         KLcziEdDwEUkVSTxdidbmWlAByv4d5ykbZjUKLdSSTkvNQoOAmcIm4kYANknmH67erRs
         FoB9FOKG+y9941v/7zfspKUMC7IVYVMWq8CqbNsppfgqBwNSi6/Hu4K9sgSerU4itClv
         Fytw==
X-Gm-Message-State: AOJu0YyVex4zquaNmoqa1bwNxIc20a1SDweOHHkspAh017RcRXLl9B59
	FnDbvS2OUJYEJSy6l3yFbDQ69HWZmuxh0jkMgS1A0wTSPBBsPdBHPtTOQ47AH0w8hNkM8vgd/6C
	ALgAJAMKfMAR6jcUg1XFZEtKYKuc=
X-Gm-Gg: ASbGncvRYUVIv5NbP9LpkqQQTNyJ5l8EeZu8q6HQR0WDRCZ7nlszwYaCZgo/tIehXRx
	XtYgsXfIC7fc/j9GmGcdP5Xi1j9WmKltsNy8cbkFbAX3htoHWebY/SeE/rIoi3dtYp+Yr91GyTM
	h4O9zukMZVcYjmRS4A6nuUiAt8OfwTB2KOlMIZQw==
X-Google-Smtp-Source: AGHT+IEHIp1oVhwBS4ZGgveW60Cs5tpTdYXsFL0E3mEbzHCmMLc6DhajaKQsnQzJXqcl3Cn1/R046w0647XIFpz1GLw=
X-Received: by 2002:a05:6a00:218c:b0:736:5753:12fd with SMTP id
 d2e1a72fcca58-73ff72553c3mr699052b3a.4.1745605341781; Fri, 25 Apr 2025
 11:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425125839.71346-1-mykyta.yatsenko5@gmail.com> <20250425125839.71346-5-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250425125839.71346-5-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Apr 2025 11:22:07 -0700
X-Gm-Features: ATxdqUFVGHrRrcQizqm_ZKC8RFhZNRGoR4U9ZL4W2CwYbvZCsRw1uEJiL92F2SM
Message-ID: <CAEf4BzbQ6o19X_Zs+ZwVDEH6EwHnqcsJYphjCEvu+abrR_g4bg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: disable test_probe_read_user_str_dynptr
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 5:59=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Disable test that triggers bug in strncpy_from_user_nofault.
> Patch to fix the issue [1].
>
> [1] https://patchwork.kernel.org/project/linux-mm/patch/20250422131449.57=
177-1-mykyta.yatsenko5@gmail.com/
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/DENYLIST | 1 +
>  1 file changed, 1 insertion(+)
>

might be a good idea to just fold this into previous patch, but
ultimately doesn't matter much

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/testing/selftests/bpf/DENYLIST b/tools/testing/selftes=
ts/bpf/DENYLIST
> index f748f2c33b22..839eb892adc7 100644
> --- a/tools/testing/selftests/bpf/DENYLIST
> +++ b/tools/testing/selftests/bpf/DENYLIST
> @@ -1,5 +1,6 @@
>  # TEMPORARY
>  # Alphabetical order
> +dynptr/test_probe_read_user_str_dynptr # disabled until https://patchwor=
k.kernel.org/project/linux-mm/patch/20250422131449.57177-1-mykyta.yatsenko5=
@gmail.com/ is landed

nit: it's not "is landed", it's more "makes it into bpf-next tree"

>  get_stack_raw_tp    # spams with kernel warnings until next bpf -> bpf-n=
ext merge
>  stacktrace_build_id
>  stacktrace_build_id_nmi
> --
> 2.49.0
>

