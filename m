Return-Path: <bpf+bounces-11807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEC77BFC74
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 15:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3071C1C20E2C
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 13:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2D2374E6;
	Tue, 10 Oct 2023 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd4wiGMt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E628F5D;
	Tue, 10 Oct 2023 13:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753A3C433C7;
	Tue, 10 Oct 2023 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696942886;
	bh=ARY8nAiRbk6GqCoWYZNXSfZ8OEzDFquMKTGnWrDzFpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hd4wiGMtctAkbQliqvFRmP6uqb2oYAEc3y6wyxlA/vi+8IzcO7muhw9pSDd/RnRn5
	 f+wi3vR8fOVYTDbzmHphJZ7mDx7CQRfsZjrOOorzsCANiqfYkzU5E2jBXvX6Ua4uWF
	 VSmHlnaEIiMoKe4TqfP4f/2TN20q0s/CIbGAs2i05FzvBMaPQ0MX+GaUMMYbVtLoT9
	 5ZLMm7eW/JYkO3VYaohpuTCUezzF6h3+UP0zcAPufrm4FDxEuw3tWynmQPY6ipT2oq
	 M2UMkZ0WGO/vYr+LG3cxdRS3dW+VmWfxGTWskFJrPPcKEIlG6TZ7pI3N7IbrGDfMyS
	 +3TUvsvbrAfDQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id A633340508; Tue, 10 Oct 2023 10:01:23 -0300 (-03)
Date: Tue, 10 Oct 2023 10:01:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ian Rogers <irogers@google.com>, KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCHv2 0/2] tools/build: Fix -s detection code for new make
Message-ID: <ZSVLI7yXFHCXqVJp@kernel.org>
References: <20231008212251.236023-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008212251.236023-1-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com

Em Sun, Oct 08, 2023 at 11:22:49PM +0200, Jiri Olsa escreveu:
> hi,
> this fixes the detection of silent flag for newer make.
> 
> It'd be better to re-use the code, but I don't see simple
> way without more refactoring. I put that on my todo list.
> 
> v2 changes:
>   - adding the change for tools/scripts/Makefile.include as well

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> thanks,
> jirka
> 
> 
> ---
> Jiri Olsa (2):
>       tools/build: Fix -s detection code in tools/build/Makefile.build
>       tools/build: Fix -s detection code in tools/scripts/Makefile.include
> 
>  tools/build/Makefile.build     | 10 +++++++++-
>  tools/scripts/Makefile.include | 10 +++++++++-
>  2 files changed, 18 insertions(+), 2 deletions(-)

-- 

- Arnaldo

