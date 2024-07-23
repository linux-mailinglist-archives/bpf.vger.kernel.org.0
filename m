Return-Path: <bpf+bounces-35339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA66D939869
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 04:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DF51F21F2B
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F14213A241;
	Tue, 23 Jul 2024 02:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unXdau7A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5124501E
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721703043; cv=none; b=Q4dglfnIa02sMeFZaGsyzmDPMgdmYxJRJLE5hJP5phm+AlZtHgVd4uQBq0YxxXi7W9QkHZK9xHEa2j6FBpTjvklwzLA1RUnAl4l4NMSdfoPJH1Bgjd6qC9oQvbkKY5USrS4JrraRgixyoQgqO0PIJ021mvy94xLYeHQjV4PyZTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721703043; c=relaxed/simple;
	bh=+V/prJuWI26JMzZbyT/f3NuY5gCE9elQu3NS1etCcR4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sDOkvCs3YTOtc2tU1UWJaizCbLxBWT+pOjylNdUtQGc7DFV+8kTqX6naS8QKzVsVmV1rqY25MJnfolstEYh3Z39sdUiu9drWKt366MwqgunN4+euZyB/RxA4UjTBTwfMAdkhHvPGPj+AhVKiKIQSt3uP2RRnRL0qNr8NXMlI/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unXdau7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D957C116B1;
	Tue, 23 Jul 2024 02:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721703043;
	bh=+V/prJuWI26JMzZbyT/f3NuY5gCE9elQu3NS1etCcR4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=unXdau7ARdJHO2SvQEwKt1tu54QRRsIusryuLHdYkJXkKtoCVejrq7Pe1Fx5nthIW
	 /YVq1WXF4cwLcUv1iP//1J8LeuwXrnFxlQgrfhJzhyxLRjBvtNvzhGlW/ol1HR76gO
	 toXJ4T7ARCPpgefno2/8/rp3EQP8LkjhWw+rjAIEG3YZzAVwTqFa8bp565nqWR3XKx
	 8H/0DrZ9NM+EH+bY8QfoK/S0ZTbMP/Ehbqvkj/3cObZ2Jm+sxHQU+XQaZPv+E3Qqbu
	 HLKSBvddpdJXaYc3vQROTF3UbXWzctFU/urG4XBseHH+1TjxUTXYFjhHU/I5IophXi
	 jJF2bEsX7X4Pw==
Content-Type: multipart/mixed; boundary="===============5931142719418060240=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d7b6404896203652a4bfabcb4761f30068985200996fce9fceb88c0b9f93f749@mail.kernel.org>
In-Reply-To: <20240721-convert_test_xdp_veth-v4-0-23bdba21b2f9@bootlin.com>
References: <20240721-convert_test_xdp_veth-v4-0-23bdba21b2f9@bootlin.com>
Subject: Re: [PATCH v4 0/2] selftests/bpf: convert test_xdp_veth to test_progs framework
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 02:50:43 +0000 (UTC)

--===============5931142719418060240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [v4,0/2] selftests/bpf: convert test_xdp_veth to test_progs framework
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872778&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10051531186

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============5931142719418060240==--

