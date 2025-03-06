Return-Path: <bpf+bounces-53461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E5DA54569
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 09:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECB03B000E
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753A62080C8;
	Thu,  6 Mar 2025 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYL/lECD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EE71A83ED;
	Thu,  6 Mar 2025 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251161; cv=none; b=MtE5NQtFSxRV2E1M1P8XQ728rUNMnsq6M88ghogEct2SK6iBD5A4zBC8DTQuYxtwFV9uuQttlSuqzRR/D2sxmKKXMJC0OR/WKDKTgrjJHQC23HsZvMo2fbYuZdaw7NsqxqR+7qlUmbPs0vL7CRH71jXHbwi+GSb8P5GNeJrwKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251161; c=relaxed/simple;
	bh=XXs8uZWN9WWnGCHphGrfM+z/OKcBjkW6AX8J7E+t69Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvWLY5dgc4v0EKiA4C0lVkR/6N00tWO9qOTVlp/SuUlo6DmYh2VwZyBd2mUG8smMFksk1f2HMDf8CNNSybkPjNeLjZJcstoIHMI59nin+VopCXeZM3FEIJUYt668ENrHPmMVXyGWi7+621HjOEuzYs/LcQI3unY/tji+TATz/54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYL/lECD; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-6ef7c9e9592so3532527b3.1;
        Thu, 06 Mar 2025 00:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741251158; x=1741855958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXs8uZWN9WWnGCHphGrfM+z/OKcBjkW6AX8J7E+t69Y=;
        b=WYL/lECD/6JlqWhX9RYHhAA2g2y+5llFJmL2bkMLkoS9yuVVPljQgSBG8lICn7iD5k
         otAGDP15oBIQJjrIC24CJZzYBsvLOEyQrgGvmQ7VXKcVDRy0g1v7JFQ1B0x2b/VO0K8M
         PZ71h/h1I4gAmn2qp9sGFGGJkCwA1ecOwplWxIsjcf7NB5/UnVMnYf5yw1Dx6WiR1OM+
         1fVsBlh5a96tjMCUFlk5TS1ujPv0CU2VMMwhfgIdcRrSfq2Ue2JD1JLzvSReg3IVUylk
         ZQA38y7nR4jlJvwfdAEoJMfzYsW5ER/GpedU2kcRw5YoLb73lFk3eti19JbUrMctagTg
         QmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251158; x=1741855958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXs8uZWN9WWnGCHphGrfM+z/OKcBjkW6AX8J7E+t69Y=;
        b=u3Dm5FrTpVtpxvABx06usUJrYAaw0N3wKuRjnqil+hPpcW7WQExz6/Q4o9v06YQTC2
         s2EgxO18p/jf/XFzL/t7ewCJ8U/jipMHpeybkF0RKjur85gRHcRAiPpvontZiQSUOSdn
         soiK2Zcuar6CKHm/xPss9PelYZj05BULPJKYNh+igm/+TzH5O2P4BBSExUMYM1h7DLy6
         w9NGlfQZ6MajglCrGfwh8IhmHBnoiLbGkDPsiVFJY2iA3QdMWhqzVqclzteyOYTTdEgp
         czOiYuT5cldeDXtzD//fK929N6aU1ZO38u8QplBSJeMSIJVnrjvZcI5zjU4sRyZ95uTA
         dPmg==
X-Forwarded-Encrypted: i=1; AJvYcCW1mOWHaOXmP0IapArRnt7tDHoD72lI2BCDKwSQhPTLlUbi7U6tnBk/226X1BqWo7Nd7PQ=@vger.kernel.org, AJvYcCW3oOT3+XjTnVzUTrOu66fw8EDk5m249DysahljvLIiFTe0SdiHlcrKDdSpqCosGJPVApEQoJPH@vger.kernel.org, AJvYcCW5U6SwoQBuoQpQaRxEbBHEvyqjC6N6k80NpNuxLGFct4Wzv98hF46094VdvpuCk63GDprx44MIcAaJbmzF@vger.kernel.org, AJvYcCWyAesTNLAt4b9i8uxF11/HZVY6LzLXP/iOirqrtUa1YbkNCLHWengE4RTC/gUGaoWv5hD+oqgYM4MQPFX3oN64PfX0@vger.kernel.org
X-Gm-Message-State: AOJu0YxxASEINJGo1aZ5GbPoQPI2XBp0zr2pYOBDXjKgSCrSos3de4ES
	cdpVjSdFCGApbWwMQ7JhhQw8BkjLQieqXksxygWAQ8U1GGUjipCQThVCElCyqTCe5pZDDt2V+eV
	HScX1S1czCauYJHvvU6WGop1lmzg=
