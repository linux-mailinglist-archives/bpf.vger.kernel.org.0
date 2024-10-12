Return-Path: <bpf+bounces-41810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E62399B0C7
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 06:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532B81F2178B
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 04:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C450C12CD88;
	Sat, 12 Oct 2024 04:14:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCA612C478;
	Sat, 12 Oct 2024 04:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728706477; cv=none; b=tnBtMpy2PuzePN5XCvM37lj3VFS3W43LNAdjbcMuynGJey6ApT9zXCC+T2nIJBhpq1DeXbUU1WQexl9rrdcJFjo+4ETNJzAF5Ug/69AzwsncOhaWzb4GtA1SGjrBCvAlX2boKtUt1cEW0ggBYPvj/7QazBDMNK1eiuso4wfrNDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728706477; c=relaxed/simple;
	bh=N5Yj08ErVUesU/9WbLWhmyg953wIC+DgjnQqkh34xIg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=p1ibzIzy6DvNiI+kaqztnRLMIHx5XK1p1WJ+z7RtRkgxzpCXrF285ARxFrlGO3jwYWMrs67q7iSvs0Lvz6EQqIZOqL1OwAnRahKlIK+lcKXYbkpfNQYeT5lbe3YdX/Qru0L+JwizxVHkwo5fRC9u2AAbllP7C+ehQ0MqhVGRi0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: ezulian@redhat.com
Cc:
 acme@redhat.com,andrii@kernel.org,ast@kernel.org,bpf@vger.kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,haoluo@google.com,john.fastabend@gmail.com,jolsa@kernel.org,kpsingh@kernel.org,linux-kernel@vger.kernel.org,martin.lau@linux.dev,sdf@fomichev.me,song@kernel.org,vmalik@redhat.com,williams@redhat.com,yonghong.song@linux.dev,
 =?utf-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: Re: [PATCH] tools/resolve_btfids: Fix 'variable' may be used
 uninitialized warnings
In-Reply-To: <20241011200005.1422103-1-ezulian@redhat.com>
Organization: Gentoo
Date: Sat, 12 Oct 2024 05:14:29 +0100
Message-ID: <87frp2yn2y.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The parse-options change was sent before as
https://lore.kernel.org/all/20240731085217.94928-1-michael.weiss@aisec.fraunhofer.de/
but seems to have fallen through the cracks.


