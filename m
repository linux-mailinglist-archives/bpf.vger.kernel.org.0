Return-Path: <bpf+bounces-35337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB361939860
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 04:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FDE28299B
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560A1384BF;
	Tue, 23 Jul 2024 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFXtxFOJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDD61E4A9
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 02:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721702736; cv=none; b=kIpZty2wCMs/F6nRGDiPkJEd0I9htdKFGAllip9OfEY8dc+GcXbFwUhdVJQFe1WYCLnfQR5h9lMsHThPw0YiRhpQcaHKlrt75nqk6xUQuCma2dZdzqvGMWObXnMfG+u+gtbYY1blIUbj8dFR+DsaqyHvObLfe5ic4z0uhDuNNII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721702736; c=relaxed/simple;
	bh=9OFYayJO8aQPyZGLsSYhdBy921h1OxDnFMqS5XDWaFg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=QCwb/q6q8nXQr9XY+XZ9VYcKhxFYdO7vA1ZNvNFz7O3CVRTNZyuDxI2amNvJ/cpQ+vquubdq/3fqr7No0c4pamvP9ApsA1VnrB6JMsS/ykNNGMlPbUrjfzkVPdtIhrBiD8E7DDEHP4Ftk45sziUAp2k195EJ67H3ZX11Qx7G6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFXtxFOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F14C116B1;
	Tue, 23 Jul 2024 02:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721702735;
	bh=9OFYayJO8aQPyZGLsSYhdBy921h1OxDnFMqS5XDWaFg=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=fFXtxFOJ/CSl6BrXZgUhGy9f0vlfeGhLFgn/fDLDtWlaVJWCuMOP9vbxCvYBVVVcQ
	 JGzrQ4vuqouBUSem1sSSqm/qvAlan6bJPv4ZebDuo011FAPg2ntvvsXpN2MhDlE6OD
	 7OyBIFk3M4V7Vh/zR8hVcVZAEXwTq3dyRsUyE8qATyWLCdLT1pi1DmeAFD5pdUAc5e
	 PD3a8RnZ6zPBOZNadNvjSiZG2SeUDiUv2qpr4wvxBFUQUJp3tPG5IKRO+5x30s7+wM
	 BM3OukvhUjfk6jcc6SRbLY/KaIe3bWWL517CkmGRmUj3sNu016HaHeXC84DOmYQBnN
	 x/PSZCFlWj7DQ==
Content-Type: multipart/mixed; boundary="===============0633456471547448457=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b818fb16371fbcedd16e33425feb89051d84a873f30b8c00e7cc488f8b11c3bf@mail.kernel.org>
In-Reply-To: <20240723003045.2273499-1-tony.ambardar@gmail.com>
References: <20240723003045.2273499-1-tony.ambardar@gmail.com>
Subject: Re: [PATCH bpf-next v2] tools/runqslower: Fix LDFLAGS and add LDLIBS support
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 02:45:35 +0000 (UTC)

--===============0633456471547448457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v2] tools/runqslower: Fix LDFLAGS and add LDLIBS support
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873093&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10051523767

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============0633456471547448457==--

