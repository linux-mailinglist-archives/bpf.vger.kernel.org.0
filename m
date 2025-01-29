Return-Path: <bpf+bounces-50015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7956DA21655
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 02:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997AE3A8795
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 01:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EC918DF80;
	Wed, 29 Jan 2025 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJt4ZVW0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF1E17C68;
	Wed, 29 Jan 2025 01:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738115125; cv=none; b=tBVLu49wQREp6CA51HPPi8LA9d/MRURrEs3ikIDAZgcf7FDgOhJG8kp9bTcgfK74ZBRUiq+koJULjZZnJESQmWE5ZHvHGrUL3LwfMXNGMGb9SEXvLBAjhPJ0c8aMeGSe2uTRR5OEl0NpAqyfU8GRGfBOdTqkU13S6i1UtYlw6ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738115125; c=relaxed/simple;
	bh=CWzXW0bIMSURgr0c3IY4/tvstyV6bj1ozJj9dzgjU1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQ8mgffPWoD32Lu22oMBWebvQ2Opc3pRRPkcfWU4MTd7mQztYihgKse+eYhQgQY3tNqSwA/vHyXkY0AABoxQCV23q2gQkjSbsntQKJ9WbgK/u1A7N8/YIhIYnWL3EtWaBrq0GPyhepP6/1FpQZj0C83h31L8UekJYKpcIDGjX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJt4ZVW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3927EC4CED3;
	Wed, 29 Jan 2025 01:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738115124;
	bh=CWzXW0bIMSURgr0c3IY4/tvstyV6bj1ozJj9dzgjU1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tJt4ZVW0p8weQsSPDZjLgTUab4flB9ZDeO3oV5MFy7mrenPn2R71XljjJYKAkhnrm
	 UCkaqQqT+OZAhF0CZcDf6w+z1Qt+gQsQ5OCNAxgM1rmArls+WMymb4Mq830RmFCoKO
	 +qFwvjNxZ5/w+Tx4QkGkdy0DNTUbSSpw6PslUzb5XdvZf0l8UzSKbhwOCZjyb+SnY9
	 q6L5Zj8WJL2S1/bLsi4d6YQV8UUltZT+eHdIQb3MT8SpdgDLFwbf9U5bSybrLtzkIN
	 sufR1bq3uvCWQSqMly5wDlwj2bsOCg3IPtP8q6yZFB3HIxEpMDKVAt03sxW/8L9VE6
	 rHgpPPhwR2yMg==
Date: Wed, 29 Jan 2025 02:45:18 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-hardening@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org
Subject: Re: [RFC v2 00/38] Improve ABI documentation generation
Message-ID: <20250129024518.69c0be81@foz.lan>
In-Reply-To: <87h65i7e87.fsf@trenco.lwn.net>
References: <cover.1738020236.git.mchehab+huawei@kernel.org>
	<87h65i7e87.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 28 Jan 2025 15:42:00 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Hi Jon/Greg,
> >
> > That's the second version of my RFC patches meant to modenize the ABI
> > parser that I wrote in Perl.  
> 
> I have a couple of minor comments on the individual patches, but overall
> I do like this direction.
> 
> It would be nice, though, if the code were a bit more extensively
> commented.  Parts of it get into the "twistly maze of regexes" mode that
> can be awfully hard to follow.

The regex code is indeed complex, but documenting it is not an easy task.
Btw, they are (about) the same that the Perl script does. imported also
the documentation for there. I did some extra cleanups/optimizations there,
though, after checking the results of some expressions.

The big issue is that we don't have an uniform way of defining What: 
expressions. So, each subsystem (and/or author) document it in different
ways.

There are even some ABI symbols with:

	$(readlink)/sys/...

(I intend to send a patch for those later on)

and:

	What: /sys/something/...

	What: .../something_else

(I guess ".../" means "/sys/something/...", but I can't be sure, as this
is on one driver for a hardware I don't have - so, if I send a patch,
I may end breaking it)

If you want to understand how the whole set of regexes work, you can
run:

	$ ./scripts/get_abi.py -d 16 undefined --dry-run >/dev/null
