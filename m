Return-Path: <bpf+bounces-52713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E4FA4720F
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 03:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B982A165BA0
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 02:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01520185B67;
	Thu, 27 Feb 2025 02:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbOXVG2d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D790B187858;
	Thu, 27 Feb 2025 02:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622742; cv=none; b=jZR0cegQ+JM3RzG+siut0f1YkM80IA8DIrE80jodp9YfYO2hPMY5+GUT464bxPWP9ZsE6+6iPHMyyqLl4t9ApmjlVQTeOK/yOq7wMUkhdhoLXglN1CB0AZIx+NoecLgNX7MlS20KSfIyuKvKjy+CKgxuiFJBwf7oCVQkevc9P3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622742; c=relaxed/simple;
	bh=E5oKEM4c3dUDoG1C3Apf7XUAQ1dqHQWFDZ7U0uJWOW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7FJsqsdTqfccdtHapdWuB0N2OBYuw4CxXZ4ZdMLSjc9XDyZzLaQLMn5vPbC7l8lujjFd0sB1NQ4UHeYmMD4LSR5rGZP55grWUAO7UxUu6eH1KO2Wdflq5MyWJMW5DJU8Vyrecp+7D1izI+ny4HCRxe4iYIQHGxxzxcm/mmoJBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbOXVG2d; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-390df0138beso199348f8f.0;
        Wed, 26 Feb 2025 18:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740622739; x=1741227539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKgnaqO1THtjCOxWh4A+wQIkk3mMpJl1DZhYW099CWc=;
        b=kbOXVG2d6ndBV6HXs5bmrK1b5jKSA5fwunkv/cmQDS/Xpe1G4yq2dTnV8wJPv1/oy8
         gPnrPZfAuOsNaCbwYwXTTK41wo+MYHlkd+cubq6L8DevX7RKH6jTOWnAzjlMMDpPkY6v
         Qgrpy7MnuNpz+Wfeh/g3PpUJUbvP5zmyBRpHevv+kJ6YgXxRAK2gcA0W4BgyISdTSfsh
         ZnTylQqKsPQmcoeTh5Vxiy6zMw0G/msacur8Z1t3HAVeVNw+YofU6p5lL6LBTwwWgLMf
         Hxr/G6AiA7JRjSSVvQ8XADFJlwqkjqYL37zCaHketiGOj/gM4/0W0bqm1sGBZbaZZ2fE
         OrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622739; x=1741227539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKgnaqO1THtjCOxWh4A+wQIkk3mMpJl1DZhYW099CWc=;
        b=Se8SriPn1igJp2wFwOqx1rfOaynZme/eCTy5VYXFzisbhflvfK9teUsxK0uK2qjUqz
         wxe7ccoEJq+OLNKASixw0qE0WPNACNBy/wWTy5HDYUme0upFcxua58g3Ko8SIoXHRQ0x
         aC4MC+TLYMkGJt6UgR41XUe6Aa9XrHsYNQLdSghs1YrfsdUGY5nn96ymSe6eJxc2bnTR
         7wFhtZZrs6JWOW/OEZfJysUpLwKrhSV/GZ1dHrgJPKwkA0IjbGXSgR/H+30+a0bAreFO
         pGLEkoG3VQp7B2vckJtB5mCzDYY+hFohxHE0a3880YhkeiXcmxf3HK6ZEsKrPQYFGL8b
         xCcw==
X-Forwarded-Encrypted: i=1; AJvYcCXANHPaM8IyJvrAM2oh3uRhUjGYMGJasq0woUOhhiOFYwj1nIAtDnxjT4IbQ5gPhUjk0zFC1sUJzdaKIJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeCj3ZIg98zCG/vhuVLHZvewLl3B3n7vMd+w9P/mNjOVx63RIn
	hPPr+/mQgf1jn8SC3zadFhP5BO/CB7iKZigtKrDI6AtdNihzVzjDMSwh9sNy1BA4YrtVPZ086pU
	BLyAKiYmxwvyxLkjTf7t/6d92aJc=
X-Gm-Gg: ASbGncv63+GyMfASUaIr9mgQT1xY/zvTne87AgW5onqQvKtibMn3jj956GytKJTRsvz
	Omg7oBWkgqSX78uluUeZC4FVthwT2P+xdB7JSqrS1d25sxqcipMmre9+Q20/PbTNjS/7xq5i6pP
	uNUNSFrPthrlMwcgqsdWGEods=
X-Google-Smtp-Source: AGHT+IFj9lP3GWA+vKa3jAcVVxBcG8NT2uVfgsPyo0nWKDEklwxzkOv8eMk1aaXCnVCJDi5nTjn07mT717GUMuR0kVg=
X-Received: by 2002:a5d:47ac:0:b0:38f:516b:5429 with SMTP id
 ffacd0b85a97d-38f6e96738amr24102168f8f.25.1740622739040; Wed, 26 Feb 2025
 18:18:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740009184.git.yepeilin@google.com> <e2d7bfc155a26305a3024aaa102a3acfa693e565.1740009184.git.yepeilin@google.com>
In-Reply-To: <e2d7bfc155a26305a3024aaa102a3acfa693e565.1740009184.git.yepeilin@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Feb 2025 18:18:47 -0800
X-Gm-Features: AQ5f1Jq1Bqzfu5XLxkx0XrckAoOp2Oka7xkENl-fqAWdeylPPR2SlLu-E196h-E
Message-ID: <CAADnVQKEcof-WBBj_W=GpsP0Tjm8hyxeWc06243ZBR7_Ua0Gfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/9] bpf: Introduce load-acquire and
 store-release instructions
To: Peilin Ye <yepeilin@google.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, bpf@ietf.org, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 5:21=E2=80=AFPM Peilin Ye <yepeilin@google.com> wro=
te:
>
>
> In arch/{arm64,s390,x86}/net/bpf_jit_comp.c, have
> bpf_jit_supports_insn(..., /*in_arena=3D*/true) return false for the new
> instructions, until the corresponding JIT compiler supports them.

...

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a43fc5af973d..f0c31c940fb8 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3771,8 +3771,12 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, =
bool in_arena)
>         if (!in_arena)
>                 return true;
>         switch (insn->code) {
> +       case BPF_STX | BPF_ATOMIC | BPF_B:
> +       case BPF_STX | BPF_ATOMIC | BPF_H:
>         case BPF_STX | BPF_ATOMIC | BPF_W:
>         case BPF_STX | BPF_ATOMIC | BPF_DW:
> +               if (bpf_atomic_is_load_store(insn))
> +                       return false;
>                 if (insn->imm =3D=3D (BPF_AND | BPF_FETCH) ||
>                     insn->imm =3D=3D (BPF_OR | BPF_FETCH) ||
>                     insn->imm =3D=3D (BPF_XOR | BPF_FETCH))

It's border line ok-ish to delay arena ld_acq/st_rel on x86 for a follow up=
,
but non-arena on x86 should be done in this patch.
It's trivial to add support on x86-64 and
limiting the selftest to:
.. defined(__TARGET_ARCH_arm64)
is just not right.

Even arena ld_acq/st_rel can be done in this patch too.
It is such a minor addition compared to the rest, so I don't see
a reason not to do it right away.

pw-bot: cr

