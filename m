Return-Path: <bpf+bounces-18416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F1C81A735
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 20:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E421F2324B
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 19:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74999482F6;
	Wed, 20 Dec 2023 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmByK9jn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99448482DF
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3365424df34so4447431f8f.1
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 11:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703100034; x=1703704834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGqJoRBQ9gDcd2Qxx+30nyztH0vaHxEajbeHvBZX65E=;
        b=cmByK9jniv1sfa2RXzlpi9UvC+vHS9J2PDkbFOvALsYw6kQLoANovnBjlzvTBxckkZ
         DShkiEVXbCRRsdUR5c96wekHxUN2h53W1mnrH33eCYDfLJlY/x7Ez1I8NLFJieFKMYxj
         4Ow++iO7l1WvPmqwEnSL7YVQ9R8mEQQ+B9l5JUGaIXKoXUVnUUEFOoNvdV9SSYW0UlPO
         q9rdymdspBglA0oW1cuWQ3MvMrC2ip6bfzraWsj6WgjeDPhN2ISkzTIXwFfL+MUzXJyM
         strdUgHKAoU1zqGlDt6u5uECLA0RmmzEJ3ZAhReKEHpWKl0r7ZAEsi/uRkXYyAHq2HUd
         BTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703100034; x=1703704834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGqJoRBQ9gDcd2Qxx+30nyztH0vaHxEajbeHvBZX65E=;
        b=mLgSWtKQ88OLn7Y5FXci7xoJGQTypKhF0aIfvcAMeOsqgSJM57ZqJfMT44skSRNuy8
         nNaXddrF9OD0KpZaUkh2hxkjWCMlYQrCkHnC0i1iof9a5/7t8c6mT8LaKlPGI8jMAMR6
         tzvWGnhN96FGNfqbzl/71Nbtop46kQRv/EM6+/cficILIuX5g4gJ0eH2R3IiBzOVvn3k
         PdkU6jBU438c5utpaYEiOUCyIQbNlbxPWkP0gmeIX14i+WDOBaPHR+XkvKqcAP/xAlUK
         Bc81BUD7dllnflpwpSp5C1T0TACfGyaFkxndaJAKERIloumFjN3zNoGdicOojnTY0uOB
         AQJg==
X-Gm-Message-State: AOJu0Yx/VoVv0J7Q83EuKLKdlsHmSxpAVMsA8QYQMIOA2jP9kv4Ai8Ot
	2BS56Ss566unkj1M4iCnrxe0WIB51QOgKQsO/OtJMIv+
X-Google-Smtp-Source: AGHT+IEYIB8yfeSiziqVz8Sz3Qlbfq2gTj7lzyhyd+XdNUdqPDoZOjnT4KBXPRMCpleMUrtBklvKfyw6JF6o9Km03ZU=
X-Received: by 2002:adf:f0d1:0:b0:336:60ea:319d with SMTP id
 x17-20020adff0d1000000b0033660ea319dmr92627wro.63.1703100033458; Wed, 20 Dec
 2023 11:20:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220133411.22978-1-eddyz87@gmail.com>
In-Reply-To: <20231220133411.22978-1-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 20 Dec 2023 11:20:22 -0800
Message-ID: <CAADnVQJKbtFAKDo6LGTmufXO-eDptud6pymDJLA-=o-qtk4Z4w@mail.gmail.com>
Subject: Re: [RFC v3 0/3] use preserve_static_offset in bpf uapi headers
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Quentin Monnet <quentin@isovalent.com>, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 5:34=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
>
> Note:
> This RFC does not handle type pt_regs used for kprobes/
> This type is defined in architecture specific headers like
> arch/x86/include/asm/ptrace.h and is hidden behind typedef
> bpf_user_pt_regs_t in include/uapi/asm-generic/bpf_perf_event.h.
> There are two ways to handle struct pt_regs:
> 1. Modify all architecture specific ptrace.h files to use __bpf_ctx;
> 2. Add annotated forward declaration for pt_regs in
>    include/uapi/asm-generic/bpf_perf_event.h, e.g. as follows:
>
>     #if __has_attribute(preserve_static_offset) && defined(__bpf__)
>     #define __bpf_ctx __attribute__((preserve_static_offset))
>     #else
>     #define __bpf_ctx
>     #endif
>
>     struct __bpf_ctx pt_regs;
>
>     #undef __bpf_ctx
>
>     #include <linux/ptrace.h>
>
>     /* Export kernel pt_regs structure */
>     typedef struct pt_regs bpf_user_pt_regs_t;
>
> Unfortunately, it might be the case that option (2) is not sufficient,
> as at-least BPF selftests access pt_regs either via vmlinux.h or by
> directly including ptrace.h.
>
> If option (1) is to be implemented, it feels unreasonable to continue
> copying definition of __bpf_ctx macro from file to file.
> Given absence of common uapi exported headers between bpf.h and
> bpf_perf_event.h/ptrace.h, it looks like a new uapi header would have
> to be added, e.g. include/uapi/bpf_compiler.h.
> For the moment this header would contain only the definition for
> __bpf_ctx, and would be included in bpf.h, nf_bpf_link.h and
> architecture specific ptrace.h.
>
> Please advise.

I'm afraid option 1 is a non starter. bpf quirks cannot impose
such heavy tax on the kernel.

Option 2 is equally hacky.

I think we should do what v2 did and hard code pt_regs in bpftool.

