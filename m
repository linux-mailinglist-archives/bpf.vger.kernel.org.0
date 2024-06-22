Return-Path: <bpf+bounces-32806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3589133E7
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 14:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581B21F247AF
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 12:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6534416D4F6;
	Sat, 22 Jun 2024 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="G3o6ibSY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8614016C44C;
	Sat, 22 Jun 2024 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719058820; cv=none; b=rCuxMv7lAs9OC0wqftImlsdWhvklZUMO0dBf5C8xuV5vPLZ5E9V9yfcTa5CLowgfs2PZTcifx37T/88MaFsuF9RqZRTKYWEYp9ytD+ex/35jQUL5a+9b7QNpyZH0HhssmGw/XISwcxZ1rO9UyYQiVVY8Rp02DKYe1ct1AzfR9sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719058820; c=relaxed/simple;
	bh=L3zFua0iGMeJV0ZUhBAiZRWO0Sn/pc+WC2zvhsyqG0k=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=Ai21nTJTwXkOWBSNASVWW8a2uj2So3+qSgU3j4QjCfT8N1RBHW4AR/99hK8fYHsi/lORtDsXGvQvFyN/lxM2olBRMymul5SCgjD7XZr1rx1wC2nNZBNST/IMCfCzthfXzkhWQXHjiEwqWZ4k7aoqBd0OdaYWnrqWgDACleJkE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=G3o6ibSY; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1719058810; x=1719318010;
	bh=L3zFua0iGMeJV0ZUhBAiZRWO0Sn/pc+WC2zvhsyqG0k=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=G3o6ibSYqy6yR9jOvo78uMsRlzUhGCZGL5ZRVMt1P3j6Mk65O4zQxAJkt/LNT3gdi
	 LfiXOwPjunEKKGgtRFrxrEOIKhVL+FEtrrC/0VdCe2NwAE9/ogAZFuQManQ5t+S8mn
	 sS5wP7CEpbz5Lk4JhYfX53lf6tDBXdrlnphbQ+6+Af67LPUBuL0Vtma3kggNy/W5gY
	 K5hObwqM1s7s3gdo5VYA7pQf/yz0LTwWjV7WjmdJaLMm+WUtWsQv6MH9rXXIf6eW3j
	 mTOHMNBHBfo70CXE3zY+A+jGYxiDfGms0EyyB7wItX31SjPnSigMdp+ArSf4Fnv1ym
	 MGr6p1kS4XzXw==
Date: Sat, 22 Jun 2024 12:20:05 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Zac Ecob <zacecob@protonmail.com>
Subject: Returning negative values repeatedly from a SOCK_FILTER ebpf prog stalls kernel thread
Message-ID: <CJrradVmkT-HM6goIYbivHNdWglG0h11_0Ky2ObV_ZCOunJaksIj9alG1UTHCkSDX_Jhm6uB5P5vS8C75QfrjWrqeHisUIDn2023xfv7jp0=@protonmail.com>
Feedback-ID: 29112261:user:proton
X-Pm-Message-ID: 4921c3cd716c290ff768da4f1d53ad61eb2579da
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Problem is title.=20

To trigger, I attached an EBPF prof that just returned -1, and send ~1000 p=
ackets through it.

After doing some investigation, the `sk_wmem_alloc` member of `struct sk` s=
eems to only be increasing, presumably missing some refcnt_dec somewhere.=
=20

At a certain point, in `sock_alloc_send_pskb`, we fail the check:=20

`
if (sk_wmem_alloc_get(sk) < READ_ONCE(sk->sk_sndbuf))
`=20

Upon which we enter `sock_wait_for_wmem` and schedule a massive timeout (at=
 least that's what happened in my tests).

Not sure where the missing refcnt subs are, must admit unfamiliarity with t=
he network code.

Please let me know if I need to add anything.=20

Thanks

