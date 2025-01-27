Return-Path: <bpf+bounces-49917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3ADA201F6
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 00:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6923A4278
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E70D1DF98F;
	Mon, 27 Jan 2025 23:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/CFKglh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B03481A3
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022006; cv=none; b=Sl9VRgxkbRjDUp0cN1sSLOIOdp9y/RBkhnFloOZRSABanvyXGsbPjT14i6bUK338tXOlBGlDV+348Az38U7letsD1VgXp75i9ovCrKhYmtttFmt/06ojrPhSKWUF5kJWYLMvt2NYiSTrIokctqXRNxpQXU02sVNN5j6pK3irVq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022006; c=relaxed/simple;
	bh=HXwXQh3Uc5R2U+541unuMmpgD/qpzNGez384w8ymbdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1QOGUuriF7/YUvk/IBHCJ4UCvXPptOFfE6VXMijiZZ/uB7GNQududEFBAeit77lbJJBkP8xtFlI5HJDJpBkN8zSJVdeVeLShBl6MXdd0996Nzu0UPZAWDAynFPIKsvFlPjE88kyt+PODdq4VLo86n0IFvU98jPKchb7VlGOc4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/CFKglh; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso6714407a91.2
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 15:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738022004; x=1738626804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEZ9fzgjBbdW9Jv7606er4vSda6+pN/lt+q5JyaXMv8=;
        b=C/CFKglhTwZOSQoIZvpOloE7Ej9/6NfiFAwIR7s6CyaEXrmiob8X1oTY70dZc3pd81
         9pvNgVTC4WkW3QnSzEtvSTGMDb1KCYSNfKX1ApmEYMJoiww0urRcC+aUrnaIS8q4jGgi
         RPlAj0SDdqhtYqwJDn05cjqgTSN0TVJxJ9b3ZhqDc3fDkBHIW6KMYHL2/JgdhPX/gF9R
         dccLNDsoyldMmTkpr6lOyr0ZlPc/pQz7UuQYkfjikzDnB2IXNDvSS1Zt4z/ONID+QXKf
         mlT4Q0wQtmgKOtpugk8wczKDD7J+pDLHVlAbOl7GFLU4PiS1SZ1YB88/8X+1pDYl+Xmr
         HZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738022004; x=1738626804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEZ9fzgjBbdW9Jv7606er4vSda6+pN/lt+q5JyaXMv8=;
        b=gYlb3NMaKoRN3QcqKjvN/KIqcJ4YFD7MKZIHw0dm7LoaWzKdspSe4OKIkpRRAKpKTO
         GRBN2SD4cHyHwk4k7OFXWJT5eLhJWP9ppBkTxbZjZpCEeHDja9Y+rNbrh1ulqFYMJS+N
         gWCgGXN/NsT/2fc2wNWwt6UGcX0SiTI0ktRkR8O3UiByFXBhiDX325VVX4emxGpU2m+T
         CO0+f3SnhWrJE4KxMfgxpbfXp+iVftcu1UoG0T4MVWCgq1S3h5I3Aox/SAVyTHdxQYDG
         NAJHW3ycw6g1JzHoO1jFJDPR7WyW0fJO6ZQ/jx7cLWl1UUxgquyACF6G4ejT4A2NYPbV
         3VPQ==
X-Gm-Message-State: AOJu0Yz3IiUzyE+jL60QesusBPEsQml5+/zHkFEHCsk6W7PqThtuu8hO
	NULT7sjmoUNnco2flgprgWAtrr04tJEIBglXSHaN2/DRwmD81VvMOjYz0pTkc0AJ7rCPR1fe+K6
	PcSi2l4D00ZOPJBP3uz3MjANHxLk=
X-Gm-Gg: ASbGncvj+cR1/gtubpc1xZp7HFGcTNpnfAnrVL/aubDNFQEFY99Xps3ztnK3d7xTdPs
	Q07yQr7ixSraPCUlJR0klLJ2uuvheTH1bBAefM1v3G6hIUGkY2iQxEXpVYm0un25a8JG7PuV8u+
	RTMg==
X-Google-Smtp-Source: AGHT+IHBuJzqyvrjxNg6IAKP+gWLMAYigz5CQ1DpTyPJBKcWkoZIOx9ykwwabrJ00PK4fMWyCEUIiZlBaliWliD0d0c=
X-Received: by 2002:a05:6a00:32c4:b0:728:eb62:a132 with SMTP id
 d2e1a72fcca58-72dafa68bbbmr50806919b3a.15.1738022003823; Mon, 27 Jan 2025
 15:53:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126163857.410463-1-linux@jordanrome.com> <20250126163857.410463-2-linux@jordanrome.com>
In-Reply-To: <20250126163857.410463-2-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jan 2025 15:53:12 -0800
X-Gm-Features: AWEUYZlWgd43bqXjk0zr8FgHPbu6tGqkGJCy6S-Pyd5JOJE6HYuq5f_B7C_csC8
Message-ID: <CAEf4Bza+Ji9T=R3Yn=JoVRj_Oux7PhfpeaF+AcQbOKj93WYFZw@mail.gmail.com>
Subject: Re: [bpf-next v5 2/3] bpf: Add bpf_copy_from_user_task_str kfunc
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 8:39=E2=80=AFAM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> This new kfunc will be able to copy a string
> from another process's/task's address space.
> This is similar to `bpf_copy_from_user_str`
> but accepts a `struct task_struct*` argument.
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  kernel/bpf/helpers.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>

Please carry over received acks/reviewed-by's, unless you drastically
changed something about approved patch:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index f27ce162427a..a33f72a4c31f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3082,6 +3082,53 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned lo=
ng *flags__irq_flag)
>         local_irq_restore(*flags__irq_flag);
>  }

[...]

