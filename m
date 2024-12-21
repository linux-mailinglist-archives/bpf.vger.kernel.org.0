Return-Path: <bpf+bounces-47510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EECE49F9E07
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 04:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A1516AC9A
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 03:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8147DA6A;
	Sat, 21 Dec 2024 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="nakrwi/D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C3953365
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734750490; cv=none; b=HKr1T3boRuakvySGI8YLGlHJXALcKviTTwQXpLDKaTdM4jUUxm5yHlInomiokWNEL/NKoengMtXg2VuX1lxzTl3VtK0wwZpa1HY62cMdsqrzitbGd1N0bce618YF93vx/HJtNEHS2AX2DtXquMrtBgmNEPZahx37EJkCN0A4wK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734750490; c=relaxed/simple;
	bh=OSTi9mdvhq9nlkO9fKmqsWHY3hY3WOW5EBEnkRCKFHA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qinIT15CYsc2g8YKnRTaOpDIVs146IdkLwJkmdd5udnrPw4wMJYdf6AF/wtbrPNWH6/8o1KsFtHvJti9ftrGqTSeAFfUYI8gVu5jMMIBi0TIhvVuFYAsTOjVGywKq+cRz/3AWmeUVzJtW6ih6Wc1QjU2WglYRLIffaUtCE2ywpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=nakrwi/D; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734750486; x=1735009686;
	bh=OSTi9mdvhq9nlkO9fKmqsWHY3hY3WOW5EBEnkRCKFHA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=nakrwi/D0UppAFRckABidaGgEvD2BjicwzmFkpseTGr3pQH74bBHqRfneGYoloczt
	 ByJeNDJhZ/JFuS7PNn9vbvwnyeLPzsizOSbNY6wFmi04b/v6IOXJjbmjttbG86vZVq
	 /uoqJosCFCqhu4jsNouKCQBSNWKUaLvKdYjB1qBrYIRdL06rRrK09i7qU8wzqdrz5x
	 8AYfAUS02EQOBsRX0s6AHQzHTv/F70Hi3NbFS/ghHjhLlIAZHcpxsS2gJhpU//qZ5M
	 bCoeqRO81ZWKYTsX4bXyuFq/Y3+DPC01OnPLpk8RxQYbX6icVH/IGwKUXzBGneMKkv
	 we2v1Rn+FzwCw==
Date: Sat, 21 Dec 2024 03:08:03 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves] dwarves: set cu->obstack chunk size to 128Kb
Message-ID: <m49nn97qH9FUVriXgfTK3r-km8ARVr20pLhsjXgORDd_SfXUqSxcbGgSxKQqXrJlLgF3ZNN1Cs3I7g21bugUwZgEuk6a0yJa1KB0BZyVp-w=@pm.me>
In-Reply-To: <20241221030445.33907-1-ihor.solodrai@pm.me>
References: <20241221030445.33907-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: c2c1448dea1cb69f881c244d41ce775b59a1e390
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch was supposed to be a part of [1], but I missed it when
preparing a patchset. However it is independent of the other changes
there, so I'm sending it separately.

[1] https://lore.kernel.org/dwarves/20241221012245.243845-9-ihor.solodrai@p=
m.me/

