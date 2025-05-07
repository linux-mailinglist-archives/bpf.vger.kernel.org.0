Return-Path: <bpf+bounces-57613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2F3AAD421
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 05:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699941C027BB
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C5819343B;
	Wed,  7 May 2025 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nApyilBl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7551C4B1E4E
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 03:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746588988; cv=none; b=GcHaIlYgLxlxf/vdQwZyfjeB+HcoslmR+NwERkoQwzBScM+BPbIFVd6Y9hRpChz+9DZnpcll0/Eh0Hkpnu9huEVXserYIvmi3SSUvOHS43KnWYx7yfVSmeRlGsD0sJsEB1nHaGmYmIPB/asjnLb7O877deLcke0R3IOGkefwh9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746588988; c=relaxed/simple;
	bh=twgBsXU6DKGKQNI9JgvlJ5vLj+imBPy998E0HfQVZLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSCirnicozhK2fXYoW7sUkfyzrW5V85vzjDAlGTdz3i+T/zvDkn5cru8v/6koBb76UfyKgspNhvQtHVcsHYyoQ9hqgORTLBg/pRG0xElQfj7209OahjToklOc0q9qXkcrw/LBm88u8Ns3n61cedUHV9c2bUXQ0LWgWegUwAOiqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nApyilBl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a07a7b4ac7so2892330f8f.2
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 20:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746588985; x=1747193785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHwwRGR37ziGvYmPzqFBsrAZRKjKiGdv/9uf0VOmKtU=;
        b=nApyilBlfH1oZaLWa7cbHQUC0b00dN8PSA88osE/AR1T9Nw6m/qyxqUcy1fZDZKUdF
         10f8+B/dUM6mo3yOvYdlX87wCE7LUgknmzhRZqpFunVth9iBRT6q38Jpgev0EzpJcnhg
         pEpQNJVSYHdsN5CXn8H64oKkQhGJxBlhoagGLt6iOvsinxo7aBbd+LfIDFDIgELxHCi+
         HW5LYrHLrNAgKKOuKyeuYekLAm2wMDjwlRNxHmjnbyCAgaMtlDqcpO2YRDhjeChGT0J0
         0ZPPcnPO7Vu8J0jiNSRkg8Kkts3yzDCdTJHAeZUWwI3uBxNtrDo6N0VorhqtBRD3Dzb0
         D1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746588985; x=1747193785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHwwRGR37ziGvYmPzqFBsrAZRKjKiGdv/9uf0VOmKtU=;
        b=Am7OHOnHhBt7qFlzE0NEqDfJiX3jc0vGiMu9eHWSwwvpkgjALOzYzwlIjjt5atXPxZ
         5vV8b8TfQ0Bmns1MFFOZqkhvxICF+SPgeM6x/FaWN5SZ4vMes26oMr2DfbsOjEowUIGY
         ltU+xFsCXok3xzu+xw2MOWN2xAj49niV4r1YmcPtLDDg/5bLFc47gdPbsa5KwaxE+jr6
         U3dU6r1R32PntcJSzw99pWrJIC58NdXxft+cV3qXMW54j9MOnmjIzDWBl4OTm2L3XbG3
         S9qrkw9MiJQAvE3hYAJpkS/VevpIjs3k5rU2aWBvSb05Q8PPt0xPnkTyFTQF8H9dzKAj
         CUtA==
X-Forwarded-Encrypted: i=1; AJvYcCXQStEt2YqmnPEmdPNEJ2CUJ07yoDq+D+TJbGZZtCaBZwCaKeyTd+sclwDBFs5fWDQFq0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4my8NmUxNYiz7yVZCjN7eFQpXRgX3Vx8Gr2dzM/aVTcDBHSbX
	Ylp4nHupvjfmn0bQGJGfZI+evZar2xZy5ZjfsH1VIw2Rncev+o4R3cvsyRY08+5ssEpUOsL+SFi
	s33N8Zw5hXR325XAdJPEDMkSY7PY=
X-Gm-Gg: ASbGncvVNQXdnl8NpFpJzWYkfjv1LpmJ3oU2u5/zzHJ2qrl6KH7JYg/g1lXa3CplE7t
	06kB43vq7NRcHFgpbwfHYT1IbSqq29tZN1ptmEPIOryMJHLeGa5HQGYs7HoxvzpAoalahJeqTRb
	W1DQHjPYZ/ibfIa7qOi0fyeDund/GkMcrkdEYN50R6K3Q18/V/KQ==
