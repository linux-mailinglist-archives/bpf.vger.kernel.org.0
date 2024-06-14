Return-Path: <bpf+bounces-32198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9728B909275
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 20:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F15B24483
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 18:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177841A01AD;
	Fri, 14 Jun 2024 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3gVxdH0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7AB19ADB3;
	Fri, 14 Jun 2024 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390499; cv=none; b=qNeM+TJJjDORGzOJ79u3IhSU1EwH3dL+J0WZDXQsHHbunt7ofumeBvb/XyqGVPdQLk4e5KH+fzBdtWa8s3NKajf2SNHrHs7rEXffdeDin5Fslr47uwZdGOEI3oYSfpvjlTtxkaOzBLec5hEqV1gu7qCOAQ4nWaNTUu6H2kuMh4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390499; c=relaxed/simple;
	bh=eNfNLPou9bpDvL/G8e13RmhlK6Su6AEqPpnIuSsApjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7harG5QmBI9GHjLUigF7fL42lkoTj+/YiWW8MLBcZuH4bF98FJ5mS811uXFgJJ0m5snXtmq8Zq33ASAFKx7zJmV+nvMcg/ct/7XZSpz83QT22rNtw7gJXewnZV9pX3P8/IcuQ8sWEPyx1Jy5j6bhXhTZNlxn+oU6Ma9l3Xctgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3gVxdH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661B1C2BD10;
	Fri, 14 Jun 2024 18:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718390499;
	bh=eNfNLPou9bpDvL/G8e13RmhlK6Su6AEqPpnIuSsApjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3gVxdH0BxA+WtA3scbeVwkYwYzeMkYO4urUszsIfoSrrOwSAJR4DD1R+Jyb56JiH
	 aQkf3M9/+Q7IH8fcqeD8iizadr0rpbvF9Z4dntHG2YQVNsKNgGWXQTqomvTNnrMNo6
	 s6zA63mdxp4BDm7qifjkxCKuYbf1zWfnuSiiHKVJtBYLmv+7pygVw4OVFevo7K/NB/
	 Y1lA2FVJXCgq3XNk6n3jPa/Y65mTlnFFYPePdaQt69IDkf8iyJgtzROZXdWA+FV4k5
	 flfbFxERUJdxWQnpvBZaNj5LlQbyLz8knuqiwnENzhMEI0HT9xZI7Ace64nDYGtnFC
	 IQKKbUsJrhQTg==
Date: Fri, 14 Jun 2024 15:41:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, mic@digikod.net, gnoack@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4] perf trace: BTF-based enum pretty printing
Message-ID: <ZmyO39kNH0gscc5n@x1>
References: <20240613042747.3770204-1-howardchu95@gmail.com>
 <ZmrqQs64TvAt8XjK@x1>
 <ZmrtGuhdMlbssODG@x1>
 <CAH0uvogFih59J1nBQKKM4r2Fc1UA755EoAa01e6MihSd1_QHFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvogFih59J1nBQKKM4r2Fc1UA755EoAa01e6MihSd1_QHFg@mail.gmail.com>

On Thu, Jun 13, 2024 at 11:50:59PM +0800, Howard Chu wrote:
> Thanks for testing and reviewing this patch, and your precious suggestions.

You're welcome
 
> On Thu, Jun 13, 2024 at 8:59 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > On Thu, Jun 13, 2024 at 12:27:47PM +0800, Howard Chu wrote:
> > > > changes in v4:

> > > > - Add enum support to tracepoint arguments

> > > That is cool, but see below the comment as having this as a separate
> > > patch.

> > > Also please, on the patch that introduces ! syscall tracepoint enum args
> > > BTF augmentation include examples of tracepoints being augmented. I'll

> > You did it as a notes for v4, great, I missed that.

> > > try here while testing the patch as-is.

> > The landlock_add_rule continues to work, using the same test program I
> > posted when testing your v1 patch:

> > root@x1:~# perf trace -e landlock_add_rule
> >      0.000 ( 0.016 ms): landlock_add_r/475518 landlock_add_rule(ruleset_fd: 1, rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7ffd790ff690) = -1 EBADFD (File descriptor in bad state)
> >      0.115 ( 0.003 ms): landlock_add_r/475518 landlock_add_rule(ruleset_fd: 2, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7ffd790ff690) = -1 EBADFD (File descriptor in bad state)

> > Now lets try with some of the !syscalls tracepoints with enum args:

> > root@x1:~# perf trace -e timer:hrtimer_start --max-events=5
> >      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff225050, function: 0xffffffff9e22ddd0, expires: 210588861000000, softexpires: 210588861000000, mode: HRTIMER_MODE_ABS)
> > 18446744073709.551 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff2a5050, function: 0xffffffff9e22ddd0, expires: 210588861000000, softexpires: 210588861000000, mode: HRTIMER_MODE_ABS)
> >      0.007 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff325050, function: 0xffffffff9e22ddd0, expires: 210588861000000, softexpires: 210588861000000, mode: HRTIMER_MODE_ABS)
> >      0.007 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff3a5050, function: 0xffffffff9e22ddd0, expires: 210588861000000, softexpires: 210588861000000, mode: HRTIMER_MODE_ABS)
> > 18446744073709.543 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff425050, function: 0xffffffff9e22ddd0, expires: 210588861000000, softexpires: 210588861000000, mode: HRTIMER_MODE_ABS)
> > root@x1:~#

> > Cool, it works!

> > Now lets try and use it with filters, to get something other than HRTIMER_MODE_ABS:

