Return-Path: <bpf+bounces-40686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DD998C0CF
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 16:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE30C285829
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C5E282F7;
	Tue,  1 Oct 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIoF4RLA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B61C6F73;
	Tue,  1 Oct 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794436; cv=none; b=CkFCLLZ15QMb9rMBX8w5lpMywDjbUOmtCqqeFJ6AvSsXjQr5PLWyZoZ+e/KEbL1v40YCmiiR/j/nbxBrvbqNV4P7Gvguf2G77HnlgGa9CWghFJh4xjB3HUXXjeYLnb5ryK5jN80baazPezTBvYQJn7ZaYz3AC4kg3rBdCd0oOFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794436; c=relaxed/simple;
	bh=NiNTmNONqUG6rArLU6+DW/koYHBP+PdkO5eQL5qKW5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGzE361Ky27XXrz9vSHdhAxkCdsKL2mXIVHzUyFQp91Ljmkj6rPXQ78SXE6dEsHMDkFdWksdoXXT6IEpVGdfM6MKPASQg5wHYKoOy4/HT6DW8XAXwICYAQcT8nbot719qTvcLI11G7/BFHQbHtFHyTA1NQPGxHZ1C+2PdU9RAuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIoF4RLA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37cdb6ebc1cso2160624f8f.1;
        Tue, 01 Oct 2024 07:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727794433; x=1728399233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSTnPU9v6H2GxBsNTOAiZzPo6DZqtIPh6ogHLJkD69Y=;
        b=cIoF4RLAJ5CKomWNW2LZn2p/in6XaxaKLzxMj/AfmU4vVPEI5fcbc2uQ6734WwsH/D
         VbW2Gz1vseKhOclIVlLJeMUow+KlnVlmh6GgAO0PQJgEIHqEUdGlaYEsUB5GZ0yoLMIt
         rJjW40tlq7OXis+Trc603C1pUbCe5aDN2hAnBGRYkXYN9AWJjezLEf+0wlnC37R0eedr
         IaTkcu6M+xvzuOPNCnZANxhuWK7+tuhoUrJ8tc+LZ/9n5zsQYtBrZutqLHjuLicYy8Ad
         GvpgVNxzB2sn/slp14qP0aJX7yUjVBvppzhsBel3en5EYzRcdf+VTz5ypepb7nRYgunc
         dg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727794433; x=1728399233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSTnPU9v6H2GxBsNTOAiZzPo6DZqtIPh6ogHLJkD69Y=;
        b=XyFl9/KMIw/xKQfRv6h6rhqXWgVORH/6hlm4QFr2A5zl+TMcxj+59s34ybfzlUeSv1
         XBzFi2PV3e3DHxQrnCCB+xj276qORjQnKDIHP8Xujo1Eu9pPQjf+KqiEM843Wh+gXI2c
         llXuBDDHEtasi1buwLcvL5y/zWD7XaydR32OnUPoTWSQWAubbZUiW5um4MImBpVWO/Pf
         RBhzN0OXwfFQ+Sgxs8H7vHUo2Qb8a4aUW/7qPXi1kxZzsUQ0gA07xc8cYZJHNsH0dsZo
         eNbh4+qJQ/K/wXK3m4HiUGsncV2Vil8JbKhm0hGC3bkaKBC1x66xo9/pJkvJixj/QFIw
         Gggg==
X-Forwarded-Encrypted: i=1; AJvYcCUlydnOAlaU0RhrN493vW3f4XIs4uaslbMQ/EI+905H4aOyxHxZ5ezVl5I0GPf7c1kopr1WEPEeaWDV+ZBl@vger.kernel.org, AJvYcCVZfto3bu0yMVvLB5sMqg0Gb4BU6AWLdFnA7HvMA+42qCOQoU3naMSJwhu8DP9HM/H+0Xo=@vger.kernel.org, AJvYcCW01P2UxcSlPZTG4Q4y0IDMCjvC0HEw9R0vtLm5UMgRGb7BcGyqBTZ4I0m88Z2u26DTn4/gK9WQo2On+04+M9lQVjEu@vger.kernel.org, AJvYcCWL4OUHcvGfPxT7i4gg8kepsPWnMkPRvfw01jAV1PPHMy7BGKTVgbwY/ky68Y/bhRtJVZQV/IfzXg4sPuy5@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlrv6C5gmesX2OGkjCL8Nm31H1QYkSfQ6dQpFJJGnaM6CGrgHp
	55IlLIhrCM06Glu1QRpES7Gkh2DAaUcagUzCoj5BO7/L5XwUpR0qAZ4KoyyeR/J9ZWICpXMnEs+
	+BaTI/5gwKhx9AEhbiEH/FigrfGXNvvPp
