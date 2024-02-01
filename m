Return-Path: <bpf+bounces-20934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313CD845551
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 11:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6423D1C2330F
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 10:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B1415B965;
	Thu,  1 Feb 2024 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="iU35tsOU"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229894DA07
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783312; cv=none; b=XlolTArL4l5+2ntb6ZzEVP0l1Rr0JSRC1/pKFPvlpLdGIgxbQGmOzuQrVtOB432W1ATG3iYu9jn7Kj0THOhvl5o87t/1TEagKAkhV7eGdVXIMZ4cC0L+4kbvycL3Smn6vknxd1I+lYNvw3QK+gxixcYWPPTUMdz2qMuSa9/YtgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783312; c=relaxed/simple;
	bh=CPsZWpYtshVT5bsF2X05TpcrZMco2TEuYe1u2FXVII0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ogYuWB/2LHBvzLrb/28Y9uGWpTZdsbtnNSuyrPDwqSNihpE5zpVRrlcxVXXjyAUZ28Yt46U+DbAP9pfhQccKLtSwbHOgPFz7GBkFEqEBiVOOxV0C8XG2uBRX2akq/06KEmsrLQNK1jtrxT022KZpAEf8uSAFF5JIFNpp9wo3ApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=iU35tsOU; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1rszAsIveG88iAr6ViwO3AjVRC/77TfF3NNSnILHchM=; b=iU35tsOUrI5JV+Yw78YzCBctr3
	KMe31X1iDX8H4toJeePMZ/ghXTdaZHwuHgH2KtZjCbji75lx3zqbsnb9gEbJ4ZeemBG03XSGeD404
	gwkkupGb9pbjfbuhPLTfEBaJ8B8MIwlqJfhT+29PrKLHJ0lRw/dHBgocnQokSm6IzqhxahfPjWkBT
	j4AZhXqguu0n6a82q4bWS7T6kbavlRERaKR2IzLdteh7xHl3bPtC0v7dJBXBDkafzn0Cb1TmJ54R+
	jdMonOFMfr2tS1mWntkmy7aaScLtYRuuVq7uAwaOtQv5DfXX1IN923IbYsJlfr3djgaoXvB8WaVxI
	+3RcOcGg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rVUIu-000OZb-Qu; Thu, 01 Feb 2024 11:28:20 +0100
Received: from [81.6.34.132] (helo=localhost.localdomain)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rVUIu-000FQd-DI; Thu, 01 Feb 2024 11:28:20 +0100
Subject: Re: [PATCH bpf-next] [libbpf] remove unnecessary null check in
 kernel_supports()
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
References: <20240131212615.20112-1-eddyz87@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <228bf647-8efb-ea35-0483-fa20cf1be412@iogearbox.net>
Date: Thu, 1 Feb 2024 11:28:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240131212615.20112-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27171/Wed Jan 31 10:46:17 2024)

On 1/31/24 10:26 PM, Eduard Zingerman wrote:
> After recent changes, Coverity complained about inconsistent null
> checks in kernel_supports() function:
> 
>      kernel_supports(const struct bpf_object *obj, ...)
>      ...
>      // var_compare_op: Comparing obj to null implies that obj might be null
>      if (obj && obj->gen_loader)
>          return true;
> 
>      // var_deref_op: Dereferencing null pointer obj
>      if (obj->token_fd)
>          return feat_supported(obj->feat_cache, feat_id);
>      ...
> 
> - The original null check was introduced by commit [0],
>    which introduced a call `kernel_supports(NULL, ...)`
>    in function bump_rlimit_memlock();
> - This call was refactored to use `feat_supported(NULL, ...)`
>    in commit [1].
> 
> Looking at all places where kernel_supports() is called:
> - there is either `obj->...` access before the call;
> - or `obj` comes from `prog->obj` expression, where `prog` comes from
>    enumeration of programs in `obj`;
> - or `obj` comes from `prog->obj`, where `prog` is a parameter to one
>    of the API functions:
>    - bpf_program__attach_kprobe_opts;
>    - bpf_program__attach_kprobe;
>    - bpf_program__attach_ksyscall.
> 
> Assuming correct API usage, it appears that `obj` can never be null
> when passed to kernel_supports(). Silence the Coverity warning by
> removing redundant null check.
> 
> [0] e542f2c4cd16 ("libbpf: Auto-bump RLIMIT_MEMLOCK if kernel needs it for BPF")
> [1] d6dd1d49367a ("libbpf: Further decouple feature checking logic from bpf_object")
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

lgtm, also on the latter the struct bpf_program is only defined in libbpf.c, and
you can only use libbpf.h APIs to retrieve a pointer of this type from the obj.

