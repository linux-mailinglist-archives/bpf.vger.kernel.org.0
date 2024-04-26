Return-Path: <bpf+bounces-27955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E0B8B3E56
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE4B287E09
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 17:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E649916C688;
	Fri, 26 Apr 2024 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxi60XLr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195A115AAC3;
	Fri, 26 Apr 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152943; cv=none; b=XNj4aWZxMQA2RJ3CPA/67G7Sv9pArPXsNC1wI8npYeYgVH79/kM+jzPljToQ28zYLxExAEWm4HeUF97CfRN4v60I8W4ecqZUTB0vGQMRehb2gePAXJTib5Obh1iEmIY7+ym8gL8Z1BXxoApndGOjbBRtoDjJ00Nhsnlw+fiQmZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152943; c=relaxed/simple;
	bh=PAf/263nrw/kABvtzmEaTtx8i3mzP5lLmHYjKVIsNZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ff8OfSCj4ZS6ScBfowe78N+gf8Hq5qhtF1KsmkOv2z+9G0zxDgaWgC7FmgCwH4DBwXwUGW5SAsLVbb1uVKTxHkagU6KAfn0pN+bgxTabpqiDeSQlDWSxhhYQyS7yGPvYotTrl2645dsRhoPlrdoIBx9jCvy20nPGPlakgNvZvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxi60XLr; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5f807d941c4so1944605a12.0;
        Fri, 26 Apr 2024 10:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714152941; x=1714757741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fJMTF64jFuyHLBH5JGA8xPvhwH8zh6RJUjITDFFVtA=;
        b=kxi60XLrJthsM4TpJFAG7CejBFfz6RKozznC0JKdOfkIFqW+6SB2CjKZzMtEMFjr8F
         Gxq8zhnhUXtIJw9VXFA+E6WwBFcKonlpH1T5/FhRMLITnsq78zY+4XR/1CH8HOJcBXWU
         +noaVJ1Hm6lX5czJ5f2BAfTG7wTllvPudsduxDWTTMac/PoVlRKBbEzzfFXJcAoJl25a
         kANhLcY6B4UKS9SrBkjvbNXGJnMkG36qTaZpoL1l/lmzcEiwHNTmLawi7SULLrHemuXp
         aFxwHmiZX4G6Xr+3GYcSONVAFCkwZlO3Js4q1RdMs3Im0sAiHebD6qiLyaxAfAzhV2aJ
         349A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152941; x=1714757741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fJMTF64jFuyHLBH5JGA8xPvhwH8zh6RJUjITDFFVtA=;
        b=iFrGUmCCmP+Q6x3PPqMfgB/DyWEpwRXj+mtzkJKeESJO/1zrGYpAy0usfdHYJtpH0u
         rAhenGLa0FjDZmHZ+x2x1/yGeGfUx8bybAqaMkStUwsdw/6AUMwN1269oh01kaiIUBg7
         rx2Xqo6AycDFC21dXP72XN4VA2gMlr4nWQqac/rkwjpV9qZf6U/A3XfUwpy+JtNrYDI1
         KSZuvehv+wt1u4GiPb8YHtCpZQDKEuYxWrqnvfM5/c4QBJ6zQFH8oFc2xFtxqWVfOjSE
         P8nKDBB1xFajjBuBNKVKHPUqd+ZgOYghffH9O7O5D8RjHkZ2w8HDn9vt/fxotx2z6j66
         tqSw==
X-Forwarded-Encrypted: i=1; AJvYcCUPm2dob2/BJOFeq+CTMDexzKoszviiASMFKcye6hGGhxisy3enGsfwSNmmpuyXjz6Arfhy/0HY/WyQn5ZQMfSh7C0KlzraixkAWEnfY6fgsuN/vL/nAQvHXRWwsoyqKX3b
X-Gm-Message-State: AOJu0Yxysiq6IT9ephZ0m3Zh8KJh/mVf0TbvHVIoyYJT45b9C3SmmzAo
	WYAIPDsB0b68u/JIB0NeSYCD9lmjm5zvZDt18+2PtKwL/Y9CgbhZPTtyVyJixuSv3fKopqndgXV
	Re/UokaaVtCGEsRJKcpgVoNvksIw=
