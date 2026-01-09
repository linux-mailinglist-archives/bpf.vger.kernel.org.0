Return-Path: <bpf+bounces-78268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38340D06969
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 01:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE5B5300854B
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 00:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383FC10A1E;
	Fri,  9 Jan 2026 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0SOKeY6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AC1500945
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 00:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767917126; cv=none; b=uyQCMecTINXEnU4txIXi1QaJolGL+Ec0mHxfpF0bcWv3QLpXLLgXKYKavFKw2BG284WDw4TDjppdyEXq47HrS6xUBfevAwbjH4qTMMLpoeoaSklIwv1sliAiQR5OF9ZpPPZDkBD97c1S6UQYcCvx94Czn12u2AFcblcgSDQvajI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767917126; c=relaxed/simple;
	bh=vW5ADiDJ75eZDrfL5GHxW5o18qrNlKplRzYnqxEx/S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoQDKDvCuA/TvWGvQWchGktMXkO+/aEG9wLeaFIjI7PM7sjzCsC38KrrcStc6X6hnH7ICgCkFn6NP1RYnX3Wo+kWKG6BwxN6J4CUBpeYCkwqG5t0xkzMsWh5A0gANrlZ/hMqliyvvrn9WZO2Fr28rzJT+4rnYq02ALqlbK4eunI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0SOKeY6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so1708889f8f.1
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 16:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767917123; x=1768521923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErfUaunZ6GdgjxdErmo5UizwYIWkhLbRVfZXrc8E7is=;
        b=d0SOKeY6XvbpVo1rXy0nih2S8qUXTTzOKo5uqJoEgLQoBu+CjFziyxqcjB17yarQiK
         mbgjQuNjK6kh81WmTK8mdvDDTPp1yVcTSDUpvLC6ptKL/S+ed2+5CYSnD+KzNzCh6BSt
         sZAB8UUaoxtXKScxhijrXJlb0LMZiPOyE6MNuYY3ygu1YXpqq0LOTGA+Mea3dIIuMZ6r
         NZojzQScY10e337Du9sWeiNtxrI2gsUjeG4XKvAQhfinOCofhwpunj9zbYb8C3mnwSmU
         YsL5dRR61lpS5ApqTHouY5q5TsDk7zsBco13HTbaubV0Qd6rEOZ6JOeeigSLzwzFAzQh
         aj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767917123; x=1768521923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ErfUaunZ6GdgjxdErmo5UizwYIWkhLbRVfZXrc8E7is=;
        b=npZJz8GzuSWkArL0fkdYnZPW5RWC0v5XmdxKhLVGk3uXYzvWsvJmRxDXYLq9Tr0k6x
         R7gHvMqSZVrk0MnRkna045NuGPr4XEwhAwRGYiJbRQ4bPDq6s7GvkQwr4Rk7X9nR7H0D
         EkvWcoOhEn3A9SGS4EB9YCx84SQ+llNDIeujSQa/C3zRcXFk4WArruIOzJhPIC3Hb1s7
         E5b5ffF2whzoMZr8IHW+h8+aOm6H1AtI8F53c2RzGy1FykU2wsbBaahnaMbP4BuvzI/V
         AcS1ziIaY53yLnuSxWxIpcCMlHWqfKxnoO9ATLRTprl5e7C8jb8AcutyoilNPlHP3jZo
         zPuA==
X-Forwarded-Encrypted: i=1; AJvYcCViorFOf/mwYj0XlrpvOCSfixyOtO26ivPd0xL5z545avhJ3Rga46VI5u1VAumEsO7H+fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzigSoA9T0sKGTXgRbBizZFD/9c1w/AlMEPeCfXbseHzDGbCBjW
	r9DmQ3enQJ8HON1gWaIaMgMfoHGu8Kwu+C7HLjKl0+1SZ+j3MykqD8Tl+84j+NAqCZxMyKs7Zfj
	sG8/ldVQnCkeiZc06ck0uu4N7udPRfiI=
