Return-Path: <bpf+bounces-32501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EBC90E4B2
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 09:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20327282CCF
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 07:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE048763F1;
	Wed, 19 Jun 2024 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="YpRRUW2z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8163B73455
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782742; cv=none; b=A44vdRrUQ3lVmhBaIhY7lHv01YaRsNqbFKiblaQiOElIKCon5mKeICOqaIv0WqPndalWguunPFvzDTwXYXc3IL9Vgj9bVcqMZCDGG1Zd4Jsd+XiQVSUwd6f3ZVFCb5opGhhBbbgEIT3o9PRPEjNDzeW5WENibom0Oot+OIKVm4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782742; c=relaxed/simple;
	bh=bKHf6A0tp6Uu0MdcZPPDyGq0CpFkPpgOI82vxB2UzDg=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Us6AV7rjWAh0+wO3LDNKsN9gpoL+8W4LudkF+wgRaq5EaKONfitwH6ZHkCrl729+eeiTN2T0mJDdRBFeNvZ0R5u5452geKUmQHGJ1GRmaiPbSqQE27/1bhQmuvvrGB7fam543dXsm3RwhcsZkKt/UCLMAFQzIqPdPsRNP9Y2FCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=YpRRUW2z; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1718782737; x=1719041937;
	bh=bKHf6A0tp6Uu0MdcZPPDyGq0CpFkPpgOI82vxB2UzDg=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YpRRUW2zMyW8mkc0sdVumK/UelEA5ehWRDhxCVwDPs986GkxnsoA0wjgVtshEvnMh
	 Mx17R44W/MeLTdJcVd9fTqfxsi91fqLfy2DC2180qbTjgiud8Imlh4O7kwfkU7xuWD
	 c55fHPHUzxyABQEpXQhnh79WJaSVB4mQvXOckyvEXuP+vvZy27L+L9Pmn2qqM1q0eE
	 RGWikXOVh44ITjUvdZ0FnBHILKmWaNRUgenNC7WZrjUhqOsxY4ei2ksqQ+kMohLhDa
	 zz6wq99SPBE2gOn5ZLm9p2kW+bTIzIZjwdQawBYQTWslohHsoY08/Jb6o2IqHCcTZo
	 ZWTPW1AfvZ0jw==
Date: Wed, 19 Jun 2024 07:38:52 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: Zac Ecob <zacecob@protonmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix the corner case where may_goto is a 1st insn.
Message-ID: <AoWNnDQxM1Ckwtroep85ZBr0qZ3bxEBjr4uvmJae7NPMVOh6EoGAEUrS8XfhDsF9Aqa0bG7_CnTD1yToOr-mKbipj6rJ37XcSDT_UNEgqE8=@protonmail.com>
In-Reply-To: <20240618184219.20151-1-alexei.starovoitov@gmail.com>
References: <20240618184219.20151-1-alexei.starovoitov@gmail.com>
Feedback-ID: 29112261:user:proton
X-Pm-Message-ID: 0e09b9aec26bf89ed723946c8291eccca37eac5b
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_kKwPGBH5rj6lHf4aUfyg0i9ogG31B8oZXgHAFcg9YY"

This is a multi-part message in MIME format.

--b1_kKwPGBH5rj6lHf4aUfyg0i9ogG31B8oZXgHAFcg9YY
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Have applied the changes - moved to 6.10-rc4.
Prevents the repro I gave earlier from stalling, however I think it has int=
roduced some new bugs, in part involved with ldimm64.

Attached is a new repro that stalls.
Additionally, when minimising it to what it is, some of the intermediate pr=
ograms would crash, complaining about 'unknown opcode 0' - relating to ldim=
m64.


--b1_kKwPGBH5rj6lHf4aUfyg0i9ogG31B8oZXgHAFcg9YY
Content-Type: application/x-xz; name=repro.tar.xz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=repro.tar.xz

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

--b1_kKwPGBH5rj6lHf4aUfyg0i9ogG31B8oZXgHAFcg9YY--


