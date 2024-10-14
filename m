Return-Path: <bpf+bounces-41890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F90D99D9D1
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 00:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2E51F2252C
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 22:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF011D365A;
	Mon, 14 Oct 2024 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Iqkn3Wiv"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBDC1CF2AF
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945284; cv=none; b=ttC2ohG5oiYE8NsY8kBd+8sBnBHCtPmpKLM1oWI+gclBypNuZxoYW7XjIj7v48yZZtjsyRPYwo/Ozx943eVsNwoIrcAKiFDh0iHzWA9zSg7/D5lvGn22OXiYhoJJP44SjOk+TUWEw6g/m9ltSvJAfxDbSMULe1aZ66hOB+qJ0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945284; c=relaxed/simple;
	bh=0svh9Uot8vREZKTrMbrDMI2/+fvvVG4XSf//0Rw2jkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8DPLei4iMNrZsTLoQ1Kp3c/OfDY5NmStqajyv4km9tXY/yk/xyHgp/PJd2TPjbObc9T5ocr5KAnWx+xOOHOn+Ui6865hZIaxccIh8SH/aPlb9nKLxG1z+wmQWI6KP7FlhN9JHEMCnk47sZuKqvx8F8RjZ89suFCz8pgqgl2oUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Iqkn3Wiv; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ebd6486a-f4b8-40c7-9221-86d1a97c6adb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728945279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIBWRVchPRccvlCmxWKjuSOmpx3Nqox2GMVKFrMi5s4=;
	b=Iqkn3WivAiA3hZpoeofAP+PFOofRDWyMh31/E/XYt4cUZdNcmpcqH9yZcsVVg6VEYbZXqj
	F2JBfN40R7k7BcHJp3pvj2GlsGa7tqPL4CrdgHFnD6iSpSDGDf/1f7h4L14hPm3mtBQjcW
	1lbIEefpqXcRwgEw/xdJ5QcKvV6ZHGw=
Date: Mon, 14 Oct 2024 15:34:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] tools/resolve_btfids: Fix 'variable' may be used
 uninitialized warnings
Content-Language: en-GB
To: Eder Zulian <ezulian@redhat.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, acme@redhat.com, vmalik@redhat.com,
 williams@redhat.com
References: <20241011200005.1422103-1-ezulian@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241011200005.1422103-1-ezulian@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/11/24 1:00 PM, Eder Zulian wrote:
> - tools/bpf/resolve_btfids/main.c: Initialize 'set' and 'set8' pointers
>    to NULL in to fix compiler warnings.
>
> - tools/lib/bpf/btf_dump.c: Initialize 'new_off' and 'pad_bits' to 0 and
>    'pad_type' to  NULL to prevent compiler warnings.
>
> - tools/lib/subcmd/parse-options.c: Initiazlide pointer 'o' to NULL
>    avoiding a compiler warning.
>
> Tested on x86_64 with clang version 17.0.6 and gcc (GCC) 13.3.1.
>
> $ cd tools/bpf/resolve_btfids
> $ for c in gcc clang; do \
> for o in fast g s z $(seq 0 3); do \
> make clean && \
> make HOST_CC=${c} "HOSTCFLAGS=-O${o} -Wall" 2>&1 | tee ${c}-O${o}.out; \
> done; done && grep 'warning:\|error:' *.out
>
> [...]
> clang-O1.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
> clang-O1.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
> clang-O2.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
> clang-O2.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
> clang-O3.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
> clang-O3.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
> clang-Ofast.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
> clang-Ofast.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
> clang-Og.out:btf_dump.c:903:42: error: ‘new_off’ may be used uninitialized [-Werror=maybe-uninitialized]
> clang-Og.out:btf_dump.c:917:25: error: ‘pad_type’ may be used uninitialized [-Werror=maybe-uninitialized]
> clang-Og.out:btf_dump.c:930:20: error: ‘pad_bits’ may be used uninitialized [-Werror=maybe-uninitialized]
> clang-Os.out:parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
> clang-Oz.out:parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
> gcc-O1.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
> gcc-O1.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
> gcc-O2.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
> gcc-O2.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
> gcc-O3.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
> gcc-O3.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
> gcc-Ofast.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
> gcc-Ofast.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
> gcc-Og.out:btf_dump.c:903:42: error: ‘new_off’ may be used uninitialized [-Werror=maybe-uninitialized]
> gcc-Og.out:btf_dump.c:917:25: error: ‘pad_type’ may be used uninitialized [-Werror=maybe-uninitialized]
> gcc-Og.out:btf_dump.c:930:20: error: ‘pad_bits’ may be used uninitialized [-Werror=maybe-uninitialized]
> gcc-Os.out:parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
> gcc-Oz.out:parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
>
> The above warnings and/or errors are not observed after applying this
> patch.
>
> Signed-off-by: Eder Zulian <ezulian@redhat.com>

Currently compilation is okay although it uses -O0.

One choice is to move from -O0 to -O2 and fix corresponding -Wmaybe-uninitialized issues.
Otherwise, since there is no bug, not sure whether we should make changes or not.
Maintainers can decide the next step.


