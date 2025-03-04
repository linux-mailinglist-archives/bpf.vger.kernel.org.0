Return-Path: <bpf+bounces-53139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B77A4CFE5
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 01:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A79F1894C23
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 00:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DD8171C9;
	Tue,  4 Mar 2025 00:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwHW5ku4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE3BA2D;
	Tue,  4 Mar 2025 00:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741047867; cv=none; b=cpYKMh+Bfu8CkATByEy5pvMswpUNKdA6ekC4HlSP3JrBj2MOPDiGYF1WZqVY1C+mriP9RGA1/W/4AFcesR0hnbL6XQbnN0zzZplnfmCnEB3LwozdR4fc19m6bNiaZYCd+NCH5DvijDmOG3LPFHdV3AD/eTFlfYbhrnZd55yl90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741047867; c=relaxed/simple;
	bh=K+qvmYmkY5zyeTiJUrEHNt3d/YMLC1K3rD/CHwp9e4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOGaosiH4yLuNJeBlDTBja7EeZeo/c4+9Tsc+QYUwu04jxUb6um4y+LL7MuaTEQLlcKqVAQ6C/rXhg6rvNmaukj+x1TbeGjETrQPJjOknrulVQM6A60iv793shk2l6BQGTFZBsjpsKcbdw2qsya2XJtXbcYu/rrSK+PEJcKjOs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwHW5ku4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bc31227ecso9754955e9.1;
        Mon, 03 Mar 2025 16:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741047864; x=1741652664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urfZQlGq/pVWGO0zyd3wt9oayIr9+WV6zda/5R7lTs4=;
        b=kwHW5ku42m1fNWq345IJwHZA3EqGCcsVnKenPzP6mDqfFmqHUPUu6Qqzg1anwypD2z
         7B0SSnXCOkiRLM99V4Z+g5+CxmmO/sDGekF2eFmUifM7Ejxg4IVTCxjhc2FdaLBAOwa5
         DO9TIlSiMFFx4D8Pma6nlzfRKy67EaxkIc2f5oEhBMWfgIklxghkYr2NbdRg5aN/1fxK
         y7gQkQoLy0AIlKMfYicTqe1c2LQ/+r9ghN1WLeVdrnwOk8SGQIpqNfvSb9JhVwzJicKt
         hpT7xw+LARSDqoMB9Sc6Jm+Nx4/QPytblhCyvuUqL9Ha3U6/4GFsLmbRTBT5vfEAGF4L
         vx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741047864; x=1741652664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urfZQlGq/pVWGO0zyd3wt9oayIr9+WV6zda/5R7lTs4=;
        b=VIYZgbfiTgC482SPxicSV1mHrWHpmsxAPgWZPThO+x4zxeuhBJbJ4GcLhJa2aX7IJ5
         jJWEK1wRAW15iX9iyTQxAth8973TTw6ViqCmE4fiYya2DKmUKgVfkhf3FAz2tiaYN+1q
         dsWdOkYDS3YOO44mwqyhKuwE0vaNwkrhiJrYVjgQOZEAy0FzOwshDIuGYkHyWI8TYBG2
         8/iSFo61cnvxA/tzemM8gTjgj6TsN/CtdOoErBUdqXBiGSU089HapQqZAWH2VH5AXasl
         9Mbyh6EW4KQPzwBFGCGHQLM1ZDsHbi2vQgGc1fcH2I2rW3H3dLPKaAAGRjMBEBytoaKN
         eSJw==
X-Forwarded-Encrypted: i=1; AJvYcCURAM76/wq5cTfQlfXMV7NVcsA0RMYd7pkU8JemZQVWQDgZ5Cxm61zQIjPzY5y6IacCgg3+foSbr0xmalM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA27m7Zv2bAvU6eP4CYxNkl9nTVnC997ObwibEsh0mS684s8OY
	BNlIfT1uEreC4xk4czjIeobgf3Nc1L1BX0VhqSehpAPokyvE+UAYNGmkuWIjjTm/Jy8HUUwB+bU
	hPMkxhSfkqUi2M8sHqS9uEft4vjw=
X-Gm-Gg: ASbGncvjmvc9s2GkRJCn/wFqejlga0f/WYuCnaH38+aMrX0fb/viA+n0FcGjYY4Jo6A
	dDMeJyV+Dz4Jb7YrTFKrJULLd3GUPxZK9tUkNDQvHyCG0uqizwjekThU9Ban7ob3AFTiqoaBsx5
	6bv8VrioJ09vPTKf5JsOVXognGVX4rcSXOyCQ6sY2zqQ==
X-Google-Smtp-Source: AGHT+IHO+uVmNNZv/qkoEu5z4sgYhqObHiMzlFXLnOjF27YhrY281zOCVH1Tw0rSTwju5ncIQJYZex/bg3HsNm15TPA=
X-Received: by 2002:a5d:598d:0:b0:390:f0ff:2bf8 with SMTP id
 ffacd0b85a97d-390f0ff2f85mr11378429f8f.10.1741047863798; Mon, 03 Mar 2025
 16:24:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741046028.git.yepeilin@google.com> <b0042990da762f5f6082cb6028c0af6b2b228c54.1741046028.git.yepeilin@google.com>
In-Reply-To: <b0042990da762f5f6082cb6028c0af6b2b228c54.1741046028.git.yepeilin@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 3 Mar 2025 16:24:12 -0800
X-Gm-Features: AQ5f1JrTqby__bpiM0CWE4k0H7GR2tFUkKqgrjo6SaastgWB_5YIMYTwEno1ALo
Message-ID: <CAADnVQKX+PoSUqPBB2+eZrR7wdq-8EVaMxy_Wur7g8wyy3Dcmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/6] bpf: Introduce load-acquire and
 store-release instructions
To: Peilin Ye <yepeilin@google.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, bpf@ietf.org, 
	Alexei Starovoitov <ast@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
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

On Mon, Mar 3, 2025 at 4:13=E2=80=AFPM Peilin Ye <yepeilin@google.com> wrot=
e:
>
>         switch (insn->imm) {
> @@ -7780,6 +7813,24 @@ static int check_atomic(struct bpf_verifier_env *e=
nv, struct bpf_insn *insn)
>         case BPF_XCHG:
>         case BPF_CMPXCHG:
>                 return check_atomic_rmw(env, insn);
> +       case BPF_LOAD_ACQ:
> +#ifndef CONFIG_64BIT
> +               if (BPF_SIZE(insn->code) =3D=3D BPF_DW) {
> +                       verbose(env,
> +                               "64-bit load-acquires are only supported =
on 64-bit arches\n");
> +                       return -EOPNOTSUPP;
> +               }
> +#endif

Your earlier proposal of:
if (BPF_SIZE(insn->code) =3D=3D BPF_DW && BITS_PER_LONG !=3D 64) {

was cleaner.
Why did you pick ifndef ?

> +               return check_atomic_load(env, insn);
> +       case BPF_STORE_REL:
> +#ifndef CONFIG_64BIT
> +               if (BPF_SIZE(insn->code) =3D=3D BPF_DW) {
> +                       verbose(env,
> +                               "64-bit store-releases are only supported=
 on 64-bit arches\n");
> +                       return -EOPNOTSUPP;
> +               }
> +#endif

