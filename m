Return-Path: <bpf+bounces-55754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0649A863E9
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D6B3B5220
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C683321D5A7;
	Fri, 11 Apr 2025 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1WZgEZ1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B545A42A9E;
	Fri, 11 Apr 2025 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390746; cv=none; b=E6HbkfMmG+vqT+67zMr9mnboO2fvnbj1H8+UZrTJSzLJtsQrAKEa932qwSc/5GrYHEZws17511HXVEg0D5auWubzwQ3wMP0O6BZBJB73xAG2T8IsPDU6JwWjBoGn0NQKs7jK2hGMWotPeKKDCh+Vpy1cUNyNEfr+gwRQeDFNC7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390746; c=relaxed/simple;
	bh=TXguka1bEhW/OHWrpUMccWeFPNHgfSXHr9J3Q6OxMjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sn2rY7se1wy++aBkqbseqrVI6AubYB/4hefsufZ/sAScg/0TFpe04tvvwMTxu6T0tmLgP4RXpmKIiX0o8oTw3uxzjndv32bDt28vw7Y8PhPP0KnvQ/E16+LmRzExe2hSQm/fOn2emLRFGzXRK+AmUqxHYybSp1lV4qFx3n4UhEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1WZgEZ1; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7020d8b110aso20424777b3.1;
        Fri, 11 Apr 2025 09:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744390743; x=1744995543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9wYNM5kK2YRTaOQeR6MwQqR01LW7U5j8+pp86cogLY=;
        b=S1WZgEZ1xHsCcAq+Kl4MClVfqMG2aZFAlvjrb146YF3+cj8aPDamDj3jygxqc7imI9
         upEeiipyb7jdquJJQNEm5JGVtRXGY9maFD7RvIjeyA4X93m09AbHy5cawoqVFvMiZiHS
         42qUqAVkm/Df9TVw+ngaUrplBNaPqI8blBDwu/7y3w2miNntVe9mSJ+1u5XIAZ2S+2J5
         JVOGTiWmWZH7aT9cRb2Pr1A8v9998YeVObS+0hLAlvO6Pc/cytE509oidJQ6hkWsjk6C
         vU9JzIb6Nl45NgPzsF2UWvTju/pW472obmtD+rehUS+6CA5wcEn7D2ObfSHxppVgiZ7z
         Yayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744390743; x=1744995543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9wYNM5kK2YRTaOQeR6MwQqR01LW7U5j8+pp86cogLY=;
        b=UEpxV7hUQTsvY48+hfDZdeFtBAMQ7M8T248Ouq3bikGLSMf19r2kGsw+uhDycrDGve
         LYmDjrHPWbICMu2+5MFkjB9WtqnDdNGGPTqd40CPgX1MfBV7pQlN+QYdpDvoiVC7osG5
         16+0Vu35KuXZjTEnY6xY5qzpesFt6Y6inUaaym0CK56qLMvNjyfg/nWw+ls3wwHhncQd
         gtyS0mxR2D17jvjsPF9GRy9G6Vn+IlKCQKQ31Ft/zaHTcPHvjbzZv8fJw5HMrUaGiy2W
         VLnbAR8DbevZLfakRNHFlBxNSXN4Fcw9apvY5q4MXcnp+xzH5e/5OKaGnJkb7pcMhAf3
         al0A==
X-Forwarded-Encrypted: i=1; AJvYcCUdWMhqJfkaP6fKmqP+Exke5hFODhYXxJXiPSwfgVDbQ62ltM3wg/QoSMOojqbC4O475JUpW7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze7ZVUIG44R+NrFNllr9ogcA2XyhxQsQ/hofwBK9/b2/WjevB0
	BBG8Wwe+ocEiN/8CkK5bOi8GiMrALMDvIM6SBFKv/BR8mXzPDJih6NdpIZT10yOk9Esv8ZPVpMv
	cEGN7BdpRPb3qGVYsBSRsn4rwKpc=
X-Gm-Gg: ASbGncuYOO4LdFqF3yXvH62pfcvlqUIadckMNrCWY40JSNbRFIbLalFDjjXanm64kUV
	y7KcF76gNK6GZUcgY5xHEFC7rzY5REdJACjJtxefwnhMzA96CKORvrvBbBsUGqSrcjwh+7GPzxp
	hr2clBABqCRSuNj4gbKCkdUQ==
X-Google-Smtp-Source: AGHT+IFFL0OBNk4q3Xx/8gsghlkM5EJAbMEtydztzkVsPNRGh+usvNlI3uYWfyGi940JQ+RcxXcW6LCbMvqlLOAluHU=
X-Received: by 2002:a05:690c:c02:b0:6fe:bfb7:68bd with SMTP id
 00721157ae682-7055998f0e4mr63218647b3.1.1744390743596; Fri, 11 Apr 2025
 09:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409214606.2000194-1-ameryhung@gmail.com> <20250409214606.2000194-4-ameryhung@gmail.com>
 <CAP01T77ibGcEhwsyJb1WVaH-vhbZB_M2yVA8Uyv9b5fy=ErWQQ@mail.gmail.com>
In-Reply-To: <CAP01T77ibGcEhwsyJb1WVaH-vhbZB_M2yVA8Uyv9b5fy=ErWQQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 11 Apr 2025 09:58:52 -0700
X-Gm-Features: ATxdqUH3ayEfczkYeFQ0l0roYDPt92wGNdJePCEj05yJ95tTtgaQyJo5IEPvGEg
Message-ID: <CAMB2axNqfBpneVc9unn7S65Ewb1u6EpLudjtiq00-sqbfnSY7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 03/10] bpf: net_sched: Add basic bpf qdisc kfuncs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, edumazet@google.com, kuba@kernel.org, 
	xiyou.wangcong@gmail.com, jhs@mojatatu.com, martin.lau@kernel.org, 
	jiri@resnulli.us, stfomichev@gmail.com, toke@redhat.com, sinquersw@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	yepeilin.cs@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 6:32=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, 9 Apr 2025 at 23:46, Amery Hung <ameryhung@gmail.com> wrote:
> >
> > From: Amery Hung <amery.hung@bytedance.com>
> >
> > Add basic kfuncs for working on skb in qdisc.
> >
> > Both bpf_qdisc_skb_drop() and bpf_kfree_skb() can be used to release
> > a reference to an skb. However, bpf_qdisc_skb_drop() can only be called
> > in .enqueue where a to_free skb list is available from kernel to defer
> > the release. bpf_kfree_skb() should be used elsewhere. It is also used
> > in bpf_obj_free_fields() when cleaning up skb in maps and collections.
> >
> > bpf_skb_get_hash() returns the flow hash of an skb, which can be used
> > to build flow-based queueing algorithms.
> >
> > Finally, allow users to create read-only dynptr via bpf_dynptr_from_skb=
().
> >
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > ---
>
> How do we prevent UAF when dynptr is accessed after bpf_kfree_skb?
>

Good question...

Maybe we can add a ref_obj_id field to bpf_reg_state->dynptr to track
the ref_obj_id of the object underlying a dynptr?

Then, in release_reference(), in addition to finding ref_obj_id in
registers, verifier will also search stack slots and invalidate all
dynptrs with the ref_obj_id.

Does this sound like a feasible solution?

> >  [...]

