Return-Path: <bpf+bounces-35170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D68C93811B
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 14:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0511C215C6
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 12:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FBD82D89;
	Sat, 20 Jul 2024 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWsIWRTo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80EF2F5A
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721476844; cv=none; b=rj1QO14tyfMi+R4YiGR3Xkfue0yMvfHNIutSKAs9NKtNqqNm5HRbEBqw/V6ro2lrilgOUbcIW+XXYKpQnpo5B+yUrKyvl8NemZyO3XOoCTWVv/0gaqF155ItrbCyO/Pq2vxJB+mWWwAqsLvhYn/mGDx3cBa/3wv60tnxNC3l1YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721476844; c=relaxed/simple;
	bh=aan1c0yokMXxkS8azH6r9LCPgb5DdnnGAd3SJsQ0YlU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=D+6saSmaVKMTwRZRkPCwxxra4iYTNTcDwas74YTPoQpXGRUa+UPIa1eeFZzXy5x2fHzUcCBjJsoROJnbauCfy646I+Xo9b2zjZrAoIba5OTUA9hl1sjh6legv+q79CWCxJYSdK9M4p1hm4yk0km4CfGaNXGGBzyjZ/vjydokq+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWsIWRTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EEDC2BD10;
	Sat, 20 Jul 2024 12:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721476844;
	bh=aan1c0yokMXxkS8azH6r9LCPgb5DdnnGAd3SJsQ0YlU=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=BWsIWRToiui3tfMr9j6kUYn8T7CRr6cw23ok0t2FyFwwYzWbi3FohrjJDl//KAHMB
	 Zde7j1nv3oAURRZyxpMPa3WHVop3vo4wWUObigPfp6BUH++vUihdoWIiaUECiTSIwv
	 GXiPVQO/V60j9I6HE9hgK/aHkfqp5F6pzaViI27QLSOpxgkt4zjAsot8JeTfLnMcaY
	 eAkUr4R/4MSURNBC2zNFBOGJaYLRYXrLSaCIDuKv7JXELIsLpkCJLbs3SgykukGBsZ
	 JnNDrvFcglbKZfBGJF7l8AUnz9m+tkXUuuFdikFxytme/dJmPUIOwYwiqggNfwbv5y
	 6V3UayciKKHWA==
Content-Type: multipart/mixed; boundary="===============4330575858904372217=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4077b621656278727e6b65b6f1fd80668352a9198889a8b28810a09991809e77@mail.kernel.org>
In-Reply-To: <cover.1721475357.git.tanggeliang@kylinos.cn>
References: <cover.1721475357.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next 0/4] use network helpers, part 10
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Sat, 20 Jul 2024 12:00:44 +0000 (UTC)

--===============4330575858904372217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,0/4] use network helpers, part 10
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872683&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10019935133

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============4330575858904372217==--

