Return-Path: <bpf+bounces-69717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C97CB9F922
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 15:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C2E1777D5
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066AD14658D;
	Thu, 25 Sep 2025 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McRjYv7P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3033E2264AA
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806916; cv=none; b=CJ5GI5HX0yuAuVXl94CO+okjxXgPQKS2U52CsxZGQ/KZmCEnkQ23WPppxJ49j0Yc6JS6TvIdAHtneipglkGwiZvmBlAHLylshJLRb02xi7UNteJmRoWasTwx/u9Hv7hKTagaVYlqGEP9pOCo7AVj0R6yVpo4kwZByItcQFpsICk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806916; c=relaxed/simple;
	bh=Wtr4343jRw+x6tvTLVc6oPOqmQwis8WJiaqbBbi9p1M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I2blBSXUKfoGr0+XWWROnc2gAks37WkbDuJLdhFE0lTYyxpgGtNGhkEhkYJAQsVg4QZtPSTV3TJlB5fiHk5CrviL/5YozjIW7aBpEJWL507fr1Ys/KPWHb6ecKCc3klFl6DPACYWc/B7awoY9C5IKv/xOK9JRxLIzbddK7h6+5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McRjYv7P; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3306d93e562so1058930a91.1
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 06:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758806914; x=1759411714; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nKSNE7rQEgC3Vt/685jIbcjO6yNnx0GPMdfTZMEBO/0=;
        b=McRjYv7PQuAuJIgp1WkTzaUIConLHmqsNPAGPzUnwHpZ7iuxrHu+e3L+Fmsk5Y9ENh
         xm06uFEdzjUAs0Ego6AyErXmy3OsQdDOLVhEhxWl5y1nlLnizk+DmbUqqV8a+Cs5rweT
         EjVGlGDUBMlshJSIbk0Y1neGKLwPm0deamKo5RFZAafZ9M6rV30mxFWVt5f5G9koQnRb
         4ghEnDp12xDtNxtasiERCFOPaEHUUGaRTzbgAncilj3KIQbYe72B3iekPEKWnXK3Hmyc
         f+r+kb5RexANLtom0R7tuH0Cp8/JepZZQBiZHf85VAPzrtORbxs4CrDjFsIyHDkJCn2f
         r/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806914; x=1759411714;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKSNE7rQEgC3Vt/685jIbcjO6yNnx0GPMdfTZMEBO/0=;
        b=jnr40+6oa7SSLz7PBdJ4+nGNtR10g9VcS2wknYktVylpTtyEcdspXsxapuXKtTYdW2
         TVrwzTbD4Ujkbusjx1xDaRzBeKYLMpztm0r7+ZBGuW9o4ovXb3eE2dP1B9KH5P3HIKJ7
         he+w2gXI7vOTOAB/kd06gC17Ci+Plhw3Y5PCn9D7EyqdfsSggXbXqfOkhGRfR+UQg83J
         JqlZ4iMoJMSr0M9OONf8J9V9NFUacg3Lch+oJ9EuvgLkF/hDFyXKlNzQE1n6vVFoGX/D
         PmQOA8o2o028pr4NuoJp5+TFxnBeNEkQA+skIPupyr1NzcyocHU5VYmBZbxANcVbYQvQ
         hJ8A==
X-Gm-Message-State: AOJu0YyldPhqPoFUEAQb/1WnfJBLrHvrJjSmO6pjj+AKZkc0Q/0FNayo
	KVpYWTpukqQBpDEwAn+rypqYnUlSNmz+zL0KkD/dzt1hQK0Rbc6QRnF8
