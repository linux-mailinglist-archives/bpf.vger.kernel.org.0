Return-Path: <bpf+bounces-46667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A339ED80E
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 22:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64784188B6EF
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 21:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDE42288EA;
	Wed, 11 Dec 2024 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMZ6hcwL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD261D88D3;
	Wed, 11 Dec 2024 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950912; cv=none; b=StZWLz+35SXgxGNguMSeVaiMRENxYqaYhaSIHIkODrEx7zFrvR61+lxu+bOcQlTPP0lDp6/p1R+NpTOyXqEN/9/YnzEtGweXwRMeskAPK4ly+aKDvKK5tmObqbR8HcD9DSFT0xXey+0f+CezVRuYnGdmjJCEWmn6k70vwqQvRyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950912; c=relaxed/simple;
	bh=dQnmoWONT5Zo+IkP2sm37LSCIsWrY5YPNyx39MAvgBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4IfQBsHWTELYKp49p5sOEOLj0KIvc8nJ6e4leswoIPpYJ7eN7zRzgZpsYfrZ3NhFKYHUbNWiCC3ADXga6WIan5XJkTf6sFlBh/LPfSqCJQI8f9JMyAJ2M5Histeks76TtAJnoqYvV/2t/19k0yg8AVrsr8zTDgM3cozclXzXRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMZ6hcwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D72C4CED2;
	Wed, 11 Dec 2024 21:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733950912;
	bh=dQnmoWONT5Zo+IkP2sm37LSCIsWrY5YPNyx39MAvgBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMZ6hcwLgY5CuexEHbWUkzg9oEtO4r82tLO75t7aa+WBwtCIIzBYMwboKaX8U7SXE
	 babeq9B+PtSh4DoAHGI5WLO3fNJ9qra8LlC+wlwR+oeJw66cDlEkdemeMzyr2t4ogc
	 lUtN/oXzatlxclTdclt/nfCbZJ6vrtzS7HOiHS/vKNrHRK8ZmZCTEeJvrNgH534E+B
	 xcAkUqiahziRV+RLcoq8AtLAG9zSJIewEbMcSRYLcnZx+YkoKg/NxNNqxM95poZkMG
	 /Hy8tmpPHXoHTL7Dzzi2a6Yjwow2F6UShuy3ba5DfqteBYkJcBAduuHKIWEpOgAyjI
	 JRyS+dNVazqww==
Date: Wed, 11 Dec 2024 11:01:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: David Vernet <void@manifault.com>, sched-ext@meta.com,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: [PATCH sched_ext/for-6.13-fixes] sched_ext: Fix invalid irq restore
 in scx_ops_bypass()
Message-ID: <Z1n9v7Z6iNJ-wKmq@slm.duckdns.org>
References: <20241209152924.4508-1-void@manifault.com>
 <qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7DvH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7DvH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=@pm.me>

While adding outer irqsave/restore locking, 0e7ffff1b811 ("scx: Fix raciness
in scx_ops_bypass()") forgot to convert an inner rq_unlock_irqrestore() to
rq_unlock() which could re-enable IRQ prematurely leading to the following
warning:

  raw_local_irq_restore() called with IRQs enabled
  WARNING: CPU: 1 PID: 96 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x30/0x40
  ...
  Sched_ext: create_dsq (enabling)
  pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : warn_bogus_irq_restore+0x30/0x40
  lr : warn_bogus_irq_restore+0x30/0x40
  ...
  Call trace:
   warn_bogus_irq_restore+0x30/0x40 (P)
   warn_bogus_irq_restore+0x30/0x40 (L)
   scx_ops_bypass+0x224/0x3b8
   scx_ops_enable.isra.0+0x2c8/0xaa8
   bpf_scx_reg+0x18/0x30
  ...
  irq event stamp: 33739
  hardirqs last  enabled at (33739): [<ffff8000800b699c>] scx_ops_bypass+0x174/0x3b8
  hardirqs last disabled at (33738): [<ffff800080d48ad4>] _raw_spin_lock_irqsave+0xb4/0xd8

Drop the stray _irqrestore().

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Ihor Solodrai <ihor.solodrai@pm.me>
Link: http://lkml.kernel.org/r/qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7DvH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=@pm.me
Fixes: 0e7ffff1b811 ("scx: Fix raciness in scx_ops_bypass()")
Cc: stable@vger.kernel.org # v6.12
---
 kernel/sched/ext.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7fff1d045477..98519e6d0dcd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4763,7 +4763,7 @@ static void scx_ops_bypass(bool bypass)
 		 * sees scx_rq_bypassing() before moving tasks to SCX.
 		 */
 		if (!scx_enabled()) {
-			rq_unlock_irqrestore(rq, &rf);
+			rq_unlock(rq, &rf);
 			continue;
 		}
 

