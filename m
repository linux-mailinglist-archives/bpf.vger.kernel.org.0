Return-Path: <bpf+bounces-11078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083937B2726
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 23:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B5EDC283796
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 21:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4BF16405;
	Thu, 28 Sep 2023 21:09:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9D8839
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 21:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DF7C433CA
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 21:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695935373;
	bh=DOYtT8XqWvaKAWXjcDsdY5Ix4lfUlVYiGzpyiAu7WjA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f21yVN3qqVFzcJWcHpLU+IS92zIlkFB7YSF0+dYLuIfZ5iGLmuJI5TRGVAsCRZwdF
	 q03nnEXJ/YAo8dI41jE6ZhYD0KhOfoPT/HEqV1+2Ad8Vvy/oBi4LD3/YQWe08m/CvR
	 D/CdpLsSAo+yHFZWywDb4DvdruEQ/wsLjjbKwi25n8UyU40cNv9KGt2Fa9XHxgMG8j
	 ObQPAmYSWhFbKqZgnBTCAjjUkyCHswGt5d/dpk0T0psrjw3vemOc51W+N6otzfS8Ga
	 mUta/H/vPYTN1/8LUuN1im04MFbCH13jHb3VF3nGliCDaF+gBeOQu8YT0w3pGqwRk/
	 REYWWdM7n1AaA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50444e756deso17493081e87.0
        for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 14:09:33 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw3ptYPP/8V91+324drx9j/Jky36dVbA10jKRaS08aICiGGQ+gA
	TkeNzxZ1hxt6uaETW/UVU/kkMBI9JXhav8mZgvw=
X-Google-Smtp-Source: AGHT+IHtMR6OkeIBT4okRR6COTrfyiA8wsez9F9aBZFhUSyDUgbI8N7ZIA0ELzokJn8uKzfN8L6mJ1DVH+w+tjlOFyo=
X-Received: by 2002:a05:6512:47c:b0:503:38ef:eb54 with SMTP id
 x28-20020a056512047c00b0050338efeb54mr2210868lfd.37.1695935372169; Thu, 28
 Sep 2023 14:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928194818.261163-1-hbathini@linux.ibm.com> <20230928194818.261163-4-hbathini@linux.ibm.com>
In-Reply-To: <20230928194818.261163-4-hbathini@linux.ibm.com>
From: Song Liu <song@kernel.org>
Date: Thu, 28 Sep 2023 14:09:20 -0700
X-Gmail-Original-Message-ID: <CAPhsuW70FyyLnn-JUXrJke6V9srguKL6yrUP4hqW1eWcxCaZwQ@mail.gmail.com>
Message-ID: <CAPhsuW70FyyLnn-JUXrJke6V9srguKL6yrUP4hqW1eWcxCaZwQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] powerpc/bpf: implement bpf_arch_text_invalidate
 for bpf_prog_pack
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
> Implement bpf_arch_text_invalidate and use it to fill unused part of
> the bpf_prog_pack with trap instructions when a BPF program is freed.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Acked-by: Song Liu <song@kernel.org>

