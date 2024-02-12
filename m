Return-Path: <bpf+bounces-21755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FB9851CA3
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 19:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072E61F23869
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 18:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D028C3FB35;
	Mon, 12 Feb 2024 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L//63RTE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C440BE0
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762234; cv=none; b=sQh/Qa3ZoOWX79vp+9glU6CsG8lkG4R9C1WfuzagtqUYfiws1JvJh/2M3J3Pj6cT1p80xaYbfF+hhi4bthNJuE7INEJETF67fisxB9Jvaiy4Y39dupzWkVGSJnkwFw8Vd+f67RVgfbNFVi1r+F2Qma0mZsYTo+fWLcO+6y/hSSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762234; c=relaxed/simple;
	bh=OPyREaGXyK8yGFebaPdOKyoWKYJ8d4s1wtrpEza6+4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udCsDlse+0yqkdW6Uz0t7O2uKj1okLySZeUQkrn+umI1Ku9xh6muffBILpfXrD+zhLgUpYb93KrmdArlEsvCktWIBuETUCSqx0kA+M/n/qbU2Nib0SNzp7vU0V9j/U9xovbuQxFgGBVxoOyQcI0zGDuKtYLIJWmGoRbW76ShS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L//63RTE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33b0ecb1965so1915717f8f.1
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 10:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707762231; x=1708367031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOLcRqL4PWP5gx5t9V64UxQKQJUWLVYG/flknmF9Mus=;
        b=L//63RTEnKO7PXxYPjbyCp9BQAFTwqhqbzKonnXuPQqFuDQWqia2B/KwoZJTIB0X0y
         E8/8k1rOTBG1pERd4H3+h/vZMCDAKdg/S31y65ecDviSKIx5eD8WgHzd6bQGWa6MtFmk
         CSBmTuhcfIoGoIjcGqx3jNLvoKQXXiAvEAVaosHsbcapqW4rUL7J0+VmK+A1fDD3mmLA
         LBkJmmToNCDlY7RMnNMMR2p7OXMhPJdW4innV8vZ/jmxoCcfWx5HZ59t6lzxO/NVcM77
         l2pTk/0a7CHSxfmaaru3yYDh0IbblwD1Lo4LdtnKqpJZzksZUln09R0gSP2pp1SPQwxk
         WF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707762231; x=1708367031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOLcRqL4PWP5gx5t9V64UxQKQJUWLVYG/flknmF9Mus=;
        b=CYLEaAl0ECixg4Gexi1LfLq7x0waMRAdU6pWmonJTKUfjbZ6rog7XuU7tdy8Vt1XDX
         AKZMq7dokcDjwfppLTA6p9mgsI8unZwUMV4v0bqC2JRsqb2fp5PPdrf3620pG/eBVg8o
         zrRM92aMOzyIflPJ/R+r1CbrpZMq6ioerOozh3/6jz1aKCrMLJ3dYY/lSVLdB+5FIjff
         GeQql/Nq8AvUzYMGbopQVpyZmd63dEQRJbi2cz6VKiPRD3RE8CYMQ8aidsSHOThiQ/v1
         DXSUJlgswu/aHTRDkuAmtmqGe7Gl7MHC6LOR6dypr5cB/Yj6K4DrP6Hv9XK4kkh6qd7i
         64JQ==
X-Gm-Message-State: AOJu0YywylUrDWaQdQnzinURQO9doT/KUaJ2NoEAp9jQrP+emag0dRkV
	V0ikbFpteHw3Clu4HnikBF7oVTyX0XZe6y1BzYDDDQ37yIFMmq4tsSlt4Ru8kYpkRU46kXb0YlZ
	TcOD1gHErM50jULjZTanqmjmO87e+ItyPbbU=
X-Google-Smtp-Source: AGHT+IHM2kiH2B+Vz61Nscx+v9dwwpRLj4RZc73LknOKQi12kuv5pmc9W9ak75e4hQ/enHmOfvMF5hAAilnn4prauPY=
X-Received: by 2002:a5d:4f85:0:b0:33b:14e8:c97d with SMTP id
 d5-20020a5d4f85000000b0033b14e8c97dmr5891367wru.48.1707762230837; Mon, 12 Feb
 2024 10:23:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-6-alexei.starovoitov@gmail.com> <4ac1bea6-f1b0-4f9e-8b46-c181ce9413a9@google.com>
In-Reply-To: <4ac1bea6-f1b0-4f9e-8b46-c181ce9413a9@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Feb 2024 10:23:39 -0800
Message-ID: <CAADnVQKF_E8CObfk35z+z++cF7qm_919tdSbi8c4Jw2-XKbVNA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/20] bpf: Introduce bpf_arena.
To: Barret Rhoden <brho@google.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 7:56=E2=80=AFAM Barret Rhoden <brho@google.com> wro=
te:
>
> On 2/8/24 23:05, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce bpf_arena, which is a sparse shared memory region between the=
 bpf
> > program and user space.
>
>
> one last check - did you have a diff for the verifier to enforce
> user_vm_{start,end} somewhere?  didn't see it in the patchset, but also
> highly likely that i just skimmed past it.  =3D)

Yes. It's in the patch 9:
+   if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
+        verbose(env, "arena's user address must be set via map_extra
or mmap()\n");
+        return -EINVAL;
+   }


> Reviewed-by: Barret Rhoden <brho@google.com>

Thanks a lot for thorough code reviews!

