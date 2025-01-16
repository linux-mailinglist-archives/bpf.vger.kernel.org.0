Return-Path: <bpf+bounces-49119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B39A7A14437
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 22:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3475E3A6F5E
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A0722CBF9;
	Thu, 16 Jan 2025 21:50:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5BA14901B
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064200; cv=none; b=GXmey+Ibhg+/bijrDJew8STnWdshUtzCGByJh8bTBF++cJ0ahEmbfFtvHndEjSw9eGxhmwR8Sw+JCyEm8M4K9lTE46uFjOKI9Vu1rGAu3pWZlrPdydB2c1twKwFbERnIh+5phcvC+DPoTTXckxL5Oo6OzRvYxAI99eVa47uyqlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064200; c=relaxed/simple;
	bh=9zPomwiYdM5Xs/5vOFJuXz4cIbV2OP9+msAzss7sicM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=npavEbN2OV67Cg5a4ZyHX9AWGaE38ugKLJaCFxEJ6A+zY7drufz9LwejvBQMmqYhCFicxwYRxrffA4GIFZWctlMmpeQ6WQS7T2IVGnFIIizlmap/vC0DND2mmcPf+RyGkKyjDzCKe3YReyKYN68E+Pj7BOrY0nyeFQeLDEoIBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: ihor.solodrai@pm.me
Cc: andrii@kernel.org,ast@kernel.org,bpf@vger.kernel.org,chantra@meta.com,cupertino.miranda@oracle.com,david.faust@oracle.com,eddyz87@gmail.com,gcc@gcc.gnu.org,jose.marchesi@oracle.com,mykolal@fb.com,pinskia@gmail.com,yonghong.song@linux.dev
Subject: Re: Announcement: GCC BPF is now being tested on BPF CI
In-Reply-To: <mMhcrHuvf5fyjPwMa19kug9DHQH9yYcCJXKfaFMXhfQlKIuColex7zg7G6qpPqlfF74-IqzkhpZSlzsgvgikc-u6oQp27dNzFQAAatRaEuU
Organization: Gentoo
User-Agent: mu4e 1.12.7; emacs 31.0.50
Date: Thu, 16 Jan 2025 21:49:53 +0000
Message-ID: <871px2mnsu.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wonderful news! Massive thanks for working on this.

> but if there are specific people who should be notified
> please let me know.

Please feel free to include me on that list too.

