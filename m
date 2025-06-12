Return-Path: <bpf+bounces-60545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE44EAD7EB9
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 01:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331363B31AB
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 23:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2715A23644D;
	Thu, 12 Jun 2025 23:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzP4mxnP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343C718CC1D
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749769727; cv=none; b=MD6XGzHoo54FgOcsrJ2sT3tMsWnX7rkS/AmwbQlicj1OhR6BbHDu3kxjD3AK1JxhP5QbmCjRh7ZmP1d4HYtfrLPBDVGMY24tnPaorOKmWv3fnez2mWo5FehjYa4fUPee7jKDXfG8VukzYbHJNj6AG5ng59OllGDpvbMeeOO4vwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749769727; c=relaxed/simple;
	bh=AhDltIpkFoDe+KlM0Tln9jJ5vpZ/F5YMlyKVPJHbIyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLs5mEFfjC3ypgmok3U/JoqOhIq3zDE7g/aaFAugbXmXwsR379nm8YjrR5+iVnvuPVQtx3queWbpv/7DPtsaAWHt+bBg9+N4zHq9EwxAc7oEKqUS2pA87J92hjf+kLGjZghXyVE9NUBBh40FbOqrCisJV634I+6idfjBLB3BKmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzP4mxnP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso1272117b3a.2
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 16:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749769725; x=1750374525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgFFPxyEOI3z+fEJQHPe9h1W1b9JlcxO1qEbpGjwvnY=;
        b=jzP4mxnPBmlQcZgoRgZr7tXR7c9X+OUf1AdcxBUOq2jpVdR4Fz9KAlizn7wDp1FhHx
         7+9zb6i+NIxWzRvzrNFzRBiFm2NO4/lPJOc/Kxz901aUQVNMDrdQl5tenpiyiQGED1wF
         GFiGc69UkRMQ/59epZNUDwei6C+63xc4sWqiagJTiQ3Ocf8pIhp7mEBg37rAtiAi3UeY
         oQtXHb2qek6a2KztCeqh+rYPq3v5NV0vfPx5pYIDjIEYLXYeGB55aNyXQWwyR0ta2K+f
         aCfZnu1Uo/wLfWh2QZtk9ChQz+bFqjN7pm1hwkU7R8rWxSjuTOQJPnK7YY8FWyYXqmWb
         1daA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749769725; x=1750374525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgFFPxyEOI3z+fEJQHPe9h1W1b9JlcxO1qEbpGjwvnY=;
        b=AsLGGhG543wvT3riQJ1pESJkHh+XwomeHQyeSw1cC/4A9Ke2BccrWM4KiL840s7TVQ
         SgL5JZFH6ezQKraFbQiyE4yzX08i/I16vRZcQE6FOheSvv3kRjoG0GRseM1HgX/50tgW
         ogSBDRnzMONmlrs3L+J5ROUXCMfRBgMHOFlfMDZyZNYq2I6KuTKK2pD/dRGa5qqZgeqU
         vjC+1t5eq3M+vl5y+scuIqDqCYobXS9akVXmbDlwQ3jTeCajcq5XbHkXZrnmTMzaTZWk
         YzXg40vzzbphOj4+azPSNdPL4ohzEsx1whb3QYNoqDw3KHyqMp22XLEdi/pac3pTlblk
         sh1g==
X-Gm-Message-State: AOJu0Yy0QPHMPLTOeUilzUuE0X6C3POSYTUckOVADbBWWN1lJdlHgpFx
	rWW+G47oG5lI7spDwQ0dY0DOzWA8WfRS8umRuaFjiqaUlpH8+RKzluao8zG8tL6dBIryCeLLD/9
	4l/enVp9bZsJV/WXz3O+rwdnjMCl8Coc=
X-Gm-Gg: ASbGncv+Mm/VtGVtabLzHL7cGTPpZZ+cDUehtbyBHXJBVgwH94K7jjNgTx4kpJT8cwH
	n1JjZLLg8CvgWBdLKRovXrDBsmOZ4LT+/Pjme0C7/wLLf+fDWfLCQbbNQqkF7ruMrMTghL0EPlS
	P5Z/Co+Bm3T1gwZc8CGzKz3O9AlxAX6CMBIgSNeUmoO+CPSVrViU282kbRFN0=
X-Google-Smtp-Source: AGHT+IH+TrE3KAH8b7GCSYzukDakDSqfXHPsODdJENS1iJHiKMtAZCVBDxADwy/mLOHp16louHXKAa6Z5utgC011H18=
X-Received: by 2002:a05:6a21:6012:b0:215:e43a:29b9 with SMTP id
 adf61e73a8af0-21fad02d0abmr819341637.33.1749769725449; Thu, 12 Jun 2025
 16:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609232746.1030044-1-ameryhung@gmail.com>
In-Reply-To: <20250609232746.1030044-1-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Jun 2025 16:08:33 -0700
X-Gm-Features: AX0GCFsAKws0bUtcb2ERsgiTfeAOK25RBKzxfhSirpkiIyiAGSuuvrBhD7-ib4k
Message-ID: <CAEf4BzbFaPMG4C4h1BX_Wa2gzO-DvCosPFHosCph1u7++KwhPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Save struct_ops instance pointer in bpf_prog_aux
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 4:27=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> Allows struct_ops implementors to infer the calling struct_ops instance
> inside a kfunc through prog->aux->this_st_ops. A new field, flags, is
> added to bpf_struct_ops. If BPF_STRUCT_OPS_F_THIS_PTR is set in flags,
> a pointer to the struct_ops structure registered to the kernel (i.e.,
> kvalue->data) will be saved to prog->aux->this_st_ops. To access it in
> a kfunc, use BPF_STRUCT_OPS_F_THIS_PTR with __prog argument [0]. The
> verifier will fixup the argument with a pointer to prog->aux. this_st_ops
> is protected by rcu and is valid until a struct_ops map is unregistered
> updated.
>
> For a struct_ops map with BPF_STRUCT_OPS_F_THIS_PTR, to make sure all
> programs in it have the same this_st_ops, cmpxchg is used. Only if a
> program is not already used in another struct_ops map also with
> BPF_STRUCT_OPS_F_THIS_PTR can it be assigned to the current struct_ops
> map.
>

Have you considered an alternative to storing this_st_ops in
bpf_prog_aux by setting it at runtime (in struct_ops trampoline) into
bpf_run_ctx (which I think all struct ops programs have set), and then
letting any struct_ops kfunc just access it through current (see other
uses of bpf_run_ctx, if you are unfamiliar). This would avoid all this
business with extra flags and passing bpf_prog_aux as an extra
argument.

There will be no "only one struct_ops for this BPF program" limitation
either: technically, you could have the same BPF program used from two
struct_ops maps just fine (even at the same time). Then depending on
which struct_ops is currently active, you'd have a corresponding
bpf_run_ctx's struct_ops pointer. It feels like a cleaner approach to
me.

And in the trampoline itself it would be a hard-coded single word
assignment on the stack, so should be basically a no-op from
performance point of view.

> [0]
> commit bc049387b41f ("bpf: Add support for __prog argument suffix to
> pass in prog->aux")
> https://lore.kernel.org/r/20250513142812.1021591-1-memxor@gmail.com
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  include/linux/bpf.h         | 10 ++++++++++
>  kernel/bpf/bpf_struct_ops.c | 38 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>

[...]

