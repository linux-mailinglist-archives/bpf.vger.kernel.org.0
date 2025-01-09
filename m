Return-Path: <bpf+bounces-48428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C04AAA07FAC
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 19:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C7C3A6A8D
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 18:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEC619ABCE;
	Thu,  9 Jan 2025 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGgb6tqT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E96198A37;
	Thu,  9 Jan 2025 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736446791; cv=none; b=EQ8JvRRKDASnWJadnmQ9IdsShbH5knL8mylx3QOnN3wM/7ZTa4dDwOgVMfWXssw7QrThSPjVEZKz0E+ceT8fKwBw/tQxAAK2w+mj8BrzrgFQmlBZ7XNpWOnxCwxfLdB03fUvgwAok60FPM+LJrGzVQ+PTHtp0W4wBsU1ZoFb33w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736446791; c=relaxed/simple;
	bh=eUQtthi/frZRwtQiNbjXDw/V2n/1FsUsGp8PYmgKIXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaUINML6R31iM/QTDgRNDsH8fXop6e/+2HjTvm90nRLQzO3y+tHPFIagAW47Lmoq1HOjhYQ/KdQiqnHD6fp+xiCxwP+6waktnETEClPeDAfJHte7id6kgyTYHRKpJ5cTNF2g9cihWIIogFbAqsV3iF2HHKukCrbcpyipUc9rQgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGgb6tqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F5CC4CED2;
	Thu,  9 Jan 2025 18:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736446791;
	bh=eUQtthi/frZRwtQiNbjXDw/V2n/1FsUsGp8PYmgKIXE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tGgb6tqTL+WyDjcp+oSo6bhJAGaOi4tddHE0APJsri+xX+qy824A4Q7C/AvD+GqCV
	 +jNJhh0R0a0iQNLzAiE2WEnX3qHLa+r8XdKCBg66guYHLsMDXX5ImgFIldIEeImc/E
	 2Svb9//hwtFZiCv4wa/ABzw/Fqdda+KqsowFZrPhPu9IcjjC9g4arsjrgrvbK2XFpp
	 RdQ/yKFmwE+85J1JQkC5QDI3ZNAkufsFo3/BPHNnFtNXMggTS4gB6oF5/RnWR3eEeN
	 G3ZaNnN7hqk3WMYCOXolsAGGZguZT9mMjpPs+dVto2vFPZEx6k+VWct+w9DQsaxk7c
	 p9mJA/06ouM7g==
Message-ID: <55b9484a-c7db-402b-94f8-fe0544a9739f@kernel.org>
Date: Thu, 9 Jan 2025 18:19:46 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: fix control flow graph segfault during edge
 creation
To: Christoph Werle <christoph.werle@longjmp.de>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250108220937.1470029-1-christoph.werle@longjmp.de>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250108220937.1470029-1-christoph.werle@longjmp.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/01/2025 22:09, Christoph Werle wrote:
> If the last instruction of a control flow graph building block is a
> BPF_CALL, an incorrect edge with e->dst set to NULL is created and
> results in a segfault during graph output.
> 
> Ensure that BPF_CALL as last instruction of a building block is handled
> correctly and only generates a single edge unlike actual BPF_JUMP*
> instructions.
> 
> Signed-off-by: Christoph Werle <christoph.werle@longjmp.de>


Fixes: 0824611f9b38 ("tools: bpftool: partition basic-block for each function in the CFG")


> ---
>  tools/bpf/bpftool/cfg.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
> index eec437cca2ea..e3785f9a697d 100644
> --- a/tools/bpf/bpftool/cfg.c
> +++ b/tools/bpf/bpftool/cfg.c
> @@ -302,6 +302,7 @@ static bool func_add_bb_edges(struct func_node *func)
>  
>  		insn = bb->tail;
>  		if (!is_jmp_insn(insn->code) ||
> +		    BPF_OP(insn->code) == BPF_CALL ||
>  		    BPF_OP(insn->code) == BPF_EXIT) {
>  			e->dst = bb_next(bb);
>  			e->flags |= EDGE_FLAG_FALLTHROUGH;


Thanks for this! It looks OK, would you have a minimal reproducer by any
chance?

Quentin

