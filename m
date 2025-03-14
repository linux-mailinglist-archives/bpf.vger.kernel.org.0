Return-Path: <bpf+bounces-54059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56829A61715
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 18:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49FE81B60A93
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 17:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2354E204582;
	Fri, 14 Mar 2025 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS8OqIP7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC4F1FDA89;
	Fri, 14 Mar 2025 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972006; cv=none; b=QXC9ne4tcrlOL6g5qcKNLXBov5ch368Stg02sTTlcTjbSUcGKqVso0moci5c+E4cgXSdXw5OZOJ5LE3a5wrJOEbYK794Vuwwrc42efzCAT2kHBu/mvMxwIGzCqXw26Z/z+WjzRjOVPaEsgqlKH6MM2p3BgQruSG+zpEoYf6DKDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972006; c=relaxed/simple;
	bh=iDOL+Pgf68XI5fMo87a+IqebfJjceVppGD9rKghIMl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTXiqH1Dsx4/HTcJY6GJ4l9DD8CEiNZQuzyNzXik94OoeNvQ6rd7GdxCaF3rZf8SGovRkdyQqZSJ8jLIfKo4ceHIjHIO8HJzYb3HcnLHO9JDi6+uynVBmubd2fX1QcXkJCUYuVVs7+jDKCj7eq/e9sSGKqt66RY76I+idl4kKQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS8OqIP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B19C4CEEC;
	Fri, 14 Mar 2025 17:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741972006;
	bh=iDOL+Pgf68XI5fMo87a+IqebfJjceVppGD9rKghIMl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bS8OqIP7wINdAElZjuT/hg4AKOH+7zMy69HXrKw1kajUHeonYJkDLGZkiEUO5HbXD
	 PRuDcvr2agaJwkzm/UEfYIuEJmjqvCd91E4ucyh7eR+KhY5gQEWI/yQT6j0XJNOjsZ
	 /DQvBOyEyuKgYMx4sBbJjLu7K0Kuf7F91JI8j2Z1n1mAOwHsBmWbT8L8vvANd3rRiz
	 igGUZz+9IWMxSgdW7hJIfprfp22mK7MCnI2BzD2IezhtZ7SQKRuP0u2SZDlD43fYOR
	 rvVjYp4mL3UCbPqoCha98OkbDhYfazjV9w0ViNeYzx1F3sv35lb9DNlTCTvtMYTcOW
	 0U388YuYtIedA==
Date: Fri, 14 Mar 2025 14:06:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Changbin Du <changbin.du@huawei.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH v2 00/17] Support dynamic opening of capstone/llvm remove
 BUILD_NONDISTRO
Message-ID: <Z9RiI9yjpMUPRYZe@x1>
References: <20250122062332.577009-1-irogers@google.com>
 <Z5K712McgLXkN6aR@google.com>
 <CAP-5=fX2n4nCTcSXY9+jU--X010hS9Q-chBWcwEyDzEV05D=FQ@mail.gmail.com>
 <CAP-5=fUHLP-vtktodVuvMEbOd+TfQPPndkajT=WNf3Mc4VEZaA@mail.gmail.com>
 <CAP-5=fV_z+Ev=wDt+QDwx8GTNXNQH30H5KXzaUXQBOG1Mb8hJg@mail.gmail.com>
 <Z9NbFqaDQMjvYxcc@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9NbFqaDQMjvYxcc@google.com>

On Thu, Mar 13, 2025 at 03:24:22PM -0700, Namhyung Kim wrote:
> I think #ifdef placements is not a big deal, but I still don't want to
> pull libcapstone details into the perf tree.
 
> For LLVM, I think you should to build llvm-c-helpers anyway which means
> you still need LLVM headers and don't need to redefine the structures.
 
> Can we do the same for capstone?  I think it's best to use capstone
> headers directly and add a build option to use dlopen().

My two cents: if one wants to support some library, then have its devel
packages available at build time.

Then, perf nowadays has lots of dependencies, we need to rein on that,
making the good to have but not always used things to be dlopen'ed.

Like we did with gtk (that at this point I think is really deprecated,
BTW).

gdb has prior art in this area that we could use, it is not even a TUI
but it asks if debuginfo should be used and if so it goes on on
potentially lenghty updates of the local buildid cache they keep (which
is not the one we use, it should be).

And in the recent discussion with Dmitry Vyukov the possibility doing a
question to the user about a default behaviour to be set and then using
.perfconfig not to bother anymore the user about things is part of
helping the user to deal with the myriad possibilites perf offers.

gdb could use that as well, why ask at every session if debuginfod
should be used? Annoying.

I think perf should try to use what is available, both at build and at
run time, and it shouldn't change the way it output things, but should
warn the user about recent developments, things we over time figured out
are problematic and thus a new default would be better, but then obtain
consent if the user cares about it, and allow for backtracking, to go
and change .perfconfig when the user realises the old output/behaviour
is not really nice.

But keeping the grass green as it used to be should be the priority.

- Arnaldo

