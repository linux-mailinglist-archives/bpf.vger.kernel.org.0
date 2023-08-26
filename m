Return-Path: <bpf+bounces-8750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A4B78971E
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 16:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23A22817FE
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 14:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211DADDDB;
	Sat, 26 Aug 2023 14:06:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147D7CA58
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 14:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17630C433C7;
	Sat, 26 Aug 2023 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693058764;
	bh=ukZ6g9EgWPFpAkFvHGXVcuI1MM3Y+aVwL2MADMeVBTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hEhdoseJzsPGizH7PA9sWAhJB8NV7oOIzb56+6bL7zKKO0dzFZQtjYW53M9Rdtrm1
	 PDll6zD9T3tkm1zl9r1jdEooRVqDYJEYqiBPe8i5umSYGTn8SSoExX7ih97FPcgUaX
	 xJUQsdOmuSD77v+2LbiRvJ8yv8ycUPjuEfgX5IZsC7xVUL5KQFE9UGSNONHVcUIjBK
	 KpDDt8BG7KLshSVKBFcqpDFH72eAt6ZlwcT4g7NHwF86Z+N4JnmPbCzpGW8F+tYP16
	 DtWyoGHvduD4mTpnEebDQkX8/Y/h/DN6ObHHNQFnzIUnqoJBDcEW/Lvc7aTk75p6HO
	 8o29gxRGxD3sw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, pulehui@huawei.com,
 conor.dooley@microchip.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 kpsingh@kernel.org, bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: Re: [PATCH bpf-next v2 3/3] bpf, riscv: use prog pack allocator in
 the BPF JIT
In-Reply-To: <20230824133135.1176709-4-puranjay12@gmail.com>
References: <20230824133135.1176709-1-puranjay12@gmail.com>
 <20230824133135.1176709-4-puranjay12@gmail.com>
Date: Sat, 26 Aug 2023 16:06:00 +0200
Message-ID: <87v8d1q4on.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

> Use bpf_jit_binary_pack_alloc() for memory management of JIT binaries in
> RISCV BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW and RX
> buffers. The JIT writes the program into the RW buffer. When the JIT is
> done, the program is copied to the final RX buffer with
> bpf_jit_binary_pack_finalize.
>
> Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for RISCV
> JIT as these functions are required by bpf_jit_binary_pack allocator.

General style comment; Please try to use the full 100 characters width
for the patches. You're having a lot of linebreaks, which IMO makes the
patch harder to read.


Bj=C3=B6rn