> > root@x1:~# perf trace -e timer:hrtimer_start --filter='mode!=HRTIMER_MODE_ABS' --max-events=5
> > No resolver (strtoul) for "mode" in "timer:hrtimer_start", can't set filter "(mode!=HRTIMER_MODE_ABS) && (common_pid != 475859 && common_pid != 4041)"
> > root@x1:~#

> > oops, that is the next step then :-)
 
> Sure, I will add support for enum filtering(enum string -> int).

Cool
 
> > If I do:

> > root@x1:~# pahole --contains_enumerator=HRTIMER_MODE_ABS
> > enum hrtimer_mode {
> >         HRTIMER_MODE_ABS             = 0,
> >         HRTIMER_MODE_REL             = 1,
> >         HRTIMER_MODE_PINNED          = 2,
> >         HRTIMER_MODE_SOFT            = 4,
> >         HRTIMER_MODE_HARD            = 8,
> >         HRTIMER_MODE_ABS_PINNED      = 2,
> >         HRTIMER_MODE_REL_PINNED      = 3,
> >         HRTIMER_MODE_ABS_SOFT        = 4,
> >         HRTIMER_MODE_REL_SOFT        = 5,
> >         HRTIMER_MODE_ABS_PINNED_SOFT = 6,
> >         HRTIMER_MODE_REL_PINNED_SOFT = 7,
> >         HRTIMER_MODE_ABS_HARD        = 8,
> >         HRTIMER_MODE_REL_HARD        = 9,
> >         HRTIMER_MODE_ABS_PINNED_HARD = 10,
> >         HRTIMER_MODE_REL_PINNED_HARD = 11,
> > }
> > root@x1:~#

> > And then use the value for HRTIMER_MODE_ABS instead:

> > root@x1:~# perf trace -e timer:hrtimer_start --filter='mode!=0' --max-events=1
> >      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff225050, function: 0xffffffff9e22ddd0, expires: 210759990000000, softexpires: 210759990000000, mode: HRTIMER_MODE_ABS_PINNED_HARD)
> > root@x1:~#

> > Now also filtering HRTIMER_MODE_ABS_PINNED_HARD:

> > root@x1:~# perf trace -e timer:hrtimer_start --filter='mode!=0 && mode != 10' --max-events=2
> >      0.000 podman/178137 timer:hrtimer_start(hrtimer: 0xffffa2024468fda8, function: 0xffffffff9e2170c0, expires: 210886679225214, softexpires: 210886679175214, mode: HRTIMER_MODE_REL)
> >     32.935 podman/5046 timer:hrtimer_start(hrtimer: 0xffffa20244fabc40, function: 0xffffffff9e2170c0, expires: 210886712159707, softexpires: 210886712109707, mode: HRTIMER_MODE_REL)
> > root@x1:~#

> > But this then should be a _third_ patch :-)
> 
> Sure.

> > We're making progress!
 
> > See the comment about evsel__init_tp_arg_scnprintf() below. Also please
> > do patches on top of previous work, i.e. the v3 patch should be a
> > separate patch and this v4 should add the extra functionality, i.e. the
> > support for !syscall tracepoint enum BTF augmentation.
 
> Thank you for suggesting this. May I ask if this is saying that v3 and
> v4 should all be separated?

Yes, I suggest you extract from v4 the updated contents of v3 and have
it as a "perf trace: Augment enum syscall arguments with BTF", have the
examples of such syscalls before and after.

Then have another patch, that assumes that first patch with the fix and
the "perf trace: Augment enum syscall arguments with BTF" are applied
that will add support for augmenting non-syscall tracepoints with enum
arguments with BTF.
 
> > The convention here is that evsel__ is the "class" name, so the first
> > arg is a 'struct evsel *', if you really were transforming this into a
> > 'struct trace' specific "method" you would change the name of the C
> > function to 'trace__init_tp_arg_scnprintf'.
 
> Oops, my bad. Thanks for pointing it out.
 
> > But in this case instead of passing the 'struct trace' pointer all the
> > way down we should instead pass a 'bool *use_btf' argument, making it:

> > static int evsel__init_tp_arg_scnprintf(struct evsel *evsel, bool *use_btf)
 
> You are right, we should do that. Thanks for pointing out this silly
> implementation. I think we should do the same for
> syscall__set_arg_fmts(struct trace *trace, struct syscall *sc) as
> well. Also, I forgot to delete the unused 'bool use_btf' in struct
> syscall, I will delete it.
>
> > Then, when evlist__set_syscall_tp_fields(evlist, &use_btf) returns,
> > check that use_btf to check if we need to call
> > trace__load_vmlinux_btf(trace).
 
> > And when someone suggests you do something and you implement it, a
> > Suggested-by: tag is as documented in:

> > ⬢[acme@toolbox perf-tools-next]$ grep -A5 Suggested-by Documentation/process/submitting-patches.rst
> > Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
 
> > A Suggested-by: tag indicates that the patch idea is suggested by the person
> > named and ensures credit to the person for the idea. Please note that this
> > tag should not be added without the reporter's permission
 
> May I ask if you want a Suggested-by? Hats off to you sir.

yes, it is appropriate in this case.
 
> Also, do you want me to do the fixes on evsel__init_tp_arg_scnprintf()

If its separate from what you are doing, yes, you do the fix then
continue with the new features.

> for tracepoint enum, and send it as v5, or just send a separate patch
> for tracepoint enum, so we get a patch for syscall enum, and another
> patch for tracepoint enum? Sorry to bother you on these trivial
> things.

> Thanks again for this detailed review, and valuable suggestions.

- Arnaldo

