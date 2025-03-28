Return-Path: <bpf+bounces-54878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3D3A751B2
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 21:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A253D16FDD5
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 20:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3C01EB5C5;
	Fri, 28 Mar 2025 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MURL1vZX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8871E25E3
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743195483; cv=none; b=fBDtE/5VHLfS8b+zT4hwCKJifdbzuYGTfPqOGfmnSHlB1xwGIXm5tzBlFhVvVJAblDn7fe2AXDsTclEs9GR/wbdT2FwcfceCM5LOx/IuAY4Nyrr6oP6cIXzeVRyEV7lotrEsKSIOUSw379fD3FchBQ2zjQFGtcT+bzDwZpHnldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743195483; c=relaxed/simple;
	bh=Qr0OTEql7Jlg26YsQpxzURIT4IO63iaSbirjjcc8VBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRIL+BjeSoJ3s+7ePckNhoMP8J+yevdvHF7jkG+fjHcx//rThbkiwSqMaIUZV0S3RjHhcQ0l1CeZc6tpfEWZf/186hnYI7fHZDWaOwznOil+BgD+k/fJdhEa2XAJwRCqWoTF/QKZo8HK3mYWjWCG5GRUY+/Sw+cm9gtZkhNHSiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MURL1vZX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223f4c06e9fso51017395ad.1
        for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 13:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743195481; x=1743800281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2N4eeV9Su8rlfvtkCnBbOazlQDHaar13lep7+u7834=;
        b=MURL1vZXCe6RR5OwN9BoYGi5Y8QwwyT19Ohxma6GKHsqujaohagiRMeE8Bv0T79VPr
         Pzc36uJCTIZjZKxF9MgR9e6hDzjgnsyxgrtqVXnC5Zmv34SwKPVegEw3JniJbcWzNyLo
         H2OBn/NRAhLbPTY3yZWB53R9uEJOS72PSnc5VExIbhIhd1Jqw7sqoJvnTp7yDBvi+mCf
         Nus3lSA9JIZG/jCpOiXl2ocuojcp12ba9BSM9oDIf6GKkB0DPqVAw88NEN41J9Gmj3Hc
         i/14cipdysIW6+kd0QtNV9frSGNGrI5sK253/j2th+ZlgjbB2/NeBxBIa05SGlKHtEzo
         p5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743195481; x=1743800281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2N4eeV9Su8rlfvtkCnBbOazlQDHaar13lep7+u7834=;
        b=ZrdOijRBKYXRym04h8QvF0u0MmSrVaHH381VezDJZgQD9vI6LS/r/dRc6ySyklbMvo
         idreAMbAg+auvx9fNLCq/0cWBpV3F0AWcV2jPv4ujh7hLf63WHFxJwKjALznyZlpftB/
         sj7Lrd0j77tNYzLsrTlTHr/MtAddZJIjWtEEBaWNVGfG5nw1sDNoCcyXVyhJ4yc4UD1H
         fK/yG8IVj1ifGRQAPFpOPLCONKQlwU3tYU4qjkEGYFF4zQ0k1Z9UvZMO9JZFV65jeqJv
         CSlpx4OlM1c7m0MqQ1e2CUklCYwnnPRDUqHoMT/UdT+piKxVni3y4BYBgiYWTF4fijhV
         J2HQ==
X-Gm-Message-State: AOJu0YzDQUhkz8aBwMR2Q3Tl79lgeH2zW8s91feOsvjc2Os0TMv8qirv
	jCr3HqmexfHwsfa2mqTRt63kcEjKqnymTg5yR2wcGzPnUx3kXvGNMLzwFnww/u2GrsV6aqfytKT
	nOwtzEtb042EclA3I2cjoqmSjnUw=
X-Gm-Gg: ASbGncsXsgfUTw1frqbOZAPP0xklfD99PZHCuM2JFYOLVOTqHKFryLlP2H4n98hmVT0
	75MrZZ8t769GkZOb3W1eQargQoJ/dRFShJhYw5HNPKKXuKMaKnGsn/3QKPlHQFlHYDbS9hh8cH6
	jA+LCgvsp1QqBxG8jRwliQp+LFEwWYSMx41ZW37bf/rg==
X-Google-Smtp-Source: AGHT+IFWv/k6a94yabgCng7Ms5t48Qnw8xpOa6GuoHpJlBb2EheYqCM8wgDPf5NJaXqHgYeygHclD7cV1UuQ8pQphVQ=
X-Received: by 2002:a17:902:e744:b0:21f:98fc:8414 with SMTP id
 d9443c01a7336-22921d733b6mr64157485ad.26.1743195481352; Fri, 28 Mar 2025
 13:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318143318.656785-1-aspsk@isovalent.com> <20250318143318.656785-11-aspsk@isovalent.com>
In-Reply-To: <20250318143318.656785-11-aspsk@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Mar 2025 13:57:49 -0700
X-Gm-Features: AQ5f1Jp40uFtJzQSeXGxofqAHi_qCQ3c1ujSpyZVb-davK8c5pMb8kXPp0kpmOM
Message-ID: <CAEf4BzZSfzDEMk5uSZ6+QhzGrNpzM7PpPiJ+Ga9yg1rFqMU2SA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 10/14] libbpf: add likely/unlikely macros
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:30=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> A few selftests and, more importantly, a consequent changes to the
> bpf_helpers.h file use likely/unlikely macros. So define them here.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  tools/lib/bpf/bpf_helpers.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 686824b8b413..a50773d4616e 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -15,6 +15,14 @@
>  #define __array(name, val) typeof(val) *name[]
>  #define __ulong(name, val) enum { ___bpf_concat(__unique_value, __COUNTE=
R__) =3D val } name
>
> +#ifndef likely
> +#define likely(x)      (__builtin_expect(!!(x), 1))
> +#endif
> +
> +#ifndef unlikely
> +#define unlikely(x)    (__builtin_expect(!!(x), 0))
> +#endif
> +

this seems useful, maybe send this as a separate patch? I'd roll your
BPF selftests manipulation into the same patch to avoid unnecessary
code churn

>  /*
>   * Helper macro to place programs, maps, license in
>   * different sections in elf_bpf file. Section names
> --
> 2.34.1
>

