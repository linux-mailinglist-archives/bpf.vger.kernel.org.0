Return-Path: <bpf+bounces-77726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CC0CEF855
	for <lists+bpf@lfdr.de>; Sat, 03 Jan 2026 01:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0FC53009C2F
	for <lists+bpf@lfdr.de>; Sat,  3 Jan 2026 00:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAA21D432D;
	Sat,  3 Jan 2026 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVKTn0U0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB665661
	for <bpf@vger.kernel.org>; Sat,  3 Jan 2026 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399722; cv=none; b=ZObSzQ+OkDGA875+zp6w/Qejp/pC89CuN51SylZpNVDVV/oRshjtr3zwHQ3pXIOzxAFPl/hLGBUS1nbIaz9AJkEWNhicDUxYcTpY70FP5QKElm5GzTGf+x7RB17FL7+7bQ6OaucMoYdebc/FqKabm/V7h/309AyQw1NQC+F8JQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399722; c=relaxed/simple;
	bh=h0yfGz3NKb23GwrQ0hiHkndFEFMf19sAQcs0jB4SgII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tw+9Jv4BPl9DMzML/rZa2lk/Wd1zy3ay07p/fDrrcnZx5AR8mZ4G70DV7IbIaPBO1WLPU3GkJ1OZGLe4xDPzKkepiM+HsZQalHkoBaBffay0bmuwKMb5lqjUZEhYd3p1awHVIlZjJZSHjSk0CVHZpOlk/8lNINQVCtTlYHG5n0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVKTn0U0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47d3ffb0f44so41177035e9.3
        for <bpf@vger.kernel.org>; Fri, 02 Jan 2026 16:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767399719; x=1768004519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liQ9k523QnNtaCmLoYfsa5lwge7/2fBoLvtWV8YILBE=;
        b=CVKTn0U0saBdXy5Ay3SXxw6iHyX6DPxXWM8/VlYyBBVOh9Y2gmnkQConMcVBW3CvnN
         XdaUsaHbRn2YtWwKNZ6Fr82sbVk0ss8jOHpXWuX983kGKhPdoBN8iSw4esEcIXOLYCNw
         jHGNgZBYLuwzMkjktN68++mVRGKpFUDtUG4gVE8n93EY8R1khXo/wCF6IZJk7SrD0whs
         PvGHV/hh7xMbUhwrmKoqSoutywWSalMHNktfBMuZjGn71plPN5nnoR3TW7QQ+/CzLsLZ
         tOFfLGgXoYxih/KCbNGS0wmSrW7ee54j1ArnBQGeNxtt3EpU/1ZBCuc5CI8xqVTu5H2N
         gf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767399719; x=1768004519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=liQ9k523QnNtaCmLoYfsa5lwge7/2fBoLvtWV8YILBE=;
        b=Ngs+Rh/grLEw6n5fLDDNl98zQLtDhfo5ADCcEKZyQfHy4EvNbpmkRDNhaD+aOf9Sz8
         3A46qIdzGubdC4E1NBh/7D7F2CNlncrL5u9RHbh38ty+183hwNVb6Ku3wkK9yr01kN2X
         kCUAjNZXvB4tKUAbjKqK+ITPKQtC2PztSFrHJEJwbVQfWovx2fGreqE2Ex26Mx02m6Ke
         11Wsl2N3Yu5HuoRw5NgIB0i9kNCzytdkEIbKoz6JKJQojv0PVP2N57KSYgU3wL2wDnok
         0ie0rjKE2YJ9JCDls3M2fE3ZlQtCrLEIzjw7+CgMzetYEXfEq/Dgu8lY2OPWD2ix4gNa
         DEmw==
X-Forwarded-Encrypted: i=1; AJvYcCWL0PBOQ6l60PXScqOKwYjhfBj628fZsYGWos5MRLHuT/4n3usQBO/FHa3x2MAY/ChX9Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzcKCm46qwBIgwAMU7NKxihqyCjxCrp+Ji39dEp55qgfGu8FuI
	47l43Fn4ZGc1Rj4hy1QddiXbEjvC2dyNBxu4pT5dRGgK+ANQexZpA7gMGdIAjc36dydjwBIUsXR
	AAhTYjzj1oBZxllsRXM/YNxxaATUDDwdbFg==
