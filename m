Return-Path: <bpf+bounces-30612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2268CF2EF
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 11:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781FD1C21036
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 09:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9EC8F45;
	Sun, 26 May 2024 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="y9UKEFBz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="y9UKEFBz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jOOvp69k"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6465B1A2C2D
	for <bpf@vger.kernel.org>; Sun, 26 May 2024 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716714279; cv=none; b=fOoyVEWRVgx051WO/6Oav88sEJVq0bu1jwWoowiyakWbuKcuBS0Pg087k9czYOY65MRsjg+XRAABMQULbfvlLw6dBRqfjlAl8AJZXRim4+VM6JpR+RWSuqOXzUbruoEmwsKhokglZsO8kbN3iireKih3cQ0+vx9pW55LsHN4gFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716714279; c=relaxed/simple;
	bh=pf5pPGfZUc//HvVMOukE8OM/sxwCpzY9FcZEaS/9N+o=;
	h=Date:From:To:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:CC:Subject:Content-Type; b=hYxjMEu0hE5THWiguh9d+s2plZD2cz3C1RU3kpIH6uAb8fWdWl58zaauP/dvgXcc/UNuWlFJr7ICcFEQkeLxTi2tA9I1Ns1xkpVODiuYPtUC9k8sVLWnTJYictMO7gUUVk/G7dldrxAhI/kBRWhzq0d/9KnkHPILCIW9CxdK8Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=y9UKEFBz; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=y9UKEFBz; dkim=fail (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jOOvp69k reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B15CDC151065
	for <bpf@vger.kernel.org>; Sun, 26 May 2024 02:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716714276; bh=pf5pPGfZUc//HvVMOukE8OM/sxwCpzY9FcZEaS/9N+o=;
	h=Date:From:To:References:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=y9UKEFBzcsP0yL5n0aOt45KxMDf/xUwbak8fDFQ29ukPIAa1s1xWKwtkt32kInsH0
	 RCysFAbfUMTTUzB4VKtmQKccNmmtyfSYv5/FdS/zU1QqNaI8WlgGChF0uvvewIo6IF
	 kGZBpMa6cs7ltgc50H6X8hUMf1Ma+cSRkof8g98c=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Sun May 26 02:04:36 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 98FE9C14CF13
	for <bpf@vger.kernel.org>; Sun, 26 May 2024 02:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716714276; bh=pf5pPGfZUc//HvVMOukE8OM/sxwCpzY9FcZEaS/9N+o=;
	h=Date:From:To:References:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=y9UKEFBzcsP0yL5n0aOt45KxMDf/xUwbak8fDFQ29ukPIAa1s1xWKwtkt32kInsH0
	 RCysFAbfUMTTUzB4VKtmQKccNmmtyfSYv5/FdS/zU1QqNaI8WlgGChF0uvvewIo6IF
	 kGZBpMa6cs7ltgc50H6X8hUMf1Ma+cSRkof8g98c=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id 02BD1C14F5FF;
	Sun, 26 May 2024 02:01:11 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.095
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
	header.d=infradead.org
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rnZEtmPOUjcF; Sun, 26 May 2024 02:01:05 -0700 (PDT)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id D4B9FC14F738;
	Sun, 26 May 2024 02:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=jOOvp69kNacTPkiddj+yvd+cxL
	dfGeIqMwDiN0dvutOKSFS1z189kgPht2F8SOrUJdBYDKBirBfN1z+M4944qPE5nYPpdswtu5dCmwE
	1qb/YoE7eMWR80Dwe2sdQ44xSBLRBCw0V7vdDMyjNLwuRyI8bpnmmEnuPJ/CLSN3cyU03KgK4wCpf
	BHJZmI/2rYvG2kiw22O9XzIR/D2WUp3Wka34dNuSgDLi4U1W6YJs8FHnfvpkiH6ESNYRFYj3c9f0t
	QS+ub+FdCG3GgS4A2fAZfXQ5SKnytrjCuW5IiBUlY+xBWrJQiRxqAWHxSJNUz/JhslOiuFnZD8SVO
	75Vnqw+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux))
	id 1sB9kN-0000000COKk-0okJ;
	Sun, 26 May 2024 09:00:55 +0000
Date: Sun, 26 May 2024 02:00:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Message-ID: <ZlL6R4k2zmnosfkc@infradead.org>
References: <20240517153445.3914-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240517153445.3914-1-dthaler1968@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: WB2PUCTIEXAF6IG3U3V2ZCYIUNMYHJJY
X-Message-ID-Hash: WB2PUCTIEXAF6IG3U3V2ZCYIUNMYHJJY
X-MailFrom: 
 BATV+a1c11ae06ea55677c231+7581+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
 Dave Thaler <dthaler1968@googlemail.com>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_bpf=2C_docs=3A_Move_sentence_?=
 =?utf-8?q?about_returning_R0_to_abi=2Erst?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/mObxSK4heUY-hU8nrJ1LlovKtEY>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

TG9va3MgZ29vZDoNCg0KUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRl
Pg0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAtLSBicGZAaWV0Zi5vcmcKVG8gdW5zdWJzY3JpYmUg
c2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVAaWV0Zi5vcmcK

