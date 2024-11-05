Return-Path: <bpf+bounces-44050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F479BD105
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 16:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3586F284361
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 15:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243251531E8;
	Tue,  5 Nov 2024 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez0S4D9d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B2814A611
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821843; cv=none; b=YexsFAocVBvILEAsBqqD8Z1dsDaAlIZ7zMHwqFNqQzwXd0Jyf6f0EsVY9uVn423nl1D0OF6DYVlnM+6igMG7YVeYFMdsQdvx/RiOesM77xS8qrEA+CNgiRDvzkmPKY8NzgF9RNhRwptTt6vktx8nuRxSERCxhQVjBsg+m4D+lng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821843; c=relaxed/simple;
	bh=7rlZZYUsptTsDxr9DLS+C+m1KBT2e2o5M7FoAmOVkb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWe3qkgyhGFa2eIySS7ArFJSW5965exH1K5TbFhB9com3hWCNfMg5kY4NmFX9nmnGjKwllL5h6eIegmhhl1PBhOKj6KNEG+V9BywHCvv/kv5c25ICekx0rZPVyzLWEvrmzpfAS5v8FOdS4Kl6kuN3xXXQhGoHDUhe0WMoU6iWHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ez0S4D9d; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so66455305e9.2
        for <bpf@vger.kernel.org>; Tue, 05 Nov 2024 07:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730821840; x=1731426640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9iOQwj58fFvwNhe5ZbTdzbr4b6mhmKSDJtWV2LPn6A=;
        b=Ez0S4D9d3AZi6nvT3Xh2u/mD8rHNDsK2z6FuRDmWzjfAWboyur52vMXSMgTXmXVTBm
         lTVubbSOQHVoa5BxiFZxbEHQ0odoAzFdQj+N0EKPqBWI0Vs3mao4MzI3eQ7yiDbTlWmU
         0/wRHybPVVWjt9sLsJo1t5CH2APqgxn+N5tWcFNxrzXdFQQj4S1CHHj/Q7SeN5OFFHk6
         mcSFqNJgVh4W3gz7+zE28O7JqpU8QLOoYnfktooPlTPnr7/DphBycF7FoHMQHT2LpiG0
         AngPZvM93YpR1ppP/Z3kusv5TqfuFPA/yniRHTYAFRxyP6SJOUn/cOXO8LRs13r+y82P
         C5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730821840; x=1731426640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9iOQwj58fFvwNhe5ZbTdzbr4b6mhmKSDJtWV2LPn6A=;
        b=ge0GRkrpadA6kpZaWoA3V4YiizciNuY3ZH2JAZRsjiV0ruomES94dF5Yey0CH7Qh6a
         ozZ9tIUa+viEsHPG63R75xxRBs7XIdYkCWuYaU5f8sajisMr6Jswq4EgJLUynPdd8985
         csq8jNoZoTUrGjJor71zenwQg+pXZUkEKeGztUJ8nMUhVV0sIT1wDyQ933MvmcPGrpm7
         dAFZ1pr108vjDQmtn7a7SZFjLIqTxvxVkjAp++uyT39XlOzQPXPBDlj+iPQA9IP2yaPH
         p4wE/o6/tKcbKPmG0M6tbUtEPJVl1gTSh9prhfV3LQPaCcc4+X+BE6aCCids/D+3P/Gj
         gemA==
X-Gm-Message-State: AOJu0YxczE7puIZenGJjajsamDSjUAN1Dc72N8Nfc5REqqQ5ju5+ec9B
	IaQpw9LO4dnJ/0PLW3enew7SAy2L0o6gHWXHXlYnnMF8OiTc4AjtKdV3/H3WI+pdV5N5nktY2hY
	1yi53qO6nxfd7uS64nfFudIYcy4Y=
X-Google-Smtp-Source: AGHT+IGiJvGRQ6BH40vi3+vN7bc3JCLa+wO/ixGG4yAgnh2tuvfIyHNDgZBcmdGUYlQZVm+26OvbWza4UEkHrgtIgTI=
X-Received: by 2002:a5d:6da6:0:b0:374:c1c5:43ca with SMTP id
 ffacd0b85a97d-381c7a6c662mr16547183f8f.32.1730821840090; Tue, 05 Nov 2024
 07:50:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193505.3242662-1-yonghong.song@linux.dev> <CAADnVQLr5Rz+L=4CWPxjBGLcYEctLRpPfh642LtNjXKTbyKPgQ@mail.gmail.com>
 <36294e71-4d0b-465d-9bf5-c5640aa3a089@linux.dev> <CAADnVQLXbsuzHX6no+CSTAOYxt27jNY5qgtrML6vqEVsggfgRQ@mail.gmail.com>
 <6c78f973-341e-4260-aed4-a5cb8e873acc@linux.dev> <29e2658c-02c9-4ef1-a633-ee5017e72bc3@linux.dev>
 <CAADnVQL54BFUpzAWx-4B6_UFyHp4O88=+x8zeWJupiyjNarRfg@mail.gmail.com> <97ea8f52-96c3-4109-92b7-cf2631a34e2d@linux.dev>
In-Reply-To: <97ea8f52-96c3-4109-92b7-cf2631a34e2d@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Nov 2024 07:50:28 -0800
Message-ID: <CAADnVQK-AXqxEhDwWK=RKx-dA0PZ=N1j6vSshBWS4bGNfv=a7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 02/10] bpf: Return false for
 bpf_prog_check_recur() default case
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:02=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> >
> > I also don't understand the point of this patch 2.
> > The patch 3 can still do:
> >
> > + switch (prog->type) {
> > + case BPF_PROG_TYPE_KPROBE:
> > + case BPF_PROG_TYPE_TRACEPOINT:
> > + case BPF_PROG_TYPE_PERF_EVENT:
> > + case BPF_PROG_TYPE_RAW_TRACEPOINT:
> > +   return PRIV_STACK_ADAPTIVE;
> > + default:
> > +   break;
> > + }
> > +
> > + if (!bpf_prog_check_recur(prog))
> > +   return NO_PRIV_STACK;
> >
> > which would mean that iter, lsm, struct_ops will not be allowed
> > to use priv stack.
>
> One example is e.g. a TC prog. Since bpf_prog_check_recur(prog)
> will return true (means supporting recursion), and private stack
> does not really support TC prog, the logic will become more
> complicated.
>
> I am totally okay with removing patch 2 and go back to my
> previous approach to explicitly list prog types supporting
> private stack.

The point of reusing bpf_prog_check_recur() is that we don't
need to duplicate the logic.
We can still do something like:
switch (prog->type) {
 case BPF_PROG_TYPE_KPROBE:
 case BPF_PROG_TYPE_TRACEPOINT:
 case BPF_PROG_TYPE_PERF_EVENT:
 case BPF_PROG_TYPE_RAW_TRACEPOINT:
    return PRIV_STACK_ADAPTIVE;
 case BPF_PROG_TYPE_TRACING:
 case BPF_PROG_TYPE_LSM:
 case BPF_PROG_TYPE_STRUCT_OPS:
    if (bpf_prog_check_recur())
      return PRIV_STACK_ADAPTIVE;
    /* fallthrough */
  default:
    return NO_PRIV_STACK;
}