X-Gm-Gg: AY/fxX7/kc44oZqje7/QNllHxbJ2hrFGPvTBscP0fxs2Ow+43+JVt0IjrlMsCTX8cj/
	jJWFq36lJat4NekMhamdI0fkH4yA99elcsJbJSSFs15+ICyh6QEzfAFgKpZkqEvSP9FMy1924+Y
	7p1aFA19EyJ7B3F4Hfe01Z1LAXjiEm7Me3ESSyg2OKZM8Z/MMB8CZYY49efATp7pzdi/YveXAI9
	Ju0Hts5SZtpv3Yka4aZrbTdnJQka4r6b9dA4L0KbnVBFBTQHMB3aGeSmVXBb0NjmJZtBL3EXk/y
	9/xMRQsqisGKtAF6NQyiFCRZGMHn
X-Google-Smtp-Source: AGHT+IEpR6XPmUpQ/Sle9tPH4KLEz+haruPVEJDdiiFhJMDp+ALDeSs9j+t18sZapD4wNe4VkoQ0Zd4zLVdrZwa9Qr0=
X-Received: by 2002:a05:600c:5488:b0:471:14b1:da13 with SMTP id
 5b1f17b1804b1-47d19566d5amr467292545e9.14.1767399718875; Fri, 02 Jan 2026
 16:21:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db829499-1ad3-4d9f-8a89-6246938a45aa@linux.dev> <20251225091701.1911903-1-tangyazhou@zju.edu.cn>
In-Reply-To: <20251225091701.1911903-1-tangyazhou@zju.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 Jan 2026 16:21:47 -0800
X-Gm-Features: AQt7F2qmQ1N9Pk6LtRl48XFst4bsxEsoJcHLZ49jm-jxHM-z101zQ7IVljubB0A
Message-ID: <CAADnVQKfo4tM01PnsZE8mVpztumqAvHvvvmJrO6nxf66y8w+kQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add interval and tnum analysis for
 signed and unsigned BPF_DIV
To: Yazhou Tang <tangyazhou@zju.edu.cn>
Cc: Yonghong Song <yonghong.song@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shenghao Yuan <shenghaoyuan0928@163.com>, Song Liu <song@kernel.org>, 
	Yazhou Tang <tangyazhou518@outlook.com>, Tianci Cao <ziye@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 25, 2025 at 1:17=E2=80=AFAM Yazhou Tang <tangyazhou@zju.edu.cn>=
 wrote:
>
> Hi Yonghong,
>
> Thank you for the review.
>
> > In my own experience, typical division (signed or unsigned) has remaind=
er 0.
> > For example, (ptr1 - ptr2)/sizeof(*ptr1).
> >
> > Do you have other production examples which needs more complex div/sdiv
> > handling in tnum and verifier? For example see:
> >     https://lore.kernel.org/bpf/aRYSlGmmQM1kfF_b@mail.gmail.com/
>
> You are absolutely right that pointer arithmetic is the most common use
> case for division in BPF today.
>
> To be honest, our primary motivation for this patch is not driven by a
> specific real-world problem or use case. Instead, we want to improve the
> completeness of the BPF verifier.
>
> While analyzing the verifier's logic, we noticed that unlike other ALU
> operations, BPF_DIV (and BPF_MOD) lacks precise value tracking. This
> creates a gap where valid BPF code using standard ISA instructions might
> be rejected simply because the verifier falls back to "unknown scalar"
> too easily. We believe that closing this gap makes the verifier more robu=
st
> for future developers who might use division in non-pointer contexts.
>
> That said, I fully agree with your concern regarding code complexity. To
> address this, I am working on a v3 which will:
>
> 1. Simplify and refactor the logic to be cleaner and more readable.
> 2. Add detailed in-code comments and commit message examples to explain
>    the tnum/interval derivation steps.
> 3. Fix the ALU32/64 mismatch issue reported by syzbot ci (which I have
>    already root-caused).

No. Drop all the tnum complexity and only support a single case where
divisor is a constant.
"Completeness" is not a goal for the verifier. It aims to track
real world cases where precision is important.
So far I seen only one case where compiler couldn't optimize modulo
operation into shifts and muls and that caused verification issues.
The code was something like: array[idx % sizeof()].
The verifier can be improved for such specific case,
but not for "completeness".

