Return-Path: <bpf+bounces-53378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ACCA50653
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 18:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F2B1717CD
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E242512C4;
	Wed,  5 Mar 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4CMdRwY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9FD250C1F
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195667; cv=none; b=lFex2L7UyziEeYuAH8hLQqc777+ZlikNYWf0ZoD2TJUe2Ar+2djbO2jZM/P3/hjIQ31KK0j0gEpkMnSBFLR3DnAZ6NLFDX5Mv4kYE7VnHfbR2S5mnfPnIOsFZdOZC69AHlECVLysSEQxq90J4D+dxsDaSTFcUdjJD2O2JJoq7FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195667; c=relaxed/simple;
	bh=vdA+S2eVcpyiosDCyP9IrVeOv+LmOS84T/GErggzGpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duoVvIHILZvI21hAQwX9Ztj6OxSXgtl1llfbmKC14z1BgUVqEGNLybsWmTXt7+oYp133BNkMWE1Mc6d41+6dz9M8a3JK10EagHC/iD9FUTfVZIEHTy7bABemQGlrT8vS20K0P2XtxAhLGb8EFJCSmBtNrBtgzC0MXvOAE2Qhdts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4CMdRwY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390eebcc331so720292f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 09:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741195663; x=1741800463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/QbjHPqYTicvHSmiWLHbUYrLagyv94Rm0v3LoS4h2M=;
        b=d4CMdRwYuIAYKuwS41c+xiaaHMnILKQO9MDT8coxTNg37C1Xjx3uTD9RfHs48pdBVm
         UoJ6KSnuIxk5LT9hvaiaKX4ziUI7B6UAeYrlvy6m72XxU3WwlUXzBhARxMvO4kqMyUMp
         hl7/aagCy67TA968jySkhqnEVZXmyon/9NPWWbUFdM+rXGIGN1VgogkVcfyterrqzT2v
         vKf9A6JL2foeP/wB//7ebFCFl5iLz+Ttm8w1r2HqTVtTth4/FSgV3aavawlosNkB7Mmm
         joLYEe9KorUc9a9gCfuA5Lna0WiHAb+D/Qil3N1bURbjomqZA9UoIwJ4Zl6M5M8JQNQo
         JoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741195663; x=1741800463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/QbjHPqYTicvHSmiWLHbUYrLagyv94Rm0v3LoS4h2M=;
        b=bnZSr/eVZYPfatpHTbq4bepTlW52GI2YtPhv0nbW5JlnApJ0I/W5JNgAxqPQgBuj4Y
         pecRMc4kWg1lT69APhxOgbB6rzM8KdLNykNnAUWJbASE9wKR1J/rwZXLlTk9gj9TmMe2
         TH7+TdQlzbbS0Ww30pmT0Ch3612yiQBUdCPqMD5hWDvSzgHYnzVxBD+aWRhQomtokbBW
         RMcF666IUrPQOLCEL0YMdD2uIGsv4h8f2jU+qNqi2UiinYD5CPevMc71eemrhW62CFnm
         ACaMUK3QIGyEUSrRkdOAVr5kH4m6x0LxVjqBd7hOZ4Z3mqmnYOozqiVHZFwaAPwncPfK
         ooPw==
X-Gm-Message-State: AOJu0YyOMdV6M4y8kQGasyI6a9L0knkzhGIVy94d/xfCwX+ioFazPFfD
	qHSURVHyF+td9ZSTq1wxvrPjFARq4DDqS+aoOjfitOo5nwltMYv2E2NaK4qktVo5HorAZqw8/WJ
	+5nwy9Sx17eCf4Lj8R+D6OfHV1o0=
X-Gm-Gg: ASbGnct8DlEIOaXKuZSGMHizyk6SycbfevIU1KXHIlmLhwISCXExVlvnxmm+4HEze0d
	E+dULDsl9DaVfo+iNnWW8oGtTrAboifMwEFW72F1SQSksYY66U+ajaj53Nw+Sromslt/In+mT7G
	7L07Pm8/Ku1Mi6EARYjxLUamF5VhRqUKbDK+Ixlizu8Q==
X-Google-Smtp-Source: AGHT+IEzt6sQmZENFmC9xoQYaK9VlbvutwFgSkWqNhJAKWF/vEskKUWqf8ZJeeCnUZOcz4KWwib2SYYfO6FrOJK8Ffs=
X-Received: by 2002:a05:6000:18a8:b0:38a:4184:14ec with SMTP id
 ffacd0b85a97d-391296d3cefmr176346f8f.1.1741195662480; Wed, 05 Mar 2025
 09:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305045136.2614132-1-memxor@gmail.com> <20250305045136.2614132-3-memxor@gmail.com>
In-Reply-To: <20250305045136.2614132-3-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Mar 2025 09:27:31 -0800
X-Gm-Features: AQ5f1JrZaaqo0TMZbEJS-9ZX0KNef_NzS5KeZVTlATe5ATiYZsMbhm38q6dPPRQ
Message-ID: <CAADnVQJwAD8SZhbQpig7gToL5CRAr9Sy8Wr11pu8o_s2NmyBqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: Introduce arena spin lock
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, 
	Dohyun Kim <dohyunkim@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 8:51=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> +#define __scalar_type_to_expr_cases(type) \
> +       unsigned type : (unsigned type)0, signed type : (signed type)0
> +/*
> + * This is lifted from __unqual_scalar_typeof in the kernel (which is us=
ed to
> + * lose const qualifier etc.), but adapted to also cover pointers. It is
> + * necessary because we ascertain type to create local variables in macr=
os
> + * below, but for pointers with __arena tag, we'll ascertain the underly=
ing type
> + * with the tag, causing a compilation error (as local variables that ar=
e not
> + * pointers may not have __arena tag). This trick allows losing the qual=
ifier
> + * when necessary.
> + */
> +#define __unqual_typeof(x)                              \
> +       typeof(_Generic((x),                            \
> +               char: (char)0,                          \
> +               __scalar_type_to_expr_cases(char),      \
> +               __scalar_type_to_expr_cases(short),     \
> +               __scalar_type_to_expr_cases(int),       \
> +               __scalar_type_to_expr_cases(long),      \
> +               __scalar_type_to_expr_cases(long long), \
> +               default: (typeof(x))0))

I think this needs a bigger comment to explain the nuances.
btw __unqual_scalar_typeof() is using here:
  default: (x)))

that should work to keep __arena tag, right ?
Otherwise I'm lost why typeof((typeof(x))0))) is necessary.

What was the idea to call it __unqual_typeof instead of
sticking with the original __unqual_scalar_typeof name
that preserves pointer qualifiers ?

