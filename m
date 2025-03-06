Return-Path: <bpf+bounces-53446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44C3A54149
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 04:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2A1171B18
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 03:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66825199396;
	Thu,  6 Mar 2025 03:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imXWcO28"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367622E40B;
	Thu,  6 Mar 2025 03:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741232375; cv=none; b=UdKwvbNlDLRz2FrfmH9ON6kIWQVRIA7KVwAmyMTjmwQZ36fXRSbKOiRBY7n2pwM35Ma8elpOt4Q1VvIHT1lWdqXJ4zMvjF3vc9AHtncK3UwtQAxk7Pn7wNAN8fv3LXciIPcHsabKWTXmfQZ08SoX7GrrOuTjtyVdh7CCbQUAQJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741232375; c=relaxed/simple;
	bh=f/eEcM0NHe7IojjfcsfekX/bHp43CZXGZ50QyLmEDFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLhF4GF+7R8mFRWC3aI/kG77eS61YnokII1REd9EGIcSm9tNEO/yMX5gOBju6cmq/PzQMwMmDwDARA/9TjYR9H3uecx/OCw/CN3X6ZX55vDsw8pVXJ1yfOYDKYls10EYcFxEMMlwQaDpDitsrq0aNXO1JM/cT++GFk71qgj4K7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imXWcO28; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390f5f48eafso100488f8f.0;
        Wed, 05 Mar 2025 19:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741232372; x=1741837172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/eEcM0NHe7IojjfcsfekX/bHp43CZXGZ50QyLmEDFY=;
        b=imXWcO28sFQSwdqdtFFKH5wI8zco1783Zvzk3pPMG1c37ABzqikwNE07Sf2n1j7Tv6
         oDqqEuPDAlI0OHUPYVekyrKtEAGzFPfUWt7GtjaSLn6+MJQTMwkxPk0RKkI+pmCqwx6R
         QL9J96WMbS1Qg5bxgf2dmM0pn9EbEwk9iw1rSFVET/MN+4jwvGnU2KUpxi5txtig1b3U
         vcGK7sFuBzrmJuZY1uRPRC9j+MH+pEEe6ff73kT9StPBDX/AA2523LEmi3P7OtoESymP
         fmjF/BHMmR/1/xtfDiDGstcqXRdIRAjNdy0AWMZk/FFT5PrXzezki8Hr2Tf+PvPr1LWh
         CAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741232372; x=1741837172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/eEcM0NHe7IojjfcsfekX/bHp43CZXGZ50QyLmEDFY=;
        b=NciaTwSHBlbE7RfeasEefJn05YTUmHHYBohjrCTpfX8M7kKHcjQ5fP2oJF4MAi69zl
         jxe2qrcQYr1lsxuk7OGK+FGYoykRTSxXkOAYhtJCp0dskzP0Gfg3lbiyd/obLY339rMv
         1fw9FvN3TmMzc/wUaduEq9xOQVgOKuiFvQZxgVbAV5Xo17d0AA3yoyTl5iXFJJIXoXnr
         eftAESIDznupEhA7Bkeh3sqe+3ELMH5WYGGIRbv6Ib8JYz+eieVZdPOJ4jPioGTR6gw/
         eTNcutmK+2Hb0PX7oSdbd+0qdOckc/y9nJiRZPnF7beJnFHyYTrETm1wI2OqNcYW/T4a
         /gVw==
X-Forwarded-Encrypted: i=1; AJvYcCUyp/JaKkqb5HBCvgsuE2tpHhd+mBg3GFTIPDA5TACbAoGvZurAAvWQqXCySx2tUrfo12U=@vger.kernel.org, AJvYcCV7Q4STafZGOArg+POUghCFHJ3CJEXj3GlvAWXnkQ4T78V3LbIVNg1MTzEqSLTnCTmb0jsRugjHMW09Xyqp@vger.kernel.org, AJvYcCVA9UGjgZgSHi8/zLW6cZBWhEKczSf2q5CrvjUVsdY+KXFNaQXAF9dwOId40EnEzDR0VOaQ/fCzCiwNv5P4ibb0fAbl@vger.kernel.org, AJvYcCWUh6lYp2lSvjZg1VtYT76iF+Jm/n2z0sYeMG3kKAVxSlnjAdYFmKPT1EW56x77AqheJP77NLWg@vger.kernel.org
X-Gm-Message-State: AOJu0YzuMcdKSMgAK/tuyL0iT+3ImC67hFV1jfiHJLFIPD8UJXF06iUI
	5wAPRx1Xk3x5BPqmkqQ/EB7KMi622VbxiVZp8qKO8SKbubfohxwZqV1N3uwYqXUPV60qnf9NkQj
	cznus4z9U0WgDzT8vLxZiXBxbdFM=
X-Gm-Gg: ASbGncuF9/0GMheFrqqxDqM4FRifzx37/g3Bb1HIlbbue516Mev2MTxVDNG6XYdcnYK
	xq+terOhgndUPntTkSmalUKNgISRwBsHCkBsExhyNtIOcItFgyAimpN/YD3efSLYuntmH2DXa9M
	L7hJjVp0ARTLlIHEVkUyVksOq97W9M4Ei3jraSmc84dg==
X-Google-Smtp-Source: AGHT+IH27dDGyBt7hd/VD86i6Z5HrEQ87tPCL5LhwJp6YDp6zkaw2KXN1sF3oSjJz4rUkFgqQ7BDSNeVdPcCH+k+1EA=
X-Received: by 2002:a5d:59ab:0:b0:391:1139:2653 with SMTP id
 ffacd0b85a97d-3911f7d2142mr4539340f8f.52.1741232372007; Wed, 05 Mar 2025
 19:39:32 -0800 (PST)
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
In-Reply-To: <CADxym3ZB_eQny=-aO4AwrHiwT264NXitdKwjRUYrnGJ2tH=Qwg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Mar 2025 19:39:20 -0800
X-Gm-Features: AQ5f1JrlMjvbkNliJ-RM0--naYFcbVQdQvx8bndtQJGQK7ImHRvWRfp852lYwK0
Message-ID: <CAADnVQJ0_+Hij=kf9eVPX_ZND=2=uDHaYPWvv1x-WmR5sZRSmA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] x86/ibt: factor out cfi and fineibt offset
To: Menglong Dong <menglong8.dong@gmail.com>
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

On Wed, Mar 5, 2025 at 6:59=E2=80=AFPM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> I'm not sure if it works. However, indirect call is also used
> in function graph, so we still have better performance. Isn't it?
>
> Let me have a look at the code of the function graph first :/

Menglong,

Function graph infra isn't going to help.
"call foo" isn't a problem either.

But we have to step back.
per-function metadata is an optimization and feels like
we're doing a premature optimization here without collecting
performance numbers first.

Let's implement multi-fentry with generic get_metadata_by_ip() first.
get_metadata_by_ip() will be a hashtable in such a case and
then we can compare its performance when it's implemented as
a direct lookup from ip-4 (this patch) vs hash table
(that does 'ip' to 'metadata' lookup).

If/when we decide to do this per-function metadata we can also
punt to generic hashtable for cfi, IBT, FineIBT, etc configs.
When mitigations are enabled the performance suffers anyway,
so hashtable lookup vs direct ip-4 lookup won't make much difference.
So we can enable per-function metadata only on non-mitigation configs
when FUNCTION_ALIGNMENT=3D16.
There will be some number of bytes available before every function
and if we can tell gcc/llvm to leave at least 5 bytes there
the growth of vmlinux .text will be within a noise.

So let's figure out the design of multi-fenty first with a hashtable
for metadata and decide next steps afterwards.

