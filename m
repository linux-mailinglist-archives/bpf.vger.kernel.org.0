Return-Path: <bpf+bounces-35303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A01EF93977E
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD3A1C21985
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAC173456;
	Tue, 23 Jul 2024 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agi9EvvV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13C6D1C7
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 00:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721694994; cv=none; b=Ndxgxmj5H1H3oGnHkE45paE+uU6ada5/8F8E/+pwNr6T1OvWaP1RviGaLV5bf9hzMjGUvRcM5UT/7+E9SsEiR5L1wO+IPZJBq1LdodASgddzmEks84zMM6xRD3fXNzLbc+QDpsPgIgUuCFCA09/IJUB6ue+b+oSs0oQGzK4yqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721694994; c=relaxed/simple;
	bh=1f9ky8h3gH3mEMMGUOFuePFwuMMj/Va6ogHEcLHCuO0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ctBeEvnI8WQTilFFAr00W8Go84N2bXG8iJEDq4iMlwIV1L2Tw+cruoXjNCz89V31rqr2PShZ5UPUVg0pSQzr0DqHZmtxxA3KbGQ6O+9hSUcqUM33MtIIlpd8e//shG4opc1WbQr9jGykHVF/OP1oyIADQpEk6raoF2W8caUhT+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agi9EvvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D124C4AF0D;
	Tue, 23 Jul 2024 00:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721694994;
	bh=1f9ky8h3gH3mEMMGUOFuePFwuMMj/Va6ogHEcLHCuO0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=agi9EvvVLW4oxKLFARnuphcFAd3tC2nJpYxK8csc5zHTO4BoVTjbvb14q9q4mG1uv
	 Mxen/w2M3LPJkxU3h1mRb+82nXB2S7GW1dJL7FopaQeK3izwmCmnFo7IbeR8yL77TP
	 tuHwQ770pZ0z69cQZmako6jQObL4MJsROBQaFI81S9OEX+nZX0iYppjnW7VTTENVEj
	 R/U7EDaWwS18xFX/imLRIY1zikZ9XxK/m80lfwivzZNMD+KzHmOs8SSuR2itPuSfUs
	 ALJrSdnck+Fv72PPiSaNDShY4BHoqHUoTPg0Jw3/9Mn+NIbIUG51B1CQGpPm0uWQys
	 nwMwH4fZFXycA==
Content-Type: multipart/mixed; boundary="===============0859777111228160738=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <af3092c49ec5118fcfef15bd31ad30033533c6c36fb6aeb1d4b1fbe16b076388@mail.kernel.org>
In-Reply-To: <20240722233844.1406874-1-eddyz87@gmail.com>
References: <20240722233844.1406874-1-eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v4 00/10] no_caller_saved_registers attribute for helper calls
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 00:36:34 +0000 (UTC)

--===============0859777111228160738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v4,00/10] no_caller_saved_registers attribute for helper calls
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873083&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10050074658

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============0859777111228160738==--

