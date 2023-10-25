Return-Path: <bpf+bounces-13262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 493377D7316
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 20:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796AE1C20E4B
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 18:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE69B30FBE;
	Wed, 25 Oct 2023 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmFhsto0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF82771A
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 18:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930AEC433C8;
	Wed, 25 Oct 2023 18:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698257920;
	bh=+ZEj1XuhMhJev6XOUs0XKi93f2UCPsmTIs8hiy/MUq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YmFhsto0a5XOvamACnfnGpb4NOgRZEe5+1cDLF5BneZZURjIbJx3X15SWht359zbJ
	 Nf5bO/9v8XrT4doppUdAVgG1QhduTIpIQZAQqC6k5O5DoAKR5aGRlAakapg4SmPYqc
	 d3k6RjLMRp5caxQSEGNlyRcDCP7rBvm+NWuDdJOr9b7H0xGQRxGdwZJ2mBtKcK/6Bs
	 AE5IK78QaPfKF27rg9hLNjjxRFXrAMkuCsfjimKcM4i8i4b4Vf3pbLZ+yfcQllW/3j
	 kn5CUKlVF1FMVikC+gBLvnjAwYeI7U/vicso7+tA9It88ZoBQcmr4XecFcLSX60JsZ
	 t3ckiyyKyqKfg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 494734035D; Wed, 25 Oct 2023 15:18:38 -0300 (-03)
Date: Wed, 25 Oct 2023 15:18:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii.nakryiko@gmail.com, jolsa@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH v4 dwarves 0/5] pahole, btf_encoder: support
 --btf_features
Message-ID: <ZTlb/inSUnEelTJT@kernel.org>
References: <20231023095726.1179529-1-alan.maguire@oracle.com>
 <ZTlTpYYVoYL0fls7@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTlTpYYVoYL0fls7@kernel.org>
X-Url: http://acmel.wordpress.com

Em Wed, Oct 25, 2023 at 02:43:02PM -0300, Arnaldo Carvalho de Melo escreveu:
> $ cp vmlinux.v5.19.0-rc5+ vmlinux.v5.19.0-rc5+.enum64 ; pahole --btf_encode --btf_features=enum64 vmlinux.v5.19.0-rc5+.enum64 
> $
 
> I tried using --btf_encode_detached=file but then couldn't find a way to
> make 'bpftool btf' to consume detached BTF, it seems that "file" means
> "ELF file containing BTF" so I copied the original file to then reencode
> BTF selecting just the enum64 feature, the resulting file continues to
> have the original DWARF and the BTF using that --btf_features set:

This was another symptom of me using a random old bpftool, using
upstream I get what is expected:

$ pahole --btf_encode_detached=vmlinux.v5.19.0-rc5+.enum64 --btf_features=enum64 vmlinux.v5.19.0-rc5+
$ bpftool btf dump file vmlinux.v5.19.0-rc5+.enum64 format raw | wc -l
290975
$ file vmlinux.v5.19.0-rc5+.enum64
vmlinux.v5.19.0-rc5+.enum64: data
$
[acme@quaco pahole]$ bpftool btf dump file vmlinux.v5.19.0-rc5+.enum64 format raw | grep -w ENUM64
[4266] ENUM64 'perf_event_sample_format' encoding=UNSIGNED size=8 vlen=27
[5089] ENUM64 '(anon)' encoding=UNSIGNED size=8 vlen=11
[6727] ENUM64 '(anon)' encoding=SIGNED size=8 vlen=28
[27943] ENUM64 '(anon)' encoding=UNSIGNED size=8 vlen=3
[31242] ENUM64 'netdev_priv_flags' encoding=UNSIGNED size=8 vlen=33
[31438] ENUM64 'perf_callchain_context' encoding=UNSIGNED size=8 vlen=7
[38853] ENUM64 'hmm_pfn_flags' encoding=UNSIGNED size=8 vlen=7
[56830] ENUM64 'ib_uverbs_device_cap_flags' encoding=UNSIGNED size=8 vlen=25
[60295] ENUM64 'blake2b_iv' encoding=UNSIGNED size=8 vlen=8
[63498] ENUM64 '(anon)' encoding=UNSIGNED size=8 vlen=31
[93914] ENUM64 '(anon)' encoding=SIGNED size=8 vlen=172
[acme@quaco pahole]$

So sorry for the noise about this.

- Arnaldo

