Return-Path: <bpf+bounces-65026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB0FB1AE2A
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 08:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1863189D05D
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 06:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4331B21ABD4;
	Tue,  5 Aug 2025 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpmpZB9V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7E021A424;
	Tue,  5 Aug 2025 06:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754374965; cv=none; b=FvEfcphAQ3q8Omtx4ueu/TQ6xquFR2+zcBdtZS7i7+olmGeUYNJZGjT8AZNP2PqN81tt+XCRjo3OX71nsJTXcgliegzhJqw/BkIWVkSq+EHs+aR3C8imZX5EysNFNhrI/fXbvwtmHVjT2w4TGY6JevJPKdjtjY7AdZhkXT+KtOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754374965; c=relaxed/simple;
	bh=5xIvnTl3bYzB7tPvwCECdm4JozJkV4aSeyKvq1EVy6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dg9Mh6pgLnzmxK4kDDmKS348rkUXQ0sicPsNYN/GFkXMt7F35Yo+uq/YqPtIgcek4EwUt8bv3LdIUUpSamZvz0fwixqXJWgZr858r216QublOGjrqS8TP1895IT6pe+YI8Lu0fyEngZfh8xeHHJiPDxBdLCDXvP+E2+p8YzDFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpmpZB9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA625C4CEF4;
	Tue,  5 Aug 2025 06:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754374964;
	bh=5xIvnTl3bYzB7tPvwCECdm4JozJkV4aSeyKvq1EVy6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HpmpZB9V3hIsTH/be+3zyRLB/VhBeWtBUlrgkxyrgwJFWOs4T8AIYYBO+bYiXplfn
	 tsEWezuLTMRRd3bJe/Dr90g8ia1xSWgvSxpGzDpUbPCpylVi11PUgU4wKdwjo7do02
	 C1yTL1XZ+u9r0VeUrNd7C67PbcwZpxixebmzjAyUAYjFoTg0951ULmQTknPaGKT9GG
	 g9qpi9bke/lqVf9QHtbyqV9zsDbttQnQiBVA91QfS1L7RG5kiCl48ojxKm2Eo6q04q
	 r8t9NyJL3HPEn/EyRKrPmuynXv5w3GoDE7aCLzN5siEnbefEVyWMzElQpFzSI6HK7p
	 M8gJsQT3osK5w==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Pu Lehui
 <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 08/10] riscv, bpf: Add ex_insn_off and
 ex_jmp_off for exception table handling
In-Reply-To: <20250719091730.2660197-9-pulehui@huaweicloud.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
 <20250719091730.2660197-9-pulehui@huaweicloud.com>
Date: Tue, 05 Aug 2025 08:22:41 +0200
Message-ID: <874ium2spa.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> Add ex_insn_off and ex_jmp_off fields to struct rv_jit_context so that
> add_exception_handler() does not need to be immediately followed by the
> instruction to add the exception table. ex_insn_off indicates the offset
> of the instruction to add the exception table, and ex_jmp_off indicates
> the offset to jump over the faulting instruction. This is to prepare for
> adding the exception table to atomic instructions later, because some
> atomic instructions need to perform zext or other operations.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

[...]

> @@ -748,7 +745,7 @@ static int add_exception_handler(const struct bpf_ins=
n *insn,
>  	 * that may fault. The execution will jump to this after handling the
>  	 * fault.
>  	 */

Nit: After the upcoming change, the comment ^^^ is not entierly true.
Don't respin for this, but a follow up would be nice!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

