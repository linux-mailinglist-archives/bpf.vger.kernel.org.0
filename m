Return-Path: <bpf+bounces-73079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BADBDC22760
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 22:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F8F54EF7B1
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 21:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C573524D1;
	Thu, 30 Oct 2025 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqnWu/SL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437462620C3
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 21:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860891; cv=none; b=OY0xFEXqVtUEooe8wIQroGU+MURe0mkzcQ+17YQBs2gBc4LV04cgRgaFxtiqsT4bgrD8jEo+GE6KzlhvVTIwBbj0YET9d5FgQlXZLjuHTXl/5L4BpjvSY3Uj+XQZaXssIzoyYBxJw7cyKh7Azi7o42mWl4sy0Bs228uByBl++iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860891; c=relaxed/simple;
	bh=qtDHxxoTJEWK6sajeFnub9aVCYf5UX0w2uwpoVn66QU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfJxT3nLiFx6Rt3wCR93BENDCpUzJUjlP+Wrwwaw/TzS+RSrbglehbU/+5aXRCiAXjT20muPXCJoiAWhbiuQGH2Me6bROkkaNeboj2C/jYV5FU0V1xn2vT9/ncujnbEs8t1Ph/ReYIg8whfC9jmvQEq+Zy0XTPSW6BgJieBV6bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqnWu/SL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4270a3464bcso1196417f8f.2
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 14:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761860886; x=1762465686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9zdtajZahxIouVQ7BZgQHFNhqJxmMsIC/KMsmOx1Lqs=;
        b=YqnWu/SLwqT7BZyLLepbq4v5fXnyzyPp0wQJEW9NfH2x7BYS6qc5o7/nX3FXl+uV8y
         efnb0LA0aQr3e4Z2KAYmWjsXK2xTHA8OJm1dlsHvCchUfZ1VJgwaT3LxucbT1oJw1Erj
         w2JjNr3hY/70zIVTR9uRYr66D2/ovNjzIYvBQKL62T6oykC84dkSkAa5YeReBsy9i22W
         CqJZIq29s+t+L6Gh2A4CeZ52gBkh8Pa1EIKMKEzk5HlaOB9shFOtHeMw6UVvTMO/DHH5
         0rm4jLY/DHf9k3ZymG+IGV7Sljvgmy4GxGTHEYiZzt0QtkB0T9fEmq8PJJet/6d/E39J
         kPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761860886; x=1762465686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zdtajZahxIouVQ7BZgQHFNhqJxmMsIC/KMsmOx1Lqs=;
        b=c9PSFlIgdJecmELI+fqY3v0U0ur4vCbcM4/4i22Qn8P7p7U4ZfwRbmAuNBkKchrzQW
         T2PzAoNqyW9S11XrP5S1cPJbAFijkkfZRYcD74bB3LU8flwlBK3CaW2PgMm36ebn7clv
         8osrzVgylrjZ8r5BTVyBa4yQA99GSNtI8ZvuzwCFbGT3UlCt+ws4nXgGU0/JzX0p4IcP
         hqwmhkKMRQGpcG0oKQlJKaaoMJRidA8vdZTDB0RC9+WoSjsPp5eItBj0sGbM9Vgst9XL
         NVfof3BDfIN0wvPYY6KDqct9tsOQ4V5TWO8Oy2Y3uqzjNoffq/laEXSwBANDnwBFMV9t
         aGgg==
X-Forwarded-Encrypted: i=1; AJvYcCUo0pEex7Ou1f+TV80oFu2FdwHcbqtYhigeqmqPZxA+A2SyPaIigXWLKQRH7BSUNObdlpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWkOO7x/58DlgJ5S6Hy7/DcstjamOfCXHTFCp28q/I/m9Kt8UU
	Ry9iOuCwWhbVKBieVrwmDNJsjBdSz1h1BluxwDapyRygRGDZOvFKYACu
X-Gm-Gg: ASbGnctAFUCVhfF2Vdnyf235PPbLcuYMXehWapKDyCdnpu0G9oqyo3y0K0FDqIn+3/q
	669Cl8SrzAMo2mBTiinyFU7S4bi7TFlcpt7ZThr/7kP9HDHgkCdMfpoKE4KYQZunEQD3nXrTf2f
	DVSLohdYP3U5nRqH+Azv1uV2nUHO4+28ZsstWK22UBa3h8myAWJcgeNpab1mfUlRz06GMJqsGLm
	qq1Kft3EDB670EQfa+YPJmHgjIh/K1c93JJgzwN35vEjmyySoUKxd3I0rSckZI71l/yS0hUWP/F
	XSBMRZkRPPd0mLUxTz5OW9hJYY65CGi8OJgaagxH8tSZfHaZ3TBABAwTUG5lotPESr8HVeKVClm
	sjJ6uvai0sqDEC+2cvoz91K2ah+YvyjsNxA/y5KqdEJzxsm7QI9wePbXfq8bszbea
X-Google-Smtp-Source: AGHT+IHpgIVwSKRX64ItacGOvKG5O7LOYeM0likkg9tQz3SPg+zELqpevWEhOftGbLR0IwXfs1b9eA==
X-Received: by 2002:a05:6000:40df:b0:428:52d1:73ab with SMTP id ffacd0b85a97d-429bd6c1716mr960254f8f.58.1761860886262;
        Thu, 30 Oct 2025 14:48:06 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de971sm33498892f8f.39.2025.10.30.14.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:48:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 30 Oct 2025 22:48:03 +0100
