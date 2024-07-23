Return-Path: <bpf+bounces-35400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575E293A416
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 18:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB181F24559
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1150E157A58;
	Tue, 23 Jul 2024 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAFOa7Jx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F83114EC61
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750481; cv=none; b=k4hil7mBkvazJJ8UU7Nfm6++o5dafHTfuLxO73gPW/0X0kSegQYsqfzYjsHcIBAvx3ZGpOLhRfLtX9IhDvsOefFvTvWI7ovfbmZzg1EB7bn+h8ogngqrqwGR7w+g8E559c6ASZyMaD2pIYVjIhkiYi6zeqdDTDSZbjRXdaQXnjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750481; c=relaxed/simple;
	bh=YMGDnUi9duM0TzawY1vDV4PzYWo669lT51BcRlp8rMU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=poU2v2p2Z2f4FTSUmeEJOda1DhIr1V7XXf86dMirbOFg7jNmzzjUh3On1y4yUY9YgLJ9vS5jBGczrX0fcesRgPfGMyytYJwD5A9shsJ63R2DWaFzgjKmXP0s0vDEd6Uv37A791RCDLS17ujOFlY1CpLo60+2s7QjpLKXAYKb1Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAFOa7Jx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D45C4AF0A;
	Tue, 23 Jul 2024 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721750481;
	bh=YMGDnUi9duM0TzawY1vDV4PzYWo669lT51BcRlp8rMU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=NAFOa7JxYVNeWZRRgBP2piaNdf5u73z2H/Jv4gN0qNpPqSkal61+iQxxDVdoZcxJ8
	 m+giHKppyG3zA++uoMEDbQ5ys/8YnutFduG5i2gzc1R29JqiqCgjbGLic/DYGYkGqN
	 REulRP/dM6Vjz9/W/mgTHl7nybcHZYty4Akx0PWLkpEYXfEtjmRaAZwucfo8eqVf77
	 AFcjdqsZn1/M+z4raslBIiJEMRGFqd072AeThDqK2Ree0O1+pwfQoifuI35xXikKsf
	 a+s/7R3KAHRW0V/lPBjiSx6l2gzsCurJMN6byMVj1pTh4Ri4qo+IQPOe2q017Jkvml
	 i2ypvLqqNLZgQ==
Content-Type: multipart/mixed; boundary="===============8721983496296672074=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <55e838fcf7d7d54118fb5b13cc75f1db7300462590151b9ac4b4b3c9b0cbb596@mail.kernel.org>
In-Reply-To: <20240723153444.2430365-1-yonghong.song@linux.dev>
References: <20240723153444.2430365-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for ldsx of pkt data/data_end/data_meta accesses
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 16:01:21 +0000 (UTC)

--===============8721983496296672074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v3,2/2] selftests/bpf: Add tests for ldsx of pkt data/data_end/data_meta accesses
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873296&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10062073488

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============8721983496296672074==--

