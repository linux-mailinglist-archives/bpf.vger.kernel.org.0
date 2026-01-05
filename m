Return-Path: <bpf+bounces-77890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20893CF5D7A
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 23:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D8CD3073E29
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 22:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323242D781E;
	Mon,  5 Jan 2026 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVm/eDv8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CAB3D994
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767652432; cv=none; b=s5wRxRA7k4qBpJ9wz2Z4Tfv65aYVr9s+NQTbVIgb0dolGd1FPG5d0845KSYHOLGHKT4Q5aNTIYhxPk3fSjvlHw03aSgDilTSEx4IV7B+04UIzxK4Jqw0QN0k0micwh0JwI2ZYq+J1noGreFVcjUG5bex+o8wqJiCOP11ARuSVko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767652432; c=relaxed/simple;
	bh=XyNAwwSRh0ea+o2ZHOIEDYhb989XVxYoKerSYaQ/rQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPMU0Sud9jTJHVjKJbXt+kz2yfv/cOl9myeUuN7dWIMk5LowV2Rrf7CwVQiW7E64OLsSrUn3/FaIEto054s67LTHTiiAOFboAro8b9zwecTuhbsL6a/XTD/HunBS56o8TowX+KBS6XDiDsXIwQgLwh/HR8Skx1fcnKGonVmW+mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVm/eDv8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so2366665e9.1
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 14:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767652429; x=1768257229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyNAwwSRh0ea+o2ZHOIEDYhb989XVxYoKerSYaQ/rQY=;
        b=ZVm/eDv8N37bbOM6hOGKc7qWOVpkszywAPB/VyQ7db66aDfHM5+C69+3I3Q7umqdp3
         /nZeJUHqFpEu4WKCrEI9+txUR8uLZHY/1uC4bdcCGyNZuqzxVoacAVJZTEhQRM2DpA+b
         o/W9l3RX98tWKcJAh8VzXtpUv6zFLMkh5swlfNkQk63jn98Mo3G2NruFlJDDLCv+4r9l
         MOmkOBWiSSzXfLWfEMBC4cRUg2LOfPi8fWJ7qDnpB+++eV49oT+L3JY53OBwM3rbUGD7
         cR00aFMb+vLFGvHAppnpgW/pNOSIGxntolZ2tLa8QIi3IRsyQdgX7CtLbnw7cgZvj150
         Swxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767652429; x=1768257229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XyNAwwSRh0ea+o2ZHOIEDYhb989XVxYoKerSYaQ/rQY=;
        b=iGbZE2KrO6AwcfbWZy/DphxITU4fn64MzhAq5+caqnc3swPIAJg0j3XOT+ufS4qP30
         evmI9P6uQ6Hz6COcEItIBpChPfdprR7hVF6ORCDG3wQFyzp/QIgxgTnivxoDN+YMQfHY
         gYBh2ByiTURDh2jWg0zSxkMg2NaZIAUQ/zCJzjjda4eGOKhlevNWg44FlWkK9u0TRECu
         Wf4LI5HR3ya5wh5gYf2hWYR/4XEVWjmUnZoUdk2u6vFI2LOZV1+xi7NURady2TyCbH64
         BXWZQOK0bU5UfaTP5debRZYxkpof+fOQhIu0IRuB+CMI7yUPmRqiNg5cYknpbKjm1ARQ
         QVFw==
X-Forwarded-Encrypted: i=1; AJvYcCUfYB0Fp3l0n3zcu2pmRXSiOvF8oB01s4AlxQ/Rn/ZhZELptG9nk18eXZThN0YgXeY9Tc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2ckcRMw/3lCsFjnoaHzFLdsUrEDP9cNA8yRliFWkP+xjYC3d
	WCX8E5i1ilju3e06/Y7Sjw29UBiSp6S5kpHq76X9UeX+lnsKanG6g2uqocQWDBmedF0LEwyvmYS
	PQCzgVaxHooiO9JNpaVZw/fAT0zet1Qc=
X-Gm-Gg: AY/fxX7s7+5eQqJDBPioVmu2aJPaHciwbKV8KwDSU0cbyTwq1Jxf/KWQM8HzSdac3DB
	AAK0z8eiYTGvYSToUhfoQzPS5Izczie9LUj90EzyXZVuyWYlC3AtXP78s8GrvRFNLdqyE54a+rp
	ZS8cqDl/Bk+2VMy2fLFt+R+u5xxCCJZwdyzqzZQwR034W9oSH/zmIdSUTwliD/B4O065q0GtCCq
	ER/DWrv+YLC+LVA3guwNoQaExwH3Hp8QBkihsQXRTdryEUlg890cnx99JkVEu7sJHKOgEVPFbvh
	WNlJRQj6sERAJq6nP6HOBHvWq7KT
X-Google-Smtp-Source: AGHT+IHyUpIlnxhLNs9vUwOvPHQQkiLrdEPuoA1MO0lPN9p0H5yKaRJgyCbGkX+8PkINg4466J+7ncc9++EAa8JDQNw=
X-Received: by 2002:a05:6000:2411:b0:432:8651:4071 with SMTP id
 ffacd0b85a97d-432bca2b8b7mr1501402f8f.18.1767652429277; Mon, 05 Jan 2026
 14:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260104122814.183732-1-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jan 2026 14:33:37 -0800
X-Gm-Features: AQt7F2oN5dSGx-LIvpN3esAITXjbM-Mv5yyouCpQWhrn0tQffiQ6Jq60jnulvQo
Message-ID: <CAADnVQ+cK1XvYrBPf3zuNmRF+2A=i-AKGaNV4SoeTUeGRLF2Fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 00/10] bpf: fsession support
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 4:28=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> In current solution, we can't reuse the existing bpf_session_cookie() and
> bpf_session_is_return(), as their prototype is different from
> bpf_fsession_is_return() and bpf_fsession_cookie(). In
> bpf_fsession_cookie(), we need the function argument "void *ctx" to get
> the cookie. However, the prototype of bpf_session_cookie() is "void".

I think it's ok to change proto to bpf_session_cookie(void *ctx)
for kprobe-session. It's not widely used yet, so proto change is ok
if it helps to simplify this tramp-session code.
I see that you adjust get_kfunc_ptr_arg_type(), so the verifier
will enforce PTR_TO_CTX for kprobe and trampoline.
Potentially can relax and enforce r1=3D=3Dctx only for trampoline,
but I would do it for both for consistency.

