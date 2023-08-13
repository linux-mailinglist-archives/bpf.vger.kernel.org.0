Return-Path: <bpf+bounces-7680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B3577AB25
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 22:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715B4280F89
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 20:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537449460;
	Sun, 13 Aug 2023 20:20:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E367C9443
	for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 20:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D367EC433C8;
	Sun, 13 Aug 2023 20:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691958044;
	bh=4c9Nf0xCFNZxfPRt4PlZyVsc+0YLNfixZSDSHDUw0jA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kbgnKHJuhrQSID8NCvBNxiKkQ85EEKEim4uacdl5bqSV9FcdOOa42L2xbef9HPoZW
	 ayelpyjakJg63h0I9RoWxdIL/tOx0dUoV4ifR33Vb5QZpyu9TJsLneM7DVhgPb7dml
	 F3APjUXxBTMSPyIhavL/1RcbMo1s1hA/lZg8U06lB2ZL9Ru6UThJ5hCPCllLjacBab
	 q/GhCxtg0u1FcZjTNWzsEqmj83d2ov7RmtiIOt3Xgb7/Ty0DsPgDKa6bVdos0bVxxO
	 Isd+h6n/EYzsuSM/42vN03WB/iCBzp7QvHQU91Ow6yDsleSCA7nX2IdAYDbXmxj+10
	 AxsJ7pddBfYAw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, pulehui@huawei.com,
 conor.dooley@microchip.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 kpsingh@kernel.org, bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: Re: [PATCH bpf-next 1/2] riscv: Extend patch_text_nosync() for
 multiple pages
In-Reply-To: <20230720154941.1504-2-puranjay12@gmail.com>
References: <20230720154941.1504-1-puranjay12@gmail.com>
 <20230720154941.1504-2-puranjay12@gmail.com>
Date: Sun, 13 Aug 2023 22:20:41 +0200
Message-ID: <87y1ie1yp2.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

> The patch_insn_write() function currently doesn't work for multiple
> pages of instructions, therefore patch_text_nosync() will fail with a
> page fault if called with lengths spanning multiple pages.
>
> This commit extends the patch_insn_write() function to support multiple
> pages by copying at max 2 pages at a time in a loop. This implementation
> is similar to text_poke_copy() function of x86.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

