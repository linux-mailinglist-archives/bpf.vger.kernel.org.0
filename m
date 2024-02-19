Return-Path: <bpf+bounces-22257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7364D85A440
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 14:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6E7280C95
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 13:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DED37702;
	Mon, 19 Feb 2024 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDrf2ii6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A151376E0;
	Mon, 19 Feb 2024 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347888; cv=none; b=ANpuDq1Y/T/CnpbAoCATTspYTleDFnAXZ9D2RZSGPs7mHzPFLGwJ5173youzSpOxPC5MT78wS/LyCOuxZqsjwVEabF3ZobOTf0KRVqPLEce7CQ4MPlbCrz2gmNMU0qkco5awqwKGKyI0YCelDDpYvRftcgXC0v6GzhvdoFMezo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347888; c=relaxed/simple;
	bh=F7lFIi5YWEQkqiJdWwbx2quDPyRISPmN8tr0pDUd78c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rf5VyDqHPL3cAVGJb+o3OnLhWuTnxoJ0r2IgBSA4HsEqjN/HJrsecBlvRbfkPlQOstIanj9ChMfPJxEuY88xUJ/kFstbHYgAURKvypo6E1+PNHxdQInlUd/cgg89jwL9xThs2PFDq8ixDwi9474nkXBmeIctz0DlyONVDkrdd94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDrf2ii6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED59C433B1;
	Mon, 19 Feb 2024 13:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708347888;
	bh=F7lFIi5YWEQkqiJdWwbx2quDPyRISPmN8tr0pDUd78c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XDrf2ii6+/hTpL3c07hOnzKUx4KJ1Vb5+CNsbZAoiNbaFD+VUlNJ+CNNJQo7RatC+
	 twRqAtjIVwor/O3pExrMYPBd3yjJfqjyzmkT6RsCJTzddGiDzJTPjnPj5vE2eND5Uc
	 yVqYCofGovHcBl8svChqtUjor8X16fq8xOIH0ggJPOqNh1k1Q7AqDTEo4axkjyf5jo
	 Y1OGqZExKLsz2JGjKH84CpA5nEDgFB9rJkXHccv9FQeDmvyJgp4e9LxACExkah74tL
	 AHbF4HF2Ye5Tz/iIi23W1R/qN0JAwoq6gpFnc/DLP1YX5RMxgpirJre5B5t06ot4Hq
	 F+iEdIeH+QKhQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Samuel
 Holland <samuel.holland@sifive.com>, Daniel Borkmann
 <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: [PATCH 5/7] riscv: Pass patch_text() the length in bytes
In-Reply-To: <20240212025529.1971876-6-samuel.holland@sifive.com>
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
 <20240212025529.1971876-6-samuel.holland@sifive.com>
Date: Mon, 19 Feb 2024 14:04:45 +0100
Message-ID: <87y1bgehaq.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Samuel Holland <samuel.holland@sifive.com> writes:

> patch_text_nosync() already handles an arbitrary length of code, so this
> removes a superfluous loop and reduces the number of icache flushes.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Nice!

Nit: 100 chars lines, please.

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

