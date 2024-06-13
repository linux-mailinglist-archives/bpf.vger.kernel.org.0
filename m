Return-Path: <bpf+bounces-32079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5FB907307
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 14:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1481A1C21C5A
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 12:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E140C142E9C;
	Thu, 13 Jun 2024 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1NWlxKM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCB8137914;
	Thu, 13 Jun 2024 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283550; cv=none; b=Mo1QMqWchiWwJBgw1jI81A6wxFW6X5ZaA2xT+4y82qY9f3R1jVDRXwrgNjKj2UjtrcitO9wpc4DIPfEQ+nRmRqXKzy/a67u1p+PQYrNZCprnQh8QjmGdKm9PvxgM1eWS/xFB44M18TMPz2bpe1dpj9lhC0iQsNefU7R6fF9d87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283550; c=relaxed/simple;
	bh=etrALkXwRl8zDxAotSVCh3RhyEbTiNBpltd+VXvzvNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+GbObZKTtjcK/mrWipLzdURNpy7LW+c4V9TL+kuH4HEr0CZzjSldi6Ehk/CKElcsxYkQ8OQXwUTr8VjWp5pnlfaUF4PwzbuXMaedQlqSAa9ZemeXHRVklsjS3LRwxqwPaQbkkh2IzlKu968aexzwTlYHw0D3pWUSEif2aWTcf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1NWlxKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96739C2BBFC;
	Thu, 13 Jun 2024 12:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718283550;
	bh=etrALkXwRl8zDxAotSVCh3RhyEbTiNBpltd+VXvzvNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1NWlxKMENC+Q3DhMuln06VopaAL/VXRxy5sDVDqSt4L6aFwMy1L2JXzTdhs3Kkg2
	 C2Wv66R/o66EYxKbWHPKQNP9Q2Ewp9mXJhKwnm8y0/7r8+ONjxD0Mc46y7MkLZG6wf
	 kEiebLSKL8Ww98b2EuFV/tlH+9KkPGi1KPVzEjygpRzr962oNqBv0z38jAl07JXinL
	 yhHp/n3MH0fJovw7iyVKz/zm3iMHLCJUeh6iGepW0l/wiUsss7oVA0a3FDTowfypfa
	 BehIamiT6sp6zDy1g1TnJIh7pDfTr1xTYC6+5bohSeBS2NlwxCwZ/xc74Epj+O3+6s
	 kqwl8Y8Ta1nkg==
Date: Thu, 13 Jun 2024 09:59:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, mic@digikod.net, gnoack@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4] perf trace: BTF-based enum pretty printing
Message-ID: <ZmrtGuhdMlbssODG@x1>
References: <20240613042747.3770204-1-howardchu95@gmail.com>
 <ZmrqQs64TvAt8XjK@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmrqQs64TvAt8XjK@x1>

On Thu, Jun 13, 2024 at 09:47:02AM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jun 13, 2024 at 12:27:47PM +0800, Howard Chu wrote:
> > changes in v4:

> > - Add enum support to tracepoint arguments
 
> That is cool, but see below the comment as having this as a separate
> patch.
> 
> Also please, on the patch that introduces ! syscall tracepoint enum args
> BTF augmentation include examples of tracepoints being augmented. I'll

You did it as a notes for v4, great, I missed that.

> try here while testing the patch as-is.

The landlock_add_rule continues to work, using the same test program I 
posted when testing your v1 patch: 

root@x1:~# perf trace -e landlock_add_rule
     0.000 ( 0.016 ms): landlock_add_r/475518 landlock_add_rule(ruleset_fd: 1, rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7ffd790ff690) = -1 EBADFD (File descriptor in bad state)
     0.115 ( 0.003 ms): landlock_add_r/475518 landlock_add_rule(ruleset_fd: 2, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7ffd790ff690) = -1 EBADFD (File descriptor in bad state)

Now lets try with some of the !syscalls tracepoints with enum args:

root@x1:~# perf trace -e timer:hrtimer_start --max-events=5
     0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff225050, function: 0xffffffff9e22ddd0, expires: 210588861000000, softexpires: 210588861000000, mode: HRTIMER_MODE_ABS)
18446744073709.551 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff2a5050, function: 0xffffffff9e22ddd0, expires: 210588861000000, softexpires: 210588861000000, mode: HRTIMER_MODE_ABS)
     0.007 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff325050, function: 0xffffffff9e22ddd0, expires: 210588861000000, softexpires: 210588861000000, mode: HRTIMER_MODE_ABS)
     0.007 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff3a5050, function: 0xffffffff9e22ddd0, expires: 210588861000000, softexpires: 210588861000000, mode: HRTIMER_MODE_ABS)
18446744073709.543 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff425050, function: 0xffffffff9e22ddd0, expires: 210588861000000, softexpires: 210588861000000, mode: HRTIMER_MODE_ABS)
root@x1:~# 

Cool, it works!

Now lets try and use it with filters, to get something other than HRTIMER_MODE_ABS:

root@x1:~# perf trace -e timer:hrtimer_start --filter='mode!=HRTIMER_MODE_ABS' --max-events=5
No resolver (strtoul) for "mode" in "timer:hrtimer_start", can't set filter "(mode!=HRTIMER_MODE_ABS) && (common_pid != 475859 && common_pid != 4041)"
root@x1:~#


oops, that is the next step then :-)

If I do:

root@x1:~# pahole --contains_enumerator=HRTIMER_MODE_ABS
enum hrtimer_mode {
	HRTIMER_MODE_ABS             = 0,
	HRTIMER_MODE_REL             = 1,
	HRTIMER_MODE_PINNED          = 2,
	HRTIMER_MODE_SOFT            = 4,
	HRTIMER_MODE_HARD            = 8,
	HRTIMER_MODE_ABS_PINNED      = 2,
	HRTIMER_MODE_REL_PINNED      = 3,
	HRTIMER_MODE_ABS_SOFT        = 4,
	HRTIMER_MODE_REL_SOFT        = 5,
	HRTIMER_MODE_ABS_PINNED_SOFT = 6,
	HRTIMER_MODE_REL_PINNED_SOFT = 7,
	HRTIMER_MODE_ABS_HARD        = 8,
	HRTIMER_MODE_REL_HARD        = 9,
	HRTIMER_MODE_ABS_PINNED_HARD = 10,
	HRTIMER_MODE_REL_PINNED_HARD = 11,
}
root@x1:~#

And then use the value for HRTIMER_MODE_ABS instead:

root@x1:~# perf trace -e timer:hrtimer_start --filter='mode!=0' --max-events=1
     0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff225050, function: 0xffffffff9e22ddd0, expires: 210759990000000, softexpires: 210759990000000, mode: HRTIMER_MODE_ABS_PINNED_HARD)
root@x1:~#

Now also filtering HRTIMER_MODE_ABS_PINNED_HARD:

root@x1:~# perf trace -e timer:hrtimer_start --filter='mode!=0 && mode != 10' --max-events=2
     0.000 podman/178137 timer:hrtimer_start(hrtimer: 0xffffa2024468fda8, function: 0xffffffff9e2170c0, expires: 210886679225214, softexpires: 210886679175214, mode: HRTIMER_MODE_REL)
    32.935 podman/5046 timer:hrtimer_start(hrtimer: 0xffffa20244fabc40, function: 0xffffffff9e2170c0, expires: 210886712159707, softexpires: 210886712109707, mode: HRTIMER_MODE_REL)
root@x1:~#

But this then should be a _third_ patch :-)

We're making progress!

- Arnaldo

