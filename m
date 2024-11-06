Return-Path: <bpf+bounces-44184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98839BFA12
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 00:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53931C20E57
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 23:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CCC20D503;
	Wed,  6 Nov 2024 23:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="i2s6fU77"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221AA20D4E7
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935695; cv=none; b=RFKTWV6QbVaKmt2IHp+WQzHCY14lurAbLFELjvI5z/iseRu9lhoQsZKfotVPCXrAYwlUOuh4OtPW2MR4gfugE+O+NXdaTI56w9MUeXorpTq9s/QOZ3O4UtQ3JPTRWAXW7z2639g1VVPnDlp5zNy6fazznkZL08G3inVaU1bmtfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935695; c=relaxed/simple;
	bh=lSi+X1grzdL+pY4HAvVpMQDCFl+nwfdx0T9AWgUekAQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWt3y0IlaAJQWQNNm7wFBx86JOxzM99YRXJOOpq8um2AtqyPdxnZ9us/FUUiO6Cexyreh21C/yo6wXoA7bv1wxX2MCfr6q+cv7GFLqETNBIPLXNj9K6MNis+B7/GpluLJs9+adFO3xKwP2YTroRRDVXj1BOpoT+44omY7ktby40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=i2s6fU77; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730935691; x=1731194891;
	bh=hRyHNExL46XAxe3OutWLwKfDQAr0NwB3lPOW8ULdW74=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=i2s6fU77RKmuoToq9CMwG3/wYtA44c3H0b7NemKwPaRMSo1cSDQUozejM4sWPZjvo
	 fJ9aFLQUyRewEXjMrrZEzgXsAK0mWuxP2hJGrAhdfP3gSmNdUz5S7MaLH2GWQoNDXy
	 2lVUjY7hnOSiFwds3p2V6L+Q7JKoLWwJdMAhEWaUbjOmoJ85xwxd19lDGIMxbSJKNb
	 vTu6Oaw2smCaVwDoZAfHVPg7qASXrcoaNz8uCUnUpU6PXFIRTVc48vsDP4vFZLHCDU
	 DWZaB+Dh3bjDcJgiyxxPpRxFXKK2CK+8EfeDyGRFh34CNdbnobyKWuaOKnPcabiQpq
	 99MWwmq/8QYIA==
Date: Wed, 06 Nov 2024 23:28:09 +0000
To: acme@kernel.org, Alan Maguire <alan.maguire@oracle.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>, andrii@kernel.org, eddyz87@gmail.com
Subject: Re: [PATCH v3 dwarves 4/5] btf_encoder: store a list of elf_function per function name
Message-ID: <L5Bv7su_qwLNpU42pyqsvF4rfjyR8BjHgb0u2aVPUdf4Cy1lkVpWzHyLvqdca1E4d6TLot2HQK6n-YLaE5utKSjap2aQB6LkWtNhgAFZtPs=@pm.me>
In-Reply-To: <qZHen28Acr_pzq0oImrTEVB6xsUgeVkqBmQ43dpfluDRfqWYRfCQp9jTj1KCLtXqwXSQmSFObW4HNqKkWaPCsz2HeUKzzkfMtZ8MQJUkfgo=@pm.me>
References: <20241016001025.857970-1-ihor.solodrai@pm.me> <20241016001025.857970-5-ihor.solodrai@pm.me> <8678ce40-3ce2-4ece-985b-a40427386d57@oracle.com> <qZHen28Acr_pzq0oImrTEVB6xsUgeVkqBmQ43dpfluDRfqWYRfCQp9jTj1KCLtXqwXSQmSFObW4HNqKkWaPCsz2HeUKzzkfMtZ8MQJUkfgo=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 81440a7a1e170f40331e594675fde24588215869
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, October 30th, 2024 at 5:14 PM, Ihor Solodrai <ihor.solodrai@p=
m.me> wrote:

>=20
> Hi Alan.
>=20
> Finally got time to try your changes. Apologies for delay, was busy
> with other things.
>=20
> TL;DR Here is my patchset rebased on top of your commits:
> * https://github.com/theihor/dwarves/pull/7
>=20
> Please take a look, and let's sync on how do we plan to merge it
> in. Your commits seem to have debug code in them, so maybe you'd want
> to submit a clean version first.

Alan, Arnaldo,

Did you get a chance to review the changes rebased on Alan's work?

I think the state of commits in the branch is good enough as is, so
I am inclined to send them as v4 of the patchset, assuming Alan
doesn't mind me including his patches.

Thanks.

> > [...]
>=20
> 

