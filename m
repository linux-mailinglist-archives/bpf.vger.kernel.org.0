Return-Path: <bpf+bounces-22251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324C985A326
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 13:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E8F1C23AB2
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 12:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0941F2E835;
	Mon, 19 Feb 2024 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4u7Qbif"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840362E645;
	Mon, 19 Feb 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345509; cv=none; b=bN2OXPMolCI0DwRs5YsrhDqhIC0OG6rFuNDkNsYq3Qns4RuGxv5hy5lt9uAZ/8ulZyZDIEbPUKFWg2FTUItjXUsp0VTyQHgqNi4po+c+ph6MgL+PpRude2+bAi1j2Jh0PuABEHnvFsjJsvHazME2Y4xbL2Cv3FuPtrahJ/039dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345509; c=relaxed/simple;
	bh=Qt19ljXFDHGnHsJC4+Ibe49Z9ewRnSNk2tYJMGxyCEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j0bP0SjsM+KhF0ChobTcqOEemW9+IeBxM9jrY7E53zZ4tcyiQTtuIdgJmGER7e7tUSIdM+BODsWBgpQup5s7Bx80abBxaBav8QikMfvvWpM8aw6VjDu4t37FeD9zbGEdQcGRJeIlQ3EYYGKuqe3w51DhV+jTyLNSUPldDc5X6SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4u7Qbif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F711C43609;
	Mon, 19 Feb 2024 12:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708345509;
	bh=Qt19ljXFDHGnHsJC4+Ibe49Z9ewRnSNk2tYJMGxyCEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=H4u7QbifuxAeJ6eSh940HphqB9PmtRuzg+WBkSsKMWqS3vtrXfp18rtzxrUJOUm3e
	 dghQfLgD5drU3GkO28skuRzB7lgL8yd9FoaW5jOqJ8O2ofm7g8hDU62m3SHx54gYEY
	 P0FQe/vpi7yF8h0k6zMT4MWaRJCX/OPUJ5f4wyHSGCr15tDNM0rmeCB4ptqF37t/p3
	 KGUw7j93NmCTXtkHJjfbQiH6yn3YQEFH/db4yqG5u6r44tn2XLjIwACIAvzKhQFOIp
	 ki6KlTWmUHgN9TvIkZSGS43MZuw5vhHz6dc7Tn50rwYSMVY94SRkzCV6Lc4vZq1lVY
	 M6eUzZyJY0zyA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>, Samuel Holland
 <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jason Baron <jbaron@akamai.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org, Alexandre Ghiti
 <alexghiti@rivosinc.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>
Subject: Re: [PATCH 0/7] riscv: Various text patching improvements
In-Reply-To: <ZctnfZWWO3HCiXe5@andrea>
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
 <ZctnfZWWO3HCiXe5@andrea>
Date: Mon, 19 Feb 2024 13:25:05 +0100
Message-ID: <87msrwfxpa.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrea Parri <parri.andrea@gmail.com> writes:

> Hi Samuel,
>
> On Sun, Feb 11, 2024 at 06:55:11PM -0800, Samuel Holland wrote:
>> Here are a few changes to minimize calls to stop_machine() and
>> flush_icache_*() in the various text patching functions, as well as
>> to simplify the code.
>> 
>> 
>> Samuel Holland (7):
>>   riscv: jump_label: Batch icache maintenance
>>   riscv: jump_label: Simplify assembly syntax
>>   riscv: kprobes: Use patch_text_nosync() for insn slots
>>   riscv: Simplify text patching loops
>>   riscv: Pass patch_text() the length in bytes
>>   riscv: Use offset_in_page() in text patching functions
>>   riscv: Remove extra variable in patch_text_nosync()
>
> This does look like a nice clean-up.  Just curious (a "teach me"-like question),
> how did you test these changes? kselftests, micro-benchmarks, other?
>
> BTW, I recall a parallel work from Alex and Bjorn [1] that might have some minor
> conflict with these changes; + both of them to Cc: for further sync.

Indeed! I think Alex is still working on the v2.

