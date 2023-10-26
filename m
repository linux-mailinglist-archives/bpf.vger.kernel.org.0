Return-Path: <bpf+bounces-13352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C224B7D89A4
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 22:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61FF3B212A8
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 20:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4B33CD02;
	Thu, 26 Oct 2023 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QADcdLah"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC584156CE
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 20:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0F4C433C8;
	Thu, 26 Oct 2023 20:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698351671;
	bh=P5VjtQYXdi5ByhK4K3nPatgozZMyiarkgmt0/OGG3qk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QADcdLahXOWtb6rcy+ttxrDJvYFzmckCVdBnUf/asOvc0thnUHNp955vHJ5qhWzjC
	 1UwzT+5dsXnTmvgie5ZGafKYRm6e9qLeFdadY2hMBciXCqGhND3/x9IArr9LQ6jBSu
	 7bXFHg+eT0KA+uaUvz5up259MOvqkfljSnUDAZY+F59q74hergSp7gt6yZOJ/LeX5U
	 OPPiw7FPu67O1XSNJ0azl2K6cUKtB9XikoL28jzvAtow3I4369Hwx3PFgTwpBB7mI9
	 54jcTV4hvR3j2HfirWCojsdRrRCWizS6KO3It9mBJLn1Ya+dfYCnvCqj3nhj09Vw97
	 xWQRfMgKDAb3w==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, kernel-team@meta.com, xukuohai@huawei.com,
 pulehui@huawei.com, iii@linux.ibm.com, jolsa@kernel.org, Song Liu
 <song@kernel.org>
Subject: Re: [PATCH v5 bpf-next 6/7] bpf: Use arch_bpf_trampoline_size
In-Reply-To: <20231024224601.2292927-7-song@kernel.org>
References: <20231024224601.2292927-1-song@kernel.org>
 <20231024224601.2292927-7-song@kernel.org>
Date: Thu, 26 Oct 2023 22:21:08 +0200
Message-ID: <8734xxgmob.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Song Liu <song@kernel.org> writes:

> Instead of blindly allocating PAGE_SIZE for each trampoline, check the si=
ze
> of the trampoline with arch_bpf_trampoline_size(). This size is saved in
> bpf_tramp_image->size, and used for modmem charge/uncharge. The fallback
> arch_alloc_bpf_trampoline() still allocates a whole page because we need =
to
> use set_memory_* to protect the memory.
>
> struct_ops trampoline still uses a whole page for multiple trampolines.
>
> With this size check at caller (regular trampoline and struct_ops
> trampoline), remove arch_bpf_trampoline_size() from
> arch_prepare_bpf_trampoline() in archs.
>
> Also, update bpf_image_ksym_add() to handle symbol of different sizes.
>
> Signed-off-by: Song Liu <song@kernel.org>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>  # on s390x

(And this one got stuck on my queue...)

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com> # on riscv

