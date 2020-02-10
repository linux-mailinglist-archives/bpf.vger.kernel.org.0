Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3A1E157F8C
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2020 17:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgBJQSI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Feb 2020 11:18:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgBJQSH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Feb 2020 11:18:07 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [193.85.242.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 567E520714;
        Mon, 10 Feb 2020 16:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581351487;
        bh=Q4ZkafkaKSh84YCeMFnoSGa3N8qENIFyo2pbdVYUeKc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=IPS+Ru7101I3F9G8FtyNS+bvAyJ/U9qgxNoEqnkXTUrVAZ47ZzYAl1AZd/x0Fm+HH
         s0MwfBAU55oopQlyDvRoc2VbdTnhZzy4cLI0s5nb9tesFrx969gsLx5P0ugDm4INPS
         RF2xwDfXt0a/62okmeeXXUflLAZG5pgxwYprDxLo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 42E273522700; Mon, 10 Feb 2020 08:18:05 -0800 (PST)
Date:   Mon, 10 Feb 2020 08:18:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Cc:     kernel-team@fb.com
Subject: [BPF TOPIC] BPF Memory Model
Message-ID: <20200210161805.GA5214@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF Memory Model
================

Now that BPF supports concurrency, the issue of memory ordering is
with us.  This issue will become more pressing as additional atomic
operations are added to BPF for the following reasons:

1.	Developers will need to know how much synchronization is
	needed to make their concurrent BPF code work properly,
	regardless of the underlying hardware and compiler.

2.	A BPF memory model can be helpful in locating concurrency
	bugs and checking fixes.

Given that BPF interacts with the Linux kernel, the obvious candidate for
the BPF memory model is of course the Linux-kernel memory model (LKMM).
However, BPF will likely adopt atomic operations on an as-needed basis,
and these will need to interact not only with each other, but also with
in-kernel atomic operations.  In addition, LKMM relies on help from
coding conventions and compiler options, so some care is required to
even exactly mimic LKMM.

Some areas needing attention:

a.	Determining what in-kernel data should be accessed directly by
	BPF programs as opposed to accessed via helpers.  For example,
	in-kernel data with complex access protocols might require access
	via helpers that enforce those protocols.

b.	Deciding what types of verification should be applied to
	BPF programs and at what point in the process.
	
c.	Deciding to what extent BPF verification should be integrated
	with in-kernel validation such as lockdep and KASAN.

d.	Adapting LKMM tooling to BPF programs.

e.	Working out which atomic operations to add to BPF and in which
	order.

Tackling these issues head-on will help BPF move to concurrency with
minimal shared-variable drama.  This talk will summarize the current
state and hopefully kick of discussions leading to improved approaches
to BPF's sharing variables both within BPF and with the kernel.