X-Google-Smtp-Source: AGHT+IHOJPythzKlh0oMKWUL/9evOI+gfwgln2taU8mn912UoIjEWRPPlBtESYeZ643vcu3w8LX5gI6S89+Q2XmxCuk=
X-Received: by 2002:a17:902:ea11:b0:1eb:dae:bdab with SMTP id
 s17-20020a170902ea1100b001eb0daebdabmr3197581plg.46.1714152941245; Fri, 26
 Apr 2024 10:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426121349.97651-1-puranjay@kernel.org> <20240426121349.97651-2-puranjay@kernel.org>
 <CAEf4BzbBBpsuCGgombEj1N8f97iKrMr2WXSoU8jOUfKSqLXnyw@mail.gmail.com> <mb61psez8vzbu.fsf@kernel.org>
In-Reply-To: <mb61psez8vzbu.fsf@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 10:35:29 -0700
Message-ID: <CAEf4BzZejgfw=GiX_LTWVupRzrKVaX5Ky6L3wziSoquEFUju2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] arm64, bpf: add internal-only MOV
 instruction to resolve per-CPU addrs
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Xu Kuohai <xukuohai@huawei.com>, 
	Florent Revest <revest@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 9:55=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Fri, Apr 26, 2024 at 5:14=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> >>
> >> From: Puranjay Mohan <puranjay12@gmail.com>
> >>
> >> Support an instruction for resolving absolute addresses of per-CPU
> >> data from their per-CPU offsets. This instruction is internal-only and
> >> users are not allowed to use them directly. They will only be used for
> >> internal inlining optimizations for now between BPF verifier and BPF
> >> JITs.
> >>
> >> Since commit 7158627686f0 ("arm64: percpu: implement optimised pcpu
> >> access using tpidr_el1"), the per-cpu offset for the CPU is stored in
> >> the tpidr_el1/2 register of that CPU.
> >>
> >> To support this BPF instruction in the ARM64 JIT, the following ARM64
> >> instructions are emitted:
> >>
> >> mov dst, src            // Move src to dst, if src !=3D dst
> >> mrs tmp, tpidr_el1/2    // Move per-cpu offset of the current cpu in t=
mp.
> >> add dst, dst, tmp       // Add the per cpu offset to the dst.
> >>
> >> To measure the performance improvement provided by this change, the
> >> benchmark in [1] was used:
> >>
> >> Before:
> >> glob-arr-inc   :   23.597 =C2=B1 0.012M/s
> >> arr-inc        :   23.173 =C2=B1 0.019M/s
> >> hash-inc       :   12.186 =C2=B1 0.028M/s
> >>
> >> After:
> >> glob-arr-inc   :   23.819 =C2=B1 0.034M/s
> >> arr-inc        :   23.285 =C2=B1 0.017M/s
> >
> > I still expected a better improvement (global-arr-inc's results
> > improved more than arr-inc, which is completely different from
> > x86-64), but it's still a good thing to support this for arm64, of
> > course.
> >
> > ack for generic parts I can understand:
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
>
> I will have to do more research to find why we don't see very high
> improvement.
>
> But this is what is happening here:
>
> This was the complete picture before inlining:
>
> int cpu =3D bpf_get_smp_processor_id();
> mov     x10, #0xffffffffffffd4a8
> movk    x10, #0x802c, lsl #16
> movk    x10, #0x8000, lsl #32
> blr     x10 ---------------------------------------> nop
>                                                      nop
>                                                      adrp    x0, 0xffff80=
0082128000
>                                                      mrs     x1, tpidr_el=
1
>                                                      add     x0, x0, #0x8
>                                                      ldrsw   x0, [x0, x1]
>             <----------------------------------------ret
> add     x7, x0, #0x0
>
>
> Now we have:
>
> int cpu =3D bpf_get_smp_processor_id();
> mov     x7, #0xffff8000ffffffff
> movk    x7, #0x8212, lsl #16
> movk    x7, #0x8008
> mrs     x10, tpidr_el1
> add     x7, x7, x10
> ldr     w7, [x7]
>
>
> So, we have removed multiple instructions including a branch and a
> return. I was expecting to see more improvement. This benchmark is taken
> from a KVM based virtual machine, maybe if I do it on bare-metal I would
> see more improvement ?

I see, yeah, I think it might change significantly. I remember back
from times when I was benchmarking BPF ringbuf, I was getting
very-very different results from inside QEMU vs bare metal. And I
don't mean just in absolute numbers. QEMU/KVM seems to change a lot of
things when it comes to contentions, atomic instructions, etc, etc.
Anyways, for benchmarking, always try to do bare metal.

>
> Thanks,
> Puranjay