X-Gm-Gg: AY/fxX4KJlDRnzXTLZ25v2JoPmeRSkApnElJ6Gl4/HLAHm582cR+s+aTv57dzmbyxqJ
	T8sXa7vd9NFS7Qp0y0OHmR5bxQOWKLMsKWt3gLQar8Ha2CiuOGjCc/LnuM6FYH+NWGYkFVq2XZm
	VnhpL/s7RZFqKyyHAtQLV1pKT8iSpptrK37F/vV22bW93e7ebYOnIBoONnsRbdapmtLuD7joNkz
	+33yjykAZvQYQtuVNdJel//FB4phbWfrN+gA0d6chLmqhGrrFUEOx2tzIDYWLqXNUYCXuyrMzgU
	/2QhV9b5EdqJ7jlAvnlawZHi6Xrj
X-Google-Smtp-Source: AGHT+IGQft91ItcYpzKCXBOqanxZUsL87GFzGcJq3XkI9xH/wZR/PUpMyvECl59NQXIbutHb2ywkSP9Vj0l/9gxZGaQ=
X-Received: by 2002:a5d:5888:0:b0:42f:edb6:3642 with SMTP id
 ffacd0b85a97d-432c37767acmr10670060f8f.60.1767917123383; Thu, 08 Jan 2026
 16:05:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87plb17ijl.fsf@fau.de> <20251005104500.999626-1-luis.gerhorst@fau.de>
In-Reply-To: <20251005104500.999626-1-luis.gerhorst@fau.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Jan 2026 16:05:12 -0800
X-Gm-Features: AZwV_Qg8NOb4zGwDgdCmfAX9eUNC39y22gTQCGFmlnUEH1TCoEwtSoNiCmwlGeE
Message-ID: <CAADnVQLGu_=Ko+sny5mONbrSysdg-iLRRO2vGaC-D1H4sNFDtQ@mail.gmail.com>
Subject: Re: [RFC 3/3] selftests/bpf: Add missing SPEC_V1-ifdefs
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard <eddyz87@gmail.com>, Hengqi Chen <hengqi.chen@gmail.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 5, 2025 at 3:45=E2=80=AFAM Luis Gerhorst <luis.gerhorst@fau.de>=
 wrote:
>
> For errors that only occur if bpf_jit_bypass_spec_v1() is set (e.g., on
> LoongArch), add the missing '#ifdef SPEC_V1' to the selftests.
>
> Fixes: 03c68a0f8c68 ("bpf, arm64, powerpc: Add bpf_jit_bypass_spec_v1/v4(=
)")
> Reported-by: Hengqi Chen <hengqi.chen@gmail.com>
> Closes: https://lore.kernel.org/bpf/CAEyhmHTvj4cDRfu1FXSEXmdCqyWfs3ehw5gt=
B9qJCrThuUy2Kw@mail.gmail.com/
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> ---
>  .../selftests/bpf/progs/verifier_bounds.c     |  6 ++++
>  .../verifier_direct_stack_access_wraparound.c |  2 ++
>  .../bpf/progs/verifier_map_ptr_mixing.c       |  5 +++-
>  .../bpf/progs/verifier_runtime_jit.c          | 12 ++++++--
>  .../selftests/bpf/progs/verifier_stack_ptr.c  | 30 ++++++++++++++++---
>  .../selftests/bpf/progs/verifier_unpriv.c     | 12 +++++---
>  .../bpf/progs/verifier_value_ptr_arith.c      | 30 +++++++++++++++----
>  .../selftests/bpf/progs/verifier_var_off.c    | 25 ++++++++++++----
>  8 files changed, 100 insertions(+), 22 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index a8fc9b38633b..033211c3f486 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -48,7 +48,9 @@ SEC("socket")
>  __description("subtraction bounds (map value) variant 2")
>  __failure
>  __msg("R0 min value is negative, either use unsigned index or do a if (i=
ndex >=3D0) check.")
> +#ifdef SPEC_V1
>  __msg_unpriv("R0 pointer arithmetic of map value goes out of range, proh=
ibited for !root")
> +#endif

Sorry for the long delay.
Patches 1 and 2 look reasonable. Pls resubmit with bpf-next tag and drop RF=
C.

This one I'm not excited about.
I didn't like earlier additions of ifdef SPEC_V1,
but now it's getting too much.
Especially all of it for loongarch that we don't even run in BPF CI.
Pls think of an alternative.
Or just drop the patch?
I don't know how many other selftest are failing on that arch.
If pass rate is not 100% then few extra failures is a noise anyway.

