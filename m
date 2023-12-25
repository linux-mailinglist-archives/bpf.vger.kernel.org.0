Return-Path: <bpf+bounces-18663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E88681E25A
	for <lists+bpf@lfdr.de>; Mon, 25 Dec 2023 21:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE4A1C21048
	for <lists+bpf@lfdr.de>; Mon, 25 Dec 2023 20:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B28E38DC0;
	Mon, 25 Dec 2023 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtWRNKic"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEC55380E
	for <bpf@vger.kernel.org>; Mon, 25 Dec 2023 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33697e6fc4aso2706960f8f.1
        for <bpf@vger.kernel.org>; Mon, 25 Dec 2023 12:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703536424; x=1704141224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbBUGKF+7ffjWrXswKvChsnVUYBMAte+3uKYcgMYt70=;
        b=OtWRNKic6rERi9B4tomz2uldhanOiQvXfRfPDj8elGsrSgwK8Jxk06VWInWIq2MFnO
         CwMB3MCc35rnf75G2yLsHGkJxF1oRDp1DjA3czWoYjolp+YMH/y0zPhzmSlscmoPGwCh
         osmkRd1XqfZ2+8uUiurzUHRUjo97+T3QpfqnxzW/PiAnWLKBKAq0vh5+D3/WXVaznxDk
         KPzzofuZPqgMcSme14b6WVzwuJzhcARDtvAFs5K7prZMhSlNg7R+IBLRBD2nZdJPXAzU
         hSh9hsocOdRgJV2luHHrao1wlwFBPtnNxapF9t7F+hmVP9v1CFsfvoce/dB2Yk7DYSJx
         ZZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703536424; x=1704141224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbBUGKF+7ffjWrXswKvChsnVUYBMAte+3uKYcgMYt70=;
        b=j6bb5MgS66MoiemRzjwAVf6yH7s4lIH/JxQlXWzpC75tbMrHu7xaNQCWscMpDyGRdI
         r87C4x3OZYWiXcv41MWYEcTvu/zHLouMGkc1JfiPw/YG1QselnSwyZKD6YDU/atBPRDi
         ZMcF2eQZZas/KBQm80Ag5B2amesvWlr3uXIaqNP9Rul5AJgQ749Bfj+NNmOkjmzaJ8/W
         7tKza6pXdlIvwynRCKUl+MUHuWmRYRCFiWcDRFhyHHg1UK9NZ9vcjyZb6AU3G37VNBKv
         3wa+j+Efud7+3YTNjr2Khm5eyB9qgrgF1AoVmkKE7v+Z1eAEt+ft9EXlnD0KAEc6tqg2
         7mIQ==
X-Gm-Message-State: AOJu0Yy6RpheBuTdHhVl6Blj5zqYFP57zqkvYpDEyv+5vKtELCn3MVeH
	HVQKjRQ4tIJd+Ly1s4E55YYvyfirkj4zYpSm8OY=
X-Google-Smtp-Source: AGHT+IHc4dETXw+4NSKNTcrEKGbeVk7p8ajblZ6Z75q/ORe1gyrqLPnsX2jtK6VsCrs3ohqxGdxpbIs4QHVX8cmmZKg=
X-Received: by 2002:adf:ce04:0:b0:336:d0bb:e379 with SMTP id
 p4-20020adfce04000000b00336d0bbe379mr364058wrn.213.1703536424042; Mon, 25 Dec
 2023 12:33:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
 <20231221033854.38397-3-alexei.starovoitov@gmail.com> <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
 <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
In-Reply-To: <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Dec 2023 12:33:32 -0800
Message-ID: <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: Introduce "volatile compare" macro
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Eddy Z <eddyz87@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 2:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 20, 2023 at 8:28=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > When I was writing the _eq/lt/... variants I noticed that unless I use
> > LHS to be a full 8-byte register the compiler can still play
> > shenanigans even with inline assembly, like choosing a different input
> > register for LHS than the one already allocated for a variable before
> > the assembly is emitted, doing left/right shifts to mask upper bits
> > before the inline assembly logic, and thus since the scalar id
> > association is broken on that, the cmp does not propagate to what are
> > logical copies.
>
> I saw that llvm can add a redundant r1 =3D w2 and use r1 as LHS in some c=
ases,
> but I haven't seen extra shifts.

It turned out there are indeed a bunch of redundant shifts
when u32 or s32 is passed into "r" asm constraint.

Strangely the shifts are there when compiled with -mcpu=3Dv3 or v4
and no shifts with -mcpu=3Dv1 and v2.

Also weird that u8 and u16 are passed into "r" without redundant shifts.
Hence I found a "workaround": cast u32 into u16 while passing.
The truncation of u32 doesn't happen and shifts to zero upper 32-bit
are gone as well.

https://godbolt.org/z/Kqszr6q3v

Another issue is llvm removes asm() completely when output "+r"
constraint is used. It has to be asm volatile to convince llvm
to keep that asm block. That's bad1() case.
asm() stays in place when input "r" constraint is used.
That's bad2().
asm() removal happens with x86 backend too. So maybe it's a feature?

I was worried whether:
asm("mov %[reg],%[reg]"::[reg]"r"((short)var));
is buggy too. Meaning whether the compiler should truncate before
allocating an input register.
It turns out it's not.
At least there is no truncation on x86 and on arm64.

https://godbolt.org/z/ovMdPxnj5

So I'm planning to unconditionally use "(short)var" workaround in bpf_cmp.

Anyway, none of that is urgent.
Yonghong or Eduard,
Please take a look at redundant shifts issue with mcpu=3Dv3 after the holid=
ays.

