Return-Path: <bpf+bounces-35152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE885937F58
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 08:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28403B21331
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 06:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4CC14A90;
	Sat, 20 Jul 2024 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2fG/1y/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806DD101E4
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721457818; cv=none; b=mLs6JCJe/3BCjjIhKzEqM3TGLnsitFhVIX5L2bj2i6UIwu1m7iuSQo8+D7KPpur7GTCzrYb6ck4YAs/0nwl7DRHVXFpYV9NCpSLdp/iPK4LBRfSSWT4DWqE+i7t6zMSAVzm76J22MOEUpXapXC6KufaPPa+qJJrJ/ObGTQJd7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721457818; c=relaxed/simple;
	bh=L96L+eKYUf5ANbpAMDVRvNwRjdl1CSIKZnDw0/BVjJk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=EBQaER6jSSE+yYe6z+3FjQ58+ASWhbC5SDamXXraFAd3nCn876qBGMY9u7IGYRZajQ3vQksIelBeuoN6ZFZPfRh8jzibbEgCl/WjL5ifyAncRZ/7N7w+Fn/DlAdvfFxn8emK4yWn2vQJnFITrxYa0kNdEjRbw+fdXoEwkfKKN3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2fG/1y/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB64C2BD10;
	Sat, 20 Jul 2024 06:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721457817;
	bh=L96L+eKYUf5ANbpAMDVRvNwRjdl1CSIKZnDw0/BVjJk=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=o2fG/1y/ZZSOISi2c7fUCdrY9KgJ8Aba5gwWcN72Iztbr6Ms9G6ww60NanKZIYscQ
	 0YU6bzKsn7LKP1/lfhf1BReo5IQICY3lyO9VpZgOD68y708bMhkuAQNNIUnWNLhF5k
	 zQ62VAtZX1uNIAKhoNKG2z3Y9gskboOYQ/YAk8lQQ8O1IQQdTJMKpeOE8rIyo6gDmZ
	 TYICq7AaWJe1ZP0kgcOlfeyPEONlvu+Eg3Yu4eAC8/N1gBWPi/VRH3zXz7o1kRAx06
	 jguZ2XjKOpx/RdBS67kkDe249lWOY/Zj7fUUW0knHGxD0cF2bpo6FrJdm+E/H3QfRG
	 RCqiiAJmbQLpw==
Content-Type: multipart/mixed; boundary="===============5722047072677889231=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ac0bf260a1a0f0bed9aff50dfa8bf1d9e00c3d65cc953c5aed4ceab7bc2a6665@mail.kernel.org>
In-Reply-To: <20240720062233.2319723-1-martin.lau@linux.dev>
References: <20240720062233.2319723-1-martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next 0/3] bpf: Retire the unsupported_ops usage in struct_ops
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Sat, 20 Jul 2024 06:43:37 +0000 (UTC)

--===============5722047072677889231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,0/3] bpf: Retire the unsupported_ops usage in struct_ops
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872651&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10018220214

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============5722047072677889231==--

