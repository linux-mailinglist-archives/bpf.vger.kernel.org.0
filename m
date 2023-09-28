Return-Path: <bpf+bounces-11080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A987B273C
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 23:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 80DE32837B3
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 21:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B5216416;
	Thu, 28 Sep 2023 21:12:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E7816407
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 21:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B9BC433C8
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 21:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695935533;
	bh=qGYf0Ot6wDp4Tf3fgiYIzUrKLJOt5tM0YIMbv15baXI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WIlYOoaBv3SfCBFg3U6tH82eGrGEAZHhue7xoznsz+aFaFJzo9r3vIti4hh80TZhU
	 32/a5908t7H+5v6vKi2Ed4cDha5nusHXP6hf2gYzo3v2bQotIYjokDVdRO5U30z2uC
	 QVi5rACVPEmjpsAwcE+GhDM+ThjCpWFWtGTAy+DoNa/2diAL0OkmdICsMMhmufb8iG
	 1/Gq+twqKEaLqLvQiKKjqnnUejY+fGN1o0XMx2poRltbfkmlYKzeR+/U8AlD3Bx3Rl
	 PO4TYzQRECX4ax/2OPrQGOQRC1Sv2D7Y6T0fRVmXtcWpenLBIvt3VbTS4TOOjqDbqC
	 sr2ndDQfGUliw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50317080342so22315123e87.2
        for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 14:12:12 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz3zA/GefaMwQgMHlR+le4FgokwZW3FCxdLB+rMh17zsPUwLB76
	3wXIMOgRs8q3/VrycjYMA043k4WKYSQeyLayw9A=
X-Google-Smtp-Source: AGHT+IEh4Ki/LitKTQkP2Eoj8RzO9bXbkxs3ZzcTN0vMDDoY+OlegyBlrv9S1uz3Z9WvEeeZlOiAUMWOhAVFQAQAu8s=
X-Received: by 2002:ac2:549a:0:b0:500:75e5:a2f0 with SMTP id
 t26-20020ac2549a000000b0050075e5a2f0mr2208799lfk.51.1695935531220; Thu, 28
 Sep 2023 14:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928194818.261163-1-hbathini@linux.ibm.com> <20230928194818.261163-6-hbathini@linux.ibm.com>
In-Reply-To: <20230928194818.261163-6-hbathini@linux.ibm.com>
From: Song Liu <song@kernel.org>
Date: Thu, 28 Sep 2023 14:11:59 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5Pb+jXMopC7CACJ=2qHDYxMQrw+xgxm4DLHBa4+PBW_w@mail.gmail.com>
Message-ID: <CAPhsuW5Pb+jXMopC7CACJ=2qHDYxMQrw+xgxm4DLHBa4+PBW_w@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] powerpc/bpf: use bpf_jit_binary_pack_[alloc|finalize|free]
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 12:49=E2=80=AFPM Hari Bathini <hbathini@linux.ibm.c=
om> wrote:
>
> Use bpf_jit_binary_pack_alloc in powerpc jit. The jit engine first
> writes the program to the rw buffer. When the jit is done, the program
> is copied to the final location with bpf_jit_binary_pack_finalize.
> With multiple jit_subprogs, bpf_jit_free is called on some subprograms
> that haven't got bpf_jit_binary_pack_finalize() yet. Implement custom
> bpf_jit_free() like in commit 1d5f82d9dd47 ("bpf, x86: fix freeing of
> not-finalized bpf_prog_pack") to call bpf_jit_binary_pack_finalize(),
> if necessary. As bpf_flush_icache() is not needed anymore, remove it.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Acked-by: Song Liu <song@kernel.org>

