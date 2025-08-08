Return-Path: <bpf+bounces-65270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DB7B1EC5E
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 17:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858503ADE0C
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 15:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6716F286413;
	Fri,  8 Aug 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAfjK+tL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4812285CBB
	for <bpf@vger.kernel.org>; Fri,  8 Aug 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668183; cv=none; b=cqHq+h6n6yLY5+a3edvqtInx6WcLzaw8Cqp5fdx0QCtG/UyV0Zjyl8GHsO00VhDLMaAYYLjqgxpB3pJLno0s3pkT/mPXD4WIMvaCqGup1Qm2nQoFA2nUeGT+KrIeaZfuLFRaSiZCYUOgQVulxVWGP3bLHDmK+cLsd1dS9oSJWnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668183; c=relaxed/simple;
	bh=MSb5SkgCd8iSMQd5UP+wi++y4niZdmYrKxpxpnm/U3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YWNQowfzUJTa5WA7zewypOqQaODccR+ztrx6KuY4LzvyKAmY0K/YqutZTBuecajPL6n5DYbwZPg/tEDwoDDssTf5IRKXm2PvpyAfudZG9mE7klgIJHIkcD0tPFkS+3FlI5R79umMyYeLKNhxVXDIFx86jDRzDau155WJv8k2Vv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAfjK+tL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AF4C4CEED;
	Fri,  8 Aug 2025 15:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754668183;
	bh=MSb5SkgCd8iSMQd5UP+wi++y4niZdmYrKxpxpnm/U3Q=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cAfjK+tLnKKvMcZ0xk23BUIo+iCfYZfmThZHQQTIvnrTz+Dy3kuoF2Lj35i45j0s/
	 af+paKeKBww3XBE5Sjq84bQLRlviF57fw6EfjhtBBRnGC2Rjwb1jcg138HXfpVzB9l
	 hqORSPGXgMFIlthDFiTqO+nUcw5nTKuSxQnhvKcWGF/DR61e8Pw6IbP6o1zcBZUVQT
	 zu7mDBje8GAIn5/MLTfb6hGuuQWDITyVML8mWkzHoYXPyaxgVeSiob8e5GYQk714/1
	 wQqR/6mBOzTUwdITCFy65Ln/ug5eD8B+n6ULnT2MbU+/OUclh32YfTqUO0980XQMNa
	 fEtdwKB7nHsbA==
Message-ID: <d9e524a6-6296-4a5a-941e-65cca7d72bcd@kernel.org>
Date: Fri, 8 Aug 2025 16:49:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: add kernel.kptr_restrict hint for no
 instructions
To: Vincent Li <vincent.mc.li@gmail.com>, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>
References: <20250808145133.404799-1-vincent.mc.li@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250808145133.404799-1-vincent.mc.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Please run ./scripts/get_maintainer.pl and Cc all maintainers for your
future submissions, in this case: all BPF maintainers/reviewers.

On 08/08/2025 15:51, Vincent Li wrote:
> from bpftool github repo issue [0], when Linux distribution
> kernel.kptr_restrict is set to 2, bpftool prog dump jited returns "no
> instructions returned", this message can be puzzling to bpftool users
> who is not familiar with kernel BPF internal, so add small hint for
> bpftool users to check kernel.kptr_restrict setting. Set
> kernel.kptr_restrict to expose kernel address to allow bpftool prog
> dump jited to dump the jited bpf program instructions.
> 
> [0]: https://github.com/libbpf/bpftool/issues/184
> 
> Signed-off-by: Vincent Li <vincent.mc.li@gmail.com.
> ---
>  tools/bpf/bpftool/prog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 9722d841abc0..7d2337511284 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -714,7 +714,7 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
>  
>  	if (mode == DUMP_JITED) {
>  		if (info->jited_prog_len == 0 || !info->jited_prog_insns) {
> -			p_info("no instructions returned");
> +			p_info("no instructions returned: set kernel.kptr_restrict to expose kernel addresses");
>  			return -1;
>  		}
>  		buf = u64_to_ptr(info->jited_prog_insns);


Thank you Vincent!

We have the same hint for the xlated dump some 7 lines further in the
file. As we discussed off-list, this hint was initially printed for both
cases, JITed and xlated dump, since commit 7105e828c087 ("bpf: allow for
correlation of maps and helpers in dump") from Daniel, back in 2017. It
was kept for the xlated dump only after commit cae73f233923 ("bpftool:
use bpf_program__get_prog_info_linear() in prog.c:do_dump()"), I believe
by accident.

From what I understand, the kptr restriction should not be relevant in
the case of xlated dump (it does change the information we can print -
it prevents us from retrieving __bpf_call_base from ksyms - but should
not prevent bpftool from retrieving instructions entirely). Daniel, it's
been a while, but do you remember why you printed it for xlated dumps
too? If not, we should probably just keep the hint for the JITed case.

Thanks,
Quentin

