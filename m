Return-Path: <bpf+bounces-22189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A64A858852
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 23:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46BCB28CFFC
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 22:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E901474A7;
	Fri, 16 Feb 2024 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rzn16JLx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A863145FFE
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708121013; cv=none; b=RmJQu+cLyaIYKC3X02oCzzOjuUXNwAC6VF2I6uyNKeCKtlPSpjVpzpm/N+UmWOXc3jdh8FlJXTR/54/omjIH/Sznaf8bRwtkW04pqm2AgxOWfQfYoEMrCdWd3onnB310MT1YTD8KztOEN6vzsJRcLXoIBWgPwXnlIcEyCf92i0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708121013; c=relaxed/simple;
	bh=WLhTG2Og+5yarJjZFYPyhc4+HRFBqiJ1TYsHwZ9kJqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJjPcfkAj2DgCqi/ui567tDFTb18EH5mW7aasX4hc+N9CKQmixbmkGZC8oZlbf7Q22CjDMB0iBSriCx0ikawZ+Xup3l8B6HFD2JWdRXRz3arB5uIg3xNn5inmVW73D+KcwRLhgLG44n7JYfKi9V9aUbatuoC04CXb40h/cgT6Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rzn16JLx; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-563e6131140so1467533a12.2
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 14:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708121009; x=1708725809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=//2RJQ4ZI3CBWTtTLhy6tI3d52fo9T46saPaUThTXB8=;
        b=Rzn16JLxRJMd0iipNseunONvy4dQwrbsLP6MPS3w0S41JnLBZDCme24pTba7ce3ULM
         aGAP35VJ2v+og8fpKVg7Y9X3szeHg+LOgK62B5y2W67pKB2rKWBHcXJYsFS7rEtiNnEp
         thBXI/bo92tQpuPyegSggNuS20acIA+e9s+XGKViKd73yqkJ+hOBTimT2Cdo6c4eDDjk
         qRtFbUuNrLvm/juSviKETDt1gGnzVHcAIfFdYqZDDf36QmJcv39HfJemVSqDAaZYCpx9
         1oYkWP2qlXKmK1BYtvO+/k2T09q0F8qHQMHcCBJkcuMRnRrXttewoiSBLoodDQnvl7Uu
         zEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708121009; x=1708725809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//2RJQ4ZI3CBWTtTLhy6tI3d52fo9T46saPaUThTXB8=;
        b=j+GVpCtQ6Pdl1FH5L0dR1QjUwGn/sgbj8xVgk5x/iWVhJEaOLqNb7pr5WQUM85DAcS
         GbYKPeoUxa6FfytE/dCQx0Zhb7SfvL2joEPJqfD3NwdNvA00XUWpqP1jcgoKyXGHI6fe
         czylO/WWGcJ7NPTvPxJckcigvFgupmNbc80HTXu2sgeZFJWgcZfhy+K/tJPtDb5LIXl9
         fuYigu1v+9/lb3bQkHU2gjX0TiNUEkcYvdLvmMlZS6wJvzibtgQDYoEh3vRUGQ2qG8wg
         8pfIv6a7WflUp9BZ3x4Z5tflavTIQh4ZQq6mkf7WRHbAND4Bb7OBq1fCPpBDE1hRd7/8
         uz7A==
X-Gm-Message-State: AOJu0Yxv0PbVvVDm6CX6e18lUDIzqNm7TRsSJUg570/eSKtoakkHhzYU
	PmJiJabe+0CYox+wT0jIp0477vEmS1BjEBG8xZMfmrODqNqJXnBl5iBLqsb70W0E3gdymkh0cgr
	o18gjxmENFhW/YjdGvMTOYNmhJFk=
X-Google-Smtp-Source: AGHT+IEH5Renkabc1KMRbBv9P1a4UdBE/2ck4DZcjPuN8WdMQIKhcpz82DYxbITj7d7UrhnmsD/uOapLbpwkNi41GaI=
X-Received: by 2002:a17:906:4ec6:b0:a3d:2551:291 with SMTP id
 i6-20020a1709064ec600b00a3d25510291mr4388888ejv.69.1708121009552; Fri, 16 Feb
 2024 14:03:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201042109.1150490-1-memxor@gmail.com> <20240201042109.1150490-9-memxor@gmail.com>
 <a99c123671efdf4e795d883cb3b0c67ced3884c1.camel@gmail.com>
In-Reply-To: <a99c123671efdf4e795d883cb3b0c67ced3884c1.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 16 Feb 2024 23:02:53 +0100
Message-ID: <CAP01T74yVyxLcW13+gEUs4A7qe4YCz84x7jnw78o9P5Xjtt12A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 08/14] bpf: Compute used callee saved registers for subprogs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>, Rishabh Iyer <rishabh.iyer@epfl.ch>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 23:12, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2024-02-01 at 04:21 +0000, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 942243cba9f1..aeaf97b0a749 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2942,6 +2942,15 @@ static int check_subprogs(struct bpf_verifier_env *env)
> >                   insn[i].src_reg == 0 &&
> >                   insn[i].imm == BPF_FUNC_tail_call)
> >                       subprog[cur_subprog].has_tail_call = true;
> > +             /* Collect callee regs used in the subprog. */
> > +             if (insn[i].dst_reg == BPF_REG_6 || insn[i].src_reg == BPF_REG_6)
> > +                     subprog[cur_subprog].callee_regs_used[0] = true;
> > +             if (insn[i].dst_reg == BPF_REG_7 || insn[i].src_reg == BPF_REG_7)
> > +                     subprog[cur_subprog].callee_regs_used[1] = true;
> > +             if (insn[i].dst_reg == BPF_REG_8 || insn[i].src_reg == BPF_REG_8)
> > +                     subprog[cur_subprog].callee_regs_used[2] = true;
> > +             if (insn[i].dst_reg == BPF_REG_9 || insn[i].src_reg == BPF_REG_9)
> > +                     subprog[cur_subprog].callee_regs_used[3] = true;
>
> Nit: Maybe move bpf_jit_comp.c:detect_reg_usage() to some place available to
>      both verifier and jit? Just to keep all related code in one place.
>      E.g. technically nothing prevents x86 jit to do this detection in a more
>      precise manner as a "fixed point" computation.
>

Hm, I remember I did this and then decided against it for some reason,
but I can't remember now.
I will make this change though, if I remember why I didn't go ahead
with it, I will reply again.

Also, what did you mean by the final sentence?