X-Gm-Gg: ASbGncs3WXbzpAca2FJtMZnGMcNAlzivcKQtm/HWVqHHFkh0UCp7Av27ru56FLc+EcK
	nLYVOlDnpMT8hPXOfExWI7ufY+25evVbRo4n+izPqMlABodjEvXbfoOYaJc3TqtplDMOEqu7KhE
	KxlZSBvxUeToq8zLhrwDaW2TEWrA==
X-Google-Smtp-Source: AGHT+IHUPHaw0YZdo+mDMRAkSmdnWIm6D16Vg79ihR5A4Mv8LJil7rF/h/OfZk/ywEv5+Ey8+JWj4dl2X5zMiVr1zBQ=
X-Received: by 2002:a05:690c:2b03:b0:6fe:b88e:4d82 with SMTP id
 00721157ae682-6feb88e57c7mr3700567b3.28.1741251158459; Thu, 06 Mar 2025
 00:52:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303132837.498938-1-dongml2@chinatelecom.cn>
 <20250303132837.498938-2-dongml2@chinatelecom.cn> <20250303165454.GB11590@noisy.programming.kicks-ass.net>
 <CADxym3aVtKx_mh7aZyZfk27gEiA_TX6VSAvtK+YDNBtuk_HigA@mail.gmail.com>
 <20250304053853.GA7099@noisy.programming.kicks-ass.net> <20250304061635.GA29480@noisy.programming.kicks-ass.net>
 <CADxym3bS_6jpGC3vLAAyD20GsR+QZofQw0_GgKT8nN3c-HqG-g@mail.gmail.com>
 <20250304094220.GC11590@noisy.programming.kicks-ass.net> <6F9EF5C3-4CAE-4C5E-B70E-F73462AC7CA0@zytor.com>
 <CADxym3busXZKtX=+FY_xnYw7e1CKp5AiHSasZGjVJTdeCZao-g@mail.gmail.com>
 <20250305100306.4685333a@gandalf.local.home> <CADxym3ZB_eQny=-aO4AwrHiwT264NXitdKwjRUYrnGJ2tH=Qwg@mail.gmail.com>
 <CAADnVQJ0_+Hij=kf9eVPX_ZND=2=uDHaYPWvv1x-WmR5sZRSmA@mail.gmail.com>
In-Reply-To: <CAADnVQJ0_+Hij=kf9eVPX_ZND=2=uDHaYPWvv1x-WmR5sZRSmA@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 6 Mar 2025 16:50:58 +0800
X-Gm-Features: AQ5f1JpgFvunO0OQTqf93RDkyeUwF-IllYoHkeBCNOU1pNT2c-N8DSTxA6mOAMI
Message-ID: <CADxym3YMeAPpc+ozM2E7yW1qpB_arKJiDyAcRs8pW8sRqJZOZw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] x86/ibt: factor out cfi and fineibt offset
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, dongml2@chinatelecom.cn, 
	Andrew Morton <akpm@linux-foundation.org>, Rik van Riel <riel@surriel.com>, 
	Mike Rapoport <rppt@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 11:39=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 5, 2025 at 6:59=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > I'm not sure if it works. However, indirect call is also used
> > in function graph, so we still have better performance. Isn't it?
> >
> > Let me have a look at the code of the function graph first :/
>
> Menglong,
>
> Function graph infra isn't going to help.
> "call foo" isn't a problem either.
>
> But we have to step back.
> per-function metadata is an optimization and feels like
> we're doing a premature optimization here without collecting
> performance numbers first.
>
> Let's implement multi-fentry with generic get_metadata_by_ip() first.
> get_metadata_by_ip() will be a hashtable in such a case and
> then we can compare its performance when it's implemented as
> a direct lookup from ip-4 (this patch) vs hash table
> (that does 'ip' to 'metadata' lookup).

Hi, Alexei

You are right, I should do such a performance comparison.

>
> If/when we decide to do this per-function metadata we can also
> punt to generic hashtable for cfi, IBT, FineIBT, etc configs.
> When mitigations are enabled the performance suffers anyway,
> so hashtable lookup vs direct ip-4 lookup won't make much difference.
> So we can enable per-function metadata only on non-mitigation configs
> when FUNCTION_ALIGNMENT=3D16.
> There will be some number of bytes available before every function
> and if we can tell gcc/llvm to leave at least 5 bytes there
> the growth of vmlinux .text will be within a noise.

Sounds great! It's so different to make the per-function metadata
work in all the cases. Especially, we can't implement it in arm64
if CFI_CLANG is enabled. And the fallbacking to the hash table makes
it much easier in these cases.

>
> So let's figure out the design of multi-fenty first with a hashtable
> for metadata and decide next steps afterwards.

Ok, I'll develop a version for fentry multi-link with both hashtable
and function metadata, and do some performance testing. Thank
you for your advice :/

Thanks!
Menglong Dong

