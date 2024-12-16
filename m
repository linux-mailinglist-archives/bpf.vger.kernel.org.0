Return-Path: <bpf+bounces-47054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890909F387D
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 19:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 959197A1459
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 18:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3C120D4FD;
	Mon, 16 Dec 2024 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXEZV+IY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97539207A0B
	for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372352; cv=none; b=MrwzSLnTMTYNazbTxZHMCl+Codd5geHDOo4nhvqS7wT0HD8iBzgQ7Oev83Qvh3W4VpsYmdIHe0vmASLtmgAfa2p1NB0BMSBxGzWEx19GyMbdE8sMtlhdPVq+9lBaOqtQsRk0detTPw6v4+cxlBUOF8GpwNTw3GJMkCRrVYMS4Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372352; c=relaxed/simple;
	bh=jspQxfSf4T1DO5ClakIaCMtK5HKml2sfGFd9tQMfOls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBr5W5stqyOhw9PjkFvHYrbVTv/0yd8iQYPbcjIvXj9SUwY+j1siKl/E/H/JsRUoybnZc/BZHJIsFHqIusxe4hFZSHpiMfFL8ZX61tRpR3QmCwTDgkWG7/u3x9xKBj1QfFJ4WnBU7PA92y+Z6mojfbxLx806Vi+X1mI7Vj10NBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXEZV+IY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso9163445e9.0
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 10:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734372349; x=1734977149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpqCNqJl4VG/xnKCQRwiPDni7nrhiCuv1sDsA65ODhg=;
        b=BXEZV+IYVc428XipkK8sKHzGNuh4woabJBwFu8vHI8+M+rs1AluDm8OKBlmVkuBGqH
         vX+wV5hl6WqyO49hkrQcNtk9sdztc42xZiT6Pf256Yo+8xLIVNbrULvpCtD5dHJpwEqz
         5qoFSBh3/+XaGiVL2usfTi1+3XOxW3O7sO4oV75kLZswENJmsWbb2cZYIF5trtDCT7df
         EKcAIiIZ6I4tocnXxrjXsSjsj+dxqbZkefxvcpXIqUDPvL5KP0UnMoqE8Pnp3XOrAxTr
         4KJECC9BCGph/wZQ50NLIR8IFvWXTwkyh583wu+Xi+ZpILvlnX+h5WWqw70zMAxfhDR0
         pQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734372349; x=1734977149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpqCNqJl4VG/xnKCQRwiPDni7nrhiCuv1sDsA65ODhg=;
        b=NDTQe/suh9VaL+H7JS2aiL7qS4XeOZyds2xysVOLnYhf+0jVl7xBziqDLqAvR/Lfda
         0hUQoZ0POwHcD7x5TcegH3GZ41jwE5okMqlS5t0ucwTovAEvuNO3qUaYFZfV+e622xQX
         XZ8a9O3hDn2c5sPKFMnyxlECUR968OYxnMD0TUo83oBhtBLiSi4SHetbS9JuS+z21qTv
         miIL7MgU1PmTB447YPGsMq4aR+MZ6kbpOssBeGWU/1vp4EWrTrXHYXxsHWhYg6Qmd1Ng
         g/LiD3x0Fbt4/zBDo6GNGLSzaLfvefusKYXvEaVxf0sdsHLaGrc/O6R395Cb/RvoE7eo
         Q+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVQXrvcr25w66lBvth/RuKWEqDQb7xbAL7tk/c1rGvYF7R6NXbpnqpJHo3Jae9syLKsL6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YycsEASVBN7bYX8btNxjbWrcy2EACcUITnAPFhJmZG0QZmTLzK+
	I5dAlwWOvjn2f1M1n+4orTXN2OCSLS6fGym+11zLykEdON92yShUCn8NJ5fNxzUDs0hV75/qMoT
	4ZzEGdN42d10I99dUmSsrC/jWyg4=