X-Google-Smtp-Source: AGHT+IEYuuaE73wquGdwuKiYUj39PMPbyywhWU+yY9EL0V7ggBdPcDznBxycJ32KcCREoVmKLShAFCgmCW3z0zmOfTw=
X-Received: by 2002:a05:6000:4205:b0:39c:1159:fe1f with SMTP id
 ffacd0b85a97d-3a0b49d789fmr1298020f8f.32.1746588984536; Tue, 06 May 2025
 20:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <CAP01T75B87Vnq-kdq6gaNXj5xeOOiah-onm4weEZA=jm8W8JVQ@mail.gmail.com>
 <CAM6KYsuk060Fv43Djp4q57AwBcmmkHBitGgfSsCJZwbGqRmQEA@mail.gmail.com>
 <CAADnVQL_+5FiOwNEnaYZ-i52r4jDiStboWxA9VycARFboOjx6Q@mail.gmail.com>
 <CAP01T757KLkBx3FMAK8-7vYTO0v=RtWvkQpztS1Zugd8tHSnHA@mail.gmail.com>
 <CAADnVQKzgELtqZ_4pce7sOegE1i3azcija0w6Bn5OWH0LgpbQg@mail.gmail.com>
 <CAP01T75O90bgYeb1q1ot+=D9MxN3UXyji5T6mA+UsnPwQUF52g@mail.gmail.com>
 <CAADnVQKsjGFhqsZ6s8SRNbv=Fr3oU=o3GquvOwqg27S9m8B02w@mail.gmail.com> <CAP01T77bquNBKBRUC47bJkk-UvdWXeu7UPUhymuygLm0ojX7-g@mail.gmail.com>
In-Reply-To: <CAP01T77bquNBKBRUC47bJkk-UvdWXeu7UPUhymuygLm0ojX7-g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 May 2025 20:36:12 -0700
X-Gm-Features: ATxdqUFHdJt4_se_V6LajM4fK_cdrChlWKLPHIiPiiYgoCgjUGTW3PtMG37wlHI
Message-ID: <CAADnVQLauqDRatfDw=yCK+v86H3c2tfVGhXPb3bEPK3NSTM=dg@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/4] bpf: Fast-Path approach for BPF program Termination
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Raj Sahu <rjsu26@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, rahult@vt.edu, 
	doniaghazy@vt.edu, quanzhif@vt.edu, Jinghao Jia <jinghao7@illinois.edu>, 
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 7:11=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> We will unwind the callback, return control into kfunc, it will clean
> itself up and return to prog, and then we continue unwinding when it
> returns into caller BPF program.
> And we'll do exactly this with stubs as well.
>
> Program stub callback will return to kfunc, kfunc will return to
> program, and replaced return address causes jump into stub again.

Ok, so this is a new proposal where unwind would
jump back into kfunc, but it will also replace the address
where kfunc would have returned with a jump to 2nd phase
of unwinder.
So for
prog A -> kern -> prog B -> kern -> prog C.
In the first phase the unwinder will deal with C,
then let kern continue as normal code, but the kernel
will 'ret' back into unwinder machinery, so it can
continue to unwind B, then another jump back to unwinder
machinery to unwind A.

Yes, it can be made to work, but this is quite complex,
and it's really a combination of unwind and fast-execute
through kernel bits.
When the whole thing is fast executed there is only one
step to adjust all return addresses on the stack, and then
everything just flows to the kernel proper.
Much simpler than going back to unwind machinery
and without a seesaw pattern of stack usage.

> If we add it, sched-ext will replace their MEMBER_VPTR and other
> associated macro hacks.
> https://github.com/sched-ext/scx/blob/main/scheds/include/scx/common.bpf.=
h#L227

I really doubt it. It's fighting the verifier because the verifier
needs to see that bounds check. That's why it's macro with asm.

> > bpf_throw may stay as a kfunc with fast execute underneath or
>
> Yes, by having users write clean up code which is what they are doing tod=
ay.
> Which defeats the whole point of supporting assertions.
> Then it's a kfunc with a misleading name, it's
> bpf_fail_everything_from_this_point().

Indeed. That's a better name. 'throw' has an incorrect analogy.

> You do bpf_assert(i < N) and don't write anything to handle the case
> where i >=3D N, and arr[i] is not well-formed.
> This is the benefit to program writers: they can assert something as
> true and don't have to "appease" the verifier by writing alternative
> paths in the program.

That indeed was the goal of assertions, but I think it was explored
and it failed.
#define bpf_assert(cond) if (!(cond)) bpf_throw(0);

should have worked, but the compiler doesn't care about keeping
"if (!(cond))" like that.
All the asm volatile ("if .. were added
in __bpf_assert() form and in bpf_cmp_likely().
And they didn't succeed.
They're too unnatural for C code.
All uses remained in selftests.

> Does Rust keep executing the rest of the program when assert_eq!(x, y) fa=
ils?
> Whether we use tables to do it or have the compiler emit them or do
> anything else (how) is immaterial to the basic requirement (what).

The high level language can do it, because it's done at a compiler level.
rust->bpf compiler can be made to support it, but we deal with C and
bpf_assert(i, <, 100);
arr[i] =3D ..;
didn't fly.

> - Assertions are unnecessary.
>  - Then we don't have to continue discussing further, and we can just
> focus on fast-execute, and phase out bpf_throw().
> - They are useful, but not necessary now.

They could have been useful, but I think we already explored
and concluded that it's very hard to do true C++like throw()
in the verifier alone. Too many corner cases.

I also doubt that we can go with a compiler assisted approach where
the compiler will generate cleanup code for us.
Ideally the users would write
assert(i < 100);
and the compiler will generate cleanup, but
it cannot do it without explicit __attribute__((cleanup(..)
And if the users have to write it then
if (i < 100) return;
is just more natural without any complexity.

