Return-Path: <bpf+bounces-35477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6082093ACF9
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 09:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B421C216E9
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 07:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746D35C8FA;
	Wed, 24 Jul 2024 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lG4K8EOM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA14E4C84;
	Wed, 24 Jul 2024 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721804927; cv=none; b=i1SIvGRCpDrVA47r7MBGS/YS/wVK/fqPTKJoiC/Mrn/YW3kLUAsUeUyWhZ+tCV56V1mM0FPLQf3VA9+GY0uBWjSDEc0O5IgW2Evnw+MEfXXpmXXmAX25dwShIEf4yLSHPhN4cC1JBGE1nZ4vP0LbF/Vt2pnBrTZuNRgPxS6KaRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721804927; c=relaxed/simple;
	bh=2PnDFY9MZ51zqP1efOCCIr96nPmcLKIya3dYshW8wh0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dXLCZBgeFwzCDmFh+vvhahBdbEfqJsfNetnqWorEBdMLqN/725nrv2zGL9S5Cb+U98ljexpUXWms4JevYuoSEpzzTmIl542bjxhTpNEGwBpSev2MSx6qBd/TTIbww54AyrKEskpmnCr9+9fNKC8sez4Vpq3fSpNUAiQPL5m2V4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lG4K8EOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AD4C32782;
	Wed, 24 Jul 2024 07:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721804926;
	bh=2PnDFY9MZ51zqP1efOCCIr96nPmcLKIya3dYshW8wh0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lG4K8EOMTucqHOuJ5UvSN4fyaT8mTJ9ZrsO7QlvqGSavJqMCGi5tVgmehyB8hBhUR
	 ui2IK3+juYNZcR8smdJYEzB/gOIlC2c/4vER29L9PLA8cjdZNKrCYmaMNLQpmiGosE
	 Syl3HIAstaKTvFzSKjICjTvu9Kk/9YL21CyX6HV3FWthnCjBBsbC+VFXpz4cXJAkef
	 aPoCMTCnbbn3yzhT9gveU2ZUhLNVfQbhDWEGO234jx8qgvZ/8r9uvRgJFOYt7c/Shf
	 MG1CIKW15sVnmNaJMlDWHY3VHq7oS7gc1PGFDi/z2K1JXDpKNs3NJeJ8Y2cgFbejRX
	 SuQqXXLfG4cVA==
Message-ID: <948240d0866b93ddc60fe084bca74253c99306ff.camel@kernel.org>
Subject: Re: [PATCH bpf-next v1 07/19] selftests/bpf: Fix missing
 ARRAY_SIZE() definition in bench.c
From: Geliang Tang <geliang@kernel.org>
To: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>, Yucong Sun <sunyucong@gmail.com>,  Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.co.jp>, Jakub
 Sitnicki <jakub@cloudflare.com>, Dave Marchevsky <davemarchevsky@fb.com>,
 David Vernet <void@manifault.com>, Carlos Neira <cneirabustos@gmail.com>,
 Joanne Koong <joannelkoong@gmail.com>, Petar Penkov <ppenkov@google.com>,
 Willem de Bruijn <willemb@google.com>, Yan Zhai <yan@cloudflare.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, YiFei Zhu <zhuyifei@google.com>
Date: Wed, 24 Jul 2024 15:08:31 +0800
In-Reply-To: <bc4dde77dfcd17a825d8f28f72f3292341966810.1721713597.git.tony.ambardar@gmail.com>
References: <cover.1721713597.git.tony.ambardar@gmail.com>
	 <bc4dde77dfcd17a825d8f28f72f3292341966810.1721713597.git.tony.ambardar@gmail.com>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-07-22 at 22:54 -0700, Tony Ambardar wrote:
> Add a "bpf_util.h" include to avoid the following error seen
> compiling for
> mips64el with musl libc:
> 
>   bench.c: In function 'find_benchmark':
>   bench.c:590:25: error: implicit declaration of function
> 'ARRAY_SIZE' [-Werror=implicit-function-declaration]
>     590 |         for (i = 0; i < ARRAY_SIZE(benchs); i++) {
>         |                         ^~~~~~~~~~
>   cc1: all warnings being treated as errors

I'm curious why this error doesn't occur on other platforms. ARRAY_SIZE
is actually defined in linux/kernel.h (tools/include/linux/kernel.h). I
think you should find out why this file is not included on your
platform.

> 
> Fixes: 8e7c2a023ac0 ("selftests/bpf: Add benchmark runner
> infrastructure")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/testing/selftests/bpf/bench.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/bench.c
> b/tools/testing/selftests/bpf/bench.c
> index 627b74ae041b..90dc3aca32bd 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -10,6 +10,7 @@
>  #include <sys/sysinfo.h>
>  #include <signal.h>
>  #include "bench.h"
> +#include "bpf_util.h"
>  #include "testing_helpers.h"
>  
>  struct env env = {


