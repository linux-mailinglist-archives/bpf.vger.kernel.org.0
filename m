Return-Path: <bpf+bounces-43779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C619B9904
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 203BDB2116C
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F8B1D365A;
	Fri,  1 Nov 2024 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKfmOGdP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917671CACF2;
	Fri,  1 Nov 2024 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490722; cv=none; b=M1XVkm4Isw/5jkiWXWvnhfVghREH4F0lI5cCwuxs7ROVU2/HhWBb+Y8LrvH1F5ms/AqRcKop4x6MNl2SLVmwKew7940tAQliXy4K6ZAEKwURHQz4TYYkjYyN+6UbQOBKbBuAtoIVFjmVKSyEIysJc4f9fDuvUZ9uJMIR1WU9U3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490722; c=relaxed/simple;
	bh=U4MvWnH9l3Nyr17zfp+s14ncaolIsfqLhW8jCtTo6YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7TPKTNVsPiHuvT+/LenT9W16KFkUrUgS061ed8Dxa4A3cJHZeYKCiHtDqLQfA31WFbpRW4P0KQat1Ih30fIR0Tzb3XUvk2eqYMZWPVdV+xeef4Ny4NqwmSwcvMAsxcfIW147CMx3WvVMQkU7WIKfcoK9teoFhGFgci4FhVEQKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKfmOGdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B31EC4CECD;
	Fri,  1 Nov 2024 19:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730490722;
	bh=U4MvWnH9l3Nyr17zfp+s14ncaolIsfqLhW8jCtTo6YE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKfmOGdPUxeCjNHZg25uglySAbe4J5DQLd6ad47Z6b7myndt/NxXB3tbg0h/hL+P+
	 rGQDA23X9h+MHcxXj71nkImwwJaPoegIzdIWR7mZuQsMzTLbyqOzhDYpr3mAjSfg9P
	 vpPalyU5hpLaA5If2UJTc/vLbdZL8H22YRgvIBxEWWnfkV/CwsKwR/yzcf5knrWgut
	 3Ge/5Pygra2hvKFsDQEOkj6RlJHTy5un/YgWfE3euDTMKgLtP47vQJFuQtsvOXuIM+
	 dx11dcl09AIXYl3/+Pf1CuT8Sc6DjS8al68K4Iqld8Z94xCCRqAkWg2R+nhrprE7YT
	 uzNzWR01xapKA==
Date: Fri, 1 Nov 2024 12:51:59 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241101195159.6rf7ubde2wmymhpb@jpoimboe>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>
 <20241030055314.2vg55ychg5osleja@treble.attlocal.net>
 <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
 <20241031230313.ubybve4r7mlbcbuu@jpoimboe>
 <CAEf4BzaQYqPfe2Qb5n71JVAAD3-1Q7q2+_cnQMQEa43DvV5PCQ@mail.gmail.com>
 <20241101192937.opf4cbsfaxwixgbm@jpoimboe>
 <CAEf4Bza6QZt=N8=O7NU3saHpJ_XrXRdGn48gVJMN+kawurNP3g@mail.gmail.com>
 <CAEf4BzZvhuUeGYbo1Nesfdx3=-WAkAT2OjSdtE4tfRV7H7PZoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZvhuUeGYbo1Nesfdx3=-WAkAT2OjSdtE4tfRV7H7PZoQ@mail.gmail.com>

On Fri, Nov 01, 2024 at 12:46:09PM -0700, Andrii Nakryiko wrote:
> On Fri, Nov 1, 2024 at 12:44 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Nov 1, 2024 at 12:29 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > >
> > > On Fri, Nov 01, 2024 at 11:34:48AM -0700, Andrii Nakryiko wrote:
> > > > 00200000-170ad000 r--p 00000000 07:01 5
> > > > 172ac000-498e7000 r-xp 16eac000 07:01 5
> > > > 49ae7000-49b8b000 r--p 494e7000 07:01 5
> > > > 49d8b000-4a228000 rw-p 4958b000 07:01 5
> > > > 4a228000-4c677000 rw-p 00000000 00:00 0
> > > > 4c800000-4ca00000 r-xp 49c00000 07:01 5
> > > > 4ca00000-4f600000 r-xp 49e00000 07:01 5
> > > > 4f600000-5b270000 r-xp 4ca00000 07:01 5
> > > >
> 
> I should have maybe posted this in this form:
> 
> 00200000-170ad000 r--p 00000000 07:01 5  /packages/obfuscated_file
> 172ac000-498e7000 r-xp 16eac000 07:01 5  /packages/obfuscated_file
> 49ae7000-49b8b000 r--p 494e7000 07:01 5  /packages/obfuscated_file
> 49d8b000-4a228000 rw-p 4958b000 07:01 5  /packages/obfuscated_file
> 4a228000-4c677000 rw-p 00000000 00:00 0
> 4c800000-4ca00000 r-xp 49c00000 07:01 5  /packages/obfuscated_file
> 4ca00000-4f600000 r-xp 49e00000 07:01 5  /packages/obfuscated_file
> 4f600000-5b270000 r-xp 4ca00000 07:01 5  /packages/obfuscated_file
> 
> Those paths are pointing to the same binary.

Ok, thanks for sharing that.  I'll add in support for noncontiguous
text.

-- 
Josh

