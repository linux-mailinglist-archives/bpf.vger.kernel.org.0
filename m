Return-Path: <bpf+bounces-38839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F87796AA53
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 23:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3BA1F25D09
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 21:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32115192B68;
	Tue,  3 Sep 2024 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f9MN7roT"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8451CF5FA
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399493; cv=none; b=GLL5xXedX/nGWovsshq1aRYJmyNx7NDkwIFVd/ZUhAZ+JfI895cY62csdwJnx7yC/FDc6vLLaDZ0umsceIQIyQtHzg6pJmrDlXToGHh4vtII16xpbzWUNl2zkP1sCmb1nWwWKxdqyk6Xhe6IvY5UP6IUfekHuNlpgPzELmbOqzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399493; c=relaxed/simple;
	bh=cGgPf5JfNAEVKnOSbYXIvdInRlTxMPFHlIJ0pyVOscY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILt8mRRTK83dWck8sLDb1/K34h8Az/ESoDycGxppXQRcRat3hvNqvdzIZHd1fD5miF8MqnJ9PmGtA792ChKLRiUmxryz4jHQI5wRD6tErgQ4dwwyGFA+XaZgzeSwPMoTZQ586jNbYASoGY/nO3IS9ICf8bwllubxwHgw/UqqNkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f9MN7roT; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 3 Sep 2024 17:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725399489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=952PcxBu4qPLrefB1WB3fF6Z6QmUkNBiQIiXRdzbJtc=;
	b=f9MN7roTLfeCBLibXWPWmJSFKwaZ1LysJK5hbwspmAYOEQmEVJmM792/jDmZHxxX5Ih1gM
	V7ipG9+QvIw0cDfcID28oRVP65BC3fNiii/hrOFibwDaC32V3f8Kqq31fOXMkRjSf88Qt/
	WiuC1wOU5eg6gDR1m6ddN9eyjz2ZzOk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 0/11] Add light-weight readers for SRCU
Message-ID: <gbar5cxixgq4jtxgtzv7xjipabhqqbwdwyrtahkkws3tregdvo@edqb7ku2uhk2>
References: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 03, 2024 at 09:32:51AM GMT, Paul E. McKenney wrote:
> Hello!
> 
> This series provides light-weight readers for SRCU.  This lightness
> is selected by the caller by using the new srcu_read_lock_lite() and
> srcu_read_unlock_lite() flavors instead of the usual srcu_read_lock() and
> srcu_read_unlock() flavors.  Although this passes significant rcutorture
> testing, this should still be considered to be experimental.

This avoids memory barriers, correct?

> There are a few restrictions:  (1) If srcu_read_lock_lite() is called
> on a given srcu_struct structure, then no other flavor may be used on
> that srcu_struct structure, before, during, or after.  (2) The _lite()
> readers may only be invoked from regions of code where RCU is watching
> (as in those regions in which rcu_is_watching() returns true).  (3)
> There is no auto-expediting for srcu_struct structures that have
> been passed to _lite() readers.  (4) SRCU grace periods for _lite()
> srcu_struct structures invoke synchronize_rcu() at least twice, thus
> having longer latencies than their non-_lite() counterparts.  (5) Even
> with synchronize_srcu_expedited(), the resulting SRCU grace period
> will invoke synchronize_rcu() at least twice, as opposed to invoking
> the IPI-happy synchronize_rcu_expedited() function.  (6)  Just as with
> srcu_read_lock() and srcu_read_unlock(), the srcu_read_lock_lite() and
> srcu_read_unlock_lite() functions may not (repeat, *not*) be invoked
> from NMI handlers (that is what the _nmisafe() interface are for).
> Although one could imagine readers that were both _lite() and _nmisafe(),
> one might also imagine that the read-modify-write atomic operations that
> are needed by any NMI-safe SRCU read marker would make this unhelpful
> from a performance perspective.

So if I'm following, this should work fine for bcachefs, and be a nifty
small perforance boost.

Can I give you an account for my test cluster? If you'd like, we can
convert bcachefs to it and point it at your branch.

