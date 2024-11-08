Return-Path: <bpf+bounces-44394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864B79C26CA
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 21:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201CD286FBF
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 20:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E38220B819;
	Fri,  8 Nov 2024 20:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCsszgql"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A792F1F26FB
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098616; cv=none; b=EmM3tgd5XlyMLj4FiaTGnYhpAX/386ZfMGRphvTuE647WI6EjW9MKc9rYOcEH7WNXx2oSdl5f3ow7KCDuLFF461mInjYwNBEpNJC1IN1nnrxblAqURvTnRHIN9KuqN8M7cujzqr+2zqBPN6AtYiNTjWBg/G07w93KwNA5evcfx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098616; c=relaxed/simple;
	bh=crwsxzfCV1GYdvc0if1Y2GneFT6+DD2W7SSIJtf5tAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s5X9Be7Mb/FkKToa/2Pbddvp0YwCT2bsTSmSJPxQIZDx8vLnpiajhYZ7/Q4a3hUPx/VY49ecHpaPNdgwpNPpDs2GovqoiCRXjpi8R7MTU33o5keQ28PLpgxlHZ/2ipkarjCQIccetcaJVVWbhsHLtOTM1w8HZ9kOVS+6lb3EEe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCsszgql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E107C4CECD;
	Fri,  8 Nov 2024 20:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731098616;
	bh=crwsxzfCV1GYdvc0if1Y2GneFT6+DD2W7SSIJtf5tAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lCsszgqlliIKfsfW6yaczB6rGAp0Io7GNPZXrLsioDNXkFUVxNZe0bT0k9pVYUnjW
	 +swcY/MzZwer2warxwnOjBsyDpmeKtksJodKGHrpt7NepkYiFy0lyWJdfOalDJu7Wv
	 0HseBoMLwRpK3lQ2TK60TKH/GdjftdCjFeHAzHDBNVXMOsG75zjSTfL2AUA1Ehkdv3
	 fXYXOBwfxy/2SYXcNLHo2VZkMIXfd5+Fy7LaHr+GluKR0BmG0pLFMF99FwQe7MIeuT
	 8axewKXrn5zs5iRIa9Zjw7FzWAFO7mkpjiDqgT4YXzS+VadpotzGJjrAiUCh3Gc2AO
	 kF7Fq0Ks85EgQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5194C164C7C6; Fri, 08 Nov 2024 21:43:33 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, memxor@gmail.com, Eduard
 Zingerman <eddyz87@gmail.com>
Subject: Re: [RFC bpf-next 03/11] bpf: shared BPF/native kfuncs
In-Reply-To: <20241107175040.1659341-4-eddyz87@gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
 <20241107175040.1659341-4-eddyz87@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 08 Nov 2024 21:43:33 +0100
Message-ID: <87ses15udm.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> Inlinable kfuncs are available only if CLANG is used for kernel
> compilation.

To what extent is this a fundamental limitation? AFAIU, this comes from
the fact that you are re-using the intermediate compilation stages,
right? But if those are absent, couldn't we just invoke a full clang
compile from source of the same file (so you could get the inlining even
when compiling with GCC)?

-Toke

