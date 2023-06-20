Return-Path: <bpf+bounces-2958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CAF7377ED
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 01:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F140281400
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 23:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2484818B0E;
	Tue, 20 Jun 2023 23:25:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7026C2AB42
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 23:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC362C433C9;
	Tue, 20 Jun 2023 23:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687303513;
	bh=vKs3Nn3T/tb9VC69M13qftg8yAfs62GKs6eI5yArd/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h5gLCg7QDfJ81tP2+/Va4XfHxM18mMN55498n2NiTw+wlLeE47Renbz+YpICVh7Pu
	 7HwHvpMMzlKqGH5VHfEDJd0TxWWVvLFpD0PxnXkKHHhksurtr4o3tIeC0tN0ctUjd2
	 TWYf5jgsXMdjMY7mfU8NMcWF1mK6u1UwbUd2DYDe93s5lKkVWG+1+pd21v5wS6hzEd
	 nRek0IVVuGsep5lInTahMLflKtF2nnFulQGIgbsM/tkPYXWNRaSgqsjjrCumRPtxqj
	 mWrHQVsfjs52o4Em9fcr0qV0pyzi3/MGBXmTczaXSotOXXzww7ExGPtt7WYt1TtzWJ
	 91mikawwFt2VQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f86e6e4038so3635579e87.0;
        Tue, 20 Jun 2023 16:25:13 -0700 (PDT)
X-Gm-Message-State: AC+VfDz86lk3HuLQ2UsHx4Wafl5ht1m1hvMMru3+OT54EHu1T5EaLgbw
	87C70i1WjDTYDSyo8XdxNc/EMrIej8lw1k5C0h4=
X-Google-Smtp-Source: ACHHUZ4uR5DEQ8f5ra7Q+/O6bWWssR1OOIHGdmsuiBLVUBsE5Y0ZJwFefrImhfNab17AYlhtRbsnMCBYBbG4Wlixexs=
X-Received: by 2002:a05:6512:2346:b0:4f6:1307:80b0 with SMTP id
 p6-20020a056512234600b004f6130780b0mr7329104lfu.12.1687303511923; Tue, 20 Jun
 2023 16:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230619100121.27534-1-puranjay12@gmail.com> <20230619100121.27534-4-puranjay12@gmail.com>
In-Reply-To: <20230619100121.27534-4-puranjay12@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 20 Jun 2023 16:24:59 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7FHYpccw-YRK6ka_EX8pVDuHvhvT0myLhZOkrGjJ6=Ng@mail.gmail.com>
Message-ID: <CAPhsuW7FHYpccw-YRK6ka_EX8pVDuHvhvT0myLhZOkrGjJ6=Ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, catalin.marinas@arm.com, mark.rutland@arm.com, 
	bpf@vger.kernel.org, kpsingh@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2023 at 3:01=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> Use bpf_jit_binary_pack_alloc for memory management of JIT binaries in
> ARM64 BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW and RX
> buffers. The JIT writes the program into the RW buffer. When the JIT is
> done, the program is copied to the final RX buffer
> with bpf_jit_binary_pack_finalize.
>
> Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for ARM64
> JIT as these functions are required by bpf_jit_binary_pack allocator.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

LGTM! Thanks!

Acked-by: Song Liu <song@kernel.org>

