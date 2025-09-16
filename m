Return-Path: <bpf+bounces-68460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C36B0B58A71
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 03:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74ACF2A5E1D
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 01:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9BB1E3DCD;
	Tue, 16 Sep 2025 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz3ZZSyk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2341E379B
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984419; cv=none; b=Dq9WYqS7SjK7wiwWzk0e1VYNoZ1ITeUkIe/9aHpZmMymIAmDkdcvQls1o07QXjdoIG5C807J+m28Pjy1YMLsW989mTFi383ribu/ZzOn1MLhY2bNX+XfQaG/w94IAQxic720OKtXkWD2dUXbOcY/6xwJybYQBTOrf7Z0ds3vDj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984419; c=relaxed/simple;
	bh=vJ8uvW5pPBElSePJ5lVixVZCgb687MoeT4SjQWM0OaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQ4vMoJDrpZ3LuYZ31QzsKua/GjGHi5io0x+7cgvocb0tmG9Pkkz48Q9UKqhBvoX5y93qyMSRxIf40eRzBAjtgg7Vzbj/pMxa5V03mosDsRx3o3/QhVAh4XMDSLXI4zmppJOHwAj5b1mzbGH7W2IdnZ8AbAuNySbNXR6TXn7VdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fz3ZZSyk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45ed646b656so39960375e9.3
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 18:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757984415; x=1758589215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40khU2eera/C0wIDlxivIo2NAj0/r96JDxR8+rLtfvE=;
        b=Fz3ZZSykA8m70exrp3HnCnQcrUl6dWQ0pjDuKlYUNUyt2TIcLPnwYylfrZIEu/Hgdk
         SZ9nl13CALSMBSos6izzL3rXMgVKAlQz/CYR3jbUMeh1Odah7revUXJ9P5umTlgNFpzE
         hNPkjp2gMgeZ6M25547y0/mkthI+7nd8wzHNPDDQp9BG+5pCd8K1894KdiD+GmF39uhE
         TFDjMN/DEuwIEeaoVROOSEsxyHTmnIr6+Cv8mBRcXDl9myBZ27U0qV2Cy++4GwjIT5Ko
         aXRx6S4JdTH3jVWUSJMQCHhuyFcj+EUiJ6z91cwoqooHQNlS1btFPmzOy0Hks7gkGruC
         iPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757984415; x=1758589215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40khU2eera/C0wIDlxivIo2NAj0/r96JDxR8+rLtfvE=;
        b=gdUl8cadP7PwXF6i8a1+Jk3aPTAHmStgZGyOEXQMMTewLmTNCUVG9aV/WbFVVipzhZ
         BaEP+AkVLz7FcCAyC5SwGT273FkumNwbZxI5sg//ftzwdnccuUcS0br49FIYGME0fmo1
         lWg3IoA03sRpGSE4IUww5LQCSg7Oibn7aWxn2pRbM4F4pySPOmdwOlz/TQPOAC2vyzOp
         wWQ361mAaETQVnpOk8Y0A5eI/PN0gsBU8pwl2DRnYWAztY9nUMXFSiUWrlfnQP6tUXh5
         ZVyKeLAbRLSgB20xQvRzctvu9u80jkvqVUorXxt+JIMvGZQ1wo3Pd/CxJI0AJR9uUN02
         hUmw==
X-Gm-Message-State: AOJu0Yw3QxlYZqz3DOcefc8PRk3YrS7OlvlOBOd+xKeccec645GzFLij
	nos2dDSdx8keHlT+ZX6jWRs8eCSoS2urjut8RqIanvH0jeXE9DxYvY9YjEUYFbLeqy+YKjN3S3g
	n7QC05ssHXRV4qSfArZ2nrefS08549TY=
X-Gm-Gg: ASbGncuddwqG+BDNbMKnwPZTvlzPfTmKrHZzW5i5FAeIBdfMaSyIfgIUTZXzDyxL/ql
	32FPORPSgZ8wwmOZ7Hn7ydLFXtS8UsSawajKX3RRygqPIjwyhYOaWL+cRO9a7CuLfxJtq/42gLw
	rlYfP9d4RKaX4Q7W72kHYVwTqGjieOaJrHCGt1Zoha6u518hAysG23bX91/BYNI5f8FBotwsyv3
	y11biFnxea/Sn/50RfSHNL6Otas4lcRWlYm
X-Google-Smtp-Source: AGHT+IFF/jNbJrg7JsqU1KXpSbCfkS4+VN2T8ZW+UmOw9rPbBXYFNDdRXsyuyZNFSfle/Y+OP+wYAkK7vfhDvIB9uf8=
X-Received: by 2002:a05:6000:240a:b0:3e3:f332:73f7 with SMTP id
 ffacd0b85a97d-3e7657adee4mr12627231f8f.28.1757984414528; Mon, 15 Sep 2025
 18:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-7-alexei.starovoitov@gmail.com> <aMgMIQVYnAq2weuE@hyeyoo>
In-Reply-To: <aMgMIQVYnAq2weuE@hyeyoo>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Sep 2025 18:00:03 -0700
X-Gm-Features: AS18NWAI9B_2wRiYhYkx2plpF2KQ-My4XIXEQBm9flGJedyurG-fw80e8XPUpbw
Message-ID: <CAADnVQJSS8+2Zw4kAypC7duWhyd2zQeiu1zbgy8WW-xqnBCgnw@mail.gmail.com>
Subject: Re: [PATCH slab v5 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Harry Yoo <harry.yoo@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 5:53=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> >       if (unlikely(!node_match(slab, node))) {
> >               /*
> >                * same as above but node_match() being false already
> > -              * implies node !=3D NUMA_NO_NODE
> > +              * implies node !=3D NUMA_NO_NODE.
> > +              * Reentrant slub cannot take locks necessary to
> > +              * deactivate_slab, hence ignore node preference.
>
> nit: the comment is obsolte?

Ohh. Sorry. I clearly remember fixing this comment per
your feedback. Not sure how I lost this hunk.

> Per previous discussion there were two points.
> Maybe something like this?
>
> /*
>  * We don't strictly honor pfmemalloc and NUMA preferences when
>  * !allow_spin because:
>  *
>  * 1. Most kmalloc() users allocate objects on the local node,
>  *    so kmalloc_nolock() tries not to interfere with them by
>  *    deactivating the cpu slab.
>  *
>  * 2. Deactivating due to NUMA or pfmemalloc mismatch may cause
>  *    unnecessary slab allocations even when n->partial list is not empty=
.
>  */
>
> ...or if you don't feel like it's not worth documenting,
> just removing the misleading comment is fine.

The above reads great to me.
Will send a follow up patch in a minute to fold in or keep it separate.

