Return-Path: <bpf+bounces-32216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B62909679
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 09:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A991F22144
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 07:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0D9171CD;
	Sat, 15 Jun 2024 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="eOitEjQi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C24C79F0
	for <bpf@vger.kernel.org>; Sat, 15 Jun 2024 07:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718435356; cv=none; b=PGBS5y8pIldHzJkOkFciUp9EztiVgS5R44MRJ1uwwtuKUHKYCbwCvZDm/2dbcj/U1MlbzIhs9wSOpL3XKPcN1NWDIUOQdp8o0kRGQg66VeLQEimIdnUickNeQbwLhhwLq9Lyezb4M3odbvjg0N/i7J4HChfmDWH0forLP1PhyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718435356; c=relaxed/simple;
	bh=Ofcf4d7Zhi/iiPgMDODmSMEk8qb60irgqQ7eJMSBHS0=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLjEi0jIsJajRcsX5kefDHVdkIxgMFSZAFsx5MT1yO0kEC3/GoNdDJi4TytAZ0WFk0zfTv/RL3ZG/3BayvzCoflqXsHp6VgE6xrvB80Rulgvmqbd9O7YlMhXLZQy/iwokhLU8d3QZJ7He9GUlJkW6XRG8MOhjinMEnDacZ7J2Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=eOitEjQi; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1718435346; x=1718694546;
	bh=Ofcf4d7Zhi/iiPgMDODmSMEk8qb60irgqQ7eJMSBHS0=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eOitEjQipJyV9R+fnkHekoGLFIsn+2Aw5XC/q0IhufOZCTy7uUtTlZGn0AGezoOF1
	 Ge2FJdCK+OxysLSDUGCoX9JWMSePlY3v/NQpSrosYErzudWbiHTDlRJY7+FjmGRdPF
	 5hhMBnote9EHxmZ6wAfwzGoWg7Akcch8N5grvorMM6etEqBjaP0TbOI5T8KRa5F7hR
	 GLvLMn0TWRxE3QvEoW5Ui6X+jPRL/iwV0aao0R+2P8xJyJMK5jTpXC8LBlDc/QArh/
	 yVAjJSzNscgUMUAqKyt4zkD0VlxFnU7rmmHpim0P6qqfnsNpcenY5+pBfZrxBcNIwX
	 rl4yu9XsyafXg==
Date: Sat, 15 Jun 2024 07:09:02 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: Zac Ecob <zacecob@protonmail.com>
Subject: Re: rcu_preempt detected stalls related to ebpf
Message-ID: <-P_rTwSVX1lEiqRGA2drBZcQM24fbnVw4OBcVUrZ4bwPHBQ9QhFHJeWrHmImV3UxR6YqbRdkKXgVHHfNck-54u8Q0QSK6Qi4EWzxr9PVPSE=@protonmail.com>
In-Reply-To: <CAADnVQLPU0Shz7dWV4bn2BgtGdxN3uFHPeobGBA72tpg5Xoykw@mail.gmail.com>
References: <eHjqF1DbM2cbq_nXVoanIt042aeSlLwf3xBQ-LTesttfagbXyJfsxMa1zyHU6ngtUYRD4-nfM3sAmyRbPiSN7o4_sWtRy8zodlI7K2UmyTg=@protonmail.com> <CAADnVQLPU0Shz7dWV4bn2BgtGdxN3uFHPeobGBA72tpg5Xoykw@mail.gmail.com>
Feedback-ID: 29112261:user:proton
X-Pm-Message-ID: c521cc41428f507e4db84f1e88a0da1b0a502e9c
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> I reduced the reproducer to the following:

Thank you for minimising the repro - I didn't think to do it myself. Apolog=
ies.

> The verifier doesn't process the (s8) instruction correctly.

I took a further look out of curiosity and managed to properly crash the ke=
rnel. I think it might have security implications?=20
I haven't attached a repro for this because of such (though I could perhaps=
 email it directly?).=20

Not sure how best to precede?

Thanks


