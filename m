Return-Path: <bpf+bounces-44953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC499CE073
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 14:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9AD21F24415
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153BB1D0E18;
	Fri, 15 Nov 2024 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hkb/e8pF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0791D0942;
	Fri, 15 Nov 2024 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678181; cv=none; b=Qog8PO4rbtdAZPZaxNjSaaRfegNWc/yEdLRtlA5cFzCpOvo1M3q1dg5nu93ZJCkn5PnsMk8wRAtkoD+Xc90118vW3skdCBV2fBzvPJcr6MOH2kjm/pgH/kAduUeu64hr7lR2P/e3SuhQrQ2y2qwwtBZcj4VcL4qbLkRnPfcJuIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678181; c=relaxed/simple;
	bh=RsOLztyeR+AnrZ9rqjcFzU0QgY2pHmkYbxAjAcmrspA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSInpGoyvUDSOUJn70PO0emLCsW0jnlB/vGgf0izGLrlmKMu+r/2G+SgmyiK/f+zuf8A29pU9htIrmdgEmfA7BCfqOCmu6NkUPk5Z7sTDgMVjSgRK76vscaTewTVdnKd+NPjokMxo18OLiGZFydY12lfmwanR/cp5eluwK8kjJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hkb/e8pF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45410C4CECF;
	Fri, 15 Nov 2024 13:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731678181;
	bh=RsOLztyeR+AnrZ9rqjcFzU0QgY2pHmkYbxAjAcmrspA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hkb/e8pFh8yNP/LSd8ZnioEAR/cLJs3wGCA0yqd9ta5A3nvlwRaGmLy0zeSM37xmD
	 BSJubEfH6mR0v2FojjnH84k86mq13Em3/Bfd46KrhO7SDcUD8N/JQTF3ikDTLX0QQl
	 MeXFljK0clZ8lhTXp14b8sqVrqMoJhhf30YtfmlZI9N4H45p0sKeJRIqt2OIp4/IVT
	 e4YrYlVol9f3VkOy36T1IC2xx4mHGKINT/iqkdGJ0SF+CLGtLiZU1bUEJBGDDyVvb6
	 1Hp6H0d+UuZUUtARA7aPgiYvaUjCbGiPkksrNSyqFOs0piqlMhLtpSZK9jDeYukH6c
	 qjZJq3GBkejrA==
Message-ID: <47225498-12ab-4e69-ac50-2aab9dbe62c0@kernel.org>
Date: Fri, 15 Nov 2024 13:42:56 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: fix potential NULL pointer dereferencing in
 prog_dump()
To: Amir Mohammadi <amirmohammadi1999.am@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Amir Mohammadi <amiremohamadi@yahoo.com>
References: <20241115114507.1322910-1-amiremohamadi@yahoo.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20241115114507.1322910-1-amiremohamadi@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-11-15 15:15 UTC+0330 ~ Amir Mohammadi <amirmohammadi1999.am@gmail.com>
> A NULL pointer dereference could occur if ksyms
> is not properly checked before usage in the prog_dump() function.
> 
> Signed-off-by: Amir Mohammadi <amiremohamadi@yahoo.com>
> ---
>  tools/bpf/bpftool/prog.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 2ff949ea8..8b5300103 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -822,11 +822,12 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
>  					printf("%s:\n", sym_name);
>  				}
>  
> -				if (disasm_print_insn(img, lens[i], opcodes,
> -						      name, disasm_opt, btf,
> -						      prog_linfo, ksyms[i], i,
> -						      linum))
> -					goto exit_free;
> +				if (ksyms)
> +					if (disasm_print_insn(img, lens[i], opcodes,
> +							      name, disasm_opt, btf,
> +							      prog_linfo, ksyms[i], i,
> +							      linum))
> +						goto exit_free;
>  
>  				img += lens[i];
>  


Thanks! But we don't want to skip dumping the instruction silently if we
don't have ksyms. So we'd need an 'else' block that does the same as if
no JITed functions are found I think, something calling:

	disasm_print_insn(img, lens[i], opcodes, name, disasm_opt, btf,
			  NULL, 0, 0, false)

Fixes: b053b439b72a ("bpf: libbpf: bpftool: Print bpf_line_info during prog dump")

Quentin