X-Gm-Gg: ASbGncs9egvcdovxZAo+bfrap9SkPNMNT3wuKPMB7/CsxxawgQ5KWmn19S+bCKSzhL2
	FivumrcuXCOZJrxOFu5JojXVauLm1SZl6FsAyJX1AH6Vbp2Cnv8ncUn/RjnzTC3ikZpZyQR+6KE
	8eb1sVCapuRF05WI2PY/mbmuhT6XZGkIvza2t+L8vEoVG+maZv+xOVJPRRB39D0gXbZCRWaLnvS
	pROiMADzhhfCvzZ5n3Plp7Trzu1N29H0uzAwwKQNOvO9BEsjoRDnvsDhNkteo0L6DXgz/PCJva+
	VVy8T63aTFB5bzYAtnIR3qY6DXIcPQkimeNItp/4/h79rLYWlBMfyH/t4nZH46XPrYbGv4xDcWn
	J0WVZbcKJFauEPRtbHt5UUw8=
X-Google-Smtp-Source: AGHT+IG+2OXHAZ/OOB6tGx4st9SdDqsB343hU2yAeiB/tTlQmrBbTF+J4DCQGTWAHYW4xflyZuXd/A==
X-Received: by 2002:a17:90b:314c:b0:32e:5cba:ae26 with SMTP id 98e67ed59e1d1-3342a2ae68cmr3654294a91.23.1758806914245;
        Thu, 25 Sep 2025 06:28:34 -0700 (PDT)
Received: from [192.168.33.19] ([24.114.36.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33471d71199sm2396108a91.5.2025.09.25.06.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:28:33 -0700 (PDT)
Message-ID: <b92d892f6a09fc7a411838ccf03dfebbba96384b.camel@gmail.com>
Subject: Re: [PATCH dwarves v1 2/2] btf_encoder: implement
 KF_IMPLICIT_PROG_AUX_ARG kfunc flag handling
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
 alan.maguire@oracle.com, acme@kernel.org, andrii <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org, tj@kernel.org, kernel-team@meta.com
Date: Thu, 25 Sep 2025 06:28:26 -0700
In-Reply-To: <a7f28918-7eda-42e9-ae41-446b7a2d9759@linux.dev>
References: <20250924211512.1287298-1-ihor.solodrai@linux.dev>
	 <20250924211512.1287298-3-ihor.solodrai@linux.dev>
	 <4fb8a812fdd01f115a99317c8e46ad055b5bf102.camel@gmail.com>
	 <a7f28918-7eda-42e9-ae41-446b7a2d9759@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-24 at 20:59 -0700, Ihor Solodrai wrote:

[...]

> I'm not sure how generic KF_IMPLICIT_ARG would even work.
> Any *implicit* parameter requires a very concrete implementation in
> the verifier: an actual pointer of a particular type is injected after
> the verification.

Does not seem complicated:

- In pahole generate a special decl_tag for bpftool.
- In bpftool, don't emit last argument to vmlinux.h, if that flag is presen=
t.
- on kernel side, when checking kfunc args, also check for the flag
  and switch over types recorded for last function parameter in BTF.
  If kernel knows how to handle it, great, if it does not, emit
  verifier error.
- Not sure, but likely, the change on the libbpf side will be needed,
  as it compares function prototypes between program and kernel BTFs.

E.g., for bpf_wq_set_callback keep the definition as is:

__bpf_kfunc int bpf_wq_set_callback(struct bpf_wq *wq,
				    int (callback_fn)(void *map, int *key, void *value),
				    unsigned int flags,
				    struct bpf_prog_aux *aux)
                   =20
Kernel BTF will have it with full set of parameters.
But because of the flag, it will be printed w/o last parameter in
vmlinux.h:

extern int bpf_wq_set_callback(struct bpf_wq *wq,
				    int (callback_fn)(void *map, int *key, void *value),
				    unsigned int flags) __weak __ksym

On kernel side check_kfunc_args() will have access to complete BTF
declaration, so it can:
- check presence of the flag
- lookup bpf_prog_aux from the kernel side BTF
- call set_kfunc_arg_prog_regno.

> So we have to do a type check on pahole side to catch invalid kfunc
> declarations. And the verifier of course must be very strict about
> where it can pass pointers to kernel objects.

Type checks on pahole side will require upgrades to both kernel and
pahole, when new implicit parameter types are added. I'd try to avoid
that.

Also, do we plan to have several implicit parameters passed to a same
function?

