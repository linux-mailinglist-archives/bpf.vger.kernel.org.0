Return-Path: <bpf+bounces-35338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203EC939863
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 04:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF011282A4E
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4366E13B5B9;
	Tue, 23 Jul 2024 02:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQhSkgie"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9B013B2A5
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 02:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721702761; cv=none; b=Z1Cn/U+luJKtGdnXYMIfByu1wh3Mh86ROUuronNmTSlZNhFZcq4bgxCznszuXSFckmrNoHgUNIzflGFLkD98wJKP5M4kzGiQNAVkRcC8Gr2aysBbjfXLYjOTYjZm/IEa6EzGKbxclePIbUo1kqhFGIHUgLPVbeyHV6+VJHZqrG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721702761; c=relaxed/simple;
	bh=AIxrSSejrM/iMXmPcGwhGf9tPsYDQxeJEF3NQVE6x44=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=ujrlUK7VcHOfGWinp/FOgbMYpR32CJwMS2OW1v7p69eEU6FQTUrCp94sm4tJ79fUKYKU5Wq7H0VCZL+gO53fySgVVraShP+8/EUoJ7tdfG+1ag58dknKnmEC7IYS1lZ4jrbFjPPCAw/+CgdpI+Kg2QWAjbELJy4wAXkAuwkdqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQhSkgie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3852DC4AF0E;
	Tue, 23 Jul 2024 02:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721702761;
	bh=AIxrSSejrM/iMXmPcGwhGf9tPsYDQxeJEF3NQVE6x44=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=eQhSkgieTXD8IOGiWulxz4A39uqif4SusxcgoGz97O/99LlT60z9ZzYIYp9EE4Gz0
	 DTg+hiu9cnri7Fx+4hB3QYtWm2dpcOpofTJ73fw/OCmqKeIQydhF2zfGVKHyZno6On
	 D1/jhVLojovYgfk4trQF+U2UgL6YN5FSPMy+Z+knFIWEoZ7Jy9Ss9cmEg7g4menV3K
	 yIuY7PztDc5NfKg1PQP4UBTfes1n4dFRRW5Bmc+wy3s5x3XVXDRyNCzGU5GVnwICJn
	 4T01GWWXIebj/O2gJNbeS9cx/GgLKsJ6WyDwOkQK5NQhys5l/c03AKx6uohA1nSfBp
	 Zfpv3I9xjIlgQ==
Content-Type: multipart/mixed; boundary="===============2940950126422844599=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <62dd44860efbf8710cdd9d4dfaf762d5b5532c02cb66a7b6dde321517df03c1b@mail.kernel.org>
In-Reply-To: <20240720052535.2185967-1-tony.ambardar@gmail.com>
References: <20240720052535.2185967-1-tony.ambardar@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix wrong binary in Makefile log output
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 02:46:01 +0000 (UTC)

--===============2940950126422844599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v2] selftests/bpf: Fix wrong binary in Makefile log output
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872645&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10051528751

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============2940950126422844599==--

