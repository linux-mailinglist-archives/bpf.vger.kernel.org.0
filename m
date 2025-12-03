Return-Path: <bpf+bounces-75979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 304D6CA0170
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 17:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 154123009816
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D63361DBB;
	Wed,  3 Dec 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMJmOKBS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2E35FF46;
	Wed,  3 Dec 2025 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780201; cv=none; b=CqpeglVf0keKRXA6I+G0M7+pmoO4sl/tV+FIshcu+5f99t2Hulr7nAVj3RLfID+qLHpGxCdxZcGuhQC0qLvY8dwx3F1RuFDwaqhLEJ4j2B0JbpGGoUvaRyUe45a5F7pY+q0PQcvJK3t8Vl7la/YcMftPj+NRrO6rv1Znf+8IauM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780201; c=relaxed/simple;
	bh=1XNQS0lbn9FevDFX+NqC8EFfjK6r037ERyxzwj6yRtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvWNd1mrXy6u/qJsOIOsTpaCUiJJqFrUaOwkASsG/Pak8hkB8580wTRQngM+8854lq44PR/1GXedcxMeL7cjnavoPGw/01S4cJaLjhzn7VbO0YzpkAlwWuHLyIB5V1Ku6kOnn31pD5QoWnOibCwAiiTzQk7JQh3TGbd84gRj7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMJmOKBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB3FC4CEF5;
	Wed,  3 Dec 2025 16:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764780201;
	bh=1XNQS0lbn9FevDFX+NqC8EFfjK6r037ERyxzwj6yRtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMJmOKBSwDtijIjhVAv3lZAEXFA8Yg75apJnBXD7HeB41Pcbx4cEfrGe5PC453Zwb
	 0KSjymC4CyxhG91V4UP+V+lgmtigbMB6EdZgdlpZ/KdfV/2cg6Gj5pFEN+HxAxhfxm
	 ekGvhYvlws2XvOGcvo3spTIC88zChQSeKvrDvJdDArfUveZU4ApFeEcnOwFuCIspv0
	 FiWrutG1OQHIwSSeJ7oCxlukKtE2D5JRw9uli5xeysT7leY1KC9Do3Ll3Q66hrMJbi
	 ZzCpg59GJ1gatpTK4jrU3K2cyIdj5YmogAU0MVLmc03HISbQEiNI8GVIbiuUpjU2gz
	 UF8KLZa5msswQ==
Date: Wed, 3 Dec 2025 13:43:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jon Kohler <jon@nutanix.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Tomas Glozar <tglozar@redhat.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] perf build: build BPF skeletons with fPIC
Message-ID: <aTBopdY6tmmxbDuu@x1>
References: <20251203035526.1237602-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203035526.1237602-1-jon@nutanix.com>

On Tue, Dec 02, 2025 at 08:55:26PM -0700, Jon Kohler wrote:
> Fix Makefile.perf to ensure that bpf skeletons are built with fPIC.
> 
> When building with BUILD_BPF_SKEL=1, bpf_skel's was not getting built
> with fPIC, seeing compilation failures like:
> 
> /usr/bin/ld: /builddir/.../tools/perf/util/bpf_skel/.tmp/bootstrap/main.o:
>   relocation R_X86_64_32 against `.rodata.str1.8' can not be used when
>   making a PIE object; recompile with -fPIE
> 
> Bisected down to 6.18 commit a39516805992 ("tools build: Don't assume
> libtracefs-devel is always available").
> 
> Fixes: a39516805992 ("tools build: Don't assume libtracefs-devel is always available")

How come, this patch is just:

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 9c1a69d26f5121fd..531f8fc4f7df9943 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -83,7 +83,6 @@ FEATURE_TESTS_BASIC :=                  \
         libpython                       \
         libslang                        \
         libtraceevent                   \
-        libtracefs                      \
         libcpupower                     \
         pthread-attr-setaffinity-np     \
         pthread-barrier                \
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index e1847db6f8e63750..2df593593b6ec15e 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -150,10 +150,6 @@
 # include "test-libtraceevent.c"
 #undef main

-#define main main_test_libtracefs
-# include "test-libtracefs.c"
-#undef main
-
 int main(int argc, char *argv[])
 {
        main_test_libpython();
@@ -187,7 +183,6 @@ int main(int argc, char *argv[])
        main_test_reallocarray();
        main_test_libzstd();
        main_test_libtraceevent();
-       main_test_libtracefs();

        return 0;
}


----

And your patch is touching building bpftool? Seems very unrelated :-\

- Arnaldo

> Cc: stable@vger.kernel.org
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 02f87c49801f..4557c2e89e88 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1211,7 +1211,7 @@ endif
>  
>  $(BPFTOOL): | $(SKEL_TMP_OUT)
>  	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool \
> -		OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
> +		EXTRA_CFLAGS="-fPIC" OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
>  
>  # Paths to search for a kernel to generate vmlinux.h from.
>  VMLINUX_BTF_ELF_PATHS ?= $(if $(O),$(O)/vmlinux)			\
> -- 
> 2.43.0