To: Jiri Olsa <olsajiri@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bot+bpf-ci@kernel.org, mhiramat@kernel.org, rostedt@goodmis.org,
	song@kernel.org, peterz@infradead.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, yhs@fb.com,
	songliubraving@fb.com, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 1/3] Revert "perf/x86: Always store regs->ip in
 perf_callchain_kernel()"
Message-ID: <aQPdE7_yPO8HOwMC@krava>
References: <20251027131354.1984006-2-jolsa@kernel.org>
 <8227ad3af501bb982231ef00ac5e970a0a12c9d64e07ea3f3d37100ec7e3f1cc@mail.kernel.org>
 <v53j2leswscyunqmrj5zvr3bsdafxlze5z3yp4hvsd6epbvdvm@njx4yhpkqoiz>
 <aP_0eh7TH2f_ykhz@krava>
 <xnx66p7w3qstst4ixj356dnzexrpsjy52tfwthp5kytv5yagcf@4ngtq5rrgqzj>
 <aQG_calHM0E7ou67@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQG_calHM0E7ou67@krava>

On Wed, Oct 29, 2025 at 08:17:05AM +0100, Jiri Olsa wrote:
> On Tue, Oct 28, 2025 at 08:39:33PM -0700, Josh Poimboeuf wrote:
> > On Mon, Oct 27, 2025 at 11:38:50PM +0100, Jiri Olsa wrote:
> > > On Mon, Oct 27, 2025 at 01:19:52PM -0700, Josh Poimboeuf wrote:
> > > > On Mon, Oct 27, 2025 at 01:52:18PM +0000, bot+bpf-ci@kernel.org wrote:
> > > > > Does this revert re-introduce the BPF selftest failure that was fixed in
> > > > > 2019? The test tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
> > > > > still exists in the kernel tree.
> > > > 
> > > > I have the same question.  And note there may be subtle differences
> > > > between the frame pointer and ORC unwinders.  The testcase would need to
> > > > pass for both.
> > > 
> > > as I wrote in the other email that test does not check ips directly,
> > > it just compare stacks taken from bpf_get_stackid and bpf_get_stack
> > > helpers.. so it passes for both orc and frame pointer unwinder
> > 
> > Ok.  So the original fix wasn't actually a fix at all?  It would be good
> > to understand that and mention it in the commit log.  Otherwise it's not
> > clear why it's ok to revert a fix with no real explanation.
> 
> I think it was a fix when it was pushed 6 years ago, but some
> unwind change along that time made it redundant, I'll try to
> find what the change was

hum I can't tell what changed since v5.2 (kernel version when [1] landed)
that reverted the behaviour which the [1] commit was fixing

I did the test for both orc and framepointer unwind with and without the
fix (revert of [1]) and except for the initial entry it does not seem to
change the rest of the unwind ... though I'd expect orc unwind to have
more entries

please check results below

any idea? thanks,
jirka


[1] 83f44ae0f8af perf/x86: Always store regs->ip in perf_callchain_kernel()
[2] ae6a45a08689 x86/unwind/orc: Fall back to using frame pointers for generated code
---
framepointer + fix:

        bpf_prog_2beb79c650d605dd_rawtracepoint_bpf_testmod_test_read_1+324
        bpf_trace_run2+216
        __bpf_trace_bpf_testmod_test_read+13
        bpf_testmod_test_read+1322
        sysfs_kf_bin_read+103
        kernfs_fop_read_iter+243
        vfs_read+549
        ksys_read+115
        __x64_sys_read+29
        x64_sys_call+6112
        do_syscall_64+133
        entry_SYSCALL_64_after_hwframe+118

framepointer withtout fix:

        bpf_prog_2beb79c650d605dd_rawtracepoint_bpf_testmod_test_read_1+324
        bpf_prog_2beb79c650d605dd_rawtracepoint_bpf_testmod_test_read_1+324
        bpf_trace_run2+216
        __bpf_trace_bpf_testmod_test_read+13
        bpf_testmod_test_read+1322
        sysfs_kf_bin_read+103
        kernfs_fop_read_iter+243
        vfs_read+549
        ksys_read+115
        __x64_sys_read+29
        x64_sys_call+6112
        do_syscall_64+133
        entry_SYSCALL_64_after_hwframe+118


orc + fix:

        bpf_prog_2beb79c650d605dd_rawtracepoint_bpf_testmod_test_read_1+324
        bpf_trace_run2+214
        bpf_testmod_test_read+1322
        kernfs_fop_read_iter+228
        vfs_read+550
        ksys_read+112
        do_syscall_64+133
        entry_SYSCALL_64_after_hwframe+118


orc without fix:

        bpf_prog_2beb79c650d605dd_rawtracepoint_bpf_testmod_test_read_1+324
        bpf_prog_2beb79c650d605dd_rawtracepoint_bpf_testmod_test_read_1+324
        bpf_trace_run2+214
        bpf_testmod_test_read+1322
        kernfs_fop_read_iter+228
        vfs_read+550
        ksys_read+112
        do_syscall_64+133
        entry_SYSCALL_64_after_hwframe+118

