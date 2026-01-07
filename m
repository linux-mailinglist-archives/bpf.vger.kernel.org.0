Return-Path: <bpf+bounces-78069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AA5CFCA5A
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 09:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D22A30D4A1A
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 08:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662B02C11CB;
	Wed,  7 Jan 2026 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="mCNEnUzk"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75B923EAAF
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774937; cv=none; b=HixORMXdKgS+UruO3gHYlZ/Wo/dy9I3zfPmG5sWGYYp2yA5Jd90SR+PBOlOOsKfm+AnN2LaLn0SimU63PBnMFysCgwo7yUTqoHbJZqLimgFQePRM+B0JlwQpd+ttbR5KhWxnj9hLdiNoWU+fRg2OexY32JsC7JK8nDTIKvg8R6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774937; c=relaxed/simple;
	bh=hBWHCIpkzChrATnFln/bxRB+e8DDJ5hzfUmuXh8ecCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C060fb1/UISsrxbGW3na9Qv0f2/fLIVktaZz3r7giZPTYIBi7KnYZyaZ4bDdKJ+i/k9nSpytAD+egtpg/VtplFqr3YbSt4KSxWiVZrA8tNCPI5o+P7a0PzAOsZjoj2r89EKU6PPa+TVk11Fy36WqIpZWi85+t75xWl390P+/CyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=mCNEnUzk; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1767774421; bh=hBWHCIpkzChrATnFln/bxRB+e8DDJ5hzfUmuXh8ecCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=mCNEnUzkeFL8UqBRb94lEX1fV6Db/78BEQCeNi5G4TLNVHcP6bWcS03fVJ4DIbR6/
	 nL3xoSzdHk5Mr0noHL5yXtVxm23RdjgUZ7siVO3nKgtCEyEyWVld4kXXIoWnNuFvyg
	 b8SVvAJoFDXDxc4SjZWqE6h0xTZmjXEJjjRzumTY9YDwgL69TsnYguRYVxIEyy0nXI
	 1OjjGuyeuxsFVYAmRcwjt899jgzgJ8qMBpHEp+8tbtJtFvEdXmyYzKlDA6cm17BY2S
	 gGfwD03OE9S3+HTk76WdRzvFnmXOm5JRdEk4W065gqOi8U2gFJeLOEFjPJpxalOdGe
	 r5xZdzUfoFUAw==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4dmLjx0GVpz1xxC;
	Wed,  7 Jan 2026 09:27:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.188.34.184
Received: from localhost (i4laptop33.informatik.uni-erlangen.de [10.188.34.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18+iE5pwJG0JL2v/qz8hzsiECbHr4AnlqI=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4dmLjt17ZYz1xv0;
	Wed,  7 Jan 2026 09:26:58 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Lukas Gerlach <lukas.gerlach@cispa.de>
Cc: <pjw@kernel.org>,  <ast@kernel.org>,  <bjorn@kernel.org>,
  <bpf@vger.kernel.org>,  <daniel.weber@cispa.de>,  <daniel@iogearbox.net>,
  <jo.vanbulck@kuleuven.be>,  <linux-riscv@lists.infradead.org>,
  <luke.r.nels@gmail.com>,  <marton.bognar@kuleuven.be>,
  <michael.schwarz@cispa.de>,  <palmer@dabbelt.com>,  <xi.wang@gmail.com>
Subject: Re: [PATCH] riscv, bpf: add a speculation barrier for BPF_NOSPEC
In-Reply-To: <20260106084410.94496-1-lukas.gerlach@cispa.de> (Lukas Gerlach's
	message of "Tue, 6 Jan 2026 09:44:10 +0100")
References: <83981ed7-9d36-a47a-cf73-9010fceba5f1@kernel.org>
	<20260106084410.94496-1-lukas.gerlach@cispa.de>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 07 Jan 2026 09:26:57 +0100
Message-ID: <87y0m996b2.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Gerlach <lukas.gerlach@cispa.de> writes:

> I have not benchmarked fence.i in the eBPF context specifically, but
> from my other work on Spectre mitigations on RISC-V I can confirm that
> fence.i flushes the instruction cache on all cores I have tested, both
> in-order and out-of-order, so there is a performance impact.
>
> I agree that making this conditional similar to ARM64's proton-pack.c
> is the right approach. Getting this infrastructure in place is a good
> idea regardless, as the RISC-V hardware landscape is very diverse, and
> we will likely need conditional mitigation support for other Spectre
> defenses as well.

Thanks for the patch, I believe this approach makes sense.

For eBPF, you can make them conditional by implementing
bpf_jit_bypass_spec_v1/v4() similarly to how powerpc does it [1]. They
default to false for archs that do not implement them. Setting them will
not only avoid the performance bumb, but also speed up verification and
improve expressiveness (i.e., fewer programs are rejected for some edge
cases).

I am not familiar with RISC-V, but could the be any problem from fence.i
being an extension [2]? Or do all RISC-V CPUs supported by the kernel
implement this?

[1] https://lwn.net/ml/all/20250603211318.337474-1-luis.gerhorst@fau.de/
[2] https://docs.riscv.org/reference/isa/unpriv/zifencei.html

