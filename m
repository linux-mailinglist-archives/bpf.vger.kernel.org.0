Return-Path: <bpf+bounces-8532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1C9787B65
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 00:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A54281681
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 22:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71155AD31;
	Thu, 24 Aug 2023 22:19:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05602A93E
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 22:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887ABC433CA;
	Thu, 24 Aug 2023 22:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692915560;
	bh=zvH8ONOUJWk9e87genF3KmOMumc0b+2p11O9YN0uraU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Py9k2pBynJepls2T4y1A5dYXBOUBsYr/oyTG5rN13nfoKhzOnEbkTwRrwOK2xB3DQ
	 HnW2YN/npJ4d/FGrPv/gKh+QrBMHxiQynYBsdTGeooDkT1Ie/gqToTtxp/N08YM17A
	 y6sQKI+4bcu6DHawsCXgMj2cqrZ6rOfpfryt+o1eKtQpjkkph8hy6wohB84935sg3J
	 scMMKMtNGoH+BYelFpIuU0TIiX7CvrA89okXXS40NhKYliU1OABTbfReE1sFfwPZfy
	 F7in4L+LE5k6Z5S2kizXOX77M9c+aAh6Hi8lp4ktXuYtpgp5ar2EJ30z/Zcu/k6kem
	 l5oeLOEydkqMw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4ffa01fc987so1637936e87.1;
        Thu, 24 Aug 2023 15:19:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YxX8vXxqytWKg3sAFGsFmdkuiwK5aKBp0LZQ/iU99A8GuoY3g5G
	tO1QWT2WqpIZ7erPIq8qYCbewDs1D1opnVGbSYY=
X-Google-Smtp-Source: AGHT+IF2/zODRPW5Xo9uTDOdjogrYYoQqdmXIyi7fsgZ23qeHth2bWzkXZpzsrjdMEfTmPWdilSHUZJb7Eond9KK2Y8=
X-Received: by 2002:a05:6512:1193:b0:500:9a50:8970 with SMTP id
 g19-20020a056512119300b005009a508970mr2066629lfr.31.1692915558581; Thu, 24
 Aug 2023 15:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824133135.1176709-1-puranjay12@gmail.com> <20230824133135.1176709-4-puranjay12@gmail.com>
In-Reply-To: <20230824133135.1176709-4-puranjay12@gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 24 Aug 2023 15:19:06 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4hfBMvB9DzM=ZCnq5Bz-bpFTP1gBujyEN7NxdsXnnceA@mail.gmail.com>
Message-ID: <CAPhsuW4hfBMvB9DzM=ZCnq5Bz-bpFTP1gBujyEN7NxdsXnnceA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf, riscv: use prog pack allocator in
 the BPF JIT
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	pulehui@huawei.com, conor.dooley@microchip.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, yhs@fb.com, 
	kpsingh@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 6:31=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> Use bpf_jit_binary_pack_alloc() for memory management of JIT binaries in
> RISCV BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW and RX
> buffers. The JIT writes the program into the RW buffer. When the JIT is
> done, the program is copied to the final RX buffer with
> bpf_jit_binary_pack_finalize.
>
> Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for RISCV
> JIT as these functions are required by bpf_jit_binary_pack allocator.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

LGTM.

Reviewed-by: Song Liu <song@kernel.org>

[...]

