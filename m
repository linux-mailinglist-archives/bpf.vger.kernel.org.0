Return-Path: <bpf+bounces-78402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E9BD0C559
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A0E13037518
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81D433D6C4;
	Fri,  9 Jan 2026 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnQES+yn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7496C31B133;
	Fri,  9 Jan 2026 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994458; cv=none; b=GeqSWS3P5+EmwQjHF7T3uzb9wCzCUob1Dr80HehnSEuLxDxVxuN6YS1oLNpW/lcK6XbneqZM+WS+BDmz5YqvRI8ESfKV75AAV42uaV8SmR2XcHw36zLx+0MNFjsAfgsCEF0XArsFK2/xonkL7W/4Bo+iZBQj/wrUxY1Lo+WBZSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994458; c=relaxed/simple;
	bh=O1z7mjpOke5bocjNdQ/DFQ2hI1k1t1Kx9JNBeNNHJ7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/30fgmjwiDjGhq4dVjSHwexWAAmqVq9Wwml8Rmc8PuqKHjbAYxWBYdinonGQztoG5se/Zs8tJpaHCwGIkS/pwyAsPOL58MG8akuvknJlsGhPm2fCQbJPwjLJF5H70u66eK2d+17aEGODyXmmSHsjKzX68jafZMxHBPknHPXyxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnQES+yn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63242C4CEF1;
	Fri,  9 Jan 2026 21:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767994458;
	bh=O1z7mjpOke5bocjNdQ/DFQ2hI1k1t1Kx9JNBeNNHJ7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GnQES+ynIcoNO+2c0ex19j3XxEa7jMX3EeNFpMGM+9wPA8rHoBYZkT6+aA2A9nppW
	 JVZp08hnesLU8y4d7iJZmWtrlgRnj+P7yOn7yWHhsyYQSCEDJ9gvFurxM49g/x52qk
	 IRxJpvrQ9HRwbVIeg7l537i+inLmSM28NrI1/Rk8YFaApkJhgpH11VfxRZDaoGB8GP
	 n0yN1sczxEIDiUsr8kKQccBrTLrFN9F7nB6yBKoKrlrMQA9pwGP8NRJXMnrXkBz7Vy
	 VLLG4GBoIlLwf2pA9TENTe+Jr6SZKNMTDTwxNwMVHQ8vD5D5NJ+RkQyGzaUiWemspC
	 e7GeuNK50snkg==
Date: Fri, 9 Jan 2026 22:34:12 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Jiri Kosina <jikos@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH bpf-next v1 07/10] HID: Use bpf_wq_set_callback kernel
 function
Message-ID: <orvnpqolvwpbalpwcqp2izn5r2otkyikzk7jqbu6mynbizsm2b@iodguv7xvd3x>
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-8-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109184852.1089786-8-ihor.solodrai@linux.dev>

On Jan 09 2026, Ihor Solodrai wrote:
> Remove extern declaration of bpf_wq_set_callback_impl() from
> hid_bpf_helpers.h and replace bpf_wq_set_callback macro with a
> corresponding new declaration.
> 
> Fix selftests/hid build failure caused by missing BPF_CFLAGS.

Already fixed in e03fb369b083 ("selftests/hid: fix bpf compilations due to -fms-extensions")

> 
> Tested with:
>   # append tools/testing/selftests/hid/config and build the kernel
>   $ make -C tools/testing/selftests/hid
>   # in built kernel
>   $ ./tools/testing/selftests/hid/hid_bpf -t test_multiply_events_wq
> 
>   TAP version 13
>   1..1
>   # Starting 1 tests from 1 test cases.
>   #  RUN           hid_bpf.test_multiply_events_wq ...
>   [    2.575520] hid-generic 0003:0001:0A36.0001: hidraw0: USB HID v0.00 Device [test-uhid-device-138] on 138
>   #            OK  hid_bpf.test_multiply_events_wq
>   ok 1 hid_bpf.test_multiply_events_wq
>   # PASSED: 1 / 1 tests passed.
>   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>   PASS
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  drivers/hid/bpf/progs/hid_bpf_helpers.h             | 8 +++-----
>  tools/testing/selftests/hid/Makefile                | 4 +++-
>  tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 8 +++-----
>  3 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hid/bpf/progs/hid_bpf_helpers.h b/drivers/hid/bpf/progs/hid_bpf_helpers.h
> index bf19785a6b06..228f8d787567 100644
> --- a/drivers/hid/bpf/progs/hid_bpf_helpers.h
> +++ b/drivers/hid/bpf/progs/hid_bpf_helpers.h
> @@ -33,11 +33,9 @@ extern int hid_bpf_try_input_report(struct hid_bpf_ctx *ctx,
>  /* bpf_wq implementation */
>  extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
>  extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
> -extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> -		int (callback_fn)(void *map, int *key, void *value),
> -		unsigned int flags__k, void *aux__ign) __ksym;
> -#define bpf_wq_set_callback(wq, cb, flags) \
> -	bpf_wq_set_callback_impl(wq, cb, flags, NULL)
> +extern int bpf_wq_set_callback(struct bpf_wq *wq,
> +		int (*callback_fn)(void *, int *, void *),
> +		unsigned int flags) __weak __ksym;

FWIW, if I'm the only one using bpf_wq_set_callback_impl() that you are
aware of, I'm fine removing the _impl kfunc from the kernel, I can deal
with this when loading the programs.

>  
>  #define HID_MAX_DESCRIPTOR_SIZE	4096
>  #define HID_IGNORE_EVENT	-1
> diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
> index 2839d2612ce3..4c01bb649913 100644
> --- a/tools/testing/selftests/hid/Makefile
> +++ b/tools/testing/selftests/hid/Makefile
> @@ -184,7 +184,9 @@ MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
>  
>  CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
>  BPF_CFLAGS = -g -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 		\
> -	     -I$(INCLUDE_DIR)
> +	     -I$(INCLUDE_DIR)						\
> +	     -Wno-microsoft-anon-tag					\
> +	     -fms-extensions

Already in Linus' tree.

>  
>  CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
>  	       -Wno-compare-distinct-pointer-types
> diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> index 531228b849da..80ab60905865 100644
> --- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> +++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> @@ -116,10 +116,8 @@ extern int hid_bpf_try_input_report(struct hid_bpf_ctx *ctx,
>  /* bpf_wq implementation */
>  extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
>  extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
> -extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> -		int (callback_fn)(void *map, int *key, void *wq),
> -		unsigned int flags__k, void *aux__ign) __weak __ksym;
> -#define bpf_wq_set_callback(timer, cb, flags) \
> -	bpf_wq_set_callback_impl(timer, cb, flags, NULL)
> +extern int bpf_wq_set_callback(struct bpf_wq *wq,
> +		int (*callback_fn)(void *, int *, void *),
> +		unsigned int flags) __weak __ksym;
>  
>  #endif /* __HID_BPF_HELPERS_H */
> -- 
> 2.52.0
> 

Acked-by: Benjamin Tissoires <bentiss@kernel.org>

Cheers,
Benjamin

