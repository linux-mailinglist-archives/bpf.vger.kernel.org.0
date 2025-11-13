Return-Path: <bpf+bounces-74378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB68C57432
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B173F354291
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E471234889A;
	Thu, 13 Nov 2025 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="f0UAbtfS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3406E33F8AD
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034373; cv=none; b=d00rjusQQAabMGov/Iap4kNgMSmPUOCqJf1iKhhBirgz/aXHVKFl6Cp9OWNjSAij3epFxs4toKGYtFe+6w2C0C/80sF7QL8LAp0zLvTC994oymBGlITyP/LjIa2V7JQDbkO9weS7jgffH22niOYCQ6KrG4RBNzZBhLYGBB2GcuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034373; c=relaxed/simple;
	bh=NzWR2vTaR9mgjHFEuT9kPxhCPg1E4stbtor0uZGgP2E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AD246Vky2YJ8xHL53tkt4w2yjRo4ueqf6satqfVRve1TzICAOiz2OKg5wJewgPrtwVyweBDkxuyHDcFdMdpUz4k35DxVu1nSNFi1pUqagUCZWPIqRR7F7zTaF6CrgNfZxduS15IiUVknUNIWQW/+CQHj0enCgvfgtNDvGr2LXwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=pass smtp.mailfrom=xfel.eu; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=f0UAbtfS; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfel.eu
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 84CED13F654
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 12:46:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 84CED13F654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1763034361; bh=NzWR2vTaR9mgjHFEuT9kPxhCPg1E4stbtor0uZGgP2E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=f0UAbtfSuaf1kzrURYG9VQQrxA+yeU0LIWC09skcfLIw5K8dmXZTrRMjYTic0n50a
	 0l9YNFNQs6WbwLSqIP09jvKiBQd5XX6Dh6eIV2CDdnRjE+/WKNn+tUTr1CKzg1kNc1
	 FlODUBMJa7EUV/NarluResm1ao49JcQHmWEB1bdc=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 78231120043;
	Thu, 13 Nov 2025 12:46:01 +0100 (CET)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [194.95.233.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 6C77A16003F;
	Thu, 13 Nov 2025 12:46:01 +0100 (CET)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [131.169.56.69])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id CA031320093;
	Thu, 13 Nov 2025 12:46:00 +0100 (CET)
Received: from z-mbx-6.desy.de (z-mbx-6.desy.de [131.169.55.144])
	by smtp-intra-3.desy.de (Postfix) with ESMTP id B25251A0048;
	Thu, 13 Nov 2025 12:46:00 +0100 (CET)
Date: Thu, 13 Nov 2025 12:46:00 +0100 (CET)
From: "Teichmann, Martin" <martin.teichmann@xfel.eu>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, ast <ast@kernel.org>, andrii <andrii@kernel.org>
Message-ID: <745490756.25826958.1763034360662.JavaMail.zimbra@xfel.eu>
In-Reply-To: <4952b7bf8a0b50352b31bee7ddf89e7809101af6.camel@gmail.com>
References: <998304ddd050ef81ce6281ebb88130e836c07fc3.camel@gmail.com> <20251110151844.3630052-2-martin.teichmann@xfel.eu> <4952b7bf8a0b50352b31bee7ddf89e7809101af6.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: properly verify tail call behavior
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 10.1.10_GA_4785 (ZimbraWebClient - FF134 (Linux)/10.1.10_GA_4785)
Thread-Topic: properly verify tail call behavior
Thread-Index: Komk6PpYxid9d2tpJEWTjgasObzC5A==

Hi Eduard, Hi List,

sorry for the late response.

> This is a clever hack and I like it, but let's not do that.
> It is going to be a footgun if e.g. someone would use
> bpf_insn_successors() to build intra-procedural CFG.

I appreciate the effort you've put into your solution. However, I feel that=
 we might be leaning towards a YAGNI (You Ain't Gonna Need It) situation he=
re. Sure, if somebody wants to do something like your CFG, my "hack" might =
pose problems. But what if not? In that case, your proposed solution just l=
eads to additional complexity and unused code.

My implementation is quite concise at just three lines, making it straightf=
orward to replace if necessary. It maintains clarity by using BPF_FUNC_tail=
_call markers, which can help anyone reviewing the code quickly identify it=
s purpose. If someone is not focused on tail calls, they can easily bypass =
that section, ensuring minimal distractions.

Additionally, I've discovered that the bug in the stack liveness code is ac=
tually independent of the bug I=E2=80=99m addressing. My patch doesn=E2=80=
=99t introduce this issue, so it doesn=E2=80=99t need to resolve it.

In line with the tradition of the Linux kernel of keeping patches small, I =
can extract my three lines and the corresponding test, allowing us to proce=
ed with my patch as a bug fix. You can then apply your adjustments for the =
stack liveness issue in your preferred manner.

I hope that helps.

Greetings

Martin