...
	[DEBUG] /sys/kernel/mm/damon/admin/kdamonds/\w+/contexts/\w+/schemes/\w+/quotas/goals/\w+/current_value <== /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/goals/<G>/current_value
	[DEBUG] /sys/kernel/mm/damon/admin/kdamonds/\w+/contexts/\w+/schemes/\w+/quotas/goals/\w+/target_metric <== /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/goals/<G>/target_metric
	[DEBUG] /sys/kernel/mm/damon/admin/kdamonds/\w+/contexts/\w+/schemes/\w+/quotas/goals/\w+/target_value <== /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/goals/<G>/target_value
	[DEBUG] /sys/kernel/mm/damon/admin/kdamonds/\w+/contexts/\w+/schemes/\w+/quotas/goals/nr_goals     <== /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/goals/nr_goals
	[DEBUG] /sys/kernel/mm/damon/admin/kdamonds/\w+/contexts/\w+/schemes/\w+/quotas/ms                 <== /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/ms
	[DEBUG] /sys/kernel/mm/damon/admin/kdamonds/\w+/contexts/\w+/schemes/\w+/quotas/reset_interval_ms  <== /sys/kernel/mm/
...

This will place at stderr all regular expressions that are currently
parsed (they're currently used only for /sys symbols).

Yet, instead of spending too much time documenting them, IMO we shold
do the do the reverse: use the AbiRegex class to convert "What:" into
a new tag (like "Regex:") and use it as much as possible (we'll still
need "What:" for some things that aren't devnodes), as, with regular
expressions, symbols can be clearly documented. As on python match groups
can be named with:

	(?P<name>...)

this could be used to better describe some arguments, e.g. (picking an
easy case):

	What: /sys/module/<MODULENAME>/srcversion

could be described, instead, as:

	Regex: /sys/module/(?P<MODULENAME>[\w\-]+)/srcversion

The Kernel_abi extension (actually AbiParser class) can either display it
as-is (my personal preference), or even replace:
	(?P<MODULENAME>[\w\-]+)
with:
	MODULENAME

and still output this at html/pdf output as before, e. g.:

	What: /sys/module/<MODULENAME>/srcversion

Yet, doing it on a consistent way.

This is easier said than done, as if we do some automatic conversion,
subsystem reviewers/maintainers will need to double-check if the
converted expressions make sense.


> > On this series we have:
> >
> > patches 1 to 11: several bug fixes addressing issues at ABI symbols;  
> 
> 1-3 aren't needed - it seems you already upstreamed #2?
> 
> For the rest, is there any reason to not apply them right away?  They
> just seem like worthwhile fixes.
> 
> > patch 12: a fix for scripts/documentation-file-ref-check
> > patches 13-15: create new script with rest and search logic and 
> >   minimally integrate with kernel_abi Sphinx extension(phase 1);
> > patches 16-19: implement phase 2: class integration (phase 2);
> > patch 20: fix a bug at kernel_abi: the way it splits lines is buggy;
> > patches  21-24: rewrite kernel_abi logic to make it simpler and more
> >   robust;
> > patches 25-27: add cross-reference support at automarkup;
> > patches 28-36: several ABI cleanups to cope with the improvements;
> > patch 37: implement undefined command;
> > patch 38: get rid of the old Perl script.
> >
> > To make it easier to review/apply, I may end breaking the next version
> > on a couple of different patchsets. Still it would be nice to have more
> > people testing it and providing some feedback.  
> 
> I've looked over everything, though with limited depth. 

> My testing hasn't turned up any problems.  

Great!

> I've only tested with current Sphinx,
> have you tried this with the more ancient versions we support?

Not yet, but I double-checked at Sphinx documentation to be sure that
I won't be using any newer methods: I just kept using the same Sphinx
API as used by other extensions at the Kernel.

For instance this loop:

    def do_parse(self, content, node):
        with switch_source_input(self.state, content):
            self.state.nested_parse(content, 0, node, match_titles=1)

was changed on Sphinx 7.4[1], and even nested_parse(match_titles=1) is
not the recommended code for versions < 7.4, as there is this 
replacement function:

	nested_parse_with_titles()

Yet, as they're working fine at least up to version 8.1.3, we can
keep using the old way.

In any case, I'll do a test before sending the final version to see if
it works fine with our minimal version.

[1] See: https://www.sphinx-doc.org/en/master/extdev/markupapi.html

- 

On a separate discussion, I noticed one potential compatibility issue
we may have with future Python versions, due to some ascii texts
formatted as unicode. I'll send later a patch fixing them.

Additionally, automarkup has backward-compatible code with Python 2.7.
 Can I send patches dropping 2.7 support from Sphinx extensions?

> [It's probably time to raise our minimum version again, especially now
> that current Sphinx has better performance.]

Agreed. 

IMO, we should also increase Python's minimal version.

> I don't see a whole lot of reasons not to apply this set shortly after
> the merge window; anybody disagree?

Thanks,
Mauro

