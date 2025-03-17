Return-Path: <bpf+bounces-54157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D00A63C96
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 04:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FB53AC26D
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 03:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFB61632E6;
	Mon, 17 Mar 2025 02:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6AhLLBD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0D218BBB0
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742180328; cv=none; b=BE3U+fyXNJVgWEeO8T1b65l0PuKXOPxzVRpPcbjG+Qcm6iAb9pea0530B3VUYaFFZXy14rqEESZnQ3aAM/w6HihY34wAfEhZqj/akvfPDtjCAxlH1taXgq4DWFICwtbLiGBW1wH6M5B/lqZK+iJCTfM8oELgZucViV6yNrW6lls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742180328; c=relaxed/simple;
	bh=13yvj5krrl6E9jnmMEhRzLUwYHXniRoOOiUU5IJiCWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+w/wbXzDLdxMoD59h6FIKyuxIqzQnB9SA2aHzHVIq2FKCDAF4ncvX0GKzRv2NvphoA1xBem7OVm2eROhv8zwnj8g/ktw35JmPchV39obkWhBuFYseCOlbbe2AvGUqV1YmRcJQuJx0oZA2McPI19YZe86tzry7axcsanPzThjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6AhLLBD; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476a57a9379so14769431cf.1
        for <bpf@vger.kernel.org>; Sun, 16 Mar 2025 19:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742180325; x=1742785125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJHOXmMHFhTPCZVIBP4tqeTzAQJ2H0JWwUkzr+VLRv8=;
        b=d6AhLLBDcuEG1psN87Jtjdkc5lOWXVcwyBZdk8xuQiuTaSZTdsMYrKMexjkzpGBdUT
         /7T8VvTE9wfsTB6e/bwBCMCJQsRgrLDgoN5p5ECfIkJfYsDsXRs+Mc3XVWluzu2vGkF+
         biKM04ePvcXNez5Pq0vKEE8QPsYdul7FcarG80eE7qJDXKNy7DvBhnylwAjU+uabq+TS
         YqQUhprSSdqHj0GTBYcdP/e4p7BjSCekS47hRMnESce1qpVJO8VzT83WwQeMdxHwun0k
         nU2wn6pEeRcgCs/i7HHbB2FO+PvaEWtJARBBDZfJGFZpFoVI0K4CXKfe36Z/j7hB1gQ/
         z3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742180325; x=1742785125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJHOXmMHFhTPCZVIBP4tqeTzAQJ2H0JWwUkzr+VLRv8=;
        b=mA6j68H1SRwjc2if5ZmUwXI6BKCyzVtaES4ymFNmv+1Me+KY48pQCkXewPXQZkab4O
         KY/Xy45/Zxb+KuPdldO/aEl+6r6CZ+u1f73xqPaxhWKfNB8hd5bmGOvWJqXAWBXhpRdc
         ZjPVi01bwgjoTij8qseZMmT2Y9bG3pEVLfur0+CCs2NIFzv1O+LpjAyukOXjvn0XnApy
         Wgp+eDNDUE/ZSZ5fOGhTL4OmyDft/HsagglnA1Nf9WiJblcrECtnSZkm1hDUJbRDSg4p
         wfzZWwKJ9/wOjrzDfQa5uWCbhaQyTSuhA0XNpl10WUwX2yZB5PqpEfCriXp6cAgGD160
         pTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVycGBQwR/BZgCWiuaNmcq5na/1ROTT/kJB638Dq9aP0xEhjgLmQdmWpYFO6p7IsrBkLGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybUjdJ3k4UvMbPUthtsUNHC8DU2jn8etKWIjoCDXWBfWxUoFvO
	bljbzeUvZGk3yjD5q6aEiWrG9QiAVl+7SIS+x9+Tpe8p+w9P4p1GBZyi9eoaNyV0MZBScCfzSOw
	efcQzPREqLvGUH/pNOaQpL1Jfl9k=
X-Gm-Gg: ASbGncsZ5fGhwW0a0QHSz47XSKLkREFrK9gcrmucNVley8sm3VSXvqS3i1yKifJ4/Pq
	qtvb91prC8g3IFhRGDxI4hwUx+gqB9pyiX2EupRRcuXoX4hUVhbT/8MbvCqvZ9gl+tiTRXL4zWa
	7nlsnhRPTpR4TQ5AFNYbPfqyIIkRMcbfSPmHUsppLrWH+SQMwLKS1UBtnju9c=
X-Google-Smtp-Source: AGHT+IFISnow+315mUIhBfKvFnz3za89jozIfDqr6VRDIud+7dDHLSsYSLr4w2/sbTSYzDkgU9MXV5Wzwx/miDQEzBk=
X-Received: by 2002:a05:622a:6bca:b0:476:78a8:435c with SMTP id
 d75a77b69052e-476c8142f0dmr135701061cf.16.1742180325302; Sun, 16 Mar 2025
 19:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317015755.2760716-1-hengqi.chen@gmail.com> <CAK3+h2z4AGA8ekAcz3q5bALp1S0hXjJEq2roMAdq6MdKdPhtmg@mail.gmail.com>
