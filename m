Return-Path: <bpf+bounces-67837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0E4B4A01E
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 05:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA494E6441
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 03:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2010527466A;
	Tue,  9 Sep 2025 03:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BA2hMqfp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C30626529B
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 03:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389077; cv=none; b=SXI753x9S2QslaYO5k3VGvNZYUyTIHrBgHKjhAk3sjWCZ7iLEs7Yf9SalpL5vwaOnbYKjH4pATXi84yS0tXHKvvmFdgEwF+eXkX3zVLYxJMPFak681363+27QdyaPTp2rfmolFL/tIz7J9a2CMXOEPoWiEIqt5PVHE0U332usH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389077; c=relaxed/simple;
	bh=R9TIjEGBHJvOpzfCva5pnVMZC+c2zPOGBVmYquzb3g0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWAZXshVEamoVUVL8cxC5efOXrXwJpB1OgDLUx+4YY97lIeyXeV2TANtysrgBwd3R0cAhMYuLMuL5xSxS567fh7etBY3RmVkotRzhPv9du71HCUllNPzKhw3F3HuA9gaqDoC/6dyKXYPFpHGa71F2naAwOTbabbXnfUg4OeX+mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BA2hMqfp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24cf5bcfb60so405705ad.0
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 20:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757389074; x=1757993874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9TIjEGBHJvOpzfCva5pnVMZC+c2zPOGBVmYquzb3g0=;
        b=BA2hMqfpPgctPIWZLQaNbdsMEFPnsRRlOwabM1MVL4WtWXcoFGdTvrBUbUGybeuN74
         My6dujH2ZZYwvozEIb8FBbii9aoklLE+mqNX8oDGQoa8jPzgyMQ9+pQjAHvdtIptbveP
         gGsE4d2hp6KVfnXNntqexh0JRJ853cgQykQqc5lUzOac86g3w3aHTqlPRgAQ8/V3wLGM
         dJIryzhJFkq1ev8fS04L8z4JJ/GmmoynZC5L+zcJHjSd77gHnctz0E55Jqskbc/W/0U4
         1cXty+wQJcaltL26PDzP1jBixBJF/oTpQ1uWoCEw6m7aBjR/9XZYmmzSGuUEoNsKpEpd
         eo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757389074; x=1757993874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9TIjEGBHJvOpzfCva5pnVMZC+c2zPOGBVmYquzb3g0=;
        b=QDvCU/uDhHAa5ZZ8HwZE9jRQC66e4q/MmawhLGxQCaupGlhSxHgcCW+ExYpYtSNyxM
         W8IMP7C0Fbow2NKyqgiRzScw9r+R6nPe0pp3GGEJZMM7YrFiNPizMjnIP9vOASvscWca
         KZZFByhVwO1JXSf6eWBclt8GbsTZmk+fMoSbdOPgfAqZCw8AsgNhNOm7VqlRDPIij+g8
         ZauVHhv3Ar34I62hQGIqAo+VplsJ9q9u1zAkTD53nlD3TfM/u5AeMkEK4BTKA9AVektI
         t2VJ9p11qBdRBUOQsSsefteIvgc4gQtyvsNFXWebx9oA0jnKKKpbGQBkM+++4dGEZd+d
         zDUg==
X-Forwarded-Encrypted: i=1; AJvYcCWDWUWm9P/7JoCmQVh8EmMwVrhJnhsaEIsrJBwrX3VpDCLQSrr7eY3C0JtkIp98QGs/euA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlV+yhFbauB9Bt3hsBjF9DM5HOEw32P/Sg5avTqnA5rRlqyk2n
	2FcL00mOGQ4jiq98zldgvUyj1X6Pccqmzv+kntQhctWL9pHYe4B3QmyyJzVYkZtewH1QL9NzX6I
	3w0MxJ45wQDZcvNMEY6zFd2qh91o2hMFbTn5tRVAj
X-Gm-Gg: ASbGncvXTRu1pV7DOwMYEkZnSRtqsMWyAxaUW5k7UuaX0hLshRZ3xJs7wCyViiRzB+X
	iHjaZU22wNAWG/qBKj+avRQ9q9/tZiyD/LXLgmFB8Zv68O9qEnwB5Cy+4qUjfl793ticO4AKZei
	PxOTJw6K1hr+2AQb54WzmW9wE6rt+0rx3N9L0mFNeZOryPyKc/on+yTuiGc2RYGzkY/DWJ5bEsk
	Xrb1E8VvEUPqPBJhhNIpoED8mjKAruQjmLw
X-Google-Smtp-Source: AGHT+IHZEv7S0yqxnkNuP1W7kwOxLdWIqSFH2fvaOMywvOWjbfZJzlq/tdw95cHtFgBVoXq3Nr8yc9vVu7TDngqITFw=
X-Received: by 2002:a17:902:db11:b0:24b:1741:1a4c with SMTP id
 d9443c01a7336-2510f458c5emr9942915ad.0.1757389074383; Mon, 08 Sep 2025
 20:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903172453.645226-1-irogers@google.com> <CAADnVQLkhysjnEsZACK-fgG3XBaHj1FqnhJdu+0V6PCbpKEK=g@mail.gmail.com>
 <CAP-5=fUm0-f6CW1DNKWK0Zv_4Hzqe5oV+d4ajhd3+XMdxXvu2Q@mail.gmail.com> <CAADnVQK_X7PnKwbrmS2sT+oV1ZVYfmnagt_Wi5wg2nO9vt=W6A@mail.gmail.com>
In-Reply-To: <CAADnVQK_X7PnKwbrmS2sT+oV1ZVYfmnagt_Wi5wg2nO9vt=W6A@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Sep 2025 20:37:43 -0700
X-Gm-Features: Ac12FXwOEtFt0omQgpq8-1lvJkOwUT-yCFsKqELPXWqu0zjP_pbGE4cRiMZyE5M
Message-ID: <CAP-5=fUVGLiyu8fiuM7P0CG6d9R07pvUq_sfF9WXmJbhatdObQ@mail.gmail.com>
Subject: Re: [PATCH v1] bpf: Add kernel-doc for struct bpf_prog_info
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 3:32=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> Posting a patch generated by AI without proof reading is not ok.
> Wrong documentation is much worse than no documentation.
> If you don't know what these fields do don't add random comments
> to them. Read the code and document based on your understanding.
> Copy pasting AI and throwing it at maintainers to review is inconsiderate=
.

That's not what was done here. An AI has the advantage of reading
mailing list posts and gathering wider kernel context. As the code is
devoid of comments and I lack a fuller picture it was the best I could
do. Were the code commented then I would have just migrated the
comments that are missing.

Here is the commit message that captures what was done:

Recently diagnosing a regression [1] would have been easier if struct
bpf_prog_info had some comments explaining its usage. As I found it
hard to generate comments for some parts of the struct, what is here is a
mix of mostly hand written, but some AI written, comments.
[1] https://lore.kernel.org/lkml/CAP-5=3DfWJQcmUOP7MuCA2ihKnDAHUCOBLkQFEkQE=
S-1ZZTrgf8Q@mail.gmail.com/

Anyway, you can decide to ignore this patch. Feel free to write a
better one yourself. Take this patch as a bug report in the form of a
patch trying to address the problem. I'm sorry that this has caused
you such a great offense.

Thanks,
Ian

