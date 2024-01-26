Return-Path: <bpf+bounces-20389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F8E83DAB1
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 14:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3739B1C22424
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 13:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D8E1B80E;
	Fri, 26 Jan 2024 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBozBFtB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B551B809
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706275461; cv=none; b=fb9uiFXrAXXr74Z7bB+LMg4Gc4USIkaVyVngI/CZe9n3Gh/HSMBJNhD8AlBa1V/QJYP+r0cABk0VWK0+7qhL6T8HZtYgRzbCxMDjlM5kOylqViAIhdiLVV/KHBAV/KNXFLkdQrzOMvjhOk/HPJ47RDX56CfRp0jDnBRp0k4EGyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706275461; c=relaxed/simple;
	bh=PvVizu5WwFzpFkIvvTPP0V38Gm5eElcwocFEqIuJdDs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CTICS1XWJpSsUcj8l3tZxvI9sXkkzpnnBiOQsL0aKoJe9ZfCgBxEBjuSMEtoQ6MAbsWEhGOnXZdY6/YZtIytfx/zJh5I0l3RGGfUakI4k3m1M2VRUVPv3qLLTAMcKHYd0ezO8XrbJ/iqixfRhrg8y9DchQSV6pJnlLCwp2L6sD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBozBFtB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a31914e7493so38471766b.3
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 05:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706275458; x=1706880258; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VeEoDv4H6+pGRIzf5Ee4ZVvXhIKnTwWOKQLee9lBPLs=;
        b=kBozBFtBh4EyWA+AUJQtjsmD4Sf5NMJDTc8hUYcp7IornZwaL+FIB6ulm9J+5UHqHH
         FOQ3VwVfqdHskpHh6t718pcFORLs/11W4JX5g/id5DIdLaMG6HKbyWyw0hpGKT/MlznO
         JPt7QDUGIhpj6kPx/Bxg22hIEOcsdag4UvulVPAxj+VWm0FvQHDFYb8NfREh+Suc+58n
         2XMZ0nNRTWdZV173m9JBsC0NtOBPy1+SiUXGXv+hjUCZUTBWa54mnQ5/CJCpwCS35LE/
         Qz/CJrUCKnB74dRMXt0aTkHAZxcw7tNrwcQltGU6VSYQbMYtkc1dkex8aZy8OvNOgQQX
         5u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706275458; x=1706880258;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VeEoDv4H6+pGRIzf5Ee4ZVvXhIKnTwWOKQLee9lBPLs=;
        b=r7cQAQ43NNLzjAeTMSriSdlXrDWdST+/u9SPSTo+RhmF9aiU2rDFCAMJJdE2afzj9o
         HkIAQ4xE8pHAMY/hgRIWqZuPLWSgI9DOwYfcy3w5X8AH1B1PZpS2QFATS4gme57GQi9W
         HHYLKpinV/w0Yt1GkkdjDXYya82aWSh7reVxxC/bo7ln8v2mGHjl5zzeWSG16oncBLW1
         wAZGtilw1mipwDsqfmf0LgOb109x5hLFsM1LAVvwaz4P0apUlQxn3jWzDmt13kn0A6le
         I5hNNkqP/f9NJRSQHA/XVgiRsGuBOqznnKYKOQ8Jq672X/Ny+eGthfF8wXXB00Yhy5VA
         LXIA==
X-Gm-Message-State: AOJu0YxBnktxd4lm4m1IQnr2JrDlrywZfwQJ4N5IsTPJSgDYAdZH5CAq
	A4ybYDT39FD+TpCccjvIZUxvr2p4g26LVJ8D7FxkIandsJs95Fm5
X-Google-Smtp-Source: AGHT+IFcPcCaPE4/Rj6xyXrGNI8/MipxwBzYaLseAbtt4qat6DGtcWUMDYy3Zi15LNNpeSwmj7W8OA==
X-Received: by 2002:a17:906:33d8:b0:a2e:96df:28ce with SMTP id w24-20020a17090633d800b00a2e96df28cemr782818eja.62.1706275457879;
        Fri, 26 Jan 2024 05:24:17 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hw18-20020a170907a0d200b00a2d7f63dd71sm627161ejc.29.2024.01.26.05.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 05:24:17 -0800 (PST)
Message-ID: <3223cf369859b119914403664f549d1fb20bc644.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/7] libbpf: fix __arg_ctx type enforcement
 for perf_event programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Fri, 26 Jan 2024 15:24:16 +0200
In-Reply-To: <20240125205510.3642094-3-andrii@kernel.org>
References: <20240125205510.3642094-1-andrii@kernel.org>
	 <20240125205510.3642094-3-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-25 at 12:55 -0800, Andrii Nakryiko wrote:
[...]

> @@ -6379,11 +6388,21 @@ static bool need_func_arg_type_fixup(const struct=
 btf *btf, const struct bpf_pro
>  	/* special cases */
>  	switch (prog->type) {
>  	case BPF_PROG_TYPE_KPROBE:
> -	case BPF_PROG_TYPE_PERF_EVENT:
>  		/* `struct pt_regs *` is expected, but we need to fix up */
>  		if (btf_is_struct(t) && strcmp(tname, "pt_regs") =3D=3D 0)
>  			return true;
>  		break;

Sorry, this was probably discussed, but I got lost a bit.
Kernel side does not change pt_regs for BPF_PROG_TYPE_KPROBE
(in ./kernel/bpf/btf.c:btf_validate_prog_ctx_type)
but here we do, why do it differently?

[...]

