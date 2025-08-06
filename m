Return-Path: <bpf+bounces-65163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8483B1CF69
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 01:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7377C3AE717
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 23:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0935277818;
	Wed,  6 Aug 2025 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ehnrsl9h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37B1FCF41;
	Wed,  6 Aug 2025 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754523234; cv=none; b=MMhOK/0+zqR1DOCIug+8e2uc4Zwrn/CE2mYZvuOcd/nbWjMuzmNKU6nXJAbNvej4P8acp9LB9XevucRijyayIAnWdtcB5aQQZ9HswnzQlKweR1WhfT1/I9HAA21+JleiC848CrWIXy1LQ5cHTVC0QeNDMkBDDqheUzU1rwYbc4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754523234; c=relaxed/simple;
	bh=LwOsg5Phvym95NqHXVw0T6HmV6LxD1ZVx665EdoVQ8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkZYGpbOa0tRWUQHFCJDPj6p0GhFhSwMQ6ebjfqr1/r6VU+BuIEFNVhYcT1CgcDOKihxFmpg3sws0dPwe7qdGTui9GU+lGJc2i1vj7P7bobRUIS1N4Xu4F8qJ8Bcx67pL7VitAQ0PlD5H1jJ1CvXScsxb7lSyJuhPTAJzFtp0rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ehnrsl9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FFEC4CEE7;
	Wed,  6 Aug 2025 23:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754523233;
	bh=LwOsg5Phvym95NqHXVw0T6HmV6LxD1ZVx665EdoVQ8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ehnrsl9htemG79QSVa2feSbQMp2F1BAMTaPhyd3JIGxJ3+ahsvfHL8JaaqPngzhfl
	 QGVicQlqvyHH3T0t05j662gEl0RGPg+8DOzteW7/TY1aVlOa8UKgEn5cqMFM0NAM0Q
	 YGoCEk2A0q5Ha0iHuoFAwFDjW9bxgnrklHo3plw0+UXFG46N0wPDwab5wDhHurFIzf
	 +cbILmaE8LLXL/phUseMZGODessCxSwGK9QrImp1o/q/tNVtREHyYXDjobaR9XaleO
	 z5FtYE9OPt03qOJ3mTlOIxGlXWhc0owd+m5ICwsG2HIuIqje6RP5+zb/9HXldDM0IF
	 5Yn1ejufUy+dQ==
Date: Wed, 6 Aug 2025 16:33:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Sam James <sam@gentoo.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Pinski <quic_apinski@quicinc.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] perf: use __builtin_preserve_field_info for GCC
 compatibility
Message-ID: <aJPmX8xc5x0W_r0y@google.com>
References: <fea380fb0934d039d19821bba88130e632bbfe8d.1754438581.git.sam@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fea380fb0934d039d19821bba88130e632bbfe8d.1754438581.git.sam@gentoo.org>

Hello,

On Wed, Aug 06, 2025 at 01:03:01AM +0100, Sam James wrote:
> When exploring building bpf_skel with GCC's BPF support, there was a
> buid failure because of bpf_core_field_exists vs the mem_hops bitfield:
> ```
>  In file included from util/bpf_skel/sample_filter.bpf.c:6:
> util/bpf_skel/sample_filter.bpf.c: In function 'perf_get_sample':
> tools/perf/libbpf/include/bpf/bpf_core_read.h:169:42: error: cannot take address of bit-field 'mem_hops'
>   169 | #define ___bpf_field_ref1(field)        (&(field))
>       |                                          ^
> tools/perf/libbpf/include/bpf/bpf_helpers.h:222:29: note: in expansion of macro '___bpf_field_ref1'
>   222 | #define ___bpf_concat(a, b) a ## b
>       |                             ^
> tools/perf/libbpf/include/bpf/bpf_helpers.h:225:29: note: in expansion of macro '___bpf_concat'
>   225 | #define ___bpf_apply(fn, n) ___bpf_concat(fn, n)
>       |                             ^~~~~~~~~~~~~
> tools/perf/libbpf/include/bpf/bpf_core_read.h:173:9: note: in expansion of macro '___bpf_apply'
>   173 |         ___bpf_apply(___bpf_field_ref, ___bpf_narg(args))(args)
>       |         ^~~~~~~~~~~~
> tools/perf/libbpf/include/bpf/bpf_core_read.h:188:39: note: in expansion of macro '___bpf_field_ref'
>   188 |         __builtin_preserve_field_info(___bpf_field_ref(field), BPF_FIELD_EXISTS)
>       |                                       ^~~~~~~~~~~~~~~~
> util/bpf_skel/sample_filter.bpf.c:167:29: note: in expansion of macro 'bpf_core_field_exists'
>   167 |                         if (bpf_core_field_exists(data->mem_hops))
>       |                             ^~~~~~~~~~~~~~~~~~~~~
> cc1: error: argument is not a field access
> ```
> 
> ___bpf_field_ref1 was adapted for GCC in 12bbcf8e840f40b82b02981e96e0a5fbb0703ea9
> but the trick added for compatibility in 3a8b8fc3174891c4c12f5766d82184a82d4b2e3e
> isn't compatible with that as an address is used as an argument.
> 
> Workaround this by calling __builtin_preserve_field_info directly as the
> bpf_core_field_exists macro does, but without the ___bpf_field_ref use.

IIUC GCC doesn't support bpf_core_fields_exists() for bitfield members,
right?  Is it gonna change in the future?

> 
> Link: https://gcc.gnu.org/PR121420
> Co-authored-by: Andrew Pinski <quic_apinski@quicinc.com>
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
>  tools/perf/util/bpf_skel/sample_filter.bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> index b195e6efeb8be..e5666d4c17228 100644
> --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> @@ -164,7 +164,7 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
>  		if (entry->part == 8) {
>  			union perf_mem_data_src___new *data = (void *)&kctx->data->data_src;
>  
> -			if (bpf_core_field_exists(data->mem_hops))
> +			if (__builtin_preserve_field_info(data->mem_hops, BPF_FIELD_EXISTS))

I believe those two are equivalent (maybe worth a comment?).  But it'd
be great if BPF/clang folks can review if it's ok.

Anyway, I can build it with clang.

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>  				return data->mem_hops;
>  
>  			return 0;
> -- 
> 2.50.1
> 

