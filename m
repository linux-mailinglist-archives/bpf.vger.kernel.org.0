Return-Path: <bpf+bounces-63657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984BBB09489
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 21:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6ABF583059
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C362185BC;
	Thu, 17 Jul 2025 19:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDeVI+OT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4073333E7;
	Thu, 17 Jul 2025 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779087; cv=none; b=klSlRjphJBcPDIRRk/Yb8ZHhHFTEPVVq1eQ7yJguHFQqiT6rWtauO9mR3J/emUePaKUvXikv7d9rW4xfhAuJDP7b4grFjmqYIHAnNTEoaftzV7rh1eaBc6EMb9pwDnNTYCYd98fznZTPxrprOnWGx4nSpcW1CnGWd2ft9AdA8/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779087; c=relaxed/simple;
	bh=qlDSg7cXxtkS8c4tqqN7K+vLRrKz0WPEcI/MUSBCl8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbgZOCttSSCun4nqLp2ZVpw8p6VJYLyv9HJwmqb0cF8Ora1W6zgk0l6Zish510CRjXJ43dWD65IeT8xS5nZbvw6a/4UJeMOIyqoQDMGIPOSWAB4yJC8rdyusfa1TBafI5KhJjrFKvbKAnZhMp08ILKzM7RlNOaIw0hv3dgP/AOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDeVI+OT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EE2C4CEE3;
	Thu, 17 Jul 2025 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752779086;
	bh=qlDSg7cXxtkS8c4tqqN7K+vLRrKz0WPEcI/MUSBCl8E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WDeVI+OTHkCOFwGDGrmyFxoccQ4XkHDgGHa0/H9CO2M8MyKKoZG+/T+GPIBNkupuA
	 fRnUlcR/eiHf8q8h7F5XcSAh2E8I+gqqIMJ0/9MQIU7CGa8TK5AfsdrHFOdHgXScaU
	 sgE01HMza8kK5t7UadGloUtst+nl3YOsU+fExeq72bKzqmzxj3dKjf3KUBDlqIp6jU
	 BGsjzA9E6N9GO6VShr792gFluzokGmd8v9HeJdONexO3VTpYik7nbBtjC65yFZyY/K
	 bfoLZHavXnZUn6z0+PXefOlA9EBcs4778lxGLadQovDnV1f0XPMXjWUCaGnqKlIMsV
	 3nMU/VhugUj3g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 60437CE13CD; Thu, 17 Jul 2025 12:04:46 -0700 (PDT)
Date: Thu, 17 Jul 2025 12:04:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH RFC 6/4] srcu: Add guards for SRCU-fast readers
Message-ID: <58866d6b-f4d9-4aaf-abce-10ddf526c3ad@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
 <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
 <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>

This adds the usual scoped_guard(srcu_fast, &my_srcu) and
guard(srcu_fast)(&my_srcu).

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 srcu.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 0aa2376cca0b1..ada65b58bc4c5 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -510,6 +510,11 @@ DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
 		    srcu_read_unlock(_T->lock, _T->idx),
 		    int idx)
 
+DEFINE_LOCK_GUARD_1(srcu_fast, struct srcu_struct,
+		    _T->scp = srcu_read_lock_fast(_T->lock),
+		    srcu_read_unlock_fast(_T->lock, _T->scp),
+		    struct srcu_ctr __percpu *scp)
+
 DEFINE_LOCK_GUARD_1(srcu_fast_notrace, struct srcu_struct,
 		    _T->scp = srcu_read_lock_fast_notrace(_T->lock),
 		    srcu_read_unlock_fast_notrace(_T->lock, _T->scp),

