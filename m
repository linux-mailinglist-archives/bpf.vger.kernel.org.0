Return-Path: <bpf+bounces-65406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A3EB219F8
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 02:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45E554E198F
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 00:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C90F2D77F7;
	Tue, 12 Aug 2025 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEBhl12M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593581724;
	Tue, 12 Aug 2025 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754960291; cv=none; b=rCiL8iRTz9Yx1XZzGSk0GqZUTbPbHTkVMf5U8yvKEfeQp0g7oDG3ySUa78xkH9SnnKohcb7vJ9C3zxecpxDeGs9KJ9Vt0wvDF9awhGh3UeNXvQ8ffMRGgXy3oGSW6ysgpruJAgRmvgCAeBFbYWZmCxaUiFokR09J0q+/4HWGaR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754960291; c=relaxed/simple;
	bh=IQPA4PqoRW2lue3aGTTtEd5Syy5gper/GRhKNnpr7Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AL/7FZpTSOQIXMm6A5ZxWIEiKW7uRgNIuYEHDbvcQhZr5VKfpBp5yFuDixHyhtTPVCWJH0cISqSwEi8+ncE5CZVg2ZsjwCUMLlAGtXEIPKXUhOGLkpxxzS2gymH2wHVsCaftHkDe1bX6NxftGAEDFql5QKZxwL+VcPVj2DuRW3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEBhl12M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093AFC4CEF6;
	Tue, 12 Aug 2025 00:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754960291;
	bh=IQPA4PqoRW2lue3aGTTtEd5Syy5gper/GRhKNnpr7Ic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oEBhl12MTmdK8WgC980x4gbQetlFSmGty4vnbKzlzHr5xWiLOVQYLCDe1VShfqWvn
	 6AE52zN1OEicO5EXR/hPXhWHRS4Bvhi2ziXjmOltvylR57ZInstgdEi0y6ep3GNVqI
	 7ENQkq7BVtMhM+nacIoZDdCm6EVuV2IYdovSh+pHVBEERtG4DMCyE1vj6Z4OJVkI3a
	 /EZWaCS8Qo5qZKA1SYqKib98O3+y1DcIWR/QhKfqVxAI1URQQHhnlI1r/oHkm0tWXT
	 GwJDvOrbVARUpMlD3YDajZGaz0eEJ6YcSDfmVUXUK+pDI5HvFnJdBGMTCqUHS8qnV+
	 e0vENkZKAGcuw==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e8248b3f1cso614816685a.0;
        Mon, 11 Aug 2025 17:58:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdeSDIoIl3fmaZlyzYjP06GZNikWIASZKwL+CUn/QhdzKN+nACt9vQ1C8ElSL9/3bkjKlWUcCKQwtsvh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhamo6pqG0pJjZG/SVvhLWQ1M57MD9nnjCz6HK7i7wzun7BDuV
	NHqt78y7LJUU5JwRfHQjybRsnvdK4ca9sKgO0i9H+0Cie9++fPfGnQbGZ4JF7SwhIWk+tDGPf2U
	uRui/A3VGjdtcVoACZygivJKtITGrXzc=
X-Google-Smtp-Source: AGHT+IHuem+tu1DHmNMrs6L4pJy33dn1LHNBWVMghsuduFVvSdwfz2smuBjVYx592Sb/2XmGENiRYWhvsYzb1SVWkSA=
X-Received: by 2002:a05:620a:4543:b0:7e8:1ff1:a9b0 with SMTP id
 af79cd13be357-7e85883b820mr287226185a.8.1754960290152; Mon, 11 Aug 2025
 17:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811201615.564461-1-ebiggers@kernel.org>
In-Reply-To: <20250811201615.564461-1-ebiggers@kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 11 Aug 2025 17:57:58 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7shC-cN7nGLiaVcAAtxbmet45R0XZ8zRS2P2H5Bom+dw@mail.gmail.com>
X-Gm-Features: Ac12FXzia7PZgTp-FjBuljQe215ugPnhOF7m1j93G1blG3H6fFz6axKVrzHIKLs
Message-ID: <CAPhsuW7shC-cN7nGLiaVcAAtxbmet45R0XZ8zRS2P2H5Bom+dw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use sha1() instead of sha1_transform() in bpf_prog_calc_tag()
To: Eric Biggers <ebiggers@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, linux-crypto@vger.kernel.org, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 1:17=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> Now that there's a proper SHA-1 library API, just use that instead of
> the low-level SHA-1 compression function.  This eliminates the need for
> bpf_prog_calc_tag() to implement the SHA-1 padding itself.  No
> functional change; the computed tags remain the same.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  include/linux/filter.h |  6 -----
>  kernel/bpf/core.c      | 50 ++++++++----------------------------------
>  2 files changed, 9 insertions(+), 47 deletions(-)

Nice clean up!

It appears this patch changes the sha1 of some programs, but not
some other programs. For example, sha1 of program
test_task_kfunc_flavor_relo_not_found from task_kfunc_success.bpf.o
stays the same before and after the patch, while other programs from
task_kfunc_success.bpf.o have different sha1 after the patch.

Is this expected?

Thanks,
Song

