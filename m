Return-Path: <bpf+bounces-35266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAD8939483
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 21:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137331C21779
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 19:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2937617109B;
	Mon, 22 Jul 2024 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eT29YPZv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64AD1CF96
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721678296; cv=none; b=fU4jF9td2ajUEUMaTwfEx+y1Gyz1dZydvMv0U3sbwt/dBRiLcswlNqc4xcwkhKK4ws3aNVXpCRuUXut18X3rz79qMNmSBr+KDAFQDFqtVNTiA7yGhYvpzbWYAwoNnU4YWbETinL+WTcCR3vYTd3BbbnPn+hmiuesB+IVSTX69CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721678296; c=relaxed/simple;
	bh=aG5FJ3I8o8hMqmV0gHFVyV6pPNyTjux8qXaV6HBqXZ0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=rZLfT5UVp0EobUYLjvOq6n9FMvYsfbIe6nsOslxRwcVKKlcNNJx+5QVjdSYKUbfBySqP20yhO5r8fsuAuhWw060U+cm2OqPyVObk+gAiCUp80EupWuyjrY5mPObxJFqNeAHyY7ndDzXds6QqoSzWsnhzEQFMFVqsN4E+rGdbzaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT29YPZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31173C116B1;
	Mon, 22 Jul 2024 19:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721678296;
	bh=aG5FJ3I8o8hMqmV0gHFVyV6pPNyTjux8qXaV6HBqXZ0=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=eT29YPZvkyY4HhaA240SUz39XaRpz/sYd4CXgcZ2Bjt2CQuyYusN6jnRIc/LU5JxT
	 ZZqmW/cPy7S/QSFz79xy/zbEGFW3Kr7G2khruYi+hOskSbaT/ScT6+lUDrKpqpFyGf
	 6GtemNJSCYXfeqEPfDq2amFC1z8IMbrRMSLJ85gENM8bS/f8qO+fy21ufQFyVj40fP
	 gI8NC8Hh6pVMhg0yVe6qnipZty4nGqS4HpzpQtUmaE1ipDyWTcvaMY4EL93vYJd6GF
	 2Usgau915773H13F+1J9jY8M4r1yBXmDcdbE2HFnoeoVWd8CzlK4rx+CK+318PLv9k
	 fVFCcdltxlc+g==
Content-Type: multipart/mixed; boundary="===============3997020856261389133=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4d750a3310b4d7725824ef33b0691f3715061b5ea0b49b0063f47cf3c87e3d5e@mail.kernel.org>
In-Reply-To: <20240720052535.2185967-1-tony.ambardar@gmail.com>
References: <20240720052535.2185967-1-tony.ambardar@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix wrong binary in Makefile log output
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Mon, 22 Jul 2024 19:58:16 +0000 (UTC)

--===============3997020856261389133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v2] selftests/bpf: Fix wrong binary in Makefile log output
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872645&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10047154037

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============3997020856261389133==--

