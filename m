Return-Path: <bpf+bounces-56367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA20BA95C26
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 04:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0780C16420D
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 02:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627E910957;
	Tue, 22 Apr 2025 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIEMDxUV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B85C19F10A;
	Tue, 22 Apr 2025 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745289169; cv=none; b=PzTAy3wxCAJu3qvt/PMPH5tZhhss97fBkkairiXtIMKLXcVr2/bDmL4XNQULJFgvjyysOJzrpvgwpyydb7Iy9IaFcsUHGQiOC4j4ersbAJ7r/e7GS/drRB2eIgL0YCU+foznlZbp/MXH/fbsFPMdche/KcBYA9qIb3HQKCoLLTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745289169; c=relaxed/simple;
	bh=1DwdAU/2u6VybvwwDzSWITPCCqqyI5Hltlr+oNusVs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6J6n7e6C4tWZ0O1LiIAExaQrOzJ30FRPInW4d0otbjjoYuJVoyD1SgNO4hs9F+btwPoEgzmPsJLPunTqnk5mvqoRKyXhKh8BDEdspgclS0FlCHpMNEMg2/qmAHUGXske7Yap4vGcFiHlXEIjOYZjow7lWWYlG9u/5B6ek4U4/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIEMDxUV; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5f6222c6c4cso6184238a12.1;
        Mon, 21 Apr 2025 19:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745289166; x=1745893966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xNUB4oqtfbY5e3LvKNIcxfRZ0bTnicEfpTi0q3tqZ9g=;
        b=bIEMDxUVQA9gcMzI9LcQC6VZ9t1rkXpaLfoZoqthTFB1Kb0kEw1xPR/tGPmkVV85N3
         Rl1oDxSKnWuxL78r+yl4THpYb9+mojEGctg0mB6Rk+ixbJOBdNYi4q6XRWCRK50GLSwK
         m9H1lS7azVRn7DTePqYgEya276Gz9/zViEwjZlMaW+ireAEcyli5mUQA3jvP4OS30OSp
         87jGKe3o6zLzdfUTKf/HGvT2gJsuVeMQ4hMmV55moPubXoAQXvUgNXUL6pqdXzHNZmq6
         2JfEy+4A3M/rTOGI44GOR71sgbVLIteyz/nvHKDdNW/B3W6MV3ks0DfmFh3fYf1dZqUI
         bD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745289166; x=1745893966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNUB4oqtfbY5e3LvKNIcxfRZ0bTnicEfpTi0q3tqZ9g=;
        b=vG1d6jEMUuxSLX7Ka7A/pXX4WfiGvApye9xojyyMqW1naCgJFKV3x5MOyI71ZdN/Jh
         k3NdId9prGJmIDwKPXwP3Lsh0X/1g8BVat5vkguSCPkzcKx224wE+f2Cx3mmTUYPU4Dn
         CaSnnbR/5OaZQHtuRE4N/G/I6xfQMzrEbKY577LpDxNiETPLztIETHgTMthBF1du7iIg
         Fe0VzS4ziglZab/HMh2iUpOQuc167a22LU9pA9pjG8D4PguioY9yPjLv3lsGPXXrXSjK
         T6d8xN99/dW+toqML9EOzQmidjv4lRSFsHuvfF23lzYuhKeRXW3YUPRhKCJFfBkxuc3g
         jdRg==
X-Forwarded-Encrypted: i=1; AJvYcCWeWQXzcsL8px/DVcUXJo3TAgfeFMvVeiShqUJ+7yRm62Uo3jQV13FqK/ITUZHYHNtTKu4R3Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YybOfTRgglKAQccsFL599aIvRwbtZ/jRNbb2RebMMl+qUqfWZwv
	LjFOIRZZhM5Vc9j/yKRywh+0sjh1VQmCeOfdVYUG/YiW66mWYCpH/iQW4dNZe+MSbyxAWXTwVOH
	N5sDC+XgXv4VP0fJfVCJoONgoG5c=
X-Gm-Gg: ASbGncsUxuOIe9I5Kx65W+D5z3rEBHYkFkbfuJ3Ubr1b9n6NCzr/tRe+MhXv3LUpiRz
	tSHQsJybYhyHmk2KSgmf0vBeAvMTFMGHvYlZx4fTwthvqs/TrzbOzlXGGQNBmtsdFLqVujyIUcM
	zSLQ8qylR8ZAYsemLQoLs1cge3o7Y4wlcKFsmScREaaqU=
X-Google-Smtp-Source: AGHT+IErIAd623dAAJv3HoLXnmwywbNMiRGaQAOZoYuq2Z8Har0BgVscigpxllui+cnDgNgEUVSWcVJ6ybK864Te9+E=
X-Received: by 2002:a17:907:7f88:b0:ac6:ecd8:a235 with SMTP id
 a640c23a62f3a-acb74b813abmr1180932666b.28.1745289166241; Mon, 21 Apr 2025
 19:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418224652.105998-1-martin.lau@linux.dev> <20250418224652.105998-6-martin.lau@linux.dev>
In-Reply-To: <20250418224652.105998-6-martin.lau@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Apr 2025 04:32:10 +0200
X-Gm-Features: ATxdqUGJQbq4WHP3Zya3DrzKSx_vZBr-C_1p8DAJkcewoJDyXoqRRvx1rabeKIw
Message-ID: <CAP01T75q1wWNcgT3aeq8DSOLkVCu-xTD3foR2n7+fOju87OBQA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 05/12] bpf: Allow refcounted bpf_rb_node used
 in bpf_rbtree_{remove,left,right}
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	kernel-team@meta.com, Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 19 Apr 2025 at 00:48, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> The bpf_rbtree_{remove,left,right} requires the root's lock to be held.
> They also check the node_internal->owner is still owned by that root
> before proceeding, so it is safe to allow refcounted bpf_rb_node
> pointer to be used in these kfuncs.
>
> In the later selftest, a networking flow (allocated by bpf_obj_new)
> can be added to two different rbtrees. There are cases that the flow
> is searched from one rbtree, held the refcount of the flow,
> and then removed from the another rbtree:
>
> struct fq_flow {
>         struct bpf_rb_node      fq_node;
>         struct bpf_rb_node      rate_node;
>         struct bpf_refcount     refcount;
>         unsigned long           sk_long;
> };
>
> int bpf_fq_enqueue(...)
> {
>         /* ... */
>
>         bpf_spin_lock(&root->lock);
>         while (can_loop) {
>                 /* ... */
>                 if (!p)
>                         break;
>                 gc_f = bpf_rb_entry(p, struct fq_flow, fq_node);
>                 if (gc_f->sk_long == sk_long) {
>                         f = bpf_refcount_acquire(gc_f);
>                         break;
>                 }
>                 /* ... */
>         }
>         bpf_spin_unlock(&root->lock);
>
>         if (f) {
>                 bpf_spin_lock(&q->lock);
>                 bpf_rbtree_remove(&q->delayed, &f->rate_node);
>                 bpf_spin_unlock(&q->lock);
>         }
> }
>
> bpf_rbtree_{left,right} do not need this change but are relaxed together
> with bpf_rbtree_remove instead of adding extra verifier logic
> to exclude these kfuncs.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

