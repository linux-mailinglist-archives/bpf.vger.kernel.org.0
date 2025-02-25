Return-Path: <bpf+bounces-52473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E4EA43252
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 02:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BEA172F85
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 01:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93F9171CD;
	Tue, 25 Feb 2025 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN34Ii9m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28819EC0;
	Tue, 25 Feb 2025 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740446139; cv=none; b=Pc1qB6ahM7cl0V7VRnQFTAeR4RSqdjmFH/NruWm4N+MZkWhP4UtcUVco+3gOwzLRJr5gW18/lIT8R+7I1vo9JbZpWJVOHgyZSQ3c98Qx0U0ntHujPdWrXKXiASCfc4LwqvipxJ9PLU3BnuWEZaLX/6Kp0Xy17fp7XWTBWYUsvf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740446139; c=relaxed/simple;
	bh=NQzxdzth5Cj0AaIEYGgiMzEzV801esG7x9P3uFqCPYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDtl72O8WJnQ9EsU2y70aSKJxhh+hq1uretGkq0hRPlOT4IQfN++euuXyYxLly8w3X6Mc5nSUStSiZtqofSkgeZz0fUsZW/vRe6sIfjcaAQ95DyfAi7y+icIC0vxW8WA2duaXn3qjBcP9vyVFenqEgSRh8IOsC2MbVzi8WppytI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FN34Ii9m; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f441791e40so7793896a91.3;
        Mon, 24 Feb 2025 17:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740446137; x=1741050937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyKs/kcdHFl90mbe3FwJHSCtUYzcfmgTEFBbzRP6mj0=;
        b=FN34Ii9mE6MaFU3sPkiAv7apif8mTM5ji2n3IsxBhJeHGPBjb+dwpuM1t1V/RiRl9W
         TKswYrBtwmEZ75g76ov4XKg1dkmmtPrlzxmtarx8nQkyPkavOwZVWYQY0995SJ5WnNG2
         sWD49oIO+kFuroCGSjX4doFGBY7ch7whoY9IFlLWIcsRw4i0XvYjsTWc01qFF7UIYr1P
         CWInO0W4fAkrhtJfcDGoSJCms1FBJWoeJJaRkIP68yPOgWxG2Fp1dafbAg1RWFi6Ckx2
         fbVDMF06x4HElLYg3aKGTBNACaGyxE7ktFqx5qrdwGzUx4XVkK3JNs0OPv66enVHqYu9
         zKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740446137; x=1741050937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyKs/kcdHFl90mbe3FwJHSCtUYzcfmgTEFBbzRP6mj0=;
        b=ANEt2EvL1HOTeBAIlDZvBB/r2BXg9kQ7BAkuZchERtkeEkybDL5vKxRaVHHz9rX0Mc
         rTGDWuOJMGgnmJoIpxtfoBexlFTbnIV9+faR76CWZ1Ob17YbKZiI4+zxG4lqKPUZYEmj
         BbwWVlyvPlxuUxM/44tHgqoZ2XP8Lhady1cdZsmKehT+G9QANdbr+vhemUl8pr/G6Ryw
         0+pmy1g/J3L6xVG9ZevptCyY2JY2sP8jzb5s9HqU0I/+r3S9Mf9EMq7LWIrZoE1qSc3E
         REl0Qj+/0tkMY0iu6VNrVM3y9pPp8q8fxw8f7uD/wsspyOyTkB64GlgPWIvyR0zZGq5r
         ie+w==
X-Forwarded-Encrypted: i=1; AJvYcCXPpcx00DZoG2cCadaC4bkQvi5rYCPEfaqGX65lx41lYNZgaKIvvYdWqdWf0+IC7fCH3o8=@vger.kernel.org, AJvYcCXShY5sdaAeGWUKokkhdRjI4lnoc3S7u6MuuJ+uF23wt2ygSuMBvjApBSv95iw9/Y8qmmFwjlJ4NY/bU2sn@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXEe8rsR5205XUoT5gJ+5W9Pf2EIBPJQpx4ItN7sEDNYX1yym
	Nr40yPjI32uZXZYmytwQ1ZNqg+cDlQ38fcvpy+NqOT2XtbKPRMGzGl8qy8Bp/EPooiy4coDLCXi
	L2C6vooeF9RrbwuqtEJLFMRgm91s=
X-Gm-Gg: ASbGncvA/uIbFk1DTDI278WIfATGygmsFukjLCm/sD8VhTrk7vgnzqs/OtT+Lo62LIW
	xeQVAxP8FkpRE4fzUH7O3hPSOPmzU1YqyTiRBmIUdv3oNx9yL08GmPAkQIT8LueQjdDaVkz1fHl
	TSublSFg9K6bWJIz99dLnnu50=
X-Google-Smtp-Source: AGHT+IFl8ZxqOKXVRKDMI1btod3FzWxvBVAz4GdCJCYphZLfSpz06wRSaD8qLL3uldJM5lG++sabWKv5qZT9dIWX5MM=
X-Received: by 2002:a17:90b:5202:b0:2fa:b8e:3d26 with SMTP id
 98e67ed59e1d1-2fce875bd28mr23927096a91.30.1740446137373; Mon, 24 Feb 2025
 17:15:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224165912.599068-1-chen.dylane@linux.dev> <20250224165912.599068-5-chen.dylane@linux.dev>
In-Reply-To: <20250224165912.599068-5-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Feb 2025 17:15:25 -0800
X-Gm-Features: AQ5f1JrqSFMS2tmwxvdSrMwyGbL-RQYhPjDBwsSR17YcNGH6DgXWn0kFjO7HU5Q
Message-ID: <CAEf4BzYz9_0Po-JLU+Z4kB7L5snuh2KFSTO0X9KK00GKSq91Sw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 4/5] libbpf: Init kprobe prog
 expected_attach_type for kfunc probe
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chen.dylane@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:03=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> Kprobe prog type kfuncs like bpf_session_is_return and
> bpf_session_cookie will check the expected_attach_type,
> so init the expected_attach_type here.
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  tools/lib/bpf/libbpf_probes.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.=
c
> index 8efebc18a215..bb5b457ddc80 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -126,6 +126,7 @@ static int probe_prog_load(enum bpf_prog_type prog_ty=
pe,
>                 break;
>         case BPF_PROG_TYPE_KPROBE:
>                 opts.kern_version =3D get_kernel_version();
> +               opts.expected_attach_type =3D BPF_TRACE_KPROBE_SESSION;

so KPROBE_SESSION is relative recent feature, if we unconditionally
specify this, we'll regress some feature probes for old kernels where
KPROBE_SESSION isn't supported, no?

pw-bot: cr

>                 break;
>         case BPF_PROG_TYPE_LIRC_MODE2:
>                 opts.expected_attach_type =3D BPF_LIRC_MODE2;
> --
> 2.43.0
>

