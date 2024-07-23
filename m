Return-Path: <bpf+bounces-35333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 434EB93981E
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 04:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C389DB213A5
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925BC1339A4;
	Tue, 23 Jul 2024 02:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzkLHh8i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167BB347C7
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 02:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721700186; cv=none; b=Ubxh6LYuhGq+PnLnwtnwD42myYFlWvKcOoAThZwykYsXyE7hlDVl/2Pftv7s2NkhqyC34CvDkTJ149X50RHXe86BcovX9aiOqc9vGLzZLfQtgV6g/iG56FzE7Ra7cJoS9MZw2/91JAQxBGKYps7svchIUw5sOn1iYXnjxydFZKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721700186; c=relaxed/simple;
	bh=slUG5yXluO76NQ9XnioFk6Bp4cZc3EfVBCjDtEy5bHg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VC6f3wXT7PgyibXHWgqkaC0KHh75CY8Odt7c7EXEMAt17BUxzb2hvxhI68lLb0cf+DBPLbXhFocRCB4k2x5dGGif3jASeT0WNh7v9xNYKfOk+V80kEpxj/J2APbtj5czQ1wMs3XGxlzbwo/WAJfNPWLeHuWGU5/t2JKKF9FBZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzkLHh8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DABDC116B1;
	Tue, 23 Jul 2024 02:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721700185;
	bh=slUG5yXluO76NQ9XnioFk6Bp4cZc3EfVBCjDtEy5bHg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gzkLHh8i97Ykm2kSyhS7WwGYy8p4mp2WyHrVecmrdMM9lt2s6SlF2BkKHxXm0uHCR
	 xNamI/vXzXIVRK3Hm7KCnUtujLieJ2S02viNaFhznnSpLkFp7wqWfXv8HvAnPOmnBO
	 2G72ILrn54svyQochD3v7bsQgs7LvSqJ1mGtwbOLE256kMunLHC+uqtMEPmOQMeFk4
	 brJs4pgmJL1BP7F+IkgDrkbqK/LxkmtxwOLDqDjH42Vtjx2KlAUmRGNQWaO7StPjaj
	 sY4egth1LJoaJ5xkuMR4CAtXzhlb4TdZmtDjRVNZNqX+7A3C34S+UMwLlaboLNsd4x
	 HmckTE61SlrKA==
Content-Type: multipart/mixed; boundary="===============4161088946237683746=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6c3f96266443a3011089798f0f45df978d30cd6baa38fb01b314248a581d3eb7@mail.kernel.org>
In-Reply-To: <20240718050228.3543663-1-yonghong.song@linux.dev>
References: <20240718050228.3543663-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for ldsx of pkt data/data_end/data_meta accesses
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 02:03:05 +0000 (UTC)

--===============4161088946237683746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v2,2/2] selftests/bpf: Add tests for ldsx of pkt data/data_end/data_meta accesses
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872131&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10047151662

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============4161088946237683746==--