X-Google-Smtp-Source: AGHT+IEm8GKzd4fqUPp6LAzM4CsjfnUSOgffnLlYkAgZo42PyQhxjWYeeN/iWESnCrPx+63wt9+U+2OjWQ/iO36f9Zg=
X-Received: by 2002:a05:6000:e42:b0:37c:d2d2:7f5a with SMTP id
 ffacd0b85a97d-37cd5aef979mr6359211f8f.32.1727794433399; Tue, 01 Oct 2024
 07:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915205648.830121-1-hbathini@linux.ibm.com>
 <20240915205648.830121-18-hbathini@linux.ibm.com> <CAADnVQL60XXW95tgwKn3kVgSQAN7gr1STy=APuO1xQD7mz-aXA@mail.gmail.com>
 <32249e74-633d-4757-8931-742b682a63d3@linux.ibm.com> <CAADnVQKfSH_zkP0-TwOB_BLxCBH9efot9mk03uRuooCTMmWnWA@mail.gmail.com>
 <7afc9cc7-95cd-45c7-b748-28040206d9a0@linux.ibm.com>
In-Reply-To: <7afc9cc7-95cd-45c7-b748-28040206d9a0@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Oct 2024 07:53:42 -0700
Message-ID: <CAADnVQJjqnSVqq2n70-uqfrYRHH3n=5s9=t3D2AMooxxAHYfJQ@mail.gmail.com>
Subject: Re: [PATCH v5 17/17] powerpc64/bpf: Add support for bpf trampolines
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"Naveen N. Rao" <naveen@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Vishal Chourasia <vishalc@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 12:18=E2=80=AFAM Hari Bathini <hbathini@linux.ibm.co=
m> wrote:
>
>
>
> On 30/09/24 6:25 pm, Alexei Starovoitov wrote:
> > On Sun, Sep 29, 2024 at 10:33=E2=80=AFPM Hari Bathini <hbathini@linux.i=
bm.com> wrote:
> >>
> >>
> >>
> >> On 17/09/24 1:20 pm, Alexei Starovoitov wrote:
> >>> On Sun, Sep 15, 2024 at 10:58=E2=80=AFPM Hari Bathini <hbathini@linux=
.ibm.com> wrote:
> >>>>
> >>>> +
> >>>> +       /*
> >>>> +        * Generated stack layout:
> >>>> +        *
> >>>> +        * func prev back chain         [ back chain        ]
> >>>> +        *                              [                   ]
> >>>> +        * bpf prog redzone/tailcallcnt [ ...               ] 64 byt=
es (64-bit powerpc)
> >>>> +        *                              [                   ] --
> >>> ...
> >>>> +
> >>>> +       /* Dummy frame size for proper unwind - includes 64-bytes re=
d zone for 64-bit powerpc */
> >>>> +       bpf_dummy_frame_size =3D STACK_FRAME_MIN_SIZE + 64;
> >>>
> >>> What is the goal of such a large "red zone" ?
> >>> The kernel stack is a limited resource.
> >>> Why reserve 64 bytes ?
> >>> tail call cnt can probably be optional as well.
> >>
> >> Hi Alexei, thanks for reviewing.
> >> FWIW, the redzone on ppc64 is 288 bytes. BPF JIT for ppc64 was using
> >> a redzone of 80 bytes since tailcall support was introduced [1].
> >> It came down to 64 bytes thanks to [2]. The red zone is being used
> >> to save NVRs and tail call count when a stack is not setup. I do
> >> agree that we should look at optimizing it further. Do you think
> >> the optimization should go as part of PPC64 trampoline enablement
> >> being done here or should that be taken up as a separate item, maybe?
> >
> > The follow up is fine.
> > It just odd to me that we currently have:
> >
> > [   unused red zone ] 208 bytes protected
> >
> > I simply don't understand why we need to waste this much stack space.
> > Why can't it be zero today ?
> >
>
> The ABI for ppc64 has a redzone of 288 bytes below the current
> stack pointer that can be used as a scratch area until a new
> stack frame is created. So, no wastage of stack space as such.
> It is just red zone that can be used before a new stack frame
> is created. The comment there is only to show how redzone is
> being used in ppc64 BPF JIT. I think the confusion is with the
> mention of "208 bytes" as protected. As not all of that scratch
> area is used, it mentions the remaining as unused. Essentially
> 288 bytes below current stack pointer is protected from debuggers
> and interrupt code (red zone). Note that it should be 224 bytes
> of unused red zone instead of 208 bytes as red zone usage in
> ppc64 BPF JIT come down from 80 bytes to 64 bytes since [2].
> Hope that clears the misunderstanding..

I see. That makes sense. So it's similar to amd64 red zone,
but there we have an issue with irqs, hence the kernel is
compiled with -mno-red-zone.

I guess ppc always has a different interrupt stack and
it's not an issue?

