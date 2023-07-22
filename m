Return-Path: <bpf+bounces-5676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 983CD75DB4F
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 11:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6F82823F0
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C635182D1;
	Sat, 22 Jul 2023 09:24:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040911C9D
	for <bpf@vger.kernel.org>; Sat, 22 Jul 2023 09:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AEFC433C7;
	Sat, 22 Jul 2023 09:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690017853;
	bh=A7F1zmUw4KPxRoXFXZ1pO5q/1gFrwvDuZVFBYVGEmXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XcpBxqhEBeZsE22MmnIwHig0zXtwwyxQj7CLUw5rjbraL+O2OksMlQsPcgAWESJDj
	 ufzwQWM2avduDQ8Uo/Bn3Y28mShJRp98o76oHCZyPZbBqVYYxiLsqtEOlQ0JB7T3mW
	 HVXkNacF1dWMzFRTLab5FYRvoeBx3CAvqe+KpwBMxfvAEQW4VTRSenJec+xpHIhz2T
	 IjSCmNAWrSEkaogfT3FrK7zI8lL/aeBP5rBngQIOt3lZHOTTx62e/MhzUuCxYd9AdW
	 HJVoO2ru2XSLJqUUi7Qb8tmsZ5Ko6V2KYMm/ox3joXy0+R5XjHRh718NCyEnF4uZgx
	 tvlnaEujfCGzg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, pulehui@huawei.com,
 conor.dooley@microchip.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 kpsingh@kernel.org, bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: Re: [PATCH bpf-next 0/2] bpf, riscv: use BPF prog pack allocator in
 BPF JIT
In-Reply-To: <20230720154941.1504-1-puranjay12@gmail.com>
References: <20230720154941.1504-1-puranjay12@gmail.com>
Date: Sat, 22 Jul 2023 11:24:10 +0200
Message-ID: <87fs5gguyt.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

> BPF programs currently consume a page each on RISCV. For systems with man=
y BPF
> programs, this adds significant pressure to instruction TLB. High iTLB pr=
essure
> usually causes slow down for the whole system.
>
> Song Liu introduced the BPF prog pack allocator[1] to mitigate the above =
issue.
> It packs multiple BPF programs into a single huge page. It is currently o=
nly
> enabled for the x86_64 BPF JIT.
>
> I enabled this allocator on the ARM64 BPF JIT[2]. It is being reviewed no=
w.
>
> This patch series enables the BPF prog pack allocator for the RISCV BPF J=
IT.
> This series needs a patch[3] from the ARM64 series to work.

Just a heads-up; I'm on vacation for 2 more weeks, so expect a somewhat
late review from my side!

Thank you for working on the RISC-V BPF JIT!


Bj=C3=B6rn

