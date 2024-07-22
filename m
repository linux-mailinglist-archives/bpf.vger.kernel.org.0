Return-Path: <bpf+bounces-35236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD58A93918F
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 17:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6839E281764
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100E516DEBB;
	Mon, 22 Jul 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eqnpldib"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D424125D6
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661444; cv=none; b=rj3GKUI5xJS8aNmOxRbVmrplrQt10cx+t4mi7Sj1uvC3pPEGOFvbJXhkOkaH0D5PuHkctPeU6Z762dcgGrOGBPDPhWz7wDrk3JoeA0a9++k18S8fUuq2wpZfm8j54jI52MJEnW8QvHnFlTFA/TFycH8l3bKtzMKKhnB+7Nvckzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661444; c=relaxed/simple;
	bh=H7HUWoGGz1pw5a/0Zvde5yRyaI/iSF5qPld/QiyUgP0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=RXhQMO//uyOBxT8KdshXsJyi4yoqZX0LUQ2VS00lbvhg3LP4wb9UDimS9QATnURR1w7Npyzh+R+m9qMEXkQaSoEEESXy9nyTd596jC3QwSvarq+lnL24VK9YhOT2w1CY0gMwFp2jIoZPbm4+nyqqcs7/cHHgHP9eaLLEVvci/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eqnpldib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2BDC4AF0D;
	Mon, 22 Jul 2024 15:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721661444;
	bh=H7HUWoGGz1pw5a/0Zvde5yRyaI/iSF5qPld/QiyUgP0=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=EqnpldibTZ3Kau662eakKr6hF0dEbiKMRKFXby8qI4ddRYmIOokhicFldLTiPFCtx
	 ldbfv108dCXnW+cpfGfXNNabb+z0k1MoIsghKrp+3IFQh/DMETYsfYmhfhbdHthA3q
	 nJb4sEKdYQ6hqpYxv737OoZ+UFER/nM5uAFodU3kUK8XmwUHVnq3SW64xKzntNDQjK
	 sfYat51VytIeFEdYPTMoTi94eOZHGDvdU71lRLeAYUjG9NrDVZHAU70KmNSbbS8NQL
	 5y5POyfOnslYnPKGfmMd4rYKcDAkzHFl6gP5w6EpIoaW4iAsXz4HVy4ejI1+GG0xbS
	 Fkv1fgzU5hFgA==
Content-Type: multipart/mixed; boundary="===============6931760637234552461=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <80f096f86ec3d267ebc0e37a9a5fd5fbd364d479e96be818d69d1db62954b65b@mail.kernel.org>
In-Reply-To: <20240720052535.2185967-1-tony.ambardar@gmail.com>
References: <20240720052535.2185967-1-tony.ambardar@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix wrong binary in Makefile log output
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Mon, 22 Jul 2024 15:17:24 +0000 (UTC)

--===============6931760637234552461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     FAILURE
Name:       [bpf-next,v2] selftests/bpf: Fix wrong binary in Makefile log output
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872645&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10043109164

Failed jobs:
test_maps-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10043109164/job/27755765176


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============6931760637234552461==--

