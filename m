Return-Path: <bpf+bounces-40022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E38897AD0F
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 10:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B7B1C20A58
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA25155A4E;
	Tue, 17 Sep 2024 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4y7RpSZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682481591EA
	for <bpf@vger.kernel.org>; Tue, 17 Sep 2024 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563027; cv=none; b=kmrOGPWkSO4rAHwLZDT54QhXQbdIiGsQFnt49/beznGT3MLxYm2wqYsKREn3KWfGiu1AnLk/Oi2GGuhfl6Pq1wRn7eRzTwKGmqSU5yuo6Uy/uiBtE8Ke+PFzJsCry1I//UNqDkqhXoFuoFWwIhX0oZwiwN4FLn4Ts5EFA5C5J/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563027; c=relaxed/simple;
	bh=3mebPlY0ATSLOef79a6lFjPu2La1VAGcp3qdSKGZs5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cKw3tZ+DhBf7LUmAl70OhkJIx/8cJZH3bF0mjT3lNZsDFqXdUpmzqEqvEdGE0ndw0BTGVIE+oma1exD3a3wEamsXBxa21djL08efJfVK/GBlPHAxMMN6Liu1LXt4SepNiTNk8DbCTxR3tcw9iQj7tLoOqmSlWRaGyaXq46DWOlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4y7RpSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DB7C4CEC5;
	Tue, 17 Sep 2024 08:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563027;
	bh=3mebPlY0ATSLOef79a6lFjPu2La1VAGcp3qdSKGZs5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=m4y7RpSZ1ghz4rDolUhIdgd7EBwvvRzoROG+fUB3LEwGKX8EJq1wFdqopR+urwbIa
	 Qo1+SFdk8TblKuVnL1BmvgjucZl4wKaq6KGysYRkBwu4XRZmPWQOsLPKhMJzVOZSBP
	 QQJL+MbabWejCR72Ce2zDdLN/Kd2YeqxcWbe7m053MBnAGJw2Ef8n85GuDNFYQ2dy4
	 qwRk4Ez10sCNKeBdjYdsZTNphMZgNRsrkizH0q9Y0EULTwINBGpO+9tegpFRaLq4HZ
	 syRb/HFnFamlOsJbXOdKgKKoQ+UFhn+D4ZsBxb28Og5Iy8sqbZHFz1ojLmET3B/R2Y
	 igdiSwTrXb8yw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, mykolal@fb.com
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: remove
 test_skb_cgroup_id.sh from TEST_PROGS
In-Reply-To: <20240916195919.1872371-1-ihor.solodrai@pm.me>
References: <20240916195919.1872371-1-ihor.solodrai@pm.me>
Date: Tue, 17 Sep 2024 10:50:23 +0200
Message-ID: <875xqueka8.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ihor Solodrai <ihor.solodrai@pm.me> writes:

> test_skb_cgroup_id.sh was deleted in
> https://git.kernel.org/bpf/bpf-next/c/f957c230e173
>
> It has to be removed from TEST_PROGS variable in
> tools/testing/selftests/bpf/Makefile, otherwise install target fails.
>
> Link:
> https://lore.kernel.org/bpf/Q3BN2kW9Kgy6LkrDOwnyY4Pv7_YF8fInLCd2_QA3LimKY=
M3wD64kRdnwp7blwG2dI_s7UGnfUae-4_dOmuTrxpYCi32G_KTzB3PfmxIerH8=3D@pm.me/
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

