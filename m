Return-Path: <bpf+bounces-74764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6BDC65307
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B000F347077
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6592877C3;
	Mon, 17 Nov 2025 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VpMFfI/M"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF222C2372
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396794; cv=none; b=A5BNylcpPpvuhuagJWLIAHktRaMYygslnx0r4QMpcAIBnnEg9zUUOyhcVHoWFjln9wFueMgy7IihaxjFWrUO0sxzQqdmqqw3a6G+s3PTwQmpbQ47HXkW9WSsxr+AOmcw5p58Qj6a/y4BOWDv9E5et5pUANlT8Qrv5BA+MbjZIiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396794; c=relaxed/simple;
	bh=pYa7b1QSb8XhTX63U1LGfCwsxEOsaiRO0Yi2eZ+bjTk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=cKe/pS3K1sOdWw/+fB5fCUUfHDc8FcD4OrcbGdzaQ4WCwulcZGN2yOzMLw+6RYRy+bm+4Uq5kgEYGVTcNY3O5PyCyfXB3aIIDa8UJwFpatMolce1dyhRkb8skuBale+dXFhFOzAPLsNz3G2ZfI/mtXJL937rwYwlmx3VkaC0MFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VpMFfI/M; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <938dbf1c-d2b5-42db-8ceb-0121e0cac698@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763396790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pYa7b1QSb8XhTX63U1LGfCwsxEOsaiRO0Yi2eZ+bjTk=;
	b=VpMFfI/MfTi38Ls1IHtb3yBrDf4yuKiHVrh8TpQu24Ioe/qYRajmeI+SYdOEukHqnVmguw
	dpKz/Cfny7p2dmO3k2QnOnBOHxuAaEwD/AEGgyESsTNJ/lOZqAlpyl+QYluPrMxQEqCDhk
	PnKFiZ3mLfy42MXazZVapOlyOcCx67U=
Date: Mon, 17 Nov 2025 08:26:20 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: bpf <bpf@vger.kernel.org>, netdev@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Announcement: BPF CI is down
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hello everyone,

BPF CI has been down since Friday, November 15, because GitHub appears
to have disabled the "GitHub Actions" feature for the kernel-patches
GitHub organization without any prior notice. We do not yet know the
reason for this.

Currently, the dashboard [1] shows the following message:

"GitHub Actions is currently disabled for this repository. Please
reach out to GitHub Support for assistance."

This means that no BPF CI jobs, including AI reviews, will run for an
unknown period of time.

In the meantime, please be patient with patch reviews, as maintainers
will need to run the selftests manually.

[1] https://github.com/kernel-patches/bpf/actions

