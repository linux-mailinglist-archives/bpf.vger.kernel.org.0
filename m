Return-Path: <bpf+bounces-75582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC172C8A263
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 15:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FE03A7BA4
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 14:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5392741DF;
	Wed, 26 Nov 2025 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEMp3wsE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1413226D18;
	Wed, 26 Nov 2025 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764166009; cv=none; b=pl37AoF6ZML1vGtPFexwWrKMoDYLu0urx8YGj2D2T3NKGmkmKhMHfXfIFILOLYFogHLV1NTFTrE7ghe+lMsKWpT/Tyl4ueW0iCSg9emybADPJ6tda4ZrSAK8GJhWG/j0r4qI2PQLR8bJoMKeV9qDeWx183pw/1OYZMdaBcog4MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764166009; c=relaxed/simple;
	bh=F7sYG0jsLCGGWs94KYaC0drcNMqHfCxS0ZpCejngkNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ga49bn4WWTnQyka6x0E4gPGC+4DIaBzwuQSqBGwOOCYH/5S95aoPKQ7V/aMt9ke13iAQahmAFDIhL6RRDlnxF7YeUZ9fm2KXnYTzUcTgxGQMYDaLSkjFuzFtyoxrsAK/kJdilR2irO7t3R+/rfX/k5BvFedk6bt7u1zqW31g2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEMp3wsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7929C4CEF7;
	Wed, 26 Nov 2025 14:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764166009;
	bh=F7sYG0jsLCGGWs94KYaC0drcNMqHfCxS0ZpCejngkNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEMp3wsErgin+pMB3AR32dEudVEA1Wx3GJnOB9Y9yQXoDoJzezApUyIFCkwNS5sMS
	 prPd/w1l+WZHv0XGu4xjEf9ld/gS6luhNOdVOtIuB+WBNvuIe8Fj+3eKUSCuaic7Up
	 VJIcr3/JfDJt0kN8n8gFtEn7Pw4bul+Q8BATnHwfAdm+UKchH+QWXeDqN91PBUqjz8
	 hQHDXf6/8KG9OVXREXogC1/uYx2FRyo8nH9a9iQJ7oSa1mOKMQtjHInG23XUxeULoh
	 Th9Ow5OBHZvptFJeEpkJ6n7KDO1UntBwRFJyUcFSEj0o55a2m20py8/06f8/du1WEk
	 TlV2TbLHIo3Ng==
Date: Wed, 26 Nov 2025 15:06:46 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 14/16] srcu: Create an SRCU-fast-updown API
Message-ID: <aScJdsi4QNPd-f_2@localhost.localdomain>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
 <20251105203216.2701005-14-paulmck@kernel.org>
 <aSW6sVkqWh2aGxlK@localhost.localdomain>
 <66ee4f2d-9885-446a-996f-801a1fe62a68@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66ee4f2d-9885-446a-996f-801a1fe62a68@paulmck-laptop>

Le Tue, Nov 25, 2025 at 07:54:33AM -0800, Paul E. McKenney a écrit :
> On Tue, Nov 25, 2025 at 03:18:25PM +0100, Frederic Weisbecker wrote:
> > Le Wed, Nov 05, 2025 at 12:32:14PM -0800, Paul E. McKenney a écrit :
> > > This commit creates an SRCU-fast-updown API, including
> > > DEFINE_SRCU_FAST_UPDOWN(), DEFINE_STATIC_SRCU_FAST_UPDOWN(),
> > > __init_srcu_struct_fast_updown(), init_srcu_struct_fast_updown(),
> > > srcu_read_lock_fast_updown(), srcu_read_unlock_fast_updown(),
> > > __srcu_read_lock_fast_updown(), and __srcu_read_unlock_fast_updown().
> > > 
> > > These are initially identical to their SRCU-fast counterparts, but both
> > > SRCU-fast and SRCU-fast-updown will be optimized in different directions
> > > by later commits.  SRCU-fast will lack any sort of srcu_down_read() and
> > > srcu_up_read() APIs, which will enable extremely efficient NMI safety.
> > > For its part, SRCU-fast-updown will not be NMI safe, which will enable
> > > reasonably efficient implementations of srcu_down_read_fast() and
> > > srcu_up_read_fast().
> > 
> > Doing a last round of reviews before sitting down on a pull request,
> > I think the changelog in this one should mention what are the expected
> > uses of SRCU-fast-updown, since the RCU-TASK-TRACE conversion bits aren't
> > there for this merge window yet.
> 
> The RCU Tasks Trace conversion is helped by RCU-fast.  RCU-fast-updown
> is needed for Andrii's uretprobes code in order to get rid of the
> read-side memory barriers while still allowing entering the reader at
> task level while exiting it in a timer handler.
> 
> Does any of that help?
> 
> Oh, and commit-by-commit testing passed this past evening, so still
> looking good there!

Ok, here is the new proposed changelog accordingly:

----
srcu: Create an SRCU-fast-updown API

This commit creates an SRCU-fast-updown API, including
DEFINE_SRCU_FAST_UPDOWN(), DEFINE_STATIC_SRCU_FAST_UPDOWN(),
__init_srcu_struct_fast_updown(), init_srcu_struct_fast_updown(),
srcu_read_lock_fast_updown(), srcu_read_unlock_fast_updown(),
__srcu_read_lock_fast_updown(), and __srcu_read_unlock_fast_updown().

These are initially identical to their SRCU-fast counterparts, but both
SRCU-fast and SRCU-fast-updown will be optimized in different directions
by later commits. SRCU-fast will lack any sort of srcu_down_read() and
srcu_up_read() APIs, which will enable extremely efficient NMI safety.
For its part, SRCU-fast-updown will not be NMI safe, which will enable
reasonably efficient implementations of srcu_down_read_fast() and
srcu_up_read_fast().

This API fork happens to meet two different future usecases.

* SRCU-fast will become the reimplementation basis for RCU-TASK-TRACE
  for consolidation. Since RCU-TASK-TRACE must be NMI safe, SRCU-fast
  must be as well.

* SRCU-fast-updown will be needed for uretprobes code in order to get
  rid of the read-side memory barriers while still allowing entering the
  reader at task level while exiting it in a timer handler.

This commit also adds rcutorture tests for the new APIs.  This
(annoyingly) needs to be in the same commit for bisectability.  With this
commit, the 0x8 value tests SRCU-fast-updown.  However, most SRCU-fast
testing will be via the RCU Tasks Trace wrappers.

[ paulmck: Apply s/0x8/0x4/ missing change per Boqun Feng feedback. ]
[ paulmck: Apply Akira Yokosawa feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

