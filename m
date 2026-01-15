Return-Path: <bpf+bounces-78983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E3AD22555
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 04:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E758D302819C
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 03:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564232BF3E2;
	Thu, 15 Jan 2026 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6qETea5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F07029DB9A
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 03:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768449198; cv=pass; b=WwFPSAEDEpcuYmZ27TLaEPNvzmMYZMCm3vB1j8LuAqsP4cw6P3Am84v+qD6nKudZZ+xt43Bx305nL6Vb7uB/v1uT+zomzZj7/skopEqSP1EzxIwf0z/adH/ou45LIQ93nPHrUavfKbUuZQSK4h3hnSEQPTo6f6gy14DTXfSVehI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768449198; c=relaxed/simple;
	bh=3Et7r04xBJYlBXAFg9d8b1OO8CPmGvVaUkhBmhdBQyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRRLE6rsApMtDjnXuPkHdF95LjTTh18O+u14N9ZuoCK907SYLqCjzgdhEvs5ThiZ9iyN+c5OJftCDGgs6s6FVpw4YKcZPIWPm4fe97ldbD96D4eyssGHWB1RoNPOwnBycYt0nD8NREMaT0vBbdDixyfggqXXa75JhL+pxqklXao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6qETea5; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47edffe5540so4656285e9.0
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 19:53:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768449195; cv=none;
        d=google.com; s=arc-20240605;
        b=bQ8f1Ir3TZeZ2efREJM1mEelTQp++KnfrS4AS8TvdHkJedd20a5QqI3D2jmZ/lGlh8
         cjK0kJ3CGdPyzQYnrM9mk9I5AQqfo8i4IjiVXJ0i7RifTpYk7PWimwRshpkGNWvlwGYP
         S496YxpuiGry2JXkKa5CdKCl6+1+BJfEwPxrFyFbGkURPar7T+4qk4myHm9sEgN6iDgm
         G8swg0QidD+hWkPZDcUZnOAShS9lo1M7hNz6rK97es1xdS0DwNoDw3ZD3KaFM7OzhJWU
         q7RUlmYCzVF1rrD+n8dQJjT2sr5Y8/Vc++zeRU5nmJrnFfD48QUnRR6wpyltVf+psfMQ
         UAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p3v88YTGU39VjhMfg8zI+U+lS0JXjfJNDCcVCYwSTBo=;
        fh=XeiALUJLMmF/VBRVVyhLzMzl9hAT72f7vg4hMvlmtM8=;
        b=KFxvbsJD+iTi0SSFW8tQmFDLAi37AGbRRP40OPM2HPXwy6oe2EW3RLUxvkEJ731cAn
         ptxq00qxyy6oJr4EMzXrBp/M05h0FeMX1/RqbGR4mxNtejlw8ZwwWQW5cjbvD4gZiRd+
         Jnvj8aNPQ1DjJKAUZNX1NOdTr6HzQLVQxxXSRFwlEYd/ealVWHbNNdS5Oo4c+SLcxDmF
         WgsccfjmbXSI/mT/6TGVqiMe6v4x1TMFvpHIKiEca3Wu/oCElDQnhnWOP90NzLxooyTT
         c1YNwlv7t4CAOABrpQ9K+LN1iKCPA1I5r2xhD4sKyk5l8HsWBo48EBK0vGDp8koZkMlu
         kAQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768449195; x=1769053995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3v88YTGU39VjhMfg8zI+U+lS0JXjfJNDCcVCYwSTBo=;
        b=E6qETea5P80hStJo0ND3Ov9yRO/pTubKansIDCS9xz39sqaYI0uUkUAh9e3uXnb8/k
         0IBSgX8s1p0IGFS6HeeCzEC3p2csPO1ECCwNxK7N6nyhGd1Wd1rf2K5FkPyiGitt4O0N
         OPN/CpCzXaqgWWu8V6JR7yCnob/ELpUbeiaU3lQkDQlLqkxPvxrO92jlPPqCUAY6PdzY
         kxVohkq18WKqgxm8PolspQsGab7bztSAVsdkx/2Vgkx5nOyCDjhPDLkG+jXBadra0a0P
         SPn1cajPxpaOpBQHkzDK7oi5iQZEc41UT3F4V9DcD4ulN4AiQtjHLaHygqP4s40rya/j
         ve3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768449195; x=1769053995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p3v88YTGU39VjhMfg8zI+U+lS0JXjfJNDCcVCYwSTBo=;
        b=JCS9jDwhM55Vj7wBkHi0VaMaPdwKzGNZ1nUHfwsmPq0VePqg7KqzN14dhGUThZCYuo
         PKA8ddF+z7jYX7M70PPZBTYbKYX3IG/FrE67iJYTXjcgBdimR9z54/gZOnX0zejTbQ+X
         kOLC9EE2/Hm73K9EQ2dKiNeC8jkhqEvFRLjoiHUuLcxDTZ7MscO7QFxtlYtQ57En/IIe
         9UYE0bNl2MDMdK369IM2P7K5w53tGZRE03/YqbLJcyg7HAJgAadF7W56S2ytw8clFpCS
         JSSzOJA7fVSOYxdbfjnKDFCufmOGpY5z5H33VOIF4SzFknXg6KFu8rm8gs/cqoMLj9kp
         U++g==
