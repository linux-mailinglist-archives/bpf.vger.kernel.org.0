Return-Path: <bpf+bounces-38953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5846296CDF1
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 06:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4D728749A
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 04:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3632B1547C4;
	Thu,  5 Sep 2024 04:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basantfashion.com header.i=@basantfashion.com header.b="lVJcpAW2"
X-Original-To: bpf@vger.kernel.org
Received: from mod.modforum.org (mod.modforum.org [192.254.136.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80313DDAA
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 04:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.136.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725510207; cv=none; b=dudiIo7/gxd2iVMTuzxjYjqx10S8ZXhSYK8vhp5cgfnudMa3gAFf+u5sRJ8oHYcZzsBOShUTzagrp9Te7bxksD7OpxG42VZZPfeASbreSL4+O6Bc32p6paOLsGHIhFOUqMUbDa+hTMNAd74ZyoF9JhpGgRB9Xpn/bqoiyKfmnuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725510207; c=relaxed/simple;
	bh=G4BItOc8k/hB4suOfWWwTOg/U0FTlHwyCNnKCLPge2w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m58tn6nmbzBrk2Kt+VgREiJH+Uhq8+4NqN6CT0qYyqA3VCB1Q9woOlOHym9glr9BqB3hqnRz8RYK833OVYJBcQPbJ/Hfo6jhNRn/Jom+RKFasY6VtXGkda4/0tum94R3Q13U/rA/dGFxBf/wkKOOGqm+IteiaTEQl9KnlUuln7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=basantfashion.com; spf=pass smtp.mailfrom=basantfashion.com; dkim=pass (2048-bit key) header.d=basantfashion.com header.i=@basantfashion.com header.b=lVJcpAW2; arc=none smtp.client-ip=192.254.136.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=basantfashion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=basantfashion.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=basantfashion.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G4BItOc8k/hB4suOfWWwTOg/U0FTlHwyCNnKCLPge2w=; b=lVJcpAW2IjM3BFQG45QluFyqc+
	c/i+9r28cUApLYonn461Gn4n3Ax5qqeO7rmrBFe6Rx3VqAH1WE358vRgNAsy2XPmgRh5tfl2ZQuk1
	2NCUX3K3HxOnTGU3W/C+8zve0NIV7ThBQXXXLOYSStBg04WcDM3f2q+w1oR9s9ZAiUB+KQQFmMcit
	wgkmGrTACv+xjcWih+eM7MCNGxWeJTL8SXVaR6G8hjAsiOXzY85dHmooESB2G1jjvYLm2JT/wf0qg
	rvgn2bDjMlA3pqW3E7J9GBl65d5BnCaAlDEkHF31U9fmhSlcVvvDTiFrGjJjXySNokn7nV36YDwua
	bdl4SznQ==;
Received: from [162.244.210.121] (port=53367)
	by mod.modforum.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <kuljeet@basantfashion.com>)
	id 1sm40p-0002Xv-02
	for bpf@vger.kernel.org; Wed, 04 Sep 2024 23:22:27 -0500
Reply-To: procurement@mercuira.com
From: MERCURIA  <kuljeet@basantfashion.com>
To: bpf@vger.kernel.org
Subject: Request for Quote and Meeting Availability
Date: 4 Sep 2024 21:23:23 -0700
Message-ID: <20240904212323.44C25D61DFC73539@basantfashion.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mod.modforum.org
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - basantfashion.com
X-Get-Message-Sender-Via: mod.modforum.org: authenticated_id: kuljeet@basantfashion.com
X-Authenticated-Sender: mod.modforum.org: kuljeet@basantfashion.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Greetings,

I hope you are doing great.

We have reviewed your products on your website, and several items=20
have caught our interest. We would like to request a quote the=20
following

Can you ship to the United States?

What are your best prices?

What support do you provide?

We are also interested in your services for this project.

Could you let us know your availability for a virtual meeting on=20
Zoom to discuss this project further?

Please advise us on these matters so that we can prepare a=20
meeting notice for our company executives to effectively engage=20
with you.

Thank you for your attention to this inquiry. We look forward to=20
your prompt response.

Best regards,

Nina Petrova
Procurement Manager
Email: procurement@mercuira.com
12 Marina View, Asia Square Tower 2, #26-01, Singapore, 018961
Phone: +65 641 1080

