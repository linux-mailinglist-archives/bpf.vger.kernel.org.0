Return-Path: <bpf+bounces-18065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B275815662
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 03:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDC01C22FF2
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 02:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22AB1852;
	Sat, 16 Dec 2023 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtvIheE1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFACF17EB
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3363e9240b4so712876f8f.0
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 18:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702693796; x=1703298596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7kL+oLnIfpfo8KMgff0rTYsd0oAhtBTD/H7OzNeUy0=;
        b=EtvIheE1yNKB6zmrPsdFIOVxyLBX+siSrE0EH9cL6thyL6mvpgu0guySOqFA3YW1vH
         hU52+j8ViOQ1dodYu57mrvmJtYQEHokGQXzz2VWDQN+H4JBsdLjWQjGGosoUK7ggbk8D
         TIu4f2SzZnxw6Slr1yxt4Tm3Wb7rwNFZJxiawtIbsMA/lFh7A8MBTbm/4T98hKJDZoNP
         xdfwwCi+UQJIF99LE/uMfFO/ft0fsVnjy2/DP3l+4FCBb7uyrsbU/HBgEOJ01+f92vU+
         QVB6Ti3Ctv4D2jtY52smu/oCICpl80eAc/G96amb+pFyMO0ilpe+Ak3mnLAuSRHAdbcB
         H7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702693796; x=1703298596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7kL+oLnIfpfo8KMgff0rTYsd0oAhtBTD/H7OzNeUy0=;
        b=COmZUpX73VtTRApAS+MJbg+kGQ61itL0/IaVimvu7eanKUazsBJv6oPu10G6nes8D7
         vNyxmdgsYK54+zWDqDq9VV1ntcgcF9vyJOh0lXnnVz/ik3DhBz1Bu1Um6WjDFsuB2Q1x
         RsU5C4vXtfz8+kkcIxfhD0sFbVIL+uBfUiXXpVw7HzcJFjOuOVDQZks5PrK5VTZw/HW/
         gdcJAriGh3oUku6Kk0qxnKL5bgpQL9E39PvudJhg0brfk4EYrB/eM91o3hn3S4FnHGGh
         fxW4KDyRkh3pG3KzJwV+MbBne4jYD+OpZwOWM8m3Db5nIom3am9699DFXoHiz5Im4Jzw
         XbMg==
X-Gm-Message-State: AOJu0YwFzwQIg+rm/z4/bcs8Lq4IU5xnZ19mz6Xf70smAXgIhN0Q0Xik
	sqsfZPY1iCoAeFp7JvjVLs3w5jjshMFHETMyMLg=
X-Google-Smtp-Source: AGHT+IHLV7LOQjrlGUN3KqSxEV2pwe+tnMCRMIzxkhFmWbM7dv3jMhTquFnMNS2q1dKdGoLLLbdRVoYYqvKsi9VWYDw=
X-Received: by 2002:adf:f20a:0:b0:336:4367:a731 with SMTP id
 p10-20020adff20a000000b003364367a731mr2461779wro.41.1702693795865; Fri, 15
 Dec 2023 18:29:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216004549.78355-1-alexei.starovoitov@gmail.com> <rcozfumr3cg2rsvth7d4e2tash7vqrbumddoina2ivqlftyo7b@inoaz3nkvojq>
In-Reply-To: <rcozfumr3cg2rsvth7d4e2tash7vqrbumddoina2ivqlftyo7b@inoaz3nkvojq>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Dec 2023 18:29:44 -0800
Message-ID: <CAADnVQLkxq8RGwaTcm=QxaDJ6gOOxJx8gtwM5B0M+N8YaGHRNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] s390/bpf: Fix indirect trampoline generation
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Peter Zijlstra <peterz@infradead.org>, Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 5:56=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> On Fri, Dec 15, 2023 at 04:45:49PM -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > The func_addr used to be NULL for indirect trampolines used by struct_o=
ps.
> > Now func_addr is a valid function pointer.
> > Hence use BPF_TRAMP_F_INDIRECT flag to detect such condition.
> >
> > Fixes: 2cd3e3772e41 ("x86/cfi,bpf: Fix bpf_struct_ops CFI")
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  arch/s390/net/bpf_jit_comp.c               | 3 ++-
> >  tools/testing/selftests/bpf/DENYLIST.s390x | 2 --
> >  2 files changed, 2 insertions(+), 3 deletions(-)
>
> IIUC F_INDIRECT trampolines are called via C function pointers, and
> func_addr does not participate in any call chains, but is rather used
> as a source of CFI information.

Yes.

> So returning to %r14 is the right
> thing to do.
>
> Thanks!
>
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

Thank you for the quick review.