In-Reply-To: <CAK3+h2z4AGA8ekAcz3q5bALp1S0hXjJEq2roMAdq6MdKdPhtmg@mail.gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Sun, 16 Mar 2025 19:58:33 -0700
X-Gm-Features: AQ5f1JqKh0h6W9bWmDdx5y5oVefPnrWtyZ5y2zdIfKsYqKrIWnq5EqiBbH29kWg
Message-ID: <CAK3+h2zts0v7dGjL6P0Pr05bfLDyhn+kQEYVCMr0ShzxymFW5Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Use move_addr() for BPF_PSEUDO_FUNC
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, chenhuacai@kernel.org, 
	yangtiezhu@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 7:41=E2=80=AFPM Vincent Li <vincent.mc.li@gmail.com=
> wrote:
>
> On Sun, Mar 16, 2025 at 6:58=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.co=
m> wrote:
> >
> > Vincent reported that running XDP synproxy program on LoongArch
> > results in the following error:
> >     JIT doesn't support bpf-to-bpf calls
> > With dmesg:
> >     multi-func JIT bug 1391 !=3D 1390
> >
> > The root cause is that verifier will refill the imm with the
> > correct addresses of bpf_calls for BPF_PSEUDO_FUNC instructions
> > and then run the last pass of JIT. So we generate different JIT
> > code for the same instruction in two passes (one for placeholder
> > and one for real address). Let's use move_addr() instead.
> >
> > See commit 64f50f657572 ("LoongArch, bpf: Use 4 instructions for
> >  function address in JIT") for a similar fix.
> >
> > Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
> > Fixes: bb035ef0cc91 ("LoongArch: BPF: Support mixing bpf2bpf and tailca=
lls")
> > Reported-by: Vincent Li <vincent.mc.li@gmail.com>
> > Closes: https://lore.kernel.org/loongarch/CAK3+h2yfM9FTNiXvEQBkvtuoJrvz=
mN4c_NZsFXqEk4Cj1tsBNA@mail.gmail.com/T/#u
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >  arch/loongarch/net/bpf_jit.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index ea357a3edc09..b25b0bb43428 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -930,7 +930,10 @@ static int build_insn(const struct bpf_insn *insn,=
 struct jit_ctx *ctx, bool ext
> >         {
> >                 const u64 imm64 =3D (u64)(insn + 1)->imm << 32 | (u32)i=
nsn->imm;
> >
> > -               move_imm(ctx, dst, imm64, is32);
> > +               if (bpf_pseudo_func(insn))
> > +                       move_addr(ctx, dst, imm64);
> > +               else
> > +                       move_imm(ctx, dst, imm64, is32);
> >                 return 1;
> >         }
> >
> > --
> > 2.43.5
> >
>
> Thanks Hengqi for the quick fix! tested and verified working now.
>
> [root@fedora xdp-tools]# uname -a
> Linux fedora 6.14.0-rc5 #2 SMP PREEMPT_DYNAMIC Sun Mar 16 17:16:21 PDT
> 2025 loongarch64 GNU/Linux
>
> [root@fedora xdp-tools]# ./xdp-loader/xdp-loader load  -vvv lo -m skb
> -P 80 -p /sys/fs/bpf/xdp-synproxy-tailcall -n synproxy_tailcall
> ./xdp-synproxy-tailcall/xdp_synproxy_tailcall.bpf.o
> Current rlimit 8388608 already >=3D minimum 1048576
> Loading 1 files on interface 'lo'.
>   libbpf: loading object from
> ./xdp-synproxy-tailcall/xdp_synproxy_tailcall.bpf.o
> ...
>   libbpf: map 'tail_call_tbl': created successfully, fd=3D4
>   libbpf: pinned map '/sys/fs/bpf/xdp-synproxy-tailcall/tail_call_tbl'
>   libbpf: found no pinned map to reuse at
> '/sys/fs/bpf/xdp-synproxy-tailcall/values'
>   libbpf: map 'values': created successfully, fd=3D5
>   libbpf: pinned map '/sys/fs/bpf/xdp-synproxy-tailcall/values'
>   libbpf: found no pinned map to reuse at
> '/sys/fs/bpf/xdp-synproxy-tailcall/allowed_ports'
>   libbpf: map 'allowed_ports': created successfully, fd=3D6
>   libbpf: pinned map '/sys/fs/bpf/xdp-synproxy-tailcall/allowed_ports'
>   libbpf: map 'xdp_synp.rodata': created successfully, fd=3D7
>   libbpf: map 'tail_call_tbl': slot [0] set to prog 'syncookie_xdp' fd=3D=
65
>  libxdp: Loaded XDP program synproxy_tailcall, got fd 66
>  libxdp: Duplicated fd 66 to 3 for prog synproxy_tailcall
>  libxdp: Replacing XDP fd -1 with 3 on ifindex 1
>
> [root@fedora xdp-tools]# bpftool prog
> ...
> 55: xdp  name syncookie_xdp  tag 1426f5e6593da050  gpl
> loaded_at 2025-03-16T19:38:49-0700  uid 0
> xlated 8392B  jited 6412B  memlock 16384B  map_ids 11,10,12
> btf_id 75
>
> 56: xdp  name synproxy_tailcall  tag 0433e599459b925f  gpl
> loaded_at 2025-03-16T19:38:49-0700  uid 0
> xlated 192B  jited 328B  memlock 16384B  map_ids 9,12
> btf_id 75

Sorry missed the Tested-by,  you can add:

Tested-by: Vincent Li <vincent.mc.li@gmail.com>