X-Forwarded-Encrypted: i=1; AJvYcCXdzUlT2jWeQsvUVwqo8D554obVrvHUdMcnAqxLpdOnd9NYknYmdd+ruawSCUhC9r+4R9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzimlIxDVQQ5aYAg/3HswETq+h6O0Y0Rq2utz/4/UrXwLGKs0iw
	PotjHROlsKAiY/sQXeR5j1TNc2FSPcds6Rwt/TXGQ0i1eOXvmyRZVkArhJfz86C4WFWv5qZiGA9
	mfi/axTz96ge2bqM9AmFXQc/VorFR14Y=
X-Gm-Gg: AY/fxX72peWZ75ADf06aSzLBgsMxnB+HH9NB5GJiK6Atw8qtfTgdoLR/wuxArF3aIzf
	fdAbIi7ZVbwqUuCsy5K4Ynk6yBb2Yjrthv8Bm24x63qzxDcfJoYGnljrovY32EUUMnuJC1dw3A+
	H4kjkjmByeJJUbUYNpbMPeGqQBoojvPXuqu0SAFgXIwdEFFQPf6QbYzLoYkstgKOANI09/HwyJf
	7BBB30owxCDhhvPNyRWSKHooi/emDj1zlFKv4jDzqScqNA2cuXssVY7GZYo+YTEhH6JnYnRePhR
	zaPSuCHgUMk/0UcoDjGYU2gpZMqW
X-Received: by 2002:a05:6000:1449:b0:430:feb3:f5ae with SMTP id
 ffacd0b85a97d-4342c57492emr5487553f8f.55.1768449195199; Wed, 14 Jan 2026
 19:53:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQL3gGe4iK8FZWnT3frRjAHtnNwGp8m5J8OSVcX0BCorUA@mail.gmail.com>
 <20260114054752.3908998-1-tangyazhou@zju.edu.cn>
In-Reply-To: <20260114054752.3908998-1-tangyazhou@zju.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 Jan 2026 19:53:04 -0800
X-Gm-Features: AZwV_Qj0I21N18zYAPxWAN7_gqi0mC4AjeGtwH9Td5FCG_lUIEGEKDfNdBsZco4
Message-ID: <CAADnVQL-V68YSTjg0N-yTqQmJcy562S9on3AEWgSHWLoEYQDFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Add range tracking for BPF_DIV and BPF_MOD
To: Yazhou Tang <tangyazhou@zju.edu.cn>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shenghao Yuan <shenghaoyuan0928@163.com>, Song Liu <song@kernel.org>, 
	syzbot@syzkaller.appspotmail.com, Yazhou Tang <tangyazhou518@outlook.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Tianci Cao <ziye@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 9:48=E2=80=AFPM Yazhou Tang <tangyazhou@zju.edu.cn>=
 wrote:
>
> Hi Alexei,
>
> > The whole thing looks very much AI generated.
> > It can spit out a lot of code, but submitter (YOU) must
> > think it through before submitting.
> > In the above... 4 almost equivalent helpers don't bother you?!
> >
> > and b=3D=3D0 check... isn't it obvious that might be
> > easier to read and less verbose to do it once before all that?
> >
> > You need to step up the quality of this patchset.
> > AI is NOT your friend.
> >
> > pw-bot: cr
>
> I accept the criticism regarding the code verbosity and the redundant
> helpers.
>
> To clarify: I assure you that every line of code in this patch was
> written by hand.
>
> The verbosity and the redundant helpers were not generated by AI,
> but were remnants from my v2 implementation where I handled full
> interval-based divisors. When I simplified the logic for v3 to handle
> constants only, I failed to clean up the structure sufficiently.
> I apologize for this oversight.
>
> I will clean this up in v4 by removing the helpers and hoisting the
> zero-checks as suggested.
>
> Before I submit v4, could you please let me know if there are any other
> issues you see in the current logic or structure? I want to ensure the
> next version meets the quality standards.

1.
Think of ways to reduce copy paste. Some of it is unavoidable,
but 'easy to copy' shouldn't be a default mode of operation.

2.
Use proper kernel comment style. We don't use networking anymore
for any new code.

3.
The 'bool changed' is a bit difficult to follow.
It seem you've tried to share the code, but it seem doing 'void'
return BPF_MOD and using two helpers that do:
__mark_reg64/32_unbounded(dst_reg);
dst_reg->var_off =3D tnum_unknown;
would be easier to follow, since all assignments will be in one place,
instead of split between scalar[32|64]_min_max_[su]mod()
and adjust_scalar_min_max_vals().
Or even explicitly doing:
+       dst_reg->u32_min_value =3D 0;
+       dst_reg->u32_max_value =3D U32_MAX;
//+       return true;
+       __mark_reg64_unbounded(dst_reg); and tnum_unknown

would make the intent more clear.

4.
smod64/32 have 3 supported combinations depending on the sign of smin/smax,
I couldn't find where selftests cover them all.

It seem the tests do:
+       if w1 s< -8 goto l0_%=3D;                         \
+       if w1 s> 10 goto l0_%=3D;                         \
(or the same thing with r1)

so only this part is tested?

+       } else {
+               *dst_smin =3D -res_max_abs;
+               *dst_smax =3D res_max_abs;
+       }

