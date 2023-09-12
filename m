Return-Path: <bpf+bounces-9789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5497079DA82
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D274281CF5
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 21:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C17B659;
	Tue, 12 Sep 2023 21:03:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1623B8
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 21:03:37 +0000 (UTC)
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31F6199;
	Tue, 12 Sep 2023 14:03:36 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::e2d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1C6A835F;
	Tue, 12 Sep 2023 21:03:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1C6A835F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1694552616; bh=SSAzwh1tnDrXl1M/+o/bZ/L2hYeqt2O/VVxB3bIyHmg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TuO+4D0PzRhG+DW7unB1FLksenos5iftQBkayTrzYKNCCz871oCH98Wc992FRYPtj
	 jaauzWR6a/pyjQMM5rU8bxnl2sgqDgB3ydTZ/ylwVNDWXnbpdaRukPb4Fw8hYtro5n
	 p+HjkQhaVXOtbKHRK3GvZPjsGK7IOEYz40atzKN/2b2twKQESEKmf6jpl+Akk8rEXX
	 TgknuAxOjXCHnjPaQwtF7xzuy8pToOd/vXDxJv+hCCtUeH0lETgL2RdtybQCi6szNb
	 UWmPZfW+/9jxgLTZPCaaz2myM9zL2O+8WcSvqwCdJPP5WfFnuF4QncBZULW9EwRcvD
	 jJnTmWQq6YAVw==
From: Jonathan Corbet <corbet@lwn.net>
To: Benjamin Gray <bgray@linux.ibm.com>, linux-ia64@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 llvm@lists.linux.dev, linux-pm@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten
 <hsweeten@visionengravers.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, Jan
 Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 Todd E Brandt <todd.e.brandt@linux.intel.com>, Andrii Nakryiko
 <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>
Subject: Re: [PATCH v2 2/7] Documentation/sphinx: fix Python string escapes
In-Reply-To: <20230912060801.95533-3-bgray@linux.ibm.com>
References: <20230912060801.95533-1-bgray@linux.ibm.com>
 <20230912060801.95533-3-bgray@linux.ibm.com>
Date: Tue, 12 Sep 2023 15:03:35 -0600
Message-ID: <874jjzhzo8.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benjamin Gray <bgray@linux.ibm.com> writes:

> Python 3.6 introduced a DeprecationWarning for invalid escape sequences.
> This is upgraded to a SyntaxWarning in Python 3.12, and will eventually
> be a syntax error.
>
> Fix these now to get ahead of it before it's an error.
>
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> ---
>  Documentation/sphinx/cdomain.py             | 2 +-
>  Documentation/sphinx/kernel_abi.py          | 2 +-
>  Documentation/sphinx/kernel_feat.py         | 2 +-
>  Documentation/sphinx/kerneldoc.py           | 2 +-
>  Documentation/sphinx/maintainers_include.py | 8 ++++----
>  5 files changed, 8 insertions(+), 8 deletions(-)

I've applied this one to the docs tree, thanks.

jon

