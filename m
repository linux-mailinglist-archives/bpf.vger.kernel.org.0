Return-Path: <bpf+bounces-58370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077EDAB91E0
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 23:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D9AA04202
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 21:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6182528C00F;
	Thu, 15 May 2025 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVw9eFKI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAC8289828;
	Thu, 15 May 2025 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747345340; cv=none; b=jAq+07IEnWr/oU3dKbtI0GoZT2fXJQk9THfsOktvwXRKNiG8z534HzXKUxWeP2XL0lpbylsBvBOIEJOTn9LhmZaq2xN2tQBXq+fhJBo25w6ZRhYk86+KKZU5bwJ+o6KPHbxmdKizRD71/4oWeY30hvIJcUoGFz6OizEftuoBuzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747345340; c=relaxed/simple;
	bh=1y0liYuzR1PLGSJmJXnFS6TnanK9HWq9vWfQHyf8za0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QqigEqYGMi1PlRLTWmQmgsPLFQr0sF7aq68+DFdklOSMdmpvIhpqsZSIHJZ7oVU5VeiY63GVNackKMWyu46Pgsal/Iomb0a7DW6KyI0MWOjH5q4S7J8FarYe8MV2mE/KXZzGr+RzorqqqDAfvXTb0ScpV9Vniu4Xsgym5B0z3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVw9eFKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470BAC4CEED;
	Thu, 15 May 2025 21:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747345340;
	bh=1y0liYuzR1PLGSJmJXnFS6TnanK9HWq9vWfQHyf8za0=;
	h=From:To:Cc:Subject:Date:From;
	b=kVw9eFKIshf7HO9K0I5ak6VHb6kQwRhj6Qd5cHGFiiLtDdxj8CrhYHck6rROwQ/WM
	 u18MOEUyasiiZU6GIhLJ3tQt0d0h8zIgtRsZi4M4V/QpaceZsnq3L4wNnNTdXmhQZw
	 HI3G5JZnbb6q0ydRMYC7PGHxYiy7SIcQHZh0LNBtlUCaK+jBdXitXgoBVZ1k6GD3W0
	 w2fuiw6KicRLPVc4i/nXIEV4SUAhloGlaI6mMWN4uEbPLhHDt0wei8x1W7fYO4a/VU
	 iLnp1oxn5hpdxaJHLjjg82ekbssofhjGpMToo7EkkLYYF9sduJGsF5g9dEW+Ln51A1
	 fve/sPXEEFe5w==
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Erhard Furtner <erhard_f@mailbox.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] mm: vmalloc: Actually use the in-place vrealloc region
Date: Thu, 15 May 2025 14:42:14 -0700
Message-Id: <20250515214020.work.519-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=547; i=kees@kernel.org; h=from:subject:message-id; bh=1y0liYuzR1PLGSJmJXnFS6TnanK9HWq9vWfQHyf8za0=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlq8du1Z4rM4Huc/aCVY+dx19iD5lw8k+M0fkZs6ea6/ 6xYLHldRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwESkfRgZmla0+8S1RoYHsPyo nct18JH0+6+fLBe//Dl5xtP9X7wvijP8T2iOvXzeRv+z66WyTWstrrn8fGKlub32/C+O0wdftT7 SZwcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This fixes a performance regression[1] with vrealloc(). This needs to
get into v6.15, which is where the regression originates, and then it'll
get backport to the -stable releases as well.

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg/

Kees Cook (2):
  mm: vmalloc: Actually use the in-place vrealloc region
  mm: vmalloc: Only zero-init on vrealloc shrink

 mm/vmalloc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
2.34.1