X-Gm-Gg: ASbGnct5LS8wzpm3dSvoIV7Ct2KjW09+/ZBRH66n/BPZ99eVmKjgOxBQElETg/Af5Ry
	p0Tb2O/ShfCwx1/GplAkmWmEm3djQY9eNcyTnMFhAz1F7n64HWuTnQw==
X-Google-Smtp-Source: AGHT+IGEfsTm2mg+fQZWubT/YtWFLiMiy7/6veKSpS1AG9vpwG+Dg7Q3PZjwKUjwqvSVGdQ/2DaFeD5Rd0xPdcW1SG8=
X-Received: by 2002:adf:fb06:0:b0:386:4a2c:3908 with SMTP id
 ffacd0b85a97d-388db2437e7mr260545f8f.17.1734372348755; Mon, 16 Dec 2024
 10:05:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213212717.1830565-1-afabre@cloudflare.com>
 <20241213212717.1830565-3-afabre@cloudflare.com> <76401f4502366c2d9221758f9034aa7bb2d831a3.camel@gmail.com>
 <D6DB4NCLQZC9.I7DUNKR9RORW@bobby>
In-Reply-To: <D6DB4NCLQZC9.I7DUNKR9RORW@bobby>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 16 Dec 2024 10:05:37 -0800
Message-ID: <CAADnVQ++HfXeobY2XoJfDWXZGrF4_kR5kOK7asFRpBN=qmXU8Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test r0 bounds after BPF to BPF
 call with abnormal return
To: Arthur Fabre <afabre@cloudflare.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 9:39=E2=80=AFAM Arthur Fabre <afabre@cloudflare.com=
> wrote:
>
> On Sat Dec 14, 2024 at 12:55 AM CET, Eduard Zingerman wrote:
> > On Fri, 2024-12-13 at 22:27 +0100, Arthur Fabre wrote:
> [...]
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_abnormal_ret.c
> > > @@ -0,0 +1,88 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <linux/bpf.h>
> > > +#include <bpf/bpf_helpers.h>
> > > +#include "../../../include/linux/filter.h"
> > > +#include "bpf_misc.h"
> > > +
> > > +#define TEST(NAME, CALLEE) \
> > > +   SEC("socket")                                   \
> > > +   __description("abnormal_ret: " #NAME)           \
> > > +   __failure __msg("math between ctx pointer and register with unbou=
nded min value") \
> > > +   __naked void check_abnormal_ret_##NAME(void)    \
> > > +   {                                               \
> >
> > Nit: this one and 'callee_tail_call' could be plain C.
> >
> > > +           asm volatile("                          \
> > > +           r6 =3D r1;                                \
> > > +           call " #CALLEE ";                       \
> > > +           r6 +=3D r0;                               \
> > > +           r0 =3D 0;                                 \
> > > +           exit;                                   \
> > > +   "       :                                       \
> > > +           :                                       \
> > > +           : __clobber_all);                       \
> > > +   }
> >
> > [...]
> >
> > > +static __naked __noinline __used
> > > +int callee_tail_call(void)
> > > +{
> > > +   asm volatile("                                  \
> > > +   r2 =3D %[map_prog] ll;                            \
> > > +   r3 =3D 0;                                         \
> > > +   call %[bpf_tail_call];                          \
> > > +   r0 =3D 0;                                         \
> > > +   exit;                                           \
> > > +"  :
> > > +   : __imm(bpf_tail_call), __imm_addr(map_prog)
> > > +   : __clobber_all);
> > > +}
> > > +
> > > +char _license[] SEC("license") =3D "GPL";
>
> Thanks for the review! Good point, I'll try to write them in C.
>
> It might not be possible to do them both entirely: clang also doesn't
> know that bpf_tail_call() can return, so it assumes the callee() will
> return a constant r0. It sometimes optimizes branches / loads out
> because of this.

I wonder whether we should tell llvm that it's similar to longjmp()
with __attribute__((noreturn)) or some other attribute.

