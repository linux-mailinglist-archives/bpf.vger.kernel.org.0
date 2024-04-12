Return-Path: <bpf+bounces-26654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48EF8A374C
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 22:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40CB0B224C1
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 20:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18C5482C1;
	Fri, 12 Apr 2024 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDl9ufB4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550383F9E0;
	Fri, 12 Apr 2024 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955146; cv=none; b=s4Y0cXw1vDVIKMTW4mIMQUl9y+NnYSKIYpfgTVBhcTKLcYNma7OaLrJC22nUUQAPdRUR9RFQTonHY3LwSwVROedY0AVIqwNzGEWqGy2XBEjy/6cUW1rq3u3x2baSWUSIG/6wcO61agYvEkxnZq6Z+8v3/xwhZci5SZ41Mlmx/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955146; c=relaxed/simple;
	bh=9VR+EMdsvM+WGe+zuTXXUWxuK3h8e/TNNnEiaHfUVho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+KB+4xEgMe46by7HikwRKKdzr6N8RrDCzcoExlJbiE+6rqe3Qq4seQQg1SpAxEux8VxKuuKUoQlkeFlUybTy3CSpvuS6S046rIGP0brjLAGhmGyAHoQ+e7lvmLNpAw7iKRx+/pEo8EwnGXKkt8tdGw/bRB6GZwHIidtDvGUgn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDl9ufB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E28EC113CC;
	Fri, 12 Apr 2024 20:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712955145;
	bh=9VR+EMdsvM+WGe+zuTXXUWxuK3h8e/TNNnEiaHfUVho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dDl9ufB4pOPMR954EaVyoqW/ePbx13SJIc00VvHo4qZI/gtdxLIRvsXv5fJZcrkBl
	 C2kKSDohBHyHGPJEunt0axpZIib5DtmH1R4xabtILoGSsSMKe6k8M6xh9IJ9aJt8rY
	 b6XkXHhRkylK/QqEh0SCh5I4GpoVCv/2xN+WtMhzJi8jUOHU10qNaMiMxqlDWOoF81
	 VzES6lLzhk9n4YYI6UwDmYQoSg8r4fDAqjkm7vZ6BzHQ7M1zejI3UMtVO1UorTV9v0
	 1VpXMOVZxyDp51Wl6yi8BONMBkfWfiPMr0RwSVl1evszS8u4yCYXvUcZl4TYxAM5C9
	 RBHRgoYuogFoQ==
Date: Fri, 12 Apr 2024 17:52:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf bench uprobe: Remove lib64 from libc.so.6
 binary path
Message-ID: <ZhmfBl9_C1fMhR3z@x1>
References: <20240406040911.1603801-1-irogers@google.com>
 <ZhY8xzVJ6_9BI-Vd@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhY8xzVJ6_9BI-Vd@krava>

On Wed, Apr 10, 2024 at 09:18:44AM +0200, Jiri Olsa wrote:
> On Fri, Apr 05, 2024 at 09:09:10PM -0700, Ian Rogers wrote:
> > bpf_program__attach_uprobe_opts will search LD_LIBRARY_PATH and so
> > specifying `/lib64` is unnecessary and causes failures for libc.so.6
> > paths like `/lib/x86_64-linux-gnu/libc.so.6`.
> > 
> > Fixes: 7b47623b8cae ("perf bench uprobe trace_printk: Add entry attaching an BPF program that does a trace_printk")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> patchset lgtm
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied it to the series, b4 picked it just for this patch.

I tried to convince Konstantin to look for "patchset lgtm", "for the
series", but for now we need to do it manually :-)

- Arnaldo

