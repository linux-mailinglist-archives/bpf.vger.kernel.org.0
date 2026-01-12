Return-Path: <bpf+bounces-78531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 399B9D11CE5
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 11:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F8C4300FA0B
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 10:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3512C08A1;
	Mon, 12 Jan 2026 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnaaWckE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D52C15BB;
	Mon, 12 Jan 2026 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768213242; cv=none; b=B5FPu+JmqvfyzEp+8/8BWH2Gu6DQ4gMDabOSvRq8UOx5cvZlzSZWnmNTsZBDxw3Ynp/GmIYhsuQuUzXxljj6Nz4FenmEiOobTdLAoie1+/ApxzJatwOg2osJCvllRBq+pFKPyyr2/zcOFlbZknvLqta1nxU71WpqCxlk4KFSgLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768213242; c=relaxed/simple;
	bh=FaOJcdpVrP3MP6G+wHnsrsw9ryjMdTfLRbVVWn3wjrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqqxGjBxqSjQVziROtdjREfp429P3uYsuQZH5JyE+llkK3cCD4fyzz1N31RSGRLy51mzpl6Xe4Lyv+j/VpNuu+sodAY5UusQssoUg1y0adp2/Z+tVUwyaZ9GMir3/9rfRLTFzifJb+STIWX/aCqmiO9Htvaa4PAL1ZXR12IH8SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnaaWckE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CFAC4AF0B;
	Mon, 12 Jan 2026 10:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768213242;
	bh=FaOJcdpVrP3MP6G+wHnsrsw9ryjMdTfLRbVVWn3wjrw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KnaaWckEUPVbh4bx1pGmLyX64u/Wh/HaUTdPtMJ5QNOaTe51RCFwwr6qBN/Be2XNB
	 uFF9+LZPksMmOACOJsoa/nduyx59PIj9tWvFwJ6POk3tdLEV+3BvApMFhFLDX/+/Vn
	 n2Nk2a5AJZXsA/eJ+8RQI5t03gKW8ONh2e7kqg7w5/LJk9zg6cOjKyRpq8qpDoG7Ov
	 cV4SJSCPNlVaNhJTbqleeShCZ5w95Eo+3TvZpAbasrtRetc0rUvGA0Q+Als7jZTusT
	 UjPzWdu7wuSRfA+c0mGSoYNHm1bsWA5RcFPr2ICh29LBjzblQgz0CyC4ap/TWPsfZo
	 QsW+P8PaySNLw==
Message-ID: <b0a95722-23ed-4f1a-aeac-ded6983693b0@kernel.org>
Date: Mon, 12 Jan 2026 10:20:37 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] bpftool: Add 'prepend' option for tcx attach to insert
 at chain start
To: gyutae.opensource@navercorp.com, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Gyutae Bae <gyutae.bae@navercorp.com>,
 Siwan Kim <siwan.kim@navercorp.com>, Daniel Xu <dxu@dxuuu.xyz>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, Tao Chen <chen.dylane@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <43c23468-530b-45f3-af22-f03484e5148c@kernel.org>
 <20260112034516.22723-1-gyutae.opensource@navercorp.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260112034516.22723-1-gyutae.opensource@navercorp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-01-12 12:45 UTC+0900 ~ gyutae.opensource@navercorp.com
> From: Gyutae Bae <gyutae.bae@navercorp.com>
> 
> Add support for the 'prepend' option when attaching tcx_ingress and
> tcx_egress programs. This option allows inserting a BPF program at
> the beginning of the TCX chain instead of appending it at the end.
> 
> The implementation uses BPF_F_BEFORE flag which automatically inserts
> the program at the beginning of the chain when no relative reference
> is specified.
> 
> This change includes:
> - Modify do_attach_tcx() to support prepend insertion using BPF_F_BEFORE
> - Update documentation to describe the new 'prepend' option
> - Add bash completion support for the 'prepend' option on tcx attach types
> - Add example usage in the documentation
> - Add validation to reject 'overwrite' for non-XDP attach types
> 
> The 'prepend' option is only valid for tcx_ingress and tcx_egress attach
> types. For XDP attach types, the existing 'overwrite' option remains
> available.
> 
> Example usage:
>   # bpftool net attach tcx_ingress name tc_prog dev lo prepend
> 
> This feature is useful when the order of program execution in the TCX
> chain matters and users need to ensure certain programs run first.
> 
> Co-developed-by: Siwan Kim <siwan.kim@navercorp.com>
> Signed-off-by: Siwan Kim <siwan.kim@navercorp.com>
> Signed-off-by: Gyutae Bae <gyutae.bae@navercorp.com>
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> ---
> Hi Quentin.
> 
> Thank you for the review! I have added the validation for 'overwrite'
> option as you suggested.
> 
> I used a whitelist approach (rejecting non-XDP types) rather than
> a blacklist approach (rejecting TCX types) to be consistent with the
> 'prepend' validation style and to ensure that any future attach types
> will also be rejected by default unless explicitly allowed.


Looks good, thank you!
Quentin

